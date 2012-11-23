<%
	sub AnnounceList1()
	dim topNum,n
	dim announceIDRange1,announceIDRange2
	'sql="select count(Announceid) from bbs1 where istop=1 and layer=1 and boardid="&boardid
	set rs=server.createobject("adodb.recordset")
	'rs.open sql,conn,0,1
	'topNum=rs(0)
	'rs.close
	if currentPage>1 then
'	sql="select top "&MaxAnnouncePerPage&"  AnnounceID,parentID,boardID,UserName,child,Topic,DateAndTime,hits,RootID,locktopic,istop,isbest,isvote,LastPost from bbs1 where boardID="&cstr(boardID)&" and parentID=0 and times < all (select top "&(currentPage-1)*MaxAnnouncePerPage-topNum&" times from bbs1 where boardID="&cstr(boardID)&" and istop=0 and parentID=0 order by times desc) "&tl&" and not locktopic=2 ORDER BY istop desc,times desc,announceid desc"
	sql="select AnnounceID,times from bbs1 where boardID="&cstr(boardID)&" and parentID=0 and istop=0  "&tl&" ORDER BY times desc"
	rs.open sql,conn,1,1
	if err.number<>0 then
		foundErr = true
		ErrMsg = "<li>数据库操作失败：" & err.description & "</li>"
	else
		if rs.bof and rs.eof then
			call showEmptyBoard()
			bBoardEmpty = true
		else
			totalrec=RS.RecordCount 
			if totalrec mod MaxAnnouncePerPage =0 then 
				n=totalrec\MaxAnnouncePerPage
			else
				n=totalrec\MaxAnnouncePerPage+1
			end if
	
			RS.PageSize=MaxAnnouncePerPage
			currentpage =  Request("page")
			If currentpage <> "" then
				currentpage =  cint(currentpage)
				if currentpage<1 then  
					currentpage = 1
				end if  
				if err.number<>0 then 
					err.clear
					currentpage=1
				end if
			else
				currentpage = 1
			End if
			if currentpage*MaxAnnouncePerPage>totalrec and not((currentpage-1)*MaxAnnouncePerPage<totalrec)then currentPage=1
				Rs.AbsolutePage = currentpage
				announceIDRange1=rs("times")
				rs.move MaxAnnouncePerPage-1
				if rs.EOF then rs.movelast
				announceIDRange2=rs("times")
				
			end if
		end if
	rs.close
	sql="select AnnounceID,parentID,boardID,UserName,child,Topic,DateAndTime,hits,RootID,locktopic,istop,isbest,isvote,LastPost from bbs1 where BoardID=" & boardID & " and ParentID=0 and ( times >= " & announceIDRange2 &  " and times <=" & announceIDRange1 & " ) ORDER BY times desc"
	else
	sql="select top "&MaxAnnouncePerPage&"  AnnounceID,parentID,boardID,UserName,child,Topic,DateAndTime,hits,RootID,locktopic,istop,isbest,isvote,LastPost from bbs1 where boardID="&cstr(boardID)&" and parentID=0 "&tl&" and not locktopic=2 ORDER BY istop desc,times desc,announceid desc"
	end if
	'response.write sql
	'response.end
	rs.open sql,conn,1,1
	if err.number<>0 then
		rs.close
		set rs=nothing
		foundErr = true
		ErrMsg = "<li>数据库操作失败：" & err.description & "</li>"
	else
		if rs.bof and rs.eof then
			call showEmptyBoard1()
		else
      			if currentpage<1 then currentpage=1 
			MaxAnnouncePerpage=Clng(MaxAnnouncePerpage)
   			call showpagelist1() 
		end if
		rs.close
		set rs=nothing
		end if
	if err.number<>0 then err.clear	
	end sub


	REM 显示贴子列表	
	sub showPageList1()
	Dim LastPost
	dim Lastuser
	dim LastID
	dim LastTime
	dim body
	dim Pnum,p,vrs,votenum,votenum_1
	response.write "<TABLE border=1 cellPadding=0 cellSpacing=0 width="&TableWidth&" align=center bordercolor="&Tablebackcolor&">"&_
  				"<TBODY>"&_
				"<TR align=middle>"&_
				"<TD height=27 width=32 bgColor="&Tabletitlecolor&"><a href=list.asp?boardid="&boardid&"&page="&currentpage&"&action=batch><font color="&TableFontcolor&">状态</font></a></TD>"&_ 
				"<TD bgColor="&Tabletitlecolor&" width=*><font color="&TableFontcolor&">主 题  (点<img src="&picurl&"plus.gif>即可展开贴子列表)</font></TD>"&_
				"<TD bgColor="&Tabletitlecolor&" width=80><font color="&TableFontcolor&">作 者</font></TD>"&_
				"<TD bgColor="&Tabletitlecolor&" width=64><font color="&TableFontcolor&">回复/人气</font></TD>"&_
				"<TD bgColor="&Tabletitlecolor&" width=195><font color="&TableFontcolor&">最后更新 | 回复人</font></TD>"&_
				"</TR>"&_ 
				"</TBODY></TABLE>"
	'AnnounceID=0,parentID=1,boardID=2,UserName=3,child=4,Topic=5
	'DateAndTime=6,hits=7,RootID=8,locktopic=9,istop=10,isbest=11,isvote=12,LastPost=13
	do while not rs.eof
	response.write "<TABLE border=1 cellPadding=0 cellSpacing=0 width="&TableWidth&" align=center bordercolor="&Tablebackcolor&">"&_
				"<TBODY><TR align=middle>"&_
				"<TD bgColor="&aTableBodyColor&" width=32 height=27>"
