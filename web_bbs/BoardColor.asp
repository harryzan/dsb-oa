<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!-- #include file="chkuser.asp" -->
<!-- #include file="inc/char.asp" -->
<!--#include file="inc/theme.asp"-->
<%
    	Rem ----------------------
    	Rem ------主程序开始------
    	Rem ----------------------
	if boardid=0 then
	stats="论坛总配色"
	else
	stats=BoardType & "配色"
	end if
	if viewcolor=0 then
	Errmsg=Errmsg+"<br>"+"<li>该版面配色未公开，请浏览其他版面！"
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
	REM 显示版面信息---Headinfo
	sub boardcolor()
%>
<table width="<%=TableWidth%>" border="0" cellspacing="1" cellpadding="3" align="center" bgcolor="<%=TableBackColor%>">
  <tr bgcolor="<%=TableTitleColor%>"> 
    <td colspan=3><b><img src="<%=picurl%>arrow1.gif" width="13" height="13"> 
      论坛BODY标签</b></td>
  </tr> 
<tr bgcolor="<%=TablebodyColor%>"> 
<td width="45%"><font color="<%=TableContentColor%>">
控制整个论坛风格的背景颜色或者背景图片等</font></td>
<td width="5%"></td>
<td width="50%"> 
<%=ForumBody%>
</td>
</tr>
<tr bgcolor="<%=aTablebodyColor%>"> 
<td width="45%" height=23><font color="<%=TableContentColor%>">
浏览器边框颜色</font></td>
<td width="5%" bgcolor="<%=IEBarcolor%>"></td>
<td width="50%"> 
<%=IEBarcolor%>
</td>
</tr>
  <tr bgcolor="<%=TableTitleColor%>"> 
    <td colspan=3><b><img src="<%=picurl%>arrow1.gif" width="13" height="13"> 
      论坛表格颜色</b></td>
  </tr> 
<tr bgcolor="<%=TablebodyColor%>"> 
<td width="45%" height=23><font color="<%=TableContentColor%>">论坛顶部菜单表格背景（深背景）</font></td>
<td width="5%" bgcolor="<%=NavDarkcolor%>"></td>
<td width="50%"> 
<%=NavDarkcolor%>
</td>
</tr>
<tr bgcolor="<%=aTablebodyColor%>"> 
<td width="45%" height=23><font color="<%=TableContentColor%>">论坛顶部菜单表格背景（浅背景）</font></td>
<td width="5%" bgcolor="<%=Navlighcolor%>"></td>
<td width="50%"> 
<%=Navlighcolor%>
</td>
</tr>
<tr bgcolor="<%=TablebodyColor%>"> 
<td width="45%" height=23><font color="<%=TableContentColor%>">表格边框颜色一（一般页面）</font></td>
<td width="5%" bgcolor="<%=Tablebackcolor%>"></td>
<td width="50%"> 
<%=Tablebackcolor%>
</td>
</tr>
<tr bgcolor="<%=aTablebodyColor%>"> 
<td width="45%" height=23><font color="<%=TableContentColor%>">表格边框颜色二
（特殊页面－－不常用）</font></td>
<td width="5%" bgcolor="<%=aTablebackcolor%>"></td>
<td width="50%"> 
<%=aTablebackcolor%>
</td>
</tr>
<tr bgcolor="<%=TablebodyColor%>"> 
<td width="45%" height=23><font color="<%=TableContentColor%>">表格标题栏颜色一（一般页面）</font></td>
<td width="5%" bgcolor="<%=Tabletitlecolor%>"></td>
<td width="50%"> 
<%=Tabletitlecolor%>
</td>
</tr>
<tr bgcolor="<%=aTablebodyColor%>"> 
<td width="45%" height=23><font color="<%=TableContentColor%>">表格标题栏颜色二（特殊页面－－不常用）</font></td>
<td width="5%" bgcolor="<%=aTabletitlecolor%>"></td>
<td width="50%"> 
<%=aTabletitlecolor%>
</td>
</tr>
<tr bgcolor="<%=TablebodyColor%>"> 
<td width="45%" height=23><font color="<%=TableContentColor%>">表格背景颜色一</font></td>
<td width="5%" bgcolor="<%=Tablebodycolor%>"></td>
<td width="50%"> 
<%=Tablebodycolor%>
</td>
</tr>
<tr bgcolor="<%=aTablebodyColor%>"> 
<td width="45%" height=23><font color="<%=TableContentColor%>">表格背景颜色二（1和2颜色在表格中穿插显示）</font></td>
<td width="5%" bgcolor="<%=aTablebodycolor%>"></td>
<td width="50%"> 
<%=aTablebodycolor%>
</td>
</tr>
  <tr bgcolor="<%=TableTitleColor%>"> 
    <td colspan=3><b><img src="<%=picurl%>arrow1.gif" width="13" height="13"> 
      论坛字体颜色</b></td>
  </tr> 
