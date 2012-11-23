<!--#include file =conn.asp-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=chkuser.asp-->
<title><%=ForumName%>--管理页面</title>
<!--#include file="Forum_css.asp"-->
<meta NAME=GENERATOR Content=""Microsoft FrontPage 3.0"" CHARSET=GB2312>
<BODY <%=ForumBody%>>
<%
	if not master or instr(session("flag"),"23")=0 then
		Errmsg=Errmsg+"<br>"+"<li>本页面为管理员专用，请<a href=admin_index.asp target=_top>登陆</a>后进入。<br><li>您没有管理本页面的权限。"
		call Error()
	else
		call main()
		conn.close
		set conn=nothing
	end if

	sub main()
%>
<table cellpadding=0 cellspacing=0 border=0 width=<%=tablewidth%> bgcolor=<%=tablebackcolor%> align=center>
  <tr>
    <td>
      <table cellpadding=3 cellspacing=1 border=0 width=100%>
        <tr bgcolor='<%=Tabletitlecolor%>'>
        <td align=center colspan="2"><font color="<%=TablefontColor%>">欢迎<b><%=membername%></b>进入管理页面</font>
        </td>
        </tr>
            <tr  bgcolor="<%=Tablebodycolor%>">
              <td width="100%" valign=top><font color="<%=TableContentColor%>">
<%
if request("action")="save" then
call saveconst()
else
call consted()
end if
if founderr then call error()
%></font>
	      </td>
            </tr>
        </table>
        </td>
    </tr>
</table>
<%
end sub

sub consted()
dim sel
%>
<form method="POST" action=admin_color.asp?action=save>
<table width="95%" border="0" cellspacing="1" cellpadding="3"  align=center bordercolor=<%=aTablebackcolor%>>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td height="23" colspan="3" ><font color="<%=TableContentColor%>"><B>说明</B>：<BR>1、复选框中选择的为当前的使用设置模板，点击可查看该模板设置，点击别的模板直接查看该模板并修改设置。您可以将您下面的设置保存在多个论坛风格模板中<BR>2、您也可以将下面设定的信息保存并应用到具体的分论坛设置中，可多选<BR>3、如果您想在一个版面引用别的版面或模板的配置，只要点击该版面或模板名称，保存的时候选择要保存到的版面名称或模板名称即可。</font></td>
</tr>
<tr> 
<td width="100%" colspan=3 bgcolor="<%=Tablebodycolor%>"><font color="<%=TableContentColor%>"><B>当前使用主模板</B>（可将设置保存到下列模板中）<BR>
<%
set rs = server.CreateObject ("adodb.recordset")
sql="select * from config"
rs.open sql,conn,1,1
do while not rs.eof
if request("skinid")="" then
	if request("boardid")="" then
	if rs("active")=1 then
	sel="checked"
	else
	sel=""
	end if
	else
	sel=""
	end if
else
	if rs("id")=cint(request("skinid")) then
	sel="checked"
	else
	sel=""
	end if
