<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!-- #include file="inc/char.asp" -->
<!--#include file="inc/grade.asp"-->
<!--#include file=chkuser.asp-->
<title><%=ForumName%>--管理页面</title>
<!--#include file="Forum_css.asp"-->

<BODY <%=ForumBody%>>
<%
	server.scriptTimeout=999999
	if not master or instr(session("flag"),"15")=0 then
		Errmsg=Errmsg+"<br>"+"<li>本页面为管理员专用，请<a href=admin_index.asp target=_top>登陆</a>后进入。<br><li>您没有管理本页面的权限。"
		call Error()
	else
		dim body
		dim tmprs
		call main()
		conn.close
		set conn=nothing
	end if

	sub main()
%>
<table cellpadding=0 cellspacing=0 border=0 width=<%=tablewidth%> bgcolor=<%=tablebackcolor%> align=center>
  <tr>
    <td>
      <table cellpadding=3 cellspacing=1 border=0 width=100%>
        <tr bgcolor='<%=Tabletitlecolor%>'>
        <td align=center colspan="2"><font color="<%=TablefontColor%>">欢迎<b><%=membername%></b>进入管理页面</font>
        </td>
        </tr>
            <tr bgcolor=<%=tablebodycolor%>>
              <td width="100%" valign=top><p><font color="<%=TableContentColor%>">
<%
	if request("action")="updat" then
		if request("submit")="重新计算用户发贴" then
		call updateTopic()
		elseif request("submit")="更新用户等级" then
		call updategrade()
		else
		call updatemoney()
		end if
		response.write ""&body&""
	else
%>
              <table width="100%" border="0" cellspacing="3" cellpadding="0">
                <tr> 
                  <td bgcolor=<%=atabletitlecolor%>> <font color="<%=TableContentColor%>">
                    <p><b>更新用户数据</b>：执行下列操作比较消耗服务器资源，如果数据量非常大的情况下将消耗更多的资源和时间，尽量减少使用次数。</p></font>
                  </td>
                </tr>
                <tr> 
                  <td> <font color="<%=TableContentColor%>">
<form action="admin_updateuser.asp?action=updat" method=post>
<input type="submit" name="Submit" value="重新计算用户发贴">&nbsp;<BR><BR>执行本操作将按照论坛发贴重新计算所有用户发表帖子数量。<BR><BR>
<input type="submit" name="Submit" value="更新用户等级">&nbsp;<BR><BR>执行本操作将按照用户发贴数量和论坛的等级设置重新计算用户等级，本操作不影响等级为贵宾、版主、总版主的数据。<BR><BR>
<input type="submit" name="Submit" value="更新用户金钱/经验/魅力">&nbsp;<BR><BR>执行本操作将按照用户的发贴数量和论坛的相关设置重新计算用户的金钱/经验/魅力，本操作也将重新计算贵宾、版主、总版主的数据，注意：<font color=red>不推荐用户进行本操作，本操作在数据很多的时候请尽量不要使用，并且本操作对各个版面删除帖子等所扣相应分值不做运算，只是按照发贴和总的论坛分值设置进行运算，请大家慎重操作</font>。
</form></font>
                  </td>
                </tr>
<%
	end if
%></font>
</p></td>
            </tr>
        </table>
        </td>
    </tr>