<tr bgcolor="<%=TablebodyColor%>"> 
<td width="45%" height=23><font color="<%=TableContentColor%>">表格标题栏字体颜色</font></td>
<td width="5%" bgcolor="<%=TableFontcolor%>"></td>
<td width="50%"> 
<%=TableFontcolor%>
</td>
</tr>
<tr bgcolor="<%=aTablebodyColor%>"> 
<td width="45%" height=23><font color="<%=TableContentColor%>">表格内容栏字体颜色</font></td>
<td width="5%" bgcolor="<%=TableContentcolor%>"></td>
<td width="50%"> 
<%=TableContentcolor%>
</td>
</tr>
<tr bgcolor="<%=TablebodyColor%>"> 
<td width="45%" height=23><font color="<%=TableContentColor%>">警告提醒语句的颜色</font></td>
<td width="5%" bgcolor="<%=AlertFontColor%>"></td>
<td width="50%"> 
<%=AlertFontColor%>
</td>
</tr>
<tr bgcolor="<%=aTablebodyColor%>"> 
<td width="45%" height=23><font color="<%=TableContentColor%>">显示帖子的时候，相关帖子，转发帖子，回复等的颜色</font></td>
<td width="5%" bgcolor="<%=ContentTitle%>"></td>
<td width="50%"> 
<%=ContentTitle%>
</td>
</tr>
<tr bgcolor="<%=TablebodyColor%>"> 
<td width="45%" height=23><font color="<%=TableContentColor%>">网页字体颜色（表格外）</font></td>
<td width="5%" bgcolor="<%=BodyFontColor%>"></td>
<td width="50%"> 
<%=BodyFontColor%>
</td>
</tr>
<tr bgcolor="<%=aTablebodyColor%>"> 
<td width="45%" height=23><font color="<%=TableContentColor%>">首页连接颜色</font></td>
<td width="5%" bgcolor="<%=BoardLinkColor%>"></td>
<td width="50%"> 
<%=BoardLinkColor%>
</td>
</tr>
<tr bgcolor="<%=TablebodyColor%>"> 
<td width="45%" height=23><font color="<%=TableContentColor%>">一般用户名称字体颜色</font></td>
<td width="5%" bgcolor="<%=user_fc%>"></td>
<td width="50%"> 
<%=user_fc%>
</td>
</tr>
<tr bgcolor="<%=aTablebodyColor%>"> 
<td width="45%" height=23><font color="<%=TableContentColor%>">一般用户名称上的光晕颜色</font></td>
<td width="5%" bgcolor="<%=user_mc%>"></td>
<td width="50%"> 
<%=user_mc%>
</td>
</tr>
<tr bgcolor="<%=TablebodyColor%>"> 
<td width="45%" height=23><font color="<%=TableContentColor%>">版主名称字体颜色</font></td>
<td width="5%" bgcolor="<%=bmaster_fc%>"></td>
<td width="50%"> 
<%=bmaster_fc%>
</td>
</tr>
<tr bgcolor="<%=aTablebodyColor%>"> 
<td width="45%" height=23><font color="<%=TableContentColor%>">版主名称上的光晕颜色</font></td>
<td width="5%" bgcolor="<%=bmaster_mc%>"></td>
<td width="50%"> 
<%=bmaster_mc%>
</td>
</tr>
<tr bgcolor="<%=TablebodyColor%>"> 
<td width="45%" height=23><font color="<%=TableContentColor%>">管理员名称字体颜色</font></td>
<td width="5%" bgcolor="<%=master_fc%>"></td>
<td width="50%"> 
<%=master_fc%>
</td>
</tr>
<tr bgcolor="<%=aTablebodyColor%>"> 
<td width="45%" height=23><font color="<%=TableContentColor%>">版主名称上的光晕颜色</font></td>
<td width="5%" bgcolor="<%=master_mc%>"></td>
<td width="50%"> 
<%=master_mc%>
</td>
</tr>
<tr bgcolor="<%=TablebodyColor%>"> 
<td width="45%" height=23><font color="<%=TableContentColor%>">贵宾名称字体颜色</font></td>
<td width="5%" bgcolor="<%=vip_fc%>"></td>
<td width="50%"> 
<%=vip_fc%>
</td>
</tr>
<tr bgcolor="<%=aTablebodyColor%>"> 
<td width="45%" height=23><font color="<%=TableContentColor%>">贵宾名称上的光晕颜色</font></td>
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
