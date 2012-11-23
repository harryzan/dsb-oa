<!--#include file =conn.asp-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=chkuser.asp-->
<title><%=ForumName%>--管理页面</title>
<!--#include file="Forum_css.asp"-->
<meta NAME=GENERATOR Content=""Microsoft FrontPage 3.0"" CHARSET=GB2312>
<BODY <%=ForumBody%>>
<%
	if not master or instr(session("flag"),"21")=0 then
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
        <tr bgcolor='<%=Tabletitlecolor%>'><font color="<%=TablefontColor%>">
        <td align=center colspan="2">欢迎<b><%=membername%></b>进入管理页面</font>
        </td>
        </tr>
            <tr bgcolor=<%=tablebodycolor%>>
              <td width="100%" valign=top><font color="<%=TablefontColor%>">
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
<form method="POST" action=admin_var.asp?action=save>
<table width="95%" border="0" cellspacing="1" cellpadding="3"  align=center bordercolor=<%=aTablebackcolor%>>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td height="23" colspan="2" ><font color="<%=TablefontColor%>"><B>说明</B>：<BR>1、复选框中选择的为当前的使用设置模板，点击可查看该模板设置，点击别的模板直接查看该模板并修改设置。您可以将您下面的设置保存在多个论坛风格模板中<BR>2、您也可以将下面设定的信息保存并应用到具体的分论坛设置中，可多选<BR>3、如果您想在一个版面引用别的版面或模板的配置，只要点击该版面或模板名称，保存的时候选择要保存到的版面名称或模板名称即可。</font></td>
</tr>
<tr> 
<td width="100%" colspan=2><font color="<%=TablefontColor%>"><B>当前使用主模板</B>（可将设置保存到下列模板中）<BR>
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
response.write "<input type=checkbox name=skinid value="&rs("id")&" "&sel&"><a href=admin_var.asp?skinid="&rs("id")&"><font color="&TablefontColor&">"&rs("skinname")&"</font></a>&nbsp;"
rs.movenext
loop
rs.close
set rs=nothing
%></font>
</td></tr>
<tr> 
<td width="100%" colspan=2><font color="<%=TablefontColor%>"><B>当前使用分论坛模板</B>（可将设置保存到下列论坛中）<BR>
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
response.write "<input type=checkbox name=boardid value="&rs("boardid")&" "&sel&"><a href=admin_var.asp?boardid="&rs("boardid")&"><font color="&TablefontColor&">" & rs("boardtype") & "</font></a>&nbsp;"
rs.movenext
loop
rs.close
set rs=nothing
%></font>
</td></tr>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td height="23" colspan="2" ><font color="<%=TablefontColor%>"><b>论坛基本信息</b></font></td>
</tr>
<tr> 
<td width="40%"><font color="<%=TablefontColor%>"><B>论坛名称</B></td>
<td width="60%"> 
<input type="text" name="ForumName" size="35" value="<%=ForumName%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TablefontColor%>"><B>论坛的url</B></td>
<td width="60%"> 
<input type="text" name="ForumURL" size="35" value="<%=ForumURL%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TablefontColor%>"><B>主页名称</B></td>
<td width="60%"> 
<input type="text" name="CompanyName" size="35" value="<%=CompanyName%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TablefontColor%>"><B>主页URL</B></td>
<td width="60%"> 
<input type="text" name="HostUrl" size="35" value="<%=HostUrl%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TablefontColor%>"><B>SMTP Server地址</B><BR>只有在论坛使用设置中打开了发送邮件功能，该填写内容方有效</td>
<td width="60%"> 
<input type="text" name="SMTPServer" size="35" value="<%=SMTPServer%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TablefontColor%>"><B>论坛管理员Email</B><BR>给用户发送邮件时，显示的来源Email信息</td>
<td width="60%"> 
<input type="text" name="SystemEmail" size="35" value="<%=SystemEmail%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TablefontColor%>"><B>论坛首页Logo地址</B><BR>显示在论坛首页，添加论坛如果没有填写logo地址，则使用该内容</td>
<td width="60%"> 
<input type="text" name="Logo" size="35" value="<%=ForumLogo%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TablefontColor%>"><B>论坛图片目录</B></td>
<td width="60%"> 
<input type="text" name="Picurl" size="35" value="<%=picurl%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TablefontColor%>"><B>论坛表情目录</B></td>
<td width="60%"> 
<input type="text" name="Faceurl" size="35" value="<%=Faceurl%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TablefontColor%>"><B>论坛所在时区</B></td>
<td width="60%"> 
<input type="text" name="GMT" size="35" value="<%=GMT%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TablefontColor%>"><B>版权信息</B></td>
<td width="60%"> 
<input type="text" name="Copyright" size="35" value="<%=Copyright%>">
</td>
</tr>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td width="40%"><font color="<%=TablefontColor%>">&nbsp;</td>
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

sub saveconst()
dim Forum_info,Forum_copyright
if trim(request("skinid"))="" and trim(request("boardid"))="" then
Founderr=true
Errmsg=Errmsg+"<br>"+"<li>请选择保存的模板名称"
else
Forum_info=Request("ForumName") & "," & Request("ForumURL") & "," & Request("CompanyName") & "," & Request("HostUrl") & "," & Request("SMTPServer") & "," & Request("SystemEmail") & "," & Request("Logo") & "," & Request("Picurl") & "," & Request("Faceurl") & "," & Request("GMT")
Forum_copyright=request("copyright")
'response.write Forum_info
if request("skinid")<>"" then
sql = "update config set Forum_info='"&Forum_info&"',Forum_copyright='"&Forum_copyright&"' where id in ( "&request("skinid")&" )"
conn.execute(sql)
end if
if request("boardid")<>"" then
sql = "update board set Forum_info='"&Forum_info&"',Forum_copyright='"&Forum_copyright&"' where boardid in ( "&request("boardid")&" )"
conn.execute(sql)
end if
response.write "设置成功。"
end if
end sub
%>