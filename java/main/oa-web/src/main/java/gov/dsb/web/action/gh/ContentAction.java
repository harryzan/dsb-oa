package gov.dsb.web.action.gh;

import gov.dsb.core.dao.GhCommentDao;
import gov.dsb.core.dao.GhDao;
import gov.dsb.core.dao.GhTypeDao;
import gov.dsb.core.dao.base.Page;
import gov.dsb.core.domain.Gh;
import gov.dsb.core.domain.GhComment;
import gov.dsb.core.domain.GhType;
import gov.dsb.core.domain.SysUser;
import gov.dsb.core.struts2.SimpleActionSupport;
import gov.dsb.web.security.UserSessionService;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import java.sql.Timestamp;
import java.util.Collection;

/**
 * Created by IntelliJ IDEA.
 * User: harry
 * Date: 2009-10-16
 * Time: 16:12:12
 * To change this template use File | Settings | File Templates.
 */
@ParentPackage("default")
//@Results({@Result(name = SimpleActionSupport.INPUT, location = "index", type = "redirect")})
public class ContentAction extends SimpleActionSupport {

    @Autowired
    private GhTypeDao ghTypeDao;

    @Autowired
    private GhDao ghDao;

    @Autowired
    private GhCommentDao ghCommentDao;

    private Long id;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    private Gh gh;

    public Gh getGh() {
        return gh;
    }

    public void setGh(Gh gh) {
        this.gh = gh;
    }

    private Collection<GhComment> ghComments;

    public Collection<GhComment> getGhComments() {
        return ghComments;
    }

    public void setGhComments(Collection<GhComment> ghComments) {
        this.ghComments = ghComments;
    }

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

    private Long tid;

    public Long getTid() {
        return tid;
    }

    public void setTid(Long tid) {
        this.tid = tid;
    }

    private Collection<GhType> types;

    public Collection<GhType> getTypes() {
        return types;
    }

    public void setTypes(Collection<GhType> types) {
        this.types = types;
    }

    @Override
    public String execute() throws Exception {

        gh = ghDao.get(id);

        comments = gh.getGhComments();

        ghTypes = ghTypeDao.findByQuery("from GhType where parent is null order by id");

        GhType type = null;
        if (tid != null) {
            type = ghTypeDao.get(tid);
            type = type.getParent();
        }
        else {
            type = ghTypeDao.findUnique("from GhType where name='首页'");
        }

//        ghs1 = gh.getGhType()

        types = type.getChildren();
//
//        if (typeid != null) {
//            ghs1 = ghDao.findByQuery("from Gh where ghType.id=? order by starttime desc", typeid);
//        }
//        else {
//            if (types.size() > 0) {
//                GhType ghType = types.iterator().next();
//                ghs1 = ghDao.findByQuery("from Gh where ghType.id=? order by starttime desc", ghType.getId());
//            }
//            else {
//                ghs1 = ghDao.findByQuery("from Gh where ghType.id=? order by starttime desc", type.getId());
//            }
//        }

        Page<Gh> page = new Page<Gh>(5);

        page = ghDao.findPageByQuery(page, "from Gh order by starttime desc");

        ghs2 = page.getResult();


        Page<GhComment> commentPage = new Page<GhComment>(5);

        commentPage = ghCommentDao.findPageByQuery(commentPage, "from GhComment order by starttime desc");

        ghComments = commentPage.getResult();

//        types = ghTypeDao.findByQuery("from GhType where parent is null");

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


    private Collection<GhComment> comments;

    public Collection<GhComment> getComments() {
        return comments;
    }

    public void setComments(Collection<GhComment> comments) {
        this.comments = comments;
    }

    @Autowired
    private UserSessionService userSessionService;

    private String content;

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String save() throws Exception {
        gh = ghDao.get(id);

        GhComment comment = new GhComment();

        SysUser user = userSessionService.getCurrentSysUser();

        comment.setDescription(content);
        comment.setCreateuser(user);
        comment.setStarttime(new Timestamp(System.currentTimeMillis()));

        comment.setGh(gh);

        ghCommentDao.save(comment);

        ghDao.refresh(gh);

//        return INPUT;
        return execute();
    }
}
