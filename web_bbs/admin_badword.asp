<!--#include file=conn.asp-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=chkuser.asp-->
<title><%=ForumName%>--管理页面</title>
<!--#include file="Forum_css.asp"-->

<BODY  <%=ForumBody%>>
<%
	if not master or instr(session("flag"),"28")=0 then
		Errmsg=Errmsg+"<br>"+"<li>本页面为管理员专用，请<a href=admin_index.asp target=_top>登陆</a>后进入。<br><li>您没有管理本页面的权限。"
		call Error()
	else
		call main()
		conn.close
		set conn=nothing
	end if

	sub main()
	dim sel
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
          <td width="100%" valign=top> <font color="<%=TableContentColor%>">
	      <%if request("action") = "savebadword" then%>
	      <%call savebadword()%>
	      <%else%>

<form action="admin_badword.asp?action=savebadword" method=post>
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
response.write "<input type=checkbox name=skinid value="&rs("id")&" "&sel&"><a href=admin_badword.asp?skinid="&rs("id")&"><font color="&TablecontentColor&">"&rs("skinname")&"</font></a>&nbsp;"
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
response.write "<input type=checkbox name=boardid value="&rs("boardid")&" "&sel&"><a href=admin_badword.asp?boardid="&rs("boardid")&"><font color="&TablecontentColor&">" & rs("boardtype") & "</font></a>&nbsp;"
rs.movenext
loop
rs.close
set rs=nothing
%></font>
</td></tr>
                <tr> 
                  <td width="100%"><font color="<%=TableContentColor%>"><B>注意：</B>帖子过滤字符将过滤帖子内容中包含以下字符的内容，注册过滤字符将不允许用户注册包含以下字符的内容<BR>发贴过滤字符：<input type="text" name="badwords" value="<%=badwords%>" size="60">&nbsp<BR><BR>请您将要过滤的字符串添入，如果有多个字符串，请用“|”分隔开，例如：妈妈的|我靠|fuck</font></td>
                </tr>
                <tr> 
                  <td width="100%"><font color="<%=TableContentColor%>"><BR>注册过滤字符：<input type="text" name="splitwords" value="<%=splitwords%>" size="60">&nbsp;<BR><BR>请您将要过滤的字符串添入，如果有多个字符串，请用“,”分隔开，例如：沙滩,quest,木鸟<BR></font></td>
                </tr>
                <tr> 
                  <td width="100%"><input type="submit" name="Submit" value="提交"></td>
                </tr>
</table>
</form>
            <p> <br>
            </p> <%end if%></font>
             </td>
            </tr>
       </table>
      </td>
    </tr>  
</table>
<%
end sub

sub savebadword()
if request("skinid")<>"" then
sql = "update config set badwords='"&request("badwords")&"',splitwords='"&request("splitwords")&"' where id in ( "&request("skinid")&" )"
conn.execute(sql)
end if
if request("boardid")<>"" then
sql = "update board set badwords='"&request("badwords")&"',splitwords='"&request("splitwords")&"' where boardid in ( "&request("boardid")&" )"
conn.execute(sql)
end if
response.write "更新成功！"
end sub
%>