<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=chkuser.asp-->
<title><%=ForumName%>--管理页面</title>
<!--#include file="Forum_css.asp"-->
<BODY <%=ForumBody%>>
<%
	if not master or instr(session("flag"),"53")=0 then
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
        <td><font color="<%=TablefontColor%>">欢迎<b><%=membername%></b>进入管理页面</font>
        </td>
        </tr>
            <tr bgcolor=<%=tablebodycolor%>>
          <td width="100%" valign=top height="276"> <font color="<%=TableContentColor%>">
<%
	if Request("action")="add" then
		call savemsg()
	elseif request("action")="del" then
		call del()
	elseif request("action")="delall" then
		call delall()
	else
		call sendmsg()
	end if
%>
<p align=center><%=body%></p></font>
          </td>
            </tr>
        </table>
        </td>
    </tr>
</table>
<%
end sub

sub savemsg()
	dim sendtime,sender
	sendtime=Now()
	sender=Forumname
	set rs = server.CreateObject ("adodb.recordset")
	select case request("stype")
	case 1
	sql="select username from online where username<>'客人'"
	rs.open sql,conn,1,1
	do while not rs.eof
	sql="insert into message(incept,sender,title,content,sendtime,flag,issend) values('"&rs(0)&"','"&sender&"','"&TRim(Request("title"))&"','"&Trim(Request("message"))&"',Now(),0,1)"
	conn.Execute(sql)
	rs.movenext
	loop
	rs.close
	case 2
    sql = "select username from [user] where userclass=18 order by userid desc"
    rs.Open sql,conn,1,1
    do while not rs.EOF 

	sql="insert into message(incept,sender,title,content,sendtime,flag,issend) values('"&rs(0)&"','"&sender&"','"&TRim(Request("title"))&"','"&Trim(Request("message"))&"',Now(),0,1)"
	conn.Execute(sql)
	rs.MoveNext 
	Loop
	rs.Close
	case 3
    sql = "select username from [user] where userclass=19 order by userid desc"
    rs.Open sql,conn,1,1
    do while not rs.EOF 

	sql="insert into message(incept,sender,title,content,sendtime,flag,issend) values('"&rs(0)&"','"&sender&"','"&TRim(Request("title"))&"','"&Trim(Request("message"))&"',Now(),0,1)"
	conn.Execute(sql)
	rs.MoveNext 
	Loop
	rs.Close
	case 4
    sql = "select username from [user] where userclass=20 order by userid desc"
    rs.Open sql,conn,1,1
    do while not rs.EOF 

	sql="insert into message(incept,sender,title,content,sendtime,flag,issend) values('"&rs(0)&"','"&sender&"','"&TRim(Request("title"))&"','"&Trim(Request("message"))&"',Now(),0,1)"
	conn.Execute(sql)
	rs.MoveNext 
	Loop
	rs.Close
	case 5
    sql = "select username from [user] where userclass>=18 order by userid desc"
    rs.Open sql,conn,1,1
    do while not rs.EOF 

	sql="insert into message(incept,sender,title,content,sendtime,flag,issend) values('"&rs(0)&"','"&sender&"','"&TRim(Request("title"))&"','"&Trim(Request("message"))&"',Now(),0,1)"
	conn.Execute(sql)
	rs.MoveNext 
	Loop
	rs.Close
	case 6
    sql = "select username from [user] order by userid desc"
    rs.Open sql,conn,1,1
    do while not rs.EOF 

	sql="insert into message(incept,sender,title,content,sendtime,flag,issend) values('"&rs(0)&"','"&sender&"','"&TRim(Request("title"))&"','"&Trim(Request("message"))&"',Now(),0,1)"
	conn.Execute(sql)
	rs.MoveNext 
	Loop
	rs.Close
	end select
	set rs=nothing
	body=body+"<br>"+"操作成功！请继续别的操作。"
end sub

