<!--#include file=conn.asp-->
<!--#include file=inc/char.asp-->
<!--#include file=inc/const.asp-->
<html>
<body>
<%
	dim outtext
	dim num		'倒数第几个跟帖
	dim allnum	'总共多少跟帖
	dim star		'第几页
	dim rootID

	if request("rootID")="" then
		response.write "非法的贴子参数。"
		response.end
	elseif not isInteger(request("rootID")) then
		response.write "非法的贴子参数。"
		response.end
	else
		rootID=request("rootID")
	end if
	num=0
	outtext="&nbsp;&nbsp;"
function HTMLEncode(fString)

    fString = replace(fString, ">", "&gt;")
    fString = replace(fString, "<", "&lt;")
    fString = replace(fString, "'", "")
    fString = Replace(fString, CHR(13), "")
    fString = Replace(fString, CHR(10) & CHR(10), "；")
    fString = Replace(fString, CHR(10), "，")
    HTMLEncode = fString
end function

   	set rs=server.createobject("adodb.recordset")
   	sql="select child from bbs1 where announceid="&rootid
   	rs.open sql,conn,0,1
   	allnum=rs(0)
   	rs.close
   	
   	sql="select layer,rootid,announceid,topic,body,username,child,hits from bbs1 where boardid="& boardid &" and rootid="& rootid &" and announceid<>"& rootid &" and not locktopic=2 order by rootid desc,orders"
'	response.write sql
'	response.end
   	rs.open sql,conn,1,1
%>
<script>
	parent.followTd<%=rootid%>.innerHTML='<TABLE bgColor="<%=Tablebackcolor%>" border=0 cellPadding=0 cellSpacing=0 width="100%" align=center><TBODY><%do while not rs.eof%><TR><TD align=middle bgColor="<%=aTablebodycolor%>" width=32 height=27><font color="<%=TableContentcolor%>"></font></TD><td bgcolor=<%=Tablebackcolor%> valign=middle width=1></td><TD bgcolor="<%=Tablebodycolor%>" width=*><font color=<%=TableContentcolor%>><%for i=2 to rs("layer")%><%=outtext%><%next%><img src="<%=picurl%>nofollow.gif"><a href="dispbbs.asp?boardID=<%=boardID%>&RootID=<%=rs("RootID")%>&ID=<%=rs("announceID")%><%

	star=int((allnum-num)/Maxtitlelist)+1
	if  star>1 then
		response.write "&star="&star
	end if
	
	%>&skin=0#<%=rs("announceid")%>" title="<%=htmlencode(rs("topic"))%>"><%
	
	if rs("topic")="" then
	response.write ""&left(htmlencode(rs("body")),22)&"..."
else
	if len(rs("topic"))>22 then
		response.write ""&htmlencode(left(rs("topic"),22))&"..."
	else
		response.write htmlencode(rs("topic"))
	end if
	
end if%></font></a> -- <a href="dispuser.asp?name=<%=htmlencode(rs("username"))%>"><%=htmlencode(rs("username"))%></a></font><font color=<%=TableContentcolor%>>(<%=rs("child")%>/<%=rs("hits")%>)</font></tr><%
	
	rs.movenext
	num=num+1
	loop
	rs.close
	conn.close
	set conn=nothing%></TBODY></TABLE>';
	parent.followImg<%=rootid%>.loaded="yes";
</script>
</body>
</html>