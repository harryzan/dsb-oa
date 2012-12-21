package gov.dsb.web.action.oa.attendance;

import gov.dsb.core.dao.SysDeptDao;
import gov.dsb.core.dao.SysRoleDao;
import gov.dsb.core.dao.SysUserDao;
import gov.dsb.core.dao.UserAttendanceDao;
import gov.dsb.core.domain.SysUser;
import gov.dsb.core.domain.UserAttendance;
import gov.dsb.core.struts2.CRUDActionSupport;
import gov.dsb.core.utils.StringHelp;
import gov.dsb.web.security.UserSessionService;
import org.apache.axis.encoding.ser.DateSerializer;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import java.math.BigInteger;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by IntelliJ IDEA.
 * User: cxs
 * Date: 2009-7-23
 * Time: 9:47:37
 * To change this template use File | Settings | File Templates.
 */

@ParentPackage("default")
@Results({@Result(name = CRUDActionSupport.RELOAD, location = "user-attendance-main", type = "redirect")})
public class UserAttendanceAction extends CRUDActionSupport<UserAttendance> {

    @Autowired
    private UserAttendanceDao service;

    @Autowired
    private UserSessionService userSessionService;

    @Autowired
    private SysUserDao sysUserDao;

    @Autowired
    private SysDeptDao sysDeptDao;

    @Autowired
    private SysRoleDao sysRoleDao;

    protected Long id;

    private String day;

    private String beforeday;

    private String afterday;

    private List<UserAttendance> attendances;

    private String attid;

    private String atttype;

