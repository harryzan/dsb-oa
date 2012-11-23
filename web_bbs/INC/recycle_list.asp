<%
	sub AnnounceList1()
	
	sql="select AnnounceID,parentID,boardID,UserName,child,Topic,body,DateAndTime,hits,RootID,Expression,times,locktopic,istop,isbest,isvote from bbs1 where locktopic=2 order by announceid desc"
	set rs=server.createobject("adodb.recordset")
	rs.open sql,conn,1,1
	if err.number<>0 then
		rs.close
		set rs=nothing
		foundErr = true
		ErrMsg = "<li>数据库操作失败：" & err.description & "</li>"
	else
		if rs.bof and rs.eof then
			'论坛无内容
			call showEmptyBoard1()
			bBoardEmpty = true
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
	dim body
	dim vrs
	dim votenum,votenum_1
	dim pnum
	i=0
response.write "<form name=recycle action=admin_recycle.asp method=post><table cellspacing=0 border=0 width=95% bgcolor="&Tablebackcolor&" align=center><tr><td height=1></td></tr></table>"&_
				"<TABLE style=color:"&TableFontcolor&"  border=1 cellPadding=0 cellSpacing=0 width=95% align=center bordercolor="&Tablebackcolor&">"&_
  				"<TBODY>"&_
				"<TR align=middle>"&_
				"<TD height=27 width=32 bgColor="&Tabletitlecolor&"><font color="&TableFontcolor&">状态</TD>"&_ 
				"<TD bgColor="&Tabletitlecolor&" width=*><font color="&TableFontcolor&">主 题</TD>"&_
				"<TD bgColor="&Tabletitlecolor&" width=80><font color="&TableFontcolor&">作 者</TD>"&_
				"<TD bgColor="&Tabletitlecolor&" width=64><font color="&TableFontcolor&">回复/人气</TD>"&_
				"<TD bgColor="&Tabletitlecolor&" width=195><font color="&TableFontcolor&">最后更新 | 回复人</TD>"&_
				"</TR>"&_ 
				"</TBODY></TABLE>"
		while (not rs.eof) and (not page_count = rs.PageSize)
		

response.write "<TABLE style=color:"&TableContentColor&" border=1 cellPadding=0 cellSpacing=0 width=95% align=center bordercolor="&Tablebackcolor&">"&_
				"<TBODY><TR align=middle>"&_
				"<TD bgColor="&aTableBodyColor&" width=32 height=27>"

response.write "<input type=checkbox name=topicid value="&rs(0)&">"

response.write "</TD>"&_
				"<TD align=left bgcolor="&TableBodyColor&" width=* onmouseover=javascript:this.bgColor='"&aTableBodyColor&"' onmouseout=javascript:this.bgColor='"&TableBodyColor&"'>"
	response.write "<img src='face/"&rs("Expression")&"' width=15 height=15>"

	body=replace(htmlencode(left(rs(6),20)),"<BR>","")
	
