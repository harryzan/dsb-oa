<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!-- #include file="chkuser.asp" -->
<!--#include file="inc/char.asp"-->
<!--#include file="inc/theme.asp"-->
<!--#include file="inc/ubbcode.asp"-->
<%Response.Buffer = true%>
<html>
<head>
<title><%=ForumName%>--����Ϣ</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<!--#include file=forum_css.asp-->
<script language="javascript">
function DoTitle(addTitle) { 
var revisedTitle; 
var currentTitle = document.messager.touser.value; 
revisedTitle = currentTitle+addTitle; 
document.messager.touser.value=revisedTitle; 
document.messager.touser.focus(); 
return; }
</script>
</head>
<body <%=Forumbody%>>
<%
	dim usersign
	usersign=false
	dim abgcolor
	dim msg
if not founduser then
  	errmsg=errmsg+"<br>"+"<li>��û��<a href=login.asp target=_blank>��¼</a>��"
	founderr=true
else

end if
call nav()
response.write "<TABLE border=0 width="&tablewidth&" align=center><TBODY>"&_
				"<TR><TD align=left><a href='"& HostURL &"'><img border=0 src='"& Forumlogo &"'></a></TD>"&_
				"<TD Align=right>  <a href=usersms.asp?action=inbox><img src=pic/m_inbox.gif border=0 alt=�ռ���></a> &nbsp; <a href=usersms.asp?action=outbox><img src=pic/M_outbox.gif border=0 alt=������></a> &nbsp; <a href=usersms.asp?action=issend><img src=pic/M_issend.gif border=0 alt=�ѷ����ʼ�></a>&nbsp; <a href=usersms.asp?action=recycle><img src=pic/M_recycle.gif border=0 alt=�ϼ���></a>&nbsp; <a href=friendlist.asp><img src=pic/M_address.gif border=0 alt=��ַ��></a>&nbsp;<a href=usersms.asp?action=new&id=><img src=pic/m_write.gif border=0 alt=������Ϣ></a> &nbsp;<a href=usersms.asp?action=new&touser="&htmlencode(request("sender"))&"&id="&request("id")&"><img src=pic/m_reply.gif border=0 alt=�ظ���Ϣ></a> &nbsp;<a href=usersms.asp?action=fw&id="&request("id")&"><img src=pic/m_fw.gif border=0 alt=ת����Ϣ></a>&nbsp;<a href=usersms.asp?action=deletmsg&id="&request("id")&"><img src=pic/m_delete.gif border=0 alt=ɾ����Ϣ></a>"&_
				"</TD></TR></TBODY></TABLE><br>"
if founderr=true then
	call error()
else
	select case request("action")
	case "inbox"
		call inbox()
	case "outbox"
		call outbox()
	case "issend"
		call issend()
	case "recycle"
		call recycle()
	case "new"
		call sendmsg()
	case "read"
		call read()
	case "outread"
		call read()
	case "deletmsg"
		call delete()
	case "send"
		call savemsg()
	case "newmsg"
		call newmsg()
	case "fw"
		call fw()
	case "edit"
		call edit()
	case "savedit"
		call savedit()
	case "ɾ���ռ�"
		call delinbox()
	case "����ռ���"
		call AllDelinbox()
	case "ɾ������"
		call deloutbox()
	case "��շ�����"
		call AllDeloutbox()
	case "ɾ���ѷ���Ϣ"
		call delissend()
	case "����ѷ�����Ϣ"
		call AllDelissend()
	case "ɾ��ָ����Ϣ"
		call delrecycle()
	case "��ջ���վ"
		call AllDelrecycle()
	case else
		call inbox()
	end select
	if founderr then call error()
end if
'�ռ���
sub inbox()
%>
<form action="usersms.asp" method=post name=inbox>
    <table cellpadding=0 cellspacing=0 border=0 width=<%=TableWidth%> bgcolor=<%=Tablebackcolor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
            <tr bgcolor=<%=Tabletitlecolor%>>
                <td align=center valign=middle width=30><font color="<%=TableFontColor%>"><b>�Ѷ�</b></font></td>
                <td align=center valign=middle width=100><font color="<%=TableFontColor%>"><b>������</b></font></td>
                <td align=center valign=middle width=300><font color="<%=TableFontColor%>"><b>����</b></font></td>
                <td align=center valign=middle width=150><font color="<%=TableFontColor%>"><b>����</b></font></td>
                <td align=center valign=middle width=50><font color="<%=TableFontColor%>"><b>��С</b></font></td>
                <td align=center valign=middle width=30><font color="<%=TableFontColor%>"><b>����</b></font></td>
            </tr>
<%
	set rs=server.createobject("adodb.recordset")
	sql="select * from message where incept='"&trim(membername)&"' and issend=1 and delR=0 order by flag,sendtime desc"
	rs.open sql,conn,1,1
	if rs.eof and rs.bof then
