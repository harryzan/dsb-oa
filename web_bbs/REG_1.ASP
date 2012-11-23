<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!-- #include file="inc/char.asp" -->
<!-- #include file="chkuser.asp" -->
<!-- #include file="inc/theme.asp" -->
<%
  Errmsg=Errmsg+"<br>"+"<li>系统不支持用户自行注册，请联系系统管理员。</li>"
	Founderr=true
	call error()
	response.end
	
	stats="用户注册"
	call nav()
	call headline(1)
	call main()
	call endline()
	sub main()
%>
<FORM name=theForm action=regPost.asp method=post>
<table cellpadding=0 cellspacing=0 border=0 width="<%=tablewidth%>" bgcolor=<%=Tablebackcolor%> align=center>
        <tr>
            <td>
                
<table cellpadding=3 cellspacing=1 border=0 width=100%>
<TBODY> 
<TR align=middle bgcolor=<%=Tabletitlecolor%>> 
<TD colSpan=2 height=24><font color="<%=TablefontColor%>"><b>新用户注册</b></font></TD>
</TR>
<TR bgcolor=<%=Tablebodycolor%>> 
<TD width=40%><font color="<%=TableContentColor%>"><B>用户名</B>：<BR>注册用户名不能超过12个字符（6个汉字）</font></TD>
<TD width=60%> 
<INPUT maxLength=12 size=30 name=name>
                <font color="#FF0000">*</font> </TD>
</TR>
<TR bgcolor=<%=Tablebodycolor%>> 
<TD width=40%><font color="<%=TableContentColor%>"><B>性别</B>：<BR>请选择您的性别</font></TD>
<TD width=60%> <font color="<%=TableContentColor%>">
<INPUT type=radio CHECKED value="1" name=sex>
                <IMG  src="pic/Male.gif" align=absMiddle>男&nbsp;&nbsp;&nbsp;&nbsp; 
                <INPUT type=radio value="0" name=sex>
                <IMG  src="pic/Female.gif" align=absMiddle>女</font></TD>
</TR>

<TR bgcolor=<%=Tablebodycolor%>> 
<TD width=40%><font color="<%=TableContentColor%>"><B>密码(至少6位)</B>：<BR>
请输入密码，区分大小写。<BR>
请不要使用任何类似 '*'、' ' 或 HTML 字符</font>
</TD>
<TD width=60%> 
<INPUT type=password maxLength=16 size=30 name=psw>
                <font color="#FF0000">*</font> </TD>
</TR>
<TR bgcolor=<%=Tablebodycolor%>> 
<TD width=40%><font color="<%=TableContentColor%>"><B>密码(至少6位)</B>：<BR>请再输一遍确认</font></TD>
<TD> 
<INPUT type=password maxLength=16 size=30 name=pswc>
                <font color="#FF0000">*</font> </TD>
</TR>

<TR bgcolor=<%=Tablebodycolor%>> 
<TD width=40%><font color="<%=TableContentColor%>"><B>密码问题</B>：<BR>忘记密码的提示问题</font></TD>
<TD> 
<INPUT type=text size=30 name="quesion">
                <font color="#FF0000">*</font> </TD>
</TR>
<TR bgcolor=<%=Tablebodycolor%>> 
<TD width=40%><font color="<%=TableContentColor%>"><B>问题答案</B>：<BR>忘记密码的提示问题答案，用于取回论坛密码</font></TD>
<TD> 
<INPUT type=text size=30 name="answer">
                <font color="#FF0000">*</font> </TD>
</TR>
<TR bgcolor=<%=Tablebodycolor%>> 
<TD width=40%><font color="<%=TableContentColor%>"><B>Email地址</B>：<BR>
                </font></TD>
<TD width=60%> 
<INPUT maxLength=50 size=30 name=e_mail>
                <font color="#FF0000">*</font>
<input type=button value='检测帐号' name=Button onclick=gopreview()></TD>
</TR>
</tbody>
</table>
</td></tr></tbody></table>

