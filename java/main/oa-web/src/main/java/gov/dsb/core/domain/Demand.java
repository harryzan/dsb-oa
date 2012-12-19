package gov.dsb.core.domain;

import gov.dsb.core.domain.base.IdEntity;

import javax.persistence.*;

/**
 * Created with IntelliJ IDEA.
 * User: harryzan
 * String: 9/16/12
 * Time: 4:24 PM
 * To change this template use File | Settings | File Templates.
 */
@Entity
public class Demand extends IdEntity {

    private Long id;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    private String name;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    private String demanddate;

    public String getDemanddate() {
        return demanddate;
    }

    public void setDemanddate(String demanddate) {
        this.demanddate = demanddate;
    }

    private String submitdate;

    public String getSubmitdate() {
        return submitdate;
    }

    public void setSubmitdate(String submitdate) {
        this.submitdate = submitdate;
    }

    private String checkdate;

    public String getCheckdate() {
        return checkdate;
    }

    public void setCheckdate(String checkdate) {
        this.checkdate = checkdate;
    }

    private String desc;

    @Column(name = "DESCRIPTION", length = 4000)
    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    private String checkdesc;

    public String getCheckdesc() {
        return checkdesc;
    }

    public void setCheckdesc(String checkdesc) {
        this.checkdesc = checkdesc;
    }

    private Boolean status;

    @Basic
    @Column(name = "STATUS", length = 1)
    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }

    private String title;

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    private String startdate;

    public String getStartdate() {
        return startdate;
    }

    public void setStartdate(String startdate) {
        this.startdate = startdate;
    }

    private String enddate;

    public String getEnddate() {
        return enddate;
    }

    public void setEnddate(String enddate) {
        this.enddate = enddate;
    }

    private String room;

    public String getRoom() {
        return room;
    }

    public void setRoom(String room) {
        this.room = room;
    }

    private String attendance;

    public String getAttendance() {
        return attendance;
    }

    public void setAttendance(String attendance) {
        this.attendance = attendance;
    }

    private String flag;

    public String getFlag() {
        return flag;
    }

    public void setFlag(String flag) {
        this.flag = flag;
    }

    private String opinion;

    public String getOpinion() {
        return opinion;
    }

    public void setOpinion(String opinion) {
        this.opinion = opinion;
    }

    private String personnum;

    public String getPersonnum() {
        return personnum;
    }

    public void setPersonnum(String personnum) {
        this.personnum = personnum;
    }

    private String memo;

    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }

    private String remind;

    public String getRemind() {
        return remind;
    }

    public void setRemind(String remind) {
        this.remind = remind;
    }

    private String reminddate;

    public String getReminddate() {
        return reminddate;
    }

    public void setReminddate(String reminddate) {
        this.reminddate = reminddate;
    }

    private SysUser moderator;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "MODERATORID", referencedColumnName = "ID")
    public SysUser getModerator() {
        return moderator;
    }

    public void setModerator(SysUser moderator) {
        this.moderator = moderator;
    }

    private String memodate;

    public String getMemodate() {
        return memodate;
    }

    public void setMemodate(String memodate) {
        this.memodate = memodate;
    }

    private SysUser mainuser;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "MAINUSERID", referencedColumnName = "ID")
    public SysUser getMainuser() {
        return mainuser;
    }

    public void setMainuser(SysUser mainuser) {
        this.mainuser = mainuser;
    }

    private SysUser user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "USERID", referencedColumnName = "ID")
    public SysUser getUser() {
        return user;
    }

    public void setUser(SysUser user) {
        this.user = user;
    }

    private SysUser checker;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "CHECKERID", referencedColumnName = "ID")
    public SysUser getChecker() {
        return checker;
    }

    public void setChecker(SysUser checker) {
        this.checker = checker;
    }

    private SysUser memor;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "MEMORID", referencedColumnName = "ID")
    public SysUser getMemor() {
        return memor;
    }

    public void setMemor(SysUser memor) {
        this.memor = memor;
    }

    private SysUser reminder;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "REMINDERID", referencedColumnName = "ID")
    public SysUser getReminder() {
        return reminder;
    }

    public void setReminder(SysUser reminder) {
        this.reminder = reminder;
    }

    private DemandType type;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "TYPEID", referencedColumnName = "ID")
    public DemandType getType() {
        return type;
    }

    public void setType(DemandType type) {
        this.type = type;
    }
}
