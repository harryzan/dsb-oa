<!--#include file =conn.asp-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=chkuser.asp-->
<title><%=ForumName%>--����ҳ��</title>
<!--#include file="Forum_css.asp"-->
<meta NAME=GENERATOR Content=""Microsoft FrontPage 3.0"" CHARSET=GB2312>
<script language="JavaScript">
<!--
function CheckAll(form)  {
  for (var i=0;i<form.elements.length;i++)    {
    var e = form.elements[i];
    if (e.name != 'chkall')       e.checked = form.chkall.checked; 
   }
  }
//-->
</script>
<BODY <%=ForumBody%>>
<%
	if not master or instr(session("flag"),"22")=0 then
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
<form method="POST" action=admin_use.asp?action=save>
<table width="95%" border="0" cellspacing="1" cellpadding="3"  align=center bordercolor=<%=aTablebackcolor%> style="font-size:9pt;line-height: 13pt">
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
response.write "<input type=checkbox name=skinid value="&rs("id")&" "&sel&"><a href=admin_use.asp?skinid="&rs("id")&"><font color="&TableContentColor&">"&rs("skinname")&"</font></a>&nbsp;"
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
response.write "<input type=checkbox name=boardid value="&rs("boardid")&" "&sel&"><a href=admin_use.asp?boardid="&rs("boardid")&"><font color="&TableContentColor&">" & rs("boardtype") & "</font></a>&nbsp;"
rs.movenext
loop
rs.close
set rs=nothing
%></font>
</td></tr>
<%
if boardid>0 then
call admin_board()
call admin_config()
else
call admin_config()
call admin_board()
end if
%>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td width="50%"><font color="<%=TableContentColor%>">&nbsp;</td>
<td width="50%"><font color="<%=TableContentColor%>"> 
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
dim Forum_Setting
if trim(request("skinid"))="" and trim(request("boardid"))="" then
Founderr=true
Errmsg=Errmsg+"<br>"+"<li>��ѡ�񱣴��ģ������"
else
Forum_Setting=request.Form("TimeAdjust") & "," & request.Form("ScriptTimeOut") & "," & request.Form("EmailFlag") & "," & request.Form("Uploadpic") & "," & request.Form("IpFlag") & "," & request.Form("FromFlag") & "," & request.Form("TitleFlag") & "," & request.Form("uploadFlag") & "," & request.Form("kicktime") & "," & request.Form("guestlogin") & "," & request.Form("openmsg") & "," & request.Form("MaxAnnouncePerPage") & "," & request.Form("Maxtitlelist") & "," & request.Form("AnnounceMaxBytes") & "," & request.Form("online_u") & "," & request.Form("online_g") & "," & request.Form("LinkFlag") & "," & request.Form("TopicFlag") & "," & request.Form("VoteFlag") & "," & request.Form("ReflashFlag") & "," & request.Form("ReflashTime") & "," & request.Form("ForumStop") & "," & request.Form("RegTime") & "," & request.Form("EmailReg") & "," & request.Form("EmailRegOne") & "," & request.Form("RegFlag") & "," & request.Form("online_n") & "," & request.Form("ViewUser_g") & "," & request.Form("ViewUser_u") & "," & request.Form("BirthFlag") & "," & request.Form("runtime") & "," & request.Form("FastLogin") & "," & request.Form("GroupFlag") & "," & request.Form("uploadsize") & "," & request.Form("strAllowForumCode") & "," & request.Form("strAllowHTML") & "," & request.Form("strIMGInPosts") & "," & request.Form("strIcons") & "," & request.Form("strflash") & "," & request.Form("vote_num") & "," & request.Form("facenum") & "," & request.Form("imgnum") & "," & request.Form("relaypost") & "," & request.Form("relayposttime") & "," & request.Form("facename") & "," & request.Form("imgname") & "," & request.Form("smsflag") & "," & request.Form("SendRegEmail") & "," & request.Form("Search_G") & "," & request.Form("bmflag_1") & "," & request.Form("bmflag_2") & "," & request.Form("bmflag_3") & "," & request.Form("bmflag_4") & "," & request.Form("bmflag_5") & "," & request.Form("RegFaceNum") & "," & request.Form("viewcolor") & "," & request.Form("SmallPaper") & "," & request.Form("SmallPaper_g") & "," & request.Form("SmallPaper_m")
Forum_Setting=Forum_Setting & "," & request.Form("FontSize") & "," & request.Form("FontHeight") & "," & request.Form("BbsUserInfo") & "," & request.Form("DvbbsSkin") & "," & request.Form("SkinFontNum") & "," & request.Form("UpLoadPath") & "," & request.Form("UserubbCode") & "," & request.Form("UserHtmlCode") & "," & request.Form("UserImgCode") & "," & request.Form("TopUserNum") & "," & request.Form("PostRetrun") & "," & request.Form("UserPostAdmin") & "," & request.Form("bbsEven") & "," & request.Form("bbsEvenView")
if request("skinid")<>"" then
sql="update config set Forum_Setting='"&Forum_Setting&"',StopReadme='"&request.Form("StopReadme")&"',Forum_upload='"&request.Form("Forum_upload")&"' where id in ( "&request("skinid")&" )"
conn.execute(sql)
end if
if request("boardid")<>"" then
sql="update board set Forum_Setting='"&Forum_Setting&"',StopReadme='"&request.Form("StopReadme")&"',Forum_upload='"&request.Form("Forum_upload")&"' where boardid in ( "&request("boardid")&" )"
conn.execute(sql)
end if
response.write "���óɹ���"
end if
end sub

