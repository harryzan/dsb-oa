package gov.dsb.web.action.message.message;

import gov.dsb.core.dao.MessageDao;
import gov.dsb.core.dao.SysUserDao;
import gov.dsb.core.domain.Message;
import gov.dsb.core.domain.SysUser;
import gov.dsb.core.struts2.CRUDActionSupport;
import gov.dsb.core.struts2.SimpleActionSupport;
import gov.dsb.core.utils.StringHelp;
import gov.dsb.web.security.UserSessionService;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import java.sql.Timestamp;
import java.util.HashMap;

/**
 * Created by IntelliJ IDEA.
 * User: cxs
 * Date: 2010-4-1
 * Time: 14:11:53
 * To change this template use File | Settings | File Templates.
 */

@ParentPackage("default")
@Results({@Result(name = CRUDActionSupport.RELOAD, location = "message-grid", type = "chain"),
        @Result(name = SimpleActionSupport.SUCCESS, location = "/WEB-INF/pages/common/ajaxutilData.jsp")})
public class MessageAction extends CRUDActionSupport<Message> {

    @Autowired
    private MessageDao service;

    @Autowired
    private SysUserDao sysUserEntityService;

    @Autowired
    private UserSessionService userSessionService;

    protected Long id;

    private String viewuserids;

    private HashMap map;

    private String result;

    private String path;

    private Boolean messagestatus;

    private String gridParam;

    public void setPath(String path) {
        this.path = path;
    }

    public String getResult() {
        return result;
    }

    public HashMap getMap() {
        return map;
    }

    public void setViewuserids(String viewuserids) {
        this.viewuserids = viewuserids;
    }

    public Boolean getMessagestatus() {
        return messagestatus;
    }

    public void setMessagestatus(Boolean bulletinstatus) {
        this.messagestatus = bulletinstatus;
    }

    public String getGridParam() {
        return gridParam;
    }

    public void setGridParam(String gridParam) {
        this.gridParam = gridParam;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    private String tuserid;

    public String getTuserid() {
        return tuserid;
    }

    public void setTuserid(String tuserid) {
        this.tuserid = tuserid;
    }

    public String save() throws Exception {
        SysUser user = userSessionService.getCurrentSysUser();
        entity.setSender(user);

        long current = System.currentTimeMillis();
        entity.setStarttime(new Timestamp(current));
//        entity.setStarttime(new Timestamp(System.currentTimeMillis()));
//        if (entity.getSysuserbulletins() != null) {
//            entity.getSysuserbulletins().clear();
//        } else {
//            entity.setSysuserbulletins(new ArrayList<SysUser>());
//        }

        if (StringHelp.isNotEmpty(tuserid)) {
            SysUser targetuser = sysUserEntityService.get(Long.parseLong(tuserid));
            entity.setReceiver(targetuser);
        }

        service.save(entity);
        return RELOAD;
    }

    public void read() {
        entity.setStatus(true);

        service.save(entity);
//        return RELOAD;
    }

    public String delete() throws Exception {
        service.delete(id);
        return RELOAD;
    }

    protected void prepareModel() throws Exception {
        if (entity == null) {
            if (id != null) {
                entity = service.get(id);
            } else {
                entity = new Message();

//                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//                Date now = new Date(System.currentTimeMillis());
//                entity.setStarttime(sdf.format(now));
            }
        }

    }

    public String view() throws Exception {
        read();
        return VIEW;
    }


    public String mainMsg() throws Exception {
        result = "";
        try {
            SysUser user = userSessionService.getCurrentSysUser();
            user = sysUserEntityService.get(user.getId());

            result += "<a style=\"cursor:pointer;\" onclick='goModule(\"结构预警结果\",\"f04\")'>更多结构预警信息>></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";

        } catch (Exception ignore) {
            ignore.printStackTrace();
        }
        return SUCCESS;
    }

    public Message getModel() {
        return entity;
    }

    public String changeStatus() throws Exception {
        if (id != null) {
            entity.setStatus(true);
            service.save(entity);
            System.out.println("enter change status!");
        }

        return null;
    }
}
