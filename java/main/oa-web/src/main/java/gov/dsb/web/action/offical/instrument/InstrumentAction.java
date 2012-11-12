package gov.dsb.web.action.offical.instrument;

import gov.dsb.core.dao.InstrumentDao;
import gov.dsb.core.dao.SysUserDao;
import gov.dsb.core.domain.Instrument;
import gov.dsb.core.domain.SysUser;
import gov.dsb.core.struts2.CRUDActionSupport;
import gov.dsb.core.struts2.SimpleActionSupport;
import gov.dsb.web.security.UserSessionService;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;

/**
 * Created by IntelliJ IDEA.
 * User: cxs
 * Date: 2010-4-1
 * Time: 14:11:53
 * To change this template use File | Settings | File Templates.
 */

@ParentPackage("default")
@Results({@Result(name = CRUDActionSupport.RELOAD, location = "instrument-grid", type = "chain"),
        @Result(name = SimpleActionSupport.SUCCESS, location = "/WEB-INF/pages/common/ajaxutilData.jsp")})
public class InstrumentAction extends CRUDActionSupport<Instrument> {

    @Autowired
    private InstrumentDao service;

    @Autowired
    private SysUserDao sysUserEntityService;

    @Autowired
    private UserSessionService userSessionService;

    protected Long id;

    private String targetuserid;

    public String getTargetuserid() {
        return targetuserid;
    }

    public void setTargetuserid(String targetuserid) {
        this.targetuserid = targetuserid;
    }

    private String gridParam;

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

    public String save() throws Exception {
        SysUser user = userSessionService.getCurrentSysUser();
        Timestamp now = new Timestamp(System.currentTimeMillis());

        if (entity.getId() == null) {
            entity.setCreateuser(user);
            entity.setCreatedate(now);
        }
        entity.setUpdateuser(user);
        entity.setUpdatedate(now);

        if (targetuserid != null) {
            SysUser targetuser = sysUserEntityService.get(Long.getLong(targetuserid));
            entity.setTargetuser(targetuser);
        }
//        entity.setStarttime(new Timestamp(System.currentTimeMillis()));
//        if (entity.getSysuserbulletins() != null) {
//            entity.getSysuserbulletins().clear();
//        } else {
//            entity.setSysuserbulletins(new ArrayList<SysUser>());
//        }

        service.save(entity);
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
            } else {
                entity = new Instrument();

//                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//                Date now = new Date(System.currentTimeMillis());
//                entity.setStarttime(sdf.format(now));
            }
        }

    }

    public String view() throws Exception {
        return VIEW;
    }

    public Instrument getModel() {
        return entity;
    }
}
