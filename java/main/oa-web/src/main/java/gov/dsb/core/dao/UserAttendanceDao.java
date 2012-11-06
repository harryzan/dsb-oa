package gov.dsb.core.dao;

import gov.dsb.core.dao.base.EntityService;
import gov.dsb.core.domain.SysDept;
import gov.dsb.core.domain.SysUser;
import gov.dsb.core.domain.UserAttendance;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.sql.Date;
import java.util.Collection;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: harryzan
 * Date: 9/16/12
 * Time: 10:42 AM
 * To change this template use File | Settings | File Templates.
 */
@Repository
public class UserAttendanceDao extends EntityService<UserAttendance, Long> {

    @Autowired
    private SysUserDao sysUserDao;

    @Autowired
    public void setSessionFactory(SessionFactory sessionFactory) {
        initDao(sessionFactory, UserAttendance.class);
    }

    public List<UserAttendance> getDayAttendance(Date date) {
        List<UserAttendance> attendances = findByQuery("from UserAttendance where checkdate=? order by user.sysdept.orderno, user.id", date);
        return attendances;
    }

    public List<UserAttendance> getDayAttendance(Date date, SysDept sysDept) {
        List<UserAttendance> attendances = findByQuery("from UserAttendance where checkdate=? and user.sysdept.id=? order by user.id", date, sysDept.getId());
        return attendances;
    }

    public List<UserAttendance> getDayAttendance(Date date, SysUser sysUser) {
        List<UserAttendance> attendances = findByQuery("from UserAttendance where checkdate=? and user.id=?", date, sysUser.getId());
        return attendances;
    }

    public List<UserAttendance> createDayAttendance(Date date) {
        List<UserAttendance> attendances = getDayAttendance(date);

        List<SysUser> users = sysUserDao.findByQuery("from SysUser order by id");

        if (attendances.size() > 0)
            for (UserAttendance attendance : attendances) {
                if (users.contains(attendance.getUser())) {
                    users.remove(attendance.getUser());
                }
            }

        for (SysUser user : users) {
            UserAttendance userAttendance = new UserAttendance();
            userAttendance.setCheckdate(date);
            userAttendance.setUser(user);
            save(userAttendance);
            attendances.add(userAttendance);
        }
        return attendances;
    }

    public List<UserAttendance> createDayAttendance(Date date, SysDept sysDept) {
        List<UserAttendance> attendances = getDayAttendance(date, sysDept);

        Collection<SysUser> users = sysDept.getSysusers();

        if (attendances.size() > 0)
            for (UserAttendance attendance : attendances) {
                if (users.contains(attendance.getUser())) {
                    users.remove(attendance.getUser());
                }
            }

        for (SysUser user : users) {
            UserAttendance userAttendance = new UserAttendance();
            userAttendance.setCheckdate(date);
            userAttendance.setUser(user);
            save(userAttendance);
            attendances.add(userAttendance);
        }
        return attendances;
    }

    public List<UserAttendance> createDayAttendance(Date date, SysUser sysUser) {
        List<UserAttendance> attendances = getDayAttendance(date, sysUser);

        if (attendances.size() == 0) {
            UserAttendance userAttendance = new UserAttendance();
            userAttendance.setCheckdate(date);
            userAttendance.setUser(sysUser);
            save(userAttendance);
            attendances.add(userAttendance);
        }
        return attendances;
    }
}