%>
                <tr>
                <td bgcolor=<%=Tablebodycolor%> align=center valign=middle colspan=6><font color="<%=TableContentColor%>">�����ռ�����û���κ����ݡ�</font></td>
                </tr>
<%else%>
<%do while not rs.eof%>
                <tr bgcolor=<%if rs("flag")=0 then%>"<%=aTablebodycolor%>"<%else%>"<%=Tablebodycolor%>"<%end if%>>
                    <td align=center valign=middle><%if rs("flag")=0 then%><img src="pic/m_news.gif"><%else%><img src="<%=picurl%>m_olds.gif"><%end if%></td>
                    <td align=center valign=middle><%if rs("flag")=0 then%><b><%end if%><a href="dispuser.asp?name=<%=htmlencode(rs("sender"))%>" target=_blank><%=htmlencode(rs("sender"))%></a></td>
                    <td align=left><a href="usersms.asp?action=read&id=<%=rs("id")%>&sender=<%=rs("sender")%>"><%if rs("flag")=0 then%><b><%end if%><%=htmlencode(rs("title"))%></a>	</td>
                    <td><font color="<%=TableContentColor%>"><%if rs("flag")=0 then%><b><%end if%><%=rs("sendtime")%></font></td>
                    <td><font color="<%=TableContentColor%>"><%if rs("flag")=0 then%><b><%end if%><%=len(rs("content"))%>Byte</font></td>
                <td align=center valign=middle width=30><input type=checkbox name=id value=<%=rs("id")%>></td>
                </tr>
<%
	rs.movenext
	loop
	end if
	rs.close
	set rs=nothing
%>
                
        <tr bgcolor="<%=Tabletitlecolor%>"> 
          <td align=right valign=middle colspan=6><font color="<%=TablefontColor%>">��ʡÿһ�ֿռ䣬�뼰ʱɾ��������Ϣ&nbsp;<input type=checkbox name=chkall value=on onclick="CheckAll(this.form)">ѡ��������ʾ��¼&nbsp;<input type=submit name=action onclick="{if(confirm('ȷ��ɾ��ѡ���ļ�¼��?')){this.document.inbox.submit();return true;}return false;}" value="ɾ���ռ�">&nbsp;<input type=submit name=action onclick="{if(confirm('ȷ������ռ������еļ�¼��?')){this.document.inbox.submit();return true;}return false;}" value="����ռ���"></font></td>
                </tr>
                </table></td></tr></table></form>
<%
end sub
'�ռ��߼�ɾ�������ڻ���վ������ֶ�delR������������������ɾ��
sub delinbox()
dim delid
delid=replace(request("id"),"'","")
if delid="" or isnull(delid) then
Errmsg=Errmsg+"<li>"+"��ѡ����ز�����"
Founderr=true
else
	conn.execute("update message set delR=1 where incept='"&trim(membername)&"' and id in ("&delid&")")
	msg=msg+"<br>"+"<li><b>��ϲ����ɾ������Ϣ�ɹ���</b><br>ɾ������Ϣ��ת�Ƶ����Ļ���վ��"
	call success()
end if
end sub
sub AllDelinbox()
	conn.execute("update message set delR=1 where incept='"&trim(membername)&"' and delR=0")
	msg=msg+"<br>"+"<li><b>��ϲ����ɾ������Ϣ�ɹ���</b><br>ɾ������Ϣ��ת�Ƶ����Ļ���վ��"
	call success()
end sub

'������
sub outbox()
%>
<form action="usersms.asp" method=post name=inbox>
    <table cellpadding=0 cellspacing=0 border=0 width=<%=TableWidth%> bgcolor=<%=Tablebackcolor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
            <tr bgcolor=<%=Tabletitlecolor%>>
                <td align=center valign=middle width=30><font color="<%=TableFontColor%>"><b>�Ѷ�</b></font></td>
                <td align=center valign=middle width=100><font color="<%=TableFontColor%>"><b>�ռ���</b></font></td>
                <td align=center valign=middle width=300><font color="<%=TableFontColor%>"><b>����</b></font></td>
                <td align=center valign=middle width=150><font color="<%=TableFontColor%>"><b>����</b></font></td>
                <td align=center valign=middle width=50><font color="<%=TableFontColor%>"><b>��С</b></font></td>
                <td align=center valign=middle width=30><font color="<%=TableFontColor%>"><b>����</b></font></td>
            </tr>
<%
	set rs=server.createobject("adodb.recordset")
	sql="select * from message where sender='"&trim(membername)&"' and issend=0 and delS=0 order by sendtime desc"
	rs.open sql,conn,1,1
	if rs.eof and rs.bof then
%>
                <tr>
                <td bgcolor=<%=Tablebodycolor%> align=center valign=middle colspan=6><font color="<%=TableContentColor%>">���ķ�������û���κ����ݡ�</font></td>
                </tr>
