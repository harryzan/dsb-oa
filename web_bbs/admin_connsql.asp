<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=chkuser.asp-->
<title><%=ForumName%>--����ҳ��</title>
<!--#include file="Forum_css.asp"-->

<BODY <%=ForumBody%>>
<%
	if not master or instr(session("flag"),"34")=0 then
		Errmsg=Errmsg+"<br>"+"<li>��ҳ��Ϊ����Աר�ã���<a href=admin_index.asp target=_top>��½</a>����롣<br><li>��û�й���ҳ���Ȩ�ޡ�"
		call Error()
	else
		call main()
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
              <td width="100%" valign=top><p>
              <table width="100%" border="0" cellspacing="3" cellpadding="0">
                <tr> 
                  <td bgcolor=<%=atabletitlecolor%>> <font color="<%=TableContentColor%>">
                    <p><b>SOL���ִ�в���</b>�����������޸߼�����SQL��̱Ƚ���Ϥ���û���������ֱ������sqlִ����䣬����delete from bbs1 where username='test'����ɾ��ĳ�û����Ӳ������ڲ���ǰ�����ؿ�������ִ������Ƿ���ȷ��������ִ�к󲻿ɻָ���</font></p></font>
                  </td>
                </tr>
                <tr> 
                  <td>	<font color="<%=TableContentColor%>">
<%
if request("action") = "save" then
dim SQL_Statement
SQL_Statement=Request("SQL_Statement")
if SQL_Statement<>Empty then
On Error Resume Next 
conn.Execute(SQL_Statement)
if err.number="0" then
response.write "ִ�гɹ�"
else
response.write "��������⣬����������£�<br>"
response.write Err.Description
err.clear
end if
end if
else
%>
              <table width="80%" border="0" cellspacing="3" cellpadding="0">
                <tr> 
                  <td width="100%" height="2"><font color="<%=TableContentColor%>">
<Form Name=FormPst Method=Post Action="admin_connsql.asp?action=save">
<FieldSet>
<Legend>������SQL���</Legend>
ָ�<Input type="text" name="SQL_Statement" Size=60> <p>
<Input type="Submit" Value="�ͳ�"> <p>
</FieldSet>
</Form></font>
                  </td>
                </tr>
              </table>
<%end if%></font>
		</td>
            </tr>
        </table>
        </td>
    </tr>
</table>
<%
	end sub
%>