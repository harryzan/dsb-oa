package gov.dsb.web.action;

import gov.dsb.core.dao.BulletinDao;
import gov.dsb.core.dao.DemandTypeDao;
import gov.dsb.core.dao.MessageDao;
import gov.dsb.core.dao.WorkArrangeDao;
import gov.dsb.core.dao.base.Page;
import gov.dsb.core.domain.*;
import gov.dsb.core.struts2.PageActionSupport;
import gov.dsb.core.utils.StringHelp;
import gov.dsb.web.security.UserSessionService;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 2009-7-5
 * Time: 10:17:16
 * To change this template use File | Settings | File Templates.
 */

@ParentPackage("default")
@Results({@Result(name = PageActionSupport.GRIDDATA, location = "/WEB-INF/pages/common/gridData.jsp")})
public class MainAction extends PageActionSupport<DemandType> {

    @Autowired
    private WorkArrangeDao workArrangeDao;

    @Autowired
    private BulletinDao bulletinDao;

    @Autowired
    private UserSessionService userSessionService;

    @Autowired
    private MessageDao messageDao;

    private SysUser user;

    public SysUser getUser() {
        return user;
    }

    public void setUser(SysUser user) {
        this.user = user;
    }

    public void prepare() throws Exception {

    }

    private List<WorkArrange> monarranges;
    private List<WorkArrange> tusarranges;
    private List<WorkArrange> wedarranges;
    private List<WorkArrange> thearranges;
    private List<WorkArrange> friarranges;
    private List<WorkArrange> satarranges;
    private List<WorkArrange> sunarranges;

    public List<WorkArrange> getMonarranges() {
        return monarranges;
    }

    public void setMonarranges(List<WorkArrange> monarranges) {
        this.monarranges = monarranges;
    }

    public List<WorkArrange> getTusarranges() {
        return tusarranges;
    }

    public void setTusarranges(List<WorkArrange> tusarranges) {
        this.tusarranges = tusarranges;
    }

    public List<WorkArrange> getWedarranges() {
        return wedarranges;
    }

    public void setWedarranges(List<WorkArrange> wedarranges) {
        this.wedarranges = wedarranges;
    }

    public List<WorkArrange> getThearranges() {
        return thearranges;
    }

    public void setThearranges(List<WorkArrange> thearranges) {
        this.thearranges = thearranges;
    }

    public List<WorkArrange> getFriarranges() {
        return friarranges;
    }

    public void setFriarranges(List<WorkArrange> friarranges) {
        this.friarranges = friarranges;
    }

    public List<WorkArrange> getSatarranges() {
        return satarranges;
    }

    public void setSatarranges(List<WorkArrange> satarranges) {
        this.satarranges = satarranges;
    }

    public List<WorkArrange> getSunarranges() {
        return sunarranges;
    }

    public void setSunarranges(List<WorkArrange> sunarranges) {
        this.sunarranges = sunarranges;
    }

    public String list() throws Exception {
        return SUCCESS;
    }

    private List<Bulletin> bulletins;

    public List<Bulletin> getBulletins() {
        return bulletins;
    }

    public void setBulletins(List<Bulletin> bulletins) {
        this.bulletins = bulletins;
    }

    private String day;

    public String getDay() {
        return day;
    }

    public void setDay(String day) {
        this.day = day;
    }

    Integer week;

    public Integer getNweek() {
        return week;
    }

    public void setNweek(Integer week) {
        this.week = week;
    }

    Integer year;

    public Integer getNyear() {
        return year;
    }

    public void setNyear(Integer year) {
        this.year = year;
    }


    private Integer beforeweek;

    private Integer afterweek;

    private Integer beforeyear;

    private Integer afteryear;

    public int getBeforeweek() {
        return beforeweek;
    }

    public void setBeforeweek(int beforeweek) {
        this.beforeweek = beforeweek;
    }

    public int getAfterweek() {
        return afterweek;
    }

    public void setAfterweek(int afterweek) {
        this.afterweek = afterweek;
    }

    public int getBeforeyear() {
        return beforeyear;
    }

    public void setBeforeyear(int beforeyear) {
        this.beforeyear = beforeyear;
    }

    public int getAfteryear() {
        return afteryear;
    }

    public void setAfteryear(int afteryear) {
        this.afteryear = afteryear;
    }

    private Integer pageno;

    public Integer getPageno() {
        return pageno;
    }

    public void setPageno(Integer pageno) {
        this.pageno = pageno;
    }

    private Integer totalpages;

    public Integer getTotalpages() {
        return totalpages;
    }

    public void setTotalpages(Integer totalpages) {
        this.totalpages = totalpages;
    }

