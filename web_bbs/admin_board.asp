<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=chkuser.asp-->
<!--#include file=md5.asp-->
<title><%=ForumName%>--����ҳ��</title>
<!--#include file="Forum_css.asp"-->

<BODY <%=ForumBody%>>
<%
	dim str

	if not master or instr(session("flag"),"01")=0 then
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
        <td><font color="<%=TablefontColor%>">��ӭ<b><%=membername%></b>�����������</font>
        </td>
        </tr>
            <tr bgcolor=<%=tablebodycolor%>>
          <td width="100%" valign=top> <font color="<%=TableContentColor%>">
            <table width="100%" border="0" cellspacing="3" cellpadding="0">
              <tr>
                <td><font color="<%=TableContentColor%>">1��ע����� �����棬��������Ŀǰ���е���̳���ࡣ�����Ա༭��̳��������������һ���µ���̳����������С� Ҳ���Ա༭��ɾ��Ŀǰ���ڵ���̳�������Զ�Ŀǰ�ķ������½������С� 
                   <p><font color=<%=AlertFontColor%>>2.�ر�ע��</font>��ɾ����̳ͬʱ��ɾ������̳���������ӣ�ɾ������ͬʱɾ��������̳���������ӣ� ����ʱ��������д����Ϣ��</font>
                </td>
              </tr>
              <tr>
              <td>
              <p align=cetner><b><a href=admin_board.asp><font color="<%=TableContentColor%>">��̳����</font></a> | <a href="admin_board.asp?action=addclass"><font color="<%=TableContentColor%>">�½���̳����</font></a></p>
              </td>
              <tr>
            </table>
<%
select case Request("action")
case "add"
	call add()
case "edit"
	call edit()
case "savenew"
	call savenew()
case "savedit"
	call savedit()
case "del"
	call del()
case "orders"
	call orders()
case "updatorders"
	call updateorders()
case "addclass"
	call addclass()
case "saveclass"
	call saveclass()
case "del1"
	call del1()
case "mode"
	call mode()
case "savemod"
	call savemod()
case else
	call boardinfo()
end select
end sub

sub add()
%>
 <form action ="admin_board.asp?action=savenew" method=post>
<%
	dim boardnum
	set rs = server.CreateObject ("Adodb.recordset")
	sql="select Max(boardid) from board"
	rs.open sql,conn,1,1
	if rs.eof and rs.bof then
	boardnum=1
	else
	boardnum=rs(0)+1
	end if
	rs.close
%><B>��̳���������������̳������̳���������ҳ�����Ӧ����</B>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr bgcolor=<%=aTableTitlecolor%>> 
<td width="52%" height=24><font color="<%=TableContentColor%>"><b>˵��</b> </td>
<td width="48%"><font color="<%=TableContentColor%>"><b>����</b> </td>
</tr>
<tr> 
<td width="52%" height=24><font color="<%=TableContentColor%>"><B>��̳���</B><BR>ע�ⲻ�ܺͱ����̳�����ͬ</font></td>
<td width="48%"> 
<input type="text" name="newboardid" size="24" value=<%=boardnum+1%>>
</td>
</tr>
<tr> 
<td width="52%" height=24><font color="<%=TableContentColor%>"><B>��̳����</B></font></td>
<td width="48%"> 
<input type="text" name="boardtype" size="24">
</td>
</tr>
<tr> 
<td width="52%" height=24><font color="<%=TableContentColor%>"><B>�������</B></font></td>
<td width="48%"> 
<select name=class>
<%
	sql = "select * from class"
	rs.open sql,conn,1,1
	if rs.eof and rs.bof then
	response.write "<option value=>����������"
	else
	do while not rs.EOF
%>
<option value=<%=rs("id")%>><%=rs("class")%> 
<%
	rs.MoveNext 
	loop
	end if
	rs.Close 
