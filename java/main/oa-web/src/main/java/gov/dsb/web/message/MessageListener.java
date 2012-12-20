package gov.dsb.web.message;

import gov.dsb.core.dao.MessageDao;
import gov.dsb.core.dao.SysRoleDao;
import gov.dsb.core.dao.SysUserDao;
import gov.dsb.core.domain.*;
import gov.dsb.core.utils.StringHelp;
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

    @Autowired
    private SysRoleDao sysRoleDao;

    @Override
    public void notice(Collection<SysUser> sysUsers, String content) {


    }

    @Override
    public void notice(Collection<SysUser> sysUsers, Bulletin bulletin) {
        for (SysUser sysUser : sysUsers) {
            Message message = new Message();

            message.setType("公告通知");
            message.setName(bulletin.getName());
            long current = System.currentTimeMillis();
            message.setStarttime(new Timestamp(current));
            message.setDescription("/message/bulletin/bulletin!view?id=" + bulletin.getId());
            message.setReceiver(sysUser);

            message.setSystem(true);

            messageDao.save(message);
        }
    }

    @Override
    public void notice(Collection<SysUser> sysUsers, DocDocument docDocument) {
        for (SysUser sysUser : sysUsers) {
            Message message = new Message();

            message.setType("文档共享");
            message.setName(docDocument.getName());
            long current = System.currentTimeMillis();
            message.setStarttime(new Timestamp(current));
            message.setDescription("/document/docdocument/doc-document?id=" + docDocument.getId());
            message.setReceiver(sysUser);

            message.setSystem(true);

            messageDao.save(message);
        }
    }

    @Override
    public void notice(Collection<SysUser> sysUsers, CarUse carUse) {
        for (SysUser sysUser : sysUsers) {
            Message message = new Message();

            message.setType("用车申请");
            message.setFlag("caruse");
            long current = System.currentTimeMillis();
            message.setStarttime(new Timestamp(current));
            message.setReceiver(sysUser);
            message.setSystem(true);

            if (!carUse.getStatus()) {
                message.setName("用车申请待处理");
                message.setDescription("/oa/car/car-check!input?id=" + carUse.getId());
                messageDao.save(message);
            }
            else {
                if (StringHelp.isEmpty(carUse.getFlag())) {
                    message.setName("用车申请已通过");
                    message.setDescription("/oa/car/car-complete?id=" + carUse.getId());
                    messageDao.save(message);


                    SysRole role = sysRoleDao.findUnique("from SysRole where name=?", "车辆负责人");
                    Collection<SysUser> users = role.getSysuserroles();
                    for (SysUser user : users) {
                        message = new Message();
                        message.setType("用车申请");
                        message.setFlag("caruse");
                        message.setStarttime(new Timestamp(current));
                        message.setReceiver(user);
                        message.setSystem(true);
                        message.setName("用车申请待安排");
                        message.setDescription("/oa/car/car-drive!input?id=" + carUse.getId());
                        messageDao.save(message);
                    }
                }
                else {
                    message.setName("用车申请已安排");
                    message.setDescription("/oa/car/car-complete?id=" + carUse.getId());
                    messageDao.save(message);
                }
            }
        }
    }

    @Override
    public void notice(Collection<SysUser> sysUsers, Demand demand) {
        for (SysUser sysUser : sysUsers) {
            Message message = new Message();

            message.setType(demand.getType().getName() + "申请");
            message.setFlag("demand");
            long current = System.currentTimeMillis();
            message.setStarttime(new Timestamp(current));
            message.setReceiver(sysUser);
            message.setSystem(true);

            if (!demand.getStatus()) {
                message.setName(demand.getType().getName() + "申请待处理");
                message.setDescription("/oa/demand/demand-check!input?id=" + demand.getId());
                messageDao.save(message);
            }
            else {
                if (StringHelp.isEmpty(demand.getFlag())) {
                    message.setName(demand.getType().getName() + "申请已通过");
                    message.setDescription("/oa/demand/demand-complete?id=" + demand.getId());
                    messageDao.save(message);


                    SysUser user = demand.getType().getUser();
                    message = new Message();
                    message.setType(demand.getType().getName() + "申请");
                    message.setFlag("demand");
                    message.setStarttime(new Timestamp(current));
                    message.setReceiver(user);
                    message.setSystem(true);
                    message.setName(demand.getType().getName() + "申请待安排");
                    message.setDescription("/oa/demand/demand-app!input?id=" + demand.getId());
                    messageDao.save(message);
                }
                else {
                    message.setName(demand.getType().getName() + "申请已安排");
                    message.setDescription("/oa/demand/demand-complete?id=" + demand.getId());
                    messageDao.save(message);
                }
            }
        }
    }

    @Override
    public void notice(Collection<SysUser> sysUsers, WorkArrange workArrange) {
        for (SysUser sysUser : sysUsers) {
            Message message = new Message();

            message.setType("一周工作安排");
            message.setName(workArrange.getYear() + "年第" + workArrange.getWeek() + "周工作安排");
            long current = System.currentTimeMillis();
            message.setStarttime(new Timestamp(current));
            message.setDescription("/message/workarrange/work-arrange!week");
            message.setReceiver(sysUser);

            message.setSystem(true);

            messageDao.save(message);
        }
    }

    @Override
    public void notice(Collection<SysUser> sysUsers, WorkFlow workFlow) {
        for (SysUser sysUser : sysUsers) {
            notice(sysUser, workFlow);
        }
    }

    @Override
    public void notice(SysUser sysUser, WorkFlow workFlow) {
        Message message = new Message();

        message.setType("发文管理");
        message.setFlag("workflow");
        message.setName("处理 " + workFlow.getTitle());
        long current = System.currentTimeMillis();
        message.setStarttime(new Timestamp(current));
        message.setDescription("/offical/workflow/work-flow!input?id=" + workFlow.getId());
        message.setReceiver(sysUser);

        message.setSystem(true);
        messageDao.save(message);
    }
}