if request("action")="batch" then
	response.write "<form action=admin_batch.asp method=post name=batch><input type=checkbox name=Announceid value="&rs(0)&">"
else
if rs(10)<>1 and lockboard<>1 and rs(9)<>1 and rs(12)<>1 and rs(11)<>1 and rs(4)<10 then
	response.write "<img src="""&picurl&P_opentopic&""" alt=开放主题>"
elseif rs(12)=1 then
	response.write "<img src="""&picurl&P_isvote&""" alt=投票贴子>"
elseif rs(10)=1 then
	response.write "<img src="""&picurl&P_istop&""" alt=固顶主题>"
elseif rs(11)=1 then
	response.write "<img src="""&picurl&P_Tisbest&""" alt=精华帖子>"
elseif rs(4)>=10 then
	response.write "<img src="""&picurl&P_hotTopic&""" alt=热门主题>"
elseif rs(9)=1 then
	response.write "<img src="""&picurl&P_closeTopic&""" alt=本主题已锁定>"
elseif lockboard=1 then
	response.write "<img src="""&picurl&P_closeTopic&""" alt=本论坛已锁定>"
else
	response.write "<img src="""&picurl&P_opentopic&""" alt=开放主题>"
end if
end if
response.write "</TD>"&_
				"<TD align=left bgcolor="&TableBodyColor&" width=* onmouseover=javascript:this.bgColor='"&aTableBodyColor&"' onmouseout=javascript:this.bgColor='"&TableBodyColor&"'>"
if rs(4)=0 then
	response.write "<img src='"& picurl &"nofollow.gif' id='followImg"& rs(8) &"'>"
else
	response.write "<img loaded=no src='"& picurl &"plus.gif' id='followImg"& rs(8) &"' style='cursor:hand;' onclick='loadThreadFollow("& rs(8) &","& rs(0) &","& boardid &")' title=展开贴子列表>"
end if
if not isnull(rs(13)) then
	LastPost=split(rs(13),"$")
	if ubound(LastPost)=4 then
	Lastuser=htmlencode(LastPost(0))
	LastID=LastPost(1)
	LastTime=LastPost(2)
	body=htmlencode(LastPost(3))
	if not isnull(LastPost(4)) and LastPost(4)<>"" then response.write "<img src="&picurl&LastPost(4)&".gif height=16 width=16>"
	end if
else
	Lastuser=""
	LastID=rs(0)
	LastTime=rs(6)
	body="..."
end if
response.write "<a href=""dispbbs.asp?boardID="& boardID &"&RootID="& rs(8) &"&ID="& rs(0)&""" title=""《"& htmlencode(rs(5)) &"》<br>作者："& htmlencode(rs(3)) &"<br>发表于"& rs(6) &"<br>最后跟贴："& body &"..."">"

if len(rs(5))>26 then
	response.write left(htmlencode(rs(5)),26)&"..."
else
	response.write htmlencode(rs(5))
end if
	response.write "</a>"
	Maxtitlelist=Cint(Maxtitlelist)
if rs(4)>Maxtitlelist then
	response.write "&nbsp;&nbsp;[<img src="&picurl&"multipage.gif><b>"
  	if rs(4) mod Maxtitlelist=0 then
     		Pnum= rs(4) \ Maxtitlelist
  	else
     		Pnum= rs(4) \ Maxtitlelist+1
  	end if
	for p=1 to Pnum
	response.write " <a href='dispbbs.asp?boardID="& boardID &"&RootID="& rs(8) &"&ID="& rs(0) &"&star="&P&"'><font color="&AlertFontcolor&">"&p&"</font></a> "
	if p+1>7 then
	response.write "... <a href='dispbbs.asp?boardID="& boardID &"&RootID="& rs(8) &"&ID="& rs(0) &"&star="&Pnum&"'><font color="&AlertFontcolor&">"&Pnum&"</font></a>"
	exit for
	end if
	next
	response.write "</b>]"
