package gov.dsb.core.domain;

import gov.dsb.core.domain.base.IdEntity;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.Collection;

/**
 * Created with IntelliJ IDEA.
 * User: harryzan
 * Timestamp: 9/16/12
 * Time: 4:24 PM
 * To change this template use File | Settings | File Templates.
 */
@Entity
public class WorkFlow extends IdEntity {

    private Long id;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    private String title;

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    private Timestamp createdate;

    public Timestamp getCreatedate() {
        return createdate;
    }

    public void setCreatedate(Timestamp createdate) {
        this.createdate = createdate;
    }

    private Timestamp updatedate;

    public Timestamp getUpdatedate() {
        return updatedate;
    }

    public void setUpdatedate(Timestamp updatedate) {
        this.updatedate = updatedate;
    }

    private String content;

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
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

    private Integer step;

    public Integer getStep() {
        return step;
    }

    public void setStep(Integer step) {
        this.step = step;
    }

    private String workno;

    public String getWorkno() {
        return workno;
    }

    public void setWorkno(String workno) {
        this.workno = workno;
    }

    private String fast;

    public String getFast() {
        return fast;
    }

    public void setFast(String fast) {
        this.fast = fast;
    }

    private String security;

    public String getSecurity() {
        return security;
    }

    public void setSecurity(String security) {
        this.security = security;
    }

    private String signdate;

    public String getSigndate() {
        return signdate;
    }

    public void setSigndate(String signdate) {
        this.signdate = signdate;
    }

    private String allsigndate;

    public String getAllsigndate() {
        return allsigndate;
    }

    public void setAllsigndate(String allsigndate) {
        this.allsigndate = allsigndate;
    }

    private Integer num;

    public Integer getNum() {
        return num;
    }

    public void setNum(Integer num) {
        this.num = num;
    }

    private String keyword;

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    private SysUser createuser;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "CREATEUSERID", referencedColumnName = "ID")
    public SysUser getCreateuser() {
        return createuser;
    }

    public void setCreateuser(SysUser user) {
        this.createuser = user;
    }

    private SysUser updateuser;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "UPDATEUSERID", referencedColumnName = "ID")
    public SysUser getUpdateuser() {
        return updateuser;
    }

    public void setUpdateuser(SysUser updateuser) {
        this.updateuser = updateuser;
    }

    private SysUser targetuser;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "TARGETUSERID", referencedColumnName = "ID")
    public SysUser getTargetuser() {
        return targetuser;
    }

    public void setTargetuser(SysUser targetuser) {
        this.targetuser = targetuser;
    }

    private SysUser signuser;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "SIGNUSERID", referencedColumnName = "ID")
    public SysUser getSignuser() {
        return signuser;
    }

    public void setSignuser(SysUser signuser) {
        this.signuser = signuser;
    }

    private SysUser allsignuser;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "ALLSIGNUSERID", referencedColumnName = "ID")
    public SysUser getAllsignuser() {
        return allsignuser;
    }

    public void setAllsignuser(SysUser allsignuser) {
        this.allsignuser = allsignuser;
    }

    private SysUser senduser;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "SENDUSERID", referencedColumnName = "ID")
    public SysUser getSenduser() {
        return senduser;
    }

    public void setSenduser(SysUser senduser) {
        this.senduser = senduser;
    }

    private SysUser ccuser;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "CCUSERID", referencedColumnName = "ID")
    public SysUser getCcuser() {
        return ccuser;
    }

    public void setCcuser(SysUser ccuser) {
        this.ccuser = ccuser;
    }

    private SysUser ctuser;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "CTUSERID", referencedColumnName = "ID")
    public SysUser getCtuser() {
        return ctuser;
    }

    public void setCtuser(SysUser ctuser) {
        this.ctuser = ctuser;
    }

    private SysUser writeuser;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "WRITEUSERID", referencedColumnName = "ID")
    public SysUser getWriteuser() {
        return writeuser;
    }

    public void setWriteuser(SysUser writeuser) {
        this.writeuser = writeuser;
    }

    private SysUser checkuser;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "CHECKUSERID", referencedColumnName = "ID")
    public SysUser getCheckuser() {
        return checkuser;
    }

    public void setCheckuser(SysUser checkuser) {
        this.checkuser = checkuser;
    }

    private SysUser modifyuser;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "MODIFYUSERID", referencedColumnName = "ID")
    public SysUser getModifyuser() {
        return modifyuser;
    }

    public void setModifyuser(SysUser modifyuser) {
        this.modifyuser = modifyuser;
    }

    private SysUser typeuser;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "TYPEUSERID", referencedColumnName = "ID")
    public SysUser getTypeuser() {
        return typeuser;
    }

    public void setTypeuser(SysUser typeuser) {
        this.typeuser = typeuser;
    }

    private SysUser collateuser;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "COLLATEUSERID", referencedColumnName = "ID")
    public SysUser getCollateuser() {
        return collateuser;
    }

    public void setCollateuser(SysUser collateuser) {
        this.collateuser = collateuser;
    }

    private SysUser printuser;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "PRINTUSERID", referencedColumnName = "ID")
    public SysUser getPrintuser() {
        return printuser;
    }

    public void setPrintuser(SysUser printuser) {
        this.printuser = printuser;
    }

    private SysDept writedept;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "WRITEDEPTID", referencedColumnName = "ID")
    public SysDept getWritedept() {
        return writedept;
    }

    public void setWritedept(SysDept writedept) {
        this.writedept = writedept;
    }

    private DocDocument docdocument;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "DOCID", referencedColumnName = "ID")
    public DocDocument getDocdocument() {
        return docdocument;
    }

    public void setDocdocument(DocDocument docdocument) {
        this.docdocument = docdocument;
    }
}
