package gov.dsb.web.action.dw;

import gov.dsb.core.dao.DwDao;
import gov.dsb.core.dao.DwTypeDao;
import gov.dsb.core.domain.Dw;
import gov.dsb.core.domain.DwType;
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
@Results({@Result(name = CRUDActionSupport.RELOAD, location = "dw-grid", type = "chain"),
        @Result(name = SimpleActionSupport.SUCCESS, location = "/WEB-INF/pages/common/ajaxutilData.jsp")})
public class DwAction extends CRUDActionSupport<Dw> {

    @Autowired
    private DwDao service;

    @Autowired
    private DwTypeDao dwTypeDao;

    @Autowired
    private UserSessionService userSessionService;

    protected Long id;

    private String viewuserids;

    private HashMap map;

    private String result;

    private String path;

    private String gridParam;

    private Long typeid;

    public Long getTypeid() {
        return typeid;
    }

    public void setTypeid(Long typeid) {
        this.typeid = typeid;
    }

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
        entity.setCreateuser(user);
//        entity.setStarttime(new Timestamp(System.currentTimeMillis()));
//        if (entity.getSysuserbulletins() != null) {
//            entity.getSysuserbulletins().clear();
//        } else {
//            entity.setSysuserbulletins(new ArrayList<SysUser>());
//        }

        if (typeid != null) {
            DwType dwType = dwTypeDao.get(typeid);
            entity.setDwType(dwType);
        }

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
                entity = new Dw();

                Timestamp now = new Timestamp(System.currentTimeMillis());
                entity.setStarttime(now);
            }
        }

    }

    public String view() throws Exception {
        return VIEW;
    }

    public Dw getModel() {
        return entity;
    }
}
