<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=chkuser.asp-->
<!-- #include file="admin_config.asp" -->
<title><%=ForumName%>--����ҳ��</title>
<!--#include file="Forum_css.asp"-->

<BODY <%=ForumBody%>>
<%
	if not master or instr(session("flag"),"26")=0 then
		Errmsg=Errmsg+"<br>"+"<li>��ҳ��Ϊ����Աר�ã���<a href=admin_index.asp target=_top>��½</a>����롣<br><li>��û�й���ҳ���Ȩ�ޡ�"
		call Error()
	else
		dim body
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
              <td width="100%" valign=top><p><font color="<%=TableContentColor%>">
<%
	select case request("action")
	case "news"
		call step1()
	case "step2"
		call saveskin()
	case "active"
		call active()
	case "delet"
		call delete()
	case "edit"
		call edit()
	case "savedit"
		call savedit()
	case else
		call skininfo()
	end select
%></font>
		</td>
            </tr>
        </table>
        </td>
    </tr>
</table>
<%
	end sub

	sub delete()
	set rs=conn.execute("select skinname from config where active=1 and id="&request("nskinid"))
	if rs.eof and rs.bof then
	conn.execute("delete from config where id="&request("nskinid"))
	response.write "ɾ���ɹ���"
	else
	response.write "������ʾ����ǰʹ�õ���̳ģ�岻��ɾ�����������ø�ģ��Ϊ���ǵ�ǰģ��״̬��"
	end if
	rs.close
	set rs=nothing
	end sub

	sub edit()
	set rs=conn.execute("select skinname from config where id="&request("skinid"))
%>
<form method="POST" action="?action=savedit">
<input type=hidden value="<%=request("skinid")%>" name="skinid">
<table width="95%" border="0" cellspacing="1" cellpadding="3"  align=center bordercolor=<%=aTablebackcolor%>>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td height="23" colspan="2" ><font color="<%=TableContentColor%>"><B>˵��</B>��<BR>����ϸ��д������Ϣ���޸�ģ�������뷵�ص��������ӡ�</font></td>
</tr>
<tr bgcolor=<%=Tabletitlecolor%>> 
<td height="23" colspan="2" ><font color=<%=TableFontcolor%>><b>�޸�ģ������</b></font></td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>ģ������</B></font></td>
<td width="60%"><font color="<%=TableContentColor%>"> 
<input type="text" name="SkinName" size="35" value="<%=rs(0)%>">
</td>
</tr>
<tr bgcolor=<%=Tabletitlecolor%>> 
<td width="40%"><font color="<%=TableContentColor%>">&nbsp;</td>
<td width="60%"><font color="<%=TableContentColor%>"> 
<div align="center"> 
<input type="submit" name="Submit" value="�ύ�޸�">
</div>
</td>
</tr>
</table>
</form>
<%
	rs.close
	set rs=nothing
	end sub

	sub savedit()
	conn.execute("update config set skinname='"&request("skinname")&"' where id="&request("skinid"))
	response.write "�޸ĳɹ���"
	end sub

	sub skininfo()
%>
			  <form method=post action="admin_skin.asp?action=active">
              <table width="95%" border="0" cellspacing="3" cellpadding="0" align=center>
                <tr> 
                  <td colspan=2 bgcolor="<%=aTableTitleColor%>"> <font color="<%=TableContentColor%>">
                    <p><b>��̳ģ��ѡ�����</b>��<br>
                      ע�⣺�ɵ����Ӧģ�����ͳһ�鿴�͹�����������ĳ��ģ��Ϊ��ǰʹ�á�������ص�������Ŀ�ǳ��࣬Ϊ�˲�������������Ե�ǰʹ�õ�ģ���޸ĵ����Ӧ����˵������޸ģ����ģ�����ƽ����޸�ģ������</p><B><a href=admin_skin.asp?action=news>����µ�ģ��</a></B></font>
                  </td>
                </tr>
                <tr bgcolor="<%=TableTitleColor%>"> 
                  <td width="83%" height=22><font color="<%=TablefontColor%>">&nbsp;<B>ģ������</B></font></td><td width="17%"><font color="<%=TablefontColor%>">&nbsp;<B>��ǰ�Ƿ�ʹ��</B></font></td>
                </tr>