<%else%>
<%do while not rs.eof%>
                <tr bgcolor=<%if rs("flag")=0 then%>"<%=aTablebodycolor%>"<%else%>"<%=Tablebodycolor%>"<%end if%>>
                    <td align=center valign=middle><img src="<%=picurl%>m_issend_2.gif"></td>
                    <td align=center valign=middle><%if rs("flag")=0 then%><b><%end if%><a href="dispuser.asp?name=<%=htmlencode(rs("incept"))%>" target=_blank><%=htmlencode(rs("incept"))%></a></td>
                    <td align=left><a href="usersms.asp?action=edit&id=<%=rs("id")%>"><%if rs("flag")=0 then%><b><%end if%><%=htmlencode(rs("title"))%></a>	</td>
                    <td><font color="<%=TableContentColor%>"><%if rs("flag")=0 then%><b><%end if%><%=rs("sendtime")%></font></td>
                    <td><font color="<%=TableContentColor%>"><%if rs("flag")=0 then%><b><%end if%><%=len(rs("content"))%>Byte</font></td>
                <td align=center valign=middle width=30><input type=checkbox name=id value=<%=rs("id")%>></td>
                </tr>
<%
	rs.movenext
	loop
	end if
	rs.close
	set rs=nothing
%>
                
        <tr bgcolor="<%=Tabletitlecolor%>"> 
          <td align=right valign=middle colspan=6><font color="<%=TablefontColor%>">��ʡÿһ�ֿռ䣬�뼰ʱɾ��������Ϣ&nbsp;<input type=checkbox name=chkall value=on onclick="CheckAll(this.form)">ѡ��������ʾ��¼&nbsp;<input type=submit name=action onclick="{if(confirm('ȷ��ɾ��ѡ���ļ�¼��?')){this.document.inbox.submit();return true;}return false;}" value="ɾ������">&nbsp;<input type=submit name=action onclick="{if(confirm('ȷ��������������еļ�¼��?')){this.document.inbox.submit();return true;}return false;}" value="��շ�����"></font></td>
                </tr>
                </table></td></tr></table></form>
<%
end sub
'�����߼�ɾ�������ڻ���վ������ֶ�delS������������������ɾ��
sub deloutbox()
dim delid
delid=replace(request("id"),"'","")
if delid="" or isnull(delid) then
Errmsg=Errmsg+"<li>"+"��ѡ����ز�����"
Founderr=true
else
	conn.execute("update message set delS=1 where sender='"&trim(membername)&"' and issend=0 and id in ("&delid&")")
	msg=msg+"<br>"+"<li><b>��ϲ����ɾ������Ϣ�ɹ���</b><br>ɾ������Ϣ��ת�Ƶ����Ļ���վ��"
	call success()
end if
end sub
sub AllDeloutbox()
	conn.execute("update message set delS=1 where sender='"&trim(membername)&"' and delS=0 and issend=0")
	msg=msg+"<br>"+"<li><b>��ϲ����ɾ������Ϣ�ɹ���</b><br>ɾ������Ϣ��ת�Ƶ����Ļ���վ��"
	call success()
end sub

'�ѷ�����Ϣ
sub issend()
%>
<form action="usersms.asp" method=post name=inbox>
    <table cellpadding=0 cellspacing=0 border=0 width=<%=TableWidth%> bgcolor=<%=Tablebackcolor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
            <tr bgcolor=<%=Tabletitlecolor%>>
                <td align=center valign=middle width=30><font color="<%=TableFontColor%>"><b>�Ѷ�</b></font></td>
                <td align=center valign=middle width=100><font color="<%=TableFontColor%>"><b>�ռ���</b></font></td>
                <td align=center valign=middle width=300><font color="<%=TableFontColor%>"><b>����</b></font></td>
                <td align=center valign=middle width=150><font color="<%=TableFontColor%>"><b>����</b></font></td>
                <td align=center valign=middle width=50><font color="<%=TableFontColor%>"><b>��С</b></font></td>
                <td align=center valign=middle width=30><font color="<%=TableFontColor%>"><b>����</b></font></td>
            </tr>
<%
	set rs=server.createobject("adodb.recordset")
	sql="select * from message where sender='"&trim(membername)&"' and issend=1 and delS=0 order by sendtime desc"
	rs.open sql,conn,1,1
	if rs.eof and rs.bof then
%>
                <tr>
                <td bgcolor=<%=Tablebodycolor%> align=center valign=middle colspan=6><font color="<%=TableContentColor%>">�����ѷ�����Ϣ��û���κ����ݡ�</font></td>
                </tr>
<%else%>
<%do while not rs.eof%>
                <tr bgcolor=<%if rs("flag")=0 then%>"<%=aTablebodycolor%>"<%else%>"<%=Tablebodycolor%>"<%end if%>>
                    <td align=center valign=middle><img src="<%=picurl%>m_issend_1.gif"></td>
                    <td align=center valign=middle><%if rs("flag")=0 then%><b><%end if%><a href="dispuser.asp?name=<%=htmlencode(rs("incept"))%>" target=_blank><%=htmlencode(rs("incept"))%></a></td>
                    <td align=left><a href="usersms.asp?action=outread&id=<%=rs("id")%>"><%if rs("flag")=0 then%><b><%end if%><%=htmlencode(rs("title"))%></a>	</td>
                    <td><font color="<%=TableContentColor%>"><%if rs("flag")=0 then%><b><%end if%><%=rs("sendtime")%></font></td>
                    <td><font color="<%=TableContentColor%>"><%if rs("flag")=0 then%><b><%end if%><%=len(rs("content"))%>Byte</font></td>
                <td align=center valign=middle width=30><input type=checkbox name=id value=<%=rs("id")%>></td>
                </tr>
