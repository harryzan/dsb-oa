<!--#include file="conn.asp"-->
<%
function HTMLEncode(fString)

    fString = replace(fString, ">", "&gt;")
    fString = replace(fString, "<", "&lt;")
    fString = replace(fString, ";", "£»")
    fString = replace(fString, "'", "¡®")
    fString = Replace(fString, CHR(13), "")
    fString = Replace(fString, CHR(10) & CHR(10), "£»")
    fString = Replace(fString, CHR(10), "£¬")
    HTMLEncode = fString
end function
	dim rs,sql
	dim orders,reply
	if request("orders")=1 then
		orders="hits"
	else
		orders="DateAndTime"
	end if
	if request("reply")=1 then
		reply=""
	else
		reply=" parentid=0 and "
	end if
	set rs=server.createobject("adodb.recordset")
	if request("boardid")="all" then
	sql="select top "&request("n")&" username,topic,announceid,boardid,rootid,hits from bbs1 where "&reply&" datediff('d',dateandtime,Now())>="&request("sdate")-1&" and not locktopic=2 ORDER BY "&orders&" desc"
	else
	sql="select top "&request("n")&" username,topic,announceid,boardid,rootid,hits from bbs1 where "&reply&" datediff('d',dateandtime,Now())>="&request("sdate")-1&" and not locktopic=2 and boardid="&request("boardid")&" ORDER BY "&orders&" desc"
	end if
	'response.write sql
	rs.open sql,conn,1,1
	do while Not RS.Eof
	response.write "document.write('<FONT color=#b70000><B>¡¤</B></FONT><span style=""font-size:9pt;line-height: 15pt""><a href=dispbbs.asp?boardid="&rs(3)&"&RootID="&rs(4)&"&ID="&rs(2)&" target=_top title="&htmlencode(rs(1))&">');"

	if len((rs("topic")))>Cint(request("tlen")) then
		response.write "document.write('"&htmlencode(left(rs(1),request("tlen")))&"...');"
	else
		response.write "document.write('"&htmlencode(rs(1))&"');"
	end if

	response.write "document.write('</a>');"
	select case request("info")
	case 0

	case 1
	response.write "document.write('£ (<a href=dispuser.asp?name="&rs(0)&" target=_blank>"&rs(0)&"</a>,<font color=green>"&rs(5)&"</font>)');"
	case 2
	response.write "document.write('£ (<font color=green>"&rs(5)&"</font>)');"
	case 3
	response.write "document.write('£ (<a href=dispuser.asp?name="&rs(0)&" target=_blank>"&rs(0)&"</a>)');"
	case else

	end select

	response.write "document.write('</span><br>');"
	RS.MoveNext
	Loop
	rs.close
	set rs=nothing
	conn.close
	set conn=nothing
%>

