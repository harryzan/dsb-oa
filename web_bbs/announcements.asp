<!--#include file="conn.asp"-->
<!-- #include file="inc/char.asp" -->
<!-- #include file="inc/const.asp" -->
<!-- #include file="chkuser.asp" -->
<!--#include file="inc/theme.asp"-->
<!--#include file="inc/ubbcode.asp"-->
<%
	dim abgcolor
	stats="�����̳����"
	dim usersign
	usersign=false
	call nav()
	call headline(1)
        BoardID = Request("BoardID")
	if BoardID="" or not isInteger(BoardID) then
		BoardID=0
	else
		BoardID=clng(BoardID)
	end if
	if founderr then
		call error()
	else
		call main()
	end if
	call endline()
%>
<%sub main()%>
	        <table cellpadding=0 cellspacing=0 border=0 width="<%=TableWidth%>" bgcolor="<%=tablebackcolor%>" align=center>
	                <tr>
	                    <td>
	                    <table cellpadding=3 cellspacing=1 border=0 width=100%>
<%
	set rs=server.createobject("adodb.recordset")
	sql="select * from bbsnews where boardid="&BoardID&" order by id desc"
	rs.open sql,conn,1,1
	if rs.eof and rs.bof then
%>
	                        <tr>
	                        <td bgcolor="<%=tabletitlecolor%>" align=center valign=top><font color="<%=TableFontColor%>"><b>>> ��ǰû���κι��� <<</b></font></td></tr>
	                        <tr>
	                            <td bgcolor="<%=tablebodycolor%>" valign=top style="LEFT: 0px; WIDTH: 100%; WORD-WRAP: break-word"><font color="<%=TableContentColor%>"><br>
	                        <p><blockquote>�������̳����ҳ��������һ������(�����ǹ���Ա���߰���)�� <br>���㷢��һ�ι���󣬱�����ͻ��Զ���ʧ���������ֶ�ɾ����
</blockquote></p></font>
	                        </td>
	                        </tr>
	                        <tr>
	                            <td bgcolor="<%=tablebodycolor%>" valign=middle>
	                        <table width=100% border="0" cellpadding="0" cellspacing="0">
	                        <tr><td align=left><font color="<%=TableContentColor%>">&nbsp;&nbsp;&nbsp;<b>������</b>�� ��վ��Ĭ�Ϲ���</font>
	                        </td><td align=right><font color="<%=TableContentColor%>"><b>����ʱ��</b>�� <%=Now()%>&nbsp;&nbsp;&nbsp;</font>
	                        </tr>
	                        </table>
	                        </td>
	                        </tr>
<%
	else
	do while not rs.eof
%>
	                        <tr>
	                        <td bgcolor="<%=tabletitlecolor%>" align=center valign=top><font color="<%=TableFontColor%>"><b>>> <%=htmlencode(rs("title"))%> <<</b></font></td></tr>
	                        <tr>
	                            <td bgcolor="<%=tablebodycolor%>" valign=top style="LEFT: 0px; WIDTH: 100%; WORD-WRAP: break-word"><font color="<%=TableContentColor%>"><br>
	                        <p><blockquote><%=ubbcode(rs("content"))%>
</blockquote></p></font>
	                        </td>
	                        </tr>
	                        <tr>
	                            <td bgcolor="<%=tablebodycolor%>" valign=middle>
	                        <table width=100% border="0" cellpadding="0" cellspacing="0">
	                        <tr><td align=left><font color="<%=TableContentColor%>">&nbsp;&nbsp;&nbsp;<b>������</b>�� <%=htmlencode(rs("username"))%></font>
	                        </td><td align=right><font color="<%=TableContentColor%>"><b>����ʱ��</b>�� <%=rs("addtime")%>&nbsp;&nbsp;&nbsp;</font>
	                        </tr>
	                        </table>
	                        </td>
	                        </tr>
<%
	rs.movenext
	loop
	end if
	rs.close
	set rs=nothing
	
%>
				</table>
			</td></tr></table>
<%end sub%>
<!--#include file="footer.asp"-->
