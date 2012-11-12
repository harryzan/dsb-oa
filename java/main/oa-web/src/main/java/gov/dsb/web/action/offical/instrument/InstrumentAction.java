package gov.dsb.web.action.offical.instrument;

import gov.dsb.core.dao.DocDocumentDao;
import gov.dsb.core.dao.InstrumentDao;
import gov.dsb.core.dao.SysUserDao;
import gov.dsb.core.domain.DocDocument;
import gov.dsb.core.domain.DocDocumentAttach;
import gov.dsb.core.domain.Instrument;
import gov.dsb.core.domain.SysUser;
import gov.dsb.core.struts2.CRUDActionSupport;
import gov.dsb.core.struts2.SimpleActionSupport;
import gov.dsb.web.security.UserSessionService;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;

/**
 * Created by IntelliJ IDEA.
 * User: cxs
 * Date: 2010-4-1
 * Time: 14:11:53
 * To change this template use File | Settings | File Templates.
 */

@ParentPackage("default")
@Results({@Result(name = CRUDActionSupport.RELOAD, location = "instrument-grid", type = "chain"),
        @Result(name = SimpleActionSupport.SUCCESS, location = "/WEB-INF/pages/common/ajaxutilData.jsp")})
public class InstrumentAction extends CRUDActionSupport<Instrument> {

    @Autowired
    private InstrumentDao service;

    @Autowired
    private SysUserDao sysUserEntityService;

    @Autowired
    private UserSessionService userSessionService;


    @Autowired
    private DocDocumentDao docDocumentEntityService;

    protected Long id;

    private String tuserid;

    public String getTuserid() {
        return tuserid;
    }

    public void setTuserid(String tuserid) {
        this.tuserid = tuserid;
    }

    private String gridParam;

    public String getGridParam() {
        return gridParam;
    }

    public void setGridParam(String gridParam) {
        this.gridParam = gridParam;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    private Long documentid;

    public Long getDocumentid() {
        return documentid;
    }

    public void setDocumentid(Long documentid) {
        this.documentid = documentid;
    }

    private Collection<DocDocumentAttach> attachs;

    public Collection<DocDocumentAttach> getAttachs() {
        return attachs;
    }

    public void setAttachs(Collection<DocDocumentAttach> attachs) {
        this.attachs = attachs;
    }

    public String save() throws Exception {
//        System.out.println("121212121212121");
        SysUser user = userSessionService.getCurrentSysUser();
//        System.out.println("user.getDisplayname() = " + user.getDisplayname());
        Timestamp now = new Timestamp(System.currentTimeMillis());
//        System.out.println("now = " + now);

        if (entity.getId() == null) {
            entity.setCreateuser(user);
            entity.setCreatedate(now);
        }
        entity.setUpdateuser(user);
        entity.setUpdatedate(now);

//        System.out.println("tuserid = " + Long.getLong(tuserid));
        if (tuserid != null) {
            SysUser targetuser = sysUserEntityService.get(Long.parseLong(tuserid));
//            System.out.println("targetuser.getDisplayname() = " + targetuser.getDisplayname());
            entity.setTargetuser(targetuser);
        }

        if(documentid != null){
            DocDocument document = docDocumentEntityService.get(documentid);
            entity.setDocdocument(document);
        }
//        entity.setStarttime(new Timestamp(System.currentTimeMillis()));
//        if (entity.getSysuserbulletins() != null) {
//            entity.getSysuserbulletins().clear();
//        } else {
//            entity.setSysuserbulletins(new ArrayList<SysUser>());
//        }

        service.save(entity);
//        System.out.println("*********** save success");
        return RELOAD;
    }

    public String delete() throws Exception {
        service.delete(id);
        return RELOAD;
    }

    protected void prepareModel() throws Exception {
        if (entity == null) {
            if (id != null) {
                entity = service.get(id);

                DocDocument document = entity.getDocdocument();
                if(document != null) {
                    attachs = document.getDocdocumentattaches();
                }
            } else {
                entity = new Instrument();

//                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//                Date now = new Date(System.currentTimeMillis());
//                entity.setStarttime(sdf.format(now));
            }
        }

    }

    public String view() throws Exception {
        return VIEW;
    }

    public Instrument getModel() {
        return entity;
    }
}
