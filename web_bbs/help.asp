<!-- #include file="conn.asp" -->
<!-- #include file="inc/const.asp" -->
<!--#include file="inc/grade.asp"-->
<!--#include file="inc/ubbcode.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<LINK href="forum.css" rel=stylesheet>
<title><%=Forumname%>--����</title>
</head>

<body bgcolor="#ffffff" alink="#333333" vlink="#333333" link="#333333">
    <table cellpadding=0 cellspacing=0 border=0 width=95% bgcolor=#777777 align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
    <tr align="center"> 
      <td width="100%" bgcolor=#EEEEEE><b><%=Forumname%>�����ļ�</b></td>
    </tr>
    <tr> 
      <td width="100%" bgcolor=#FFFFFF><blockquote>
<%if request("action")="" then%>
        <p align="center"><br>
        ϣ�����������Ϣ��������</p>
        <p>��������ļ�</p>
        <p>����<a href=help.asp?action=message>����Ϣ</a>�İ���</p>
        <p>����<a href=help.asp?action=update>������Ϣ</a>�İ���</p>
        <p>����<a href=help.asp?action=announce>������</a>�İ���</p>
        <p>����<a href=help.asp?action=edit>�޸�����</a>�İ���</p>
        <p>����<a href=help.asp?action=forget>��������</a>�İ���</p>
        <p>����<a href=help.asp?action=reg>�û�ע��</a>�İ���</p>
        <p>����<a href=help.asp?action=online>�����û�</a>�İ���</p>
<%
elseif request("action")="message" then
	call message()
elseif request("action")="update" then
	call update()
elseif request("action")="announce" then
	call announce()
elseif request("action")="edit" then
	call edit()
elseif request("action")="forget" then
	call forget()
elseif request("action")="reg" then
	call reg()
elseif request("action")="online" then
	call online()
elseif request("action")="ubb" then
	call ubb()
elseif request("action")="face" then
	call face()
elseif request("action")="point" then
	call fpoint()
end if
%>
	</blockquote>
      </td>
    </tr>
    </table>   </td></tr></table>
<!--#include file="footer.asp"-->
</body>     
<%
sub message()
%>
        <p align="center"><br>
        <b>����Ϣ����</b></p>
	<p>����Ϣ����Ҳ�൱�����ԣ�����ͬ�������������û���¼����������¼�ʱ�շ���Ϣ�������࣬��DV3000�汾�������˼�ʱ�շ����ռ��䡢�����䡢ȫ����Ϣɾ���Ȳ�����</p>
	<p><b>������Ϣ</b>����¼�û����ܷ�����Ϣ��һ�����Լ���д�ռ������ƣ����û���������̳ע���û����������ı�������ݣ�����֧��ubb��ʽ������һ��������̳�в鿴���ӵ�ʱ��ֱ�Ӹ����߷�����Ϣ����Ҫ��д����ͬ�ϡ�������Ϣ�󣬸���Ϣ����ͬʱ������ķ������С�
	<p><b>�ռ���</b>����¼��̳�����Ϸ�����Ϣ���ӣ��г������Ѷ���δ������Ϣ������⡢�����ˣ����Խ��ж�ȡ��Ϣ��ȫ��ɾ��������
	<p><b>������</b>����¼��̳�������Ϣҳ�棬����ֱ�ӽ�������ռ��䣬���ﱣ������ǰ�����͹�����Ϣ���⼰�ռ��ˣ����Խ��ж�ȡ��ȫ��ɾ��������
	<p><b>����Ϣ</b>����¼��̳��ÿ���б��˸��㷢���µĶ���Ϣ������ԭ������Ϣ��δ��ȡ����̳�����Զ���������Ϣ��ʾ��ֱ�ӵ�����Ķ���
	<p>�鿴<a href=help.asp>���а����ļ�</a>
<%
end sub

