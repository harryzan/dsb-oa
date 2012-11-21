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
        for (SysUser sysUser : sysUsers) {
            Message message = new Message();

            long current = System.currentTimeMillis();
            message.setStarttime(new Timestamp(current));
            if (carUse.getStatus()) {
                message.setName("车辆申请审核");
                message.setDescription("/oa/car/car-check-grid");
            }
            else {
                message.setName("车辆申请通过");
                message.setDescription("/oa/car/car-complete-grid");
            }
            message.setReceiver(sysUser);

            messageDao.save(message);
        }
    }

    @Override
    public void notice(Collection<SysUser> sysUsers, Demand demand) {
        for (SysUser sysUser : sysUsers) {
            Message message = new Message();

            long current = System.currentTimeMillis();
            message.setStarttime(new Timestamp(current));
            if (demand.getStatus()) {
                message.setName(demand.getName() + "申请审核");
                message.setDescription("/oa/demand/demand-check-grid");
            }
            else {
                message.setName(demand.getName() + "申请通过");
                message.setDescription("/oa/demand/demand-complete-grid");
            }
            message.setReceiver(sysUser);

            messageDao.save(message);
        }
    }

    @Override
    public void notice(Collection<SysUser> sysUsers, WorkArrange workArrange) {
        for (SysUser sysUser : sysUsers) {
            Message message = new Message();

            message.setName(workArrange.getYear() + "年第" + workArrange.getWeek() + "周工作安排");
            long current = System.currentTimeMillis();
            message.setStarttime(new Timestamp(current));
            message.setDescription("/");
            message.setReceiver(sysUser);

            messageDao.save(message);
        }
    }
}
