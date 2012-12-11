<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2009-5-15
  Time: 12:21:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%--<%@ include file="/common/taglibs.jsp"%>--%>
<%--<%@ include file="/common/metaMocha.jsp" %>--%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>公告信息查看</title>
<%--<link href="${themesPath}/css/style.css" rel="stylesheet" type="text/css">--%>
<%--<script type="text/javascript" src="${scriptsPath}/system/function.js"></script>--%>
</head>

<body>
<table width="90%" border="0" align="center" cellpadding="0" cellspacing="1">
    <tr>
        <%--<td width="30%"><div align="right">标题：</div></td>--%>
        <td width="100%" align="center" valign="top">&nbsp;${name}</td>
    </tr>
    <%--<tr class="textone12">--%>
    <%--<td><div align="right">发布时间：</div></td>--%>
    <%--<td>&nbsp;${starttime}</td>--%>
    <%--</tr>--%>
    <%--<tr class="textone1">--%>
    <%--<td><div align="right">结束时间：</div></td>--%>
    <%--<td>&nbsp;${endtime}</td>--%>
    <%--</tr>--%>
    <tr>
        <%--<td><div align="right">内容：</div></td>--%>
        <td align="center" valign="top">&nbsp;${description}</td>
    </tr>
</table>
</body>
</html>
