package gov.dsb.web.action.system.demandtype;

import gov.dsb.core.dao.DemandTypeDao;
import gov.dsb.core.dao.SysUserDao;
import gov.dsb.core.domain.DemandType;
import gov.dsb.core.domain.SysUser;
import gov.dsb.core.struts2.CRUDActionSupport;
import gov.dsb.core.utils.StringHelp;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.ArrayList;
import java.util.Collection;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 2009-5-15
 * Time: 10:57:24
 * To change this template use File | Settings | File Templates.
 */

@ParentPackage("default")
@Results({@Result(name = CRUDActionSupport.RELOAD, location = "demand-type-grid", type = "chain")})
public class DemandTypeAction extends CRUDActionSupport<DemandType>{

    @Autowired
    private DemandTypeDao service;

    @Autowired
    private SysUserDao sysUserDao;

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

    private Long userid;

    public Long getUserid() {
        return userid;
    }

    public void setUserid(Long userid) {
        this.userid = userid;
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
//        if (userid != null) {
//            entity.setUser(sysUserDao.get(userid));
//        }
        entity.setUserids(viewuserids);
        entity.setUsernames(viewusernames);

//        if (StringHelp.isNotEmpty(viewuserids)) {
//            Collection<SysUser> users = new ArrayList<SysUser>();
//
//            viewuserids = viewuserids.trim();
//            String[] userids = viewuserids.split(",");
//            for (String id : userids) {
//                SysUser sysUser = sysUserDao.get(Long.parseLong(id));
//                users.add(sysUser);
//            }
//
//            entity.setDemandtypeusers(users);
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
            }
            else {
                entity = new DemandType();
            }
        }
    }

    public DemandType getModel() {
        return entity;
    }

}
