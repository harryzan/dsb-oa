package gov.dsb.web.action.oa.car;

import gov.dsb.core.dao.CarDao;
import gov.dsb.core.dao.CarUseDao;
import gov.dsb.core.dao.DriverDao;
import gov.dsb.core.dao.SysRoleDao;
import gov.dsb.core.domain.*;
import gov.dsb.core.struts2.CRUDActionSupport;
import gov.dsb.web.message.MessageListener;
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
@Results({@Result(name = CRUDActionSupport.RELOAD, location = "car-complete-grid", type = "redirect")})
public class CarDriveAction extends CRUDActionSupport<CarUse>{

    @Autowired
    private CarUseDao service;

    @Autowired
    private MessageListener messageListener;

    @Autowired
    private CarDao  carDao;

    @Autowired
    private DriverDao driverDao;

    @Autowired
    private UserSessionService userSessionService;

    @Autowired
    private SysRoleDao sysRoleDao;

    private String gridParam;

    public void setGridParam(String gridParam) {
        this.gridParam = gridParam;
    }


    private Collection<Car> cars;

    public Collection<Car> getCars() {
        return cars;
    }

    public void setCars(Collection<Car> cars) {
        this.cars = cars;
    }

    private Collection<Driver> drivers;

    public Collection<Driver> getDrivers() {
        return drivers;
    }

    public void setDrivers(Collection<Driver> drivers) {
        this.drivers = drivers;
    }

    protected Long id;

    public void setId(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    public Long carid;

    public Long getCarid() {
        return carid;
    }

    public void setCarid(Long carid) {
        this.carid = carid;
    }

    public Long driverid;

    public Long getDriverid() {
        return driverid;
    }

    public void setDriverid(Long driverid) {
        this.driverid = driverid;
    }

    public String save() throws Exception {
//        System.out.println("********************** carid = " + carid);

        Car car = carDao.get(carid);
        entity.setCar(car);

        Driver driver = driverDao.get(driverid);
        entity.setDriver(driver);

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        Date d = new Date();
        String day = sdf.format(d);
        entity.setMemodate(day);
        entity.setMemor(userSessionService.getCurrentSysUser());
        entity.setFlag("完成");

        service.save(entity);

        List<SysUser> sysUsers = new ArrayList<SysUser>();
        sysUsers.add(entity.getUser());
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
                entity = new CarUse();
                entity.setStatus(false);
            }
        }

        cars = carDao.findAll();
        drivers = driverDao.findAll();
//        System.out.println("cars.size() = " + cars.size());
    }

    public CarUse getModel() {
        return entity;
    }

}
