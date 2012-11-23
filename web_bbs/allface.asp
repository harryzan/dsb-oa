<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!--#include file="inc/char.asp"-->
<!-- #include file="chkuser.asp" -->
<!--#include file="inc/theme.asp"-->
<%
	dim n,m,h,s
	dim y,z,show
	stats="所有头像"
	i=0
	h=10
	s=50
	M=regfacenum
	call nav()
	call headline(1)
	call main()
	call endline()
%>
<%sub main()%>
    <table cellpadding=6 cellspacing=1 border=0 width=<%=tablewidth%> align=center style="table-layout:fixed;word-break:break-all;">
    
    <tr>
    <td bgcolor=<%=TableTitlecolor%> align=center><font color="<%=TablefontColor%>">
    <b>
<% if m>s then %>
<p align="center"><% for Y=1 to (m+s-1)/s %>
 [<a href=allface.asp?show=<%=Y%>> 头像列表<%=Y%> </a>]  
<% next 
end if%>
</b></font>
    </td>
    </tr>
    <td bgcolor="<%=tablebodycolor%>">
<table width="100%">
    <tr>
<% 
	dim p
	p= request("show")
	if p="" then
		p=1
	end if
	z=s*p

	if z/m>1 then
		z=m
	else
		z=s*p
	end if

for n=s*p+1-s to z
     i=i+1
%>
      <td   align="center" height=50><IMG SRC=<%=picurl%>Image<%=n%>.gif><br><FONT COLOR="<%=alertfontcolor%>">Image<%=n%>
</FONT></td>
<%
	if i=h then
	response.write "</tr><tr>"
	i=0
	end if 
	next
%>

  </table>
    </td>
    </tr></table>
    </td></tr></table>
<%end sub%>
<!--#include file="footer.asp"-->
