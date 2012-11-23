<!--#include file="conn.asp"-->
<!-- #include file="inc/char.asp" -->
<!-- #include file="inc/const.asp" -->
<!--#include file="inc/form2.asp"-->
<!--#include file="inc/theme.asp"-->
<!-- #include file="chkuser.asp" -->
<%
   	dim AnnounceID
   	dim RootID
   	dim username
	dim rs_old
	dim old_user
   	dim con,content
	dim topic
   	dim olduser,oldpass
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
	if membername="" then
  		Errmsg=Errmsg+"<br>"+"<li>您没有<a href=login.asp>登录</a>，没有权限编辑贴子！"
		founderr=true
	end if
	if founderr then
		call nav()
		call headline(2)
		call error()
	else
		stats=boardtype & "编辑帖子"

		call nav()
		call headline(2)
		call edit()
		if founderr then
			call error()
		else
			call showeditForm()
		end if
	end if

	sub edit()
   	set rs=server.createobject("adodb.recordset")
	set rs_old = server.CreateObject ("adodb.recordset")
   	sql="select bbs1.username,bbs1.topic,bbs1.body,[user].userclass from bbs1,[user] where bbs1.username=[user].username and bbs1.AnnounceID="&AnnounceID
   	rs.open sql,conn,1,1
	if rs.eof and rs.bof then
		Errmsg=Errmsg+"<br>"+"<li>没有找到相应的帖子。"
		Founderr=true
	else
		topic=rs("topic")
   		con=rs("body")
		old_user=rs("username")
	if rs("username")<>Trim(membername) then
		if chkboardmaster(boardid)=false then
		Errmsg=Errmsg+"<br>"+"<li>版主只能编辑所在版面帖子。"
		Founderr=true
		elseif boardmaster and cint(rs("userclass"))=19 then
		Errmsg=Errmsg+"<br>"+"<li>同等级用户不能修改。"
		Founderr=true
		elseif master and cint(rs("userclass"))=20 then
		Errmsg=Errmsg+"<br>"+"<li>同等级用户不能修改。"
		Founderr=true
		elseif boardmaster and cint(rs("userclass"))=20 then
		Errmsg=Errmsg+"<br>"+"<li>不能修改等级比你高的用户贴子。"
		Founderr=true
		elseif not (boardmaster or master) then
		Errmsg=Errmsg+"<br>"+"<li>您的等级不足以修改别人的贴子。"
		Founderr=true
		end if
	end if
	end if
	rs.Close
	set rs=nothing
	end sub
	
call endline()
%>
<!--#include file="footer.asp"-->
