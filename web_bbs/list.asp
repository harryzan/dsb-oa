<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!-- #include file="chkuser.asp" -->
<!-- #include file="inc/char.asp" -->
<!-- #include file="inc/char_board.asp" -->
<!--#include file="inc/bbs_list.asp"-->
<!--#include file="inc/theme.asp"-->
<%
	Rem ----------------------
	Rem ------主程序开始------
	Rem ----------------------
	Dim currentPage
	Dim tl
	Dim Guests
	Dim limitime
	Dim Fast_action
	Dim totalrec
	Fast_action=false

	if boardmaster or master then
		guestlist=""
		Fast_action=true
	else
		guestlist=" lockboard=0 and "
		Fast_action=false
	end if
	if founderr then
		call nav()
		call headline(1)
		call error()
	else
    	call chkInput()
		if founderr then
			call nav()
			call headline(1)
			call error()
		else
			if cint(boardskin)=6 then
				if membername="" then
				response.write "<script>location.href='login.asp'</script>"
				response.end
				end if
			elseif cint(boardskin)=5 then
				if membername="" then
					founderr=true
					Errmsg=Errmsg+"<br>"+"<li>本论坛为认证论坛，请<a href=login.asp>登陆</a>并确认您的用户名已经得到管理员的认证后进入。"
				else
					if chkboardlogin(boardid,membername)=false then
					founderr=true
					Errmsg=Errmsg+"<br>"+"<li>本论坛为认证论坛，请确认您的用户名已经得到管理员的认证后进入。"
					end if
				end if
			end if
			if founderr then
				call nav()
				call headline(1)
				call error()
			else
				call nav()
				call headline(1)
				call boardtop(boardid)
				call AnnounceList1()
				call listPages3()
				call boardlist()
				if founderr=true then call error()
			end if
		end if
	end if
	call endline()
	REM 显示版面信息---Headinfo
	sub boardtop(boardid)
	response.write "<style>TABLE {BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 1px; }TD {BORDER-RIGHT: 0px; BORDER-TOP: 0px; color: "&TableContentColor&"; }</style>"

	dim onlinenum,guestnum
	onlinenum=online(boardid)
	guestnum=guest(boardid)

	response.write "<script language=javascript src=inc/list.js></script><TABLE cellSpacing=0 cellPadding=0 width="&TableWidth&" border=0 align=center>"&_
				"<TBODY><tr>"&_
				"<td align=center width=34 valign=middle> <img src="&picurl&P_call&" border=0 alt=本分论坛的公告！不可不看！！ width=20 height=17>"&_ 
				"</td><td valign=middle align=left>"

	sql="select top 1 title,addtime from bbsnews where boardid="&boardid&"  order by id desc"
	set rs=server.createobject("adodb.recordset")
	rs.open sql,conn,1,1
	if rs.bof and rs.eof then
		response.write "<b><a href='announcements.asp?boardid="& boardid &"' target=_blank><ACRONYM TITLE='当前没有公告'>当前没有公告</ACRONYM></a></b> ("& now() &")"
	else
		response.write "<b><a href='announcements.asp?boardid="& boardid &"' target=_blank>"& rs("title") &"</a></b> ("& rs("addtime") &")"
	end if
	rs.close
	set rs=nothing


	response.write "</td><td align=right valign=middle><p>"&_
				"<form action=list.asp method=get>"&_
				"<input type=hidden name=boardid value="& boardid &">"&_
				"</form></p></td></tr></TBODY></TABLE>"
	response.write "<table cellspacing=0 border=0 width="&TableWidth&" bgcolor="&Tablebackcolor&" align=center><tr><td height=1></td></tr></table>"&_
				"<TABLE border=1 cellpadding=0 cellspacing=0 width="&TableWidth&" align=center bordercolor="&Tablebackcolor&">"&_
  				"<TBODY>"&_
				"<TR>"&_
				"<TD height=27 width=""95%"" bgColor="&Tabletitlecolor&"><font color="&TableFontColor&">目前论坛总在线<b>"&allonline()&"</b>人，其中"& boardtype &"上共有 <b>"& onlinenum &"</b> 位会员与 <b>"& guestnum &"</b> 位客人.今日贴子 <font color="&AlertFontColor&"><b>"& todaynum &"</b></font> "

	if request("action")="show" then
		response.write "[<a href=list.asp?action=off&boardID="& boardid&"&amp;page=1&skin="& skin &"><font color="&TableFontcolor&">关闭详细列表</font></a>]"
	else
		if cint(online_u)=1 and request("action")<>"off" then
		response.write "[<a href=list.asp?action=off&boardID="& boardid&"&amp;page=1&skin="& skin &"><font color="&TableFontcolor&">关闭详细列表</font></a>]"
		else
		response.write "[<a href=list.asp?action=show&boardID="& boardid&"&amp;page=1&skin="& skin &"><font color="&TableFontcolor&">显示详细列表</font></a>]"
		end if
	end if

response.write "</TD><TD bgColor="&Tabletitlecolor&" width=""5%"" align=center><a href='list.asp?boardID="& boardid&"&amp;page=1&skin="& skin &"'>"&_
				"<img src="&picurl&P_reflash&" border=0 alt='刷新'></a></TD></TR>"

	if request("action")="off" then
		call onlineuser(0,0,boardid)
	elseif request("action")="show" then
		call onlineuser(1,1,boardid)
	else
		call onlineuser(online_u,online_g,boardid)
	end if
