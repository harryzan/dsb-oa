<!-- #include file="conn.asp" -->
<!-- #include file="inc/char.asp" -->
<!-- #include file="inc/const.asp" -->
<!-- #include file="chkuser.asp" -->
<!--#include file="inc/theme.asp"-->
<!--#include file="inc/Form.asp"-->
<!-- #include file="inc/char_board.asp" -->
<%
	rem ----------------------
	rem ------主程序开始------
	rem ----------------------

	dim boardstat
   	boardid=request("boardid")
	if BoardID="" or not isInteger(BoardID) then
		BoardID=1
	else
		BoardID=clng(BoardID)
		if err then
			BoardID=1
			err.clear
		end if
	end if
	select case boardskin
	case 1
		boardstat="常规论坛，只允许<a href=reg.asp><font color="&TableContentcolor&">注册会员</a>发言"
	case 2
		boardstat="开放论坛，允许所有人发言"
	case 3
		boardstat="评论论坛，坛主和版主允许发言，其他<a href=reg.asp><font color="&TableContentcolor&">注册用户</font></a>只能回复"
		if not(boardmaster or master) then
		Founderr=true
		Errmsg=Errmsg+"<br>"+"<li>评论论坛，坛主和版主允许发言，其他<a href=reg.asp><font color="&TableContentColor&">注册用户</font></a>只能回复"
		end if
	case 4
		boardstat="精华区，只允许版主和坛主发言和操作"
		if not(boardmaster or master) then
		Founderr=true
		Errmsg=Errmsg+"<br>"+"<li>精华区，只允许版主和坛主发言和操作"
		end if
	case 5
		boardstat="认证论坛，除坛主和版主外，其他<a href=reg.asp><font color="&TableContentColor&">注册用户</font></a>登陆论坛需要认证"
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
		boardstat="正规论坛，只有<a href=login.asp><font color="&TableContentColor&">登陆用户</a>才能浏览论坛并发言"
		if membername="" then
		Founderr=true
		Errmsg=Errmsg+"<br>"+"<li>正规论坛，只有<a href=login.asp><font color="&TableContentColor&">登陆用户</a>才能浏览论坛并发言"
		end if
	end select
	
	stats=""&boardtype&"发言"
	if founderr then
		call nav()
		call headline(2)
		call error()
	else
		call nav()
		call headline(2)
		call showForm()
	end if
	call endline()
   	rem ----------------------
	rem ------主程序结束------
	rem ----------------------

%>
<!--#include file="footer.asp"-->
