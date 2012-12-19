package gov.dsb.web.action.common;

import gov.dsb.core.dao.MessageDao;
import gov.dsb.core.dao.SysLogDao;
import gov.dsb.core.dao.SysPrivilegeDao;
import gov.dsb.core.dao.SysUserDao;
import gov.dsb.core.domain.*;
import gov.dsb.core.struts2.SimpleActionSupport;
import gov.dsb.core.utils.CryptUtil;
import gov.dsb.core.utils.StringHelp;
import gov.dsb.web.security.UserSession;
import gov.dsb.web.security.UserSessionService;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.Timestamp;
import java.util.Collection;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: xiejiao
 * Date: 2009-11-17
 * Time: 16:19:26
 */
@ParentPackage("default")
public class Intouch2Action extends SimpleActionSupport {

    @Autowired
    private SysUserDao sysUserEntityService;

    @Autowired
    private UserSessionService userSessionService;


    private SysUser user;

    public SysUser getUser() {
        return user;
    }

    public void setUser(SysUser user) {
        this.user = user;
    }

    @Override
    public String execute() throws Exception {
        user = userSessionService.getCurrentSysUser();
        return super.execute();    //To change body of overridden methods use File | Settings | File Templates.
    }
}
