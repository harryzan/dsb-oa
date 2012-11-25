package gov.dsb.web.action.dw;

import gov.dsb.core.dao.DocDocumentDao;
import gov.dsb.core.dao.DwDao;
import gov.dsb.core.dao.base.Page;
import gov.dsb.core.domain.DocDocument;
import gov.dsb.core.domain.DocDocumentAttach;
import gov.dsb.core.domain.Dw;
import gov.dsb.core.domain.SysUser;
import gov.dsb.core.struts2.PageActionSupport;
import gov.dsb.core.utils.Nulls;
import gov.dsb.core.utils.StringHelp;
import gov.dsb.web.security.UserSessionService;
import gov.dsb.web.ui.grid.Grid;
import gov.dsb.web.ui.grid.QueryTranslate;
import gov.dsb.web.ui.grid.Row;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: cxs
 * Date: 2010-4-1
 * Time: 14:15:48
 * To change this template use File | Settings | File Templates.
 */

@ParentPackage("default")
@Results({@Result(name = PageActionSupport.GRIDDATA, location = "/WEB-INF/pages/common/gridData.jsp")})
public class DwGridAction extends PageActionSupport<Dw> {

    @Autowired
    private DwDao service;

    @Autowired
    private UserSessionService userSessionService;

    @Autowired
    private DocDocumentDao docDocumentDao;

    private Long typeid;

    public Long getTypeid() {
        return typeid;
    }

    public void setTypeid(Long typeid) {
        this.typeid = typeid;
    }

    private String columns;

    private Integer start;

    private Integer limit;

    private String conditions;

    private List<Row> rows;

    private String gridParams;

    public void setColumns(String columns) {
        this.columns = columns;
    }

    public void setStart(Integer start) {
        this.start = start;
    }

    public void setLimit(Integer limit) {
        this.limit = limit;
    }

    public void setConditions(String conditions) {
        this.conditions = conditions;
    }

    public List<Row> getRows() {
        return rows;
    }

    public String getGridParams() {
        return gridParams;
    }

    public void setGridParams(String gridParams) {
        this.gridParams = gridParams;
    }


    public void prepare() throws Exception {
        if (gridParams == null) {
            gridParams = "";
        }
    }

    public String list() throws Exception {
        return SUCCESS;
    }

    public String griddata() throws Exception {
        if (!Nulls.isNull(limit) && limit > 0) {
            page = new Page<Dw>(limit, true);
        } else {
            page = new Page<Dw>(10, true);
        }

        if (!Nulls.isNull(start) && !Nulls.isNull(limit)) {
            int pageNo = start / limit + 1;
            page.setPageNo(pageNo);
        }
        SysUser user = userSessionService.getCurrentSysUser();
        if (user == null) {
            throw new RuntimeException("注意：请先登录系统！");
        }

//        String s = "Select t from Student t left join t.books b where   \n" +
//                "exists　( select b.new from b where b.student = t )    \n" +
//                "and true=all( select b.new from b where b.student = t )";

        String hql = "from Dw where dwType.id=?";
        System.out.println("typeid = " + typeid);
//        if (bulletinstatus)
//            hql += " where endtime < to_char(sysdate)";
//        else
//            hql += " where endtime >= to_char(sysdate)";
        if (!StringHelp.isEmpty(conditions)) {
            QueryTranslate queryTranslate = new QueryTranslate(hql, conditions);
            page = service.findPageByQuery(page, queryTranslate.toString() + " order by starttime desc", typeid);
        } else {
            page = service.findPageByQuery(page, hql + " order by starttime desc", typeid);
        }
        List<Dw> list = page.getResult();
        System.out.println("list.size() = " + list.size());

        if (page.getResult() != null) {
            Collection<DocDocumentAttach> attachs = new ArrayList<DocDocumentAttach>();
            for (Dw dw : page.getResult()) {
                if (dw.getDocdocument() != null) {
                    DocDocument docDocument = docDocumentDao.get(dw.getDocdocument().getId());
                    attachs = docDocument.getDocdocumentattaches();
                    if (attachs != null && attachs.size() > 0) {
                        String desc = "";
                        desc += "?";
                        //doc.setDescription() + "?");
                        for (DocDocumentAttach attach : attachs) {
                            //doc.setDescription(doc.getDescription() + attach.getId() + ":" + attach.getFilename() +",");
                            desc += attach.getId() + ":" + attach.getFilename() + ",";
                        }
                        if (desc.endsWith(",")) {
                            desc = desc.substring(0, desc.length() - 1);
                        }
                        dw.setMemo(dw.getMemo() + desc);
                    }
                }
            }
        }

        rows = Grid.gridValue2Rows(page.getResult(), columns);
        return GRIDDATA;
    }
}