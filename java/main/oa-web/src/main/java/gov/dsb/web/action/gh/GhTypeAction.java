package gov.dsb.web.action.gh;

import gov.dsb.core.dao.GhTypeDao;
import gov.dsb.core.domain.GhType;
import gov.dsb.core.struts2.CRUDActionSupport;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 2009-7-5
 * Time: 12:15:18
 * To change this template use File | Settings | File Templates.
 */

@ParentPackage("default")
@Results({@Result(name = CRUDActionSupport.RELOAD, location = "sys-privilege", type = "chain"),
        @Result(name = CRUDActionSupport.DELETE, location = "/common/blank", type = "redirect")})
public class GhTypeAction extends CRUDActionSupport<GhType> {

    @Autowired
    private GhTypeDao service;

    protected Long id;

    private Long parentid;

    private Long privilegetypeid;

//    private Collection<SysCodeList> colprivilegetype;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getParentid() {
        return parentid;
    }

    public void setParentid(Long parentid) {
        this.parentid = parentid;
    }

    public Long getPrivilegetypeid() {
        return privilegetypeid;
    }

    public void setPrivilegetypeid(Long privilegetypeid) {
        this.privilegetypeid = privilegetypeid;
    }

    public String save() throws Exception {
        service.save(entity);

        return VIEW;
    }

    public String delete() throws Exception {
        service.delete(id);
        return DELETE;
    }


    public String view() throws Exception {
        return VIEW;
    }

    protected void prepareModel() throws Exception {
        if (entity == null) {
            if (id != null) {
                entity = service.get(id);
            } else {
                entity = new GhType();
            }
        }
        if (parentid != null) {
            GhType parent = service.get(parentid);
            entity.setParent(parent);
        }

//        colprivilegetype = sysCodeEntityService.findCodeList("privilegetype");
    }

    public GhType getModel() {
        return entity;
    }
}
