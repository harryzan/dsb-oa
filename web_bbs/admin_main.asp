<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=chkuser.asp-->
<title><%=ForumName%>--管理页面</title>
<!--#include file=forum_css.asp-->

<BODY <%=ForumBody%>>
<%
	if session("flag")="" then
		Errmsg=Errmsg+"<br>"+"<li>本页面为管理员专用，请<a href=admin_index.asp target=_top>登陆</a>后进入。"
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
        <td><font color="<%=TablefontColor%>">欢迎<b><%=membername%></b>进入管理中心</font>
        </td>
        </tr>
            <tr bgcolor=<%=tablebodycolor%>>
          <td width="100%" valign=top><font color="<%=TableContentColor%>"> 
            <CENTER>
              <B>欢迎您使用长江隧桥</B> 
            </CENTER>
            <BR>
            <B>以下为长江隧桥基本信息，管理操作请点击左边相应连接</B><br>
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