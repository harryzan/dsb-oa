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
		Errmsg=Errmsg+"<br>"+"<li>��ָ����̳���档"
	elseif not isInteger(request("boardid")) then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>�Ƿ��İ��������"
	else
		boardid=request("boardid")
	end if
	if request("id")="" then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>��ָ��������ӡ�"
	elseif not isInteger(request("id")) then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>�Ƿ������Ӳ�����"
	else
		AnnounceID=request("id")
	end if
	if request("RootID")="" then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>��ָ��������ӡ�"
	elseif not isInteger(request("RootID")) then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>�Ƿ������Ӳ�����"
	else
		RootID=request("RootID")
	end if
	if membername="" then
  		Errmsg=Errmsg+"<br>"+"<li>��û��<a href=login.asp>��¼</a>��û��Ȩ�ޱ༭���ӣ�"
		founderr=true
	end if
	if founderr then
		call nav()
		call headline(2)
		call error()
	else
		stats=boardtype & "�༭����"

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
		Errmsg=Errmsg+"<br>"+"<li>û���ҵ���Ӧ�����ӡ�"
		Founderr=true
	else
		topic=rs("topic")
   		con=rs("body")
		old_user=rs("username")
	if rs("username")<>Trim(membername) then
		if chkboardmaster(boardid)=false then
		Errmsg=Errmsg+"<br>"+"<li>����ֻ�ܱ༭���ڰ������ӡ�"
		Founderr=true
		elseif boardmaster and cint(rs("userclass"))=19 then
		Errmsg=Errmsg+"<br>"+"<li>ͬ�ȼ��û������޸ġ�"
		Founderr=true
		elseif master and cint(rs("userclass"))=20 then
		Errmsg=Errmsg+"<br>"+"<li>ͬ�ȼ��û������޸ġ�"
		Founderr=true
		elseif boardmaster and cint(rs("userclass"))=20 then
		Errmsg=Errmsg+"<br>"+"<li>�����޸ĵȼ�����ߵ��û����ӡ�"
		Founderr=true
		elseif not (boardmaster or master) then
		Errmsg=Errmsg+"<br>"+"<li>���ĵȼ��������޸ı��˵����ӡ�"
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
