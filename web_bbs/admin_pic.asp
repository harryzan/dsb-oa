<!--#include file =conn.asp-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=chkuser.asp-->
<title><%=ForumName%>--����ҳ��</title>
<!--#include file="Forum_css.asp"-->
<meta NAME=GENERATOR Content=""Microsoft FrontPage 3.0"" CHARSET=GB2312>
<BODY <%=ForumBody%>>
<%
	if not master or instr(session("flag"),"24")=0 then
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
            <tr bgcolor=<%=tablebodycolor%>>
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
<form method="POST" action=admin_pic.asp?action=save>
  <table width="95%" border="0" cellspacing="1" cellpadding="3"  align=center bordercolor=<%=aTablebackcolor%>>
    <tr bgcolor=<%=aTabletitlecolor%>> 
      <td height="23" colspan="2" ><font color="<%=TableContentColor%>"><B>˵��</B>��<BR>
        1����ѡ����ѡ���Ϊ��ǰ��ʹ������ģ�壬����ɲ鿴��ģ�����ã�������ģ��ֱ�Ӳ鿴��ģ�岢�޸����á������Խ�����������ñ����ڶ����̳���ģ����<BR>
        2����Ҳ���Խ������趨����Ϣ���沢Ӧ�õ�����ķ���̳�����У��ɶ�ѡ<BR>
        3�����������һ���������ñ�İ����ģ������ã�ֻҪ����ð����ģ�����ƣ������ʱ��ѡ��Ҫ���浽�İ������ƻ�ģ�����Ƽ��ɡ�<br>
        4������ͼƬ����������̳picĿ¼�У���Ҫ����Ҳ�뽫ͼ���ڸ�Ŀ¼</font></td>
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
response.write "<input type=checkbox name=skinid value="&rs("id")&" "&sel&"><a href=admin_pic.asp?skinid="&rs("id")&"><font color="&TableContentColor&">"&rs("skinname")&"</font></a>&nbsp;"
rs.movenext
loop
rs.close
set rs=nothing
%>
        </font> </td>
    </tr>
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
response.write "<input type=checkbox name=boardid value="&rs("boardid")&" "&sel&"><a href=admin_pic.asp?boardid="&rs("boardid")&"><font color="&TableContentColor&">" & rs("boardtype") & "</font></a>&nbsp;"
rs.movenext
loop
rs.close
set rs=nothing
%>
        </font> </td>
    </tr>
    <tr bgcolor=<%=aTabletitlecolor%>> 
      <td height="23" colspan="2" ><font color="<%=TableContentColor%>"><b>����ͼƬ����</b></font></td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>��̳����Ա</B></font></td>
      <td width="60%"> <input type="text" name="pic_om" size="20" value="<%=pic_om%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=pic_om%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>��̳����</B></font></td>
      <td width="60%"> <input type="text" name="pic_ob" size="20" value="<%=pic_ob%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=pic_ob%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>��ͨ��Ա</B></font></td>
      <td width="60%"> <input type="text" name="pic_ou" size="20" value="<%=pic_ou%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=pic_ou%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>���˻������Ա</B></font></td>
      <td width="60%"> <input type="text" name="pic_oh" size="20" value="<%=pic_oh%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=pic_oh%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>ͻ����ʾ�Լ�����ɫ</B></font></td>
      <td width="60%"> <input type="text" name="online_mc" size="20" value="<%=online_mc%>"> 
        &nbsp;&nbsp;<font color=<%=online_mc%>>�Լ�</font> </td>
    </tr>
    <tr bgcolor=<%=aTabletitlecolor%>> 
      <td height="23" colspan="2" ><font color=<%=TableFontcolor%>><b>��̳ͼ��</b></font></td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>������̳������������</B></font></td>
      <td width="60%"> <input type="text" name="F_mode1_n" size="20" value="<%=F_mode1_n%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=F_mode1_n%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>������̳������������</B></font></td>
      <td width="60%"> <input type="text" name="F_mode1_o" size="20" value="<%=F_mode1_o%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=F_mode1_o%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>������̳������������</B></font></td>
      <td width="60%"> <input type="text" name="F_mode2_n" size="20" value="<%=F_mode2_n%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=F_mode2_n%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>������̳������������</B></font></td>
      <td width="60%"> <input type="text" name="F_mode2_o" size="20" value="<%=F_mode2_o%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=F_mode2_o%>> </td>
    </tr>
    <tr bgcolor=<%=aTabletitlecolor%>> 
      <td height="23" colspan="2" ><font color=<%=TableFontcolor%>><b>��̳����ͼ��</b></font></td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>��������</B></font></td>
      <td width="60%"> <input type="text" name="P_post" size="20" value="<%=P_post%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_post%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>�ظ�����</B></font></td>
      <td width="60%"> <input type="text" name="P_reply" size="20" value="<%=P_reply%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_reply%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>����</B></font></td>
      <td width="60%"> <input type="text" name="P_help" size="20" value="<%=P_help%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_help%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>������ҳ</B></font></td>
      <td width="60%"> <input type="text" name="P_gohome" size="20" value="<%=P_gohome%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_gohome%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>�����ϼ�Ŀ¼</B></font></td>
      <td width="60%"> <input type="text" name="P_folder" size="20" value="<%=P_folder%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_folder%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>��ǰĿ¼</B></font></td>
      <td width="60%"> <input type="text" name="P_ofolder" size="20" value="<%=P_ofolder%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_ofolder%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>�µĶ���Ϣ</B></font></td>
      <td width="60%"> <input type="text" name="P_newmsg" size="20" value="<%=P_newmsg%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_newmsg%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>�ҷ��������</B></font></td>
      <td width="60%"> <input type="text" name="P_mytopic" size="20" value="<%=P_mytopic%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_mytopic%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>�����������ģʽ</B></font></td>
      <td width="60%"> <input type="text" name="P_treeview" size="20" value="<%=P_treeview%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_treeview%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>ƽ�����������ģʽ</B></font></td>
      <td width="60%"> <input type="text" name="P_flatview" size="20" value="<%=P_flatview%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_flatview%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>��һƪ����</B></font></td>
      <td width="60%"> <input type="text" name="P_nexttopic" size="20" value="<%=P_nexttopic%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_nexttopic%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>��һƪ����</B></font></td>
      <td width="60%"> <input type="text" name="P_backTopic" size="20" value="<%=P_backTopic%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_backTopic%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>ˢ�����</B></font></td>
      <td width="60%"> <input type="text" name="P_reflash" size="20" value="<%=P_reflash%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_reflash%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>��̳����</B></font></td>
      <td width="60%"> <input type="text" name="P_call" size="20" value="<%=P_call%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_call%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>�򿪵�����</B></font></td>
      <td width="60%"> <input type="text" name="P_opentopic" size="20" value="<%=P_opentopic%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_opentopic%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>�鿴���µ�����</B></font></td>
      <td width="60%"> <input type="text" name="P_newTopic" size="20" value="<%=P_newTopic%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_newTopic%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>�鿴�û��б�</B></font></td>
      <td width="60%"> <input type="text" name="P_userlist" size="20" value="<%=P_userlist%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_userlist%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>�鿴��������</B></font></td>
      <td width="60%"> <input type="text" name="P_Top20" size="20" value="<%=P_Top20%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_Top20%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>��ǰʱ��</B></font></td>
      <td width="60%"> <input type="text" name="P_nowTime" size="20" value="<%=P_nowTime%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_nowTime%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>�����û������״̬����</B></font></td>
      <td width="60%"> <input type="text" name="P_online_s" size="20" value="<%=P_online_s%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_online_s%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>�û���Ϣ�����״̬����</B></font></td>
      <td width="60%"> <input type="text" name="P_userfrom" size="20" value="<%=P_userfrom%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_userfrom%>> </td>
    </tr>
    <tr bgcolor=<%=aTabletitlecolor%>> 
      <td height="23" colspan="2" ><font color=<%=TableFontcolor%>><b>��̳����ͼ��</b></font></td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>���汾��������</B></font></td>
      <td width="60%"> <input type="text" name="P_report" size="20" value="<%=P_report%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_report%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>�ѱ�������IE�ղ�</B></font></td>
      <td width="60%"> <input type="text" name="P_iefav" size="20" value="<%=P_iefav%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_iefav%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>���Ͷ��Ÿ�����</B></font></td>
      <td width="60%"> <input type="text" name="P_sms" size="20" value="<%=P_sms%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_sms%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>����û���Ϣ</B></font></td>
      <td width="60%"> <input type="text" name="P_userinfo" size="20" value="<%=P_userinfo%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_userinfo%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>�����û���������</B></font></td>
      <td width="60%"> <input type="text" name="P_search" size="20" value="<%=P_search%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_search%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>�û���ϵ��ַ</B></font></td>
      <td width="60%"> <input type="text" name="P_homepage" size="20" value="<%=P_homepage%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_homepage%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>�༭����</B></font></td>
      <td width="60%"> <input type="text" name="P_edit" size="20" value="<%=P_edit%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_edit%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>ɾ������</B></font></td>
      <td width="60%"> <input type="text" name="P_delete" size="20" value="<%=P_delete%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_delete%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>��������</B></font></td>
      <td width="60%"> <input type="text" name="P_copy" size="20" value="<%=P_copy%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_copy%>> </td>
    </tr>

    <tr bgcolor=<%=aTabletitlecolor%>> 
      <td><font color="<%=TableContentColor%>">&nbsp;</td>
      <td width="60%"> <div align="center"> 
          <input type="submit" name="Submit" value="�� ��">
        </div></td>
    </tr>
  </table>