response.write "<a href=""dispbbs.asp?boardID="& rs(2) &"&RootID="& rs(9) &"&ID="& rs(0)&""" title=""《"& htmlencode(rs(5)) &"》作者："& rs(3) &"发表于"& rs(7) &"最后跟贴："& body &"..."">"
if rs(5)="" or isnull(rs(5)) then
	response.write body
else
	if len(rs(5))>26 then
	response.write ""&left(htmlencode(rs(5)),26)&"..."
	else
	response.write htmlencode(rs(5))
	end if
end if
	response.write "</a>"
	Maxtitlelist=Cint(Maxtitlelist)
if rs(4)+1>Maxtitlelist then
	response.write "&nbsp;&nbsp;[分页："
	Pnum=(Cint(rs(4)+1)/Maxtitlelist)+1
	for p=1 to Pnum
	response.write " <a href='dispbbs.asp?boardID="& boardID &"&RootID="& rs(9) &"&ID="& rs(0) &"&star="&P&"'><FONT color=#990000><b>"&p&"</b></font></a> "
	next
	response.write "]"
end if

response.write "</TD>"&_
				"<TD bgColor="&aTableBodyColor&" width=80><a href=javascript:openUser('"& rs(3) &"')>"& rs(3) &"</a></TD>"&_
				"<TD bgColor="&TableBodyColor&" width=64>"
if rs(15)=1 then
	set vrs=conn.execute("select votenum from vote where announceid="& rs(0) &"")
	votenum=vrs("votenum")
	votenum=split(votenum,"|")
	dim iu
	for iu = 0 to ubound(votenum)
		votenum_1=cint(votenum_1)+votenum(iu)
	next
	response.write "<FONT color=#990000><b>"&votenum_1&"</b></font>  票"
	votenum_1=0
	vrs.close
	set vrs=nothing
else
	response.write "<font color="& TableContentColor &">"& rs(4) &"/"& rs(8) &"</font>"
end if

response.write "</TD><TD align=left bgColor="& aTableBodyColor &" width=195>&nbsp;"

	'on error resume next
		response.write "&nbsp;"&_
						FormatDateTime(rs(7),2)&"&nbsp;"&FormatDateTime(rs(7),4)&_
						"&nbsp;<font color=#990000>|</font>&nbsp;------"

response.write "</TD></TR>"&_
				"</TBODY></TABLE>"

	  page_count = page_count + 1
          rs.movenext
        wend
	if err.number<>0 then err.clear
	end sub


	sub listPages3()
	dim endpage
	'on error resume next
	if master then
response.write "<table cellspacing=0 border=0 width=95% bgcolor="&Tablebackcolor&" align=center><tr><td height=1></td></tr></table>"&_
				"<TABLE style=color:"&TableFontcolor&"  border=1 cellPadding=0 cellSpacing=0 width=95% align=center bordercolor="&Tablebackcolor&">"&_
  				"<TBODY>"&_
				"<TR>"&_
				"<TD height=27 width=""100%"" bgColor="&Tabletitlecolor&"><input type=checkbox name=chkall value=on onclick=""CheckAll(this.form)"">选中所有显示帖子&nbsp;<input type=submit name=action onclick=""{if(confirm('确定删除选定的纪录吗?')){this.document.recycle.submit();return true;}return false;}"" value=删除>&nbsp;<input type=submit name=action onclick=""{if(confirm('确定还原选定的纪录吗?')){this.document.recycle.submit();return true;}return false;}"" value=还原>&nbsp;<input type=submit name=action onclick=""{if(confirm('确定清除回收站所有的纪录吗?')){this.document.recycle.submit();return true;}return false;}"" value=清空回收站></TD>"&_ 
				"</TR></form>"&_ 
				"</TBODY></TABLE>"
	end if
	Pcount=rs.PageCount
	response.write "<table border=0 cellpadding=0 cellspacing=3 width="""&tablewidth&""" align=center>"&_
			"<tr><td valign=middle nowrap>"&_
			"<font color="&bodyfontColor&">页次：<b>"&currentpage&"</b>/<b>"&Pcount&"</b>页"&_
			"每页<strong>"&MaxAnnouncePerpage&"</b> 贴数<b>"&totalrec&"</b></td>"&_
			"<td valign=middle nowrap><div align=right><p>分页： <b>"

	if currentpage > 4 then
	response.write "<a href=""?page=1"">[1]</a> ..."
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
        response.write " <a href=""?page="&i&""">["&i&"]</a>"
		end if
	end if
	next
	if currentpage+3 < Pcount then 
	response.write "... <a href=""?page="&Pcount&""">["&Pcount&"]</a></b>"
	end if
	response.write "</p></div></font></td></tr></table>"
	rs.close
	set rs=nothing
	end sub 

	sub showEmptyBoard1()
		response.write "<TABLE style=color:"&TableFontcolor&" bgColor='"&Tablebackcolor&"' border=0 cellPadding=4 cellSpacing=1 width=95% align=center>"&_
			"<TBODY>"&_
			"<TR align=middle bgColor='"&Tabletitlecolor&"'>"&_
			"<TD height=25><font color="&TableFontcolor&">状态</font></TD>"&_
			"<TD><font color="&TableFontcolor&">主 题  (点心情符为开新窗浏览)</TD>"&_
			"<TD><font color="&TableFontcolor&">作 者</TD> "&_
			"<TD><font color="&TableFontcolor&">回复/人气</TD> "&_
			"<TD><font color="&TableFontcolor&">最新回复</TD></TR> "&_
			"<tr bgColor="&TableBodyColor&"><td colSpan=5 width=100% >论坛回收站暂无内容。</td></tr>"&_
			"</TBODY></TABLE>"
	end sub
%>