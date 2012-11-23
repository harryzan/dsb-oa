<!--#include file=conn.asp-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=inc/grade.asp-->
<!--#include file=chkuser.asp-->
<title><%=ForumName%>--管理页面</title>
<!--#include file="Forum_css.asp"-->

<BODY <%=ForumBody%>>
<%
	if not master or instr(session("flag"),"13")=0 then
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
        <td><font color="<%=TablefontColor%>">欢迎<b><%=membername%></b>进入管理页面</font>
        </td>
        </tr>
            <tr bgcolor=<%=tablebodycolor%>>
              <td width="100%" valign=top><font color="<%=TablefontColor%>">
<%
if request("action")="save" then
call savegrade()
else
call grade()
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

sub grade()
dim sel
%>
<form method="POST" action=admin_wealth.asp?action=save>
<table width="95%" border="0" cellspacing="1" cellpadding="3"  align=center bordercolor=<%=aTablebackcolor%>>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td height="23" colspan="2" ><font color="<%=TableContentColor%>"><B>说明</B>：<BR>1、复选框中选择的为当前的使用设置模板，点击可查看该模板设置，点击别的模板直接查看该模板并修改设置。您可以将您下面的设置保存在多个论坛风格模板中<BR>2、您也可以将下面设定的信息保存并应用到具体的分论坛设置中，可多选<BR>3、如果您想在一个版面引用别的版面或模板的配置，只要点击该版面或模板名称，保存的时候选择要保存到的版面名称或模板名称即可。</font></td>
</tr>
<tr> 
<td width="100%" colspan=2><font color="<%=TableContentColor%>"><B>当前使用主模板</B>（可将设置保存到下列模板中）<BR>
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
response.write "<input type=checkbox name=skinid value="&rs("id")&" "&sel&"><a href=admin_wealth.asp?skinid="&rs("id")&"><font color="&TablecontentColor&">"&rs("skinname")&"</font></a>&nbsp;"
rs.movenext
loop
rs.close
set rs=nothing
%></font>
</td></tr>
<tr> 
<td width="100%" colspan=2><font color="<%=TableContentColor%>"><B>当前使用分论坛模板</B>（可将设置保存到下列论坛中）<BR>
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
response.write "<input type=checkbox name=boardid value="&rs("boardid")&" "&sel&"><a href=admin_wealth.asp?boardid="&rs("boardid")&"><font color="&TablecontentColor&">" & rs("boardtype") & "</font></a>&nbsp;"
rs.movenext
loop
rs.close
set rs=nothing
%></font>
</td></tr>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td height="23" colspan="2" ><font color="<%=TableContentColor%>"><b>用户金钱设定</b></font></td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>">注册金钱数</td>
<td width="60%"> 
<input type="text" name="wealthReg" size="35" value="<%=wealthReg%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>">登陆增加金钱</td>
<td width="60%"> 
<input type="text" name="wealthLogin" size="35" value="<%=wealthLogin%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>">发帖增加金钱</td>
<td width="60%"> 
<input type="text" name="wealthAnnounce" size="35" value="<%=wealthAnnounce%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>">跟帖增加金钱</td>
<td width="60%"> 
<input type="text" name="wealthReannounce" size="35" value="<%=wealthReannounce%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>">精华增加金钱</td>
<td width="60%"> 
<input type="text" name="BestWealth" size="35" value="<%=BestWealth%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>">删帖减少金钱</td>
<td width="60%"> 
<input type="text" name="wealthDel" size="35" value="<%=wealthDel%>">
</td>
</tr>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td height="23" colspan="2" ><font color=<%=TableFontcolor%>><b>用户经验设定</b></font></td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>">注册经验值</td>
<td width="60%"> 
<input type="text" name="epReg" size="35" value="<%=epReg%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>">登陆增加经验值</td>
<td width="60%"> 
<input type="text" name="epLogin" size="35" value="<%=epLogin%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>">发帖增加经验值</td>
<td width="60%"> 
<input type="text" name="epAnnounce" size="35" value="<%=epAnnounce%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>">跟帖增加经验值</td>
<td width="60%"> 
<input type="text" name="epReannounce" size="35" value="<%=epReannounce%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>">精华增加经验值</td>
<td width="60%"> 
<input type="text" name="bestuserep" size="35" value="<%=bestuserep%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>">删帖减少经验值</td>
<td width="60%"> 
<input type="text" name="epDel" size="35" value="<%=epDel%>">
</td>
</tr>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td height="23" colspan="2" ><font color=<%=TableFontcolor%>><b>用户魅力设定</b></font></td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>">注册魅力值</td>
<td width="60%"> 
<input type="text" name="cpReg" size="35" value="<%=cpReg%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>">登陆增加魅力值</td>
<td width="60%"> 
<input type="text" name="cpLogin" size="35" value="<%=cpLogin%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>">发帖增加魅力值</td>
<td width="60%"> 
<input type="text" name="cpAnnounce" size="35" value="<%=cpAnnounce%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>">跟帖增加魅力值</td>
<td width="60%"> 
<input type="text" name="cpReannounce" size="35" value="<%=cpReannounce%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>">精华增加魅力值</td>
<td width="60%"> 
<input type="text" name="bestusercp" size="35" value="<%=bestusercp%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>">删帖减少魅力值</td>
<td width="60%"> 
<input type="text" name="cpDel" size="35" value="<%=cpDel%>">
</td>
</tr>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td width="40%"><font color="<%=TableContentColor%>">&nbsp;</td>
<td width="60%"> 
<div align="center"> 
<input type="submit" name="Submit" value="提 交">
</div>
</td>
</tr>
</table>
</form>
<%
end sub

sub savegrade()
dim forum_user
if trim(request("skinid"))="" and trim(request("boardid"))="" then
Founderr=true
Errmsg=Errmsg+"<br>"+"<li>请选择保存的模板名称"
else
Forum_user=request.form("wealthReg") & "," & request.form("wealthAnnounce") & "," & request.form("wealthReannounce") & "," & request.form("wealthDel") & "," & request.form("wealthLogin") & "," & request.form("epReg") & "," & request.form("epAnnounce") & "," & request.form("epReannounce") & "," & request.form("epDel") & "," & request.form("epLogin") & "," & request.form("cpReg") & "," & request.form("cpAnnounce") & "," & request.form("cpReannounce") & "," & request.form("cpDel") & "," & request.form("cpLogin") & "," & request.form("BestWealth") & "," & request.form("BestuserCP") & "," & request.form("BestuserEP")
'response.write Forum_user
if request("skinid")<>"" then
sql = "update config set Forum_user='"&Forum_user&"' where id in ( "&request("skinid")&" )"
conn.execute(sql)
end if
if request("boardid")<>"" then
sql = "update board set Forum_user='"&Forum_user&"' where boardid in ( "&request("boardid")&" )"
conn.execute(sql)
end if
response.write "设置成功。"
end if
end sub
%>