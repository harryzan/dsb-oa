<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!--#include file="inc/char.asp"-->
<!-- #include file="chkuser.asp" -->
<!--#include file="inc/theme.asp"-->
<%
	Errmsg=Errmsg+"<br>"+"<li>ϵͳ��֧���û�����ע�ᣬ����ϵϵͳ����Ա��</li>"
	Founderr=true
	call error()
	response.end
	
	stats="�û�ע��"
	call nav()
	call headline(1)
	call main()
	call endline()
%>
<%sub main()%>
    <table cellpadding=6 cellspacing=1 border=0 width=<%=tablewidth%> align=center>
    
    <tr>
    <td bgcolor=<%=TableTitlecolor%> align=center><font color="<%=TablefontColor%>">
    <form action="reg_1.asp" method="post">
    <b>�������������</b></font>
    </td>
    </tr>
    <td bgcolor=<%=tablebodycolor%> align=left>
<font color=<%=tablecontentcolor%>>
     <b>����ע��ǰ�����Ķ���̳Э��</b><p>
��ӭ�����뱾վ��μӽ��������ۣ���վ��Ϊ������̳��Ϊά�����Ϲ������������ȶ��������Ծ������������<BR><BR>
һ���������ñ�վΣ�����Ұ�ȫ��й¶�������ܣ������ַ�������Ἧ��ĺ͹���ĺϷ�Ȩ�棬�������ñ�վ���������ƺʹ���������Ϣ�� <BR>
����һ��ɿ�����ܡ��ƻ��ܷ��ͷ��ɡ���������ʵʩ�ģ�<BR>
��������ɿ���߸�������Ȩ���Ʒ���������ƶȵģ�<BR>
��������ɿ�����ѹ��ҡ��ƻ�����ͳһ�ģ�<BR>
�����ģ�ɿ�������ޡ��������ӣ��ƻ������Ž�ģ�<BR>
�����壩�������������ʵ��ɢ��ҥ�ԣ������������ģ�<BR>
������������⽨���š����ࡢɫ�顢�Ĳ�����������ɱ���ֲ�����������ģ�<BR>
�����ߣ���Ȼ�������˻���������ʵ�̰����˵ģ����߽����������⹥���ģ�<BR>
�����ˣ��𺦹��һ��������ģ�<BR>
�����ţ�����Υ���ܷ��ͷ�����������ģ�<BR>
����ʮ��������ҵ�����Ϊ�ġ�<BR>
�����������أ����Լ������ۺ���Ϊ���� <BR>
<p></font>
    </td>
    </tr>
    <tr>
    <td bgcolor=<%=TableTitlecolor%> align=center>
    <center><input type="submit" value="��ͬ��"></center>
    </td></form></tr></table>
    </td></tr></table>
<%end sub%>
<!--#include file="footer.asp"-->
