<!--#include file=conn.asp-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=chkuser.asp-->
<title><%=ForumName%>--����ҳ��</title>
<!--#include file="Forum_css.asp"-->

<BODY  <%=ForumBody%>>
<%
	if not master or instr(session("flag"),"28")=0 then
		Errmsg=Errmsg+"<br>"+"<li>��ҳ��Ϊ����Աר�ã���<a href=admin_index.asp target=_top>��½</a>����롣<br><li>��û�й���ҳ���Ȩ�ޡ�"
		call Error()
	else
		call main()
		conn.close
		set conn=nothing
	end if

	sub main()
	dim sel
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
          <td width="100%" valign=top> <font color="<%=TableContentColor%>">
	      <%if request("action") = "savebadword" then%>
	      <%call savebadword()%>
	      <%else%>

<form action="admin_badword.asp?action=savebadword" method=post>
<table width="95%" border="0" cellspacing="1" cellpadding="3"  align=center bordercolor=<%=aTablebackcolor%>>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td height="23" colspan="2" ><font color="<%=TableContentColor%>"><B>˵��</B>��<BR>1����ѡ����ѡ���Ϊ��ǰ��ʹ������ģ�壬����ɲ鿴��ģ�����ã�������ģ��ֱ�Ӳ鿴��ģ�岢�޸����á������Խ�����������ñ����ڶ����̳���ģ����<BR>2����Ҳ���Խ������趨����Ϣ���沢Ӧ�õ�����ķ���̳�����У��ɶ�ѡ<BR>3�����������һ���������ñ�İ����ģ������ã�ֻҪ����ð����ģ�����ƣ������ʱ��ѡ��Ҫ���浽�İ������ƻ�ģ�����Ƽ��ɡ�</font></td>
</tr>
<tr> 
<td width="100%" colspan=2><font color="<%=TableContentColor%>"><B>��ǰʹ����ģ��</B>���ɽ����ñ��浽����ģ���У�<BR>
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
response.write "<input type=checkbox name=skinid value="&rs("id")&" "&sel&"><a href=admin_badword.asp?skinid="&rs("id")&"><font color="&TablecontentColor&">"&rs("skinname")&"</font></a>&nbsp;"
rs.movenext
loop
rs.close
set rs=nothing
%></font>
</td></tr>
<tr> 
<td width="100%" colspan=2><font color="<%=TableContentColor%>"><B>��ǰʹ�÷���̳ģ��</B>���ɽ����ñ��浽������̳�У�<BR>
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
response.write "<input type=checkbox name=boardid value="&rs("boardid")&" "&sel&"><a href=admin_badword.asp?boardid="&rs("boardid")&"><font color="&TablecontentColor&">" & rs("boardtype") & "</font></a>&nbsp;"
rs.movenext
loop
rs.close
set rs=nothing
%></font>
</td></tr>
                <tr> 
                  <td width="100%"><font color="<%=TableContentColor%>"><B>ע�⣺</B>���ӹ����ַ����������������а��������ַ������ݣ�ע������ַ����������û�ע����������ַ�������<BR>���������ַ���<input type="text" name="badwords" value="<%=badwords%>" size="60">&nbsp<BR><BR>������Ҫ���˵��ַ������룬����ж���ַ��������á�|���ָ��������磺�����|�ҿ�|fuck</font></td>
                </tr>
                <tr> 
                  <td width="100%"><font color="<%=TableContentColor%>"><BR>ע������ַ���<input type="text" name="splitwords" value="<%=splitwords%>" size="60">&nbsp;<BR><BR>������Ҫ���˵��ַ������룬����ж���ַ��������á�,���ָ��������磺ɳ̲,quest,ľ��<BR></font></td>
                </tr>
                <tr> 
                  <td width="100%"><input type="submit" name="Submit" value="�ύ"></td>
                </tr>
</table>
</form>
            <p> <br>
            </p> <%end if%></font>
             </td>
            </tr>
       </table>
      </td>
    </tr>  
</table>
<%
end sub

sub savebadword()
if request("skinid")<>"" then
sql = "update config set badwords='"&request("badwords")&"',splitwords='"&request("splitwords")&"' where id in ( "&request("skinid")&" )"
conn.execute(sql)
end if
if request("boardid")<>"" then
sql = "update board set badwords='"&request("badwords")&"',splitwords='"&request("splitwords")&"' where boardid in ( "&request("boardid")&" )"
conn.execute(sql)
end if
response.write "���³ɹ���"
end sub
%>