%>
</select>
</td>
</tr>
<tr> 
<td width="52%" height=24><font color="<%=TableContentColor%>"><B>����˵��</B></font></td>
<td width="48%"> 
<input type="text" name="readme" size="24">
</td>
</tr>
<tr> 
<td width="52%" height=24><font color="<%=TableContentColor%>"><B>��̳����</B><BR>������������|�ָ����磺ɳ̲С��|wodeail</font></td>
<td width="48%"> 
<input type="text" name="boardmaster" size="24">
</td>
</tr>
<tr> 
<td width="52%" height=24><font color="<%=TableContentColor%>"><B>�Ƿ�Ϊ��������</B><BR>0��ʾ���ţ�1��ʾ����</font></td>
<td width="48%"> 
<select name="lockboard">
<option value="0" selected>0 
<option value="1">1 
</select>
</td>
</tr>
<tr> 
<td width="52%" height=24><font color="<%=TableContentColor%>"><B>��ҳ��ʾ��̳ͼƬ</B><BR>��������ҳ��̳����������<BR>��ֱ����дͼƬURL</font></td>
<td width="48%"> 
<input type="text" name="indexIMG" size="35" value="">
</td>
</tr>
<tr bgcolor="<%=atabletitlecolor%>"> 
<td width="52%" height=24>&nbsp;</td>
<td width="48%"> 
<input type="submit" name="Submit" value="�����̳">
</td>
</tr>
</table>
</form>
<%
set rs=nothing
end sub

sub edit()
%>
 <form action ="admin_board.asp?action=savedit" method=post>           
<%
dim rs_c
set rs_c= server.CreateObject ("adodb.recordset")
sql = "select * from class"
rs_c.open sql,conn,1,1
set rs= server.CreateObject ("adodb.recordset")
sql = "select * from board where boardid="+CSTr(request("editid"))
rs.open sql,conn,1,1
%>            
<input type='hidden' name=editid value='<%=Request("editid")%>'>
<B>��̳�����޸�����������̳���������ҳ�����Ӧ����</B>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr bgcolor=<%=aTableTitleColor%>> 
<td width="52%" height=24><font color="<%=TableContentColor%>"><b>˵��</b> </font></td>
<td width="48%"> 
<div align="center"><font color="<%=TableContentColor%>"><b>����</b></font></div>
</td>
</tr>
<tr> 
<td width="52%" height=24><font color="<%=TableContentColor%>"><B>��̳���</B><BR>ע�ⲻ�ܺͱ����̳�����ͬ</font></td>
<td width="48%"> 
<input type="text" name="newboardid" size="3"  value = '<%=rs("boardid")%>'>
</td>
</tr>
<tr> 
<td width="52%" height=24><font color="<%=TableContentColor%>"><B>��̳����</B></font></td>
<td width="48%"> 
<input type="text" name="boardtype" size="24"  value = '<%=rs("boardtype")%>'>
</td>
</tr>
<tr> 
<td width="52%" height=24><font color="<%=TableContentColor%>"><B>�������</B></font></td>
<td width="48%"> 
<select name=class>
<% do while not rs_c.EOF%>
<option value=<%=rs_c("id")%> <% if cint(rs("class")) = rs_c("id") then%> selected <%end if%>><%=rs_c("class")%> 
<%
rs_c.MoveNext 
loop
rs_c.Close 
%>
</select>
</td>
</tr>
<tr> 
<td width="52%" height=24><font color="<%=TableContentColor%>"><B>����˵��</B></font></td>
<td width="48%"> 
<input type="text" name="readme" size="24" value='<%=rs("readme")%>'>
</td>
</tr>
<tr> 
<td width="52%" height=24><font color="<%=TableContentColor%>"><B>��̳����</B><BR>������������|�ָ����磺ɳ̲С��|wodeail</font></td>
<td width="48%"> 
<input type="text" name="boardmaster" size="24"  value='<%=rs("boardmaster")%>'>
</td>
</tr>
<tr> 
<td width="52%" height=24><font color="<%=TableContentColor%>"><B>�Ƿ�Ϊ��������</B><BR>0��ʾ���ţ�1��ʾ����</font></td>
<td width="48%"> 
<select name="lockboard">
<option value="0" <%if rs("lockboard")=0 then%>selected<%end if%>>0 
<option value="1" <%if rs("lockboard")=1 then%>selected<%end if%>>1 
</select>
</td>
</tr>
<tr> 
<td width="52%" height=24><font color="<%=TableContentColor%>"><B>��ҳ��ʾ��̳ͼƬ</B><BR>��������ҳ��̳����������<BR>��ֱ����дͼƬURL</font></td>
<td width="48%">
<input type="text" name="indexIMG" size="35" value="<%=rs("indexIMG")%>">
</td>
</tr>
<tr bgcolor=<%=aTableTitleColor%>> 
<td width="52%" height=24>&nbsp;</td>
<td width="48%"> 
<input type="submit" name="Submit" value="�ύ�޸�">
</td>
</tr>
</table>
</form>
<%
rs.close
end sub
sub mode()
dim boarduser
%>
 <form action ="admin_board.asp?action=savemod" method=post>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr bgcolor=<%=aTableTitlecolor%>> 
