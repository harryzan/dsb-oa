<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!-- #include file="chkuser.asp" -->
<!--#include file="inc/char.asp"-->
<!--#include file="inc/ubbcode.asp"-->
<html>
<head>
<title><%=ForumName%>--����Ϣ</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<!--#include file="Forum_css.asp"-->
</head>
<body <%=ForumBody%>" onkeydown="if(event.keyCode==13 && event.ctrlKey)messager.submit()">
<%
	dim msg
	dim abgcolor
	dim usersign
	usersign=false
	set rs=server.createobject("adodb.recordset")

if membername="" then
  	errmsg=errmsg+"<br>"+"<li>��û��<a href=login.asp target=_blank>��¼</a>��"
	founderr=true
else

end if

if founderr=true then
	call error()
else
	if request("action")="new" then
	call sendmsg()
	elseif request("action")="read" or request("action")="outread" then
	call read()
	elseif request("action")="delete" then
	call delete()
	elseif request("action")="send" then
	call savemsg()
	elseif request("action")="newmsg" then
	call newmsg()
	elseif request("action")="fw" then
	call fw()
	else
  	errmsg=errmsg+"<br>"+"<li>��ָ����ȷ�Ĳ�����"
	founderr=true
	end if
	if founderr then call error()
end if
'������Ϣ
sub sendmsg()
dim sendtime,title,content
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
<form action="messanger.asp" method=post name=messager>
<input type=hidden name="action" value="send">
  <table cellpadding=0 cellspacing=0 border=0 width="<%=tablewidth%>" bgcolor=<%=Tablebackcolor%> align=center>
    <tr> 
      <td> 
        <table cellpadding=3 cellspacing=1 border=0 width=100%>
          <tr> 
            <td bgcolor=<%=Tabletitlecolor%> align=center colspan=3><font color="<%=TablefontColor%>"><b>���Ͷ���Ϣ</b>��������������Ϣ��</font></td>
          </tr>
          <tr> 
            <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>"><b>�ռ��ˣ�</b><BR>ʹ�ö��ţ�,���ֿ������5λ�û�</font></td>
            <td bgcolor=<%=Tablebodycolor%> valign=middle>
              <input type=text name="touser" value="<%=request("touser")%>" size=20>
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
            </td>
          </tr>
          <tr> 
            <td bgcolor=<%=Tablebodycolor%> valign=top width=30%><font color="<%=TableContentColor%>"><b>���⣺</b></font></td>
            <td bgcolor=<%=Tablebodycolor%> valign=middle>
              <input type=text name="title" size=36 maxlength=80>
            </td>
          </tr>
          <tr> 
            <td bgcolor=<%=Tablebodycolor%> valign=top width=30%><font color="<%=TableContentColor%>"><b>���ݣ�</b><br>Ctrl+Enter����</font></td>
            <td bgcolor=<%=Tablebodycolor%> valign=middle>
              <textarea cols=35 rows=6 name="message" title="Ctrl+Enter����">
<%if request("id")<>"" then%>
====== �� <%=sendtime%> ��������д���� ======
<%=content%>
==========================================
<%end if%>
			  </textarea>
            </td>
          </tr>
          <tr> 
            <td bgcolor=<%=Tabletitlecolor%> valign=middle colspan=2 align=center> 

              <input type=Submit value="����" name=Submit>
              &nbsp; 
              <input type=Submit value="����" name=Submit>
              &nbsp; 
              <input type="button" name="close" value="�ر�" onclick="window.close">
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
<table cellpadding=0 cellspacing=0 border=0 width="<%=tablewidth%>" bgcolor=<%=Tablebackcolor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
                
            <tr>
                <td bgcolor=<%=Tabletitlecolor%> align=center colspan=3><font color="<%=TablefontColor%>"><b>��ӭʹ�ö���Ϣ���գ�<%=membername%></b></font></td>
            </tr>
            <tr>
                <td bgcolor=<%=Tablebodycolor%> valign=middle align=center colspan=3><a href="messanger.asp?action=delete&id=<%=rs("id")%>"><img src="<%=picurl%>m_delete.gif" border=0 alt="ɾ����Ϣ"></a> &nbsp; <a href="messanger.asp?action=new"><img src="<%=picurl%>m_write.gif" border=0 alt="������Ϣ"></a> &nbsp;<a href="messanger.asp?action=new&touser=<%=htmlencode(rs("sender"))%>"><img src="<%=picurl%>m_reply.gif" border=0 alt="�ظ���Ϣ"></a>&nbsp;<a href="messanger.asp?action=fw&id=<%=request("id")%>"><img src=<%=picurl%>m_fw.gif border=0 alt=ת����Ϣ></a></td>
            </tr>
                <tr>
                    <td bgcolor=<%=Tabletitlecolor%>><font color="<%=TablefontColor%>">
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
<%
rs.close
set rs=nothing
	sql="select id,sender from message where incept='"&membername&"' and flag=0 and issend=1 and id>"&cstr(request("id")&" order by sendtime")
	set rs=conn.execute(sql)
	if not (rs.eof and rs.bof) then
