<!--#include file =conn.asp-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=chkuser.asp-->
<title><%=ForumName%>--����ҳ��</title>
<!--#include file="Forum_css.asp"-->
<meta NAME=GENERATOR Content=""Microsoft FrontPage 3.0"" CHARSET=GB2312>
<BODY  <%=ForumBody%>>
<%
	if not master or instr(session("flag"),"25")=0 then
		Errmsg=Errmsg+"<br>"+"<li>��ҳ��Ϊ����Աר�ã���<a href=admin_index.asp target=_top>��½</a>����롣<br><li>��û�й���ҳ���Ȩ�ޡ�"
		call Error()
	else
		call main()
		conn.close
		set conn=nothing
	end if

	sub main()
%>
<table cellpadding=0 cellspacing=0 border=0 width=<%=Tablewidth%> bgcolor=<%=tablebackcolor%> align=center>
  <tr>
    <td>
      <table cellpadding=3 cellspacing=1 border=0 width=100%>
        <tr bgcolor='<%=Tabletitlecolor%>'>
        <td align=center colspan="2"><font color="<%=tablefontcolor%>">��ӭ<b><%=membername%></b>�������ҳ��</font>
        </td>
        </tr>
            <tr bgcolor="<%=tablebodycolor%>">
              <td width="100%" valign=top><font color=<%=TableContentColor%>>
