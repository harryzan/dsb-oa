<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!-- #include file="chkuser.asp" -->
<!-- #include file="inc/char.asp" -->
<!--#include file="inc/theme.asp"-->
<%
    	Rem ----------------------
    	Rem ------������ʼ------
    	Rem ----------------------
	dim totalrec
	dim n
	dim orders,ordername
	dim currentpage,page_count,Pcount
        currentPage=request("page")
	if membername="" then
		Errmsg="����û�е�½����<a href=login.asp>��½</a>�����"
		founderr=true
	end if
	orders=request("s")
	if orders="" or not isInteger(orders) then
		orders=1
	else
		orders=clng(orders)
		if err then
			orders=1
			err.clear
		end if
	end if
	call nav()
	if orders=1 then
	sql="select top 200 AnnounceID,parentID,boardID,UserName,child,Topic,body,DateAndTime,hits,RootID,Expression,times,locktopic,istop,isbest,isvote from bbs1 where username='"&membername&"' and parentid=0 ORDER BY announceid desc"
	ordername="�Ҳ��������"
	elseif orders=2 then
	sql="select top 200 AnnounceID,parentID,boardID,UserName,child,Topic,body,DateAndTime,hits,RootID,Expression,times,locktopic,istop,isbest,isvote from bbs1 where username='"&membername&"' and parentid=0 and child>0 ORDER BY announceid desc"
	ordername="�ѱ��ظ����ҵķ���"
	else
	sql="select top 200 AnnounceID,parentID,boardID,UserName,child,Topic,body,DateAndTime,hits,RootID,Expression,times,locktopic,istop,isbest,isvote from bbs1 where username='"&membername&"' and parentid=0 ORDER BY announceid desc"
	ordername="�Ҳ��������"
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
%>
<style>
TABLE {BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 1px; }
TD {BORDER-RIGHT: 0px; BORDER-TOP: 0px; color: #000000; }
</style>
<%
	stats=ordername
	call headline(1)
	if founderr then
		call error()
	else
		call AnnounceList1()
		call listPages3()
	end if
	call endline()

	sub AnnounceList1()
	set rs=server.createobject("adodb.recordset")
	rs.open sql,conn,1,1
	if err.number<>0 then
		foundErr = true
		ErrMsg = "<li>���ݿ����ʧ�ܣ�" & err.description & "</li>"
	else
		if rs.bof and rs.eof then
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

	REM ��ʾ�����б�	
	sub showPageList1()
	i=0
response.write "<font color="&bodyfontcolor&"><center><b>���г���������200����¼</b></center></font><table cellspacing=0 border=0 width="&tablewidth&" bgcolor="&Tablebackcolor&" align=center><tr><td height=1></td></tr></table>"&_
				"<TABLE style=color:"&TableFontcolor&"  border=1 cellPadding=0 cellSpacing=0 width="&tablewidth&" align=center bordercolor="&Tablebackcolor&">"&_
  				"<TBODY>"&_
				"<TR align=middle>"&_
				"<TD height=27 width=32 bgColor="&Tabletitlecolor&"><font color="&TableFontcolor&">״̬</TD>"&_ 
				"<TD bgColor="&Tabletitlecolor&" width=*><font color="&TableFontcolor&">�� ��</TD>"&_
				"<TD bgColor="&Tabletitlecolor&" width=80><font color="&TableFontcolor&">�� ��</TD>"&_
				"<TD bgColor="&Tabletitlecolor&" width=64><font color="&TableFontcolor&">�ظ�/����</TD>"&_
				"<TD bgColor="&Tabletitlecolor&" width=195><font color="&TableFontcolor&">������ | �ظ���</TD>"&_
				"</TR>"&_ 
				"</TBODY></TABLE>"
	dim Ers, Eusername, Edateandtime,body
	dim vrs,votenum,pnum,p,iu,votenum_1
       while (not rs.eof) and (not page_count = rs.PageSize)
	boardid=rs("boardid")
response.write "<TABLE style=color:"&tablecontentcolor&" border=1 cellPadding=0 cellSpacing=0 width="&tablewidth&" align=center bordercolor="&Tablebackcolor&">"&_
				"<TBODY><TR align=middle>"&_
				"<TD bgColor="&aTablebodyColor&" width=32 height=27>"

if rs("istop")<>1 and lockboard<>1 and rs("locktopic")<>1 and rs("isvote")<>1 and rs("isbest")<>1 and rs("child")<10 then
	response.write "<img src="""&picurl&P_opentopic&""" alt=��������>"
elseif rs("isvote")=1 then
	response.write "<img src="""&picurl&P_isvote&""" alt=ͶƱ����>"
elseif rs("istop")=1 then
	response.write "<img src="""&picurl&P_istop&""" alt=�̶�����>"
elseif rs("isbest")=1 then
	response.write "<img src="""&picurl&P_Tisbest&""" alt=��������>"
elseif rs("child")>=10 then
	response.write "<img src="""&picurl&P_hotTopic&""" alt=��������>"
elseif rs("locktopic")=1 then
	response.write "<img src="""&picurl&P_closeTopic&""" alt=������������>"
elseif lockboard=1 then
	response.write "<img src="""&picurl&P_closeTopic&""" alt=����̳������>"
else
	response.write "<img src="""&picurl&P_opentopic&""" alt=��������>"
end if

response.write "</TD>"&_
				"<TD align=left bgcolor="&TablebodyColor&" width=* onmouseover=javascript:this.bgColor='"&aTablebodyColor&"' onmouseout=javascript:this.bgColor='"&TablebodyColor&"'><font color="&TableContentColor&">"

	response.write "<img src='"& picurl &"nofollow.gif' id='followImg"& rs("rootid") &"'>"

		Eusername=""
		Edateandtime=""
	
    set Ers=conn.execute("select top 1 username,dateandtime,body,announceid,rootid from bbs1 where rootid="& rs("rootid") &" and not announceid="& rs("rootid") &" order by announceid desc")
	if not(Ers.eof and Ers.bof) then
		body=Ers("body")
		Eusername=htmlencode(Ers("username"))
		Edateandtime=Ers("dateandtime")	
	end if
	Ers.close
	set Ers=nothing
	if body="" then body=rs("body")

response.write "<a href=""dispbbs.asp?boardID="& rs("boardid") &"&RootID="& rs("rootid") &"&ID="& rs("rootid")&""" title='��"& rs("topic") &"��&#13;&#10;���ߣ�"& rs("username") &"&#13;&#10;������"& rs("dateandtime") &"&#13;&#10;��������"& htmlencode(left(body,20)) &"...'>"

if len(rs("topic"))>26 then
	response.write ""&left(rs("topic"),26)&"..."
else
	response.write rs("topic")
end if
	response.write "</a>"
	Maxtitlelist=Cint(Maxtitlelist)
if (rs("child")+1)>Maxtitlelist then
	response.write "&nbsp;&nbsp;[��ҳ��"
	Pnum=(Cint(rs("child")+1)/Maxtitlelist)+1
	for p=1 to Pnum
	response.write " <a href='dispbbs.asp?boardID="& boardID &"&RootID="& rs("rootid") &"&ID="& rs("announceid") &"&star="&P&"'><FONT color="&AlertFontcolor&"><b>"&p&"</b></font></a> "
	next
	response.write "]"
end if

response.write "</font></TD>"&_
				"<TD bgColor="&aTablebodyColor&" width=80><a href=dispuser.asp?name="& rs("username") &">"& rs("username") &"</a></TD>"&_
				"<TD bgColor="&TablebodyColor&" width=64><font color="&TableContentColor&">"
if rs("isvote")=1 then
	set vrs=conn.execute("select votenum from vote where announceid="& rs("announceid") &"")
	votenum=vrs("votenum")
	votenum=split(votenum,"|")
	for iu = 0 to ubound(votenum)
		votenum_1=cint(votenum_1)+votenum(iu)
	next
	response.write "<FONT color="&alertfontcolor&"><b>"&votenum_1&"</b></font>  Ʊ"
	votenum_1=0
	vrs.close
	set vrs=nothing
else
	response.write ""& rs("child") &"/"& rs("hits") &""
end if

response.write "</font></TD><TD align=left bgColor="& aTablebodyColor &" width=195><font color="&TableContentColor&">&nbsp;"

	if Eusername="" then
		response.write "&nbsp;"&_
						FormatDateTime(rs("dateandtime"),2)&"&nbsp;"&FormatDateTime(rs("dateandtime"),4)&_
						"&nbsp;<font color="&alertfontcolor&">|</font>&nbsp;------"
	else
		response.write "&nbsp;<a href=showannounce.asp?boardid="& boardid &"&rootid="& rs("rootid") &"&id="& rs("announceid") &">"&_
						FormatDateTime(Edateandtime,2)&"&nbsp;"&FormatDateTime(Edateandtime,4)&_
						"&nbsp;<font color="&alertfontcolor&">|</font>&nbsp;"
		if rs("announceid")=rs("times") then
			response.write "------"
		else
			response.write "</a><a href=dispuser.asp?name="&Eusername&">"&Eusername&"</a>"
		end if
	end if

response.write "</font></TD></TR>"&_
				"<tr style=display:none id='follow"& rs("rootid") &"'><td colspan=5 id='followTd"& rs("rootid") &"' style=padding:0px><div style='width:240px;margin-left:18px;border:1px solid black;background-color:lightyellow;color:black;padding:2px' onclick=loadThreadFollow("& rs("rootid") &")>���ڶ�ȡ���ڱ�����ĸ��������Ժ��</div></td></tr>"&_
				"</TBODY></TABLE>"

	  page_count = page_count + 1
          rs.movenext
        wend
	end sub

	sub listPages3()
	dim endpage
	Pcount=rs.PageCount
	response.write "<table border=0 cellpadding=0 cellspacing=3 width="""&tablewidth&""" align=center>"&_
			"<tr><td valign=middle nowrap>"&_
			"<font color="&bodyfontColor&">ҳ�Σ�<b>"&currentpage&"</b>/<b>"&Pcount&"</b>ҳ"&_
			"ÿҳ<strong>"&MaxAnnouncePerpage&"</b> ����<b>"&totalrec&"</b></td>"&_
			"<td valign=middle nowrap><div align=right><p>��ҳ�� "

	if currentpage > 4 then
	response.write "<a href=""?page=1&s="&orders&""">[1]</a> ..."
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
        response.write " <a href=""?page="&i&"&s="&orders&""">["&i&"]</a>"
		end if
	end if
	next
	if currentpage+3 < Pcount then 
	response.write "... <a href=""?page="&Pcount&"&s="&orders&""">["&Pcount&"]</a>"
	end if
	response.write "</p></div></font></td></tr></table>"
	rs.close
	set rs=nothing	
	end sub 

	sub showEmptyBoard1()
%>
<TABLE bgColor='<%=Tablebackcolor%>' border=0 cellPadding=4 cellSpacing=1 width="<%=tablewidth%>" align=center>
  <TBODY>
  <TR bgColor='<%=Tabletitlecolor%>'>
    <TD align=middle noWrap height=25><font color=<%=TableFontcolor%>>״̬</font></TD> 
    <TD align=middle noWrap><font color=<%=TableFontcolor%>>�� ��  (�������Ϊ���´����)</font></TD> 
    <TD align=middle noWrap><font color=<%=TableFontcolor%>>�� �� </font></TD> 
    <TD align=middle noWrap><font color=<%=TableFontcolor%>>�ظ�/����</font></TD> 
    <TD align=middle noWrap><font color=<%=TableFontcolor%>>���»ظ�</font></TD></TR> 
  <tr bgColor="<%=TablebodyColor%>"><td colSpan=5 vAlign=center width="100%"><font color="<%=TableContentColor%>">�������ݣ���ӭ��������</font></td></tr>
</TBODY></TABLE>
<%
	end sub

%>
<!--#include file="footer.asp"-->
