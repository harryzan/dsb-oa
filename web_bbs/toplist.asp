<!--#include file="conn.asp"-->
<!-- #include file="inc/char.asp" -->
<!-- #include file="inc/const.asp" -->
<!-- #include file="chkuser.asp" -->
<!--#include file="inc/grade.asp"-->
<!--#include file="inc/theme.asp"-->
<%
	dim orders,ordername
	dim currentpage,page_count,Pcount
	dim totalrec,endpage
	dim bbsnum,usernum
        currentPage=request("page")
	if not isInteger(request("orders")) or request("orders")="" then
		orders=1
	else
		orders=request("orders")
	end if
	select case orders
	case 1
		orders=1
		ordername="发贴总数Top" & TopUserNum
	case 2
		orders=2
		ordername="最新用户注册"
	case 3
		orders=3
		ordername=TopUserNum & "大富翁"
	case 4
		orders=4
		ordername=TopUserNum & "大存户"
	case 5
		orders=5
		ordername=TopUserNum & "大高智商天才"
	case 6
		orders=6
		ordername="百万富翁通关用户"
	case 7
		orders=7
		ordername="所有用户列表"
	case 8
		orders=8
		ordername="管理团队"
	case else
		orders=1
		ordername="发贴总数Top" & TopUserNum
	end select
	
	stats=ordername
	call nav()
	call headline(1)
%>
    <table width="<%=tablewidth%>" bgcolor=<%=Tablebackcolor%>  cellspacing=0 border=0 bordercolor=<%=Tablebackcolor%> align=center>
    	<tr>
	        <td>
        	
<table cellpadding=6 cellspacing=1 border=0 width=100%>
<form method="POST" action="toplist.asp"> 
<tr bgcolor=<%=aTableTitlecolor%>> 
<td colspan=5 valign=top width=350><font color="<%=TableFontColor%>">&nbsp;>> <B><%=ordername%></B> <<<BR>
<BR>
<%
	set rs=conn.execute("select top 1 BbsNum,UserNum from config where active=1")
	bbsnum=rs(0)
	usernum=rs(1)
%>
&nbsp;总注册用户数： <%=usernum%> 人 &nbsp; 发贴总数： <%=bbsnum%> 篇</font></td>
<td colspan=6 align=right> 
<select name=orders onchange='javascript:submit()'>
<option value=1 <%if orders=1 then%>selected<%end if%>>发贴总数Top<%=TopUserNum%></option>
<option value=2 <%if orders=2 then%>selected<%end if%>>最新注册用户</option>
<option value=7 <%if orders=7 then%>selected<%end if%>>所有用户列表</option>
<option value=8 <%if orders=8 then%>selected<%end if%>>管理团队</option>
</select>
</td>
</tr></form>
<tr bgcolor=<%=TabletitleColor%> style=color:<%=TableFontColor%>> 
<td align=center><font color="<%=TableFontColor%>"><b>用户名</b></font></td>
<td align=center><font color="<%=TableFontColor%>"><b>EMAIL</b></font></td>
<td align=center><font color="<%=TableFontColor%>"><b>联系地址</b></font></td>
<td align=center><font color="<%=TableFontColor%>"><b>短消息</font></td>
<td align=center><font color="<%=TableFontColor%>"><b>注册时间</b></font></td>

