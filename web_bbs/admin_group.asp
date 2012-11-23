<!--#include file=conn.asp-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=inc/grade.asp-->
<!--#include file=chkuser.asp-->
<title><%=ForumName%>--管理页面</title>
<!--#include file="Forum_css.asp"-->

<BODY <%=ForumBody%>>
<%
	if not master or instr(session("flag"),"14")=0 then
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
            <tr bgcolor=<%=tablebodycolor%>>
              <td width="100%" valign=top><font color="<%=TableContentColor%>">
<%
if request("action")="save" then
call savegroup()
elseif request("action")="savedit" then
call savedit()
elseif request("action")="del" then
call del()
else
call gradeinfo()
end if
%></font>
	      </td>
            </tr>
        </table>
        </td>
    </tr>
</table>
<%
end sub

sub gradeinfo()
%>
<table width="95%" border="0" cellspacing="1" cellpadding="3"  align=center bordercolor=<%=aTablebackcolor%>>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td height="23" colspan="2" ><font color="<%=TableContentColor%>"><b>用户门派管理</b>：您可以添加修改或者删除论坛门派。</font></td>
</tr>
<%if request("action")="edit" then%>
<form method="POST" action=admin_group.asp?action=savedit>
<%
	set rs=conn.execute("select * from GroupName where id="&request("id"))
%>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td height="23" colspan="2" ><font color="<%=TableContentColor%>"><b>修改门派</b> | <a href=admin_group.asp><font color="<%=TableContentColor%>">添加门派</font></a></font></td>
</tr>
<tr> 
    <td width="30%"><font color="<%=TableContentColor%>"><strong>门派名称</strong></font></td>
<td width="70%"> 
<input type="text" name="Groupname" size="35" value="<%=rs("Groupname")%>">&nbsp;<input type="submit" name="Submit" value="提 交">
<input type=hidden name=id value="<%=request("id")%>">
</td>
</tr>
<%set rs=nothing%>
<%else%>
<form method="POST" action=admin_group.asp?action=save>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td height="23" colspan="2" ><font color="<%=TableContentColor%>"><b>添加门派</b></font></td>
</tr>
<tr> 
      <td width="30%"><font color="<%=TableContentColor%>"><strong>门派名称</strong></font></td>
<td width="70%"> 
<input type="text" name="Groupname" size="35">&nbsp;<input type="submit" name="Submit" value="提 交">
</td>
</tr>
</form>
<%end if%>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td height="23" colspan="2" ><font color="<%=TableContentColor%>"><b>管理门派</b></font></td>
</tr>
<%
	set rs=conn.execute("select * from GroupName")
	do while not rs.eof
%>
<tr> 
<td height="23" colspan="2" ><font color="<%=TableContentColor%>">
<a href="admin_group.asp?id=<%=rs("id")%>&action=edit"><font color="<%=TableContentColor%>">修改</font></a> | <a href="admin_group.asp?id=<%=rs("id")%>&action=del"><font color="<%=TableContentColor%>">删除</font></a> | <%=rs("GroupName")%></font>
</td>
</tr>
<%
	rs.movenext
	loop
	set rs=nothing
%>
</table>
<%
end sub
sub savegroup()
	conn.execute("insert into GroupName (GroupName) values ('"&request("GroupName")&"')")
%>
<center><p><b>添加成功！</b>
<%
end sub
sub savedit()
	conn.execute("update GroupName set GroupName='"&request("GroupName")&"' where id="&request("id"))
%>
<center><p><b>修改成功！</b>
<%
end sub
sub del()
	conn.execute("delete from GroupName where id="&request("id"))
%>
<center><p><b>删除成功！</b>
<%
end sub
%>