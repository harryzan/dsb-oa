<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!-- #include file="chkuser.asp" -->
<!-- #include file="inc/char.asp" -->
<!--#include file="inc/theme.asp"-->
<%
    	Rem ----------------------
    	Rem ------������ʼ------
    	Rem ----------------------
	if boardid=0 then
	stats="��̳����ɫ"
	else
	stats=BoardType & "��ɫ"
	end if
	if viewcolor=0 then
	Errmsg=Errmsg+"<br>"+"<li>�ð�����ɫδ������������������棡"
	Founderr=true
	end if
	if founderr then
		call nav()
		call headline(2)
		call error()
	else
		call nav()
		call headline(2)
		call boardcolor()
	end if
	call endline()
	REM ��ʾ������Ϣ---Headinfo
	sub boardcolor()
%>
<table width="<%=TableWidth%>" border="0" cellspacing="1" cellpadding="3" align="center" bgcolor="<%=TableBackColor%>">
  <tr bgcolor="<%=TableTitleColor%>"> 
    <td colspan=3><b><img src="<%=picurl%>arrow1.gif" width="13" height="13"> 
      ��̳BODY��ǩ</b></td>
  </tr> 
<tr bgcolor="<%=TablebodyColor%>"> 
<td width="45%"><font color="<%=TableContentColor%>">
����������̳���ı�����ɫ���߱���ͼƬ��</font></td>
<td width="5%"></td>
<td width="50%"> 
<%=ForumBody%>
</td>
</tr>
<tr bgcolor="<%=aTablebodyColor%>"> 
<td width="45%" height=23><font color="<%=TableContentColor%>">
������߿���ɫ</font></td>
<td width="5%" bgcolor="<%=IEBarcolor%>"></td>
<td width="50%"> 
<%=IEBarcolor%>
</td>
</tr>
  <tr bgcolor="<%=TableTitleColor%>"> 
    <td colspan=3><b><img src="<%=picurl%>arrow1.gif" width="13" height="13"> 
      ��̳�����ɫ</b></td>
  </tr> 
<tr bgcolor="<%=TablebodyColor%>"> 
<td width="45%" height=23><font color="<%=TableContentColor%>">��̳�����˵���񱳾��������</font></td>
<td width="5%" bgcolor="<%=NavDarkcolor%>"></td>
<td width="50%"> 
<%=NavDarkcolor%>
</td>
</tr>
<tr bgcolor="<%=aTablebodyColor%>"> 
<td width="45%" height=23><font color="<%=TableContentColor%>">��̳�����˵���񱳾���ǳ������</font></td>
<td width="5%" bgcolor="<%=Navlighcolor%>"></td>
<td width="50%"> 
<%=Navlighcolor%>
</td>
</tr>
<tr bgcolor="<%=TablebodyColor%>"> 
<td width="45%" height=23><font color="<%=TableContentColor%>">���߿���ɫһ��һ��ҳ�棩</font></td>
<td width="5%" bgcolor="<%=Tablebackcolor%>"></td>
<td width="50%"> 
<%=Tablebackcolor%>
</td>
</tr>
<tr bgcolor="<%=aTablebodyColor%>"> 
<td width="45%" height=23><font color="<%=TableContentColor%>">���߿���ɫ��
������ҳ�棭�������ã�</font></td>
<td width="5%" bgcolor="<%=aTablebackcolor%>"></td>
<td width="50%"> 
<%=aTablebackcolor%>
</td>
</tr>
<tr bgcolor="<%=TablebodyColor%>"> 
<td width="45%" height=23><font color="<%=TableContentColor%>">����������ɫһ��һ��ҳ�棩</font></td>
<td width="5%" bgcolor="<%=Tabletitlecolor%>"></td>
<td width="50%"> 
<%=Tabletitlecolor%>
</td>
</tr>
<tr bgcolor="<%=aTablebodyColor%>"> 
<td width="45%" height=23><font color="<%=TableContentColor%>">����������ɫ��������ҳ�棭�������ã�</font></td>
<td width="5%" bgcolor="<%=aTabletitlecolor%>"></td>
<td width="50%"> 
<%=aTabletitlecolor%>
</td>
</tr>
<tr bgcolor="<%=TablebodyColor%>"> 
<td width="45%" height=23><font color="<%=TableContentColor%>">��񱳾���ɫһ</font></td>
<td width="5%" bgcolor="<%=Tablebodycolor%>"></td>
<td width="50%"> 
<%=Tablebodycolor%>
</td>
</tr>
<tr bgcolor="<%=aTablebodyColor%>"> 
<td width="45%" height=23><font color="<%=TableContentColor%>">��񱳾���ɫ����1��2��ɫ�ڱ���д�����ʾ��</font></td>
<td width="5%" bgcolor="<%=aTablebodycolor%>"></td>
<td width="50%"> 
<%=aTablebodycolor%>
</td>
</tr>
  <tr bgcolor="<%=TableTitleColor%>"> 
    <td colspan=3><b><img src="<%=picurl%>arrow1.gif" width="13" height="13"> 
      ��̳������ɫ</b></td>
  </tr> 