<td width="52%" height=22><font color="<%=TableContentColor%>"><b>˵����</b> </font></td>
<td width="48%"><font color="<%=TableContentColor%>"><b>������</b> </font></td>
</tr>
<tr> 
<td width="52%" height=22><font color="<%=TableContentColor%>"><B>��̳����</B></td>
<td width="48%"> <font color="<%=TableContentColor%>">
<%
set rs= server.CreateObject ("adodb.recordset")
sql="select boardid,boardtype,boarduser,boardskin from board where boardid="&request("boardid")
rs.open sql,conn,1,1
if rs.eof and rs.bof then
response.write "�ð��沢�����ڡ�"
else
response.write rs(1)
response.write "<input type=hidden value="&rs(0)&" name=boardid>"
boarduser=rs(2)
boardskin=rs(3)
end if
rs.close
set rs=nothing
%></font>
</td>
</tr>
<tr> 
<td width="52%"><font color="<%=TableContentColor%>"><B>��̳����</B>��<br>
������̳�������Ա���������������û������<BR>
������̳�������û��ɷ����������<BR>
</td>
<td width="48%" valign=top> 
<select name="boardskin" size=1>
<option value=1 <%if boardskin=1 then%> selected <%end if%>>������̳</option>
<option value=2 <%if boardskin=2 then%> selected <%end if%>>������̳</option>
</select>
</td>
</tr>
<tr bgcolor="<%=atabletitlecolor%>"> 
<td width="52%" height=22>&nbsp;</td>
<td width="48%"> 
<input type="submit" name="Submit" value="�趨">
</td>
</tr>
</table>
</form>
<%
end sub

sub savemod()
dim boarduser
dim boarduser_1
dim userlen
set rs= server.CreateObject ("adodb.recordset")
sql="select boardskin,boarduser from board where boardid="&request("boardid")
rs.open sql,conn,1,3
rs("boardskin")=request("boardskin")
response.write "<p>��̳���óɹ���<br><br>"
if cint(request("boardskin"))=5 then
	if trim(request("vipuser"))<>"" then
	boarduser=request("vipuser")
	boarduser=split(boarduser,chr(13)&chr(10))
	for i = 0 to ubound(boarduser)
	if not (boarduser(i)="" or boarduser(i)=" ") then
		boarduser_1=""&boarduser_1&""&boarduser(i)&","
	end if
	next
	userlen=len(boarduser_1)
	if boarduser_1<>"" then
		boarduser=left(boarduser_1,userlen-1)
		rs("boarduser")=boarduser
		response.write "<p>����û���"&boarduser&"<br><br>"
	else
		response.write "<p><font color=red>��û�������֤�û�</font><br><br>"
	end if
	end if
end if
rs.update
rs.close
set rs=nothing
end sub

sub boardinfo()
dim rs_1,rs_2
dim sql_1,sql_2
	    set rs_1 = server.CreateObject ("adodb.recordset")
            set rs_2 = server.CreateObject ("adodb.recordset")
            sql_2 = "select * from class order by id"
            rs_2.Open sql_2,conn,1,1
	    do while not rs_2.Eof
%>
            <table width="100%" border="0" cellspacing="3" cellpadding="0">
              <tr bgcolor="<%=aTableTitleColor%>">

                <td height="21"><font color="<%=TableContentColor%>"><B><%=rs_2("id")%>,��������<%=rs_2("class")%></b>    <a href="admin_board.asp?action=add"><font color="<%=TableContentColor%>">������̳</font></a> | <a href=admin_board.asp?action=orders&id=<%=rs_2("id")%>><font color="<%=TableContentColor%>">���������޸�</font></a> | <a href=admin_board.asp?action=del1&id=<%=rs_2("id")%> onclick="{if(confirm('ɾ���������÷�����������̳���������ӣ�ȷ��ɾ����?')){return true;}return false;}"><font color="<%=TableContentColor%>">ɾ������</font></a></font></td>
              </tr>
            </table>
