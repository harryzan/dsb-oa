<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!-- #include file="chkuser.asp" -->
<!-- #include file="inc/char.asp" -->
<!--#include file="inc/theme.asp"-->
<script language="javascript">
     function viewPage2(ipage){
        document.frmList2.Page.value=ipage
        document.frmList2.submit()        
     }
     function viewPage1(ipage){
        document.frmList2.Page.value=ipage
        document.frmList2.submit()        
     }

</script>
<%
    	Rem ----------------------
    	Rem ------主程序开始------
    	Rem ----------------------
	dim Ers,Esql
	dim totalrec
	dim currentpage,page_count,Pcount
	dim guests

	if boardmaster or master then
		guestlist=""
	else
		guestlist=" lockboard=0 and "
	end if
	stats="论坛精华"
	if founderr then
		call nav()
		call headline(2)
		call error()
	else
    		call chkInput()
		if founderr then
			call nav()
			call headline(2)
			call error()
		else
			if founderr then
				call nav()
				call headline(2)
				call error()
			else
				call nav()
				call headline(2)
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

	response.write "<style>TABLE {BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 1px; }TD {BORDER-RIGHT: 0px; BORDER-TOP: 0px; color: #000000; }</style><TABLE border=0 width="&TableWidth&" align=center>"&_
				"<TABLE cellSpacing=0 cellPadding=0 width="&TableWidth&" border=0 align=center>"&_
				"<TBODY><tr>"&_
				"<td align=center width=34 valign=middle> <img src="&picurl&P_call&" border=0 alt=本分论坛的公告！不可不看！！ width=20 height=17>"&_ 
				"</td><td valign=middle align=left>"

	sql="select top 1 title,addtime from bbsnews where boardid="&boardid&"  order by id desc"
	set rs=server.createobject("adodb.recordset")
	rs.open sql,conn,0,1
	if rs.bof and rs.eof then
		response.write "<b><a href='announcements.asp?boardid="& boardid &"' target=_blank><ACRONYM TITLE='当前没有公告'>当前没有公告</ACRONYM></a></b> ("& now() &")"
	else
		response.write "<b><a href='announcements.asp?boardid="& boardid &"' target=_blank>"& rs("title") &"</a></b> ("& rs("addtime") &")"
	end if
	rs.close
	set rs=nothing

	response.write "</td><td align=right valign=middle></td></tr></TBODY></TABLE>"

	dim onlinenum,guestnum
	onlinenum=online(boardid)
	guestnum=guest(boardid)
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

response.write "&nbsp;[<a href=online.asp?boardid="&boardid&"><font color="&TableFontColor&">在线用户</font></a>]</TD><TD bgColor="&Tabletitlecolor&" width=""5%"" align=center><a href='list.asp?boardID="& boardid&"&amp;page=1&skin="& skin &"'>"&_
				"<img src="&picurl&P_reflash&" border=0 alt='刷新'></a></TD></TR>"

	if request("action")="off" then
		call onlineuser(0,0,boardid)
	elseif request("action")="show" then
		call onlineuser(1,1,boardid)
	else
		call onlineuser(online_u,online_g,boardid)
	end if
response.write "</td></tr></TBODY></TABLE>"

response.write "<br><table cellpadding=0 cellspacing=0 border=0 width="&TableWidth&" align=center><tr>"&_
			"<td align=center width=2 valign=middle> </td>"&_
			"<td align=left valign=middle> <a href='announce.asp?boardid="& boardid &"'>"&_
			"<img src="&picurl&P_post&" border=0 alt='发新帖'></a>"&_
			"&nbsp;&nbsp;<a href='vote.asp?boardid="&boardid&"'>"&_
			"<img src="&picurl&P_vote&" border=0 alt='发起新投票'></a></td>"&_
			"<td align=right> "
response.write "　 <b>论坛版主</b>："& master_2 &"</td></tr></table>"
	end sub

	sub boardlist()

