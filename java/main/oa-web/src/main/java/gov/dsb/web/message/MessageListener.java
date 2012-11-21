package gov.dsb.web.message;

import gov.dsb.core.dao.MessageDao;
import gov.dsb.core.dao.SysUserDao;
import gov.dsb.core.domain.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
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
        for (SysUser sysUser : sysUsers) {
            Message message = new Message();

            message.setName(bulletin.getName());
            long current = System.currentTimeMillis();
            message.setStarttime(new Timestamp(current));
            message.setDescription("/message/bulletin/bulletin!view?id=" + bulletin.getId());
            message.setReceiver(sysUser);

            messageDao.save(message);
        }
    }

    @Override
    public void notice(Collection<SysUser> sysUsers, DocDocument docDocument) {
        for (SysUser sysUser : sysUsers) {
            Message message = new Message();

            message.setName(docDocument.getName());
            long current = System.currentTimeMillis();
            message.setStarttime(new Timestamp(current));
            message.setDescription("/document/docdocument/doc-document?id=" + docDocument.getId());
            message.setReceiver(sysUser);

            messageDao.save(message);
        }
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
