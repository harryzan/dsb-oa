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


        Page<Bulletin> page = new Page<Bulletin>(5);
        if (null != pageno) {
            page.setPageNo(pageno);
        }
        else {
            pageno = page.getPageNo();
        }
        bulletinDao.findPageByQuery(page, "from Bulletin order by starttime desc");
        bulletins = page.getResult();

        totalpages = page.getTotalPages();

        query1 = messageDao.findByQuery("from Message where flag = '发文管理' and receiver.id=? and (status is null or status is false) ", user.getId());
        count1 = query1.size();

        query2 = messageDao.findByQuery("from Message where flag = 'caruse' and receiver.id=? and (status is null or status is false) ", user.getId());
        count2 = query2.size();
        if (count2 > 0){
            Message message = query2.get(0);
            url2 = message.getId();
        }

        query3 = messageDao.findByQuery("from Message where flag = 'demand' and receiver.id=? and (status is null or status is false) ", user.getId());
        count3 = query3.size();
        if (count3 > 0){
            Message message = query3.get(0);
            url3 = message.getId();
        }

        query4 = messageDao.findByQuery("from Message where flag = '一周工作安排' and receiver.id=? and (status is null or status is false) ", user.getId());
        count4 = query4.size();

        return super.execute();    //To change body of overridden methods use File | Settings | File Templates.
    }

    private List<Message> query1;
    private List<Message> query2;
    private List<Message> query3;
    private List<Message> query4;

    private Long url1;
    private Long url2;
    private Long url3;
    private Long url4;

    public Long getUrl1() {
        return url1;
    }

    public void setUrl1(Long url1) {
        this.url1 = url1;
    }

    public Long getUrl2() {
        return url2;
    }

    public void setUrl2(Long url2) {
        this.url2 = url2;
    }

    public Long getUrl3() {
        return url3;
    }

    public void setUrl3(Long url3) {
        this.url3 = url3;
    }

    public Long getUrl4() {
        return url4;
    }

    public void setUrl4(Long url4) {
        this.url4 = url4;
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