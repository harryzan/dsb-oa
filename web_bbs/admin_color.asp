<!--#include file =conn.asp-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=chkuser.asp-->
<title><%=ForumName%>--����ҳ��</title>
<!--#include file="Forum_css.asp"-->
<meta NAME=GENERATOR Content=""Microsoft FrontPage 3.0"" CHARSET=GB2312>
<BODY <%=ForumBody%>>
<%
	if not master or instr(session("flag"),"23")=0 then
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
        <td align=center colspan="2"><font color="<%=TablefontColor%>">��ӭ<b><%=membername%></b>�������ҳ��</font>
        </td>
        </tr>
            <tr  bgcolor="<%=Tablebodycolor%>">
              <td width="100%" valign=top><font color="<%=TableContentColor%>">
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
<form method="POST" action=admin_color.asp?action=save>
<table width="95%" border="0" cellspacing="1" cellpadding="3"  align=center bordercolor=<%=aTablebackcolor%>>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td height="23" colspan="3" ><font color="<%=TableContentColor%>"><B>˵��</B>��<BR>1����ѡ����ѡ���Ϊ��ǰ��ʹ������ģ�壬����ɲ鿴��ģ�����ã�������ģ��ֱ�Ӳ鿴��ģ�岢�޸����á������Խ�����������ñ����ڶ����̳���ģ����<BR>2����Ҳ���Խ������趨����Ϣ���沢Ӧ�õ�����ķ���̳�����У��ɶ�ѡ<BR>3�����������һ���������ñ�İ����ģ������ã�ֻҪ����ð����ģ�����ƣ������ʱ��ѡ��Ҫ���浽�İ������ƻ�ģ�����Ƽ��ɡ�</font></td>
</tr>
<tr> 
<td width="100%" colspan=3 bgcolor="<%=Tablebodycolor%>"><font color="<%=TableContentColor%>"><B>��ǰʹ����ģ��</B>���ɽ����ñ��浽����ģ���У�<BR>
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
response.write "<input type=checkbox name=skinid value="&rs("id")&" "&sel&"><a href=admin_color.asp?skinid="&rs("id")&"><font color="&TableContentColor&">"&rs("skinname")&"</font></a>&nbsp;"
rs.movenext
loop
rs.close
set rs=nothing
%></font>
</td></tr>
<tr> 
<td width="100%" colspan=3 bgcolor="<%=Tablebodycolor%>"><font color="<%=TableContentColor%>"><B>��ǰʹ�÷���̳ģ��</B>���ɽ����ñ��浽������̳�У�<BR>
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
response.write "<input type=checkbox name=boardid value="&rs("boardid")&" "&sel&"><a href=admin_color.asp?boardid="&rs("boardid")&"><font color="&TableContentColor&">" & rs("boardtype") & "</font></a>&nbsp;"
rs.movenext
loop
rs.close
set rs=nothing
%></font>
</td></tr>
<script>
function color(para_URL){var URL =new String(para_URL)
window.open(URL,'','width=300,height=220,noscrollbars')}
</SCRIPT>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td height="23" colspan="3" ><font color="<%=TableContentColor%>"><b>��̳��������</b></font>&nbsp;���� <a href="javascript:color('color.asp')"><font color="<%=TableContentColor%>">����</font></a> ʹ��������ɫʰȡ��</td>
</tr>
<tr bgcolor="<%=Tablebodycolor%>"> 
<td width="45%"><font color="<%=TableContentColor%>"><B>��̳BODY��ǩ</B><br>
����������̳���ı�����ɫ���߱���ͼƬ��</font></td>
<td width="5%"></td>
<td width="50%"> 
<input type="text" name="ForumBody" size="35" value="<%=ForumBody%>">
</td>
</tr>
<tr bgcolor="<%=Tablebodycolor%>"> 
<td width="45%"><font color="<%=TableContentColor%>"><B>������߿���ɫ</B></font></td>
<td width="5%" bgcolor="<%=IEbarcolor%>"></td>
<td width="50%"> 
<input type="text" name="iebarcolor" size="35" value="<%=iebarcolor%>">
</td>
</tr>
<tr bgcolor="<%=Tablebodycolor%>"> 
<td width="45%"><font color="<%=TableContentColor%>"><B>�����˵���񱳾�(���)</B></font></td>
<td width="5%" bgcolor="<%=NavDarkcolor%>"></td>
<td width="50%"> 
<input type="text" name="NavDarkcolor" size="35" value="<%=NavDarkcolor%>">
</td>
</tr>
<tr bgcolor="<%=Tablebodycolor%>"> 
<td width="45%"><font color="<%=TableContentColor%>"><B>�����˵���񱳾�(ǳ����)</B></font></td>
<td width="5%" bgcolor="<%=Navlighcolor%>"></td>
<td width="50%"> 
<input type="text" name="Navlighcolor" size="35" value="<%=Navlighcolor%>">
</td>
</tr>
<tr bgcolor="<%=Tablebodycolor%>"> 
<td width="45%"><font color="<%=TableContentColor%>"><B>���߿���ɫһ</B><br>
һ��ҳ��</font></td>
<td width="5%" bgcolor="<%=Tablebackcolor%>"></td>
<td width="50%"> 
<input type="text" name="Tablebackcolor" size="35" value="<%=Tablebackcolor%>">
</td>
</tr>
<tr bgcolor="<%=Tablebodycolor%>"> 
<td width="45%"><font color="<%=TableContentColor%>"><B>���߿���ɫ��</B><br>
�û�ҳ�桢��ʾҳ��</font></td>
<td width="5%" bgcolor="<%=aTablebackcolor%>"></td>
<td width="50%"> 
<input type="text" name="aTablebackcolor" size="35" value="<%=aTablebackcolor%>">
</td>
</tr>
<tr bgcolor="<%=Tablebodycolor%>"> 
<td width="45%"><font color="<%=TableContentColor%>"><B>��������ɫһ�������</B><br>
һ��ҳ��</font></td>
<td width="5%" bgcolor="<%=Tabletitlecolor%>"></td>
<td width="50%"> 
<input type="text" name="Tabletitlecolor" size="35" value="<%=Tabletitlecolor%>">
</td>
</tr>
<tr bgcolor="<%=Tablebodycolor%>"> 
<td width="45%"><font color="<%=TableContentColor%>"><B>��������ɫ����ǳ������</B><br>
�û�ҳ�桢��ʾҳ��</font></td>
<td width="5%" bgcolor="<%=aTabletitlecolor%>"></td>
<td width="50%"> 
<input type="text" name="aTabletitlecolor" size="35" value="<%=aTabletitlecolor%>">
</td>
</tr>
<tr bgcolor="<%=Tablebodycolor%>"> 
<td width="45%"><font color="<%=TableContentColor%>"><B>�������ɫһ</B></font></td>
<td width="5%" bgcolor="<%=Tablebodycolor%>"></td>
<td width="50%"> 
<input type="text" name="Tablebodycolor" size="35" value="<%=Tablebodycolor%>">
</td>
</tr>
<tr bgcolor="<%=Tablebodycolor%>"> 
<td width="45%"><font color="<%=TableContentColor%>"><B>�������ɫ��</B>(1��2��ɫ����ҳ��ʾ�д���)</font></td>
<td width="5%" bgcolor="<%=aTablebodycolor%>"></td>
<td width="50%"> 
<input type="text" name="aTablebodycolor" size="35" value="<%=aTablebodycolor%>">
</td>
</tr>
<tr bgcolor="<%=Tablebodycolor%>"> 
<td width="45%"><font color="<%=TableContentColor%>"><B>��������������ɫ</B></font></td>
<td width="5%" bgcolor="<%=TableFontcolor%>"></td>
<td width="50%"> 
<input type="text" name="TableFontcolor" size="35" value="<%=TableFontcolor%>">
</td>
</tr>
<tr bgcolor="<%=Tablebodycolor%>"> 
<td width="45%"><font color="<%=TableContentColor%>"><B>���������������ɫ</B></font></td>
<td width="5%" bgcolor="<%=TableContentcolor%>"></td>
<td width="50%"> 
<input type="text" name="TableContentcolor" size="35" value="<%=TableContentcolor%>">
</td>
</tr>
<tr bgcolor="<%=Tablebodycolor%>"> 
<td width="45%"><font color="<%=TableContentColor%>"><B>��������������ɫ</B></font></td>
<td width="5%" bgcolor="<%=AlertFontColor%>"></td>
<td width="50%"> 
<input type="text" name="AlertFontColor" size="35" value="<%=AlertFontColor%>">
</td>
</tr>
<tr bgcolor="<%=Tablebodycolor%>"> 
<td width="45%"><font color="<%=TableContentColor%>"><B>��ʾ���ӵ�ʱ��������ӣ�ת�����ӣ��ظ��ȵ���ɫ</B></font></td>
<td width="5%" bgcolor="<%=ContentTitle%>"></td>
<td width="50%"> 
<input type="text" name="ContentTitle" size="35" value="<%=ContentTitle%>">
</td>
</tr>
<tr bgcolor="<%=Tablebodycolor%>"> 
<td width="45%"><font color="<%=TableContentColor%>"><B>��ҳ������ɫ������⣩</B></font></td>
<td width="5%" bgcolor="<%=BodyFontColor%>"></td>
<td width="50%"> 
<input type="text" name="BodyFontColor" size="35" value="<%=BodyFontColor%>">
</td>
</tr>
<tr bgcolor="<%=Tablebodycolor%>"> 
<td width="45%"><font color="<%=TableContentColor%>"><B>��ҳ������ɫ</B><BR>���������</font></td>
<td width="5%" bgcolor="<%=BoardLinkColor%>"></td>
<td width="50%"> 
<input type="text" name="BoardLinkColor" size="35" value="<%=BoardLinkColor%>">
</td>
</tr>
<tr bgcolor="<%=Tablebodycolor%>"> 
<td width="45%"><font color="<%=TableContentColor%>"><B>�����</B></font></td>
<td width="5%"></td>
<td width="50%"> 
<input type="text" name="tablewidth" size="35" value="<%=tablewidth%>">
</td>
</tr>
<tr bgcolor="<%=Tablebodycolor%>"> 
<td width="45%"><font color="<%=TableContentColor%>"><B>һ���û�����������ɫ</B></font></td>
<td width="5%" bgcolor="<%=user_fc%>"></td>
<td width="50%"> 
<input type="text" name="user_fc" size="35" value="<%=user_fc%>">
</td>
</tr>
<tr bgcolor="<%=Tablebodycolor%>"> 
<td width="45%"><font color="<%=TableContentColor%>"><B>һ���û������ϵĹ�����ɫ</B></font></td>
<td width="5%" bgcolor="<%=user_mc%>"></td>
<td width="50%"> 
<input type="text" name="user_mc" size="35" value="<%=user_mc%>">
</td>
</tr>
<tr bgcolor="<%=Tablebodycolor%>"> 
<td width="45%"><font color="<%=TableContentColor%>"><B>��������������ɫ</B></font></td>
<td width="5%" bgcolor="<%=bmaster_fc%>"></td>
<td width="50%"> 
<input type="text" name="bmaster_fc" size="35" value="<%=bmaster_fc%>">
</td>
</tr>
<tr bgcolor="<%=Tablebodycolor%>"> 
<td width="45%"><font color="<%=TableContentColor%>"><B>���������ϵĹ�����ɫ</B></font></td>
<td width="5%" bgcolor="<%=bmaster_mc%>"></td>
<td width="50%"> 
<input type="text" name="bmaster_mc" size="35" value="<%=bmaster_mc%>">
</td>
</tr>
<tr bgcolor="<%=Tablebodycolor%>"> 
<td width="45%"><font color="<%=TableContentColor%>"><B>����Ա����������ɫ</B></font></td>
<td width="5%" bgcolor="<%=master_fc%>"></td>
<td width="50%"> 
<input type="text" name="master_fc" size="35" value="<%=master_fc%>">
</td>
</tr>
<tr bgcolor="<%=Tablebodycolor%>"> 
<td width="45%"><font color="<%=TableContentColor%>"><B>���������ϵĹ�����ɫ</B></font></td>
<td width="5%" bgcolor="<%=master_mc%>"></td>
<td width="50%"> 
<input type="text" name="master_mc" size="35" value="<%=master_mc%>">
</td>
</tr>
<tr bgcolor="<%=Tablebodycolor%>"> 
<td width="45%"><font color="<%=TableContentColor%>"><B>�������������ɫ</B></font></td>
<td width="5%" bgcolor="<%=vip_fc%>"></td>
<td width="50%"> 
<input type="text" name="vip_fc" size="35" value="<%=vip_fc%>">
</td>
</tr>
<tr bgcolor="<%=Tablebodycolor%>"> 
<td width="45%"><font color="<%=TableContentColor%>"><B>��������ϵĹ�����ɫ</B></font></td>
<td width="5%" bgcolor="<%=vip_mc%>"></td>
<td width="50%"> 
<input type="text" name="vip_mc" size="35" value="<%=vip_mc%>">
</td>
</tr>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td width="45%">&nbsp;</td>
<td width="5%"></td>
<td width="50%"> 
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
dim Forum_body
if trim(request("skinid"))="" and trim(request("boardid"))="" then
Founderr=true
Errmsg=Errmsg+"<br>"+"<li>��ѡ�񱣴��ģ������"
else
Forum_body=request.form("Tablebackcolor") & "," & request.form("aTablebackcolor") & "," & request.form("Tabletitlecolor") & "," & request.form("aTabletitlecolor") & "," & request.form("Tablebodycolor") & "," & request.form("aTablebodycolor") & "," & request.form("TableFontcolor") & "," & request.form("TableContentcolor") & "," & request.form("AlertFontColor") & "," & request.form("ContentTitle") & "," & request.form("AlertFontColor") & "," & request.form("ForumBody") & "," & request.form("TableWidth") & "," & request.form("BodyFontColor") & "," & request.form("BoardLinkColor") & "," & request.form("user_fc") & "," & request.form("user_mc") & "," & request.form("bmaster_fc") & "," & request.form("bmaster_mc") & "," & request.form("master_fc") & "," & request.form("master_mc") & "," & request.form("vip_fc") & "," & request.form("vip_mc") & "," & request.form("NavLighColor") & "," & request.form("NavDarkColor") & "," & request.form("IEbarColor")
'response.write Forum_body
if request("skinid")<>"" then
sql = "update config set Forum_body='"&Forum_body&"' where id in ( "&request("skinid")&" )"
conn.execute(sql)
end if
if request("boardid")<>"" then
sql = "update board set Forum_body='"&Forum_body&"' where boardid in ( "&request("boardid")&" )"
conn.execute(sql)
end if
response.write "���óɹ���"
end if
end sub
%>