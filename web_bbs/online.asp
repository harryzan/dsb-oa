<!--#include file="conn.asp"-->
<!-- #include file="inc/char.asp" -->
<!-- #include file="inc/const.asp" -->
<!-- #include file="chkuser.asp" -->
<!--#include file="inc/theme.asp"-->
<%
	stats="论坛在线"
	dim guests,page_count,Pcount
	dim totalrec
	call nav()
	call headline(1)
	if founderr then
	call error()
	else
	call main()
	end if
	call endline()
	sub main()
	dim mysql
	set rs=server.createobject("adodb.recordset")
	if BoardID="" then
		mysql="select username,stats,browser,comefrom,startime from online order by userclass desc"
	elseif not isInteger(BoardID) then
		mysql="select username,stats,browser,comefrom,startime from online order by userclass desc"
	else
		BoardID=clng(request("BoardID"))
		sql="select boardtype from board where boardid="&boardid
		rs.open sql,conn,1,1
		if rs.eof and rs.bof then
		mysql="select username,stats,browser,comefrom,startime from online order by userclass desc"
		else
		boardtype=rs(0)
		mysql="select username,stats,browser,comefrom,startime from online where boardid="&boardid&" order by userclass desc"
		end if
	end if
	rs.close
	set rs=nothing
	dim totalPages,currentPage
	'response.write boardid
	'response.end
	currentPage=request.querystring("page")
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
    <table width="<%=tablewidth%>" bgcolor=<%=Tablebackcolor%>  cellspacing=0 border=0 bordercolor=<%=Tablebackcolor%> align=center>
    	<tr>
	        <td>
        	
<table cellpadding=6 cellspacing=1 border=0 width=100%>
<tr bgcolor=<%=aTableTitlecolor%>> 
<td colspan=5 align=center><font color="<%=TableContentColor%>">
<%if boardtype<>"" then%>当前论坛共有<B><%=allonline()%></B>位用户在线，其中<%=boardtype%>有<B><%=online(boardid)%></B>位在线用户与<B><%=guest(boardid)%></B>位客人<%else%>当前论坛共有<B><%=allonline()%></B>位用户在线<%end if%></font>
</td>
</tr>
<tr bgcolor=<%=TabletitleColor%> style=color:<%=TableFontColor%>> 
<td align=center width="10%"><font color="<%=TableFontColor%>"><b>用户名</b></font></td>
<td align=center width="35%"><font color="<%=TableFontColor%>"><b>当前位置</b></font></td>
<td align=center width="20%"><font color="<%=TableFontColor%>"><b>用户信息</b></font></td>
<td align=center width="22%"><font color="<%=TableFontColor%>"><b>登陆时间</b></font></td>
</tr>
<%
	set rs=server.createobject("adodb.recordset")
	rs.open mysql,conn,1,1
	if rs.eof and rs.bof then
%>
<tr bgcolor=<%=TableBodyColor%>> 
<td colspan=5>　　还没有任何用户数据。</td>
</tr>
<%
	else
		rs.PageSize = MaxAnnouncePerpage
		rs.AbsolutePage=currentpage
		page_count=0
      		totalrec=rs.recordcount
		while (not rs.eof) and (not page_count = rs.PageSize)
%>
<tr bgcolor=<%=TableBodyColor%>> 
<td align=center><a href="dispuser.asp?name=<%=htmlencode(rs("username"))%>" target=_blank><%=htmlencode(rs("username"))%></a></td>
<td align=center><font color="<%=TableContentColor%>"><%=rs("stats")%></font></td>
<td align=center><font color="<%=TableContentColor%>"><%=replace(system(rs("browser")),"操作系统：","")%>，<%=replace(replace(browser(rs("browser")),"浏 览 器：",""),"Internet Explorer","IE")%></font></td>
<td align=center><font color="<%=TableContentColor%>"><%=formatdatetime(rs("startime"),2)%>&nbsp;<%=formatdatetime(rs("startime"),4)%></font></td>
</td>
</tr>
<%
	  	page_count = page_count + 1
		rs.movenext
		wend
	end if
%>
</table>
</td></tr>
</table>
<%
	dim endpage
	Pcount=rs.PageCount
	response.write "<table border=0 cellpadding=0 cellspacing=3 width="""&tablewidth&""" align=center>"&_
			"<tr><td valign=middle nowrap>"&_
			"<font color="&bodyfontColor&">页次：<b>"&currentpage&"</b>/<b>"&Pcount&"</b>页"&_
			"每页<strong>"&MaxAnnouncePerpage&"</b> 用户数<b>"&totalrec&"</b></td>"&_
			"<td valign=middle nowrap><div align=right><p>分页： "

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
	response.write "</p></div></font></td></tr></table>"
	rs.close
	set rs=nothing	
	end sub
%>
<!--#include file="footer.asp"-->
<!--#include file="online_l.asp"-->
