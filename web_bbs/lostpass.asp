<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!--#include file="inc/char.asp"-->
<!--#include file="inc/email.asp"-->
<!--#include file="inc/theme.asp"-->
<!--#include file="chkuser.asp"-->
<!--#include file="md5.asp"-->
<%
  Errmsg=Errmsg+"<br>"+"<li>系统不支持用户自行注册，请联系系统管理员。</li>"
	Founderr=true
	call error()
	response.end
	
	Founderr=false
	dim username,answer,password
	stats="密码遗忘"
	call nav()
	call headline(1)
	if founderr then
		call error()
	else
		if request("action")="step1" then
			call step1()
		elseif request("action")="step2" then
			call step2()
		elseif request("action")="step3" then
			call step3()
		else
			call main()
		end if
		if founderr then call error()
	end if
	call endline()

sub step1()
	if request("username")="" then
		Founderr=true
		Errmsg=Errmsg+"<br>"+"<li>请输入您的用户名。"
		exit sub
	else
		username=replace(request("username"),"'","")
	end if
	set rs=conn.execute("Select Quesion,Answer,Username,userclass from [user] where username='"&username&"'")
	if rs.eof and rs.bof then
		Founderr=true
		Errmsg=Errmsg+"<br>"+"<li>您输入的用户名并不存在，请重新输入。"
	else
		if rs(0)="" or isnull(rs(0)) then
		Founderr=true
		Errmsg=Errmsg+"<br>"+"<li>该用户没有填写密码问题及答案，只有填写的用户方能继续。"
		elseif rs(3)>18 then
		Founderr=true
		Errmsg=Errmsg+"<br>"+"<li>版主和总版主取回密码请和论坛管理员联系。"
		else
%>
<form action="lostpass.asp?action=step2" method="post"> 
<table cellpadding=0 cellspacing=0 border=0 width="<%=tablewidth%>" bgcolor=<%=Tablebackcolor%> align=center>
    <tr>    
        <td>
        <table cellpadding=6 cellspacing=1 border=0 width=100%>

    <tr>
    <td bgcolor=<%=Tabletitlecolor%> valign=middle colspan=2 align=center><font color="<%=TableFontColor%>">
    <b>取回密码</b>（第二步：回答问题）</font></td></tr>
    <tr>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>"><b>问题：</b></font></td>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>"><%=rs(0)%></font></td>
    </tr>
    <tr>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>"><b>答案：</b></font></td>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><INPUT name="answer" type=text></td>
    </tr>
    <tr>
    <td bgcolor=<%=Tablebodycolor%> colspan=2><font color="<%=TableContentColor%>">
    <b>说明：</b>请填写您正确的问题答案。</font></td></tr>
    <tr>
    <td bgcolor=<%=Tabletitlecolor%> valign=middle colspan=2 align=center><input type=submit name="submit" value="提 交"></td></tr>
</table></td></tr></table>
<input type=hidden value="<%=username%>" name=username>
</form>
<%
		end if
	end if
	rs.close
	set rs=nothing
end sub

sub step2()
	if request("username")="" then
		Founderr=true
		Errmsg=Errmsg+"<br>"+"<li>请输入您的用户名。"
		exit sub
	else
		username=replace(request("username"),"'","")
	end if
	if chkpost=false then
   		ErrMsg=ErrMsg+"<Br>"+"<li>您提交的数据不合法，请不要从外部提交发言。"
   		FoundErr=True
		exit sub
	end if
	if request("answer")="" then
		Founderr=true
		Errmsg=Errmsg+"<br>"+"<li>请输入您的问题答案。"
		exit sub
	else
		answer=md5(request("answer"))
	end if
	set rs=conn.execute("select answer,quesion,userclass from [user] where username='"&username&"' and answer='"&answer&"'")
	if rs.eof and rs.bof then
		Founderr=true
		Errmsg=Errmsg+"<br>"+"<li>您输入的问题答案不正确，请重新输入。"
	else
		if rs(2)>18 then
		Founderr=true
		Errmsg=Errmsg+"<br>"+"<li>版主和总版主取回密码请和论坛管理员联系。"
		exit sub
		end if
%>
<form action="lostpass.asp?action=step3" method="post"> 
<table cellpadding=0 cellspacing=0 border=0 width=<%=tablewidth%> bgcolor=<%=Tablebackcolor%> align=center>
    <tr>    
        <td>
        <table cellpadding=6 cellspacing=1 border=0 width=100%>

    <tr>
    <td bgcolor=<%=Tabletitlecolor%> valign=middle colspan=2 align=center><font color="<%=TablefontColor%>">
    <b>取回密码</b>（第三步：修改密码）</font></td></tr>
    <tr>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>"><b>问题：</b></font></td>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>"><%=rs(1)%></font></td>
    </tr>
    <tr>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>"><b>答案：</b></font></td>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>"><%=request("answer")%></font></td>
    </tr>
    <tr>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>"><b>新密码：</b></font></td>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><input type=password name=password></td>
    </tr>
    <tr>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>"><b>确认新密码：</b></font></td>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><input type=password name=repassword></td>
    </tr>
    <tr>
    <td bgcolor=<%=Tablebodycolor%> colspan=2><font color="<%=TableContentColor%>">
    <b>说明：</b>请填写您的论坛新密码，并记住您所填写信息。</font></td></tr>
    <tr>
    <td bgcolor=<%=Tabletitlecolor%> valign=middle colspan=2 align=center><input type=submit name="submit" value="提 交"></td></tr>
