<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!-- #include file="chkuser.asp" -->
<!-- #include file="inc/char.asp" -->
<!--#include file="inc/theme.asp"-->
<!--#include file="inc/grade.asp"-->
<%
    	Rem ----------------------
    	Rem ------������ʼ------
    	Rem ----------------------
	if boardid=0 then
	stats="��̳�ܰ���"
	else
	stats=BoardType & "�������"
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
<tr bgcolor="<%=TablebodyColor%>"> 
    <td width="100%" align=center> <A HREF="#ubb">UBB�﷨</A> | <A HREF="#ubb1">UBB����</A> 
    </td>
</tr>
  <tr bgcolor="<%=TableTitleColor%>"> 
    <td><b>C. <A name="ubb">UBB�﷨</A></b></td>
  </tr> 
  <tr bgcolor="<%=TablebodyColor%>"> 
    <td>
<p>��̳�����ɹ���Ա�����Ƿ�֧��UBB��ǩ��UBB��ǩ���ǲ�����ʹ��HTML�﷨������£�ͨ����̳������ת��������������֧���������õġ���Σ���Ե�HTMLЧ����ʾ������Ϊ����ʹ��˵����
<p><font color=red>[B]</font><b>����</b><font color=red>[/B]</font>�������ֵ�λ�ÿ��������������Ҫ���ַ�����ʾΪ����Ч����
<p><font color=red>[I]</font><i>����</i><font color=red>[/I]</font>�������ֵ�λ�ÿ��������������Ҫ���ַ�����ʾΪб��Ч����
<p><font color=red>[U]</font><u>����</u><font color=red>[/U]</font>�������ֵ�λ�ÿ��������������Ҫ���ַ�����ʾΪ�»���Ч����
<p><font color=red>[align=center]</font><div align=center>����</div><font color=red>[/align]</font>�������ֵ�λ�ÿ��������������Ҫ���ַ���centerλ��center��ʾ���У�left��ʾ����right��ʾ���ҡ�
<p><font color=red>[URL]</font><A HREF="">www.donghai-bridge.com.cn</A><font color=red>[/URL]</font>
      <P><font color=red></font><A HREF="www.donghai-bridge.com.cn">�����޹��̽�����Ϣ��</A><font color=red>[/URL]</font>�������ַ������Լ��볬�����ӣ��������Ӿ����ַ�����������ӡ� 
      <p><font color=red>[EMAIL]</font><A HREF="mailto:test@mmail.com">test@mmail.com</A><font color=red>[/EMAIL]</font>
