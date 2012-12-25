package gov.dsb.web.action.oa.demand;

import gov.dsb.core.dao.*;
import gov.dsb.core.domain.*;
import gov.dsb.core.struts2.CRUDActionSupport;
import gov.dsb.web.message.MessageListener;
import gov.dsb.web.security.UserSession;
import gov.dsb.web.security.UserSessionService;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 2009-5-15
 * Time: 10:57:24
 * To change this template use File | Settings | File Templates.
 */

@ParentPackage("default")
@Results({@Result(name = CRUDActionSupport.RELOAD, location = "demand-complete-grid", type = "redirect")})
public class DemandUseAction extends CRUDActionSupport<Demand>{

    @Autowired
    private DemandDao service;

    @Autowired
    private MessageListener messageListener;

    @Autowired
    private SysRoleDao sysRoleDao;

    @Autowired
    private SysUserDao sysUserDao;

    @Autowired
    private DemandTypeDao demandTypeDao;

    @Autowired
    private UserSessionService userSessionService;

    private String gridParam;

    public void setGridParam(String gridParam) {
        this.gridParam = gridParam;
    }

    protected Long id;

    public void setId(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    private DemandType type;

    public DemandType getType() {
        return type;
    }

    public void setType(DemandType type) {
        this.type = type;
    }

    public Long moderatorid;

    public Long getModeratorid() {
        return moderatorid;
    }

    public void setModeratorid(Long moderatorid) {
        this.moderatorid = moderatorid;
    }

    public String save() throws Exception {
//        System.out.println("********************** carid = " + carid);

        UserSession userSession = userSessionService.getUserSession();
        Long typeid= typeid = (Long) userSession.get("typeid");
        if (typeid != null){
            type = demandTypeDao.get(typeid);
            entity.setType(type);
        }

        if (moderatorid != null) {
            SysUser moderator = sysUserDao.get(moderatorid);
            entity.setModerator(moderator);
        }

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date d = new Date();
        String day = sdf.format(d);
        entity.setSubmitdate(day);
        entity.setUser(userSessionService.getCurrentSysUser());
        entity.setFlag("审核");
        service.save(entity);

        List<SysUser> sysUsers = new ArrayList<SysUser>();
        sysUsers.add(entity.getType().getUser());
        messageListener.notice(sysUsers, entity);

        return RELOAD;
    }

    public String delete() throws Exception {
        service.delete(id);
        return RELOAD;
    }

    protected void prepareModel() throws Exception {
        if (entity == null) {
            if (id != null) {
                entity = service.get(id);
            }
            else {
                entity = new Demand();
                entity.setStatus(false);
            }
        }
        if (entity.getId() == null) {
            UserSession userSession = userSessionService.getUserSession();
            Long typeid= typeid = (Long) userSession.get("typeid");
            if (typeid != null){
                type = demandTypeDao.get(typeid);
                entity.setType(type);
            }
        }
        else {
            type = entity.getType();

            UserSession userSession = userSessionService.getUserSession();
            userSession.set("typeid", type.getId());
        }
    }

    public Demand getModel() {
        return entity;
    }

}
