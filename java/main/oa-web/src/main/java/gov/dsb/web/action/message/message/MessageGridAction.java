package gov.dsb.web.action.message.message;

import gov.dsb.core.dao.MessageDao;
import gov.dsb.core.dao.base.Page;
import gov.dsb.core.domain.Message;
import gov.dsb.core.domain.SysUser;
import gov.dsb.core.struts2.PageActionSupport;
import gov.dsb.core.utils.Nulls;
import gov.dsb.core.utils.StringHelp;
import gov.dsb.web.security.UserSessionService;
import gov.dsb.web.ui.grid.Grid;
import gov.dsb.web.ui.grid.QueryTranslate;
import gov.dsb.web.ui.grid.Row;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.OutputStream;
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
public class MessageGridAction extends PageActionSupport<Message> {

    @Autowired
    private MessageDao service;

    @Autowired
    private UserSessionService userSessionService;

    private Boolean messagestatus;

    public Boolean getMessagestatus() {
        return messagestatus;
    }

    public void setMessagestatus(Boolean messagestatus) {
        this.messagestatus = messagestatus;
    }

    private String columns;

    private Integer start;

    private Integer limit;

    private String conditions;

    private List<Row> rows;

    private String gridParams;

    private String type;

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
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
            page = new Page<Message>(limit, true);
        } else {
            page = new Page<Message>(20, true);
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
//        System.out.println("user.getId() = " + user.getId());

        String hql = "from Message where receiver.id=" + user.getId();

        if (StringHelp.isNotEmpty(type)) {
            hql += " and flag = '" + type + "' ";
        }

        if (messagestatus) {
            hql += " and status is true ";
        }
        else {
            hql += " and (status is null or status is false) ";
        }

        System.out.println("************** hql = " + hql);
//        if (bulletinstatus)
//            hql += " where endtime < to_char(sysdate)";
//        else
//            hql += " where endtime >= to_char(sysdate)";

//        System.out.println("hql = " + hql);
        if (!StringHelp.isEmpty(conditions)) {
            QueryTranslate queryTranslate = new QueryTranslate(hql, conditions);
            page = service.findPageByQuery(page, queryTranslate.toString() + " order by starttime desc");
        } else {
            page = service.findPageByQuery(page, hql + " order by starttime desc");
        }
        List<Message> list = page.getResult();
//        System.out.println("list.size() = " + list.size());

        rows = Grid.gridValue2Rows(list, columns);
        return GRIDDATA;
    }


}