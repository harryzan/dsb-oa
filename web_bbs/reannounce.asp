<!--#include file="conn.asp"-->
<!-- #include file="inc/char.asp" -->
<!-- #include file="inc/char_board.asp" -->
<!-- #include file="inc/const.asp" -->
<!-- #include file="chkuser.asp" -->
<!--#include file="inc/theme.asp"-->
<!--#include file="inc/form1.asp"-->
<!--#include file="inc/ubbcode.asp"-->
<%

	dim AnnounceID
	dim RootID
	dim rsBoard
	dim boardsql
	dim userclass
	dim username
	dim dateandtime
	dim bgcolor,abgcolor
	dim topic
	dim usersign
	usersign=false
	
	dim con,content
	dim boardstat
	if request("boardid")="" then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>��ָ����̳���档"
	elseif not isInteger(request("boardid")) then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>�Ƿ��İ��������"
	else
		boardid=request("boardid")
	end if
	if request("id")="" then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>��ָ��������ӡ�"
	elseif not isInteger(request("id")) then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>�Ƿ������Ӳ�����"
	else
		AnnounceID=request("id")
	end if
	if request("RootID")="" then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>��ָ��������ӡ�"
	elseif not isInteger(request("RootID")) then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>�Ƿ������Ӳ�����"
	else
		RootID=request("RootID")
	end if

	select case boardskin
	case 1
		boardstat="������̳��ֻ����<a href=reg.asp><font color="&TableFontcolor&">ע���Ա</a>����"
	case 2
		boardstat="������̳�����������˷���"
	case 3
		boardstat="������̳��̳���Ͱ��������ԣ�����<a href=reg.asp><font color="&TableFontcolor&">ע���û�</font></a>ֻ�ܻظ�"
	case 4
		boardstat="��������ֻ���������̳�����ԺͲ���"
		if not(boardmaster or master) then
		Founderr=true
		Errmsg=Errmsg+"<br>"+"<li>��������ֻ���������̳�����ԺͲ���"
		end if
	case 5
		boardstat="��֤��̳����̳���Ͱ����⣬����<a href=reg.asp><font color="&TableFontcolor&">ע���û�</font></a>��½��̳��Ҫ��֤"
		if membername="" then
			founderr=true
			Errmsg=Errmsg+"<br>"+"<li>����̳Ϊ��֤��̳����<a href=login.asp>��½</a>��ȷ�������û����Ѿ��õ�����Ա����֤����롣"
		else
			if chkboardlogin(boardid,membername)=false then
			founderr=true
			Errmsg=Errmsg+"<br>"+"<li>����̳Ϊ��֤��̳����ȷ�������û����Ѿ��õ�����Ա����֤����롣"
			end if
		end if
	case 6
		boardstat="������̳��ֻ��<a href=login.asp><font color="&TableFontcolor&">��½�û�</a>���������̳������"
		if membername="" then
		Founderr=true
		Errmsg=Errmsg+"<br>"+"<li>������̳��ֻ��<a href=login.asp><font color="&TableContentColor&">��½�û�</a>���������̳������"
		end if
	end select

	stats=""&boardtype&"�ظ�����"
	sub chktopic()
     	set rs=conn.execute("select topic from bbs1 where announceID="&rootID&"")
	if not(rs.bof and rs.eof) then
		topic=rs("topic")
	else
		foundErr = true
		ErrMsg=ErrMsg+"<br>"+"<li>��ָ�������Ӳ�����</li>"
	end if
	rs.close
	set rs = server.CreateObject ("adodb.recordset")
  	sql="select body,topic,locktopic,username,dateandtime from bbs1 where AnnounceID="&AnnounceID
   	rs.open sql,conn,1,1 
		if rs("locktopic")=1 then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>�������ѱ����������ܷ���ظ���"
		else
   		con=rs("body")
		topic=rs("topic")
		username=rs("username")
		dateandtime=rs("dateandtime")
		end if
	rs.close
	end sub

	if founderr then
		call nav()
		call headline(2)
		call error()
	else
		call chktopic()
		if founderr then
		call nav()
		call headline(2)
		call error()
		else
		call nav()
		call headline(2)
		call showreform()
		call announceinfo()
		end if
	end if
	call endline()

	sub announceinfo()
	response.write "<hr width='"&tablewidth&"'>"
	set rs = server.CreateObject ("adodb.recordset")
	sql="Select UserName,Topic,dateandtime,body,announceid from bbs1 where boardid="&boardid&" and rootid="&rootid&" order by announceid"
	rs.open sql,conn,1,1
	do while not rs.eof
	if bgcolor=TableBodyColor then
		bgcolor=aTableBodyColor
		abgcolor=TableBodyColor
	else
		bgcolor=TableBodyColor
		abgcolor=aTableBodyColor
	end if
%>
<TABLE border=0 width="<%=tablewidth%>" align=center bgcolor="<%=bgcolor%>">
  <TBODY>
  <TR>
    <TD valign=middle align=top><font color="<%=TableContentColor%>">
--&nbsp;&nbsp;���ߣ�<%=htmlencode(rs("username"))%><br>
--&nbsp;&nbsp;����ʱ�䣺<%=rs("dateandtime")%><br><br>
--&nbsp;&nbsp;<%=htmlencode(rs("topic"))%><br>
<%=ubbcode(rs("body"))%></font>
	<hr size=1>
    </TD></TR></TBODY></TABLE> 
<%
          rs.movenext
        loop	
	rs.close
	end sub
	set rs=nothing
%>
<!--#include file="footer.asp"-->