<%
	rs.movenext
	loop
	end if
	rs.close
	set rs=nothing
%>
                
        <tr bgcolor="<%=Tabletitlecolor%>"> 
          <td align=right valign=middle colspan=6><font color="<%=TablefontColor%>">��ʡÿһ�ֿռ䣬�뼰ʱɾ��������Ϣ&nbsp;<input type=checkbox name=chkall value=on onclick="CheckAll(this.form)">ѡ��������ʾ��¼&nbsp;<input type=submit name=action onclick="{if(confirm('ȷ��ɾ��ѡ���ļ�¼��?')){this.document.inbox.submit();return true;}return false;}" value="ɾ���ѷ���Ϣ">&nbsp;<input type=submit name=action onclick="{if(confirm('ȷ������ѷ�����Ϣ���еļ�¼��?')){this.document.inbox.submit();return true;}return false;}" value="����ѷ�����Ϣ"></font></td>
                </tr>
                </table></td></tr></table></form>
<%
end sub
'�ѷ����߼�ɾ�������ڻ���վ������ֶ�delS������������������ɾ��
'delS��0δ������1������ɾ����2�����ߴӻ���վɾ��
sub delissend()
dim delid
delid=replace(request("id"),"'","")
if delid="" or isnull(delid) then
Errmsg=Errmsg+"<li>"+"��ѡ����ز�����"
Founderr=true
else
	conn.execute("update message set delS=1 where sender='"&trim(membername)&"' and issend=1 and id in ("&delid&")")
	msg=msg+"<br>"+"<li><b>��ϲ����ɾ������Ϣ�ɹ���</b><br>ɾ������Ϣ��ת�Ƶ����Ļ���վ��"
	call success()
end if
end sub
sub AllDelissend()
	conn.execute("update message set delS=1 where sender='"&trim(membername)&"' and delS=0 and issend=1")
	msg=msg+"<br>"+"<li><b>��ϲ����ɾ������Ϣ�ɹ���</b><br>ɾ������Ϣ��ת�Ƶ����Ļ���վ��"
	call success()
end sub
'����վ
sub recycle()
%>
<form action="usersms.asp" method=post name=inbox>
    <table cellpadding=0 cellspacing=0 border=0 width=<%=TableWidth%> bgcolor=<%=Tablebackcolor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
            <tr bgcolor=<%=Tabletitlecolor%>>
                <td align=center valign=middle width=30><font color="<%=TableFontColor%>"><b>�Ѷ�</b></font></td>
                <td align=center valign=middle width=100><font color="<%=TableFontColor%>"><b>����</b></font></td>
                <td align=center valign=middle width=300><font color="<%=TableFontColor%>"><b>����</b></font></td>
                <td align=center valign=middle width=150><font color="<%=TableFontColor%>"><b>����</b></font></td>
                <td align=center valign=middle width=50><font color="<%=TableFontColor%>"><b>��С</b></font></td>
                <td align=center valign=middle width=30><font color="<%=TableFontColor%>"><b>����</b></font></td>
            </tr>
<%
	set rs=server.createobject("adodb.recordset")
	sql="select * from message where ((sender='"&trim(membername)&"' and delS=1) or (incept='"&trim(membername)&"' and delR=1)) and not delS=2 order by sendtime desc"
	rs.open sql,conn,1,1
	if rs.eof and rs.bof then
%>
                <tr>
                <td bgcolor=<%=Tablebodycolor%> align=center valign=middle colspan=6><font color="<%=TableContentColor%>">���ķϼ�����û���κ����ݡ�</font></td>
                </tr>
<%else%>
<%do while not rs.eof%>
                <tr bgcolor=<%if rs("flag")=0 then%>"<%=aTablebodycolor%>"<%else%>"<%=Tablebodycolor%>"<%end if%>>
                    <td align=center valign=middle><font face="����" color="#333333"><%if rs("flag")=0 then%><img src="pic/m_news.gif"><%else%><img src="pic/m_olds.gif"><%end if%></font></td>
                    <td align=center valign=middle><%if rs("flag")=0 then%><b><%end if%><a href="dispuser.asp?name=<%=htmlencode(rs("incept"))%>" target=_blank><%=htmlencode(rs("incept"))%></a></td>
                    <td align=left><a href="usersms.asp?action=read&id=<%=rs("id")%>"><%if rs("flag")=0 then%><b><%end if%><%=htmlencode(rs("title"))%></a>	</td>
                    <td><font color="<%=TableContentColor%>"><%if rs("flag")=0 then%><b><%end if%><%=rs("sendtime")%></font></td>
                    <td><font color="<%=TableContentColor%>"><%if rs("flag")=0 then%><b><%end if%><%=len(rs("content"))%>Byte</font></td>
                <td align=center valign=middle width=30><input type=checkbox name=id value=<%=rs("id")%>></td>
                </tr>
