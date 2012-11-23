<!--#include file =conn.asp-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=chkuser.asp-->
<title><%=ForumName%>--管理页面</title>
<!--#include file="Forum_css.asp"-->
<meta NAME=GENERATOR Content=""Microsoft FrontPage 3.0"" CHARSET=GB2312>
<BODY  <%=ForumBody%>>
<%
	if not master or instr(session("flag"),"25")=0 then
		Errmsg=Errmsg+"<br>"+"<li>本页面为管理员专用，请<a href=admin_index.asp target=_top>登陆</a>后进入。<br><li>您没有管理本页面的权限。"
		call Error()
	else
		call main()
		conn.close
		set conn=nothing
	end if

	sub main()
%>
<table cellpadding=0 cellspacing=0 border=0 width=<%=Tablewidth%> bgcolor=<%=tablebackcolor%> align=center>
  <tr>
    <td>
      <table cellpadding=3 cellspacing=1 border=0 width=100%>
        <tr bgcolor='<%=Tabletitlecolor%>'>
        <td align=center colspan="2"><font color="<%=tablefontcolor%>">欢迎<b><%=membername%></b>进入管理页面</font>
        </td>
        </tr>
            <tr bgcolor="<%=tablebodycolor%>">
              <td width="100%" valign=top><font color=<%=TableContentColor%>>
