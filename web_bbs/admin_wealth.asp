<!--#include file=conn.asp-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=inc/grade.asp-->
<!--#include file=chkuser.asp-->
<title><%=ForumName%>--����ҳ��</title>
<!--#include file="Forum_css.asp"-->

<BODY <%=ForumBody%>>
<%
	if not master or instr(session("flag"),"13")=0 then
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
              <td width="100%" valign=top><font color="<%=TablefontColor%>">
<%
if request("action")="save" then
call savegrade()
else
call grade()
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

sub grade()
dim sel
%>
<form method="POST" action=admin_wealth.asp?action=save>
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
response.write "<input type=checkbox name=skinid value="&rs("id")&" "&sel&"><a href=admin_wealth.asp?skinid="&rs("id")&"><font color="&TablecontentColor&">"&rs("skinname")&"</font></a>&nbsp;"
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
response.write "<input type=checkbox name=boardid value="&rs("boardid")&" "&sel&"><a href=admin_wealth.asp?boardid="&rs("boardid")&"><font color="&TablecontentColor&">" & rs("boardtype") & "</font></a>&nbsp;"
rs.movenext
loop
rs.close
set rs=nothing
%></font>
</td></tr>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td height="23" colspan="2" ><font color="<%=TableContentColor%>"><b>�û���Ǯ�趨</b></font></td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>">ע���Ǯ��</td>
<td width="60%"> 
<input type="text" name="wealthReg" size="35" value="<%=wealthReg%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>">��½���ӽ�Ǯ</td>
<td width="60%"> 
<input type="text" name="wealthLogin" size="35" value="<%=wealthLogin%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>">�������ӽ�Ǯ</td>
<td width="60%"> 
<input type="text" name="wealthAnnounce" size="35" value="<%=wealthAnnounce%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>">�������ӽ�Ǯ</td>
<td width="60%"> 
<input type="text" name="wealthReannounce" size="35" value="<%=wealthReannounce%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>">�������ӽ�Ǯ</td>
<td width="60%"> 
<input type="text" name="BestWealth" size="35" value="<%=BestWealth%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>">ɾ�����ٽ�Ǯ</td>
<td width="60%"> 
<input type="text" name="wealthDel" size="35" value="<%=wealthDel%>">
</td>
</tr>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td height="23" colspan="2" ><font color=<%=TableFontcolor%>><b>�û������趨</b></font></td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>">ע�ᾭ��ֵ</td>
<td width="60%"> 
<input type="text" name="epReg" size="35" value="<%=epReg%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>">��½���Ӿ���ֵ</td>
<td width="60%"> 
<input type="text" name="epLogin" size="35" value="<%=epLogin%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>">�������Ӿ���ֵ</td>
<td width="60%"> 
<input type="text" name="epAnnounce" size="35" value="<%=epAnnounce%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>">�������Ӿ���ֵ</td>
<td width="60%"> 
<input type="text" name="epReannounce" size="35" value="<%=epReannounce%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>">�������Ӿ���ֵ</td>
<td width="60%"> 
<input type="text" name="bestuserep" size="35" value="<%=bestuserep%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>">ɾ�����پ���ֵ</td>
<td width="60%"> 
<input type="text" name="epDel" size="35" value="<%=epDel%>">
</td>
</tr>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td height="23" colspan="2" ><font color=<%=TableFontcolor%>><b>�û������趨</b></font></td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>">ע������ֵ</td>
<td width="60%"> 
<input type="text" name="cpReg" size="35" value="<%=cpReg%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>">��½��������ֵ</td>
<td width="60%"> 
<input type="text" name="cpLogin" size="35" value="<%=cpLogin%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>">������������ֵ</td>
<td width="60%"> 
<input type="text" name="cpAnnounce" size="35" value="<%=cpAnnounce%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>">������������ֵ</td>
<td width="60%"> 
<input type="text" name="cpReannounce" size="35" value="<%=cpReannounce%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>">������������ֵ</td>
<td width="60%"> 
<input type="text" name="bestusercp" size="35" value="<%=bestusercp%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>">ɾ����������ֵ</td>
<td width="60%"> 
<input type="text" name="cpDel" size="35" value="<%=cpDel%>">
</td>
</tr>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td width="40%"><font color="<%=TableContentColor%>">&nbsp;</td>
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

sub savegrade()
dim forum_user
if trim(request("skinid"))="" and trim(request("boardid"))="" then
Founderr=true
Errmsg=Errmsg+"<br>"+"<li>��ѡ�񱣴��ģ������"
else
Forum_user=request.form("wealthReg") & "," & request.form("wealthAnnounce") & "," & request.form("wealthReannounce") & "," & request.form("wealthDel") & "," & request.form("wealthLogin") & "," & request.form("epReg") & "," & request.form("epAnnounce") & "," & request.form("epReannounce") & "," & request.form("epDel") & "," & request.form("epLogin") & "," & request.form("cpReg") & "," & request.form("cpAnnounce") & "," & request.form("cpReannounce") & "," & request.form("cpDel") & "," & request.form("cpLogin") & "," & request.form("BestWealth") & "," & request.form("BestuserCP") & "," & request.form("BestuserEP")
'response.write Forum_user
if request("skinid")<>"" then
sql = "update config set Forum_user='"&Forum_user&"' where id in ( "&request("skinid")&" )"
conn.execute(sql)
end if
if request("boardid")<>"" then
sql = "update board set Forum_user='"&Forum_user&"' where boardid in ( "&request("boardid")&" )"
conn.execute(sql)
end if
response.write "���óɹ���"
end if
end sub
%>