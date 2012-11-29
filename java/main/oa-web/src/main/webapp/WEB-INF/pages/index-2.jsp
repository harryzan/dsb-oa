<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="author" content="Chomo" />
		<link rel="start"  title="Home" />
<title>中共上海市委党史研究室办公管理信息系统</title>
	<style type="text/css">
			* { margin:0; padding:0; list-style:none; font-size:14px;}/*---该css reset仅用于demo，请自行换成适合您自己的css reset---*/
			html { height:100%;}
			body {
	height:100%;
	text-align:center;
	overflow: hidden;
}
			.centerDiv {
	display:inline-block;
	zoom:1;
*display:inline; 				vertical-align:middle;
	text-align:left;
	width:892px;
	padding:10px;
	border:0px solid #f60;
	height: 367px;
	background-repeat: no-repeat;
	background-position: center;
	background-image: url(${themesPath}/login2/sea.png);
}
			.hiddenDiv { height:100%; overflow:hidden; display:inline-block; width:1px; overflow:hidden; margin-left:-1px; zoom:1; *display:inline; *margin-top:-1px; _margin-top:0; vertical-align:middle;}
		</style>

    <style type="text/css">
<!--
.STYLE2 {color: #000000}
-->
    </style>
<link href="${themesPath}/login2/login.css" rel="stylesheet" type="text/css" />
</head>
<body class="userlogin_body" onload="document.getElementById('loginname').focus()">
		
	<div class="centerDiv"> <br />
      <br />
      <br />
      <br />
      <br />
    <br />
      <br />
    <br />
<table width="100%" border="0">
    <form id="loginForm" name="loginForm" action="login" method="post">

    <tr>
            <td width="72%" height="40" align="right"><span class="STYLE2">登录账户：</span></td>
        <td><input type="text" name="loginname" id="loginname" class="login_input" /></td>
    </tr>
          <tr>
            <td height="40" align="right"><span class="STYLE2">登录密码：</span></td>
              <td><input type="password" name="loginpass" id="loginpass" class="login_input" /></td>
          </tr>
          <tr>
            <td height="40" align="right">&nbsp;</td>
            <td><input name="button3" type="submit"  class="login_ok" id="button3" value=" " />
            <input type="submit" name="button4" id="button4" class="login_cancel" value=" " /></td>
          </tr>
          <%--<tr>--%>
            <%--<td height="40" align="right">&nbsp;</td>--%>
            <%--<td><input type="checkbox" name="checkbox" id="checkbox" />--%>
            <%--记住用户名 密码</td>--%>
          <%--</tr>--%>
          <tr>
            <td height="40" align="right">&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td height="40" colspan="2" align="center">中共上海市委党史研究室     版权所有</td>
          </tr>
        </form>
        </table>
</div>
<div class="hiddenDiv"></div>
</body>
</html>