<%
if request("action")="save" then
call saveconst()
else
call consted()
end if
if founderr then call error()
%>
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
<form method="POST" action=admin_ads.asp?action=save>
<table width="95%" border="0" cellspacing="1" cellpadding="3"  align=center bordercolor=<%=aTablebackcolor%>>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td height="23" colspan="2" ><font color=<%=TableContentColor%>><B>说明</B>：<BR>1、复选框中选择的为当前的使用设置模板，点击可查看该模板设置，点击别的模板直接查看该模板并修改设置。您可以将您下面的设置保存在多个论坛风格模板中<BR>2、您也可以将下面设定的信息保存并应用到具体的分论坛设置中，可多选<BR>3、如果您想在一个版面引用别的版面或模板的配置，只要点击该版面或模板名称，保存的时候选择要保存到的版面名称或模板名称即可。</font></td>
</tr>
<tr> 
<td width="100%" colspan=2><font color=<%=TableContentColor%>><B>当前使用主模板</B>（可将设置保存到下列模板中）<BR>
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
response.write "<input type=checkbox name=skinid value="&rs("id")&" "&sel&"><a href=admin_ads.asp?skinid="&rs("id")&"><font color="&TableContentColor&">"&rs("skinname")&"</font></a>&nbsp;"
rs.movenext
loop
rs.close
set rs=nothing
%></font>
</td></tr>
<tr> 
<td width="100%" colspan=2><font color=<%=TableContentColor%>><B>当前使用分论坛模板</B>（可将设置保存到下列论坛中）<BR>
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
response.write "<input type=checkbox name=boardid value="&rs("boardid")&" "&sel&"><a href=admin_ads.asp?boardid="&rs("boardid")&"><font color="&TableContentColor&">" & rs("boardtype") & "</font></a>&nbsp;"
rs.movenext
loop
rs.close
set rs=nothing
%></font>
</td></tr>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td height="23" colspan="2" ><font color=<%=TableContentColor%>><b>论坛广告设置</b>（如为设置分论坛，就是分论坛首页广告，下属页面为帖子显示页面）</font></td>
</tr>
<tr> 
<td width="40%"><font color=<%=TableContentColor%>><B>首页顶部广告代码</B></font></td>
<td width="60%"> <font color=<%=TableContentColor%>>
<textarea name="index_ad_t" cols="50" rows="3"><%=index_ad_t%></textarea>
</td>
</tr>
<tr> 
<td width="40%"><font color=<%=TableContentColor%>><B>首页尾部广告代码</B></font></td>
<td width="60%"> <font color=<%=TableContentColor%>>
<textarea name="index_ad_f" cols="50" rows="3"><%=index_ad_f%></textarea>
</td>
</tr>
<tr> 
<td width="40%"><font color=<%=TableContentColor%>><B>开启首页浮动广告</B></font></td>
<td width="60%"> <font color=<%=TableContentColor%>>
<input type=radio name="index_moveFlag" value=0 <%if index_moveFlag=0 then%>checked<%end if%>>关闭&nbsp;
<input type=radio name="index_moveFlag" value=1 <%if index_moveFlag=1 then%>checked<%end if%>>打开&nbsp;
</td>
</tr>
<tr> 
<td width="40%"><font color=<%=TableContentColor%>><B>论坛首页浮动广告图片地址</B></font></td>
<td width="60%"> <font color=<%=TableContentColor%>>
<input type="text" name="MovePic" size="35" value="<%=MovePic%>">
</td>
</tr>
<tr> 
<td width="40%"><font color=<%=TableContentColor%>><B>论坛首页浮动广告连接地址</B></font></td>
<td width="60%"> <font color=<%=TableContentColor%>>
<input type="text" name="MoveUrl" size="35" value="<%=MoveUrl%>">
</td>
</tr>
<tr> 
<td width="40%"><font color=<%=TableContentColor%>><B>论坛首页浮动广告图片宽度</B></font></td>
<td width="60%"> <font color=<%=TableContentColor%>>
<input type="text" name="move_w" size="3" value="<%=move_w%>">&nbsp;象素
</td>
</tr>
<tr> 
<td width="40%"><font color=<%=TableContentColor%>><B>论坛首页浮动广告图片高度</B></font></td>
<td width="60%"> <font color=<%=TableContentColor%>>
<input type="text" name="move_h" size="3" value="<%=move_h%>">&nbsp;象素
</td>
</tr>
<input type=hidden name="Board_moveFlag" value=0>
<tr> 
<td width="40%"><font color=<%=TableContentColor%>><B>开启首页右下固定广告</B></font></td>
<td width="60%"> <font color=<%=TableContentColor%>>
<input type=radio name="index_fixupFlag" value=0 <%if index_fixupFlag=0 then%>checked<%end if%>>关闭&nbsp;
<input type=radio name="index_fixupFlag" value=1 <%if index_fixupFlag=1 then%>checked<%end if%>>打开&nbsp;
</td>
</tr>
<tr> 
<td width="40%"><font color=<%=TableContentColor%>><B>论坛首页右下固定广告图片地址</B></font></td>
<td width="60%"> <font color=<%=TableContentColor%>>
<input type="text" name="fixupPic" size="35" value="<%=fixupPic%>">
</td>
</tr>
<tr> 
<td width="40%"><font color=<%=TableContentColor%>><B>论坛首页右下固定广告连接地址</B></font></td>
<td width="60%"> <font color=<%=TableContentColor%>>
<input type="text" name="fixupUrl" size="35" value="<%=fixupUrl%>">
</td>
</tr>
<tr> 
<td width="40%"><font color=<%=TableContentColor%>><B>论坛首页右下固定广告图片宽度</B></font></td>
<td width="60%"> <font color=<%=TableContentColor%>>
<input type="text" name="fixup_w" size="3" value="<%=fixup_w%>">&nbsp;象素
</td>
</tr>
<tr> 
<td width="40%"><font color=<%=TableContentColor%>><B>论坛首页右下固定广告图片高度</B></font></td>
<td width="60%"> <font color=<%=TableContentColor%>>
<input type="text" name="fixup_h" size="3" value="<%=fixup_h%>">&nbsp;象素
</td>
</tr>
<input type=hidden name="Board_fixupFlag" value=0>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td width="40%"><font color=<%=TableContentColor%>>&nbsp;</td>
<td width="60%"> <font color=<%=TableContentColor%>>
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
dim Forum_ads
if trim(request("skinid"))="" and trim(request("boardid"))="" then
Founderr=true
Errmsg=Errmsg+"<br>"+"<li>请选择保存的模板名称"
else
Forum_ads=request("index_ad_t") & "$" & request("index_ad_f") & "$" & request("index_moveFlag") & "$" & request("MovePic") & "$" & request("MoveUrl") & "$" & request("move_w") & "$" & request("move_h") & "$" & request("Board_moveFlag") & "$" & request("fixupPic") & "$" & request("FixupUrl") & "$" & request("Fixup_w") & "$" & request("Fixup_h") & "$" & request("Board_fixupFlag") & "$" & request("index_fixupFlag")
'response.write Forum_ads
if request("skinid")<>"" then
sql = "update config set Forum_ads='"&CheckStr(Forum_ads)&"' where id in ( "&request("skinid")&" )"
conn.execute(sql)
end if
if request("boardid")<>"" then
sql = "update board set Forum_ads='"&CheckStr(Forum_ads)&"' where boardid in ( "&request("boardid")&" )"
conn.execute(sql)
end if
response.write "设置成功。"
end if
end sub
%>