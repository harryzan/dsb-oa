<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!-- #include file="chkuser.asp" -->
<!-- #include file="inc/char.asp" -->
<!--#include file="inc/theme.asp"-->
<!--#include file="inc/grade.asp"-->
<%
    	Rem ----------------------
    	Rem ------主程序开始------
    	Rem ----------------------
	if boardid=0 then
	stats="论坛总帮助"
	else
	stats=BoardType & "版面帮助"
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
	REM 显示版面信息---Headinfo
	sub boardcolor()
%>
<table width="<%=TableWidth%>" border="0" cellspacing="1" cellpadding="3" align="center" bgcolor="<%=TableBackColor%>">
<tr bgcolor="<%=TablebodyColor%>"> 
    <td width="100%" align=center> <A HREF="#ubb">UBB语法</A> | <A HREF="#ubb1">UBB设置</A> 
    </td>
</tr>
  <tr bgcolor="<%=TableTitleColor%>"> 
    <td><b>C. <A name="ubb">UBB语法</A></b></td>
  </tr> 
  <tr bgcolor="<%=TablebodyColor%>"> 
    <td>
<p>论坛可以由管理员设置是否支持UBB标签，UBB标签就是不允许使用HTML语法的情况下，通过论坛的特殊转换程序，以至可以支持少量常用的、无危害性的HTML效果显示。以下为具体使用说明：
<p><font color=red>[B]</font><b>文字</b><font color=red>[/B]</font>：在文字的位置可以任意加入您需要的字符，显示为粗体效果。
<p><font color=red>[I]</font><i>文字</i><font color=red>[/I]</font>：在文字的位置可以任意加入您需要的字符，显示为斜体效果。
<p><font color=red>[U]</font><u>文字</u><font color=red>[/U]</font>：在文字的位置可以任意加入您需要的字符，显示为下划线效果。
<p><font color=red>[align=center]</font><div align=center>文字</div><font color=red>[/align]</font>：在文字的位置可以任意加入您需要的字符，center位置center表示居中，left表示居左，right表示居右。
<p><font color=red>[URL]</font><A HREF="">www.donghai-bridge.com.cn</A><font color=red>[/URL]</font>
      <P><font color=red></font><A HREF="www.donghai-bridge.com.cn">天兴洲工程建设信息网</A><font color=red>[/URL]</font>：有两种方法可以加入超级连接，可以连接具体地址或者文字连接。 
      <p><font color=red>[EMAIL]</font><A HREF="mailto:test@mmail.com">test@mmail.com</A><font color=red>[/EMAIL]</font>
<P><font color=red>[EMAIL=MAILTO:test@mail.com]</font><A HREF="test@mail.com">测试</A><font color=red>[/EMAIL]</font>：有两种方法可以加入邮件连接，可以连接具体地址或者文字连接。
<P><font color=red>[img]</font><img src=HTTP://WWW.DONGHAI-BRIDGE.COM.CN/images/*.gif><font color=red>[/img]</font>：在标签的中间插入图片地址可以实现插图效果。
<P><font color=red>[flash]</font>Flash连接地址<font color=red>[/Flash]</font>：在标签的中间插入Flash图片地址可以实现插入Flash。
<P><font color=red>[code]</font>文字<font color=red>[/code]</font>：在标签中写入文字可实现html中编号效果。
<P><font color=red>[quote]</font>引用<font color=red>[/quote]</font>：在标签的中间插入文字可以实现HTMl中引用文字效果。
<P><font color=red>[list]</font>文字<font color=red>[/list]</font> <font color=red>[list=a]</font>文字<font color=red>[/list]</font>  <font color=red>[list=1]</font>文字<font color=red>[/list]</font>：更改list属性标签，实现HTML目录效果。
<P><font color=red>[fly]</font>文字<font color=red>[/fly]</font>：在标签的中间插入文字可以实现文字飞翔效果，类似跑马灯。
<P><font color=red>[move]</font>文字<font color=red>[/move]</font>：在标签的中间插入文字可以实现文字移动效果，为来回飘动。
<P><font color=red>[glow=255,red,2]</font>文字<font color=red>[/glow]</font>：在标签的中间插入文字可以实现文字发光特效，glow内属性依次为宽度、颜色和边界大小。
<P><font color=red>[shadow=255,red,2]</font>文字<font color=red>[/shadow]</font>：在标签的中间插入文字可以实现文字阴影特效，shadow内属性依次为宽度、颜色和边界大小。
<P><font color=red>[color=颜色代码]</font>文字<font color=red>[/color]</font>：输入您的颜色代码，在标签的中间插入文字可以实现文字颜色改变。
<P><font color=red>[size=数字]</font>文字<font color=red>[/size]</font>：输入您的字体大小，在标签的中间插入文字可以实现文字大小改变。
<P><font color=red>[face=字体]</font>文字<font color=red>[/face]</font>：输入您需要的字体，在标签的中间插入文字可以实现文字字体转换。
<P><font color=red>[DIR=500,350]</font>http://<font color=red>[/DIR]</font>：为插入shockwave格式文件，中间的数字为宽度和长度
<P><font color=red>[RM=500,350]</font>http://<font color=red>[/RM]</font>：为插入realplayer格式的rm文件，中间的数字为宽度和长度
<P><font color=red>[MP=500,350]</font>http://<font color=red>[/MP]</font>：为插入为midia player格式的文件，中间的数字为宽度和长度
<P><font color=red>[QT=500,350]</font>http://<font color=red>[/QT]</font>：为插入为Quick time格式的文件，中间的数字为宽度和长度
	</td>
  </tr> 
  <tr bgcolor="<%=TableTitleColor%>"> 
    <td><b>D. <A name="ubb1">UBB设置</A></b></td>
  </tr> 
  <tr bgcolor="<%=TablebodyColor%>"> 
    <td>
&nbsp;&nbsp; 下面为本论坛的UBB语法设置，通过这些设置，您可以知道在本版面发言中有哪些语句是不能使用的，这里还包括了控制用户签名里使用的UBB选项。<BR>
&nbsp;&nbsp;<B>用户发贴</B>：
<ul>
<li>HTML标签： <%if strAllowHTML=0 then%>不可用<%else%>允许<%end if%>
<li>UBB标签： <%if strAllowForumCode=0 then%>不可用<%else%>允许<%end if%>
<li>帖图标签： <%if strIcons=0 then%>不可用<%else%>允许<%end if%>
<li>Flash标签： <%if strflash=0 then%>不可用<%else%>允许<%end if%>
<li>表情字符转换： <%if strIMGInPosts=0 then%>不可用<%else%>允许<%end if%>
<li>上传图片： <%if Uploadpic=0 then%>不可用<%else%>允许<%end if%>
<li>最多<%=AnnounceMaxBytes\1024%>KB</font></ul>
<BR>&nbsp;&nbsp;<B>用户签名</B>：
<ul>
<li>HTML标签： <%if UserHtmlCode=0 then%>不可用<%else%>允许<%end if%>
<li>UBB标签： <%if UserubbCode=0 then%>不可用<%else%>允许<%end if%>
<li>帖图标签(包括图片、flash、多媒体)： <%if UserImgCode=0 then%>不可用<%else%>允许<%end if%>
</ul>
说明：这里html标签指是否允许使用html语法，贴图和flash以及表情字符转换都属于UBB语法内容，其使用方法可查看UBB语法
	</td>
  </tr> 
</table>
<%
	end sub
%>
<!--#include file="footer.asp"-->