<%
	rs.movenext
	loop
	end if
	rs.close
	set rs=nothing
%>
                
        <tr bgcolor="<%=Tabletitlecolor%>"> 
          <td align=right valign=middle colspan=6><font color="<%=TablefontColor%>">��ʡÿһ�ֿռ䣬�뼰ʱɾ��������Ϣ&nbsp;<input type=checkbox name=chkall value=on onclick="CheckAll(this.form)">ѡ��������ʾ��¼&nbsp;<input type=submit name=action onclick="{if(confirm('ȷ��ɾ��ѡ���ļ�¼��?')){this.document.inbox.submit();return true;}return false;}" value="ɾ��ָ����Ϣ">&nbsp;<input type=submit name=action onclick="{if(confirm('ȷ���������վ���еļ�¼��?')){this.document.inbox.submit();return true;}return false;}" value="��ջ���վ"></font></td>
                </tr>
                </table></td></tr></table></form>
<%
end sub
'�û�����ȫɾ���յ���Ϣ���߼�ɾ����������Ϣ���߼�ɾ����������Ϣ��������ֶ�delS����Ϊ2
sub delrecycle()
dim delid
delid=replace(request("id"),"'","")
'response.write delid
if delid="" or isnull(delid) then
Errmsg=Errmsg+"<li>"+"��ѡ����ز�����"
Founderr=true
exit sub
else
	conn.execute("delete from message where incept='"&membername&"' and delR=1 and id in ("&delid&")")
	conn.execute("update message set delS=2 where sender='"&trim(membername)&"' and delS=1 and id in ("&delid&")")
	msg=msg+"<br>"+"<li><b>��ϲ����ɾ������Ϣ�ɹ���</b><br>ɾ������Ϣ�����ɻָ���"
	call success()
end if
end sub
sub AllDelrecycle()
	conn.execute("delete from message where incept='"&membername&"' and delR=1")	
	conn.execute("update message set delS=2 where sender='"&trim(membername)&"' and delS=1")
	msg=msg+"<br>"+"<li><b>��ϲ����ɾ������Ϣ�ɹ���</b><br>ɾ������Ϣ�����ɻָ���"
	call success()
end sub

sub delete()
dim delid
delid=request("id")
if not isNumeric(request("id")) or delid="" or isnull(delid) then
Errmsg=Errmsg+"<li>"+"��ѡ����ز�����"
Founderr=true
else
	conn.execute("update message set delR=1 where incept='"&trim(membername)&"' and id="&delid)
	conn.execute("update message set delS=1 where sender='"&trim(membername)&"' and id="&delid)
	msg=msg+"<br>"+"<li><b>��ϲ����ɾ������Ϣ�ɹ���</b><br>ɾ������Ϣ���������Ļ���վ�ڡ�"
	call success()
end if
end sub
'������Ϣ
sub sendmsg()
dim title,content,sendtime
if request("id")<>"" and isNumeric(request("id")) then
set rs=server.createobject("adodb.recordset")
sql="select sendtime,title,content from message where incept='"&membername&"' and id="&request("id")
rs.open sql,conn,1,1
if not(rs.eof and rs.bof) then
sendtime=rs("sendtime")
title="RE " & rs("title")
content=rs("content")
end if
rs.close
set rs=nothing
end if
%>
<form action="usersms.asp" method=post name=messager>
  <table cellpadding=0 cellspacing=0 border=0 width=<%=TableWidth%> bgcolor=<%=Tablebackcolor%> align=center>
    <tr> 
      <td> 
        <table cellpadding=3 cellspacing=1 border=0 width=100%>
          <tr> 
            <td bgcolor=<%=Tabletitlecolor%> colspan=2 align=center> 
              <input type=hidden name="action" value="send">
              <font color="<%=TablefontColor%>"><b>���Ͷ���Ϣ</b>--����������������Ϣ</font></td>
          </tr>
          <tr> 
            <td bgcolor=<%=Tablebodycolor%> valign=middle width=70><font color="<%=TableContentColor%>"><b>�ռ��ˣ�</b></font></td>
            <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>">
              <input type=text name="touser" value="<%=request("touser")%>" size=50>
              <SELECT name=font onchange=DoTitle(this.options[this.selectedIndex].value)>
              <OPTION selected value="">ѡ��</OPTION>
<%
set rs=server.createobject("adodb.recordset")
sql="select F_friend from Friend where F_username='"&membername&"' order by F_addtime desc"
rs.open sql,conn,1,1
do while not rs.eof
%>
			  <OPTION value="<%=rs(0)%>"><%=rs(0)%></OPTION> 