sub update()
%>
        <p align="center"><br>
        <b>���ĸ�����Ϣ����</b></p>
	<p>ֻ�е�¼�û����ܽ��д��������ԭע���û��������޸ģ����Ը��µ���Ϣ���£�
	<p>���룺��¼��̳����
	<br>�Ա𣺽���ʾ��������Ϻ���̳��
	<br>������̳����ѡ�����̳����Ժ��¼���Զ�����
	<br>����ͷ����ѡ��ͷ���������г��֣���Ԥ������ͷ�񣬿���������ͼƬurl
	<br>Email��ַ������������ȷ�Ϸ��������ַ
	<br>������ҳ����ѡ��
	<br>OICQ����ѡ��
	<br>����ǩ����֧��ubb��������룬�����������µĽ�β
	<p>�鿴<a href=help.asp>���а����ļ�</a>
<%
end sub

sub announce()
%>
        <p align="center"><br>
        <b>�������Ӱ���</b></p>
        ���·����ӵİ�����</B>
<P>����һ�������⣬���ǻظ��������⣬�������ע���û���
<P><B>ǩ����:</B><BR>�����ѡ�С�����ʱ����ǩ������ѡ���ÿ�η���ʱϵͳ��������Զ��������ǩ�����������ʱͨ�����˵������޸����ǩ������ǩ�����ĵ��������Ķ�����ʱ��ʱ���еģ����ԣ�������޸���ǩ�������㷢���������ӣ������޸���ǰ�ģ��������Ķ��������ǩ������
<P><B>���ӻظ���Email֪ͨ:</B><BR>�����̳����Ա�Ѱ��ʼ����ܴ򿪣����ѡ�С����˻ظ�������ʱ�յ�Email֪ͨ����������������˻ظ�������⣬ϵͳ���Զ�Email֪ͨ�㡣
<P><B>ע��:</B><BR>���˷�������ʱ����ʡȥ�����������⣬��Ҫȷ����д�������ѳɹ��������ӡ�<BR>
<P>���������ͼ�͡�������Ѿ����õĻ������ᵯ������ͼ�͵�ͼ���Թ�ѡ�񣻵������̳��ǩ�������ᵯ����ǩͼ���Թ�ѡ��ʹ�á�
<p>�鿴<a href=help.asp>���а����ļ�</a>
<%
end sub

sub edit()
%>
        <p align="center"><br>
        �����޸����ӵİ���</p>
        <p><b>���ڷ�������֮������е������⣬�����ڵ�½������¶��������ӽ����޸ģ�����ͬ�������ӣ�<br>
        <p>�鿴<a href=help.asp>���а����ļ�</a>
<%
end sub

sub forget()
%>
        <p align="center"><br><b>
        ������������İ���</b></p>
        <P>����������룬���Ҫ��ϵͳ�����뷢����ע��ʱ���Ǽǵ������
        <P>ֻҪ������ע���Email��ַ��ϵͳ�����Ϸ���������롣���������޷��ʹ˵�֪�������ģ���Ϊϵͳ�Ǹ��������ṩ���û��������뷢����������Ͽ�������¼��Email��ַ��</P>
        <p>�鿴<a href=help.asp>���а����ļ�</a> 
<%
end sub

sub reg()
%>
        <p align="center"><br><b>
       �����û�ע��İ���</b></p>
        <FONT face=���� color=#000000><B>�����û�ע��İ�����</B>
