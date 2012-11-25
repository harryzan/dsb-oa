package gov.dsb.web.action.common.util;

import gov.dsb.core.dao.MessageDao;
import gov.dsb.core.dao.SysLogDao;
import gov.dsb.core.dao.SysPrivilegeDao;
import gov.dsb.core.dao.SysUserDao;
import gov.dsb.core.domain.*;
import gov.dsb.core.struts2.SimpleActionSupport;
import gov.dsb.core.utils.CryptUtil;
import gov.dsb.core.utils.StringHelp;
import gov.dsb.web.security.UserSession;
import gov.dsb.web.security.UserSessionService;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.Timestamp;
import java.util.Collection;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: xiejiao
 * Date: 2009-11-17
 * Time: 16:19:26
 */
@ParentPackage("default")
@Results({@Result(name = SimpleActionSupport.SUCCESS, location = "/WEB-INF/pages/common/ajaxutilData.jsp")})
public class AjaxUtilAction extends SimpleActionSupport {

    @Autowired
    private SysUserDao sysUserEntityService;

    @Autowired
    private UserSessionService userSessionService;

    @Autowired
    private SysLogDao sysLogEntityService;

    @Autowired
    private SysPrivilegeDao sysPrivilegeEntityService;


    private String result;

    private Long entityId;

    public String getResult() {
        return result;
    }

    public Long getEntityId() {
        return entityId;
    }

    public void setEntityId(Long entityId) {
        this.entityId = entityId;
    }

    //===============common attribute setting up=================//


    public String execute() throws Exception {

        return SUCCESS;
    }

    //==========unique user loginname===========//
    private String loginname;

    public void setLoginname(String loginname) {
        this.loginname = loginname;
    }

    /**
     * 用来验证登录用户名是否已被注册，结合entityId来进行验证
     * author :  xj
     *
     * @return SUCCESS
     */
    public String uniqueloginname() {
        // 根据用户名来查询系统用户，若找不到结果则用户名可用，
        // 若找到结果，但其id不是当前用户（entityId）,则用户名不可用，
        // 若是当前用户，则用户名也是表示为可用

        Collection<SysUser> users = sysUserEntityService.findByProperty("loginname", loginname);
        System.out.println("************************* users.size() = " + users.size());
        if (users != null && users.size() == 1) {
            SysUser user = users.iterator().next();
            if (user.getId().equals(entityId)) {
                result = "true";
            } else if (user.getStatus() == null || !user.getStatus()) {
                result = "true|<id>" + user.getId() + "</id><status>" + user.getStatus() + "</status><displayname>" +
                        user.getDisplayname() + "</displayname><roleids>";
                Collection<SysRole> roles = user.getSysroleusers();
                for (SysRole role : roles) {
                    result += role.getId() + ",";
                }
                if (result.endsWith(",")) {
                    result = result.substring(0, result.length() - 1);
                }
                result += "</roleids>";
            } else {
                result = "false";
            }
        } else {
            result = "true";
        }

        return SUCCESS;
    }


    //===================right user old password==================//

    public String userpwd;

    public void setUserpwd(String userpwd) {
        this.userpwd = userpwd;
    }

    /**
     * 验证当前登录用户的原密码是否正确
     *
     * @return result
     * @throws Exception 。
     */
    public String checkuserpwd() throws Exception {
        SysUser entity = userSessionService.getCurrentSysUser();
        if (entity != null) {
            boolean flag = CryptUtil.cl_decrypt(entity.getPassword()).equals(userpwd);
            result = flag + "";
        } else {
            result = "false";
        }

        return SUCCESS;
    }


    //============================logger==========================//
    private String content;

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    /**
     * 撰写日志
     *
     * @return 。
     * @throws Exception 。
     */
    public String logger() throws Exception {

        SysUser user = userSessionService.getCurrentSysUser();

        SysLog sysLog = new SysLog();
        sysLog.setSysuser(user);
        sysLog.setLogtime(new Timestamp(System.currentTimeMillis()));

        if (entityId != null) {
            SysPrivilege sysPrivilege = sysPrivilegeEntityService.get(entityId);
            sysLog.setSysprivilege(sysPrivilege);
            sysLog.setContent(sysPrivilege.getName());

            //////////////////
            UserSession userSession = (UserSession) ServletActionContext.getRequest().getSession().getAttribute(
                    UserSession.SESSION_USERSESSION);
            userSession.setLastVisitDate(new Timestamp(System.currentTimeMillis()));
            userSession.set("LastActName", sysPrivilege.getName());

        }

        HttpServletRequest request = ServletActionContext.getRequest();
        sysLog.setIpaddress(request.getRemoteAddr());

        sysLogEntityService.save(sysLog);

        return SUCCESS;
    }