<%
rs.movenext
loop
rs.close
set rs=nothing
%>
			  </SELECT>
			  &nbsp;ʹ�ö��ţ�,���ֿ������5λ�û�</font>
            </td>
          </tr>
          <tr> 
            <td bgcolor=<%=Tablebodycolor%> valign=top><font color="<%=TableContentColor%>"><b>���⣺</b></font></td>
            <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>">
              <input type=text name="title" size=50 maxlength=80 value="<%=title%>">&nbsp;���޶�50����</font>
            </td>
          </tr>
          <tr> 
            <td bgcolor=<%=Tablebodycolor%> valign=top><font color="<%=TableContentColor%>"><b>���ݣ�</b><br></font></td>
            <td bgcolor=<%=Tablebodycolor%> valign=middle>
              <textarea cols=70 rows=8 name="message" title="">

<%if request("id")<>"" then%>
============= �� <%=sendtime%> ��������д���� ============
<%=content%>
========================================================<%end if%></textarea>
            </td>
          </tr>
          <tr> 
            <td bgcolor=<%=Tabletitlecolor%> valign=middle colspan=2 align=center> 
              <input type=Submit value="����" name=Submit>
              &nbsp; 
              <input type=Submit value="����" name=Submit>
              &nbsp; 
              <input type="reset" name="Clear" value="���">
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</form>
<%
end sub
'ת����Ϣ
sub fw()
dim title,content,sender
if request("id")<>"" and isNumeric(request("id")) then
set rs=server.createobject("adodb.recordset")
sql="select title,content,sender from message where (incept='"&membername&"' or sender='"&membername&"') and id="&request("id")
rs.open sql,conn,1,1
if rs.eof and rs.bof then
Errmsg=Errmsg+"<br>"+"<li>��ѡ����ز�����"
Founderr=true
exit sub
else
title=rs("title")
content=rs("content")
sender=rs("sender")
end if
rs.close
set rs=nothing
end if
%>
<form action="usersms.asp" method=post name=messager>
  <table cellpadding=0 cellspacing=0 border=0 width=<%=TableWidth%> bgcolor=<%=Tablebackcolor%> align=center>
    <tr> 
      <td> 
        <table cellpadding=3 cellspacing=1 border=0 width=100%>
          <tr> 
            <td bgcolor=<%=Tabletitlecolor%> colspan=2 align=center> 
              <input type=hidden name="action" value="send">
              <font color="<%=TablefontColor%>"><b>���Ͷ���Ϣ</b>--����������������Ϣ</font></td>
          </tr>
          <tr> 
            <td bgcolor=<%=Tablebodycolor%> valign=middle width=70><font color="<%=TableContentColor%>"><b>�ռ��ˣ�</b></font></td>
            <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>">
              <input type=text name="touser" value="<%=request("touser")%>" size=50>&nbsp;ʹ�ö��ţ�,���ֿ������5λ�û�</font>
            </td>
          </tr>
          <tr> 
            <td bgcolor=<%=Tablebodycolor%> valign=top><font color="<%=TableContentColor%>"><b>���⣺</b></font></td>
            <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>">
              <input type=text name="title" size=50 maxlength=80 value="Fw��<%=title%>">&nbsp;���޶�50����</font>
            </td>
          </tr>
          <tr> 
            <td bgcolor=<%=Tablebodycolor%> valign=top><font color="<%=TableContentColor%>"><b>���ݣ�</b><br></font></td>
            <td bgcolor=<%=Tablebodycolor%> valign=middle>
              <textarea cols=70 rows=8 name="message" title="">


========== ������ת����Ϣ =========
ԭ�����ˣ�<%=sender%><%=chr(13)&chr(13)%>
<%=content%>
===================================</textarea>
            </td>
          </tr>
          <tr> 
            <td bgcolor=<%=Tabletitlecolor%> valign=middle colspan=2 align=center> 
              <input type=Submit value="����" name=Submit>
              &nbsp; 
              <input type=Submit value="����" name=Submit>
              &nbsp; 
              <input type="reset" name="Clear" value="���">
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</form>
<%
end sub
'������Ϣ
sub edit()
dim incept,title,content,id
if request("id")<>"" or isNumeric(request("id")) then
	set rs=server.createobject("adodb.recordset")
