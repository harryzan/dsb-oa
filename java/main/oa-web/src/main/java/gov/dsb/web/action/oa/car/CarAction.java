package gov.dsb.web.action.oa.car;

import gov.dsb.core.dao.CarDao;
import gov.dsb.core.dao.SysUserDao;
import gov.dsb.core.domain.Car;
import gov.dsb.core.domain.SysUser;
import gov.dsb.core.struts2.CRUDActionSupport;
import gov.dsb.web.security.UserSessionService;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 2009-5-15
 * Time: 10:57:24
 * To change this template use File | Settings | File Templates.
 */

@ParentPackage("default")
@Results({@Result(name = CRUDActionSupport.RELOAD, location = "car-grid", type = "chain")})
public class CarAction extends CRUDActionSupport<Car>{

    @Autowired
    private CarDao service;

    @Autowired
    private UserSessionService userSessionService;

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

    public String save() throws Exception {
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
                entity = new Car();
            }
        }
    }

    public Car getModel() {
        return entity;
    }

    private boolean isadmin;

    public boolean getIsadmin() {
        return isadmin;
    }

    public void setIsadmin(boolean isadmin) {
        this.isadmin = isadmin;
    }

    public String tab() {
        SysUser currentUser = userSessionService.getCurrentSysUser();

        if (sysUserDao.containRole(currentUser.getId(), "系统管理员") ||
                sysUserDao.containRole(currentUser.getId(), "车辆负责人")) {
            isadmin = true;
        }
        return "tab";
    }
}
