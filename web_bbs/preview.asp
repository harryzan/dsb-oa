<!-- #include file="conn.asp" -->
<!-- #include file="inc/const.asp" -->
<!-- #include file="inc/char.asp" -->
<!-- #include file="inc/ubbcode.asp" -->
<!-- #include file="chkuser.asp" -->
<%
dim usersign
dim abgcolor
usersign=false
stats="预览帖子"
response.write "<html><head>"&_
				"<meta NAME=GENERATOR Content=""Microsoft FrontPage 4.0"" CHARSET=GB2312>"&_
				"<title>"&ForumName&"--"&stats&"</title>"&_
				"<link rel=stylesheet type=text/css href=forum.css></head>"&_
				"<body "&ForumBody&">"
%>
<!--#include file="Forum_css.asp"-->
<p>&nbsp;</p>
<table cellpadding=0 cellspacing=0 border=0 width="<%=tablewidth%>" bgcolor=<%=Tablebackcolor%> align=center>
  <tr>
    <td>
<table cellpadding=3 cellspacing=1 border=0 width=100%>
<TBODY> 
<TR align=middle bgcolor=<%=Tabletitlecolor%>> 
<TD height=24><b><font color="<%=TableFontColor%>">帖子预览</font></b></TD>
</TR>
<TR bgcolor=<%=Tablebodycolor%>> 
<TD height=24><font color="<%=TableContentColor%>">
<%
response.write "<b>"& htmlencode(request.form("title")) &"</b><br>"& ubbcode(request.form("body")) 
%></font></TD>
</TR>
</TBODY>
</TABLE>
    </td>
  </tr>
</table>
<%call endline()%>
<!-- #include file="footer.asp" -->
