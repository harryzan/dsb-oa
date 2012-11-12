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
public class Instrument extends IdEntity {

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

    private SysUser createuser;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "CREATEUSERID", referencedColumnName = "ID")
    public SysUser getCreateuser() {
        return createuser;
    }

    public void setCreateuser(SysUser user) {
        this.createuser = user;
    }

    private SysUser updateuser;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "UPDATEUSERID", referencedColumnName = "ID")
    public SysUser getUpdateuser() {
        return updateuser;
    }

    public void setUpdateuser(SysUser updateuser) {
        this.updateuser = updateuser;
    }

    private SysUser targetuser;


    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "TARGETUSERID", referencedColumnName = "ID")
    public SysUser getTargetuser() {
        return targetuser;
    }

    public void setTargetuser(SysUser targetuser) {
        this.targetuser = targetuser;
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

    private InstrumentDetail currentdetail;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "CURRENTDETAILID", referencedColumnName = "ID")
    public InstrumentDetail getCurrentdetail() {
        return currentdetail;
    }

    public void setCurrentdetail(InstrumentDetail currentdetail) {
        this.currentdetail = currentdetail;
    }

    private Collection<InstrumentDetail> instrumentDetails;

    @OneToMany(mappedBy = "instrument")
    public Collection<InstrumentDetail> getInstrumentDetails() {
        return instrumentDetails;
    }

    public void setInstrumentDetails(Collection<InstrumentDetail> instrumentDetails) {
        this.instrumentDetails = instrumentDetails;
    }
}
