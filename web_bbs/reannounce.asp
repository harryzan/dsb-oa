<!--#include file="conn.asp"-->
<!-- #include file="inc/char.asp" -->
<!-- #include file="inc/char_board.asp" -->
<!-- #include file="inc/const.asp" -->
<!-- #include file="chkuser.asp" -->
<!--#include file="inc/theme.asp"-->
<!--#include file="inc/form1.asp"-->
<!--#include file="inc/ubbcode.asp"-->
<%

	dim AnnounceID
	dim RootID
	dim rsBoard
	dim boardsql
	dim userclass
	dim username
	dim dateandtime
	dim bgcolor,abgcolor
	dim topic
	dim usersign
	usersign=false
	
	dim con,content
	dim boardstat
	if request("boardid")="" then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>请指定论坛版面。"
	elseif not isInteger(request("boardid")) then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>非法的版面参数。"
	else
		boardid=request("boardid")
	end if
	if request("id")="" then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>请指定相关贴子。"
	elseif not isInteger(request("id")) then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>非法的贴子参数。"
	else
		AnnounceID=request("id")
	end if
	if request("RootID")="" then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>请指定相关贴子。"
	elseif not isInteger(request("RootID")) then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>非法的贴子参数。"
	else
		RootID=request("RootID")
	end if

	select case boardskin
	case 1
		boardstat="常规论坛，只允许<a href=reg.asp><font color="&TableFontcolor&">注册会员</a>发言"
	case 2
		boardstat="开放论坛，允许所有人发言"
	case 3
		boardstat="评论论坛，坛主和版主允许发言，其他<a href=reg.asp><font color="&TableFontcolor&">注册用户</font></a>只能回复"
	case 4
		boardstat="精华区，只允许版主和坛主发言和操作"
		if not(boardmaster or master) then
		Founderr=true
		Errmsg=Errmsg+"<br>"+"<li>精华区，只允许版主和坛主发言和操作"
		end if
	case 5
		boardstat="认证论坛，除坛主和版主外，其他<a href=reg.asp><font color="&TableFontcolor&">注册用户</font></a>登陆论坛需要认证"
		if membername="" then
			founderr=true
			Errmsg=Errmsg+"<br>"+"<li>本论坛为认证论坛，请<a href=login.asp>登陆</a>并确认您的用户名已经得到管理员的认证后进入。"
		else
			if chkboardlogin(boardid,membername)=false then
			founderr=true
			Errmsg=Errmsg+"<br>"+"<li>本论坛为认证论坛，请确认您的用户名已经得到管理员的认证后进入。"
			end if
		end if
	case 6
		boardstat="正规论坛，只有<a href=login.asp><font color="&TableFontcolor&">登陆用户</a>才能浏览论坛并发言"
		if membername="" then
		Founderr=true
		Errmsg=Errmsg+"<br>"+"<li>正规论坛，只有<a href=login.asp><font color="&TableContentColor&">登陆用户</a>才能浏览论坛并发言"
		end if
	end select

	stats=""&boardtype&"回复发言"
	sub chktopic()
     	set rs=conn.execute("select topic from bbs1 where announceID="&rootID&"")
	if not(rs.bof and rs.eof) then
		topic=rs("topic")
	else
		foundErr = true
		ErrMsg=ErrMsg+"<br>"+"<li>您指定的贴子不存在</li>"
	end if
	rs.close
	set rs = server.CreateObject ("adodb.recordset")
  	sql="select body,topic,locktopic,username,dateandtime from bbs1 where AnnounceID="&AnnounceID
   	rs.open sql,conn,1,1 
		if rs("locktopic")=1 then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>本主题已被锁定，不能发表回复。"
		else
   		con=rs("body")
		topic=rs("topic")
		username=rs("username")
		dateandtime=rs("dateandtime")
		end if
	rs.close
	end sub

	if founderr then
		call nav()
		call headline(2)
		call error()
	else
		call chktopic()
		if founderr then
		call nav()
		call headline(2)
		call error()
		else
		call nav()
		call headline(2)
		call showreform()
		call announceinfo()
		end if
	end if
	call endline()

	sub announceinfo()
	response.write "<hr width='"&tablewidth&"'>"
	set rs = server.CreateObject ("adodb.recordset")
	sql="Select UserName,Topic,dateandtime,body,announceid from bbs1 where boardid="&boardid&" and rootid="&rootid&" order by announceid"
	rs.open sql,conn,1,1
	do while not rs.eof
	if bgcolor=TableBodyColor then
		bgcolor=aTableBodyColor
		abgcolor=TableBodyColor
	else
		bgcolor=TableBodyColor
		abgcolor=aTableBodyColor
	end if
%>
<TABLE border=0 width="<%=tablewidth%>" align=center bgcolor="<%=bgcolor%>">
  <TBODY>
  <TR>
    <TD valign=middle align=top><font color="<%=TableContentColor%>">
--&nbsp;&nbsp;作者：<%=htmlencode(rs("username"))%><br>
--&nbsp;&nbsp;发布时间：<%=rs("dateandtime")%><br><br>
--&nbsp;&nbsp;<%=htmlencode(rs("topic"))%><br>
<%=ubbcode(rs("body"))%></font>
	<hr size=1>
    </TD></TR></TBODY></TABLE> 
<%
          rs.movenext
        loop	
	rs.close
	end sub
	set rs=nothing
%>
<!--#include file="footer.asp"-->