<%
            sql_1 = "select boardid,boardtype,readme from board where class="&rs_2("id")&" order by boardid"
            rs_1.Open sql_1,conn,1,1
            do while not rs_1.EOF 
            %>
            <table width="100%" border="0" cellspacing="3" cellpadding="0">
              <tr> 
                <td height="18"><font color="<%=TableContentColor%>"><%=rs_1("boardid")%>,<%=rs_1("boardtype")%></font></td>
              </tr>
              <tr>
                <td height="15"><a href="admin_board.asp?action=edit&editid=<%=rs_1("boardid")%>"><font color="<%=Boardlinkcolor%>"><U>������Ϣһ</U></font></a> | <a href="admin_var.asp?boardid=<%=rs_1("boardid")%>"><font color="<%=Boardlinkcolor%>"><U>������Ϣ��</U></font></a> | <a href="admin_use.asp?boardid=<%=rs_1("boardid")%>"><font color="<%=Boardlinkcolor%>"><U>ʹ������</U></font></a> | <a href="admin_color.asp?boardid=<%=rs_1("boardid")%>"><font color="<%=Boardlinkcolor%>"><U>��������</U></font></a> | <a href="admin_pic.asp?boardid=<%=rs_1("boardid")%>"><font color="<%=Boardlinkcolor%>"><U>ͼƬ����</U></font></a> | <a href="admin_ads.asp?boardid=<%=rs_1("boardid")%>"><font color="<%=Boardlinkcolor%>"><U>�������</U></font></a> | <a href="admin_board.asp?action=mode&boardid=<%=rs_1("boardid")%>"><font color="<%=Boardlinkcolor%>"><U>��̳ģʽ</U></font></a> | <a href="admin_board.asp?action=del&editid=<%=rs_1("boardid")%>" onclick="{if(confirm('ɾ������������̳�������ӣ�ȷ��ɾ����?')){return true;}return false;}"><font color="<%=Boardlinkcolor%>"><U>ɾ��</U></a></td>
              </tr>
            </table>
<hr color=black height=1 width="70%" align=left>
<%
		  rs_1.MoveNext
		  loop
                  rs_1.Close 
        rs_2.MoveNext 
        Loop
        rs_2.Close
%>
          </td>
            </tr>
        </table>      
        </td>
       </tr>
</table>
<%
set rs_1=nothing
set rs_2=nothing
end sub

sub savenew()
dim Forum_info,Forum_setting,Forum_ubb,Forum_body,Forum_ads,Forum_user
dim Forum_pic,Forum_boardpic,Forum_TopicPic,Forum_statePic,Forum_copyright
	set rs = server.CreateObject ("adodb.recordset")
	if request("boardtype")="" then
		Errmsg=Errmsg+"<br>"+"<li>��������̳���ơ�"
		Founderr=true
	end if
	if request("class")="" then
		Errmsg=Errmsg+"<br>"+"<li>��ѡ����̳���ࡣ"
		Founderr=true
	end if
	if request("boardmaster")="" then
		Errmsg=Errmsg+"<br>"+"<li>���������������"
		Founderr=true
	end if
	if request("readme")="" then
		Errmsg=Errmsg+"<br>"+"<li>��������̳˵����"
		Founderr=true
	end if
	if request("lockboard")="" then
		Errmsg=Errmsg+"<br>"+"<li>��ѡ����̳����״̬��"
		Founderr=true
	end if
	if founderr=true then
	response.write ""&Errmsg&""
	else
		dim boardid
		sql="select boardid from board where boardid="+cstr(request("newboardid"))
		rs.open sql,conn,1,1
		if not rs.eof and not rs.bof then
			response.write "������ָ���ͱ����̳һ������š�"
			exit sub
		else
			boardid=request("newboardid")
		end if
		rs.close
	sql="select * from config where active=1"
	rs.open sql,conn,1,1
	Forum_Info=rs("Forum_Info")
	Forum_Setting=rs("Forum_Setting")
	Forum_ads=rs("Forum_ads")
	Forum_Body=rs("Forum_Body")
	Forum_user=rs("Forum_user")
	Forum_copyright=rs("Forum_copyright")
	Badwords=rs("Badwords")
	Splitwords=rs("Splitwords")
	StopReadme=rs("StopReadme")
	Forum_pic=rs("Forum_pic")
	Forum_boardpic=rs("Forum_boardpic")
	Forum_TopicPic=rs("Forum_TopicPic")
	Forum_statePic=rs("Forum_statePic")
	Forum_upload=rs("Forum_upload")
	Forum_ubb=rs("Forum_ubb")
	rs.close
	sql = "select * from board"
	rs.Open sql,conn,1,3
	rs.AddNew
	rs("boardid") = Request("newboardid")
	rs("boardtype") = Request.Form ("boardtype")
	rs("class") = Request.Form  ("class")
	rs("boardmaster") = Request("boardmaster")
	rs("readme") = Request("readme")
	rs("lockboard") = Trim(Request("lockboard"))
	rs("indexIMG")=request.form("indexIMG")
	rs("lasttopicnum") = 0 
	rs("lastbbsnum") = 0 
	rs("lasttopicnum") = 0 
	rs("todaynum") = 0 
	rs("boardskin")=1
	rs("LastPost")="$$"&Now()&"$$"

	rs("Forum_Info")=Forum_Info
	rs("Forum_Setting")=Forum_Setting
	rs("Forum_ads")=Forum_ads
	rs("Forum_Body")=Forum_Body
	rs("Forum_user")=Forum_user
	rs("Forum_copyright")=Forum_copyright
	rs("Badwords")=Badwords
	rs("Splitwords")=Splitwords
	rs("StopReadme")=StopReadme
	rs("Forum_pic")=Forum_pic
	rs("Forum_boardpic")=Forum_boardpic
	rs("Forum_TopicPic")=Forum_TopicPic
	rs("Forum_statePic")=Forum_statePic
	rs("Forum_upload")=Forum_upload
	rs("Forum_ubb")=Forum_ubb

	rs.Update 
	rs.Close 
	call addmaster(Request("boardmaster"))
	response.write "<p>��̳��ӳɹ���<br><br>"&str
	end if
	set rs=nothing
