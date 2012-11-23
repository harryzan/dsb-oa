<!-- #include file="conn.asp" -->
<!-- #include file="inc/char.asp" -->
<!-- #include file="inc/const.asp" -->
<!-- #include file="chkuser.asp" -->
<!--#include file="inc/theme.asp"-->
<%
	rem ----------------------
	rem ------主程序开始------
	rem ----------------------
	dim announceid
	dim action
	dim vote,votenum
	dim postvote(50)
	dim postvote1
	dim j,votenum_1,votenumlen
	stats="投票"
	if VoteFlag=1 then
	membername="客人"
	else
	membername=LCase(membername)
	end if
	if request("boardid")="" then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>请指定论坛版面。"
	elseif not isInteger(request("boardid")) then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>非法的版面参数。"
	else
		boardid=request("boardid")
	end if
	if request("announceid")="" then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>请指定相关贴子。"
	elseif not isInteger(request("announceid")) then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>非法的贴子参数。"
	else
		AnnounceID=request("announceid")
	end if
	if membername="" or founderr then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>请登陆后进行投票。"
	else
	set rs=server.createobject("adodb.recordset")
	sql="select * from vote where announceid="&announceid
	rs.open sql,conn,1,3
	if rs.eof and rs.bof then
		Errmsg=Errmsg+"<br>"+"<li>请您选择投票的主题进行投票。"
		Founderr=true
	else
		if instr(rs("voteuser"),membername)>0 and VoteFlag=0 then
		Errmsg=Errmsg+"<br>"+"<li>您已经投过票了。"
		Founderr=true
		else
		votenum=split(rs("votenum"),"|")
		if rs("votetype")=1 then
		for i = 0 to ubound(votenum)
			postvote(i)=request("postvote_"&i&"")
		next
		end if
		for j = 0 to ubound(votenum)
		if rs("votetype")=0 then
			if cint(request("postvote"))=j then
				votenum(j)=votenum(j)+1
			end if
			votenum_1=""&votenum_1&""&votenum(j)&"|"
		else
			if postvote(j)<>"" then
				if cint(postvote(j))=j then
					votenum(j)=votenum(j)+1
				end if
			end if
			votenum_1=""&votenum_1&""&votenum(j)&"|"
		end if
		next
		votenumlen=len(votenum_1)
		votenum_1=left(votenum_1,votenumlen-1)
		rs("voteuser")=""&rs("voteuser")&"|"&membername&""
		rs("votenum")=votenum_1
		rs.update
		end if
	end if
	rs.close
	set rs=nothing
	end if

	if founderr then
		call nav()
		call headline(1)
		call error()
		call endline()
	else
		dim maxid
		set rs=conn.execute("select top 1 announceid from bbs1 order by announceid desc")
		maxid=rs("announceid")
		sql="update bbs1 set times="&maxid&" where announceid="&cstr(announceid)
		conn.execute(sql)
		set rs=nothing
		conn.close
		set conn=nothing
		response.redirect("list.asp?boardid="&boardid&"")
	end if
   	rem ----------------------
	rem ------主程序结束------
	rem ----------------------
	stats="投票"
%>

<!--#include file="footer.asp"-->
