package gov.dsb.core.domain;

import gov.dsb.core.domain.base.IdEntity;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import javax.persistence.*;
import java.sql.Date;
import java.util.Collection;

/**
 * Created with IntelliJ IDEA.
 * User: harryzan
 * Date: 9/16/12
 * Time: 4:24 PM
 * To change this template use File | Settings | File Templates.
 */
@Entity
public class DemandType extends IdEntity {

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

    private String desc;

    @Column(name = "DESCRIPTION", length = 4000)
    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
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

    private String type;

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    private String userids;

    public String getUserids() {
        return userids;
    }

    public void setUserids(String userids) {
        this.userids = userids;
    }

    private String usernames;

    public String getUsernames() {
        return usernames;
    }

    public void setUsernames(String usernames) {
        this.usernames = usernames;
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

    private Collection<SysUser> demandtypeusers;

    @ManyToMany()
    @JoinTable(name = "DEMANDTYPE_USER",
            joinColumns = @JoinColumn(name = "TYPEID", referencedColumnName = "ID", nullable = false),
            inverseJoinColumns = @JoinColumn(name = "USERID", referencedColumnName = "ID",
                    nullable = false))
    public Collection<SysUser> getDemandtypeusers() {
        return demandtypeusers;
    }

    public void setDemandtypeusers(Collection<SysUser> demandtypeusers) {
        this.demandtypeusers = demandtypeusers;
    }
}