<P>����ע��ǰ����ͬ�Ȿ��̳Э�顣�ڱ���ͬ��֮ǰ�������Ķ�Э�顣
<P>�����̳����ԱҪ������ʼ�ȷ�ϣ�������뽫��ͨ��Email�����㡣�˺������ʱ�޸�������롣ѡ������ʱ�������ȷ�����벻���ױ����˲³������Ҳ�����5���ַ���
<P>������ύһ������you@yourdomain.com����ЧEmail��ַ�����ע�ᡣ
<P>�������ǿ�ѡ�ģ����ǣ�����û����˽���ǵķ�Χ�ڣ����ǹ����㾡���ܵ�ע����ϸ��Ϣ����̳�����������ʼ��Ͷ�����Ϣ���������ע����Ϣ���ϸ��ܡ�
<P><B>ǩ����</B><BR>��ɱ༭�и�����ɫ��ǩ������������ÿ�η����ӵ�ʱ�����ѡ����ϡ�ϵͳ�趨ǩ�������ܳ������У�ÿ���Իس���Ϊ׼�������ҿ���ʹ����̳��UBB)��ǩ������ֹʹ��HTML��ǩ��
<P><B>����ͷ��</B><BR>�����ʹ���Լ�ϲ���ĸ���ͷ�񣬵����ע�⽫��ͼƬ������url��ַ������񣬲��ҷ���ϵͳ�涨�Ĵ�С��
        <p>�鿴<a href=help.asp>���а����ļ�</a> 
<%
end sub

sub online()
%>
        <p align="center"><br><b>
       ���������û��İ���</b></p>
<P>���������г��˵�ǰ���������û������ֺ͵�ǰ״̬�����״̬����Ķ�������ʱ���µġ�
<P>���ߵ����з�ע���û�����ʾΪ�����ˡ���
<P>ע�⣬�������20����֮��û���κζ�����ϵͳ������Ϊ���Զ����ߣ�����Ҫ���µ�¼��
        <p>�鿴<a href=help.asp>���а����ļ�</a> 

<%
end sub

sub ubb()
%>
        <p align="center"><br>
       <b> UBB��ǩ����</b></p>
