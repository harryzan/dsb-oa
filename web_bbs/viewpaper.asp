<!-- #include file="conn.asp" -->
<!-- #include file="inc/const.asp" -->
<!-- #include file="chkuser.asp" -->
<!-- #include file="inc/char.asp" -->
<!-- #include file="inc/ubbcode.asp" -->
<%
stats="浏览小字报"
%>
<html><head>
<meta NAME=GENERATOR Content="Microsoft FrontPage 4.0" CHARSET=GB2312>
<title><%=ForumName%>--<%=stats%></title>
<!--#include file=Forum_css.asp--></head>
<body <%=ForumBody%>>
<%
	dim paperid
	dim usersign
	usersign=false
	dim abgcolor
	if request("id")="" then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>非法的参数。"
	elseif not isInteger(request("id")) then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>非法的参数。"
	else
		paperID=request("id")
	end if
	if founderr then
		call error()
	else
		set rs=server.createobject("adodb.recordset")
		sql="select * from smallpaper where s_id="&paperid
		rs.open sql,conn,1,1
		if rs.eof and rs.bof then
		Errmsg=Errmsg+"<br>"+"<li>没有找到相关信息。"
		call error()
		else
		conn.execute("update smallpaper set s_hits=s_hits+1 where s_id="&paperid)
%>
<table cellpadding=0 cellspacing=0 border=0 width="<%=tablewidth%>" bgcolor=<%=Tablebackcolor%> align=center>
  <tr>
    <td>
<table cellpadding=3 cellspacing=1 border=0 width=100%>
<TBODY> 
<TR align=middle bgcolor=<%=Tabletitlecolor%>> 
<TD height=24><b><font color="<%=TableFontColor%>"><%=htmlencode(rs("s_title"))%></font></b></TD>
</TR>
<TR bgcolor=<%=Tablebodycolor%>> 
<TD height=24>
<font color="<%=TableContentColor%>">
<p align=center><a href=dispuser.asp?name=<%=htmlencode(rs("s_username"))%> target=_blank><%=htmlencode(rs("s_username"))%></a> 发布于 <%=rs("s_addtime")%></p>
    <blockquote>   
      <br>   
<%=ubbcode(rs("s_content"))%>  
      <br>
<div align=right>浏览次数：<%=rs("s_hits")%></div>
    </blockquote>
</font></TD>
</TR>
<TR align=middle bgcolor=<%=Tabletitlecolor%>> 
<TD height=24><a href=# onclick="window.close();">『 关闭窗口 』</a></TD>
</TR>
</TBODY>
</TABLE>
    </td>
  </tr>
</table>
<%
		end if
		rs.close
		set rs=nothing
	end if
%>
<%call endline()%>
<!-- #include file="footer.asp" -->