</form>
<%
end sub

sub saveconst()
dim Forum_pic
if trim(request("skinid"))="" and trim(request("boardid"))="" then
Founderr=true
Errmsg=Errmsg+"<br>"+"<li>��ѡ�񱣴��ģ������"
else
Forum_pic=request("pic_om") & "," & request("pic_ob") & "," & request("pic_ov") & "," & request("pic_ou") & "," & request("pic_oh") & "," & request("online_mc") & "," & request("F_mode1_o") & "," & request("F_mode1_n") & "," & request("F_mode2_o") & "," & request("F_mode2_n") & "," & request("F_mode3_o") & "," & request("F_mode3_n") & "," & request("F_mode4_n") & "," & request("F_mode4_n") & "," & request("F_mode5_o") & "," & request("F_mode5_n") & "," & request("F_mode6_o") & "," & request("F_mode6_n") & ",ifolder.gif,foldernew.gif"

dim Forum_boardpic
Forum_boardpic=request("F_link") & "," & request("P_post") & "," & request("P_vote") & "," & request("P_paper") & "," & request("P_reply") & "," & request("P_help") & "," & request("P_gohome") & "," & request("P_folder") & "," & request("P_ofolder") & "," & request("P_newmsg") & "," & request("P_mytopic") & "," & request("P_treeview") & "," & request("P_flatview") & "," & request("P_nexttopic") & "," & request("P_backTopic") & "," & request("P_reflash") & "," & request("P_call")

