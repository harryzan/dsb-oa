package gov.dsb.web.action.common;

import gov.dsb.core.dao.SysUserDao;
import gov.dsb.core.domain.SysUser;
import gov.dsb.core.struts2.SimpleActionSupport;
import gov.dsb.web.security.UserSessionService;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * Created by IntelliJ IDEA.
 * User: xiejiao
 * Date: 2009-11-17
 * Time: 16:19:26
 */
@ParentPackage("default")
public class JforumAction extends SimpleActionSupport {

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
