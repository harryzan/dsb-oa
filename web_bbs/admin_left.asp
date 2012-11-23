<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!-- #include file="admin_config.asp" -->
<title><%=ForumName%>--管理页面</title>
<!--#include file="Forum_css.asp"-->

<BODY bgcolor="<%=Tablebodycolor%>" alink="#333333" vlink="#333333" link="#333333" topmargin="0" leftmargin=0>
<table border="0" cellspacing="0" width="100%"  cellpadding="0">
<tr> 
<td height="20" align=center><a href=admin_index.asp target=_top><font color="<%=TableContentColor%>"><b>论坛管理中心</b></font></a></td>
</tr>
<tr> 
<td height="5"> </td>
</tr>
<%
	dim j
	dim tmpmenu
	dim menuname
	dim menurl
for i=0 to ubound(menu,1)
%>
<tr> 
<td height="20" bgcolor="<%=Tabletitlecolor%>">&nbsp;<font color="<%=TablefontColor%>"><b><%=menu(i,0)%><b></font></td>
</tr>
	<%
	for j=1 to ubound(menu,2)
	if isempty(menu(i,j)) then exit for
	tmpmenu=split(menu(i,j),",")
	menuname=tmpmenu(0)
	menurl=tmpmenu(1)
	%>
<tr> 
<td height="20" bgcolor="<%=Tablebodycolor%>">&nbsp;&nbsp;--<a href="<%=menurl%>" target="main"><font color="<%=TableContentColor%>"><%=menuname%></font></a></td>
</tr>
	<%next%>
<%next%>

<tr> 
<td height="20" bgcolor="<%=aTabletitlecolor%>">&nbsp; <b><a href=admin_logout.asp target=_top><font color="<%=TableContentColor%>">退出管理</font></a></b></td>
</tr>
</table>