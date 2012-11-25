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
public class IndexAction extends SimpleActionSupport {

    @Autowired
    private DwTypeDao dwTypeDao;

    @Autowired
    private DwDao dwDao;


    private List<DwType> dwTypes;

    public List<DwType> getDwTypes() {
        return dwTypes;
    }

    public void setDwTypes(List<DwType> dwTypes) {
        this.dwTypes = dwTypes;
    }

    public Collection<Dw> dws1;

    public Collection<Dw> dws2;

    public Collection<Dw> dws3;

    public Collection<Dw> dws4;

    public Collection<Dw> dws5;

    public Collection<Dw> dws6;

    public Collection<Dw> dws7;

    public Collection<Dw> getDws1() {
        return dws1;
    }

    public void setDws1(Collection<Dw> dws1) {
        this.dws1 = dws1;
    }

    public Collection<Dw> getDws2() {
        return dws2;
    }

    public void setDws2(Collection<Dw> dws2) {
        this.dws2 = dws2;
    }

    public Collection<Dw> getDws3() {
        return dws3;
    }

    public void setDws3(Collection<Dw> dws3) {
        this.dws3 = dws3;
    }

    public Collection<Dw> getDws4() {
        return dws4;
    }

    public void setDws4(Collection<Dw> dws4) {
        this.dws4 = dws4;
    }

    public Collection<Dw> getDws5() {
        return dws5;
    }

    public void setDws5(Collection<Dw> dws5) {
        this.dws5 = dws5;
    }

    public Collection<Dw> getDws6() {
        return dws6;
    }

    public void setDws6(Collection<Dw> dws6) {
        this.dws6 = dws6;
    }

    public Collection<Dw> getDws7() {
        return dws7;
    }

    public void setDws7(Collection<Dw> dws7) {
        this.dws7 = dws7;
    }

    @Override
    public String execute() throws Exception {
        dwTypes = dwTypeDao.findByQuery("from DwType where parent is null");

        DwType type = dwTypeDao.findUnique("from DwType where name='近期动态'");
        if (type != null) {
            dws1 = type.getDws();
        }

        type = dwTypeDao.findUnique("from DwType where name='支部生活'");
        if (type != null) {
            dws2 = type.getDws();
        }

        type = dwTypeDao.findUnique("from DwType where name='学习型党组织建设'");
        if (type != null) {
            dws3 = type.getDws();
        }

        type = dwTypeDao.findUnique("from DwType where name='创先争优'");
        if (type != null) {
            dws4 = type.getDws();
        }

        type = dwTypeDao.findUnique("from DwType where name='文件下载'");
        if (type != null) {
            dws5 = type.getDws();
        }

        type = dwTypeDao.findUnique("from DwType where name='机关文化'");
        if (type != null) {
            dws6 = type.getDws();
        }

        type = dwTypeDao.findUnique("from DwType where name='机关文化'");
        if (type != null) {
            dws7 = type.getDws();
        }

        return SUCCESS;
    }
}
