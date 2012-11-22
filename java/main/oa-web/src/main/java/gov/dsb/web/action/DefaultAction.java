package gov.dsb.web.action;

import gov.dsb.core.dao.SysLogDao;
import gov.dsb.core.domain.SysLog;
import gov.dsb.core.domain.SysUser;
import gov.dsb.core.struts2.SimpleActionSupport;
import gov.dsb.web.security.UserSession;
import gov.dsb.web.security.UserSessionService;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.sql.Timestamp;

/**
 * Created by IntelliJ IDEA.
 * User: harry
 * Date: 2009-10-16
 * Time: 16:12:12
 * To change this template use File | Settings | File Templates.
 */
@ParentPackage("default")
//@Results({@Result(name = SimpleActionSupport.SUCCESS, location = "/default", type = "redirect")})
public class DefaultAction extends SimpleActionSupport {

    private String loginname;

    private String loginpass;

    private String url;

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    //    private String url;


    public void setLoginname(String loginname) {
        this.loginname = loginname;
    }

    public void setLoginpass(String loginpass) {
        this.loginpass = loginpass;
    }

}
