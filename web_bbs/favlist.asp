<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!-- #include file="chkuser.asp" -->
<!--#include file="inc/theme.asp"-->
<!--#include file="inc/char.asp"-->
<%
	stats="�����ղؼ�"
	call nav()
	call headline(1)
%>
	        <table cellpadding=0 cellspacing=0 border=0 width=<%=TableWidth%> bgcolor="<%=tablebackcolor%>" align=center>
	                <tr>
	                    <td>
	                    <table cellpadding=3 cellspacing=1 border=0 width=100%>
<%
	set rs=server.createobject("adodb.recordset")
	if membername="" then
		Errmsg=Errmsg+"<br>"+"<li>����û��<a href=login.asp>��½��̳</a>�����ܲ鿴�ղء��������û��<a href=reg.asp>ע��</a>������<a href=reg.asp>ע��</a>��"
		Founderr=true
	end if
	if Founderr then
		call error()
	else
		if request("action")="delet" then
			call delete()
		else
			call favlist()
		end if
		if Founderr then call error()
	end if
%>
				</table>
			</td></tr>
</table>
<%
	sub favlist()
	sql="select * from bookmark where username='"&membername&"' order by id desc"
	rs.open sql,conn,1,1
	if rs.eof and rs.bof then
		Errmsg=Errmsg+"<br>"+"<li>�����ղؼл�û���ղأ��������ղ���ָ̳�����ӣ����ղ��������ݺ󣬱���Ϣ���Զ�ɾ����"
		Founderr=true
	else
%>
	                        <tr>
	                        <td bgcolor="<%=tabletitlecolor%>" align=center valign=top colspan="3"><b><font color=<%=TableFontColor%>>>> �����ղؼ� <<</font></b></td></tr>
  <tr bgcolor="<%=tablebodycolor%>">
    <td width="70%"><font color="<%=TableContentColor%>">����</font></td>
    <td width="20%"><font color="<%=TableContentColor%>">ʱ��</font></td>
    <td width="10%"><font color="<%=TableContentColor%>">����</font></td>
  </tr>
<%
	do while not rs.eof
%>
  <tr bgcolor="<%=tablebodycolor%>">
    <td width="70%"><a href="<%=rs("url")%>"><%=htmlencode(rs("topic"))%></a></td>
    <td width="20%"><font color="<%=TableContentColor%>"><%=rs("addtime")%></font></td>
    <td width="10%"><a href="favlist.asp?action=delet&id=<%=rs("id")%>"><img src="pic/a_delete.gif" border=0></a></td>
  </tr>
<%
	rs.movenext
	loop
	end if
	rs.close
	end sub

	sub error()
%>
	                        <tr>
	                        <td bgcolor="<%=tabletitlecolor%>" align=center valign=top><b><font color=<%=TableFontColor%>>> ������Ϣ <<</font></b></td></tr>
	                        <tr>
	                            <td bgcolor="<%=tablebodycolor%>" valign=top style="LEFT: 0px; WIDTH: 100%; WORD-WRAP: break-word"><br><font color="<%=TableContentColor%>">
	                        <p><blockquote><%=errmsg%>
</blockquote></p></font>
	                        </td>
	                        </tr>
<%
	end sub

	sub delete()
	if isInteger(request("id")) then
	sql="delete from bookmark where username='"&membername&"' and id="&cstr(request("id"))
	conn.execute sql
	end if
%>
	                        <tr>
	                        <td bgcolor="<%=tabletitlecolor%>" align=center valign=top><b><font color=<%=TableFontColor%>>> �����ɹ� <<</font></b></td></tr>
	                        <tr>
	                            <td bgcolor="<%=tablebodycolor%>" valign=top style="LEFT: 0px; WIDTH: 100%; WORD-WRAP: break-word"><br><font color="<%=TableContentColor%>">
	                        <p><blockquote>��ɾ�������ղؼ�����Ӧ��¼��<a href="javascript:history.go(-1)">�����ղ�</a>��
</blockquote></p></font>
	                        </td>
	                        </tr>
<%
	end sub
	set rs=nothing	
	call endline()
%>
<!--#include file="footer.asp"-->