    @Override
    public String execute() throws Exception {

        user = userSessionService.getCurrentSysUser();

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Calendar calendar = Calendar.getInstance();

//        Date d = new Date();
//        calendar.setTime(d);
//        week = calendar.get(Calendar.WEEK_OF_YEAR);
//        year = calendar.get(Calendar.YEAR);

        if (week != null && year != null) {
            calendar.set(Calendar.YEAR, year);
            calendar.set(Calendar.WEEK_OF_YEAR, week);
            Date d = calendar.getTime();
            day = sdf.format(d);
        } else if (StringHelp.isNotEmpty(day)) {
            Date d = sdf.parse(day);
            calendar.setTime(d);
            setNweek(calendar.get(Calendar.WEEK_OF_YEAR));
            setNyear(calendar.get(Calendar.YEAR));
        } else {
            Date d = new Date();
            calendar.setTime(d);
            day = sdf.format(d);
            setNweek(calendar.get(Calendar.WEEK_OF_YEAR));
            setNyear(calendar.get(Calendar.YEAR));
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

        monarranges = workArrangeDao.findByQuery("from WorkArrange where week=? and year=? and dow=? order by starttime", week.toString(), year.toString(), "2");
        tusarranges = workArrangeDao.findByQuery("from WorkArrange where week=? and year=? and dow=? order by starttime", week.toString(), year.toString(), "3");
        wedarranges = workArrangeDao.findByQuery("from WorkArrange where week=? and year=? and dow=? order by starttime", week.toString(), year.toString(), "4");
        thearranges = workArrangeDao.findByQuery("from WorkArrange where week=? and year=? and dow=? order by starttime", week.toString(), year.toString(), "5");
        friarranges = workArrangeDao.findByQuery("from WorkArrange where week=? and year=? and dow=? order by starttime", week.toString(), year.toString(), "6");
        satarranges = workArrangeDao.findByQuery("from WorkArrange where week=? and year=? and dow=? order by starttime", week.toString(), year.toString(), "7");
        sunarranges = workArrangeDao.findByQuery("from WorkArrange where week=? and year=? and dow=? order by starttime", week.toString(), year.toString(), "1");


        Page<Bulletin> page = new Page<Bulletin>(5, true);
        if (null != pageno) {
            page.setPageNo(pageno);
        }
        else {
            pageno = page.getPageNo();
        }
        page = bulletinDao.findPageByQuery(page, "from Bulletin order by starttime desc");
        bulletins = page.getResult();

        totalpages = page.getTotalPages();

        query1 = messageDao.findByQuery("from Message where flag = 'workflow' and receiver.id=? and (status is null or status is false) order by id desc", user.getId());
        count1 = query1.size();
        if (count1 > 0) {
            message1 = query1.get(0);
        }
        else {
            message1 = new Message();
        }

        query2 = messageDao.findByQuery("from Message where flag = 'caruse' and receiver.id=? and (status is null or status is false) order by id desc", user.getId());
        count2 = query2.size();
        if (count2 > 0){
            message2 = query2.get(0);
        }
        else {
            message2 = new Message();
        }

        query3 = messageDao.findByQuery("from Message where flag = 'demand' and receiver.id=? and (status is null or status is false) order by id desc", user.getId());
        count3 = query3.size();
        if (count3 > 0){
            message3 = query3.get(0);
        }
        else {
            message3 = new Message();
        }

        query4 = messageDao.findByQuery("from Message where flag is null and receiver.id=? and (status is null or status is false) ", user.getId());
        count4 = query4.size();

        return super.execute();    //To change body of overridden methods use File | Settings | File Templates.
    }

    private List<Message> query1;
    private List<Message> query2;
    private List<Message> query3;
    private List<Message> query4;

    Message message1;
    Message message2;
    Message message3;
    Message message4;

    public Message getMessage1() {
        return message1;
    }

    public void setMessage1(Message message1) {
        this.message1 = message1;
    }

    public Message getMessage2() {
        return message2;
    }

    public void setMessage2(Message message2) {
        this.message2 = message2;
    }

    public Message getMessage3() {
        return message3;
    }

    public void setMessage3(Message message3) {
        this.message3 = message3;
    }

    public Message getMessage4() {
        return message4;
    }

    public void setMessage4(Message message4) {
        this.message4 = message4;
    }

    public List<Message> getQuery1() {
        return query1;
    }

    public void setQuery1(List<Message> query1) {
        this.query1 = query1;
    }

    public List<Message> getQuery2() {
        return query2;
    }

    public void setQuery2(List<Message> query2) {
        this.query2 = query2;
    }

    public List<Message> getQuery3() {
        return query3;
    }

    public void setQuery3(List<Message> query3) {
        this.query3 = query3;
    }

    public List<Message> getQuery4() {
        return query4;
    }

    public void setQuery4(List<Message> query4) {
        this.query4 = query4;
    }

    private Integer count1;

    private Integer count2;

    private Integer count3;

    private Integer count4;

    public Integer getCount1() {
        return count1;
    }

    public void setCount1(Integer count1) {
        this.count1 = count1;
    }

    public Integer getCount2() {
        return count2;
    }

    public void setCount2(Integer count2) {
        this.count2 = count2;
    }

    public Integer getCount3() {
        return count3;
    }

    public void setCount3(Integer count3) {
        this.count3 = count3;
    }

    public Integer getCount4() {
        return count4;
    }

    public void setCount4(Integer count4) {
        this.count4 = count4;
    }
}