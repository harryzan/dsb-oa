<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=chkuser.asp-->
<title><%=ForumName%>--����ҳ��</title>
<!--#include file=forum_css.asp-->

<BODY <%=ForumBody%>>
<%
	if session("flag")="" then
		Errmsg=Errmsg+"<br>"+"<li>��ҳ��Ϊ����Աר�ã���<a href=admin_index.asp target=_top>��½</a>����롣"
		call Error()
	else
		call main()
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
          <td width="100%" valign=top><font color="<%=TableContentColor%>"> 
            <CENTER>
              <B>��ӭ��ʹ�ó�������</B> 
            </CENTER>
            <BR>
            <B>����Ϊ�������Ż�����Ϣ������������������Ӧ����</B><br>
            <br>
            <BR>
            ***************************************************************<br>
            ***************************************************************<br>
            </font> </td>
            </tr>
        </table>
        </td>
    </tr>
</table>
<%end sub%>