%>
                <tr>
                    <td bgcolor=<%=Tablebodycolor%> valign=top align=right><a href=messanger.asp?action=read&id=<%=rs(0)%>&sender=<%=rs(1)%>>[��ȡ��һ����Ϣ]</a>
		    </td>
                </tr>
<%
end if
rs.close
set rs=nothing
%>
                </table></td></tr></table>
<%end if%>
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
<form action="messanger.asp" method=post name=messager>
  <table cellpadding=0 cellspacing=0 border=0 width=<%=tablewidth%> bgcolor=<%=Tablebackcolor%> align=center>
    <tr> 
      <td> 
        <table cellpadding=3 cellspacing=1 border=0 width=100%>
          <tr> 
            <td bgcolor=<%=Tabletitlecolor%> colspan=2 align=center> <font color="<%=TablefontColor%>">
              <input type=hidden name="action" value="send">
              <b>���Ͷ���Ϣ</b>--����������������Ϣ</font></td>
          </tr>
          <tr> 
            <td bgcolor=<%=Tablebodycolor%> valign=middle width=30%><font color="<%=TableContentColor%>"><b>�ռ��ˣ�</b><br>ʹ�ö��ţ�,���ֿ������5λ�û�</font></td>
            <td bgcolor=<%=Tablebodycolor%> valign=middle>
              <input type=text name="touser" value="<%=request("touser")%>" size=20>
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
            </td>
          </tr>
          <tr> 
            <td bgcolor=<%=Tablebodycolor%> valign=top><font color="<%=TableContentColor%>"><b>���⣺</b><br>���޶�50����</font></td>
            <td bgcolor=<%=Tablebodycolor%> valign=middle>
              <input type=text name="title" size=36 maxlength=80 value="Fw��<%=title%>">&nbsp;
            </td>
          </tr>
          <tr> 
            <td bgcolor=<%=Tablebodycolor%> valign=top><font color="<%=TableContentColor%>"><b>���ݣ�</b><br></font></td>
            <td bgcolor=<%=Tablebodycolor%> valign=middle>
              <textarea cols=35 rows=6 name="message" title="Ctrl+Enter����">


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
              <input type="button" name="close" value="�ر�" onclick="window.close">
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</form>
<%
end sub
sub savemsg()
	dim incept,title,message,subtype
	if request("touser")="" then
		errmsg=errmsg+"<br>"+"<li>��������д���Ͷ����˰ɡ�"
		founderr=true
	else
		incept=CheckStr(request("touser"))
		incept=split(incept,",")
	end if
	if request("title")="" then
		errmsg=errmsg+"<br>"+"<li>����û����д����ѽ��"
		founderr=true
	else
		title=CheckStr(request("title"))
	end if
	if request("message")="" then
		errmsg=errmsg+"<br>"+"<li>�����Ǳ���Ҫ��д���ޡ�"
		founderr=true
	else
		message=CheckStr(request("message"))
	end if
	if not founderr then
		for i=0 to ubound(incept)
		set rs=server.createobject("adodb.recordset")
		sql="select username from [user] where username='"&replace(incept(i),"'","")&"'"
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
                elseif request("Submit")="����" then
		sql="insert into message (incept,sender,title,content,sendtime,flag,issend) values ('"&incept(i)&"','"&membername&"','"&title&"','"&message&"',Now(),0,0)"
		subtype="������"
		else
		sql="insert into message (incept,sender,title,content,sendtime,flag,issend) values ('"&incept(i)&"','"&membername&"','"&title&"','"&message&"',Now(),0,1)"
		subtype="�ѷ�����Ϣ"
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

sub success()
%>
    <table cellpadding=0 cellspacing=0 border=0 width=<%=tablewidth%> bgcolor=<%=Tablebackcolor%> align=center>
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

sub newmsg()
%>
    <table cellpadding=0 cellspacing=0 border=0 width=<%=tablewidth%> bgcolor=<%=aTablebackcolor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
    <tr align="center"> 
      <td width="100%" bgcolor=<%=Tabletitlecolor%>><font color="<%=TablefontColor%>">����Ϣ֪ͨ</font></td>
    </tr>
    <tr> 
      <td width="100%" bgcolor=<%=Tablebodycolor%> align=center><br>
<font color="<%=TableContentColor%>"><a href=messanger.asp?action=inbox><img src="<%=picurl%>newmail.gif" border=0>���µĶ���Ϣ</a><br>
                <br>
                <a href=messanger.asp?action=inbox>���˲鿴</a><br><br>
                </font>
      </td>
    </tr>
    <tr align="center"> 
      <td width="100%" bgcolor=<%=Tabletitlecolor%>>  
      </td>
    </tr>  
    </table>   </td></tr></table>
<%
end sub
set rs=nothing
stats="���Ͷ���"
call endline()
%>
<script language="javascript">
function DoTitle(addTitle) { 
var revisedTitle; 
var currentTitle = document.messager.touser.value; 
revisedTitle = currentTitle+addTitle; 
document.messager.touser.value=revisedTitle; 
document.messager.touser.focus(); 
return; }
</script>
<!--#include file="footer.asp"-->