<td align=center><font color="<%=TableFontColor%>"><b>发贴总数</b></font></td>
</tr>
<%

	if currentpage="" or not isInteger(currentpage) then
		currentpage=1
	else
		currentpage=clng(currentpage)
		if err then
			currentpage=1
			err.clear
		end if
	end if
	set rs=server.createobject("adodb.recordset")
	select case orders
	case 1
		sql="select top "&TopUserNum&" username,useremail,userclass,oicq,homepage,article,addDate,userwealth as wealth from [user] order by article desc"
	case 2
		sql="select top "&TopUserNum&" username,useremail,userclass,oicq,homepage,article,addDate,userwealth as wealth from [user] order by AddDate desc"
	case 3
		sql="select top "&TopUserNum&" [user].username,useremail,userclass,oicq,homepage,article,addDate,(userwealth+usersaving-userloan) as wealth from [user],userBank where [user].userid=userbank.userid order by wealth desc"
	case 4
		sql="select top "&TopUserNum&" [user].username,useremail,userclass,oicq,homepage,article,addDate,usersaving as wealth from [user],userBank where [user].userid=userbank.userid order by usersaving desc"
	case 5
		sql="select top "&TopUserNum&" [user].username,useremail,userclass,oicq,homepage,article,addDate,score as wealth from [user],Muser where [user].username=Muser.username order by score desc"
	case 6
		sql="select [user].username,useremail,userclass,oicq,homepage,article,addDate,passall as wealth from [user],Muser where [user].username=Muser.username and passall>0 order by passall desc"
	case 7
		sql="select username,useremail,userclass,oicq,homepage,article,addDate,userwealth as wealth from [user] order by userid desc"
	case 8
		sql="select username,useremail,userclass,oicq,homepage,article,addDate,userwealth as wealth from [user] where userclass>=19 order by userclass desc,article desc"
	case else
		sql="select top "&TopUserNum&" username,useremail,userclass,oicq,homepage,article,addDate,userwealth as wealth from [user] order by article desc"
	end select
	rs.open sql,conn,1,1
	if rs.eof and rs.bof then
%>
<tr bgcolor=<%=TableBodyColor%>> 
<td colspan=9><font color="<%=TableContentColor%>">　　还没有任何用户数据。</font></td>
</tr>
<%
	else
	if orders=7 then
	totalrec=userNum
	else
	totalrec=rs.recordcount
	end if
  	if totalrec mod MaxAnnouncePerpage=0 then
     		Pcount= totalrec \ MaxAnnouncePerpage
  	else
     		Pcount= totalrec \ MaxAnnouncePerpage+1
  	end if
	RS.MoveFirst
	if currentpage > Pcount then currentpage = Pcount
   	if currentpage<1 then currentpage=1
	RS.Move (currentpage-1) * MaxAnnouncePerpage
	page_count=0
	do while not rs.eof and page_count < Clng(MaxAnnouncePerpage)
	page_count=page_count+1
%>
<tr bgcolor=<%=TableBodyColor%>> 
<td>&nbsp;<a href="dispuser.asp?name=<%=htmlencode(rs("username"))%>" target=_blank><%=htmlencode(rs("username"))%></a></td>
<td align=center><a href=mailto:<%=rs("useremail")%>><%=rs("useremail")%></a></td>
<td align=center> 
<%if rs("homepage")="" or isnull(rs("homepage")) then%>
没有 
<%else%>
<%=rs("homepage")%>
<%end if%>
</td>
<td align=center><a href=usersms.asp?action=new&touser=<%=htmlencode(rs("username"))%> target=_blank><img src="<%=picurl&P_sms%>" border=0></a></td>
<td align=center><font color="<%=TableContentColor%>"><%=rs("addDate")%></font></td>
<td align=center><font color="<%=TableContentColor%>"><%=rs("article")%></font></td>
</tr>
<%
		rs.movenext
		loop
	end if
%>
</table>
</td></tr>
</table>
<%
	if orders=7 then
		response.write "<table border=0 cellpadding=0 cellspacing=3 width="""&tablewidth&""" align=center>"&_
				"<tr><td valign=middle nowrap>"&_
				"<font color="&bodyfontcolor&">页次：<b>"&currentpage&"</b>/<b>"&Pcount&"</b>页"&_
				"每页<b>"&MaxAnnouncePerpage&"</b> 用户数<b>"&userNum&"</b></font></td>"&_
				"<td valign=middle nowrap><font color="&bodyfontcolor&"><div align=right><p>分页： "
	
		if currentpage > 4 then
		response.write "<a href=""?page=1&orders="&orders&""">[1]</a> ..."
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
	        response.write " <a href=""?page="&i&"&orders="&orders&""">["&i&"]</a>"
			end if
		end if
		next
		if currentpage+3 < Pcount then 
		response.write "... <a href=""?page="&Pcount&"&orders="&orders&""">["&Pcount&"]</a>"
		end if
		response.write "</p></div></font></td></tr></table>"
	end if
	rs.close
	set rs=nothing

call endline()
%>
<!--#include file="footer.asp"-->
