package gov.dsb.web.action.dw;

import gov.dsb.core.dao.DwDao;
import gov.dsb.core.dao.DwTypeDao;
import gov.dsb.core.domain.Dw;
import gov.dsb.core.domain.DwType;
import gov.dsb.core.struts2.SimpleActionSupport;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Collection;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: harry
 * Date: 2009-10-16
 * Time: 16:12:12
 * To change this template use File | Settings | File Templates.
 */
@ParentPackage("default")
//@Results({@Result(name = SimpleActionSupport.SUCCESS, location = "/default", type = "redirect")})
public class ContentAction extends SimpleActionSupport {

    @Autowired
    private DwTypeDao dwTypeDao;

    @Autowired
    private DwDao dwDao;

    private Long tid;

    public Long getTid() {
        return tid;
    }

    public void setTid(Long tid) {
        this.tid = tid;
    }

    private List<DwType> dwTypes;

    public List<DwType> getDwTypes() {
        return dwTypes;
    }

    public void setDwTypes(List<DwType> dwTypes) {
        this.dwTypes = dwTypes;
    }

    private Collection<DwType> subDwTypes;

    public Collection<DwType> getSubDwTypes() {
        return subDwTypes;
    }

    public void setSubDwTypes(Collection<DwType> subDwTypes) {
        this.subDwTypes = subDwTypes;
    }

    private Long typeid;

    public Long getTypeid() {
        return typeid;
    }

    public void setTypeid(Long typeid) {
        this.typeid = typeid;
    }

    private List<Dw> dws;

    public List<Dw> getDws() {
        return dws;
    }

    public void setDws(List<Dw> dws) {
        this.dws = dws;
    }

    private String tname;

    public String getTname() {
        return tname;
    }

    public void setTname(String tname) {
        this.tname = tname;
    }

    private String name;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    private Long id;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    private Dw dw;

    public Dw getDw() {
        return dw;
    }

    public void setDw(Dw dw) {
        this.dw = dw;
    }

    @Override
    public String execute() throws Exception {
        dwTypes = dwTypeDao.findByQuery("from DwType where parent is null");

//        subDwTypes = dwTypeDao.findByQuery("from DwType where parent.id=?", tid);

        dw = dwDao.get(id);


        return SUCCESS;
    }
}
