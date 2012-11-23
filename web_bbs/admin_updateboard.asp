<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=chkuser.asp-->
<title><%=ForumName%>--管理页面</title>
<!--#include file="Forum_css.asp"-->

<BODY <%=ForumBody%>>
<%
	if not master or instr(session("flag"),"02")=0 then
		Errmsg=Errmsg+"<br>"+"<li>本页面为管理员专用，请<a href=admin_index.asp target=_top>登陆</a>后进入。<br><li>您没有管理本页面的权限。"
		call Error()
	else
		dim tmprs
		dim body
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
        <td><font color="<%=TablefontColor%>">欢迎<b><%=membername%></b>进入管理中心</font>
        </td>
        </tr>
            <tr bgcolor=<%=tablebodycolor%>>
              <td width="100%" valign=top><p><font color="<%=TableContentColor%>">
<%
	if request("action")="updat" then
		if request("submit")="更新论坛数据" then
		call updateboard()
		else
		call updateall()
		end if
		response.write body
	else
%>
              <table width="100%" border="0" cellspacing="3" cellpadding="0">
                <tr> 
                  <td bgcolor=<%=atabletitlecolor%>> 
                    <font color="<%=TableContentColor%>"><p><b>更新论坛数据</b>：</p></font>
                  </td>
                </tr>
                <tr> 
                  <td> <font color="<%=TableContentColor%>">
            <form action="admin_updateboard.asp?action=updat" method=post>
<input type="submit" name="Submit" value="更新论坛数据">&nbsp;<BR><BR>这里将重新计算每个论坛的帖子主题和回复数，今日帖子，最后回复信息等，建议每隔一段时间运行一次。
<BR><BR>
<input type="submit" name="Submit" value="更新论坛总数据">&nbsp;<BR><BR>这里将重新计算整个论坛的帖子主题和回复数，今日帖子，最后加入用户等，建议每隔一段时间运行一次。
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

	sub updateboard()
	dim allarticle
	dim alltopic
	dim Ers,Esql
	dim Maxid
	dim lastpost
	dim username,dateandtime,rootid,topic
	set rs=server.createobject("adodb.recordset")
	sql="select boardid,boardtype from board"
	rs.open sql,conn,1,1
	if rs.eof and rs.bof then
		Errmsg=Errmsg+"<br>"+"<li>论坛还没有版面，请先添加版面。"
		call error()
		exit sub
	else
	do while not rs.eof
    	tmprs=conn.execute("Select count(announceid) from bbs1 where boardid="&rs("boardid")&"")
    	allarticle=tmprs(0)
	set tmprs=nothing
	if isnull(allarticle) then allarticle=0
    	tmprs=conn.execute("Select count(announceid) from bbs1 where boardid="&rs("boardid")&" and parentID=0")
    	alltopic=tmprs(0)
	set tmprs=nothing
	if isnull(alltopic) then alltopic=0

	set Ers=server.createobject("adodb.recordset")
	Ers=conn.execute("select Max(announceid) from bbs1 where boardid="&rs("boardid")&"")
	Maxid=Ers(0)

	if isnull(Maxid) then
	username="无"
	dateandtime=now()
	rootid=0
	topic="无"
	else
	Ers=conn.execute("select username,dateandtime,rootid,topic,body from bbs1 where announceid="&Maxid&"")
	username=Ers("username")
	dateandtime=Ers("dateandtime")
	rootid=Ers("rootid")
		if Ers("topic")="" then
		topic=left(Ers("body"),20)
		else
		topic=left(Ers("topic"),20)
		end if
	end if

	LastPost=username & "$" & rootid & "$" & dateandtime & "$" & replace(topic,"$","") & "$"
	Esql="update board set lastbbsnum="&allarticle&",lasttopicnum="&alltopic&",TodayNum="&todays(rs("boardid"))&",LastPost='"&LastPost&"' where boardid="&rs("boardid")&""
	'response.write esql
	conn.execute(Esql)
	body=body &"更新论坛数据成功，"&rs("boardtype")&"共有"&allarticle&"篇贴子，"&alltopic&"篇主题，今日有"&todays(rs("boardid"))&"篇帖子。<br>"
	rs.movenext
	loop
	end if
	rs.close
	set rs=nothing
	end sub

	sub updateall()
	sql="update config set TopicNum="&titlenum()&",BbsNum="&gettipnum()&",TodayNum="&alltodays()&",UserNum="&allusers()&",lastUser='"&newuser()&"'"
	conn.execute(sql)
	body=body &"更新总论坛数据成功，全部论坛共有"&gettipnum()&"篇贴子，"&titlenum()&"篇主题，今日有"&alltodays()&"篇帖子，有"&allusers()&"用户，最新加入为"&newuser()&"。<br>"
	end sub
function todays(boardid)
    	tmprs=conn.execute("Select count(announceid) from bbs1 Where datediff('d',dateandtime,Now())=0 and boardid="&boardid&"")
    	todays=tmprs(0)
	set tmprs=nothing
	if isnull(todays) then todays=0
end function
function alltodays()
    	tmprs=conn.execute("Select count(announceid) from bbs1 Where datediff('d',dateandtime,Now())=0")
    	alltodays=tmprs(0)
	set tmprs=nothing
	if isnull(alltodays) then alltodays=0
end function

function allusers() 
    	tmprs=conn.execute("Select count(userid) from [user]") 
    	allusers=tmprs(0) 
	set tmprs=nothing 
	if isnull(allusers) then allusers=0 
end function 
function newuser()
	set tmprs=server.createobject("adodb.recordset")
    	sql="Select top 1 username from [user] order by userid desc"
	tmprs.open sql,conn,1,1
	if tmprs.eof and tmprs.bof then
	newuser="没有会员"
	else
    	newuser=tmprs("username")
	end if
	set tmprs=nothing
end function 

function gettipnum() 
    	tmprs=conn.execute("Select Count(announceID) from bbs1") 
    	gettipnum=tmprs(0) 
	set tmprs=nothing 
	if isnull(gettipnum) then gettipnum=0 
end function 

function titlenum() 
    	tmprs=conn.execute("Select Count(announceID) from bbs1 where parentID=0") 
    	titlenum=tmprs(0) 
	set tmprs=nothing 
	if isnull(titlenum) then titlenum=0 
end function 
%>