response.write "<table border=0 cellpadding=0 cellspacing=3 width="&TableWidth&" align=center>"&_
			"<form action=list.asp method=get><tr>"&_
			"<td valign=middle nowrap> <div align=right>"&_
			"<select name='boardid' onchange='javascript:submit()'>"&_
			"<option value=''>跳转论坛<option value=''>"

	dim rs1,sql1
	sql="select id,class from class order by id"
	set rs=server.createobject("adodb.recordset")
	set rs1=server.createobject("adodb.recordset")
	rs.open sql,conn,1,1
	if not(rs.eof and rs.bof) then
	do while not rs.eof
	response.write "<option value='1'>>>&nbsp;"& rs(1) &" <<"

		sql1="select boardid,boardtype from board where "&guestlist&" class="& rs(0)&" order by boardid"
		set rs1=server.createobject("adodb.recordset")
		rs1.open sql1,conn,1,1
		if rs1.eof and rs1.bof then
			rs1.close : set rs1=nothing
			response.write "<option value=''>没有论坛"
		else
			do while not rs1.eof
				response.write "<option value='"& rs1(0) &"'>"& rs1(1)
			rs1.movenext
			loop
			rs1.close
			set rs1=nothing
		end if

	response.write "<option value=''>"

	rs.movenext
	loop
	rs.close
	set rs=nothing
	end if

	response.write "</select><div></td></tr></form></table>"

	response.write "<table cellspacing=0 cellpadding=0 width="&TableWidth&" align=center bgcolor="& Tablebackcolor &" border=0>"&_
				"<tr><td><table cellspacing=1 cellpadding=3 width=100% border=0><tr bgcolor="& Tabletitlecolor &">"&_
				"<td width=80% ><font color="& TableFontColor &"><b>　-=> "& ForumName &"图例</b></font></td>"&_
				"<td noWrap width=20% align=right><font color="& TableFontColor &">所有时间均为 - "&GMT&" &nbsp;</td>"&_
				"</tr><tr><td colspan=3 bgcolor="& TableBodyColor &">"&_
				"<table cellspacing=4 cellpadding=0 width=92% border=0 align=center>"&_
				"<tr><td><img src="&picurl&P_opentopic&"> 开放的主题</td>"&_
				"<td><img src="&picurl&P_hottopic&"> 回复超过10贴</td>"&_
				"<td><img src="&picurl&P_closetopic&"> 锁定的主题</td>"&_
				"<td><img src="&picurl&P_istop&"> 固定顶端的主题 </td>"&_
				"<td> <img src="&picurl&P_Tisbest&"> 精华帖子 </td>"&_
				"<td> <img src="&picurl&P_isvote&"> 投票帖子 </td>"&_
				"</tr>"


response.write "</table></td></tr></table></td></tr></table><BR>"
	end sub

	sub AnnounceList1()	
	'on error resume next

	sql="select AnnounceID,boardID,UserName,child,Topic,body,DateAndTime,hits,RootID,Expression from bbs1 where boardID="&cstr(boardID)&" and isbest=1 ORDER BY announceid desc"
	'response.write sql
	set rs=server.createobject("adodb.recordset")
	rs.open sql,conn,1,1
	if err.number<>0 then
		foundErr = true
		ErrMsg = "<li>数据库操作失败：" & err.description & "</li>"
	else
		if rs.bof and rs.eof then
			'论坛无内容
			call showEmptyBoard1()
		else
			rs.PageSize = MaxAnnouncePerpage
			rs.AbsolutePage=currentpage
			page_count=0
      		totalrec=rs.recordcount
			call showpagelist1() 
		end if
	end if				
		if err.number<>0 then err.clear	
	end sub

	REM 显示贴子列表	
	sub showPageList1()
	i=0

response.write "<table cellspacing=0 border=0 width="&TableWidth&" bgcolor="&Tablebackcolor&" align=center><tr><td height=1></td></tr></table>"&_
				"<TABLE style=color:"&TableFontcolor&"  border=1 cellPadding=0 cellSpacing=0 width="&TableWidth&" align=center bordercolor="&Tablebackcolor&">"&_
  				"<TBODY>"&_
				"<TR align=middle>"&_
				"<TD height=27 width=32 bgColor="&Tabletitlecolor&"><font color="&TableFontcolor&">状态</font></TD>"&_ 
				"<TD bgColor="&Tabletitlecolor&" width=*><font color="&TableFontcolor&">主 题</font></TD>"&_
				"<TD bgColor="&Tabletitlecolor&" width=80><font color="&TableFontcolor&">作 者</font></TD>"&_
				"<TD bgColor="&Tabletitlecolor&" width=64><font color="&TableFontcolor&">回复/人气</font></TD>"&_
				"<TD bgColor="&Tabletitlecolor&" width=195><font color="&TableFontcolor&">最后更新 | 回复人</font></TD>"&_
				"</TR>"&_ 
				"</TBODY></TABLE>"
       while (not rs.eof) and (not page_count = rs.PageSize)
response.write "<TABLE style=color:"&TableContentColor&" border=1 cellPadding=0 cellSpacing=0 width="&TableWidth&" align=center bordercolor="&Tablebackcolor&">"&_
				"<TBODY><TR align=middle>"&_
				"<TD bgColor="&aTableBodyColor&" width=32 height=27>"