<table cellpadding=0 cellspacing=0 border=0 width="<%=tablewidth%>" bgcolor=<%=Tablebackcolor%> align=center id=adv style="DISPLAY: none">
        <tr>
            <td>
            <table cellpadding=3 cellspacing=1 border=0 width=100%>
<TBODY> 

<TR bgcolor=<%=Tablebodycolor%>> 
<TD width=40%><font color="<%=TableContentColor%>"><B>头像</B>：<BR>选择的头像将出现在您的资料和发表的帖子中，您也可以选择下面的自定义头像</font></TD>
<TD width=60%> 
<select name=face size=1 onChange="document.images['face'].src=options[selectedIndex].value;" style="BACKGROUND-COLOR: #99CCFF; BORDER-BOTTOM: 1px double; BORDER-LEFT: 1px double; BORDER-RIGHT: 1px double; BORDER-TOP: 1px double; COLOR: #000000">
<%for i=1 to regfacenum%>
<option value='<%=picurl%>Image<%=i%>.gif'>Image<%=i%></option>
<%next%>
</select>
&nbsp;<img id=face src="<%=picurl%>Image1.gif">&nbsp;<a href=allface.asp target=_blank>查看所有头像</a>
</TR>
<tr bgcolor=<%=Tablebodycolor%>> 
<td width=40%><font color="<%=TableContentColor%>"><B>回复提示</B>：<BR>当您发表的帖子有人回复时，使用论坛信息通知您。</font></td>
<td width=60%><font color="<%=TableContentColor%>">
<input type="radio" name="showRe" value="1" checked>
提示我
<input type="radio" name="showRe" value="0">
不提示</font>
</tr>
<TR bgcolor=<%=Tablebodycolor%>> 
<TD width=40%><font color="<%=TableContentColor%>"><B>签名</B>：<BR>最多300字节<BR>
文字将出现在您发表的文章的结尾处。体现您的个性。</font> </TD>
<TD width=60%> 
<TEXTAREA name=Signature rows=5 wrap=PHYSICAL cols=60></TEXTAREA>
</TD>
</TR>
<!--tr>    
<td width="40%"><font color="<%=TableContentColor%>"><B>选择Cookie的保留时间</B>：<BR>登陆论坛信息保留时间，在这个时间内重复登陆论坛不需要重新登陆</font></td>  <td width="60%">    
			<font color="<%=TableContentColor%>">
              <input type="radio" name="usercookies" value="1" checked>
              <font color=red>1天</font> 
              <input type="radio" name="usercookies" value="2">
    1个月
    <input type="radio" name="usercookies" value="3">
    1年
              <input type="radio" name="usercookies" value="0">
    不保留 </font></td>   
      </tr-->
</TBODY> 
</TABLE>
</td></tr></table>
<script>
function showadv(){
if (document.theForm.advshow.checked == true) {
		adv.style.display = "";
		advance.innerText="关闭高级用户设置选项"
	}else{
		adv.style.display = "none";
		advance.innerText="显示高级用户设置选项"
	}
}		
</script>
<table cellpadding=0 cellspacing=0 border=0 width="<%=tablewidth%>" align=center>
<tr>
<td width=50% height=24><font color="<%=bodyfontColor%>"><INPUT id=advcheck name=advshow type=checkbox value=1 onclick=showadv()><span id="advance">显示高级用户设置选项</a></span></font> </td>
<td width=50%><input type=submit value="注 册" name=Submit><input type=reset value="清 除" name=Submit2></td>
</tr></table>
</form>
		<form name=preview action=chkreg.asp method=post target=preview_page>
		<input type=hidden name=username value=""><input type=hidden name=email value="">
		</form>
		<script>
		function gopreview()
		{
		document.forms[1].username.value=document.forms[0].name.value;
		document.forms[1].email.value=document.forms[0].e_mail.value;
		var popupWin = window.open('preview.asp', 'preview_page', 'scrollbars=yes,width=500,height=300');
		document.forms[1].submit()
		}
		</script>
<%end sub%>
<!--#include file="footer.asp"-->
