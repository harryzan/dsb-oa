<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=chkuser.asp-->
<!-- #include file="admin_config.asp" -->
<title><%=ForumName%>--管理页面</title>
<!--#include file="Forum_css.asp"-->

<BODY  <%=ForumBody%>>
<%
	if not master or instr(session("flag"),"05")=0 then
		Errmsg=Errmsg+"<br>"+"<li>本页面为管理员专用，请<a href=admin_index.asp target=_top>登陆</a>后进入。<br><li>您没有管理本页面的权限。"
		call Error()
	else
		dim body
		if request("action")="alldel" then
			call alldel()
		elseif request("action")="userdel" then
			call del()
		elseif request("action")="alldelTopic" then
			call alldelTopic()
		elseif request("action")="delUser" then
			call delUser()
		else
		call main()
		end if
		conn.close
		set conn=nothing
	end if

	sub main()
%>
<p></p>
            <table cellpadding=0 cellspacing=0 border=0 width="<%=tablewidth%>" bgcolor="<%=TableBackColor%>" align=center>
            <tr><td>
            <table cellpadding=6 cellspacing=1 border=0 width=100%>
            <tr>
            <td bgcolor="<%=TableTitleColor%>" valign=middle colspan=2 align=center>
            <font color="<%=TableFontcolor%>">
            <b>请输入详细资料以便进入删除模式[批量删除]</b></font></td></tr>
            <tr>
            <td bgcolor="<%=TableBodyColor%>" valign=middle colspan=2><font color="<%=TableContentcolor%>"><b>如果您想还原帖子，请到论坛回收站！</b>
            <br>下面操作将大批量删除论坛帖子。如果您确定这样做，请仔细检查您输入的信息。</font></td>
            <form action="admin_alldel.asp?action=userdel" method="post">
            <tr>
            <td bgcolor="<%=TableBodyColor%>" valign=middle><font color="<%=TableContentcolor%>">请输入用户名，删除某用户的所有帖子</font></td>
            <td bgcolor="<%=TableBodyColor%>" valign=middle><input type=text name="username"> <input type=submit name="submit" value="提 交"></td></tr></form>
<form action="admin_alldel.asp?action=alldel" method="post">
            <tr>
                <td bgcolor="<%=TableBodyColor%>" valign=middle><font color="<%=TableContentcolor%>">删除指定日期内帖子</font></td>
            <td bgcolor="<%=TableBodyColor%>" valign=middle>
<select name=TimeLimited size=1> 
<option value=all>删除所有的主题
<option value=1>删除一天前的主题
<option value=2>删除两天前的主题
<option value=7>删除一星期前的主题
<option value=15>删除半个月前的主题
<option value=30>删除一个月前的主题
<option value=60>删除两个月前的主题
<option value=180>删除半年前的主题
</select>
</select><input type=submit name="submit" value="提 交"></td></tr></form>
<form action="admin_alldel.asp?action=alldelTopic" method="post">
            <tr>
                <td bgcolor="<%=TableBodyColor%>" valign=middle><font color="<%=TableContentcolor%>">删除指定日期内没有回复的主题</font></td>
            <td bgcolor="<%=TableBodyColor%>" valign=middle>
<select name=TimeLimited size=1> 
<option value=all>删除所有的
<option value=1>删除一天前的
<option value=2>删除两天前的
<option value=7>删除一星期前的
<option value=15>删除半个月前的
<option value=30>删除一个月前的
<option value=60>删除两个月前的
<option value=180>删除半年前的
</select>
</select><input type=submit name="submit" value="提 交"></td></tr></form>
<form action="admin_alldel.asp?action=delUser" method="post">
            <tr>
            <td bgcolor="<%=TableBodyColor%>" valign=middle><font color="<%=TableContentcolor%>">删除指定日期内没有登陆的用户</font></td>
            <td bgcolor="<%=TableBodyColor%>" valign=middle>
<select name=TimeLimited size=1> 
<option value=all>删除所有的
<option value=1>删除一天前的
<option value=2>删除两天前的
<option value=7>删除一星期前的
<option value=15>删除半个月前的
<option value=30>删除一个月前的
<option value=60>删除两个月前的
<option value=180>删除半年前的
</select>
</select><input type=submit name="submit" value="提 交"></td></tr></form>
</table></td></tr></table>
<%
	end sub
	sub del()
		dim titlenum
		if request("username")="" then
			founderr=true
			errmsg=errmsg+"<br>"+"<li>请输入被帖子删除用户名。"
			exit sub
		end if
    		rs=conn.execute("Select Count(announceID) from bbs1 where username='"&replace(request("username"),"'","")&"'") 
    		titlenum=rs(0) 
		if isnull(titlenum) then titlenum=0
		sql="update bbs1 set locktopic=2 where username='"&replace(request("username"),"'","")&"'"
		conn.Execute(sql)
		sql="update [user] set article=article-"&titlenum&",userWealth=userWealth-"&titlenum*wealthDel&",userEP=userEP-"&titlenum*epDel&",userCP=userCP-"&titlenum*cpDel&" where username='"&replace(request("username"),"'","")&"'"
		conn.Execute(sql)
		call success()
	end sub

	sub alldel()
	Dim TimeLimited
	TimeLimited=request.form("TimeLimited")
	if TimeLimited="all" then
	conn.execute("update bbs1 set LockTopic=2")
	else
	conn.execute("update bbs1 set LockTopic=2 where datediff('d',DateAndTime,Now())>"&TimeLimited&"")
	end if
	call success()
	end sub
	sub alldelTopic()
	Dim TimeLimited
	TimeLimited=request.form("TimeLimited")
	if TimeLimited="all" then
	conn.execute("update bbs1 set LockTopic=2 where ParentID=0 and Child=0")
	else
	conn.execute("update bbs1 set LockTopic=2 where ParentID=0 and Child=0 and  datediff('d',DateAndTime,Now())>"&TimeLimited&"")
	end if
	call success()
	end sub

	sub delUser()
	Dim TimeLimited
	TimeLimited=request.form("TimeLimited")
	if TimeLimited="all" then
	conn.execute("delete from [user]")
	else
	conn.execute("delete from [user] where datediff('d',LastLogin,Now())>"&TimeLimited&"")
	end if
	call success()
	end sub

	sub success()
%>
            <table cellpadding=0 cellspacing=0 border=0 width="<%=tablewidth%>" bgcolor="<%=Tablebackcolor%>" align=center>
            <tr><td>
            <table cellpadding=6 cellspacing=1 border=0 width=100%>
            <tr>
            <td bgcolor="<%=Tabletitlecolor%>" valign=middle colspan=2 align=center>
            <font color="<%=TableFontcolor%>">删除成功，如果要完全删除帖子请到论坛回收站<BR>建议您到更新论坛数据中更新一下论坛数据，或者<a href=admin_alldel.asp><font color="<%=TableFontcolor%>">返回</font></a></font></td></tr>
</table>
            </table></td></tr></table>
<%
	end sub
%>
<!--#include file="footer.asp"-->