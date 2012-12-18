package gov.dsb.web.action.oa.car;

import gov.dsb.core.dao.CarDao;
import gov.dsb.core.dao.CarUseDao;
import gov.dsb.core.dao.DriverDao;
import gov.dsb.core.dao.SysRoleDao;
import gov.dsb.core.domain.Car;
import gov.dsb.core.domain.CarUse;
import gov.dsb.core.domain.Driver;
import gov.dsb.core.domain.SysRole;
import gov.dsb.core.struts2.CRUDActionSupport;
import gov.dsb.web.message.MessageListener;
import gov.dsb.web.security.UserSessionService;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.Date;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 2009-5-15
 * Time: 10:57:24
 * To change this template use File | Settings | File Templates.
 */

@ParentPackage("default")
@Results({@Result(name = CRUDActionSupport.RELOAD, location = "car-complete-grid", type = "chain")})
public class CarCompleteAction extends CRUDActionSupport<CarUse>{

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

    public String save() throws Exception {
//        System.out.println("********************** carid = " + carid);

//        Car car = carDao.get(carid);
//        entity.setCar(car);

//        Driver driver = driverDao.get(driverid);
//        entity.setDriver(driver);

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date d = new Date();
        String day = sdf.format(d);
        entity.setReminddate(day);
        entity.setReminder(userSessionService.getCurrentSysUser());
        entity.setFlag("已完成");

        Long entityId = entity.getId();

        service.save(entity);

        if (entityId == null) {

            SysRole role = sysRoleDao.findUnique("from SysRole where name=?", "车辆负责人");
            if (role != null) {
                messageListener.notice(role.getSysuserroles(), entity);
            }
        }

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
