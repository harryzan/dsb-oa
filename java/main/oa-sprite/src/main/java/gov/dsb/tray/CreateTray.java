package gov.dsb.tray;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpMethod;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.URIException;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.httpclient.util.URIUtil;
import org.apache.commons.lang.StringUtils;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

/**
 * 使java application生成托盘图标的例子
 * 本代码在JDK1.6上,Win2003平台上测试通过
 *
 * @author:NetJava.cn
 */
public class CreateTray {
    /**
     * 创建单实列
     */
    public static CreateTray instance() {
        if (null == ct) {
            ct = new CreateTray();
        }
        return ct;
    }

    //测试
    public static void main(String[] args) throws InterruptedException {
        CreateTray ct = instance();
        //工作目录下使用的tray图标文件
        PopupMenu pop = ct.createPopup();
        if (!ct.CreteTrayIcon("OA小精灵", pop)) {
            System.out.println("不能创建托盘");
        }

//         System.out.println("start");
        while (true) {
            ct.updateTray();

            Thread.sleep(1000 * 60);
        }
    }

    public static String doGet(String url, String queryString, String charset, boolean pretty) {
        StringBuffer response = new StringBuffer();
        HttpClient client = new HttpClient();
        HttpMethod method = new GetMethod(url);
        try {
            if (StringUtils.isNotBlank(queryString))
                //对get请求参数做了http请求默认编码，好像没有任何问题，汉字编码后，就成为%式样的字符串
                method.setQueryString(URIUtil.encodeQuery(queryString));
            client.executeMethod(method);
            if (method.getStatusCode() == HttpStatus.SC_OK) {
                BufferedReader reader = new BufferedReader(new InputStreamReader(method.getResponseBodyAsStream(), charset));
                String line;
                while ((line = reader.readLine()) != null) {
                    if (pretty)
                        response.append(line).append(System.getProperty("line.separator"));
                    else
                        response.append(line);
                }
                reader.close();
            }
        } catch (URIException e) {
//             logger.error("执行HTTP Get请求时，编码查询字符串“" + queryString + "”发生异常！", e);
        } catch (IOException e) {
//             log.error("执行HTTP Get请求" + url + "时，发生异常！", e);
        } finally {
            method.releaseConnection();
        }
        return response.toString();
    }

    private TrayIcon trayIcon;

    public TrayIcon getTrayIcon() {
        return trayIcon;
    }

    public void setTrayIcon(TrayIcon trayIcon) {
        this.trayIcon = trayIcon;
    }

    public void updateTray() {
        String returnvalue = doGet("http://localhost:8080/oa/common/util/ajax-util!messagecount?username=" + username + "&password=" + password, null, "GBK", true);

        if (StringUtils.isNotEmpty(returnvalue) && Integer.parseInt(returnvalue.trim()) > 0) {
            PopupMenu popupMenu = trayIcon.getPopupMenu();
            int itemCount = popupMenu.getItemCount();

            MenuItem menuMessage = popupMenu.getItem(itemCount - 1);
            menuMessage.setLabel("Message(" + returnvalue.trim() + ")");
            ActionListener messageListener = new ActionListener() {
                public void actionPerformed(ActionEvent e) {
                    try {
                        String url = "http://localhost:8080/oa/login?loginname=" + username + "&loginpass=" + password + "&url=/oa/message/message/message-grid?messagestatus=false";
                        Runtime.getRuntime().exec("explorer.exe " + "\"" + url + "\"");
                    } catch (IOException e1) {
                        e1.printStackTrace();
                    }
                }
            };
            menuMessage.addActionListener(messageListener);
            popupMenu.remove(itemCount - 1);
            popupMenu.add(menuMessage);
            trayIcon.setPopupMenu(popupMenu);
            trayIcon.displayMessage("短消息", "新短消息提醒", TrayIcon.MessageType.INFO);
        }
        else {
            PopupMenu popupMenu = trayIcon.getPopupMenu();
            int itemCount = popupMenu.getItemCount();

            MenuItem menuMessage = popupMenu.getItem(itemCount - 1);
            menuMessage.setLabel("Message");
            ActionListener messageListener = new ActionListener() {
                public void actionPerformed(ActionEvent e) {
                    try {
                        String url = "http://localhost:8080/oa/login?loginname=" + username + "&loginpass=" + password + "&url=/oa/message/message/message-grid?messagestatus=false";
                        Runtime.getRuntime().exec("explorer.exe " + "\"" + url + "\"");
                    } catch (IOException e1) {
                        e1.printStackTrace();
                    }
                }
            };
            menuMessage.addActionListener(messageListener);
            popupMenu.remove(itemCount - 1);
            popupMenu.add(menuMessage);
            trayIcon.setPopupMenu(popupMenu);
//            trayIcon.displayMessage("短消息", "新短消息提醒", TrayIcon.MessageType.INFO);
        }

    }

    /**
     * 创建tray,如成功返回true值
     *
     * @para trayImage:创建tray图标的图片文件名
     * @para trayName:tray显示名字
     * @para popup 这个tray上的PopupMenu
     */
    public boolean CreteTrayIcon(String trayName, PopupMenu popup) {
        String url = this.getClass().getClassLoader().getResource("gov/dsb/tray").getPath();

        boolean isCreated = false;
//         final  TrayIcon trayIcon;
        if (SystemTray.isSupported()) {
            SystemTray tray = SystemTray.getSystemTray();
            Image image = Toolkit.getDefaultToolkit().getImage(url + "/tray.gif");
            trayIcon = new TrayIcon(image, trayName, popup);
            trayIcon.setImageAutoSize(true);
            //创建一个Action监听器:左键双击事件
//             final  ActionListener al = new ActionListener() {
//                 public void actionPerformed(ActionEvent e) {
//                     trayIcon.displayMessage("托盘事件", "这个双击事件己收到", TrayIcon.MessageType.INFO);
//                 }
//             };
//             trayIcon.addActionListener(al);
            try {
                tray.add(trayIcon);
                isCreated = true;
            } catch (AWTException e) {
                System.err.println("无法创建托盘:" + e);
                isCreated = false;
            }

            username = JOptionPane.showInputDialog("请输入您的用户名：");
            password = JOptionPane.showInputDialog("请输入您的密码：");
        }
        return isCreated;
    }

    private String username;

    private String password;

    /**
     * 创建这个tray上的右键弹出式菜单
     */
    public PopupMenu createPopup() {
        PopupMenu popup = new PopupMenu();
        MenuItem menuExit = new MenuItem("exit");
        MenuItem menuOpen = new MenuItem("login");
        MenuItem menuMessage = new MenuItem("message");
//         MenuItem menuCancel = new MenuItem("cancel");
        //创建退出菜单监听器
        ActionListener exitListener = new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                System.exit(0);
            }
        };
        //创建打开监听器
        ActionListener openListener = new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                username = JOptionPane.showInputDialog("请输入您的用户名：");
                password = JOptionPane.showInputDialog("请输入您的密码：");
            }
        };
        menuExit.addActionListener(exitListener);
        menuOpen.addActionListener(openListener);
        popup.add(menuOpen);
//         popup.add(menuCancel);
        popup.add(menuExit);
        popup.add(menuMessage);
        return popup;
    }

    private CreateTray() {
    }


    private static CreateTray ct = null;
}