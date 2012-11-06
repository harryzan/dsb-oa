package gov.dsb.web.action;

import gov.dsb.core.dao.BulletinDao;
import gov.dsb.core.dao.WorkArrangeDao;
import gov.dsb.core.domain.Bulletin;
import gov.dsb.core.domain.DemandType;
import gov.dsb.core.domain.SysUser;
import gov.dsb.core.domain.WorkArrange;
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
public class TitleAction extends PageActionSupport<DemandType> {

    @Autowired
    private WorkArrangeDao workArrangeDao;

    @Autowired
    private BulletinDao bulletinDao;

    @Autowired
    private UserSessionService userSessionService;

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

    @Override
    public String execute() throws Exception {

        user = userSessionService.getCurrentSysUser();

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Calendar calendar = Calendar.getInstance();

        return super.execute();    //To change body of overridden methods use File | Settings | File Templates.
    }
}