end sub

sub savedit()
	dim newboardid
	set rs = server.CreateObject ("adodb.recordset")
	if request("newboardid")=request("editid") then
		newboardid=request("newboardid")
	else
		sql="select boardid from board where boardid="+cstr(request("newboardid"))
		rs.open sql,conn,1,1
		if not rs.eof and not rs.bof then
			response.write "������ָ���ͱ����̳һ������š�"
			exit sub
		else
			newboardid=request("newboardid")
		end if
		rs.close
	end if
	sql = "select * from board where boardid="+Cstr(request("editid"))
	rs.Open sql,conn,1,3
	rs("boardid") = Request.Form ("newboardid")
	rs("boardtype") = Request.Form ("boardtype")
	rs("class") = Request.Form  ("class")
	rs("boardmaster") = Request("boardmaster")
	rs("readme") = Request("readme")
	rs("lockboard") = Trim(Request("lockboard"))
	rs("indexIMG")=request.form("indexIMG")
	rs.Update 
	rs.Close
	set rs=nothing
	if request("newboardid")<>request("editid") then
	conn.execute("update bbs1 set boardid="&Request.Form ("newboardid")&" where boardid="+Cstr(request("editid")))
	end if
	call addmaster(Request("boardmaster"))
	response.write "<p>��̳�޸ĳɹ���<br><br>"&str
end sub

sub del()
	set rs = server.CreateObject ("adodb.recordset")
	sql = "delete from board where boardid="+Cstr(Request("editid"))
	conn.execute(sql)
	sql = "delete from bbs1 where boardid="+cstr(Request("editid"))
	conn.execute(sql)
	set rs=nothing
	response.write "<p>��̳�޸ĳɹ���"
end sub

sub del1()
	set rs = server.CreateObject ("adodb.recordset")
	sql = "delete from class where id="+Cstr(Request("id"))
	conn.execute(sql)
	sql = "delete from board where class="+Cstr(Request("id"))
	conn.execute(sql)
	sql="select boardid from board where class="+Cstr(Request("id"))
	rs.open sql,conn,1,1
	do while not rs.eof
	sql_1 = "delete from bbs1 where boardid="+cstr(rs("boardid"))
	conn.execute(sql_1)
	rs.movenext
	loop
	rs.close
	set rs=nothing
	response.write "<p>����ɾ���ɹ���"
end sub

sub orders()
%><br>
            <table width="95%" border="0" cellspacing="3" cellpadding="0" align=center>
              <tr> 
                <td height="22"><font color="<%=TableContentColor%>"><b>��̳�������������޸�</b><br>
ע�⣺������Ӧ��̳������������������Ӧ��������ţ�ע�ⲻ�ܺͱ����̳��������ͬ��������š�</font>
		</td>
              </tr>
	      <tr>
		<td><font color="<%=TableContentColor%>">
<%
	set rs = server.CreateObject ("Adodb.recordset")
	sql="select * from class where id="&cstr(request("id"))
	rs.open sql,conn,1,1
	if rs.eof and rs.bof then
		response.write "û���ҵ���Ӧ����̳���ࡣ"
	else
		response.write "<form action=admin_board.asp?action=updatorders method=post>"
		response.write "<input type=text name=classname size=25 value="&rs("class")&">"
		response.write "  <input type=text name=newid size=2 value="&rs("id")&">"
		response.write "<input type=hidden name=id value="&request("id")&">"
		response.write "<input type=submit name=Submit value=�޸�></form>"
	end if
	rs.close
	set rs=nothing