dim Forum_topicPic
Forum_TopicPic=request("P_save") & "," & request("P_report") & "," & request("P_print") & "," & request("P_EmailPost") & "," & request("P_bbsfav") & "," & request("P_EmailPage") & "," & request("P_iefav") & "," & request("P_sms") & "," & request("P_search") & "," & request("P_userinfo") & "," & request("P_Email") & "," & request("P_oicq") & "," & request("P_icq") & "," & request("P_msn") & "," & request("P_homepage") & "," & request("P_quote") & "," & request("P_edit") & "," & request("P_delete") & "," & request("P_copy") & "," & request("P_isbest") & "," & request("P_ip") & "," & request("P_friend")

dim Forum_statePic
Forum_statePic=request("P_opentopic") & "," & request("P_hotTopic") & "," & request("P_closeTopic") & "," & request("P_istop") & "," & request("P_Tisbest") & "," & request("P_newTopic") & "," & request("P_userlist") & "," & request("P_Top20") & "," & request("P_nowTime") & "," & request("P_online_s") & "," & request("P_birth") & "," & request("P_userfrom") & "," & request("P_isvote")

dim Forum_ubb
Forum_ubb=request("bold") & "," & request("italicize") & "," & request("underline") & "," & request("center") & "," & request("url1") & "," & request("email1") & "," & request("image") & "," & request("swf") & "," & request("Shockwave") & "," & request("rm") & "," & request("mp") & "," & request("qt") & "," & request("quote1") & "," & request("fly") & "," & request("move") & "," & request("glow") & "," & request("shadow")
'response.write Forum_Topicpic & "<br>" & Forum_boardpic & "<br>" & Forum_statePic
if request("skinid")<>"" then
sql = "update config set Forum_pic='"&Forum_pic&"',Forum_boardpic='"&Forum_boardpic&"',Forum_TopicPic='"&Forum_TopicPic&"',Forum_statePic='"&Forum_statePic&"',Forum_ubb='"&Forum_ubb&"' where id in ( "&request("skinid")&" )"
conn.execute(sql)
end if
if request("boardid")<>"" then
sql = "update board set Forum_pic='"&Forum_pic&"',Forum_boardpic='"&Forum_boardpic&"',Forum_TopicPic='"&Forum_TopicPic&"',Forum_statePic='"&Forum_statePic&"' where boardid in ( "&request("boardid")&" )"
conn.execute(sql)
end if
response.write "���óɹ���"
end if
end sub
%>