    //=================has privilege=================//

    private String privilegecode;

    public void setPrivilegecode(String privilegecode) {
        this.privilegecode = privilegecode;
    }

    /**
     * 判断当前登录用户是否拥有对应权限代码的操作权限 没有返回false 有返回权限描述
     *
     * @return privilege definition
     * @throws Exception .
     */
    public String hasprivilege() throws Exception {
        result = "false";

        if (privilegecode != null) {
            SysUser user = userSessionService.getCurrentSysUser();
            SysPrivilege privilege = sysPrivilegeEntityService.findUniqueByProperty("code", privilegecode);
            if (privilege != null) {
                sysUserEntityService.containPrivilege(user.getId(), privilege.getId());
                Collection<SysPrivilege> privileges = sysUserEntityService.getUsePrivileges(user.getId());
                if (privileges.contains(privilege)) {
                    result = privilege.getDefinition() + "," + privilege.getId();
                }
            }
        }


        return SUCCESS;
    }

    public String hasPrivileges() throws Exception {
        System.out.println("********** privilegecode = " + privilegecode);
        result = "{'Results':{";
        // privilege code : is forbid
        if (privilegecode != null) {
            String[] pCodes = privilegecode.split(",");
            SysUser user = userSessionService.getCurrentSysUser();
            Collection<SysPrivilege> privileges = sysUserEntityService.getUsePrivileges(user.getId());

            for (String code : pCodes) {
                System.out.println("*********** code = " + code);

                SysPrivilege privilege = sysPrivilegeEntityService.findUniqueByProperty("code", code);
                if (privilege != null) {
                    String temp = "'" + code + "':true,";
                    for (SysPrivilege p : privileges) {
                        if (p.getCode().equals(code)) {
                            temp = "'" + code + "':false,";
                            break;
                        }
                    }
                    result += temp;
                } else {
                    // default is not forbid, if not define the privilege, system will allow to access
                    result += "'" + code + "':false,";
                }
            }
        }
        if (result.endsWith(",")) {
            result = result.substring(0, result.length() - 1);
        }
        result += "}}";
        return SUCCESS;
    }

    private String username;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    private String password;

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Autowired
    private MessageDao messageDao;

    public void messagecount() throws IOException {
        String outputString = "0";
        HttpServletRequest request = ServletActionContext.getRequest();
        HttpServletResponse response = ServletActionContext.getResponse();
        OutputStream os = response.getOutputStream();

        if (StringHelp.isNotEmpty(username)) {
            SysUser sysUser = userSessionService.getUserByLoginname(username);

            List<Message> query = messageDao.findByQuery("from Message where receiver.id=? and (status is null or status is false)", sysUser.getId());
            outputString = "" + query.size();

        }

        os.write(outputString.getBytes());
    }


    private Timestamp startTime;

    private Timestamp endTime;

    public void setStartTime(Timestamp startTime) {
        this.startTime = startTime;
    }

    public void setEndTime(Timestamp endTime) {
        this.endTime = endTime;
    }

    public String getDurantDay() throws Exception {
        if (startTime != null && endTime != null) {
            long durant = endTime.getTime() - startTime.getTime();
            long days = durant / (24 * 3600000);
            if (durant % (24 * 3600000) > 0) {
                days += 1;
            }
            result = days + "";
        }
        return SUCCESS;
    }

    public static void main(String[] args) {
        String result = "{\"Wind\":{\"speed\":\"12\",\"scale\":\"四\",\"wizard\":\"SE\"}}";
        System.out.println(result);

        result = "[0]sssss";
        String s = result.substring(result.indexOf("[") + 1, result.indexOf("]"));
        System.out.println("s = " + s);

        System.out.println("result = " + result.substring(result.indexOf("]") + 1));
    }


}