sub admin_config()
%>
<tr bgcolor=<%=Tabletitlecolor%>> 
<td height="23" colspan="2" ><font color="<%=TableContentColor%>"><a name="config"><b>��̳��ʹ������</b>
</a>(���������<a href="#board"><font color=red>���÷���̳</font></a>���������ݿɺ���)</font></td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>��̳��ǰ״̬</U><BR>ά���ڼ�����ùر���̳ʹ��</td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<input type=radio name="ForumStop" value=0 <%if cint(ForumStop)=0 then%>checked<%end if%>>��&nbsp;
<input type=radio name="ForumStop" value=1 <%if cint(ForumStop)=1 then%>checked<%end if%>>�ر�&nbsp;
</td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>ά��˵��</U><BR>����̳�ر��������ʾ��֧��html�﷨</td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<textarea name="StopReadme" cols="40" rows="3"><%=StopReadme%></textarea>
</td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>������ʱ��</U></td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<select name="TimeAdjust">
<%for i=-23 to 23%>
<option value="<%=i%>" <%if cint(i)=cint(TimeAdjust) then%>selected<%end if%>><%=i%>
<%next%>
</select>
</td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>�ű���ʱʱ��</U><BR>Ĭ��Ϊ300��һ�㲻������</td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<input type="text" name="ScriptTimeOut" size="3" value="<%=ScriptTimeOut%>">&nbsp;��
</td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>һ��Emailֻ��ע��һ���ʺ�</U></td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<input type=radio name="EmailRegOne" value=0 <%if cint(EmailRegOne)=0 then%>checked<%end if%>>�ر�&nbsp;
<input type=radio name="EmailRegOne" value=1 <%if cint(EmailRegOne)=1 then%>checked<%end if%>>��&nbsp;
</td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>�������Ż�ӭ��ע���û�</U></td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<input type=radio name="smsflag" value=0 <%if cint(smsflag)=0 then%>checked<%end if%>>�ر�&nbsp;
<input type=radio name="smsflag" value=1 <%if cint(smsflag)=1 then%>checked<%end if%>>��&nbsp;
</td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>�����Ƿ�����鿴��Ա����</U></td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<input type=radio name="ViewUser_g" value=0 <%if cint(ViewUser_g)=0 then%>checked<%end if%>>��&nbsp;
<input type=radio name="ViewUser_g" value=1 <%if cint(ViewUser_g)=1 then%>checked<%end if%>>��&nbsp;
</td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>�û��Ƿ�����鿴��Ա����</U></td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<input type=radio name="ViewUser_u" value=0 <%if cint(ViewUser_u)=0 then%>checked<%end if%>>��&nbsp;
<input type=radio name="ViewUser_u" value=1 <%if cint(ViewUser_u)=1 then%>checked<%end if%>>��&nbsp;
</td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>���ٵ�½λ��</U></td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<select name="FastLogin">
<option value="1" <%if cint(FastLogin)=1 then%>selected<%end if%>>����
<option value="2" <%if cint(FastLogin)=2 then%>selected<%end if%>>�ײ�
<option value="0" <%if cint(FastLogin)="0" then%>selected<%end if%>>����ʾ
</select>
</td>
</tr>
<!--tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>ע��ͷ�����</U><BR>Ĭ��Ϊ60����Ҫ�����µ�ͷ��ͼƬ�����ʵ�����������<BR>����Ŀ¼Ϊ<%=picurl%>�����ӵ�ͷ��������image+���ֵ�������ʽ<BR>��image61.gif�����滻ԭͷ��ͼƬҲ����������������ʽ</td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<input type="text" name="regfacenum" size="3" value="<%=regfacenum%>">&nbsp;��
</td>
</tr-->

