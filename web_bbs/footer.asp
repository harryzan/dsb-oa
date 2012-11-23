<%
sub endline()
	dim endtime
	if stats<>"" then
		if session("userid")<>"" then
		conn.execute("update online set stats='"&replace(stats,"'","")&"' where id="&cstr(session("userid")))
		end if
		if membername<>"" then
		conn.execute("update online set stats='"&replace(stats,"'","")&"' where username='"&membername&"'")
		end if
	end if
	CloseDatabase
	endtime=timer()
response.write "<p><TABLE cellSpacing=0 cellPadding=0 width="""&TableWidth&""" border=0 align=center><tr><td>"&_
	"<p align=center><font color="&BodyFontColor&">"&index_ad_f&"</font></td></tr>"

response.write "</font></td></tr></table> </body> </html>"
response.Write"<table width='80%' border='0' align='center' cellpadding='1' cellspacing='1' bordercolor='#000000'>"
response.Write"<tr><td height='5'></td><td width='31%' height='25'></td></tr>"
response.Write"<tr> <td height='5'></td><td></td></tr>"
response.Write"<tr> <td height='5' colspan='2'></td></tr>"
response.Write"<tr><td colspan='2'></td></tr></table>"
end sub
%>