</table></td></tr></table>
<input type=hidden value="<%=request("answer")%>" name=answer>
<input type=hidden value="<%=username%>" name=username>
</form>
<%
	end if
	rs.close
	set rs=nothing
end sub

sub step3()
	if request("username")="" then
		Founderr=true
		Errmsg=Errmsg+"<br>"+"<li>请输入您的用户名。"
		exit sub
	else
		username=replace(request("username"),"'","")
	end if
	if request("answer")="" then
		Founderr=true
		Errmsg=Errmsg+"<br>"+"<li>请输入您的问题答案。"
		exit sub
	else
		answer=md5(request("answer"))
	end if
	if request("password")="" then
		Founderr=true
		Errmsg=Errmsg+"<br>"+"<li>请输入您的新密码。"
		exit sub
	elseif request("repassword")="" then
		Founderr=true
		Errmsg=Errmsg+"<br>"+"<li>请再次输入您的新密码。"
		exit sub
	elseif request("password")<>request("repassword") then
		Founderr=true
		Errmsg=Errmsg+"<br>"+"<li>您输入的新密码和确认不一样，请确认您填写的信息。"
		exit sub
	else
		password=md5(request("password"))
	end if
	set rs=server.createobject("adodb.recordset")
	sql="select userpassword,quesion,userclass from [user] where username='"&username&"' and answer='"&answer&"'"
	rs.open sql,conn,1,3
	if rs.eof and rs.bof then
		Founderr=true
		Errmsg=Errmsg+"<br>"+"<li>您输入的问题答案不正确，请重新输入。"
	else
		if rs(2)>18 then
		Founderr=true
		Errmsg=Errmsg+"<br>"+"<li>版主和总版主取回密码请和论坛管理员联系。"
		exit sub
		end if
		rs("userpassword")=password
		rs.update
%>
<form action="login.asp" method="post"> 
<table cellpadding=0 cellspacing=0 border=0 width=<%=tablewidth%> bgcolor=<%=Tablebackcolor%> align=center>
    <tr>    
        <td>
        <table cellpadding=6 cellspacing=1 border=0 width=100%>

    <tr>
    <td bgcolor=<%=Tabletitlecolor%> valign=middle colspan=2 align=center><font color="<%=TablefontColor%>">
    <b>取回密码</b>（第四步：修改成功）</font></td></tr>
    <tr>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>"><b>问题：</b></font></td>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>"><%=rs(1)%></font></td>
    </tr>
    <tr>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>"><b>答案：</b></font></td>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>"><%=request("answer")%></font></td>
    </tr>
    <tr>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>"><b>新密码：</b></font></td>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>"><%=request("password")%></font></td>
    </tr>
    <tr>
    <td bgcolor=<%=Tablebodycolor%> colspan=2><font color="<%=TableContentColor%>">
    <b>说明：</b>请记住您的新密码并使用新密码<a href=login.asp>登陆论坛</a>。</font></td></tr>
    <tr>
    <td bgcolor=<%=Tabletitlecolor%> valign=middle colspan=2 align=center><input type=submit name="submit" value="返 回"></td></tr>
</table></td></tr></table>
</form>
<%
	end if
	rs.close
	set rs=nothing
end sub

sub main()
%>
<form action="lostpass.asp?action=step1" method="post"> 
<table cellpadding=0 cellspacing=0 border=0 width="<%=tablewidth%>" bgcolor=<%=Tablebackcolor%> align=center>
    <tr>    
        <td>
        <table cellpadding=6 cellspacing=1 border=0 width=100%>

    <tr>
    <td bgcolor=<%=Tabletitlecolor%> valign=middle colspan=2 align=center><font color="<%=TablefontColor%>">
    <b>取回密码</b>（第一步：用户名）</font></td></tr>
    <tr>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>">请输入您的用户名</font></td>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><INPUT name="username" type=text></td>
    </tr>
    <tr>
    <td bgcolor=<%=Tablebodycolor%> colspan=2><font color="<%=TableContentColor%>">
    <b>说明：</b>本操作只能修改您的密码，不能对原密码进行修改，请确认您已经填写了密码问题及答案。</font></td></tr>
    <tr>
    <td bgcolor=<%=Tabletitlecolor%> valign=middle colspan=2 align=center><input type=submit name="submit" value="提 交"></td></tr>
</table></td></tr></table>
</form>
<%
end sub
%>
<!--#include file="footer.asp"-->