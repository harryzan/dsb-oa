package gov.dsb.web.action;

import gov.dsb.core.dao.SysUserDao;
import gov.dsb.core.domain.SysUser;
import gov.dsb.core.struts2.SimpleActionSupport;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.springframework.beans.factory.annotation.Autowired;

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
    SysUserDao sysUserDao;

    @Override
    public String execute() throws Exception {

        SysUser sysUser = sysUserDao.findUnique("from SysUser where loginname='admin'");
        if (sysUser != null && sysUser.getProfile().equals("2")) {
            return "2";
        }

        return SUCCESS;
    }
}