end if

response.write "</TD>"&_
				"<TD bgColor="&aTableBodyColor&" width=80><a href=dispuser.asp?name="& htmlencode(rs(3)) &" target=_blank>"& htmlencode(rs(3)) &"</a></TD>"&_
				"<TD bgColor="&TableBodyColor&" width=64>"
if rs(12)=1 then
	set vrs=conn.execute("select votenum from vote where announceid="& rs(0) &"")
	if not(vrs.eof and vrs.bof) then
	votenum=vrs("votenum")
	votenum=split(votenum,"|")
	dim iu
	for iu = 0 to ubound(votenum)
		votenum_1=cint(votenum_1)+votenum(iu)
	next
	response.write "<FONT color="&AlertFontColor&"><b>"&votenum_1&"</b></font>  票"
	votenum_1=0
	end if
	vrs.close
	set vrs=nothing
else
	response.write ""& rs(4) &"/"& rs(7)
end if

response.write "</TD><TD align=left bgColor="& aTableBodyColor &" width=195>&nbsp;"

	'on error resume next
	if LastUser="" then
	response.write "&nbsp;"&_
						FormatDateTime(rs(6),2)&"&nbsp;"&FormatDateTime(rs(6),4)&_
						"&nbsp;<font color="&AlertFontColor&">|</font>&nbsp;------"
	else
		response.write "&nbsp;<a href=dispbbs.asp?boardid="& boardid &"&rootid="& rs(8) &"&id="& LastID &"&skin=1>"&_
						FormatDateTime(LastTime,2)&"&nbsp;"&FormatDateTime(LastTime,4)&_
						"</a>&nbsp;<font color="&AlertFontColor&">|</font>&nbsp;"
		if clng(rs(0))=clng(LastID) then
			response.write "------"
		else
			response.write "<a href=dispuser.asp?name="&LastUser&" target=_blank>"&LastUser&"</a>"
		end if
	end if

