<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!-- #include file="chkuser.asp" -->
<!-- #include file="inc/char.asp" -->
<!-- #include file="inc/ubbcode.asp" -->
<HTML><HEAD><TITLE><%=ForumName%>--��ʾ����</TITLE>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<!--#include file="Forum_css.asp"-->
<META content="Microsoft FrontPage 4.0" name=GENERATOR></HEAD>
<BODY bgcolor="#ffffff" alink="#333333" vlink="#333333" link="#333333" topmargin="10" leftmargin="10">
<%
	dim urs,usql
	dim rsboard,boardsql
	dim announceid
	dim username
	dim rootid
	dim topic
	dim abgcolor
	abgcolor="#FFFFFF"
	dim usersign
	usersign=false
    	Rem ------���������ID��ҳ��------
    	call chkInput()

   	set rs=server.createobject("adodb.recordset")
    	if foundErr then
		call error()
	else
		call showPage()
	end if

	sub showPage()
		'on error resume next
		if foundErr then
			call error()
		else
			call announceinfo()
			if founderr then call error()
		end if
		if err.number<>0 then err.clear
	end sub

	sub announceinfo()
	sql="select boardtype from board where boardID="&BoardID
   	rs.open sql,conn,1,1
	if not(rs.bof and rs.eof) then
   		boardtype=rs("boardtype")
	else
		foundErr = true
		ErrMsg=ErrMsg+"<br>"+"<li>��ָ������̳���治����</li>"
		exit sub
	end if
	rs.close
	'Rs.open "Select topic from bbs1 Where announceID="&AnnounceID&"",conn,1,1
     	set rs=conn.execute("select topic from bbs1 where announceID="&rootID&"")
	if not(rs.bof and rs.eof) then
		topic=rs("topic")
	else
		foundErr = true
		ErrMsg=ErrMsg+"<br>"+"<li>��ָ�������Ӳ�����</li>"
		exit sub
	end if
	rs.close
%>

<TABLE border=0 width="<%=tablewidth%>" align=center>
  <TBODY>
  <TR>
    <TD valign=middle align=top>
<b>���ı���ʽ�鿴����</b><br><br>
-&nbsp;&nbsp;<b><%=ForumName%></b>&nbsp;&nbsp;(<%=HostURL%><%=ForumURL%>index.asp)<br>
--&nbsp;&nbsp;<b><%=boardtype%></b>&nbsp;&nbsp;(<%=HostURL%><%=ForumURL%>bbs.asp?boardid=<%=boardid%>)<br>
----&nbsp;&nbsp;<b><%=htmlencode(topic)%></b>&nbsp;&nbsp;(<%=HostURL%><%=ForumURL%>dispbbs.asp?boardid=<%=boardid%>&rootid=<%=rootid%>&id=<%=announceid%>)
      </TD></TR></TBODY></TABLE> 
<br>
<hr>
<%
	Rs.open "Select UserName,Topic,dateandtime,body from bbs1 where boardid="&boardid&" and rootid="&rootid&" order by announceid",conn,1,1
       	do while not rs.eof
%>
<TABLE border=0 width="750" align=center>
  <TBODY>
  <TR>
    <TD valign=middle align=top>
--&nbsp;&nbsp;���ߣ�<%=rs("username")%><br>
--&nbsp;&nbsp;����ʱ�䣺<%=rs("dateandtime")%><br><br>
--&nbsp;&nbsp;<%=htmlencode(rs("topic"))%><br>
<%=ubbcode(rs("body"))%>
	<hr>
    </TD></TR></TBODY></TABLE> 
<%
          rs.movenext
        loop	
	rs.close
%>
<!----------------------������ʾEnd---------------------->
<%
	end sub
    
    	sub chkInput
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
    	end sub
	set urs=nothing
	set rs=nothing
	stats="�������"
	call endline()
%>
<!--#include file="footer.asp"-->
