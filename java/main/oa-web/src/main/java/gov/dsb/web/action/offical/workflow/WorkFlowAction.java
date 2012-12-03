package gov.dsb.web.action.offical.workflow;

import gov.dsb.core.dao.DocDocumentDao;
import gov.dsb.core.dao.WorkFlowDao;
import gov.dsb.core.dao.SysUserDao;
import gov.dsb.core.domain.DocDocument;
import gov.dsb.core.domain.DocDocumentAttach;
import gov.dsb.core.domain.WorkFlow;
import gov.dsb.core.domain.SysUser;
import gov.dsb.core.struts2.CRUDActionSupport;
import gov.dsb.core.struts2.SimpleActionSupport;
import gov.dsb.core.utils.StringHelp;
import gov.dsb.web.message.MessageListener;
import gov.dsb.web.security.UserSessionService;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import java.sql.Timestamp;
import java.util.Collection;

/**
 * Created by IntelliJ IDEA.
 * User: cxs
 * Date: 2010-4-1
 * Time: 14:11:53
 * To change this template use File | Settings | File Templates.
 */

@ParentPackage("default")
@Results({@Result(name = CRUDActionSupport.RELOAD, location = "work-flow-grid", type = "chain"),
        @Result(name = SimpleActionSupport.SUCCESS, location = "/WEB-INF/pages/common/ajaxutilData.jsp")})
public class WorkFlowAction extends CRUDActionSupport<WorkFlow> {

    @Autowired
    private WorkFlowDao service;

    @Autowired
    private SysUserDao sysUserEntityService;

    @Autowired
    private UserSessionService userSessionService;

    @Autowired
    private MessageListener messageListener;



    @Autowired
    private DocDocumentDao docDocumentEntityService;

    protected Long id;

    private String checkuserid;

    public String getCheckuserid() {
        return checkuserid;
    }