response.write "</TD></TR>"&_
				"<tr style=display:none id='follow"& rs(8) &"'><td colspan=5 id='followTd"& rs(8) &"' style=padding:0px><div style='width:240px;margin-left:18px;border:1px solid black;background-color:lightyellow;color:black;padding:2px' onclick=loadThreadFollow("& rs(8) &")>正在读取关于本主题的跟贴，请稍侯……</div></td></tr>"&_
				"</TBODY></TABLE>"
	Lastuser=""
	LastID=""
	LastTime=""
	body=""
	rs.movenext
	loop
	if err.number<>0 then err.clear
	if request("action")="batch" then
	response.write "<TABLE border=0 cellPadding=0 cellSpacing=0 width=95% align=center>"&_
			"<TBODY>"&_
			"<tr><td bgcolor="&Tablebackcolor&" width=1 height=26></td><td width=* bgColor="&TableBodyColor&"><select name=newboard size=1>"&_
			"<option selected>移动帖子请选择</option>"

	dim rs_board1,rs_board2
	set rs_board1=conn.execute("select id,class from class order by id")
	if not(rs_board1.eof and rs_board1.bof) then
	do while not rs_board1.eof
	response.write "<option style=BACKGROUND-COLOR:"&TableTitleColor&">╋ "& rs_board1(1) &"</option>"

		set rs_board2=conn.execute("select boardid,boardtype from board where "&guestlist&" class="& rs_board1(0)&" order by boardid")
		if rs_board2.eof and rs_board2.bof then
			rs_board2.close : set rs_board2=nothing
			response.write "<option>没有论坛</option>"
		else
			do while not rs_board2.eof
				response.write "<option value="""&rs_board2(0)&""">　├" & rs_board2(1) & "</option>"
			rs_board2.movenext
			loop
			rs_board2.close
		end if

	rs_board1.movenext
	loop
	end if
	rs_board1.close
	set rs_board1=nothing
	set rs_board2=nothing
	response.write "<input type=hidden value="&boardid&" name=boardid><input type=checkbox name=chkall value=on onclick=""CheckAll(this.form)"">全选/取消 <input type=radio name=action value=dele>批量删除 <input type=radio name=action value=move>批量移动 <input type=radio name=action value=isbest>批量精华 <input type=radio name=action value=lock>批量锁定 <input type=radio name=action value=istop>批量固顶 <input type=submit name=Submit value=执行  onclick=""{if(confirm('您确定执行的操作吗?')){this.document.batch.submit();return true;}return false;}""></font></td><td bgcolor="&Tablebackcolor&" width=1></td></tr>"&_
			"</TBODY></TABLE><table width=95% border=0 cellspacing=0 cellpadding=0 bgcolor="&Tablebackcolor&" height=1 align='center'><td></td></table></form>"
%>
<script language="JavaScript">
<!--
function CheckAll(form)  {
  for (var i=0;i<form.elements.length;i++)    {
    var e = form.elements[i];
    if (e.name != 'chkall')       e.checked = form.chkall.checked; 
   }
  }
//-->
</script>
<%
	end if
	end sub


	sub listPages3()
	'on error resume next
	dim p,ii
	if limitime="" then
		if clng(currentpage)=1 then
			totalrec=lasttopicnum
		end if
	else
		if clng(currentpage)=1 then
			totalrec=lasttopicnum
		end if
	end if
  	dim n,pi
  	if totalrec mod MaxAnnouncePerPage=0 then
     		n= totalrec \ MaxAnnouncePerPage
  	else
     		n= totalrec \ MaxAnnouncePerPage+1
  	end if

	if currentpage-1 mod 10=0 then
		p=(currentpage-1) \ 10
	else
		p=(currentpage-1) \ 10
	end if

		response.write "<table border=0 cellpadding=0 cellspacing=3 width="&TableWidth&" align=center >"&_
					"<form method=post action=list.asp name=frmList2 >"&_
					"<input type=hidden name=selTimeLimit value='"& request("selTimeLimit") &"'><tr>"&_
		  			"<td valign=middle><font color="&BodyFontColor&">页次：<b>"& currentPage &"</b>/<b>"& n &"</b>页 每页<b>"& MaxAnnouncePerPage &"</b> 主题数<b>"& totalrec &"</b></font></td>"&_
					"<td valign=middle><div align=right ><font color="&BodyFontColor&"><p>分页："
	if currentPage=1 then
	response.write "<font face=webdings color="&AlertFontColor&">9</font>   "
	else
	response.write "<a href='javascript:viewPage2("+Cstr(1)+")' title=首页><font face=webdings>9</font></a>   "
	end if
	if p*10>0 then response.write "<a href='javascript:viewPage2("+Cstr(p*10)+")' title=上十页><font face=webdings>7</font></a>   "
	response.write "<b>"
	for ii=p*10+1 to P*10+10
		   if ii=currentPage then
	          response.write "<font color="&AlertFontColor&">"+Cstr(ii)+"</font> "
		   else
		      response.write "<a href='javascript:viewPage2("+Cstr(ii)+")' language='javascript'>"+Cstr(ii)+"</a>   "
		   end if
		if ii=n then exit for
		'p=p+1
	next
	response.write "</b>"
	if ii<n then response.write "<a href='javascript:viewPage2("+Cstr(ii)+")' title=下十页><font face=webdings>8</font></a>   "
	if currentPage=n then
	response.write "<font face=webdings color="&AlertFontColor&">:</font>   "
	else
	response.write "<a href='javascript:viewPage2("+Cstr(n)+")' title=尾页><font face=webdings>:</font></a>   "
	end if

		response.write "转到:<input type=text name=Page size=3 maxlength=10  value='"& currentpage &"'><input type=button value=Go language=javascript onclick='viewPage1(document.frmList2.Page.value)' id=button1 name=button1 ></font></p>"&_     
					"</div></td></tr>"&_
					"<input type=hidden name=BoardID value='"& BoardID &"'>"&_
					"</form></table>"

		if err.number<>0 then err.clear
	end sub 

	sub showEmptyBoard1()
		response.write "<TABLE style=color:"&TableFontcolor&" bgColor='"&Tablebackcolor&"' border=0 cellPadding=4 cellSpacing=1 width=95% align=center>"&_
			"<TBODY>"&_
			"<TR align=middle bgColor='"&Tabletitlecolor&"'>"&_
			"<TD height=25><font color="&TableFontcolor&">状态</font></TD>"&_
			"<TD><font color="&TableFontcolor&">主 题  (点心情符为开新窗浏览)</font></TD>"&_
			"<TD><font color="&TableFontcolor&">作 者</font></TD> "&_
			"<TD><font color="&TableFontcolor&">回复/人气</font></TD> "&_
			"<TD><font color="&TableFontcolor&">最新回复</font></TD></TR> "&_
			"<tr bgColor="&TableBodyColor&"><td colSpan=5 width=100% >本论坛暂无内容，欢迎发贴：）</font></td></tr>"&_
			"</TBODY></TABLE>"
	end sub
%>