sub sendmsg()
%>
              <table width="100%" border="0" cellspacing="3" cellpadding="0">
                <tr> 
                  <td colspan="2" bgcolor=<%=atabletitlecolor%> height="7"> <font color="<%=TableContentColor%>">
                    <p><b>系统消息发布</b>：<br>
                      注意：这里您将向您选择的所有注册用户发送短消息，如果选择的用户数量很多，将消耗大量的系统资源，请慎重使用！</p></font>
                  </td>
                </tr>
            <form action="admin_message.asp?action=add" method=post>
                <tr> 
                  <td width="22%"><font color="<%=TableContentColor%>">消息标题</font></td>
                  <td width="78%"> 
                    <input type="text" name="title" size="50">
                  </td>
                </tr>
                <tr> 
                  <td width="22%"><font color="<%=TableContentColor%>">接收方选择</font></td>
                  <td width="78%"> 
                    <select name=stype size=1>
					<option value="1">所有在线用户</option>
					<option value="2">所有贵宾</option>
					<option value="3">所有版主</option>
					<option value="4">所有管理员</option>
					<option value="5">贵宾/版主/管理员</option>
					<option value="6">所有用户</option>
					</select>
                  </td>
                </tr>
                <tr> 
                  <td width="22%" height="20" valign="top"><font color="<%=TableContentColor%>">
                    <p>消息内容</p>
                    <p>(<font color="<%=AlertFontColor%>">HTML代码支持</font>)</p></font>
                  </td>
                  <td width="78%" height="20"> 
                    <textarea name="message" cols="50 " rows="10"></textarea>
                  </td>
                </tr>
                <tr> 
                  <td width="22%" height="23" valign="top" align="center"> 
                    <div align="left"> </div>
                  </td>
                  <td width="78%" height="23"> 
                    <div align="center"> 
                      <input type="submit" name="Submit" value="发送消息">
                      <input type="reset" name="Submit2" value="重新填写">
                    </div>
                  </td>
                </tr>
            </form>
                <tr> 
                  <td colspan="2" bgcolor=<%=atabletitlecolor%> height="20"> <font color="<%=TableContentColor%>">
                    <p><b>批量删除：</font>
                  </td>
                </tr>
                <tr> 
                  <td colspan="2"> <font color="<%=TableContentColor%>">
            <form action="admin_message.asp?action=del" method=post>
                      批量删除某用户短消息（主要用于删除系统批量信息）：<br><input type="text" name="username" size="20">
			<input type="submit" name="Submit" value="提 交">
            </form>
			<form action="admin_message.asp?action=delall" method=post>
                      批量删除用户指定日期内短消息（默认为删除已读信息）：<br>
					  <select name="delDate" size=1>
						<option value=7>一个星期前</option>
						<option value=30>一个月前</option>
						<option value=60>两个月前</option>
						<option value=180>半年前</option>
						<option value="all">所有信息</option>
					  </select>
					  &nbsp;<input type="checkbox" name="isread" value="yes">包括未读信息
			<input type="submit" name="Submit" value="提 交">
            </form></font>
                  </td>
                </tr>
              </table>
<%
end sub

sub del()
	if request("username")="" then
		body=body+"<br>"+"请输入要批量删除的用户名。"
		exit sub
	end if
	sql="delete from message where sender='"&request("username")&"'"
	conn.Execute(sql)
	body=body+"<br>"+"操作成功！请继续别的操作。"
end sub

sub delall()
	dim selflag
	if request("isread")="yes" then
	selflag=""
	else
	selflag=" and flag=1"
	end if
	select case request("delDate")
	case "all"
	sql="delete from message where id>0 "&selflag
	case 7
	sql="delete from message where datediff('d',sendtime,Now())>7 "&selflag
	case 30
	sql="delete from message where datediff('d',sendtime,Now())>30 "&selflag
	case 60
	sql="delete from message where datediff('d',sendtime,Now())>60 "&selflag
	case 180
	sql="delete from message where datediff('d',sendtime,Now())>180 "&selflag
	end select
	conn.Execute(sql)
	body=body+"<br>"+"操作成功！请继续别的操作。"
end sub
%>