response.write "</td></tr></TBODY></TABLE><br>"

response.write "<table cellpadding=0 cellspacing=0 border=0 width="&TableWidth&" align=center valign=middle><tr>"&_
			"<td align=center width=2> </td>"&_
			"<td align=left> <a href='announce.asp?boardid="& boardid &"'>"&_
			"<img src="&picurl&P_post&" border=0 alt='发新帖'></a>"&_
			"</td>"&_
			"<td align=right><img src="&picurl&"team2.gif align=absmiddle>  "& master_2 &"</td></tr></table>"

	response.write "<table cellspacing=0 border=0 width="&TableWidth&" bgcolor="&Tablebackcolor&" align=center><tr><td height=1></td></tr></table>"
	response.write "<TABLE cellSpacing=0 cellPadding=0 width="&TableWidth&" border=1 align=center bordercolor="&Tablebackcolor&">"&_
				"<TBODY><tr><td><table width=100% cellSpacing=0 cellPadding=3><tr bgcolor="&TableBodyColor&">"&_
				"<td valign=middle height=25 width=50> <a href=AllPaper.asp?boardid="&boardid&" title=点击查看本论坛所有小字报><b>广播：</b></a> </td><td width=*> "
	response.write "<marquee scrolldelay=150 scrollamount=4 onmouseout=""if (document.all!=null){this.start()}"" onmouseover=""if (document.all!=null){this.stop()}"">"
	set rs=conn.execute("SELECT TOP 5 s_id,s_username,s_title FROM SmallPaper where datediff('d',s_addtime,Now())<=1 and s_boardid="&boardid&" ORDER BY s_addtime desc")
	do while not rs.eof
	response.write "<font color="&online_mc&">"&htmlencode(rs(1))&"</font>说：<a href=javascript:openScript('viewpaper.asp?id="&rs(0)&"&boardid="&boardid&"',500,400)>"&htmlencode(rs(2))&"</a>"
	rs.movenext
	loop
	rs.close
	set rs=nothing
	response.write "</marquee><td width=""35%"" align=right><a href=online.asp?boardid="&boardid&" title=查看本版在线详细情况>在线</a> | "
	if boardmaster or master then response.write "<a href='admin_boardaset.asp?boardid="& boardid &"'>管理</a> | "
	response.write "<a href=Boardhelp.asp?boardid="&boardid&" title=查看本版帮助>帮助</a>"
	response.write "</td></tr></table></td></tr></TBODY></TABLE>"
	end sub

	sub boardlist()

response.write "<table border=0 cellpadding=0 cellspacing=3 width="&TableWidth&" align=center>"&_
			"<tr>"&_
			"<td valign=middle nowrap> <div align=right>"&_
			"<select onchange=""if(this.options[this.selectedIndex].value!=''){location=this.options[this.selectedIndex].value;}"">"&_
			"<option selected>跳转论坛至...</option>"

	dim rs1,sql1
	sql="select id,class from class order by id"
	set rs=server.createobject("adodb.recordset")
	set rs1=server.createobject("adodb.recordset")
	rs.open sql,conn,1,1
	if not(rs.eof and rs.bof) then
	do while not rs.eof
	response.write "<option style=BACKGROUND-COLOR:"&TableTitleColor&">╋ "& rs(1) &"</option>"

		sql1="select boardid,boardtype from board where "&guestlist&" class="& rs(0)&" order by boardid"
		set rs1=server.createobject("adodb.recordset")
		rs1.open sql1,conn,1,1
		if rs1.eof and rs1.bof then
			rs1.close : set rs1=nothing
			response.write "<option>没有论坛</option>"
		else
			do while not rs1.eof
				response.write "<option value=""list.asp?boardid="&rs1(0)&""">　├" & rs1(1) & "</option>"
			rs1.movenext
			loop
			rs1.close
			set rs1=nothing
		end if

	rs.movenext
	loop
	rs.close
	set rs=nothing
	end if

	response.write "</select><div></td></tr></table>"
	end sub
    
	sub chkInput
        BoardID = Request("BoardID")
        currentPage=request("page")
		if BoardID="" or (not isInteger(BoardID)) or BoardID="0" then
			Errmsg=Errmsg+"<br>"+"<li>错误的版面参数！请确认您是从有效的连接进入。"
			founderr=true
		else
			BoardID=clng(BoardID)
			if err then
				BoardID=1
				err.clear
			end if
		end if
		if currentpage="" or not isInteger(currentpage) then
			currentpage=1
		else
			currentpage=clng(currentpage)
			if err then
				currentpage=1
				err.clear
			end if
		end if
		if request("selTimeLimit")="all" then
			tl=""
		elseif request("selTimeLimit")="" then
			tl=""
		else
			limitime=request("selTimeLimit")
			tl=" and dateandtime>=#"&cstr(cdate(now()-limitime))&"# "
		end if
	end sub

if instr(scriptname,"index.asp")>0 or instr(scriptname,"list.asp")>0 then
if index_moveFlag=1 then
call admove()
end if
if index_fixupFlag=1 then
call fixup()
end if
end if
%>
<!--#include file="online_l.asp"-->
<!--#include file="inc/ad_fixup.asp"-->
<!--#include file="footer.asp"-->
<iframe width=0 height=0 src="" id="hiddenframe"></iframe>
