package gov.dsb.web.message;

import gov.dsb.core.domain.*;

import java.sql.Timestamp;
import java.util.Collection;

/**
 * Created with IntelliJ IDEA.
 * User: zhanyonglin
 * Date: 12-11-21
 * Time: 下午3:56
 * To change this template use File | Settings | File Templates.
 */
public interface Listener {

    public void notice(Collection<SysUser> sysUsers, Bulletin bulletin);

    public void notice(Collection<SysUser> sysUsers, DocDocument docDocument);

    public void notice(Collection<SysUser> sysUsers, CarUse carUse);

    public void notice(Collection<SysUser> sysUsers, Demand demand);

    public void notice(Collection<SysUser> sysUsers, WorkArrange workArrange);

    public void notice(Collection<SysUser> sysUsers, WorkFlow workFlow);

    public void notice(SysUser sysUser, WorkFlow workFlow);
}
