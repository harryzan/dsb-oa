<!--#include file="conn.asp"-->
<!--#include file="inc/const.asp"-->
<!--#include file="inc/char.asp"-->
<!--#include file="chkuser.asp"-->
<!--#include file="inc/theme.asp"-->
<%
	stats="论坛登陆"
	call nav()
	call headline(1)
	call main()
	call endline()
	sub main()
%>
<form action="chklogin.asp" method="post"> 
<table cellpadding=0 cellspacing=0 border=0 width="<%=tablewidth%>" bgcolor=<%=Tablebackcolor%> align=center>
    <tr>    
        <td>
        <table cellpadding=6 cellspacing=1 border=0 width=100%>
    <tr>
    <td bgcolor=<%=Tabletitlecolor%> valign=middle colspan=2 align=center><font color="<%=TableFontColor%>">
    <b>请输入您的用户名、密码登陆</b></font></td></tr>
    <tr>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>">请输入您的用户名</font></td>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><INPUT name=username type=text> &nbsp; <!--<a href="reg.asp">没有注册？</a>--></td></tr>
    <tr>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>">请输入您的密码</font></td>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><INPUT name=password type=password> &nbsp; <!--<a href="lostpass.asp">忘记密码？</a>--></td></tr>
    <!--tr>
    <td  valign=top width=30%><b>Cookie 选项</b><BR> 请选择你的 Cookie 保存时间，下次访问可以方便输入。</font></td>
    <td valign=middle>
                <input type="radio" name="CookieDate" value="0" checked>不保存，关闭浏览器就失效<br>
                <input type="radio" name="CookieDate" value="1">保存一天<br>
                <input type="radio" name="CookieDate" value="2">保存一月<br>
                <input type="radio" name="CookieDate" value="3">保存一年<br></font>
                </td></tr-->
	<input type=hidden name=comeurl value="<%=Request.ServerVariables("HTTP_REFERER")%>">
    <tr>
    <td bgcolor=<%=Tabletitlecolor%> valign=middle colspan=2 align=center><input type=submit name="submit" value="登 陆"></td></tr></table></td></tr></table>
</form>
<%end sub%>
<!--#include file="footer.asp"-->