package gov.dsb.web.action.gh;

import gov.dsb.core.dao.GhDao;
import gov.dsb.core.dao.GhTypeDao;
import gov.dsb.core.domain.Gh;
import gov.dsb.core.domain.GhType;
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
    private GhTypeDao ghTypeDao;

    @Autowired
    private GhDao ghDao;


    private Collection<GhType> ghTypes;

    public Collection<GhType> getGhTypes() {
        return ghTypes;
    }

    public void setGhTypes(Collection<GhType> ghTypes) {
        this.ghTypes = ghTypes;
    }

    public Collection<Gh> ghs1;

    public Collection<Gh> ghs2;

    public Collection<Gh> ghs3;

    public Collection<Gh> ghs4;

    public Collection<Gh> ghs5;

    public Collection<Gh> ghs6;

    public Collection<Gh> ghs7;

    public Collection<Gh> getGhs1() {
        return ghs1;
    }

    public void setGhs1(Collection<Gh> ghs1) {
        this.ghs1 = ghs1;
    }

    public Collection<Gh> getGhs2() {
        return ghs2;
    }

    public void setGhs2(Collection<Gh> ghs2) {
        this.ghs2 = ghs2;
    }

    public Collection<Gh> getGhs3() {
        return ghs3;
    }

    public void setGhs3(Collection<Gh> ghs3) {
        this.ghs3 = ghs3;
    }

    public Collection<Gh> getGhs4() {
        return ghs4;
    }

    public void setGhs4(Collection<Gh> ghs4) {
        this.ghs4 = ghs4;
    }

    public Collection<Gh> getGhs5() {
        return ghs5;
    }

    public void setGhs5(Collection<Gh> ghs5) {
        this.ghs5 = ghs5;
    }

    public Collection<Gh> getGhs6() {
        return ghs6;
    }

    public void setGhs6(Collection<Gh> ghs6) {
        this.ghs6 = ghs6;
    }

    public Collection<Gh> getGhs7() {
        return ghs7;
    }

    public void setGhs7(Collection<Gh> ghs7) {
        this.ghs7 = ghs7;
    }

    private Long typeid;

    public Long getTypeid() {
        return typeid;
    }

    public void setTypeid(Long typeid) {
        this.typeid = typeid;
    }

    @Override
    public String execute() throws Exception {
//        ghTypes = ghTypeDao.findByQuery("from GhType where parent is null");

        if (typeid == null)
            ghs1 = ghDao.findByQuery("from Gh order by id desc");
        else
            ghs1 = ghDao.findByQuery("from Gh where ghType.id=? order by id desc", typeid);
//
        GhType type = ghTypeDao.findUnique("from GhType where name='首页'");
        if (type != null) {
           ghTypes = type.getChildren();
        }
//        if (type != null) {
//            ghs2 = type.getGhs();
//        }
//
//        type = ghTypeDao.findUnique("from GhType where name='学习型党组织建设'");
//        if (type != null) {
//            ghs3 = type.getGhs();
//        }
//
//        type = ghTypeDao.findUnique("from GhType where name='创先争优'");
//        if (type != null) {
//            ghs4 = type.getGhs();
//        }
//
//        type = ghTypeDao.findUnique("from GhType where name='文件下载'");
//        if (type != null) {
//            ghs5 = type.getGhs();
//        }
//
//        type = ghTypeDao.findUnique("from GhType where name='机关文化'");
//        if (type != null) {
//            ghs6 = type.getGhs();
//        }
//
//        type = ghTypeDao.findUnique("from GhType where name='机关文化'");
//        if (type != null) {
//            ghs7 = type.getGhs();
//        }

        return SUCCESS;
    }
}
