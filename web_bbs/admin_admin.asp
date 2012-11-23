<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=chkuser.asp-->
<!-- #include file="admin_config.asp" -->
<head>
<title><%=ForumName%>--管理页面</title>
<!--#include file="Forum_css.asp"-->
<script language="JavaScript">
<!--
function CheckAll(form)
  {
  for (var i=0;i<form.elements.length;i++)
    {
    var e = form.elements[i];
    if (e.name != 'chkall')
       e.checked = form.chkall.checked;
    }
  }
//-->
</script>
</head>
<BODY  <%=ForumBody%>>
<%
	if not master or instr(session("flag"),"42")=0 then
		Errmsg=Errmsg+"<br>"+"<li>本页面为管理员专用，请<a href=admin_index.asp target=_top>登陆</a>后进入。<br><li>您没有管理本页面的权限。"
		call Error()
	else
		dim body
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
        <td><font color=<%=tablefontcolor%>>欢迎<b><%=membername%></b>进入管理中心</font>
        </td>
        </tr>
            <tr bgcolor=<%=tablebodycolor%>>
              <td width="100%" valign=top><font color=<%=tablecontentcolor%>><p>
<%
	if request("action")="updat" then
		call update()
		response.write body
	elseif request("action")="edit" then
		call userinfo()
	elseif request("action")="del" then
		call del()
		response.write body
	else
		call userlist()
	end if
%></font>
		</td>
            </tr>
        </table>
        </td>
    </tr>
</table>
<script language="JavaScript">
<!--
function CheckAll(form)  {
  for (var i=0;i<form.elements.length;i++)    {
    var e = form.elements[i];
    if (e.name != 'chkall')       e.checked = form.chkall.checked; 
   }
  }
//-->
</script>
<%
	end sub

	sub userlist()
%>
              <table width="100%" border="0" cellspacing="3" cellpadding="0" align=left>
                <tr> 
                  <td colspan=4 bgcolor="<%=aTableTitleColor%>"> 
                    <font color=<%=tablecontentcolor%>><p><b>管理员权限管理</b>：<br>
                      注意：请选择相应的管理员进行管理操作。</p></font>
                  </td>
                </tr>
                <tr bgcolor="<%=TableTitleColor%>"> 
                  <td width="34%" height=22><font color=<%=tablefontcolor%>>用户名</font></td><td width="33%"><font color=<%=tablefontcolor%>>上次登陆时间</font></td><td width="18%"><font color=<%=tablefontcolor%>>上次登陆IP</font></td><td width="15%"><font color=<%=tablefontcolor%>>操作</font></td>
                </tr>
<%
	set rs=conn.execute("select * from admin order by LastLogin desc")
	do while not rs.eof
%>
                <tr> 
                  <td><a href="admin_admin.asp?id=<%=rs("id")%>&action=edit"><font color=<%=tablecontentcolor%>><%=rs("username")%></font></a></td><td><font color=<%=tablecontentcolor%>><%=rs("LastLogin")%></font></td><td><font color=<%=tablecontentcolor%>><%=rs("LastLoginIP")%></font></td><td><a href="admin_admin.asp?action=del&id=<%=rs("id")%>&name=<%=rs("username")%>">删除</a></td>
                </tr>
<%
	rs.movenext
	loop
	rs.close
	set rs=nothing
%>
	       </table>
<%
	end sub
	sub userinfo()
	dim j,tmpmenu,menuname,menurl
	set rs=conn.execute("select * from admin where id="&request("id"))
%>
<form action="admin_admin.asp?action=updat" method=post name=adminflag>
              <table width="95%" border="0" cellspacing="3" cellpadding="0" align=center>
                <tr> 
                  <td bgcolor="<%=aTableTitleColor%>"> 
                    <font color=<%=tablecontentcolor%>><p><b>管理员权限管理</b>：<br>
                      注意：请选择相应的权限分配给管理员<font color=<%=alertfontcolor%>><%=rs("username")%></font>。</p></font>
                  </td>
                </tr>
                <tr> 
                  <td bgcolor="<%=TableTitleColor%>" height=22><font color=<%=tablefontcolor%>><b>>>全局权限</b></font>
                  </td>
                </tr>
		<tr><td>
<%for i=0 to ubound(menu,1)%>
<b><%=menu(i,0)%></b><br>
	<%
	for j=1 to ubound(menu,2)
	if isempty(menu(i,j)) then exit for
	tmpmenu=split(menu(i,j),",")
	menuname=tmpmenu(0)
	menurl=tmpmenu(1)
	%>
	<input type="checkbox" name="flag" <% if instr(session("flag"),"42")=0 then response.write "disabled=true" %> value="<%=i&j%>" <% if instr(rs("flag"),i&j)<>0 then response.write "checked" %>><a href="<%=menurl%>"><font color=<%=tablecontentcolor%>><%=menuname%></font></a>&nbsp;&nbsp;
	<%next%><br><br>
<%next%>
<input type=hidden name=id value="<%=request("id")%>">
<input type="submit" name="Submit" value="更新"><input name=chkall type=checkbox value=on onclick=CheckAll(this.form)>选择所有权限
		</td>
		</tr>
	      </table>
</form>
<%
	rs.close
	set rs=nothing
	end sub

	sub update()
	set rs=server.createobject("adodb.recordset")
	sql="select * from admin where id="&request("id")
	rs.open sql,conn,1,3
	if not rs.eof and not rs.bof then
	rs("flag")=request("flag")
	body="<li>管理员更新成功，请记住更新信息。"
	rs.update
	if rs("username")=membername then session("flag")=request("flag")
	end if
	rs.close
	set rs=nothing
	end sub
	sub del()
	conn.execute("delete from admin where id="&request("id"))
	conn.execute("update [user] set userclass=1 where username='"&request("name")&"'")
	body="<li>管理员删除成功。"
	end sub
%>