</table>
<%
'	response.write ""&body&""
	end sub

	sub updateTopic()
	dim userTopic
	'conn.execute("update [user] set article="&allnum(username)&"")
	set rs=server.createobject("adodb.recordset")
	sql="select username from [user] order by userid desc"
	rs.open sql,conn,1,1
	do while not rs.eof
		userTopic=allnum(rs(0))
		conn.execute("update [user] set article="&userTopic&" where username='"&rs(0)&"'")
	rs.movenext
	loop
	rs.close
	set rs=nothing
	body=body+"<br>"+"更新用户数据成功("&now()&")。"
	end sub

	sub updatemoney()
	dim userTopic,userReply,userWealth
	dim userEP,userCP
	set rs=server.createobject("adodb.recordset")
	sql="select username,logins from [user] order by userid desc"
	rs.open sql,conn,1,1
	do while not rs.eof
		userTopic=TopicNum(rs(0))
		userreply=replyNum(rs(0))
		userwealth=rs(1)*wealthLogin + userTopic*wealthAnnounce + userreply*wealthReannounce
		userEP=rs(1)*epLogin + userTopic*epAnnounce + userreply*epReAnnounce
		userCP=rs(1)*cpLogin + userTopic*cpAnnounce + userreply*cpReAnnounce
		conn.execute("update [user] set userWealth="&userWealth&",userep="&userep&",usercp="&usercp&" where username='"&rs(0)&"'")
	rs.movenext
	loop
	rs.close
	set rs=nothing
	body=body+"<br>"+"更新用户数据成功("&now()&")。"
	end sub

	sub updategrade()
	conn.execute("update [user] set userclass=1 where article<0")

	conn.execute("update [user] set userclass=1 where (article>="&point(1)&" and article<"&point(2)&") and not (userclass=18 or userclass=19 or  userclass=20)")
	conn.execute("update [user] set userclass=2 where (article>="&point(2)&" and article<"&point(3)&") and not (userclass=18 or userclass=19 or  userclass=20)")
	conn.execute("update [user] set userclass=3 where (article>="&point(3)&" and article<"&point(4)&") and not (userclass=18 or userclass=19 or  userclass=20)")
	conn.execute("update [user] set userclass=4 where (article>="&point(4)&" and article<"&point(5)&") and not (userclass=18 or userclass=19 or  userclass=20)")
	conn.execute("update [user] set userclass=5 where (article>="&point(5)&" and article<"&point(6)&") and not (userclass=18 or userclass=19 or  userclass=20)")
	conn.execute("update [user] set userclass=6 where (article>="&point(6)&" and article<"&point(7)&") and not (userclass=18 or userclass=19 or  userclass=20)")
	conn.execute("update [user] set userclass=7 where (article>="&point(7)&" and article<"&point(8)&") and not (userclass=18 or userclass=19 or  userclass=20)")
	conn.execute("update [user] set userclass=8 where (article>="&point(8)&" and article<"&point(9)&") and not (userclass=18 or userclass=19 or  userclass=20)")
	conn.execute("update [user] set userclass=9 where (article>="&point(9)&" and article<"&point(10)&") and not (userclass=18 or userclass=19 or  userclass=20)")
	conn.execute("update [user] set userclass=10 where (article>="&point(10)&" and article<"&point(11)&") and not (userclass=18 or userclass=19 or  userclass=20)")	
	conn.execute("update [user] set userclass=11 where (article>="&point(11)&" and article<"&point(12)&") and not (userclass=18 or userclass=19 or  userclass=20)")
	conn.execute("update [user] set userclass=12 where (article>="&point(12)&" and article<"&point(13)&") and not (userclass=18 or userclass=19 or  userclass=20)")
	conn.execute("update [user] set userclass=13 where (article>="&point(13)&" and article<"&point(14)&") and not (userclass=18 or userclass=19 or  userclass=20)")
	conn.execute("update [user] set userclass=14 where (article>="&point(14)&" and article<"&point(15)&") and not (userclass=18 or userclass=19 or  userclass=20)")
	conn.execute("update [user] set userclass=15 where (article>="&point(15)&" and article<"&point(16)&") and not (userclass=18 or userclass=19 or  userclass=20)")
	conn.execute("update [user] set userclass=16 where (article>="&point(16)&" and article<"&point(17)&") and not (userclass=18 or userclass=19 or  userclass=20)")

	conn.execute("update [user] set userclass=17 where article>="&point(17)&" and not (userclass=18 or userclass=19 or  userclass=20)")
	body=body+"<br>"+"更新用户数据成功("&now()&")。"
	end sub

	function TopicNum(username)
	set tmprs=conn.execute("select count(announceid) from bbs1 where ParentID=0 and username='"&username&"'")
	TopicNum=tmprs(0)
	if isnull(TopicNum) then TopicNum=0
	set tmprs=nothing
	end function
	function replyNum(username)
	set tmprs=conn.execute("select count(announceid) from bbs1 where not ParentID=0 and username='"&username&"'")
	replyNum=tmprs(0)
	if isnull(replyNum) then replyNum=0
	set tmprs=nothing
	end function
	function allnum(username)
	set tmprs=conn.execute("select count(announceid) from bbs1 where username='"&username&"'")
	allnum=tmprs(0)
	if isnull(allnum) then allnum=0
	set tmprs=nothing
	end function
%>