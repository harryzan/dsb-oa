<!--#include file =conn.asp-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=chkuser.asp-->
<title><%=ForumName%>--����ҳ��</title>
<!--#include file="Forum_css.asp"-->
<meta NAME=GENERATOR Content=""Microsoft FrontPage 3.0"" CHARSET=GB2312>
<BODY <%=ForumBody%>>
<%
	if not master or instr(session("flag"),"21")=0 then
		Errmsg=Errmsg+"<br>"+"<li>��ҳ��Ϊ����Աר�ã���<a href=admin_index.asp target=_top>��½</a>����롣<br><li>��û�й���ҳ���Ȩ�ޡ�"
		call Error()
	else
		call main()
		conn.close
		set conn=nothing
	end if

	sub main()
%>
<table cellpadding=0 cellspacing=0 border=0 width=<%=tablewidth%> bgcolor=<%=tablebackcolor%> align=center>
  <tr>
    <td>
      <table cellpadding=3 cellspacing=1 border=0 width=100%>
        <tr bgcolor='<%=Tabletitlecolor%>'><font color="<%=TablefontColor%>">
        <td align=center colspan="2">��ӭ<b><%=membername%></b>�������ҳ��</font>
        </td>
        </tr>
            <tr bgcolor=<%=tablebodycolor%>>
              <td width="100%" valign=top><font color="<%=TablefontColor%>">
<%
if request("action")="save" then
call saveconst()
else
call consted()
end if
if founderr then call error()
%></font>
	      </td>
            </tr>
        </table>
        </td>
    </tr>
</table>
<%
end sub

sub consted()
dim sel
%>
<form method="POST" action=admin_var.asp?action=save>
<table width="95%" border="0" cellspacing="1" cellpadding="3"  align=center bordercolor=<%=aTablebackcolor%>>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td height="23" colspan="2" ><font color="<%=TablefontColor%>"><B>˵��</B>��<BR>1����ѡ����ѡ���Ϊ��ǰ��ʹ������ģ�壬����ɲ鿴��ģ�����ã�������ģ��ֱ�Ӳ鿴��ģ�岢�޸����á������Խ�����������ñ����ڶ����̳���ģ����<BR>2����Ҳ���Խ������趨����Ϣ���沢Ӧ�õ�����ķ���̳�����У��ɶ�ѡ<BR>3�����������һ���������ñ�İ����ģ������ã�ֻҪ����ð����ģ�����ƣ������ʱ��ѡ��Ҫ���浽�İ������ƻ�ģ�����Ƽ��ɡ�</font></td>
</tr>
<tr> 
<td width="100%" colspan=2><font color="<%=TablefontColor%>"><B>��ǰʹ����ģ��</B>���ɽ����ñ��浽����ģ���У�<BR>
<%
set rs = server.CreateObject ("adodb.recordset")
sql="select * from config"
rs.open sql,conn,1,1
do while not rs.eof
if request("skinid")="" then
	if request("boardid")="" then
	if rs("active")=1 then
	sel="checked"
	else
	sel=""
	end if
	else
	sel=""
	end if
else
	if rs("id")=cint(request("skinid")) then
	sel="checked"
	else
	sel=""
	end if
