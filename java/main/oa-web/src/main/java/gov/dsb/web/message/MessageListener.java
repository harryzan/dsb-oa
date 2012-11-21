package gov.dsb.web.message;

import gov.dsb.core.dao.BulletinDao;
import gov.dsb.core.dao.DocDocumentDao;
import gov.dsb.core.dao.MessageDao;
import gov.dsb.core.dao.SysUserDao;
import gov.dsb.core.domain.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Collection;

/**
 * Created with IntelliJ IDEA.
 * User: zhanyonglin
 * Date: 12-11-21
 * Time: 下午4:31
 * To change this template use File | Settings | File Templates.
 */
@Service
public class MessageListener implements Listener {

    @Autowired
    public SysUserDao sysUserDao;

    @Autowired
    public MessageDao messageDao;

    @Override
    public void notice(Collection<SysUser> sysUsers, Bulletin bulletin) {
        //To change body of implemented methods use File | Settings | File Templates.
    }

    @Override
    public void notice(Collection<SysUser> sysUsers, DocDocument docDocument) {
        //To change body of implemented methods use File | Settings | File Templates.
    }

    @Override
    public void notice(Collection<SysUser> sysUsers, CarUse carUse) {
        //To change body of implemented methods use File | Settings | File Templates.
    }

    @Override
    public void notice(Collection<SysUser> sysUsers, Demand demand) {
        //To change body of implemented methods use File | Settings | File Templates.
    }

    @Override
    public void notice(Collection<SysUser> sysUsers, WorkArrange workArrange) {
        //To change body of implemented methods use File | Settings | File Templates.
    }
}