sql="select id,incept,title,content from message where sender='"&membername&"' and issend=0 and id="&request("id")
rs.open sql,conn,1,1
if not(rs.eof and rs.bof) then
incept=rs("incept")
title=rs("title")
content=rs("content")
id=rs("id")
else
Errmsg=Errmsg+"<br>"+"<li>û���ҵ���Ҫ�༭����Ϣ��"
Founderr=true
exit sub
end if
rs.close
set rs=nothing
else
Errmsg=Errmsg+"<br>"+"<li>��ָ����ز�����"
Founderr=true
exit sub
end if
%>
<form action="usersms.asp" method=post name=messager>
  <table cellpadding=0 cellspacing=0 border=0 width=<%=TableWidth%> bgcolor=<%=Tablebackcolor%> align=center>
    <tr> 
      <td> 
        <table cellpadding=3 cellspacing=1 border=0 width=100%>
          <tr> 
            <td bgcolor=<%=Tabletitlecolor%> colspan=2 align=center> 
              <input type=hidden name="action" value="savedit"> 
              <input type=hidden name="id" value="<%=id%>">
              <font color="<%=TablefontColor%>"><b>���Ͷ���Ϣ</b>--����������������Ϣ</font></td>
          </tr>
          <tr> 
            <td bgcolor=<%=Tablebodycolor%> valign=middle width=70><font color="<%=TableContentColor%>"><b>�ռ��ˣ�</b></font></td>
            <td bgcolor=<%=Tablebodycolor%> valign=middle>
              <input type=text name="touser" value="<%=incept%>" size=70>
            </td>
          </tr>
          <tr> 
            <td bgcolor=<%=Tablebodycolor%> valign=top><font color="<%=TableContentColor%>"><b>���⣺</b></font></td>
            <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>">
              <input type=text name="title" size=70 maxlength=80 value="<%=title%>">&nbsp;���޶�50����</font>
            </td>
          </tr>
          <tr> 
            <td bgcolor=<%=Tablebodycolor%> valign=top><font color="<%=TableContentColor%>"><b>���ݣ�</b><br></font></td>
            <td bgcolor=<%=Tablebodycolor%> valign=middle>
              <textarea cols=70 rows=8 name="message" title=""><%=content%></textarea>
            </td>
          </tr>
          <tr> 
            <td bgcolor=<%=Tabletitlecolor%> valign=middle colspan=2 align=center> 
              <input type=Submit value="����" name=Submit>
              &nbsp; 
              <input type=Submit value="����" name=Submit>
              &nbsp; 
              <input type="reset" name="Clear" value="���">
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</form>
<%
end sub
'��ȡ��Ϣ
sub read()
if request("id")="" or not isNumeric(request("id")) then
Errmsg=Errmsg+"<br>"+"<li>��ָ����ز�����"
Founderr=true
exit sub
end if
	set rs=server.createobject("adodb.recordset")
	if request("action")="read" then
   	sql="update message set flag=1 where ID="&cstr(request("id"))
	conn.execute(sql)
	end if
	sql="select * from message where (incept='"&membername&"' or sender='"&membername&"') and id="&cstr(request("id"))
	rs.open sql,conn,1,1
	if rs.eof and rs.bof then
		errmsg=errmsg+"<br>"+"<li>���ǲ����ܵ����˵������������߸���Ϣ�Ѿ��ռ���ɾ����"
		founderr=true
	end if
	if not founderr then
%>
<table cellpadding=0 cellspacing=0 border=0 width=<%=TableWidth%> bgcolor=<%=Tablebackcolor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
                
            <tr>
                <td bgcolor=<%=Tabletitlecolor%> align=center><font  color="<%=TableFontColor%>"><b>��ӭʹ�ö���Ϣ���գ�<%=membername%></b></font></td>
            </tr>
                <tr>
                    <td bgcolor=<%=aTabletitlecolor%>><font color="<%=TableContentColor%>">
<%if request("action")="outread" then%>
                    ��<b><%=rs("sendtime")%></b>�������ʹ���Ϣ��<b><%=htmlencode(rs("incept"))%></b>��
<%else%>
		    ��<b><%=rs("sendtime")%></b>��<b><%=htmlencode(rs("sender"))%></b>�������͵���Ϣ��
<%end if%></font></td>
                </tr>
                <tr>
                    <td bgcolor=<%=Tablebodycolor%> valign=top align=left><font color=<%=TableContentColor%>>
                    <b>��Ϣ���⣺<%=htmlencode(rs("title"))%></b><hr size=1>
                    <%=ubbcode(rs("content"))%></font>
		    </td>
                </tr>
                </table></td></tr></table>
<%end if%>
<%
rs.close
set rs=nothing
end sub

