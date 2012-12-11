package gov.dsb.web.action.policy.policy;

import gov.dsb.core.dao.DocCategoryDao;
import gov.dsb.core.dao.DocDocumentDao;
import gov.dsb.core.dao.base.Page;
import gov.dsb.core.domain.DocCategory;
import gov.dsb.core.domain.DocDocument;
import gov.dsb.core.domain.DocDocumentAttach;
import gov.dsb.core.struts2.PageActionSupport;
import gov.dsb.core.utils.Nulls;
import gov.dsb.core.utils.StringHelp;
import gov.dsb.web.ui.grid.Grid;
import gov.dsb.web.ui.grid.QueryTranslateWeight;
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
 * User: Administrator
 * Date: 2009-7-14
 * Time: 16:04:04
 * To change this template use File | Settings | File Templates.
 */

@ParentPackage("default")
@Results({@Result(name = PageActionSupport.GRIDDATA, location = "/WEB-INF/pages/common/gridData.jsp"),
        @Result(name = "data", location = "/WEB-INF/pages/common/ajaxutilData.jsp")})
public class DocDocumentGridAction extends PageActionSupport<DocDocument> {

    @Autowired
    private DocDocumentDao service;

    @Autowired
    private DocCategoryDao docCategoryDao;

    private String columns;

    private Integer start;

    private Integer limit;

    private String conditions;

    private List<Row> rows;

    private String gridParams;
    //////

    private Long doccategoryid;

    private String queryCondition;

    public String getQueryCondition() {
        return queryCondition;
    }

    public void setQueryCondition(String queryCondition) {
        this.queryCondition = queryCondition;
    }

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

    public Long getDoccategoryid() {
        return doccategoryid;
    }

    public void setDoccategoryid(Long doccategoryid) {
        this.doccategoryid = doccategoryid;
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
            page = new Page<DocDocument>(limit, true);
        } else {
            page = new Page<DocDocument>(10, true);
        }

        if (!Nulls.isNull(start) && !Nulls.isNull(limit)) {
            int pageNo = start / limit + 1;
            page.setPageNo(pageNo);
        }
        if (null != doccategoryid) {
            DocCategory docCategory = docCategoryDao.get(doccategoryid);
            queryCondition = "文件夹为 \"" + docCategory.getName() + "\"";
        }
        String hql = "from DocDocument where doccategory.id=?";
        if (!StringHelp.isEmpty(conditions)) {
            QueryTranslateWeight queryTranslate = new QueryTranslateWeight(hql, conditions);
            hql = queryTranslate.toString();
        }

        // System.out.println("queryCondition: "+ queryCondition);
        hql += " order by createtime desc";


        page = service.findPageByQuery(page, hql, doccategoryid);
        if (page.getResult() != null) {
            Collection<DocDocumentAttach> attachs = new ArrayList<DocDocumentAttach>();
            for (DocDocument doc : page.getResult()) {
                attachs = doc.getDocdocumentattaches();
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
                    doc.setDescription(doc.getDescription() + desc);
                }


            }
        }

        rows = Grid.gridValue2Rows(page.getResult(), columns);

        return GRIDDATA;
    }

    private String result;

    public String getResult() {
        return result;
    }

    public String execute() {
        DocCategory doccategory = docCategoryDao.findUnique("from DocCategory category where category.code = 'guizhangzhidu' and category.issystem is true  and category.parent is null order by category.orderno");
        if (doccategory != null) {
            doccategoryid = doccategory.getId();
        }

        return SUCCESS;
    }

}