%>
		</td>
	      </tr>
            </table>
<%
end sub

sub updateorders()
	dim newid
	set rs = server.CreateObject ("Adodb.recordset")
	if request("newid")=request("id") then
		sql="update class set class='"&request("classname")&"' where id="&cstr(request("id"))
		conn.execute(sql)
		response.write "<p align=center>���³ɹ���</p>"
	else
	sql="select * from class where id="&cstr(request("newid"))
	rs.open sql,conn,1,1
	if not rs.eof and not rs.bof then
		response.write "���������ź��������������ͬ�����������롣"
	else
		sql="update class set id="&request("newid")&",class='"&request("classname")&"' where id="&cstr(request("id"))
		conn.execute(sql)
		sql="update board set class="&request("newid")&" where class="&cstr(request("id"))
		conn.execute(sql)
		response.write "<p align=center>���³ɹ���</p>"
	end if
	end if
	set rs=nothing
end sub

sub addclass()
	dim classnum
	set rs = server.CreateObject ("Adodb.recordset")
	sql="select id from class"
	rs.open sql,conn,1,1
	if rs.eof and rs.bof then
	classnum=0
	else
	classnum=rs.recordcount
	end if
	rs.close
%>
            <table width="95%" border="0" cellspacing="3" cellpadding="0" align=center>
              <tr> 
                <td height="22" bgcolor=<%=aTableTitleColor%>><font color="<%=TableContentColor%>"><b>����µ���̳����</b><br>
ע�⣺��������д���±���Ϣ��ע�ⲻ�ܺͱ����̳��������ͬ��������š�</font>
		</td>
              </tr>
<form action=admin_board.asp?action=saveclass method=post>
	      <tr>
		<td><font color="<%=TableContentColor%>">��������<input name=classname type=text size=25>  ��ţ�
<input name=id type=text size=2 value=<%=classnum+1%>>   
<input type=submit name=Submit value=���>
		</td>
	      </tr>
</form>
	    </table>
<%
set rs=nothing
end sub

sub saveclass()
	set rs = server.CreateObject ("Adodb.recordset")
	if request("id")="" or request("classname")="" then
		response.write "���������ź�ԭ������ͬ�����ظ���������"
	else
	sql="select * from class where id="&cstr(request("id"))
	rs.open sql,conn,1,1
	if not rs.eof and not rs.bof then
		response.write "���������ź��������������ͬ�����������롣"
	else
		sql="insert into class(id,class) values("&request("id")&",'"&request("classname")&"')"
		conn.execute(sql)
		response.write "<p align=center>���³ɹ���</p>"
	end if
	end if
	set rs=nothing
end sub

sub delclass()

end sub

sub addmaster(s)
	dim arr,i,rs,sql,pw
	randomize
	pw=Cint(rnd*9000)+1000
	if instr(s,"|")<>0 and instr(s,"|")<len(s) then
		arr=split(s,"|")
		set rs=server.createobject("adodb.recordset")
		for i=0 to Ubound(arr)
			sql="select username,userpassword,userclass from [user] where username='"& arr(i) &"'"
			rs.open sql,conn,1,3
			if rs.eof and rs.bof then
				rs.addnew
				rs("username")=arr(i)
				rs("userpassword")=md5(pw)
				rs("userclass")=19
				rs.update
				str=str&"������������û���<b>" &arr(i) &"</b> ���룺<b>"& pw &"</b><br><br>"
			else
				if rs("userclass")<20 then
				rs("userclass")=19
				rs.update
				end if
			end if
			rs.close
		next
		set rs=nothing
	else
		set rs=server.createobject("adodb.recordset")
		sql="select username,userpassword,userclass from [user] where username='"& s &"'"
		rs.open sql,conn,1,3
		if rs.eof and rs.bof then
			rs.addnew
			rs("username")=s
			rs("userpassword")=md5(pw)
			rs("userclass")=19
			rs.update
			rs.close
			str=str&"������������û���<b>" &s &"</b> ���룺<b>"& pw &"</b><br><br>"
		else
			if rs("userclass")<20 then
			rs("userclass")=19
			rs.update
			end if
		end if
		set rs=nothing
	end if
end sub
%>