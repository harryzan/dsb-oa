<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=chkuser.asp-->
<title><%=ForumName%>--����ҳ��</title>
<!--#include file="Forum_css.asp"-->
<BODY <%=ForumBody%>>
<%
	if not master or instr(session("flag"),"53")=0 then
		Errmsg=Errmsg+"<br>"+"<li>��ҳ��Ϊ����Աר�ã���<a href=admin_index.asp target=_top>��½</a>����롣<br><li>��û�й���ҳ���Ȩ�ޡ�"
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
        <td><font color="<%=TablefontColor%>">��ӭ<b><%=membername%></b>�������ҳ��</font>
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
	sql="select username from online where username<>'����'"
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
	body=body+"<br>"+"�����ɹ����������Ĳ�����"
end sub

sub sendmsg()
%>
              <table width="100%" border="0" cellspacing="3" cellpadding="0">
                <tr> 
                  <td colspan="2" bgcolor=<%=atabletitlecolor%> height="7"> <font color="<%=TableContentColor%>">
                    <p><b>ϵͳ��Ϣ����</b>��<br>
                      ע�⣺������������ѡ�������ע���û����Ͷ���Ϣ�����ѡ����û������ܶ࣬�����Ĵ�����ϵͳ��Դ��������ʹ�ã�</p></font>
                  </td>
                </tr>
            <form action="admin_message.asp?action=add" method=post>
                <tr> 
                  <td width="22%"><font color="<%=TableContentColor%>">��Ϣ����</font></td>
                  <td width="78%"> 
                    <input type="text" name="title" size="50">
                  </td>
                </tr>
                <tr> 
                  <td width="22%"><font color="<%=TableContentColor%>">���շ�ѡ��</font></td>
                  <td width="78%"> 
                    <select name=stype size=1>
					<option value="1">���������û�</option>
					<option value="2">���й��</option>
					<option value="3">���а���</option>
					<option value="4">���й���Ա</option>
					<option value="5">���/����/����Ա</option>
					<option value="6">�����û�</option>
					</select>
                  </td>
                </tr>
                <tr> 
                  <td width="22%" height="20" valign="top"><font color="<%=TableContentColor%>">
                    <p>��Ϣ����</p>
                    <p>(<font color="<%=AlertFontColor%>">HTML����֧��</font>)</p></font>
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
                      <input type="submit" name="Submit" value="������Ϣ">
                      <input type="reset" name="Submit2" value="������д">
                    </div>
                  </td>
                </tr>
            </form>
                <tr> 
                  <td colspan="2" bgcolor=<%=atabletitlecolor%> height="20"> <font color="<%=TableContentColor%>">
                    <p><b>����ɾ����</font>
                  </td>
                </tr>
                <tr> 
                  <td colspan="2"> <font color="<%=TableContentColor%>">
            <form action="admin_message.asp?action=del" method=post>
                      ����ɾ��ĳ�û�����Ϣ����Ҫ����ɾ��ϵͳ������Ϣ����<br><input type="text" name="username" size="20">
			<input type="submit" name="Submit" value="�� ��">
            </form>
			<form action="admin_message.asp?action=delall" method=post>
                      ����ɾ���û�ָ�������ڶ���Ϣ��Ĭ��Ϊɾ���Ѷ���Ϣ����<br>
					  <select name="delDate" size=1>
						<option value=7>һ������ǰ</option>
						<option value=30>һ����ǰ</option>
						<option value=60>������ǰ</option>
						<option value=180>����ǰ</option>
						<option value="all">������Ϣ</option>
					  </select>
					  &nbsp;<input type="checkbox" name="isread" value="yes">����δ����Ϣ
			<input type="submit" name="Submit" value="�� ��">
            </form></font>
                  </td>
                </tr>
              </table>
<%
end sub

sub del()
	if request("username")="" then
		body=body+"<br>"+"������Ҫ����ɾ�����û�����"
		exit sub
	end if
	sql="delete from message where sender='"&request("username")&"'"
	conn.Execute(sql)
	body=body+"<br>"+"�����ɹ����������Ĳ�����"
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
	body=body+"<br>"+"�����ɹ����������Ĳ�����"
end sub
%>