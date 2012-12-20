package gov.dsb.core.dao;

import gov.dsb.core.dao.base.EntityService;
import gov.dsb.core.domain.SysDept;
import gov.dsb.core.domain.SysUser;
import gov.dsb.core.domain.UserAttendance;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.math.BigInteger;
import java.sql.Date;
import java.util.*;

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
        return findByQuery("from UserAttendance where checkdate=? order by user.sysdept.orderno, user.id, noon", date);
    }

    public List<UserAttendance> getDayAttendance(Date date, SysDept sysDept) {
        return findByQuery("from UserAttendance where checkdate=? and user.sysdept.id=? order by user.id, noon", date, sysDept.getId());
    }

    public List<UserAttendance> getDayAttendance(Date[] dates, SysDept sysDept) {
        return findByQuery("from UserAttendance where (checkdate=? or checkdate=? or checkdate=? or checkdate=? or checkdate=? or checkdate=? or checkdate=?) and user.sysdept.id=? order by user.id, checkdate, noon",
                dates[0], dates[1], dates[2], dates[3], dates[4], dates[5], dates[6], sysDept.getId());
//        return findByQuery("from UserAttendance where checkdate=? and user.sysdept.id=? order by user.id, noon", date, sysDept.getId());
    }

    public List<UserAttendance> getDayAttendance(Date date, SysUser sysUser) {
        return findByQuery("from UserAttendance where checkdate=? and user.id=? order by noon", date, sysUser.getId());
    }

    public List<UserAttendance> getDayAttendance(Date[] dates, SysUser sysUser) {
//        String s = Arrays.toString(dates);
//        System.out.println("******************* s = " + s);
        return findByQuery("from UserAttendance where (checkdate=? or checkdate=? or checkdate=? or checkdate=? or checkdate=? or checkdate=? or checkdate=?) and user.id=? order by checkdate, noon",
                dates[0], dates[1], dates[2], dates[3], dates[4], dates[5], dates[6], sysUser.getId());
    }

    synchronized public List<UserAttendance> createDayAttendance(Date date) {
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
            userAttendance.setNoon(false);
            save(userAttendance);
            attendances.add(userAttendance);

            userAttendance = new UserAttendance();
            userAttendance.setCheckdate(date);
            userAttendance.setUser(user);
            userAttendance.setNoon(true);
            save(userAttendance);
            attendances.add(userAttendance);
        }

        Collections.sort(attendances, new UserAttendanceComparator());
        return attendances;
    }

    synchronized public List<UserAttendance> createDayAttendance(Date date, SysDept sysDept) {
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
            userAttendance.setNoon(false);
            save(userAttendance);
            attendances.add(userAttendance);

            userAttendance = new UserAttendance();
            userAttendance.setCheckdate(date);
            userAttendance.setUser(user);
            userAttendance.setNoon(true);
            save(userAttendance);
            attendances.add(userAttendance);
        }

        Collections.sort(attendances, new UserAttendanceComparator());
        return attendances;
    }

    synchronized public List<UserAttendance> createDayAttendance(Date date, SysUser user) {
        List<UserAttendance> attendances = getDayAttendance(date, user);

        if (attendances.size() == 0) {
            UserAttendance userAttendance = new UserAttendance();
            userAttendance.setCheckdate(date);
            userAttendance.setUser(user);
            userAttendance.setNoon(false);
            save(userAttendance);
            attendances.add(userAttendance);

            userAttendance = new UserAttendance();
            userAttendance.setCheckdate(date);
            userAttendance.setUser(user);
            userAttendance.setNoon(true);
            save(userAttendance);
            attendances.add(userAttendance);
        }

        Collections.sort(attendances, new UserAttendanceComparator());
        return attendances;
    }

    class UserAttendanceComparator implements Comparator {

        public final int compare(Object pFirst, Object pSecond) {
            Long puserid = ((UserAttendance) pFirst).getUser().getId();
            Long suserid = ((UserAttendance) pSecond).getUser().getId();
            Long porderno = ((UserAttendance) pFirst).getUser().getSysdept().getOrderno();
            Long sorderno = ((UserAttendance) pSecond).getUser().getSysdept().getOrderno();
            Boolean pnoon = ((UserAttendance) pFirst).getNoon();
            Boolean snoon = ((UserAttendance) pSecond).getNoon();

            if (porderno < sorderno) {
                return 1;
            }
            else if (porderno > sorderno) {
                return -1;
            }
            else {
                if (puserid < suserid) {
                    return 1;
                }
                else if (puserid > suserid) {
                    return -1;
                }
                else {
                    if (snoon) {
                        return 1;
                    }
                    else {
                        return -1;
                    }
                }
            }
        }
    }
}