<tr bgcolor=<%=aTabletitlecolor%>> 
<td height="23" colspan="2" ><font color="<%=TableContentColor%>"><b>�������öԷ���̳��Ч</b>(���������<a href="#board"><font color=red>���÷���̳</font></a>����������һ��ɺ���)</font></td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>����������ʾ��������</U><BR>Ϊ��ʡ��Դ����ر�</td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<input type=radio name="online_g" value=0 <%if cint(online_g)=0 then%>checked<%end if%>>�ر�&nbsp;
<input type=radio name="online_g" value=1 <%if cint(online_g)=1 then%>checked<%end if%>>��&nbsp;
</td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>����������ʾ�û�����</U><BR>Ϊ��ʡ��Դ����ر�</td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<input type=radio name="online_u" value=0 <%if cint(online_u)=0 then%>checked<%end if%>>�ر�&nbsp;
<input type=radio name="online_u" value=1 <%if cint(online_u)=1 then%>checked<%end if%>>��&nbsp;
</td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>����ͬʱ������</U><BR>�粻�����ƣ�������Ϊ999999</td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<input type="text" name="online_n" size="6" value="<%=online_n%>">&nbsp;��
</td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>�¶���Ϣ��������</U></td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<input type=radio name="openmsg" value=0 <%if cint(openmsg)=0 then%>checked<%end if%>>��&nbsp;
<input type=radio name="openmsg" value=1 <%if cint(openmsg)=1 then%>checked<%end if%>>��&nbsp;
</td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>�Ƿ���ʾҳ��ִ��ʱ��</U></td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<input type=radio name="runtime" value=0 <%if cint(runtime)=0 then%>checked<%end if%>>��&nbsp;
<input type=radio name="runtime" value=1 <%if cint(runtime)=1 then%>checked<%end if%>>��&nbsp;
</td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>�ϴ��ļ���С</U><BR>����д����</td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<input type="text" name="uploadsize" size="6" value="<%=uploadsize%>"> K
</td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>�û�ǩ���Ƿ���UBB����</U></td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<input type=radio name="UserubbCode" value=0 <%if UserubbCode=0 then%>checked<%end if%>>�ر�&nbsp;
<input type=radio name="UserubbCode" value=1 <%if UserubbCode=1 then%>checked<%end if%>>��&nbsp;
</td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>�û�ǩ���Ƿ���HTML����</U></td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<input type=radio name="UserHtmlCode" value=0 <%if UserHtmlCode=0 then%>checked<%end if%>>�ر�&nbsp;
<input type=radio name="UserHtmlCode" value=1 <%if UserHtmlCode=1 then%>checked<%end if%>>��&nbsp;
</td>
</tr>
<tr> 
<td height="17" width="50%"><U>�û������б����</U></td>
<td height="17" width="50%"> 
<input type="text" name="TopUserNum" size="6" value="<%=TopUserNum%>">&nbsp;��
</td>
</tr>
<%
end sub

