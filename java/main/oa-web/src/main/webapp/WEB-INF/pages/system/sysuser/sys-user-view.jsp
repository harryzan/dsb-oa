<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2009-5-19
  Time: 10:18:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户信息查看</title>
<link href="${themesPath}/oldcss/style.css" rel="stylesheet" type="text/css">
</head>
    <script language="javascript">
        if (parent.tree_frame != null)
            parent.tree_frame.updateParent(parent.tree_frame.lastSelectedNode);
    </script>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<%--<table width="100%"  border="0" cellpadding="0" cellspacing="0">--%>
      <%--<tr>--%>
        <%--<td width="10" height="27" nowrap background="${themesPath}/oldimages/bgzuo.gif">&nbsp;</td>--%>
        <%--<td background="${themesPath}/oldimages/bgz.gif"><table width="100%" height="10"  border="0" align="right" cellpadding="0" cellspacing="2">--%>
            <%--<tr>--%>
              <%--<td width="20" class="textone">&nbsp;</td>--%>
              <%--<td height="23" valign="bottom" class="textone" align="center"><strong>维护用户信息</strong></td>--%>
              <%--<td width="20">&nbsp;</td>--%>
            <%--</tr>--%>
        <%--</table></td>--%>
        <%--<td width="10" height="27" nowrap background="${themesPath}/oldimages/bgyou.gif">&nbsp;</td>--%>
      <%--</tr>--%>
      <%--<tr>--%>
        <%--<td background="${themesPath}/oldimages/bgtua.gif">&nbsp;</td>--%>
        <%--<td valign="top" bgcolor="#eff6fe">--%>
        <table width="90%" height="100%" border="0" align="center" cellpadding="0" cellspacing="1">
                <tr>
                  <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="4" height="4" background="${themesPath}/oldimages/bg/shang.gif"><div align="right"><img src="${themesPath}/oldimages/bg/1.gif" width="4" height="4"></div></td>
                      <td height="4" background="${themesPath}/oldimages/bg/shang.gif"></td>
                      <td width="4" height="4" align="right"><img src="${themesPath}/oldimages/bg/2.gif" width="4" height="4"></td>
                    </tr>
                    <tr>
                      <td width="4" background="${themesPath}/oldimages/bg/zuo.gif"><img src="${themesPath}/oldimages/bg/zuo.gif" width="4" height="4"></td>
                      <td valign="top" bgcolor="#FFFFFF"><table width="100%" border="0" cellpadding="0" cellspacing="1">
                          <tr class="textone1">
                            <td colspan="2" class="text_title"><div align="center">用户信息查看</div></td>
                          </tr>
                          <tr class="textone1">
                            <td width="32%" align="right" class="textone1">用户名：</td>
                            <td width="68%" class="textone1">&nbsp;${loginname}</td>
                          </tr>
                          <tr class="textone12">
                            <td class="textone1"><div align="right">显示名：</div></td>
                            <td class="textone1">&nbsp;${displayname}</td>
                          </tr>
                          <tr class="textone1">
                            <td class="textone1"><div align="right">直线：</div></td>
                            <td class="textone1">&nbsp;${phonenumber}</td>
                          </tr>
                          <tr class="textone12">
                              <td class="textone1"><div align="right">分机：</div></td>
                              <td class="textone1">&nbsp;${subphone}</td>
                          </tr>
                          <tr class="textone1">
                              <td class="textone1"><div align="right">手机：</div></td>
                              <td class="textone1">&nbsp;${cellphone}</td>
                          </tr>
                          <tr class="textone12">
                            <td class="textone1"><div align="right">邮箱：</div></td>
                            <td class="textone1">&nbsp;${email}</td>
                          </tr>
                          <tr class="textone1">
                            <td class="textone1"><div align="right">状态：</div></td>
                            <td class="textone1">&nbsp;${status ? "激活" : "禁用"}</td>
                          </tr>
                        </table></td>
                      <td width="4" background="${themesPath}/oldimages/bg/you.gif"><img src="${themesPath}/oldimages/bg/you.gif" width="4" height="4"></td>
                    </tr>
                    <tr>
                      <td width="4" height="4" background="${themesPath}/oldimages/bg/xia.gif"><div align="right"><img src="${themesPath}/oldimages/bg/3.gif" width="4" height="4"></div></td>
                      <td height="4" background="${themesPath}/oldimages/bg/xia.gif"></td>
                      <td width="4" align="right"><img src="${themesPath}/oldimages/bg/4.gif" width="4" height="4"></td>
                    </tr>
                  </table>
                  </td>
                </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
        </table>
        <%--</td><td background="${themesPath}/oldimages/bgtub.gif">&nbsp;</td>--%>
      <%--</tr>--%>
      <%--<tr>--%>
        <%--<td valign="top"><img src="${themesPath}/oldimages/bgtuc.gif" width="10" height="11"></td>--%>
        <%--<td height="11" background="${themesPath}/oldimages/bgxia.gif"></td>--%>
        <%--<td valign="top"><img src="${themesPath}/oldimages/bgtud.gif" width="10" height="11"></td>--%>
      <%--</tr>--%>
    <%--</table>--%>
</body>
</html>
