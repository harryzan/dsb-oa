<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=chkuser.asp-->
<title><%=ForumName%>--����ҳ��</title>
<!--#include file="Forum_css.asp"-->

<BODY <%=ForumBody%>>
<%
	dim str
	if not master or instr(session("flag"),"03")=0 then
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
        <tr bgcolor='<%=Tabletitlecolor%>'>
        <td><font color="<%=TablefontColor%>">��ӭ<b><%=membername%></b>�������ҳ��</font>
        </td>
        </tr>
            <tr bgcolor=<%=tablebodycolor%>>
          <td width="100%" valign=top> 
<font color="<%=TableContentColor%>">
            <table width="100%" border="0" cellspacing="3" cellpadding="0">
              <tr>
                <td><font color="<%=TableContentColor%>">1��ע����� �����棬��������Ŀǰ���е���̳�б�������ͬһ�������ڽ��в����������Խ�һ����̳������һ����̳���кϲ����ϲ���������̳��������ת��ϲ���̳�����ϲ���̳����ɾ���Ҳ��ɻָ���</font>
                </td>
              </tr>
            </table>
<%
if Request("action") = "unite" then
	call unite()
else
	call boardinfo()
end if
end sub

sub boardinfo()
%><br>
            <table width="95%" border="0" cellspacing="3" cellpadding="0" align=center>
	      <tr>
		<td><font color="<%=TableContentColor%>">
<%
	set rs = server.CreateObject ("Adodb.recordset")
	sql="select boardid,boardtype from board"
	rs.open sql,conn,1,1
	if rs.eof and rs.bof then
		response.write "û����̳"
	else
		response.write "<form action=admin_boardunite.asp?action=unite method=post>"
		response.write "����̳"
		response.write "<select name=oldboard size=1>"
		do while not rs.eof
		response.write "<option value="&rs("boardid")&">"&rs("boardtype")&"</option>"
		rs.movenext
		loop
		response.write "</select>"
	end if
	rs.close
	sql="select * from board"
	rs.open sql,conn,1,1
	if rs.eof and rs.bof then
		response.write "û����̳"
	else
		response.write "�ϲ���"
		response.write "<select name=newboard size=1>"
		do while not rs.eof
		response.write "<option value="&rs("boardid")&">"&rs("boardtype")&"</option>"
		rs.movenext
		loop
		response.write "</select>"
	end if
	rs.close
	set rs=nothing
	response.write "<input type=submit name=Submit value=ִ��></form>"
%></font>
		</td>
	      </tr>
            </table>
<%
end sub

sub unite()
dim newboard
dim oldboard
%><br>
            <table width="95%" border="0" cellspacing="3" cellpadding="0" align=center>
	      <tr>
		<td><font color="<%=TableContentColor%>">
<%
if cint(request("newboard"))=cint(request("oldboard")) then
response.write "�벻Ҫ����ͬ�����ڽ��в�����"
else
newboard=cint(request("newboard"))
oldboard=cint(request("oldboard"))
'������̳��������
conn.execute("update bbs1 set boardid="&newboard&" where boardid="&oldboard)
'��������̳���Ӽ���
set rs=conn.execute("select lastbbsnum,lasttopicnum,todayNum from board where boardid="&oldboard)
conn.execute("update board set lastbbsnum=lastbbsnum+"&rs(0)&",lasttopicnum=lasttopicnum+"&rs(1)&",todaynum=todaynum+"&rs(2)&" where boardid="&newboard)
'ɾ�����ϲ���̳
conn.execute("delete from board where boardid="&oldboard)
response.write "�ϲ��ɹ����Ѿ������ϲ���̳��������ת�������ϲ���̳��"
end if
%></font>
		</td>
	      </tr>
            </table>
<%
end sub
%>