end if
response.write "<input type=checkbox name=skinid value="&rs("id")&" "&sel&"><a href=admin_color.asp?skinid="&rs("id")&"><font color="&TableContentColor&">"&rs("skinname")&"</font></a>&nbsp;"
rs.movenext
loop
rs.close
set rs=nothing
%></font>
</td></tr>
<tr> 
<td width="100%" colspan=3 bgcolor="<%=Tablebodycolor%>"><font color="<%=TableContentColor%>"><B>当前使用分论坛模板</B>（可将设置保存到下列论坛中）<BR>
<%
set rs = server.CreateObject ("adodb.recordset")
sql="select * from board"
rs.open sql,conn,1,1
do while not rs.eof
if request("boardid")<>"" or isnumeric(request("boardid")) then
if rs("boardid")=cint(request("boardid")) then
sel="checked"
else
sel=""
end if
end if
response.write "<input type=checkbox name=boardid value="&rs("boardid")&" "&sel&"><a href=admin_color.asp?boardid="&rs("boardid")&"><font color="&TableContentColor&">" & rs("boardtype") & "</font></a>&nbsp;"
rs.movenext
loop
rs.close
set rs=nothing
%></font>
</td></tr>
<script>
function color(para_URL){var URL =new String(para_URL)
window.open(URL,'','width=300,height=220,noscrollbars')}
</SCRIPT>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td height="23" colspan="3" ><font color="<%=TableContentColor%>"><b>论坛界面设置</b></font>&nbsp;单击 <a href="javascript:color('color.asp')"><font color="<%=TableContentColor%>">这里</font></a> 使用万用颜色拾取器</td>
</tr>
<tr bgcolor="<%=Tablebodycolor%>"> 
<td width="45%"><font color="<%=TableContentColor%>"><B>论坛BODY标签</B><br>
控制整个论坛风格的背景颜色或者背景图片等</font></td>
<td width="5%"></td>
<td width="50%"> 
<input type="text" name="ForumBody" size="35" value="<%=ForumBody%>">
</td>
</tr>
<tr bgcolor="<%=Tablebodycolor%>"> 
<td width="45%"><font color="<%=TableContentColor%>"><B>浏览器边框颜色</B></font></td>
<td width="5%" bgcolor="<%=IEbarcolor%>"></td>
<td width="50%"> 
<input type="text" name="iebarcolor" size="35" value="<%=iebarcolor%>">
</td>
</tr>
<tr bgcolor="<%=Tablebodycolor%>"> 
<td width="45%"><font color="<%=TableContentColor%>"><B>顶部菜单表格背景(深背景)</B></font></td>
<td width="5%" bgcolor="<%=NavDarkcolor%>"></td>
<td width="50%"> 
<input type="text" name="NavDarkcolor" size="35" value="<%=NavDarkcolor%>">
</td>
</tr>
<tr bgcolor="<%=Tablebodycolor%>"> 
<td width="45%"><font color="<%=TableContentColor%>"><B>顶部菜单表格背景(浅背景)</B></font></td>
<td width="5%" bgcolor="<%=Navlighcolor%>"></td>
<td width="50%"> 
<input type="text" name="Navlighcolor" size="35" value="<%=Navlighcolor%>">
</td>
</tr>
<tr bgcolor="<%=Tablebodycolor%>"> 
<td width="45%"><font color="<%=TableContentColor%>"><B>表格边框颜色一</B><br>
一般页面</font></td>
<td width="5%" bgcolor="<%=Tablebackcolor%>"></td>
<td width="50%"> 
<input type="text" name="Tablebackcolor" size="35" value="<%=Tablebackcolor%>">
</td>
</tr>
<tr bgcolor="<%=Tablebodycolor%>"> 
<td width="45%"><font color="<%=TableContentColor%>"><B>表格边框颜色二</B><br>
用户页面、提示页面</font></td>
<td width="5%" bgcolor="<%=aTablebackcolor%>"></td>
<td width="50%"> 
<input type="text" name="aTablebackcolor" size="35" value="<%=aTablebackcolor%>">
</td>
</tr>
<tr bgcolor="<%=Tablebodycolor%>"> 
<td width="45%"><font color="<%=TableContentColor%>"><B>标题表格颜色一（深背景）</B><br>
一般页面</font></td>
<td width="5%" bgcolor="<%=Tabletitlecolor%>"></td>
<td width="50%"> 
<input type="text" name="Tabletitlecolor" size="35" value="<%=Tabletitlecolor%>">
</td>
</tr>
<tr bgcolor="<%=Tablebodycolor%>"> 
<td width="45%"><font color="<%=TableContentColor%>"><B>标题表格颜色二（浅背景）</B><br>
用户页面、提示页面</font></td>
<td width="5%" bgcolor="<%=aTabletitlecolor%>"></td>
<td width="50%"> 
<input type="text" name="aTabletitlecolor" size="35" value="<%=aTabletitlecolor%>">
</td>
</tr>
<tr bgcolor="<%=Tablebodycolor%>"> 
<td width="45%"><font color="<%=TableContentColor%>"><B>表格体颜色一</B></font></td>
<td width="5%" bgcolor="<%=Tablebodycolor%>"></td>
<td width="50%"> 
<input type="text" name="Tablebodycolor" size="35" value="<%=Tablebodycolor%>">
</td>
</tr>
<tr bgcolor="<%=Tablebodycolor%>"> 
<td width="45%"><font color="<%=TableContentColor%>"><B>表格体颜色二</B>(1和2颜色在首页显示中穿插)</font></td>
<td width="5%" bgcolor="<%=aTablebodycolor%>"></td>
<td width="50%"> 
<input type="text" name="aTablebodycolor" size="35" value="<%=aTablebodycolor%>">
</td>
</tr>
<tr bgcolor="<%=Tablebodycolor%>"> 
<td width="45%"><font color="<%=TableContentColor%>"><B>表格标题栏字体颜色</B></font></td>
<td width="5%" bgcolor="<%=TableFontcolor%>"></td>
<td width="50%"> 
<input type="text" name="TableFontcolor" size="35" value="<%=TableFontcolor%>">
</td>
</tr>
<tr bgcolor="<%=Tablebodycolor%>"> 
<td width="45%"><font color="<%=TableContentColor%>"><B>表格内容栏字体颜色</B></font></td>
<td width="5%" bgcolor="<%=TableContentcolor%>"></td>
<td width="50%"> 
<input type="text" name="TableContentcolor" size="35" value="<%=TableContentcolor%>">
</td>
</tr>
<tr bgcolor="<%=Tablebodycolor%>"> 
<td width="45%"><font color="<%=TableContentColor%>"><B>警告提醒语句的颜色</B></font></td>
<td width="5%" bgcolor="<%=AlertFontColor%>"></td>
<td width="50%"> 
<input type="text" name="AlertFontColor" size="35" value="<%=AlertFontColor%>">
</td>
</tr>
<tr bgcolor="<%=Tablebodycolor%>"> 
<td width="45%"><font color="<%=TableContentColor%>"><B>显示帖子的时候，相关帖子，转发帖子，回复等的颜色</B></font></td>
<td width="5%" bgcolor="<%=ContentTitle%>"></td>
<td width="50%"> 
<input type="text" name="ContentTitle" size="35" value="<%=ContentTitle%>">
</td>
</tr>
<tr bgcolor="<%=Tablebodycolor%>"> 
<td width="45%"><font color="<%=TableContentColor%>"><B>网页字体颜色（表格外）</B></font></td>
<td width="5%" bgcolor="<%=BodyFontColor%>"></td>
<td width="50%"> 
<input type="text" name="BodyFontColor" size="35" value="<%=BodyFontColor%>">
</td>
</tr>
<tr bgcolor="<%=Tablebodycolor%>"> 
<td width="45%"><font color="<%=TableContentColor%>"><B>首页连接颜色</B><BR>如版面连接</font></td>
<td width="5%" bgcolor="<%=BoardLinkColor%>"></td>
<td width="50%"> 
<input type="text" name="BoardLinkColor" size="35" value="<%=BoardLinkColor%>">
</td>
</tr>
<tr bgcolor="<%=Tablebodycolor%>"> 
<td width="45%"><font color="<%=TableContentColor%>"><B>表格宽度</B></font></td>
<td width="5%"></td>
<td width="50%"> 
<input type="text" name="tablewidth" size="35" value="<%=tablewidth%>">
</td>
</tr>
<tr bgcolor="<%=Tablebodycolor%>"> 
<td width="45%"><font color="<%=TableContentColor%>"><B>一般用户名称字体颜色</B></font></td>
<td width="5%" bgcolor="<%=user_fc%>"></td>
<td width="50%"> 
<input type="text" name="user_fc" size="35" value="<%=user_fc%>">
</td>
</tr>
<tr bgcolor="<%=Tablebodycolor%>"> 
<td width="45%"><font color="<%=TableContentColor%>"><B>一般用户名称上的光晕颜色</B></font></td>
<td width="5%" bgcolor="<%=user_mc%>"></td>
<td width="50%"> 
<input type="text" name="user_mc" size="35" value="<%=user_mc%>">
</td>
</tr>
<tr bgcolor="<%=Tablebodycolor%>"> 
<td width="45%"><font color="<%=TableContentColor%>"><B>版主名称字体颜色</B></font></td>
<td width="5%" bgcolor="<%=bmaster_fc%>"></td>
<td width="50%"> 
<input type="text" name="bmaster_fc" size="35" value="<%=bmaster_fc%>">
</td>
</tr>
<tr bgcolor="<%=Tablebodycolor%>"> 
<td width="45%"><font color="<%=TableContentColor%>"><B>版主名称上的光晕颜色</B></font></td>
<td width="5%" bgcolor="<%=bmaster_mc%>"></td>
<td width="50%"> 
<input type="text" name="bmaster_mc" size="35" value="<%=bmaster_mc%>">
</td>
</tr>
<tr bgcolor="<%=Tablebodycolor%>"> 
<td width="45%"><font color="<%=TableContentColor%>"><B>管理员名称字体颜色</B></font></td>
<td width="5%" bgcolor="<%=master_fc%>"></td>
<td width="50%"> 
<input type="text" name="master_fc" size="35" value="<%=master_fc%>">
</td>
</tr>
<tr bgcolor="<%=Tablebodycolor%>"> 
<td width="45%"><font color="<%=TableContentColor%>"><B>版主名称上的光晕颜色</B></font></td>
<td width="5%" bgcolor="<%=master_mc%>"></td>
<td width="50%"> 
<input type="text" name="master_mc" size="35" value="<%=master_mc%>">
</td>
</tr>
<tr bgcolor="<%=Tablebodycolor%>"> 
<td width="45%"><font color="<%=TableContentColor%>"><B>贵宾名称字体颜色</B></font></td>
<td width="5%" bgcolor="<%=vip_fc%>"></td>
<td width="50%"> 
<input type="text" name="vip_fc" size="35" value="<%=vip_fc%>">
</td>
</tr>
<tr bgcolor="<%=Tablebodycolor%>"> 
<td width="45%"><font color="<%=TableContentColor%>"><B>贵宾名称上的光晕颜色</B></font></td>
<td width="5%" bgcolor="<%=vip_mc%>"></td>
<td width="50%"> 
<input type="text" name="vip_mc" size="35" value="<%=vip_mc%>">
</td>
</tr>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td width="45%">&nbsp;</td>
<td width="5%"></td>
<td width="50%"> 
<div align="center"> 
<input type="submit" name="Submit" value="提 交">
</div>
</td>
</tr>
</table>
</form>
<%
end sub