<%
	set rs=conn.execute("select id,active,skinname from config order by id desc")
	do while not rs.eof
%>
                <tr> 
                  <td height=25>&nbsp;<a href="admin_skin.asp?action=edit&skinid=<%=rs("id")%>"><%=rs(2)%></a>��<a href="admin_var.asp?skinid=<%=rs("id")%>"><font color="<%=Boardlinkcolor%>"><U>������Ϣ</U></font></a> | <a href="admin_use.asp?skinid=<%=rs("id")%>"><font color="<%=Boardlinkcolor%>"><U>ʹ������</U></font></a> | <a href="admin_color.asp?skinid=<%=rs("id")%>"><font color="<%=Boardlinkcolor%>"><U>��������</U></font></a> | <a href="admin_pic.asp?skinid=<%=rs("id")%>"><font color="<%=Boardlinkcolor%>"><U>ͼƬ����</U></font></a> | <a href="admin_ads.asp?skinid=<%=rs("id")%>"><font color="<%=Boardlinkcolor%>"><U>�������</U></font></a> | <a href="admin_skin.asp?action=delet&nskinid=<%=rs("id")%>" onclick="{if(confirm('ɾ���󲻿ɻָ���ȷ��ɾ����?')){return true;}return false;}"><font color="<%=Boardlinkcolor%>"><U>ɾ��</U></font></a>��</td>
				  <td>&nbsp;<input type=radio name=skinid value="<%=rs(0)%>" <%if rs(1)=1 then%>checked<%end if%>></td>
                </tr>
<%
	rs.movenext
	loop
	rs.close
	set rs=nothing
%>
                <tr bgcolor="<%=TableTitleColor%>"> 
                  <td width="80%" height=22 align=right><font color="<%=TablefontColor%>">&nbsp;��ǰ��̳Ĭ��ʹ��ģ��ֻ��ѡ��һ��&nbsp;</font></td><td width="50%"><font color="<%=TableContentColor%>"><input type=submit value="�� ��" name=submit></td>
                </tr>
	       </table>
		   </form>
<%
	end sub

	sub step1()
%>
<form method="POST" action=?action=step2>
<table width="95%" border="0" cellspacing="1" cellpadding="3"  align=center bordercolor=<%=aTablebackcolor%>>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td height="23" colspan="2" ><font color="<%=TableContentColor%>"><B>˵��</B>��<BR>����ϸ��д������Ϣ��ֻ����д�����в������Ϣ����ģ����ܱ��浽��̳ģ���б��С�</font></td>
</tr>
<tr bgcolor=<%=Tabletitlecolor%>> 
<td height="23" colspan="2" ><font color=<%=TableFontcolor%>><b>��̳������Ϣ</b>(��ģ��������Ϣ�ڱ���������ɺ��ڹ���ҳ�����޸�)</font></td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>ģ������</B></td>
<td width="60%"><font color="<%=TableContentColor%>"> 
<input type="text" name="SkinName" size="35">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>��̳����</B></td>
<td width="60%"><font color="<%=TableContentColor%>"> 
<input type="text" name="ForumName" size="35" value="<%=ForumName%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>��̳��url</B></td>
<td width="60%"><font color="<%=TableContentColor%>"> 
<input type="text" name="ForumURL" size="35" value="<%=ForumURL%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>��ҳ����</B></td>
<td width="60%"><font color="<%=TableContentColor%>"> 
<input type="text" name="CompanyName" size="35" value="<%=CompanyName%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>��ҳURL</B></td>
<td width="60%"><font color="<%=TableContentColor%>"> 
<input type="text" name="HostUrl" size="35" value="<%=HostUrl%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>SMTP Server��ַ</B><BR>ֻ������̳ʹ�������д��˷����ʼ����ܣ�����д���ݷ���Ч</td>
<td width="60%"><font color="<%=TableContentColor%>"> 
<input type="text" name="SMTPServer" size="35" value="<%=SMTPServer%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>��̳����ԱEmail</B><BR>���û������ʼ�ʱ����ʾ����ԴEmail��Ϣ</td>
<td width="60%"><font color="<%=TableContentColor%>"> 
<input type="text" name="SystemEmail" size="35" value="<%=SystemEmail%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>��̳��ҳLogo��ַ</B><BR>��ʾ����̳��ҳ�������̳���û����дlogo��ַ����ʹ�ø�����</td>
<td width="60%"><font color="<%=TableContentColor%>"> 
<input type="text" name="Logo" size="35" value="<%=ForumLogo%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>��̳ͼƬĿ¼</B></td>
<td width="60%"><font color="<%=TableContentColor%>"> 
<input type="text" name="Picurl" size="35" value="<%=picurl%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>��̳����Ŀ¼</B></td>
<td width="60%"><font color="<%=TableContentColor%>"> 
<input type="text" name="Faceurl" size="35" value="<%=Faceurl%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>��̳����ʱ��</B></td>
<td width="60%"><font color="<%=TableContentColor%>"> 
<input type="text" name="GMT" size="35" value="<%=GMT%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>��Ȩ��Ϣ</B></td>
<td width="60%"><font color="<%=TableContentColor%>"> 
<input type="text" name="Copyright" size="35" value="<%=Copyright%>">
</td>
</tr>
<tr bgcolor=<%=Tabletitlecolor%>> 
<td width="40%"><font color="<%=TableContentColor%>">&nbsp;</td>
<td width="60%"><font color="<%=TableContentColor%>"> 
<div align="center"> 
<input type="submit" name="Submit" value="��һ��">
</div>
</td>
</tr>
</table>
</form>
<%
	end sub

	sub saveskin()