<P><font color=red>[EMAIL=MAILTO:test@mail.com]</font><A HREF="test@mail.com">����</A><font color=red>[/EMAIL]</font>�������ַ������Լ����ʼ����ӣ��������Ӿ����ַ�����������ӡ�
<P><font color=red>[img]</font><img src=HTTP://WWW.DONGHAI-BRIDGE.COM.CN/images/*.gif><font color=red>[/img]</font>���ڱ�ǩ���м����ͼƬ��ַ����ʵ�ֲ�ͼЧ����
<P><font color=red>[flash]</font>Flash���ӵ�ַ<font color=red>[/Flash]</font>���ڱ�ǩ���м����FlashͼƬ��ַ����ʵ�ֲ���Flash��
<P><font color=red>[code]</font>����<font color=red>[/code]</font>���ڱ�ǩ��д�����ֿ�ʵ��html�б��Ч����
<P><font color=red>[quote]</font>����<font color=red>[/quote]</font>���ڱ�ǩ���м�������ֿ���ʵ��HTMl����������Ч����
<P><font color=red>[list]</font>����<font color=red>[/list]</font> <font color=red>[list=a]</font>����<font color=red>[/list]</font>  <font color=red>[list=1]</font>����<font color=red>[/list]</font>������list���Ա�ǩ��ʵ��HTMLĿ¼Ч����
<P><font color=red>[fly]</font>����<font color=red>[/fly]</font>���ڱ�ǩ���м�������ֿ���ʵ�����ַ���Ч������������ơ�
<P><font color=red>[move]</font>����<font color=red>[/move]</font>���ڱ�ǩ���м�������ֿ���ʵ�������ƶ�Ч����Ϊ����Ʈ����
<P><font color=red>[glow=255,red,2]</font>����<font color=red>[/glow]</font>���ڱ�ǩ���м�������ֿ���ʵ�����ַ�����Ч��glow����������Ϊ��ȡ���ɫ�ͱ߽��С��
<P><font color=red>[shadow=255,red,2]</font>����<font color=red>[/shadow]</font>���ڱ�ǩ���м�������ֿ���ʵ��������Ӱ��Ч��shadow����������Ϊ��ȡ���ɫ�ͱ߽��С��
<P><font color=red>[color=��ɫ����]</font>����<font color=red>[/color]</font>������������ɫ���룬�ڱ�ǩ���м�������ֿ���ʵ��������ɫ�ı䡣
<P><font color=red>[size=����]</font>����<font color=red>[/size]</font>���������������С���ڱ�ǩ���м�������ֿ���ʵ�����ִ�С�ı䡣
<P><font color=red>[face=����]</font>����<font color=red>[/face]</font>����������Ҫ�����壬�ڱ�ǩ���м�������ֿ���ʵ����������ת����
<P><font color=red>[DIR=500,350]</font>http://<font color=red>[/DIR]</font>��Ϊ����shockwave��ʽ�ļ����м������Ϊ��Ⱥͳ���
<P><font color=red>[RM=500,350]</font>http://<font color=red>[/RM]</font>��Ϊ����realplayer��ʽ��rm�ļ����м������Ϊ��Ⱥͳ���
<P><font color=red>[MP=500,350]</font>http://<font color=red>[/MP]</font>��Ϊ����Ϊmidia player��ʽ���ļ����м������Ϊ��Ⱥͳ���
<P><font color=red>[QT=500,350]</font>http://<font color=red>[/QT]</font>��Ϊ����ΪQuick time��ʽ���ļ����м������Ϊ��Ⱥͳ���
	</td>
  </tr> 
  <tr bgcolor="<%=TableTitleColor%>"> 
    <td><b>D. <A name="ubb1">UBB����</A></b></td>
  </tr> 
  <tr bgcolor="<%=TablebodyColor%>"> 
    <td>
&nbsp;&nbsp; ����Ϊ����̳��UBB�﷨���ã�ͨ����Щ���ã�������֪���ڱ����淢��������Щ����ǲ���ʹ�õģ����ﻹ�����˿����û�ǩ����ʹ�õ�UBBѡ�<BR>
&nbsp;&nbsp;<B>�û�����</B>��
<ul>
��������<li>HTML��ǩ�� <%if strAllowHTML=0 then%>������<%else%>����<%end if%>
��������<li>UBB��ǩ�� <%if strAllowForumCode=0 then%>������<%else%>����<%end if%>
��������<li>��ͼ��ǩ�� <%if strIcons=0 then%>������<%else%>����<%end if%>
��������<li>Flash��ǩ�� <%if strflash=0 then%>������<%else%>����<%end if%>
��������<li>�����ַ�ת���� <%if strIMGInPosts=0 then%>������<%else%>����<%end if%>
��������<li>�ϴ�ͼƬ�� <%if Uploadpic=0 then%>������<%else%>����<%end if%>
��������<li>���<%=AnnounceMaxBytes\1024%>KB</font></ul>
<BR>&nbsp;&nbsp;<B>�û�ǩ��</B>��
<ul>
��������<li>HTML��ǩ�� <%if UserHtmlCode=0 then%>������<%else%>����<%end if%>
��������<li>UBB��ǩ�� <%if UserubbCode=0 then%>������<%else%>����<%end if%>
��������<li>��ͼ��ǩ(����ͼƬ��flash����ý��)�� <%if UserImgCode=0 then%>������<%else%>����<%end if%>
</ul>
˵��������html��ǩָ�Ƿ�����ʹ��html�﷨����ͼ��flash�Լ������ַ�ת��������UBB�﷨���ݣ���ʹ�÷����ɲ鿴UBB�﷨
	</td>
  </tr> 
</table>
<%
	end sub
%>
<!--#include file="footer.asp"-->
