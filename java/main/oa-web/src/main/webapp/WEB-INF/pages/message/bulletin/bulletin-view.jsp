<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2009-5-15
  Time: 12:21:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<%--<%@ include file="/common/metaMocha.jsp" %>--%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>公告信息查看</title>
<link href="${themesPath}/css/gdmp.css" rel="stylesheet" type="text/css">
<%--<script type="text/javascript" src="${scriptsPath}/system/function.js"></script>--%>
</head>

<body>
<table width="766" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td colspan="3"><img src="${themesPath}/images/gdmp_1.jpg" /></td>
    </tr>
    <tr>
        <td width="96" background="${themesPath}/images/gdmp_2.jpg">&nbsp;</td>
        <td width="634" valign="top">
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td colspan="2" bgcolor="#FFFFFF"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td height="50" valign="middle" align="center" class="gdmp_title">${name}</td>
                    </tr>
                    <tr>
                        <td valign="top" class="gdmp_text"><table width="100%" border="0" cellpadding="0" cellspacing="0" background="${themesPath}/images/gdmp_title1.png">
                            <tr>
                                <td height="5"></td>
                            </tr>
                        </table></td>
                    </tr>
                </table></td>
            </tr>
            <tr>
                <td width="344" height="50" valign="top" bgcolor="#FFFFFF" class="gdmp_text"></td>
                <td width="290" valign="top" bgcolor="#FFFFFF" class="gdmp_text" align="right"></td>
            </tr>
            <tr>
                <td height="500" colspan="2" valign="top" bgcolor="#FFFFFF" class="gdmp_text">${description}</td>
            </tr>

        </table></td>
        <td width="36" background="${themesPath}/images/gdmp_3.jpg">&nbsp;</td>
    </tr>
    <tr>
        <td height="28" colspan="3"><img src="${themesPath}/images/gdmp_4.jpg" /></td>
    </tr>
</table>
</body>
</html>
