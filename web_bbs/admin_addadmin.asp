<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=chkuser.asp-->
<!-- #include file="admin_config.asp" -->
<title><%=ForumName%>--管理页面</title>
<!--#include file="Forum_css.asp"-->

<BODY  <%=ForumBody%>>
<%
	if not master or instr(session("flag"),"41")=0 then
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
              <td width="100%" valign=top><p><font color=<%=tablecontentcolor%>>
<%
	if request("action")="updat" then
		call update()
		response.write body
	else
%>
              <table width="95%" border="0" cellspacing="3" cellpadding="0" align=center>
                <tr> 
                  <td bgcolor="<%=aTableTitleColor%>"> <font color=<%=tablecontentcolor%>>
                    <p><b>添加管理员</b>：<br>
                      注意：添加管理员后请到管理员权限设置页面对其管理权限进行设置。</p></font>
                  </td>
                </tr>
                <tr> 
                  <td bgcolor="<%=TableTitleColor%>" height=22><font color=<%=tablefontcolor%>><b>>>添加管理员</b>（请完整填写以下信息）</font>
                  </td>
                </tr>
<form action="admin_addadmin.asp?action=updat" method=post>
		<tr><td height=25><font color=<%=tablecontentcolor%>>
请确保该用户名属于论坛注册用户<br>
用户名：<input name=username type=text size=30><input type="submit" name="Submit" value="添加">
		</font></td>
		</tr>
</form>
	      </table>
<%
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

	sub update()
	dim username
	if request("username")="" then
	Founderr=true
	Errmsg=Errmsg+"<br>"+"<li>请填写用户名称。"
	exit sub
	else
	username=replace(request("username"),"'","")
	end if
	set rs=server.createobject("adodb.recordset")
	sql="select username,userclass from [user] where username='"&username&"'"
	rs.open sql,conn,1,3
	if rs.eof and rs.bof then
	Founderr=true
	Errmsg=Errmsg+"<br>"+"<li>论坛注册用户中没有您添加的用户名，请确认后添加。"
	exit sub
	else
	rs("userclass")=20
	rs.update
	end if
	rs.close
	sql="select * from admin where username='"&username&"'"
	rs.open sql,conn,1,3
	if rs.eof and rs.bof then
	rs.addnew
	rs("username")=username
	body="<li>管理员添加成功，请到管理员权限设置页面对其管理权限进行设置。"
	rs.update
	else
	Founderr=true
	Errmsg=Errmsg+"<br>"+"<li>该管理员已经存在，请重新添加。"
	end if
	rs.close
	set rs=nothing
	end sub
%>