    public void setCheckuserid(String checkuserid) {
        this.checkuserid = checkuserid;
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

    private String modifyuserid;

    public String getModifyuserid() {
        return modifyuserid;
    }

    public void setModifyuserid(String modifyuserid) {
        this.modifyuserid = modifyuserid;
    }

    private String typeuserid;

    public String getTypeuserid() {
        return typeuserid;
    }

    public void setTypeuserid(String typeuserid) {
        this.typeuserid = typeuserid;
    }

    private String collateuserid;

    public String getCollateuserid() {
        return collateuserid;
    }

    public void setCollateuserid(String collateuserid) {
        this.collateuserid = collateuserid;
    }

    private String signuserid;

    public String getSignuserid() {
        return signuserid;
    }

    public void setSignuserid(String signuserid) {
        this.signuserid = signuserid;
    }

    private String allsignuserid;

    public String getAllsignuserid() {
        return allsignuserid;
    }

    public void setAllsignuserid(String allsignuserid) {
        this.allsignuserid = allsignuserid;
    }

    private String senduserid;

    public String getSenduserid() {
        return senduserid;
    }

    public void setSenduserid(String senduserid) {
        this.senduserid = senduserid;
    }

    private String ccuserid;

    public String getCcuserid() {
        return ccuserid;
    }

    public void setCcuserid(String ccuserid) {
        this.ccuserid = ccuserid;
    }

    private String ctuserid;

    public String getCtuserid() {
        return ctuserid;
    }

    public void setCtuserid(String ctuserid) {
        this.ctuserid = ctuserid;
    }

    private String printuserid;

    public String getPrintuserid() {
        return printuserid;
    }

    public void setPrintuserid(String printuserid) {
        this.printuserid = printuserid;
    }

    private String backinput;

    public String getBackinput() {
        return backinput;
    }

    public void setBackinput(String backinput) {
        this.backinput = backinput;
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

        if(documentid != null){
            DocDocument document = docDocumentEntityService.get(documentid);
            entity.setDocdocument(document);
        }

//        System.out.println("backinput = " + backinput);

        if ("1".equals(backinput)) {
            entity.setStep(entity.getStep() - 1);
        }
        else {
            entity.setStep(entity.getStep() + 1);
        }

        if (entity.getStep() == 9) {
            entity.setStatus(true);
        }
        else if (entity.getStep() == 1) {
            if ("1".equals(backinput)) {
                entity.setTargetuser(entity.getWriteuser());
            }
        }
        else if (entity.getStep() == 2) {
            if (StringHelp.isNotEmpty(checkuserid)) {
                SysUser targetuser = sysUserEntityService.get(Long.parseLong(checkuserid));
                entity.setTargetuser(targetuser);
                entity.setCheckuser(targetuser);
            }
            if ("1".equals(backinput)) {
                entity.setTargetuser(entity.getCheckuser());
            }
            messageListener.notice(entity.getTargetuser(), entity);
        }
        else if (entity.getStep() == 3) {
            if (StringHelp.isNotEmpty(modifyuserid)) {
                SysUser targetuser = sysUserEntityService.get(Long.parseLong(modifyuserid));
                entity.setTargetuser(targetuser);
                entity.setModifyuser(targetuser);
            }
            if ("1".equals(backinput)) {
                entity.setTargetuser(entity.getModifyuser());
            }
            messageListener.notice(entity.getTargetuser(), entity);
        }
        else if (entity.getStep() == 4) {
            if (StringHelp.isNotEmpty(typeuserid)) {
                SysUser targetuser = sysUserEntityService.get(Long.parseLong(typeuserid));
                entity.setTargetuser(targetuser);
                entity.setTypeuser(targetuser);
            }
            if ("1".equals(backinput)) {
                entity.setTargetuser(entity.getTypeuser());
            }
            messageListener.notice(entity.getTargetuser(), entity);
        }
        else if (entity.getStep() == 5) {
            if (StringHelp.isNotEmpty(collateuserid)) {
                SysUser targetuser = sysUserEntityService.get(Long.parseLong(collateuserid));
                entity.setTargetuser(targetuser);
                entity.setCollateuser(targetuser);
            }
            if ("1".equals(backinput)) {
                entity.setTargetuser(entity.getCollateuser());
            }
            messageListener.notice(entity.getTargetuser(), entity);
        }
        else if (entity.getStep() == 6) {
            if (StringHelp.isNotEmpty(signuserid)) {
                SysUser targetuser = sysUserEntityService.get(Long.parseLong(signuserid));
                entity.setTargetuser(targetuser);
                entity.setSignuser(targetuser);
            }
            if ("1".equals(backinput)) {
                entity.setTargetuser(entity.getSignuser());
            }
            messageListener.notice(entity.getTargetuser(), entity);
        }
        else if (entity.getStep() == 7) {
            if (StringHelp.isNotEmpty(allsignuserid)) {
                SysUser targetuser = sysUserEntityService.get(Long.parseLong(allsignuserid));
                entity.setTargetuser(targetuser);
                entity.setAllsignuser(targetuser);
            }
            if ("1".equals(backinput)) {
                entity.setTargetuser(entity.getAllsignuser());
            }
            messageListener.notice(entity.getTargetuser(), entity);
        }
        else if (entity.getStep() == 8) {
            if (StringHelp.isNotEmpty(printuserid)) {
                SysUser targetuser = sysUserEntityService.get(Long.parseLong(printuserid));
                entity.setPrintuser(targetuser);
                entity.setTargetuser(targetuser);
                messageListener.notice(entity.getTargetuser(), entity);
            }
            if (StringHelp.isNotEmpty(senduserid)) {
                SysUser senduser = sysUserEntityService.get(Long.parseLong(senduserid));
                entity.setSenduser(senduser);
                messageListener.notice(entity.getSenduser(), entity);
            }
            if (StringHelp.isNotEmpty(ccuserid)) {
                SysUser ccuser = sysUserEntityService.get(Long.parseLong(ccuserid));
                entity.setCcuser(ccuser);
                messageListener.notice(entity.getCcuser(), entity);
            }
            if (StringHelp.isNotEmpty(ctuserid)) {
                SysUser ctuser = sysUserEntityService.get(Long.parseLong(ctuserid));
                entity.setCtuser(ctuser);
                messageListener.notice(entity.getCtuser(), entity);
            }
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

    public String  print() throws Exception {
        prepareModel();
        return "print";
    }

    protected void prepareModel() throws Exception {
        if (entity == null) {
            SysUser currentUser = userSessionService.getCurrentSysUser();

            if (id != null) {
                entity = service.get(id);

                DocDocument document = entity.getDocdocument();
                if(document != null) {
                    attachs = document.getDocdocumentattaches();
                }

                if (entity.getTargetuser().getId().equals(currentUser.getId())) {
                    admin = true;
                }
                else {
                    admin = false;
                }
            } else {
                entity = new WorkFlow();

                entity.setStep(1);
                entity.setWriteuser(currentUser);
                entity.setWritedept(currentUser.getSysdept());

                entity.setStatus(false);
//                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//                Date now = new Date(System.currentTimeMillis());
//                entity.setStarttime(sdf.format(now));
            }
        }

    }

    private Boolean admin;

    public Boolean getAdmin() {
        return admin;
    }

    public void setAdmin(Boolean admin) {
        this.admin = admin;
    }

    public String view() throws Exception {
        return VIEW;
    }

    public String input() throws Exception {
        if (admin)
            return INPUT;
        else
            return view();
    }

    public WorkFlow getModel() {
        return entity;
    }
}