    private String memo;

    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }

    public String getAttid() {
        return attid;
    }

    public void setAttid(String attid) {
        this.attid = attid;
    }

    public String getAtttype() {
        return atttype;
    }

    public void setAtttype(String atttype) {
        this.atttype = atttype;
    }

    public String getBeforeday() {
        return beforeday;
    }

    public String getAfterday() {
        return afterday;
    }

    public String getDay() {
        return day;
    }

    public void setDay(String day) {
        this.day = day;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    private Timestamp today;

    private List<Map<String, Object>> result;

    public Timestamp getToday() {
        return today;
    }

    public void setToday(Timestamp today) {
        this.today = today;
    }

    public List<Map<String, Object>> getResult() {
        return result;
    }

    public void setResult(List<Map<String, Object>> result) {
        this.result = result;
    }


    public List<UserAttendance> getAttendances() {
        return attendances;
    }

    public void setAttendances(List<UserAttendance> attendances) {
        this.attendances = attendances;
    }

    private String begintime;

    private String endtime;

    public String save() throws Exception {

        String[] ids = attid.split(",");
        String[] types = atttype.split(",");
        String[] memos = memo.split(",");

        for (int i = 0; i < ids.length; i++) {
            UserAttendance attendance = service.get(Long.parseLong(ids[i].trim()));
            attendance.setType(types[i].trim());
            attendance.setMemo(memos[i]);
            service.save(attendance);
        }

        return day();
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
                entity = new UserAttendance();
            }
        }
    }

    public String day() throws Exception {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        if (day == null || "".equals(day)) {
            Date d = new Date();
            day = sdf.format(d);
            beforeday = sdf.format(new Date(d.getTime() - 24 * 3600 * 1000L));
            afterday = sdf.format(new Date(d.getTime() + 24 * 3600 * 1000L));
        }
        else {
            Date d = sdf.parse(day);
            day = sdf.format(d);
            beforeday = sdf.format(new Date(d.getTime() - 24 * 3600 * 1000L));
            afterday = sdf.format(new Date(d.getTime() + 24 * 3600 * 1000L));
        }


        SysUser currentUser = userSessionService.getCurrentSysUser();

        Calendar calendar = Calendar.getInstance();


        Date d = sdf.parse(day);
        Date now = new Date();

        calendar.setTime(d);
        int m = calendar.get(Calendar.MONTH);
        calendar.setTime(now);
        int _m = calendar.get(Calendar.MONTH);

        if (!d.after(now) && m == _m)
        {
            if (sysUserDao.containRole(currentUser.getId(), "系统管理员"))
                attendances = service.createDayAttendance(new java.sql.Date(sdf.parse(day).getTime()));
            else if (sysUserDao.containRole(currentUser.getId(), "考勤负责人"))
                attendances = service.createDayAttendance(new java.sql.Date(sdf.parse(day).getTime()), currentUser.getSysdept());
            else
                attendances = service.createDayAttendance(new java.sql.Date(sdf.parse(day).getTime()), currentUser);
        }

        return "day";
    }

    public String record() throws Exception {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Calendar calendar = Calendar.getInstance();

        if (week != null && year != null) {
            calendar.set(Calendar.YEAR, year);
            calendar.set(Calendar.WEEK_OF_YEAR, week);
            Date d = calendar.getTime();
            day = sdf.format(d);
        }
        else if (day == null || "".equals(day)) {
            Date d = new Date();
            day = sdf.format(d);
            beforeday = sdf.format(new Date(d.getTime() - 24 * 3600 * 1000L));
            afterday = sdf.format(new Date(d.getTime() + 24 * 3600 * 1000L));
            calendar.setTime(d);
            setWeek(calendar.get(Calendar.WEEK_OF_YEAR));
            setYear(calendar.get(Calendar.YEAR));
        }
        else {
            Date d = sdf.parse(day);
            day = sdf.format(d);
            beforeday = sdf.format(new Date(d.getTime() - 24 * 3600 * 1000L));
            afterday = sdf.format(new Date(d.getTime() + 24 * 3600 * 1000L));
            calendar.setTime(d);
            setWeek(calendar.get(Calendar.WEEK_OF_YEAR));
            setYear(calendar.get(Calendar.YEAR));
        }

        setBeforeweek(week - 1);
        setBeforeyear(year);
        setAfterweek(week + 1);
        setAfteryear(year);
//        setWeek("" + _week);
        if (week == 1) {
            setBeforeweek(52);
            setBeforeyear(year - 1);
        } else if (week == 52) {
            setAfterweek(1);
            setAfteryear(year + 1);
        }

        java.sql.Date[] dates = new java.sql.Date[7];
        calendar.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
        dates[0] = new java.sql.Date(calendar.getTime().getTime());
        calendar.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
        dates[1] = new java.sql.Date(calendar.getTime().getTime());
        calendar.set(Calendar.DAY_OF_WEEK, Calendar.TUESDAY);
        dates[2] = new java.sql.Date(calendar.getTime().getTime());
        calendar.set(Calendar.DAY_OF_WEEK, Calendar.WEDNESDAY);
        dates[3] = new java.sql.Date(calendar.getTime().getTime());
        calendar.set(Calendar.DAY_OF_WEEK, Calendar.THURSDAY);
        dates[4] = new java.sql.Date(calendar.getTime().getTime());
        calendar.set(Calendar.DAY_OF_WEEK, Calendar.FRIDAY);
        dates[5] = new java.sql.Date(calendar.getTime().getTime());
        calendar.set(Calendar.DAY_OF_WEEK, Calendar.SATURDAY);
        dates[6] = new java.sql.Date(calendar.getTime().getTime());

//        SysUser currentUser = userSessionService.getCurrentSysUser();

//        Date d = sdf.parse(day);
//        Date now = new Date();
//        if (!d.after(now))
//        {
//            if (sysUserDao.containRole(currentUser.getId(), "系统管理员"))
        if (deptid != null) {
            attendances = service.getDayAttendance(dates, sysDeptDao.get(deptid));
            return "dept";
        }
        else if (userid != null) {
            attendances = service.getDayAttendance(dates, sysUserDao.get(userid));
            return "user";
        }
        else {
            attendances = service.getDayAttendance(new java.sql.Date(sdf.parse(day).getTime()));
        }
//            else if (sysUserDao.containRole(currentUser.getId(), "考勤负责人"))
//                attendances = service.getDayAttendance(new java.sql.Date(sdf.parse(day).getTime()), currentUser.getSysdept());
//            else
//                attendances = service.getDayAttendance(new java.sql.Date(sdf.parse(day).getTime()), currentUser);
//        }

        return "record";
    }

    private Long userid;

    public Long getUserid() {
        return userid;
    }

    public void setUserid(Long userid) {
        this.userid = userid;
    }

    private Long deptid;

    public Long getDeptid() {
        return deptid;
    }

    public void setDeptid(Long deptid) {
        this.deptid = deptid;
    }

    public String month() throws Exception {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        today = new Timestamp(System.currentTimeMillis());

        result = new ArrayList<Map<String, Object>>();
        try {
         }
        catch (Exception e) {
            e.printStackTrace();
        }
        return "month";
    }

    public String monthopen() {
        return "monthopen";
    }

    public UserAttendance getModel() {
        return entity;
    }

    public String list() throws Exception {
        return "list";
    }

    public String search() throws Exception {
        return "search";
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
                sysUserDao.containRole(currentUser.getId(), "考勤负责人")) {
            isadmin = true;
        }
        return "tab";
    }


    private Integer month;

    private Integer beforemonth;

    private Integer aftermonth;

    private Integer week;

    private Integer beforeweek;

    private Integer afterweek;

    private Integer beforeyear;

    private Integer afteryear;

    private Integer year;

    public Integer getWeek() {
        return week;
    }

    public void setWeek(Integer week) {
        this.week = week;
    }

    public Integer getBeforeweek() {
        return beforeweek;
    }

    public void setBeforeweek(Integer beforeweek) {
        this.beforeweek = beforeweek;
    }

    public Integer getAfterweek() {
        return afterweek;
    }

    public void setAfterweek(Integer afterweek) {
        this.afterweek = afterweek;
    }

    public Integer getMonth() {
        return month;
    }

    public void setMonth(Integer month) {
        this.month = month;
    }

    public Integer getBeforemonth() {
        return beforemonth;
    }

    public void setBeforemonth(Integer beforemonth) {
        this.beforemonth = beforemonth;
    }

    public Integer getAftermonth() {
        return aftermonth;
    }

    public void setAftermonth(Integer aftermonth) {
        this.aftermonth = aftermonth;
    }

    public Integer getBeforeyear() {
        return beforeyear;
    }

    public void setBeforeyear(Integer beforeyear) {
        this.beforeyear = beforeyear;
    }

    public Integer getAfteryear() {
        return afteryear;
    }

    public void setAfteryear(Integer afteryear) {
        this.afteryear = afteryear;
    }

    public Integer getYear() {
        return year;
    }

    public void setYear(Integer year) {
        this.year = year;
    }

    public String sum() throws ParseException {

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Calendar calendar = Calendar.getInstance();

        if (month != null && year != null) {
            calendar.set(Calendar.YEAR, year);
            calendar.set(Calendar.MONTH, month-1);
            Date d = calendar.getTime();
            day = sdf.format(d);
        } else if (StringHelp.isNotEmpty(day)) {
            Date d = sdf.parse(day);
            calendar.setTime(d);
            setMonth(calendar.get(Calendar.MONTH) + 1);
            setYear(calendar.get(Calendar.YEAR));
        } else {
            Date d = new Date();
            calendar.setTime(d);
            day = sdf.format(d);
            setMonth(calendar.get(Calendar.MONTH) + 1);
            setYear(calendar.get(Calendar.YEAR));
        }


        setBeforemonth(month - 1);
        setBeforeyear(year);
        setAftermonth(month + 1);
        setAfteryear(year);
//        setWeek("" + _week);
        if (month == 1) {
            setBeforemonth(12);
            setBeforeyear(year - 1);
        } else if (month == 12) {
            setAftermonth(1);
            setAfteryear(year + 1);
        }

//        System.out.println("day.substring(0, 7) = " + day.substring(0, 7));

        String sql = "select userid,\n" +
                "        sum(decode(type, 1, 1, 0)) type1, \n" +
                "        sum(decode(type, 2, 1, 0)) type2,\n" +
                "        sum(decode(type, 3, 1, 0)) type3,\n" +
                "        sum(decode(type, 4, 1, 0)) type4,\n" +
                "        sum(decode(type, 5, 1, 0)) type5,\n" +
                "        sum(decode(type, 6, 1, 0)) type6,\n" +
                "        sum(decode(type, 7, 1, 0)) type7,\n" +
                "        sum(decode(type, 8, 1, 0)) type8,\n" +
                "        sum(decode(type, 9, 1, 0)) type9,\n" +
                "        sum(decode(type, 10, 1, 0)) type10,\n" +
                "        sum(decode(type, 0, 1, 0)) type0\n" +
                "  from userattendance t where substr(checkdate, 0, 7) = '" + day.substring(0, 7) + "' and type is not null group by userid";

        records = service.findBySql(sql);
        for (Map map : records) {
            BigInteger userid = (BigInteger) map.get("USERID");

            SysUser user = sysUserDao.get(userid.longValue());

            map.put("USERNAME", user.getDisplayname());
            map.put("ORDERNO", user.getSysdept().getOrderno());
            map.put("DEPTNAME", user.getSysdept().getName());
        }

        Collections.sort(records, new UserAttendanceComparator());

        System.out.println("records.size() = " + records.size());

        return "sum";
    }

    List<Map> records;

    public List<Map> getRecords() {
        return records;
    }

    public void setRecords(List<Map> records) {
        this.records = records;
    }

    class UserAttendanceComparator implements Comparator {

        public final int compare(Object pFirst, Object pSecond) {
            Long forderno = (Long) ((Map) pFirst).get("ORDERNO");
            Long sorderno = (Long) ((Map) pSecond).get("ORDERNO");
            BigInteger fuserid = (BigInteger) ((Map) pFirst).get("USERID");
            BigInteger suserid = (BigInteger) ((Map) pSecond).get("USERID");

            if (forderno < sorderno) {
                return -1;
            }
            else if (forderno > sorderno) {
                return 1;
            }
            else {
                if (fuserid.longValue() < suserid.longValue()) {
                    return -1;
                }
                else {
                    return 1;
                }
            }
        }
    }
}
