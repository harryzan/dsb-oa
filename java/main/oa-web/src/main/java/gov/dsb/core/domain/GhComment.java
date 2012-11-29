package gov.dsb.core.domain;

import gov.dsb.core.domain.base.IdEntity;

import javax.persistence.*;
import java.sql.Timestamp;

/**
 * Created by IntelliJ IDEA.
 * User: harry
 * Date: 2009-5-6
 * Time: 15:22:36
 * To change this template use File | Settings | File Templates.
 */
@Entity
@Table(name = "GHCOMMENT")
public class GhComment extends IdEntity {

    private Long id;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    private Timestamp starttime;

    @Basic
    public Timestamp getStarttime() {
        return starttime;
    }

    public void setStarttime(Timestamp starttime) {
        this.starttime = starttime;
    }

    private String name;

    @Basic
    @Column(name = "NAME", length = 200)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    private String description;

    @Basic
    @Column(name = "DESCRIPTION", length = 4000)
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    private Boolean status;

    @Basic
    @Column(name = "STATUS", length = 10)
    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }

    private String endtime;

    @Basic
    @Column(name = "ENDTIME", length = 10)
    public String getEndtime() {
        return endtime;
    }

    public void setEndtime(String endtime) {
        this.endtime = endtime;
    }

    private String memo;

    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }

        GhComment bulletin = (GhComment) o;


        if (id != null ? !id.equals(bulletin.id) : bulletin.id != null) {
            return false;
        }
        if (name != null ? !name.equals(bulletin.name) : bulletin.name != null) {
            return false;
        }
        if (starttime != null ? !starttime.equals(bulletin.starttime) : bulletin.starttime != null) {
            return false;
        }
        if (description != null ? !description.equals(bulletin.description) : bulletin.description != null) {
            return false;
        }
        if (status != null ? !status.equals(bulletin.status) : bulletin.status != null) {
            return false;
        }
        if (endtime != null ? !endtime.equals(bulletin.endtime) : bulletin.endtime != null) {
            return false;
        }

        return true;
    }

    @Override
    public int hashCode() {
        int result = id != null ? id.hashCode() : 0;
        result = 31 * result + (starttime != null ? starttime.hashCode() : 0);
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (description != null ? description.hashCode() : 0);
        result = 31 * result + (status != null ? status.hashCode() : 0);
        result = 31 * result + (endtime != null ? endtime.hashCode() : 0);
        return result;
    }

    private SysUser createuser;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "CREATEUSERID", referencedColumnName = "ID")
    public SysUser getCreateuser() {
        return createuser;
    }

    public void setCreateuser(SysUser createuser) {
        this.createuser = createuser;
    }

    private Gh gh;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "GHID", referencedColumnName = "ID")
    public Gh getGh() {
        return gh;
    }

    public void setGh(Gh gh) {
        this.gh = gh;
    }
}