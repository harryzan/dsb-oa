<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!-- #include file="chkuser.asp" -->
<!-- #include file="inc/char.asp" -->
<!-- #include file="inc/theme.asp" -->
<%
	dim announceid
	dim username
	dim rootid
	dim topic
	dim mailbody
	dim email
	dim content
	dim postname
	dim incepts
	dim announce
	dim boardmasterlist
	dim Master_1
    	Rem ------��ȡ����(get or post��)------
    	Rem ------���������ID��ҳ��------
	stats="���������������"
    call chkInput()
    if foundErr then
		call nav()
		call headline(2)
		call Error()
	else
		call boardinfo(boardid)
		call nav()
		call headline(2)
		if founderr then
			call error()
		else
			call showPage()
		end if
	end if
	call endline()
	sub showPage()
		if request("action")="send" then
			call announceinfo()
			if founderr then
			call error()
			else
			call success()
			end if
		else
			call pag()
		end if
	end sub
	Rem ���涨����Ϣ
	sub boardinfo(boardid)
  	sql="select boardmaster from board where "&guestlist&" boardID="&cstr(boardid)
	set rs=server.createobject("adodb.recordset")
 	rs.open sql,conn,1,1
 	if not(rs.bof and rs.eof) then
		boardmasterlist=rs(0)
		master_2=""
		if trim(boardmasterlist)<>"" then
			master_1=split(boardmasterlist, "|")
			for i = 0 to ubound(master_1)
			master_2=""&master_2&"<option value="""&master_1(i)&""">"&master_1(i)&"</option>&nbsp;"
			next
		else
			master_2="�ް���"
		end if
		'response.write master_2
		'response.end
	else
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>��ѡ��İ��治���ڻ�����û��Ȩ�޲쿴�ð��档"
		exit sub
	end if
	rs.close
	set rs=nothing
	end sub

	sub announceinfo()
	dim body
	dim writer
	dim incept
	dim topic,topic_1
	body=checkStr(request("content"))
	writer=membername
	incept=checkStr(request("boardmaster"))
	set rs=server.createobject("adodb.recordset")
	sql="select topic from bbs1 where announceID="&rootID
	rs.open sql,conn,1,1
	if not(rs.bof and rs.eof) then
		topic_1=rs(0)
		topic="���������������"
		body=body & "�����Ե�href=HTTP://WWW.DONGHAI-BRIDGE.COM.CN"&request.servervariables("server_name")&replace(request.servervariables("script_name"),"report.asp","")&"dispbbs.asp?boardid="&boardid&"&rootid="&rootid&"&id="&Announceid&"��������������"
	else
		foundErr = true
		ErrMsg=ErrMsg+"<br>"+"<li>��ָ�������Ӳ�����</li>"
		exit sub
	end if
	rs.close
	sql="insert into message (incept,sender,title,content,sendtime,flag,issend) values ('"&incept&"','"&membername&"','"&topic&"','"&body&"',Now(),0,1)"
	conn.execute(sql)
	set rs=nothing
	end sub

	sub pag()
%>
<table cellpadding=0 cellspacing=0 border=0 width="<%=tablewidth%>" bgcolor=<%=tablebackcolor%> align=center>
    <tr>
        <td>
        <table cellpadding=6 cellspacing=1 border=0 width=100%>
        
    <form action="report.asp?action=send&boardid=<%=boardid%>&rootid=<%=rootid%>&id=<%=announceid%>" method=post>
    <tr>
    <td bgcolor=<%=tabletitlecolor%> valign=middle colspan=2 align=center><font color="<%=TablefontColor%>">
    <b>���ͱ��������</b></font></td></tr>
    <tr>
    <td bgcolor=<%=tablebodycolor%>><font color="<%=TableContentColor%>"><b>���淢�͸��ĸ�������</b></font></td>
    <td bgcolor=<%=tablebodycolor%>><select name=boardmaster size=1><%=master_2%></select></td>
    </tr><tr>
    <td bgcolor=<%=atablebodycolor%>><font color="<%=TableContentColor%>"><b>��Ϣ���ݣ�</b><br>����������������Ƿ����ȡ�����
�Ǳ�Ҫ����²�Ҫʹ������ܣ�</font></td>
    <td bgcolor=<%=atablebodycolor%>><textarea name="content" cols="55" rows="6">����Ա�����ã���������ԭ�������㱨��������������ӣ�</textarea></td>
    </tr><tr>
    <td colspan=2 bgcolor=<%=tabletitlecolor%> align=center><input type=submit value="�� ��" name="Submit"></table></td></form></tr></table>
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
	if membername="" then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>��<a href=login.asp>��½</a>�������ز�����"
	end if
    	end sub

sub success()
%>
    <table cellpadding=0 cellspacing=0 border=0 width="<%=tablewidth%>" bgcolor=<%=tablebackcolor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
    <tr align="center"> 
      <td width="100%" bgcolor=<%=tabletitlecolor%>><font color="<%=TablefontColor%>">�ɹ�������ҳ��</font></td>
    </tr>
    <tr> 
      <td width="100%" bgcolor=<%=tablebodycolor%>><font color="<%=TableContentColor%>">��ϲ���������ͳɹ���</font>
      </td>
    </tr>
    <tr align="center"> 
      <td width="100%" bgcolor=<%=tabletitlecolor%>>
<a href="javascript:history.go(-1)"><font color="<%=TablefontColor%>"> << ������һҳ</font></a>
      </td>
    </tr>  
    </table>   </td></tr></table>
<%
end sub
	set rs=nothing
	stats="���������������"
%>
<!--#include file="footer.asp"-->