sub admin_board()
%>
<tr bgcolor=<%=Tabletitlecolor%>> 
<td height="23" colspan="2" ><font color="<%=TableContentColor%>"><a name="board"><b>��̳����ʹ������</b>
</a>(���������<a href="#config"><font color=red>��������̳</font></a>���������ݿɺ���)</font></td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>��̳���</U><BR>���������Ϊ����</td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<input type=radio name="DvbbsSkin" value=0 <%if DvbbsSkin=0 then%>checked<%end if%>>Ĭ�Ϸ��&nbsp;
<input type=radio name="DvbbsSkin" value=1 <%if DvbbsSkin=1 then%>checked<%end if%>>���������&nbsp;
</td>
</tr>
<tr> 
<td height="17" width="50%"><U>���������Ԥ������</U><BR>ȡ��Ԥ������д0</td>
<td height="17" width="50%"> 
<input type="text" name="SkinFontNum" size="6" value="<%=SkinFontNum%>">&nbsp;��
</td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>�����ϴ�ͼƬ</U><BR>��������ͼƬ���ϴ��������̳�Ѿ����ã��Է���̳Ϊ׼</td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<input type=radio name="Uploadpic" value=0 <%if cint(Uploadpic)=0 then%>checked<%end if%>>�ر�&nbsp;
<input type=radio name="Uploadpic" value=1 <%if cint(Uploadpic)=1 then%>checked<%end if%>>��&nbsp;
</td>
</tr>
<tr> 
<td height="17" width="50%"><U>����ͼƬ�ϴ�·��</U><BR>�����̳Ŀ¼·��</td>
<td height="17" width="50%"> 
<input type="text" name="UpLoadPath" size="10" value="<%=UpLoadPath%>">&nbsp;�磺uploadFace
</td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>���������̳</U><BR>�������Ƿ�������������̳</td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<input type=radio name="guestlogin" value=0 <%if cint(guestlogin)=0 then%>checked<%end if%>>����&nbsp;
<input type=radio name="guestlogin" value=1 <%if cint(guestlogin)=1 then%>checked<%end if%>>������&nbsp;
</td>
</tr>
<tr> 
<td height="17" width="50%"><U>�������������ֽ���</U><BR>����������</td>
<td height="17" width="50%"> 
<input type="text" name="AnnounceMaxBytes" size="6" value="<%=AnnounceMaxBytes%>">&nbsp;�ֽ�
</td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>ÿҳ��ʾ����¼</U><BR>������̳���кͷ�ҳ�йص���Ŀ</td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<input type="text" name="MaxAnnouncePerPage" size="3" value="<%=MaxAnnouncePerPage%>">&nbsp;��
</td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>�������ÿҳ��ʾ������</U></td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<input type="text" name="Maxtitlelist" size="3" value="<%=Maxtitlelist%>">&nbsp;��
</td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>����ģʽ</U><BR>�߼�ģʽΪ��ʾ������Ŀ</td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<input type=radio name="TopicFlag" value=0 <%if cint(TopicFlag)=0 then%>checked<%end if%>>��ͨ&nbsp;
<input type=radio name="TopicFlag" value=1 <%if cint(TopicFlag)=1 then%>checked<%end if%>>�߼�&nbsp;
</td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>����������ɾ������</U></td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<input type=radio name="bmflag_1" value=0 <%if cint(bmflag_1)=0 then%>checked<%end if%>>�ر�&nbsp;
<input type=radio name="bmflag_1" value=1 <%if cint(bmflag_1)=1 then%>checked<%end if%>>��&nbsp;
</td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>�������ɸ�����̳ʹ������</U></td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<input type=radio name="bmflag_3" value=0 <%if cint(bmflag_3)=0 then%>checked<%end if%>>�ر�&nbsp;
<input type=radio name="bmflag_3" value=1 <%if cint(bmflag_3)=1 then%>checked<%end if%>>��&nbsp;
</td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>���а������ɸ�����̳����</U></td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<input type=radio name="bmflag_5" value=0 <%if cint(bmflag_5)=0 then%>checked<%end if%>>�ر�&nbsp;
<input type=radio name="bmflag_5" value=1 <%if cint(bmflag_5)=1 then%>checked<%end if%>>��&nbsp;
</td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>�Ƿ�����δ��½�û�����</U></td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<input type=radio name="Search_G" value=0 <%if cint(Search_G)=0 then%>checked<%end if%>>����&nbsp;
<input type=radio name="Search_G" value=1 <%if cint(Search_G)=1 then%>checked<%end if%>>������&nbsp;
</td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>���������ֺ�</U></td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<input type="text" name="FontSize" size="3" value="<%=FontSize%>">&nbsp;Pt����15
</td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>���������о�</U></td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<input type="text" name="FontHeight" size="3" value="<%=FontHeight%>">&nbsp;���о࣬��1.5
</td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>�������󷵻�</U></td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<input type=radio name="PostRetrun" value=1 <%if PostRetrun=1 then%>checked<%end if%>>��ҳ&nbsp;
<input type=radio name="PostRetrun" value=2 <%if PostRetrun=2 then%>checked<%end if%>>��̳&nbsp;
<input type=radio name="PostRetrun" value=3 <%if PostRetrun=3 then%>checked<%end if%>>����&nbsp;
</td>
</tr>
<%
end sub
%>