response.write "<img src="""&picurl&P_Tisbest&""" alt=精华帖子>"

response.write "</TD>"&_
				"<TD align=left bgcolor="&TableBodyColor&" width=* onmouseover=javascript:this.bgColor='"&aTableBodyColor&"' onmouseout=javascript:this.bgColor='"&TableBodyColor&"'><font color="&Tablecontentcolor&">"

response.write "  <img src='"& faceurl & rs("Expression") &"' width=15 height=15>  "

response.write "<a href=""dispbbs.asp?boardID="& boardID &"&RootID="& rs("rootid") &"&ID="& rs("announceid")&"&skin=1"">"

if isnull(rs("topic")) or rs("topic")="" then
response.write left(rs("body"),26)
else
if len(rs("topic"))>26 then
	response.write ""&left(rs("topic"),26)&"..."
else
	response.write rs("topic")
end if
end if
	response.write "</a>"

response.write "</font></TD>"&_
				"<TD bgColor="&aTableBodyColor&" width=80><a href=dispuser.asp?name="& rs("username") &" target=_blank>"& rs("username") &"</a></TD>"&_
				"<TD bgColor="&TableBodyColor&" width=64><font color="&Tablecontentcolor&">"
	response.write rs("child") &"/"& rs("hits")

response.write "</font></TD><TD align=left bgColor="& aTableBodyColor &" width=195><font color="&TableContentcolor&">&nbsp;"

response.write "&nbsp;"&_
						FormatDateTime(rs("dateandtime"),2)&"&nbsp;"&FormatDateTime(rs("dateandtime"),4)&_
						"&nbsp;<font color="&alertfontcolor&">|</font>&nbsp;"
response.write "------</font>"

response.write "</TD></TR></TBODY></TABLE>"
	  page_count = page_count + 1
          rs.movenext
        wend
		if err.number<>0 then err.clear
	end sub

	sub listPages3()
	dim endpage
	Pcount=rs.PageCount
	response.write "<table border=0 cellpadding=0 cellspacing=3 width="""&TableWidth&""" align=center>"&_
			"<tr><td valign=middle nowrap>"&_
			"<font color="&bodyfontcolor&">页次：<b>"&currentpage&"</b>/<b>"&Pcount&"</b>页"&_
			"每页<strong>"&MaxAnnouncePerpage&"</strong> 精华贴数<b>"&totalrec&"</b></font></td>"&_
			"<td valign=middle nowrap><div align=right><font color="&bodyfontcolor&"><p>分页： "

	if currentpage > 4 then
	response.write "<a href=""?page=1&boardid="&boardid&""">[1]</a> ..."
	end if
	if Pcount>currentpage+3 then
	endpage=currentpage+3
	else
	endpage=Pcount
	end if
	for i=currentpage-3 to endpage
	if not i<1 then
		if i = clng(currentpage) then
        response.write " <font color="&AlertFontColor&">["&i&"]</font>"
		else
        response.write " <a href=""?page="&i&"&boardid="&boardid&""">["&i&"]</a>"
		end if
	end if
	next
	if currentpage+3 < Pcount then 
	response.write "... <a href=""?page="&Pcount&"&boardid="&boardid&""">["&Pcount&"]</a>"
	end if
	response.write "</p></font></div></td></tr></table>"
	rs.close
	set rs=nothing
	end sub 

	sub showEmptyBoard1()
%>
<TABLE bgColor='<%=Tablebackcolor%>' border=0 cellPadding=4 cellSpacing=1 width="<%=TableWidth%>" align=center>
  <TBODY>
  <TR bgColor='<%=Tabletitlecolor%>'>
    <TD align=middle noWrap height=25><font color=<%=TableFontcolor%>>状态</font></TD> 
    <TD align=middle noWrap><font color=<%=TableFontcolor%>>主 题  (点心情符为开新窗浏览)</font></TD> 
    <TD align=middle noWrap><font color=<%=TableFontcolor%>>作 者 </font></TD> 
    <TD align=middle noWrap><font color=<%=TableFontcolor%>>回复/人气</font></TD> 
    <TD align=middle noWrap><font color=<%=TableFontcolor%>>最新回复</font></TD></TR> 
  <tr bgColor="<%=Tablebodycolor%>"><td colSpan=5 vAlign=center width="100%"><font color="<%=tablecontentcolor%>">本精华版面暂无内容，欢迎发帖：）</td></tr>
</TBODY></TABLE>
<%
	end sub
    
    	sub chkInput
		'on error resume next
        	BoardID = Request("BoardID")
        	currentPage=request("page")
		if BoardID="" then
			BoardID=1
		elseif not isInteger(BoardID) then
			BoardID=1
		else
			BoardID=clng(BoardID)
			if err then
				BoardID=1
				err.clear
			end if
		end if
		if currentpage="" then
			currentpage=1
		elseif not isInteger(currentpage) then
			currentpage=1
		else
			currentpage=clng(currentpage)
			if err then
				currentpage=1
				err.clear
			end if
		end if
    	end sub
	set rs=nothing
	
%>
<!--#include file="footer.asp"-->
<!--#include file="online_l.asp"-->