end if
response.write "<input type=checkbox name=skinid value="&rs("id")&" "&sel&"><a href=admin_var.asp?skinid="&rs("id")&"><font color="&TablefontColor&">"&rs("skinname")&"</font></a>&nbsp;"
rs.movenext
loop
rs.close
set rs=nothing
%></font>
</td></tr>
<tr> 
<td width="100%" colspan=2><font color="<%=TablefontColor%>"><B>��ǰʹ�÷���̳ģ��</B>���ɽ����ñ��浽������̳�У�<BR>
<%
set rs = server.CreateObject ("adodb.recordset")
sql="select * from board"
rs.open sql,conn,1,1
do while not rs.eof
if request("boardid")<>"" or isnumeric(request("boardid")) then
if rs("boardid")=cint(request("boardid")) then
sel="checked"
else
sel=""
end if
end if
response.write "<input type=checkbox name=boardid value="&rs("boardid")&" "&sel&"><a href=admin_var.asp?boardid="&rs("boardid")&"><font color="&TablefontColor&">" & rs("boardtype") & "</font></a>&nbsp;"
rs.movenext
loop
rs.close
set rs=nothing
%></font>
</td></tr>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td height="23" colspan="2" ><font color="<%=TablefontColor%>"><b>��̳������Ϣ</b></font></td>
</tr>
<tr> 
<td width="40%"><font color="<%=TablefontColor%>"><B>��̳����</B></td>
<td width="60%"> 
<input type="text" name="ForumName" size="35" value="<%=ForumName%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TablefontColor%>"><B>��̳��url</B></td>
<td width="60%"> 
<input type="text" name="ForumURL" size="35" value="<%=ForumURL%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TablefontColor%>"><B>��ҳ����</B></td>
<td width="60%"> 
<input type="text" name="CompanyName" size="35" value="<%=CompanyName%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TablefontColor%>"><B>��ҳURL</B></td>
<td width="60%"> 
<input type="text" name="HostUrl" size="35" value="<%=HostUrl%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TablefontColor%>"><B>SMTP Server��ַ</B><BR>ֻ������̳ʹ�������д��˷����ʼ����ܣ�����д���ݷ���Ч</td>
<td width="60%"> 
<input type="text" name="SMTPServer" size="35" value="<%=SMTPServer%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TablefontColor%>"><B>��̳����ԱEmail</B><BR>���û������ʼ�ʱ����ʾ����ԴEmail��Ϣ</td>
<td width="60%"> 
<input type="text" name="SystemEmail" size="35" value="<%=SystemEmail%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TablefontColor%>"><B>��̳��ҳLogo��ַ</B><BR>��ʾ����̳��ҳ�������̳���û����дlogo��ַ����ʹ�ø�����</td>
<td width="60%"> 
<input type="text" name="Logo" size="35" value="<%=ForumLogo%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TablefontColor%>"><B>��̳ͼƬĿ¼</B></td>
<td width="60%"> 
<input type="text" name="Picurl" size="35" value="<%=picurl%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TablefontColor%>"><B>��̳����Ŀ¼</B></td>
<td width="60%"> 
<input type="text" name="Faceurl" size="35" value="<%=Faceurl%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TablefontColor%>"><B>��̳����ʱ��</B></td>
<td width="60%"> 
<input type="text" name="GMT" size="35" value="<%=GMT%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TablefontColor%>"><B>��Ȩ��Ϣ</B></td>
<td width="60%"> 
<input type="text" name="Copyright" size="35" value="<%=Copyright%>">
</td>
</tr>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td width="40%"><font color="<%=TablefontColor%>">&nbsp;</td>
<td width="60%"> 
<div align="center"> 
<input type="submit" name="Submit" value="�� ��">
</div>
</td>
</tr>
</table>
</form>
<%
end sub

sub saveconst()
dim Forum_info,Forum_copyright
if trim(request("skinid"))="" and trim(request("boardid"))="" then
Founderr=true
Errmsg=Errmsg+"<br>"+"<li>��ѡ�񱣴��ģ������"
else
Forum_info=Request("ForumName") & "," & Request("ForumURL") & "," & Request("CompanyName") & "," & Request("HostUrl") & "," & Request("SMTPServer") & "," & Request("SystemEmail") & "," & Request("Logo") & "," & Request("Picurl") & "," & Request("Faceurl") & "," & Request("GMT")
Forum_copyright=request("copyright")
'response.write Forum_info
if request("skinid")<>"" then
sql = "update config set Forum_info='"&Forum_info&"',Forum_copyright='"&Forum_copyright&"' where id in ( "&request("skinid")&" )"
conn.execute(sql)
end if
if request("boardid")<>"" then
sql = "update board set Forum_info='"&Forum_info&"',Forum_copyright='"&Forum_copyright&"' where boardid in ( "&request("boardid")&" )"
conn.execute(sql)
end if
response.write "���óɹ���"
end if
end sub
%>