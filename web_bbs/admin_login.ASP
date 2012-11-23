<!--#include file="conn.asp"-->
<!--#include file="inc/const.asp"-->
<!-- #include file="chkuser.asp" -->
<!-- #include file="md5.asp" -->
<!--#include file="inc/theme.asp"-->
<!--#include file="inc/char.asp"-->
<%
	stats="论坛管理登陆"
	dim username
	dim password
	dim ip
	call nav()
	call headline(1)
	if founderr then
		call error()
	else
		if request("action")="chklogin" then
		call chklogin()
		if founderr then call error()
		else
		call main()
		end if
	end if
	call endline()
	sub chklogin()
	username=trim(replace(request("username"),"'",""))
	password=md5(trim(replace(request("password"),"'","")))
	if request("verifycode")="" then
		errmsg=errmsg+"<br>"+"<li>请返回输入确认码。"
		founderr=true
	elseif session("verifycode")="" then
		errmsg=errmsg+"<br>"+"<li>请不要重复提交，如需重新登陆请返回登陆页面。"
		founderr=true
	elseif session("verifycode")<>trim(request("verifycode")) then
		errmsg=errmsg+"<br>"+"<li>您输入的确认码和系统产生的不一致，请重新输入。"
		founderr=true
	end if
	session("verifycode")=""
	if username="" or password="" then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>请输入您的用户名或密码。"
	end if
	if founderr then exit sub
	ip=Request.ServerVariables("REMOTE_ADDR")
	set rs=conn.execute("select u.username,u.userpassword,a.* from [user] u inner join admin a on u.username=a.username where u.username='"&username&"' and u.userpassword='"&password&"' and u.userclass=20")
	if rs.eof and rs.bof then
		rs.close
		set rs=nothing
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>您输入的用户名和密码不正确或者您不是系统管理员。<br><li>请<a href=admin_login.asp>重新输入</a>您的密码。"
		exit sub
	else
		if isnull(rs("flag")) or rs("flag")="" then
		rs.close
		set rs=nothing
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>您没有权限进入管理页面。"
		exit sub
		else
		session("flag")=rs("flag")
		session.timeout=45
		conn.execute("update admin set LastLogin=Now(),LastLoginIP='"&ip&"' where username='"&username&"'")
		rs.close
		set rs=nothing
		response.write "<script>location.href='admin_main.asp'</script>"
		end if
	end if
	end sub
	sub main()
	dim num1
	dim rndnum
	Randomize
	Do While Len(rndnum)<4
	num1=CStr(Chr((57-48)*rnd+48))
	rndnum=rndnum&num1
	loop
	session("verifycode")=rndnum
%>
<form action="admin_login.asp?action=chklogin" method="post"> 
<table cellpadding=0 cellspacing=0 border=0 width=<%=tablewidth%> bgcolor=<%=aTablebackcolor%> align=center>
    <tr>    
        <td>
        <table cellpadding=6 cellspacing=1 border=0 width=100%>

    <tr>
    <td bgcolor=<%=Tabletitlecolor%> valign=middle colspan=2 align=center>
    <font color="<%=TablefontColor%>"><b>请输入您的用户名、密码登陆</b>（如果您不是总版主请勿登陆）</font></td></tr>
    <tr bgcolor=<%=Tablebodycolor%>>
    <td valign=middle><font color="<%=TableContentColor%>">请输入您的用户名</font></td>
    <td valign=middle><INPUT name=username type=text> &nbsp; <a href="reg.asp"><font color="<%=TableContentColor%>">没有注册？</font></a></td></tr>
    <tr bgcolor=<%=Tablebodycolor%>>
    <td valign=middle><font color="<%=TableContentColor%>">请输入您的密码</font></td>
    <td valign=middle><INPUT name=password type=password> &nbsp; <a href="lostpass.asp"><font color="<%=TableContentColor%>">忘记密码？</font></a></td></tr>
    <tr>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>">请输入您的附加码</font></td>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><INPUT name="verifycode" type=text> &nbsp; 请在附加码框输入  <b><span style="background-color: #FFFFFF"><font color="#000000"><%=session("verifycode")%></font></span></b></td></tr>
    <tr>
    <td bgcolor=<%=Tabletitlecolor%> valign=middle colspan=2 align=center><input type=submit name="submit" value="登 陆"></td></tr></table></td></tr></table>
</form>
<%end sub%>
<!--#include file="footer.asp"-->