<html>
<head>
<title>论坛管理中心</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>

<frameset cols="160,*" frameborder="NO" border="0" framespacing="0" rows="*"> 
  <frame name="leftFrame" scrolling="AUTO" noresize src="admin_left.asp" marginwidth="0" marginheight="0">
<%if session("flag")="" then%>
  <frame name="main" src="admin_login.asp" noresize marginwidth="0" marginheight="0" scrolling="AUTO">
<%else%>
  <frame name="main" src="admin_main.asp" noresize marginwidth="0" marginheight="0" scrolling="AUTO">
<%end if%>
</frameset>
<noframes><body <%=ForumBody%>>

</body></noframes>
</html>