<p>��̳�����ɹ���Ա�����Ƿ�֧��UBB��ǩ��UBB��ǩ���ǲ�����ʹ��HTML�﷨������£�ͨ����̳������ת��������������֧���������õġ���Σ���Ե�HTMLЧ����ʾ������Ϊ����ʹ��˵����
<p><font color=red>[B]</font><b>����</b><font color=red>[/B]</font>�������ֵ�λ�ÿ��������������Ҫ���ַ�����ʾΪ����Ч����
<p><font color=red>[I]</font><i>����</i><font color=red>[/I]</font>�������ֵ�λ�ÿ��������������Ҫ���ַ�����ʾΪб��Ч����
<p><font color=red>[U]</font><u>����</u><font color=red>[/U]</font>�������ֵ�λ�ÿ��������������Ҫ���ַ�����ʾΪ�»���Ч����
<p><font color=red>[align=center]</font><div align=center>����</div><font color=red>[/align]</font>�������ֵ�λ�ÿ��������������Ҫ���ַ���centerλ��center��ʾ���У�left��ʾ����right��ʾ���ҡ�
<p><font color=red>[URL]</font><A HREF="HTTP://WWW.DONGHAI-BRIDGE.COM.CN">HTTP://WWW.DONGHAI-BRIDGE.COM.CN</A><font color=red>[/URL]</font>
<P><font color=red>[URL=HTTP://WWW.DONGHAI-BRIDGE.COM.CN]</font><A HREF="www.donghai-bridge.com.cn">�����޹��̽�����Ϣ��</A><font color=red>[/URL]</font>�������ַ������Լ��볬�����ӣ��������Ӿ����ַ�����������ӡ�
<p><font color=red>[EMAIL]</font><A HREF="mailto:test@mmail.com">test@mmail.com</A><font color=red>[/EMAIL]</font>
<P><font color=red>[EMAIL=MAILTO:test@mmail.com]</font><A HREF="mailto:test@mmail.com">ɳ̲С��</A><font color=red>[/EMAIL]</font>�������ַ������Լ����ʼ����ӣ��������Ӿ����ַ�����������ӡ�
<P><font color=red>[img]</font><img src=http://www.icsh.sh.cn/images/*.gif><font color=red>[/img]</font>���ڱ�ǩ���м����ͼƬ��ַ����ʵ�ֲ�ͼЧ����
<P><font color=red>[flash]</font>Flash���ӵ�ַ<font color=red>[/Flash]</font>���ڱ�ǩ���м����FlashͼƬ��ַ����ʵ�ֲ���Flash��
<P><font color=red>[code]</font>����<font color=red>[/code]</font>���ڱ�ǩ��д�����ֿ�ʵ��html�б��Ч����
<P><font color=red>[quote]</font>����<font color=red>[/quote]</font>���ڱ�ǩ���м�������ֿ���ʵ��HTMl����������Ч����
<P><font color=red>[list]</font>����<font color=red>[/list]</font> <font color=red>[list=a]</font>����<font color=red>[/list]</font>  <font color=red>[list=1]</font>����<font color=red>[/list]</font>������list���Ա�ǩ��ʵ��HTMLĿ¼Ч����
<P><font color=red>[fly]</font>����<font color=red>[/fly]</font>���ڱ�ǩ���м�������ֿ���ʵ�����ַ���Ч�������������ơ�
<P><font color=red>[move]</font>����<font color=red>[/move]</font>���ڱ�ǩ���м�������ֿ���ʵ�������ƶ�Ч����Ϊ����Ʈ����
<P><font color=red>[glow=255,red,2]</font>����<font color=red>[/glow]</font>���ڱ�ǩ���м�������ֿ���ʵ�����ַ�����Ч��glow����������Ϊ���ȡ���ɫ�ͱ߽��С��
<P><font color=red>[shadow=255,red,2]</font>����<font color=red>[/shadow]</font>���ڱ�ǩ���м�������ֿ���ʵ��������Ӱ��Ч��shadow����������Ϊ���ȡ���ɫ�ͱ߽��С��
<P><font color=red>[color=��ɫ����]</font>����<font color=red>[/color]</font>������������ɫ���룬�ڱ�ǩ���м�������ֿ���ʵ��������ɫ�ı䡣
<P><font color=red>[size=����]</font>����<font color=red>[/size]</font>���������������С���ڱ�ǩ���м�������ֿ���ʵ�����ִ�С�ı䡣
<P><font color=red>[face=����]</font>����<font color=red>[/face]</font>����������Ҫ�����壬�ڱ�ǩ���м�������ֿ���ʵ����������ת����
        <p>�鿴<a href=help.asp>���а����ļ�</a> 
<%
end sub

sub face()
%>
        <p align="center"><br>
        ����ת������</p>
<p>����&nbsp;&nbsp;&nbsp;&nbsp;ת����<p>
<%for e=1 to 9%>
                	[em0<%=e%>]&nbsp;&nbsp;&nbsp;&nbsp;<img src="pic/em0<%=e%>.gif" border=0><p>
<%next%>
<%for e=10 to 28%>
                	[em<%=e%>]&nbsp;&nbsp;&nbsp;&nbsp;<img src="pic/em<%=e%>.gif" border=0><p>
<%next%>
        <p>�鿴<a href=help.asp>���а����ļ�</a> 
<%
end sub

sub fpoint()
%>
        <p align="center"><br>
        ��̳���ְ���</p>
<p>�������»���<font color=red>+1</font>
<p>����̳�ظ����»���<font color=red>+3</font>������̳<font color=red>+1</font>
<p><b>�����û��ȼ���</b>
<%
dim i
i=1
for i=1 to 17
%>
<p><%=grade(i)%>�������<%=point(i)%>
<%next%>
<p><%=grade(18)%>Ϊ�������߹���Ա�趨�����Խ����ض����档
<p><%=grade(19)%>Ϊ����Ա�趨�����Զ���̳���ӽ��й�����
<p><%=grade(20)%>�ܰ�����ӵ��ȫ��Ȩ�ޡ�
        <p>�鿴<a href=help.asp>���а����ļ�</a> 
<%
end sub
stats="�����̳����"
%>
<!--#include file=footer.asp-->