sub saveconst()
dim Forum_body
if trim(request("skinid"))="" and trim(request("boardid"))="" then
Founderr=true
Errmsg=Errmsg+"<br>"+"<li>请选择保存的模板名称"
else
Forum_body=request.form("Tablebackcolor") & "," & request.form("aTablebackcolor") & "," & request.form("Tabletitlecolor") & "," & request.form("aTabletitlecolor") & "," & request.form("Tablebodycolor") & "," & request.form("aTablebodycolor") & "," & request.form("TableFontcolor") & "," & request.form("TableContentcolor") & "," & request.form("AlertFontColor") & "," & request.form("ContentTitle") & "," & request.form("AlertFontColor") & "," & request.form("ForumBody") & "," & request.form("TableWidth") & "," & request.form("BodyFontColor") & "," & request.form("BoardLinkColor") & "," & request.form("user_fc") & "," & request.form("user_mc") & "," & request.form("bmaster_fc") & "," & request.form("bmaster_mc") & "," & request.form("master_fc") & "," & request.form("master_mc") & "," & request.form("vip_fc") & "," & request.form("vip_mc") & "," & request.form("NavLighColor") & "," & request.form("NavDarkColor") & "," & request.form("IEbarColor")
'response.write Forum_body
if request("skinid")<>"" then
sql = "update config set Forum_body='"&Forum_body&"' where id in ( "&request("skinid")&" )"
conn.execute(sql)
end if
if request("boardid")<>"" then
sql = "update board set Forum_body='"&Forum_body&"' where boardid in ( "&request("boardid")&" )"
conn.execute(sql)
end if
response.write "设置成功。"
end if
end sub
%>