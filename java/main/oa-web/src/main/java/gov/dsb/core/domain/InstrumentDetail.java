package gov.dsb.core.domain;

import gov.dsb.core.domain.base.IdEntity;

import javax.persistence.*;
import java.sql.Timestamp;
import java.sql.SQLSyntaxErrorException;

/**
 * Created with IntelliJ IDEA.
 * User: harryzan
 * Timestamp: 9/16/12
 * Time: 4:24 PM
 * To change this template use File | Settings | File Templates.
 */
@Entity
public class InstrumentDetail extends IdEntity {

    private Long id;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
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

    private Instrument instrument;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "INSTRUMENTID", referencedColumnName = "ID")
    public Instrument getInstrument() {
        return instrument;
    }

    public void setInstrument(Instrument instrument) {
        this.instrument = instrument;
    }
}
