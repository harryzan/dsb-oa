<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>无标题文档</title>
    <link href="${themesPath}/css/style.css" rel="stylesheet" type="text/css" />
    <base target="mainFrame">
</head>

<body>
<div class="Header">
    <div class="logo">
        <div class="title"><img src="${themesPath}/images/title_1.jpg" width="568" height="76" /></div>
        <div class="right"><br />
            <br />
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td><table width="98%" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td><img src="${themesPath}/images/xgmm.png" width="15" height="14" /></td>
                            <td><a href="download/setup.exe"  class="titlelj">小精灵下载</a></td>
                        </tr>
                    </table></td>
                    <td><table width="98%" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td><img src="${themesPath}/images/xgmm.png" width="15" height="14" /></td>
                            <td><a href="#" onclick="window.parent.location='${ctx}/system/sysuser/sys-user!updatepwd'" class="titlelj">修改密码</a></td>
                        </tr>
                    </table></td>
                    <td><table width="98%" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td><img src="${themesPath}/images/bzzx.png" width="15" height="14" /></td>
                            <td><a href="#" class="titlelj">帮助中心</a></td>
                        </tr>
                    </table></td>
                    <td><table width="98%" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td><img src="${themesPath}/images/fhsy.png" width="15" height="14" /></td>
                            <td><a href="#" onclick="window.parent.location='${ctx}/default';" class="titlelj">返回首页</a></td>
                        </tr>
                    </table></td>
                    <td><table width="98%" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td><img src="${themesPath}/images/tcxt.png" width="15" height="14" /></td>
                            <td><a href="#" onclick="window.parent.location='${ctx}/login!logout';" class="titlelj">退出系统</a></td>
                        </tr>
                    </table></td>
                </tr>
            </table>
        </div>
    </div>

    <div class="nav">
        <div class="mingcheng">
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                    <td width="3%" nowrap="nowrap">&nbsp;&nbsp;<img src="${themesPath}/images/users.png" width="25" height="28" />&nbsp;</td>
                    <td width="97%">欢迎您，${user.displayname}</td>
                </tr>
            </table>
        </div>
        <div class="caidan">
            <ul>
                <li class="n1"><a href="${ctx}/common/intouch2" target="_blank">电子邮件</a></li>
                <li class="n1"><a href="${ctx}/message/message/message-main">短消息</a></li>
                <li class="n1"><a href="${ctx}/policy/policy/doc-document-grid!main">规章制度</a></li>
                <li class="n1"><a href="${ctx}/offical/workflow/work-flow-main">发文管理</a></li>
                <%--<li class="n1"><a href="#">需求申请</a></li>--%>
                <li class="n1"><a href="http://10.0.0.2:2000/" target="_blank">资料库链接</a></li>
                <li class="n1"><a href="${ctx}/dw/index" target="_blank">机关党委</a></li>
                <li class="n1"><a href="${ctx}/gh/index" target="_blank">机关工会</a></li>
                <li class="n1"><a href="${ctx}/common/jforum" target="_blank">BBS论坛</a></li>
            </ul>
        </div>
    </div>
</div>
<div class="clr"></div>
</body>
</html>
