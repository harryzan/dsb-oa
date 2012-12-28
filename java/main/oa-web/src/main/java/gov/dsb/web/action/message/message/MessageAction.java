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
import java.util.ArrayList;
import java.util.Collection;
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

    private String viewuserids;

    public String getViewuserids() {
        return viewuserids;
    }

    public void setViewuserids(String viewuserids) {
        this.viewuserids = viewuserids;
    }

    private String viewusernames;

    public String getViewusernames() {
        return viewusernames;
    }

    public void setViewusernames(String viewusernames) {
        this.viewusernames = viewusernames;
    }

    public String save() throws Exception {
        SysUser user = userSessionService.getCurrentSysUser();
        entity.setSender(user);

        long current = System.currentTimeMillis();
        entity.setStarttime(new Timestamp(current));

        if (StringHelp.isNotEmpty(viewuserids)) {
            viewuserids = viewuserids.trim();
            String[] userids = viewuserids.split(",");
            for (String id : userids) {
                SysUser sysUser = sysUserEntityService.get(Long.parseLong(id));

                if (sysUser != null) {
                    Message message = new Message();
                    message.setName(entity.getName());
                    message.setDescription(entity.getDescription());
                    message.setStarttime(entity.getStarttime());
                    message.setSender(user);
                    message.setReceiver(sysUser);
                    message.setStatus(false);

                    service.save(message);
                }
            }
        }

//        service.save(entity);
        return RELOAD;
    }

    public String read() {
        entity.setStatus(true);

        service.save(entity);
//        return RELOAD;
        return VIEW;
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

                entity.setType("个人短信");
                entity.setSystem(false);

//                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//                Date now = new Date(System.currentTimeMillis());
//                entity.setStarttime(sdf.format(now));
            }
        }

    }

    public String view() throws Exception {
//        read();
        return VIEW;
    }

    public String act() throws Exception {
        prepareModel();
        read();
        return "act";
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