dim ars
dim Forum_info
dim Forum_copyright
dim skinname
Forum_info=Request("ForumName") & "," & Request("ForumURL") & "," & Request("CompanyName") & "," & Request("HostUrl") & "," & Request("SMTPServer") & "," & Request("SystemEmail") & "," & Request("Logo") & "," & Request("Picurl") & "," & Request("Faceurl") & "," & Request("GMT")
Forum_copyright=request("copyright")
skinName=request("skinname")

set Ars=conn.execute("select * from config where active=1")

set rs = server.CreateObject ("adodb.recordset")
sql="select * from config"
rs.open sql,conn,1,3
rs.addnew
rs("Forum_body")=ars("Forum_body")
rs("Forum_info")=Forum_info
rs("Forum_copyright")=Forum_copyright
rs("skinname")=skinname
rs("Forum_Setting")=ars("Forum_Setting")
rs("StopReadme")=ars("StopReadme")
rs("Forum_upload")=ars("Forum_upload")
rs("Forum_ubb")=ars("Forum_ubb")
rs("Forum_statepic")=ars("Forum_statepic")
rs("Forum_topicpic")=ars("Forum_topicpic")
rs("Forum_boardpic")=ars("Forum_boardpic")
rs("Forum_pic")=ars("Forum_pic")
rs("Forum_ads")=ars("Forum_ads")
rs("Forum_user")=ars("Forum_user")
rs("badwords")=badwords
rs("splitwords")=splitwords
rs("birthuser")=ars("birthuser")
rs("Maxonline")=ars("Maxonline")
rs("MaxonlineDate")=ars("MaxonlineDate")
rs("LastPost")="$$"&Now()&"$$"
rs("active")=0
rs.update
rs.close
set rs=nothing
response.write "ģ����ӳɹ���"
	end sub

	sub active()
	set rs=conn.execute("select * from config where active=1")
	conn.execute("update config set active=0 where active=1")
	conn.execute("update config set active=1,Maxonline="&rs("Maxonline")&",MaxonlineDate='"&rs("MaxonlineDate")&"',TopicNum="&rs("TopicNum")&",BbsNum="&rs("BbsNum")&",TodayNum="&rs("TodayNum")&",UserNum="&rs("UserNum")&",lastUser='"&rs("lastUser")&"' where id="&request("skinid"))
	response.write "���³ɹ���<a href=admin_skin.asp>����</a>��"
	rs.close
	set rs=nothing
	end sub
%>