<tr bgcolor="<%=TablebodyColor%>"> 
<td width="45%" height=23><font color="<%=TableContentColor%>">��������������ɫ</font></td>
<td width="5%" bgcolor="<%=TableFontcolor%>"></td>
<td width="50%"> 
<%=TableFontcolor%>
</td>
</tr>
<tr bgcolor="<%=aTablebodyColor%>"> 
<td width="45%" height=23><font color="<%=TableContentColor%>">���������������ɫ</font></td>
<td width="5%" bgcolor="<%=TableContentcolor%>"></td>
<td width="50%"> 
<%=TableContentcolor%>
</td>
</tr>
<tr bgcolor="<%=TablebodyColor%>"> 
<td width="45%" height=23><font color="<%=TableContentColor%>">��������������ɫ</font></td>
<td width="5%" bgcolor="<%=AlertFontColor%>"></td>
<td width="50%"> 
<%=AlertFontColor%>
</td>
</tr>
<tr bgcolor="<%=aTablebodyColor%>"> 
<td width="45%" height=23><font color="<%=TableContentColor%>">��ʾ���ӵ�ʱ��������ӣ�ת�����ӣ��ظ��ȵ���ɫ</font></td>
<td width="5%" bgcolor="<%=ContentTitle%>"></td>
<td width="50%"> 
<%=ContentTitle%>
</td>
</tr>
<tr bgcolor="<%=TablebodyColor%>"> 
<td width="45%" height=23><font color="<%=TableContentColor%>">��ҳ������ɫ������⣩</font></td>
<td width="5%" bgcolor="<%=BodyFontColor%>"></td>
<td width="50%"> 
<%=BodyFontColor%>
</td>
</tr>
<tr bgcolor="<%=aTablebodyColor%>"> 
<td width="45%" height=23><font color="<%=TableContentColor%>">��ҳ������ɫ</font></td>
<td width="5%" bgcolor="<%=BoardLinkColor%>"></td>
<td width="50%"> 
<%=BoardLinkColor%>
</td>
</tr>
<tr bgcolor="<%=TablebodyColor%>"> 
<td width="45%" height=23><font color="<%=TableContentColor%>">һ���û�����������ɫ</font></td>
<td width="5%" bgcolor="<%=user_fc%>"></td>
<td width="50%"> 
<%=user_fc%>
</td>
</tr>
<tr bgcolor="<%=aTablebodyColor%>"> 
<td width="45%" height=23><font color="<%=TableContentColor%>">һ���û������ϵĹ�����ɫ</font></td>
<td width="5%" bgcolor="<%=user_mc%>"></td>
<td width="50%"> 
<%=user_mc%>
</td>
</tr>
<tr bgcolor="<%=TablebodyColor%>"> 
<td width="45%" height=23><font color="<%=TableContentColor%>">��������������ɫ</font></td>
<td width="5%" bgcolor="<%=bmaster_fc%>"></td>
<td width="50%"> 
<%=bmaster_fc%>
</td>
</tr>
<tr bgcolor="<%=aTablebodyColor%>"> 
<td width="45%" height=23><font color="<%=TableContentColor%>">���������ϵĹ�����ɫ</font></td>
<td width="5%" bgcolor="<%=bmaster_mc%>"></td>
<td width="50%"> 
<%=bmaster_mc%>
</td>
</tr>
<tr bgcolor="<%=TablebodyColor%>"> 
<td width="45%" height=23><font color="<%=TableContentColor%>">����Ա����������ɫ</font></td>
<td width="5%" bgcolor="<%=master_fc%>"></td>
<td width="50%"> 
<%=master_fc%>
</td>
</tr>
<tr bgcolor="<%=aTablebodyColor%>"> 
<td width="45%" height=23><font color="<%=TableContentColor%>">���������ϵĹ�����ɫ</font></td>
<td width="5%" bgcolor="<%=master_mc%>"></td>
<td width="50%"> 
<%=master_mc%>
</td>
</tr>
<tr bgcolor="<%=TablebodyColor%>"> 
<td width="45%" height=23><font color="<%=TableContentColor%>">�������������ɫ</font></td>
<td width="5%" bgcolor="<%=vip_fc%>"></td>
<td width="50%"> 
<%=vip_fc%>
</td>
</tr>
<tr bgcolor="<%=aTablebodyColor%>"> 
<td width="45%" height=23><font color="<%=TableContentColor%>">��������ϵĹ�����ɫ</font></td>
<td width="5%" bgcolor="<%=vip_mc%>"></td>
<td width="50%"> 
<%=vip_mc%>
</td>
</tr>
</table>
<%
	end sub
%>
<!--#include file="footer.asp"-->