<%
if request("action")="save" then
call saveconst()
else
call consted()
end if
if founderr then call error()
%>
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
<form method="POST" action=admin_ads.asp?action=save>
<table width="95%" border="0" cellspacing="1" cellpadding="3"  align=center bordercolor=<%=aTablebackcolor%>>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td height="23" colspan="2" ><font color=<%=TableContentColor%>><B>˵��</B>��<BR>1����ѡ����ѡ���Ϊ��ǰ��ʹ������ģ�壬����ɲ鿴��ģ�����ã�������ģ��ֱ�Ӳ鿴��ģ�岢�޸����á������Խ�����������ñ����ڶ����̳���ģ����<BR>2����Ҳ���Խ������趨����Ϣ���沢Ӧ�õ�����ķ���̳�����У��ɶ�ѡ<BR>3�����������һ���������ñ�İ����ģ������ã�ֻҪ����ð����ģ�����ƣ������ʱ��ѡ��Ҫ���浽�İ������ƻ�ģ�����Ƽ��ɡ�</font></td>
</tr>
<tr> 
<td width="100%" colspan=2><font color=<%=TableContentColor%>><B>��ǰʹ����ģ��</B>���ɽ����ñ��浽����ģ���У�<BR>
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
response.write "<input type=checkbox name=skinid value="&rs("id")&" "&sel&"><a href=admin_ads.asp?skinid="&rs("id")&"><font color="&TableContentColor&">"&rs("skinname")&"</font></a>&nbsp;"
rs.movenext
loop
rs.close
set rs=nothing
%></font>
</td></tr>
<tr> 
<td width="100%" colspan=2><font color=<%=TableContentColor%>><B>��ǰʹ�÷���̳ģ��</B>���ɽ����ñ��浽������̳�У�<BR>
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
response.write "<input type=checkbox name=boardid value="&rs("boardid")&" "&sel&"><a href=admin_ads.asp?boardid="&rs("boardid")&"><font color="&TableContentColor&">" & rs("boardtype") & "</font></a>&nbsp;"
rs.movenext
loop
rs.close
set rs=nothing
%></font>
</td></tr>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td height="23" colspan="2" ><font color=<%=TableContentColor%>><b>��̳�������</b>����Ϊ���÷���̳�����Ƿ���̳��ҳ��棬����ҳ��Ϊ������ʾҳ�棩</font></td>
</tr>
<tr> 
<td width="40%"><font color=<%=TableContentColor%>><B>��ҳ����������</B></font></td>
<td width="60%"> <font color=<%=TableContentColor%>>
<textarea name="index_ad_t" cols="50" rows="3"><%=index_ad_t%></textarea>
</td>
</tr>
<tr> 
<td width="40%"><font color=<%=TableContentColor%>><B>��ҳβ��������</B></font></td>
<td width="60%"> <font color=<%=TableContentColor%>>
<textarea name="index_ad_f" cols="50" rows="3"><%=index_ad_f%></textarea>
</td>
</tr>
<tr> 
<td width="40%"><font color=<%=TableContentColor%>><B>������ҳ�������</B></font></td>
<td width="60%"> <font color=<%=TableContentColor%>>
<input type=radio name="index_moveFlag" value=0 <%if index_moveFlag=0 then%>checked<%end if%>>�ر�&nbsp;
<input type=radio name="index_moveFlag" value=1 <%if index_moveFlag=1 then%>checked<%end if%>>��&nbsp;
</td>
</tr>
<tr> 
<td width="40%"><font color=<%=TableContentColor%>><B>��̳��ҳ�������ͼƬ��ַ</B></font></td>
<td width="60%"> <font color=<%=TableContentColor%>>
<input type="text" name="MovePic" size="35" value="<%=MovePic%>">
</td>
</tr>
<tr> 
<td width="40%"><font color=<%=TableContentColor%>><B>��̳��ҳ����������ӵ�ַ</B></font></td>
<td width="60%"> <font color=<%=TableContentColor%>>
<input type="text" name="MoveUrl" size="35" value="<%=MoveUrl%>">
</td>
</tr>
<tr> 
<td width="40%"><font color=<%=TableContentColor%>><B>��̳��ҳ�������ͼƬ���</B></font></td>
<td width="60%"> <font color=<%=TableContentColor%>>
<input type="text" name="move_w" size="3" value="<%=move_w%>">&nbsp;����
</td>
</tr>
<tr> 
<td width="40%"><font color=<%=TableContentColor%>><B>��̳��ҳ�������ͼƬ�߶�</B></font></td>
<td width="60%"> <font color=<%=TableContentColor%>>
<input type="text" name="move_h" size="3" value="<%=move_h%>">&nbsp;����
</td>
</tr>
<input type=hidden name="Board_moveFlag" value=0>
<tr> 
<td width="40%"><font color=<%=TableContentColor%>><B>������ҳ���¹̶����</B></font></td>
<td width="60%"> <font color=<%=TableContentColor%>>
<input type=radio name="index_fixupFlag" value=0 <%if index_fixupFlag=0 then%>checked<%end if%>>�ر�&nbsp;
<input type=radio name="index_fixupFlag" value=1 <%if index_fixupFlag=1 then%>checked<%end if%>>��&nbsp;
</td>
</tr>
<tr> 
<td width="40%"><font color=<%=TableContentColor%>><B>��̳��ҳ���¹̶����ͼƬ��ַ</B></font></td>
<td width="60%"> <font color=<%=TableContentColor%>>
<input type="text" name="fixupPic" size="35" value="<%=fixupPic%>">
</td>
</tr>
<tr> 
<td width="40%"><font color=<%=TableContentColor%>><B>��̳��ҳ���¹̶�������ӵ�ַ</B></font></td>
<td width="60%"> <font color=<%=TableContentColor%>>
<input type="text" name="fixupUrl" size="35" value="<%=fixupUrl%>">
</td>
</tr>
<tr> 
<td width="40%"><font color=<%=TableContentColor%>><B>��̳��ҳ���¹̶����ͼƬ���</B></font></td>
<td width="60%"> <font color=<%=TableContentColor%>>
<input type="text" name="fixup_w" size="3" value="<%=fixup_w%>">&nbsp;����
</td>
</tr>
<tr> 
<td width="40%"><font color=<%=TableContentColor%>><B>��̳��ҳ���¹̶����ͼƬ�߶�</B></font></td>
<td width="60%"> <font color=<%=TableContentColor%>>
<input type="text" name="fixup_h" size="3" value="<%=fixup_h%>">&nbsp;����
</td>
</tr>
<input type=hidden name="Board_fixupFlag" value=0>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td width="40%"><font color=<%=TableContentColor%>>&nbsp;</td>
<td width="60%"> <font color=<%=TableContentColor%>>
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
dim Forum_ads
if trim(request("skinid"))="" and trim(request("boardid"))="" then
Founderr=true
Errmsg=Errmsg+"<br>"+"<li>��ѡ�񱣴��ģ������"
else
Forum_ads=request("index_ad_t") & "$" & request("index_ad_f") & "$" & request("index_moveFlag") & "$" & request("MovePic") & "$" & request("MoveUrl") & "$" & request("move_w") & "$" & request("move_h") & "$" & request("Board_moveFlag") & "$" & request("fixupPic") & "$" & request("FixupUrl") & "$" & request("Fixup_w") & "$" & request("Fixup_h") & "$" & request("Board_fixupFlag") & "$" & request("index_fixupFlag")
'response.write Forum_ads
if request("skinid")<>"" then
sql = "update config set Forum_ads='"&CheckStr(Forum_ads)&"' where id in ( "&request("skinid")&" )"
conn.execute(sql)
end if
if request("boardid")<>"" then
sql = "update board set Forum_ads='"&CheckStr(Forum_ads)&"' where boardid in ( "&request("boardid")&" )"
conn.execute(sql)
end if
response.write "���óɹ���"
end if
end sub
%>