sub savemsg()
	dim incept,title,message,subtype
	if request("touser")="" then
		errmsg=errmsg+"<br>"+"<li>��������д���Ͷ����˰ɡ�"
		founderr=true
	else
		incept=checkStr(request("touser"))
		incept=split(incept,",")
	end if
	if request("title")="" then
		errmsg=errmsg+"<br>"+"<li>����û����д����ѽ��"
		founderr=true
	else
		title=checkStr(request("title"))
	end if
	if request("message")="" then
		errmsg=errmsg+"<br>"+"<li>�����Ǳ���Ҫ��д���ޡ�"
		founderr=true
	else
		message=checkStr(request("message"))
	end if
	if not founderr then
		for i=0 to ubound(incept)
		set rs=server.createobject("adodb.recordset")
		sql="select username from [user] where username='"&incept(i)&"'"
		rs.open sql,conn,1,1
		if rs.eof and rs.bof then
			errmsg=errmsg+"<br>"+"<li>��̳û������û���������ķ��Ͷ���д�����"
			founderr=true
		end if
		rs.close
		set rs=nothing

		if not founderr then
		if request("Submit")="����" then
		sql="insert into message (incept,sender,title,content,sendtime,flag,issend) values ('"&incept(i)&"','"&membername&"','"&title&"','"&message&"',Now(),0,1)"
		subtype="�ѷ�����Ϣ"
		else
		sql="insert into message (incept,sender,title,content,sendtime,flag,issend) values ('"&incept(i)&"','"&membername&"','"&title&"','"&message&"',Now(),0,0)"
		subtype="������"
		end if
		conn.execute(sql)
			if i>4 then
			errmsg=errmsg+"<br>"+"<li>���ֻ�ܷ��͸�5���û�����������5λ�Ժ�������·���"
			founderr=true
			exit for
			end if
		end if
		next
		if not founderr then
		msg=msg+"<br>"+"<li><b>��ϲ�������Ͷ���Ϣ�ɹ���</b><br>���͵���Ϣͬʱ����������"&subtype&"�С�"
		call success()
		end if
	end if
end sub
sub savedit()
	dim incept,title,message,subtype
	if request("id")="" or not isNumeric(request("id")) then
		Errmsg=Errmsg+"<br>"+"<li>��ָ����ز�����"
		Founderr=true
		exit sub
	end if
	if request("touser")="" then
		errmsg=errmsg+"<br>"+"<li>��������д���Ͷ����˰ɡ�"
		founderr=true
		exit sub
	else
		incept=checkStr(request("touser"))
	end if
	if request("title")="" then
		errmsg=errmsg+"<br>"+"<li>����û����д����ѽ��"
		founderr=true
		exit sub
	else
		title=checkStr(request("title"))
	end if
	if request("message")="" then
		errmsg=errmsg+"<br>"+"<li>�����Ǳ���Ҫ��д���ޡ�"
		founderr=true
		exit sub
	else
		message=checkStr(request("message"))
	end if
	if not founderr then
		set rs=server.createobject("adodb.recordset")
		sql="select username from [user] where username='"&incept&"'"
		rs.open sql,conn,1,1
		if rs.eof and rs.bof then
			errmsg=errmsg+"<br>"+"<li>��̳û������û���������ķ��Ͷ���д�����"
			founderr=true
			exit sub
		end if
		rs.close
		set rs=nothing

		if not founderr then
		if request("Submit")="����" then
		sql="update message set incept='"&incept&"',sender='"&membername&"',title='"&title&"',content='"&message&"',sendtime=Now(),flag=0,issend=1 where id="&request("id")
		subtype="�ѷ�����Ϣ"
		else
		sql="update message set incept='"&incept&"',sender='"&membername&"',title='"&title&"',content='"&message&"',sendtime=Now(),flag=0,issend=0 where id="&request("id")
		subtype="������"
		end if
		conn.execute(sql)
		end if
		if not founderr then
		msg=msg+"<br>"+"<li><b>��ϲ�������Ͷ���Ϣ�ɹ���</b><br>���͵���Ϣͬʱ����������"&subtype&"�С�"
		call success()
		end if
	end if
end sub

sub success()
%>
    <table cellpadding=0 cellspacing=0 border=0 width=<%=TableWidth%> bgcolor=<%=Tablebackcolor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
    <tr align="center"> 
      <td width="100%" bgcolor=<%=Tabletitlecolor%>><font color="<%=TablefontColor%>">�ɹ�������Ϣ</font></td>
    </tr>
    <tr> 
      <td width="100%" bgcolor=<%=Tablebodycolor%>><font color="<%=TableContentColor%>"><%=msg%></font>
      </td>
    </tr>
    </table>   </td></tr></table>
<%
end sub

sub newmsg()
%>
    <table cellpadding=0 cellspacing=0 border=0 width=<%=TableWidth%> bgcolor=<%=Tablebackcolor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
    <tr align="center"> 
      <td width="100%" bgcolor=<%=Tabletitlecolor%>><font color="<%=TablefontColor%>">����Ϣ֪ͨ</font></td>
    </tr>
    <tr> 
      <td width="100%" bgcolor=<%=Tablebodycolor%> align=center><br>
<a href=usersms.asp?action=inbox><img src="<%=picurl%>newmail.gif" border=0>���µĶ���Ϣ</a><br>
                <br>
                <a href=usersms.asp?action=inbox>���˲鿴</a><br><br>
      </td>
    </tr>
    </table>   </td></tr></table>
<%
end sub
stats="���Ͷ���"
call endline()
%>
<script language="JavaScript">
<!--
function CheckAll(form)  {
  for (var i=0;i<form.elements.length;i++)    {
    var e = form.elements[i];
    if (e.name != 'chkall')       e.checked = form.chkall.checked; 
   }
  }
//-->
</script>
<!--#include file="footer.asp"-->