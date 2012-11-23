<!--#include file="conn.asp"-->
<!--#include file="inc/const.asp"-->
<!--#include file="inc/char.asp"-->
<!--#include file="inc/char_login.asp"-->
<!--#include file="inc/char_cfrom.asp"-->
<!--#include file="chkuser.asp"-->
<!--#include file="inc/theme.asp"-->
<!--#include file="md5.asp"-->
<%
	dim UserIP
	dim username
	dim userclass
	dim password
	dim article
	dim cookies_path_s,cookies_path_d,cookies_path,usercookies

	sub chkuser()
	UserIP=Request.ServerVariables("REMOTE_ADDR")
	if request("username")="" then
		errmsg=errmsg+"<br>"+"<li>请输入您的用户名。"
		founderr=true
	else
		username=trim(checkStr(request("username")))
	end if
	if request("password")="" then
		errmsg=errmsg+"<br>"+"<li>请输入您的密码。"
		founderr=true
	else
		password=md5(trim(checkStr(request("password"))))
	end if
	'判断更新cookies目录
	cookies_path_s=split(Request.ServerVariables("PATH_INFO"),"/")
	cookies_path_d=ubound(cookies_path_s)
	cookies_path="/"
	for i=1 to cookies_path_d-1
		cookies_path=cookies_path&cookies_path_s(i)&"/"
	next
	if cookiepath<>cookies_path then
	cookiepath=cookies_path
	conn.execute("update config set cookiepath='"&cookiepath&"'")
	end if

	usercookies=request("CookieDate")
	if chkuserlogin(username,password,usercookies,1)=false then
		errmsg=errmsg+"<br>"+"<li>您的用户名并不存在，或者您的密码错误，或者您的帐号已被管理员锁定。"
		founderr=true
	end if
	end sub

	stats="用户登陆"
	call chkuser()
	if founderr then
		call nav()
		call headline(1)
		call error()
	else
		call nav()
		call headline(1)
		call success()
	end if
	call endline()
	sub success()
	dim comeurl
%>
<%if instr(lcase(request("comeurl")),"regpost")>0 or instr(request("comeurl"),"login.asp")>0 or instr(request("comeurl"),"chklogin.asp")>0 or trim(request("comeurl"))="" then%>
	<meta HTTP-EQUIV=REFRESH CONTENT='4; URL=index.asp'>
<%comeurl="index.asp"%>
<%else%>
	<meta HTTP-EQUIV=REFRESH CONTENT='4; URL=<%=request("comeurl")%>'>
<%comeurl=request("comeurl")%>
<%end if%>
    <table cellpadding=0 cellspacing=0 border=0 width=<%=TableWidth%> bgcolor=<%=tablebackcolor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
	     <tr>
	      <td bgcolor="<%=tableTitleColor%>"><font color="<%=TableFontColor%>"><b>状态：您已经登录成功</b></font></td>
	    </tr>
	     <tr><td bgcolor="<%=tablebodycolor%>"><br><ul><li><a href="<%=comeurl%>"><font color="<%=TableContentColor%>">进入讨论区</font></a></li></ul></td></tr>
	  </table>   </td></tr></table>
<%
	end sub
%>
<!-- #include file=footer.asp -->