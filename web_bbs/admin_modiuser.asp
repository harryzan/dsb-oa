<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=inc/grade.asp-->
<!--#include file=chkuser.asp-->
<!--#include file=md5.asp-->
<title><%=ForumName%>--����ҳ��</title>
<!--#include file="Forum_css.asp"-->

<BODY <%=ForumBody%>>
<%
	if not master or instr(session("flag"),"11")=0 then
		Errmsg=Errmsg+"<br>"+"<li>��ҳ��Ϊ����Աר�ã���<a href=admin_index.asp target=_top>��½</a>����롣<br><li>��û�й���ҳ���Ȩ�ޡ�"
		call Error()
	else
		call main()
		set rs=nothing
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
              <td width="100%" valign=top><font color="<%=TableContentColor%>">
<%
if request("action")="save" then
call update()
else
call userinfo()
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

sub userinfo()
	dim username
	username=trim(replace(request("name"),"'",""))
	set rs=server.createobject("adodb.recordset")
   	sql="select * from [User] where username='"&UserName&"'"
	rs.open sql,conn,1,1
	if rs.eof and rs.bof then
		errmsg=errmsg+"<br>"+"<li>���û��������ڡ�"
		call error()
		exit sub
	else
%>
<form method="POST" action=admin_modiuser.asp?action=save>
  <table width="95%" border="0" cellspacing="1" cellpadding="3"  align=center bordercolor=<%=aTablebackcolor%>>
    <tr bgcolor=<%=aTabletitlecolor%>> 
      <td height="11" colspan="2" ><font color="<%=TableContentColor%>"><b><%=htmlencode(rs("username"))%>�ĸ�������</b></font></td>
    </tr>
    <tr> 
      <td width="41%" height="18"><font color="<%=TableContentColor%>">�û���</font></td>
      <td width="59%" height="18"> <input type="text" name="userName" size="35" value="<%=htmlencode(rs("username"))%>"> 
        <input type="hidden" name="Name" value="<%=htmlencode(rs("username"))%>"> 
      </td>
    </tr>
    <tr> 
      <td width="41%" height="18"><font color="<%=TableContentColor%>">�û�����</font></td>
      <td width="59%" height="18"> <input type="text" name="password" size="35" value="<%=htmlencode(rs("userpassword"))%>"> 
      </td>
    </tr>
    <tr> 
      <td width="41%" height="18"><font color="<%=TableContentColor%>">�ʼ���ַ</font></td>
      <td width="59%" height="18"> <input type="text" name="userEmail" size="35" value="<%=rs("userEmail")%>"> 
      </td>
    </tr>
    <tr> 
      <td width="41%" height="18"><font color="<%=TableContentColor%>">��ϵ��ַ</font></td>
      <td width="59%" height="18"> <input type="text" name="homepage" size="35" value="<%=rs("homepage")%>"> 
      </td>
    </tr>
    <tr> 
      <td width="41%" height="8"><font color="<%=TableContentColor%>">��������</font></td>
      <td width="59%" height="-2"> <input type="text" name="article" size="35" value="<%=rs("article")%>"> 
      </td>
    </tr>
    <tr bgcolor=<%=aTabletitlecolor%>> 
      <td height="23" colspan="2" > <input type="submit" name="Submit" value="�� ��"> 
      </td>
    </tr>
  </table>
</form>
<%
	end if
	rs.close
	set rs=nothing
end sub

sub update()
	dim username
	username=trim(replace(request("name"),"'",""))
	set rs=server.createobject("adodb.recordset")
   	sql="select * from [User] where username='"&UserName&"'"
	'response.write sql
	'response.end
	rs.open sql,conn,1,3
	if rs.eof and rs.bof then
		errmsg=errmsg+"<br>"+"<li>���û��������ڡ�"
		call error()
		exit sub
	else
		rs("title")=request.form("title")
		rs("username")=request.form("username")
		if rs("userpassword")<>request.form("password") then
		rs("userpassword")=md5(request.form("password"))
		end if
		rs("useremail")=request.form("useremail")
		rs("homepage")=request.form("homepage")
		rs("article")=request.form("article")
		rs("userclass")=request.form("userclass")
		rs("lockuser")=request.form("lockuser")
		rs("userWealth")=request.form("userWealth")
		rs("userEP")=request.form("userEP")
		rs("userCP")=request.form("userCP")
		rs.update
		if request.form("username")<>rs("username") then
		conn.execute("update bbs1 set username='"&request.form("username")&"' where username='"&request.form("username")&"'")
		conn.execute("update message set sender='"&request.form("username")&"' where sender='"&request.form("username")&"'")
		conn.execute("update message set incept='"&request.form("username")&"' where incept='"&request.form("username")&"'")
		end if
        rs.close
	end if
	set rs=nothing
%><center><p><b>�����û����ݳɹ���</b>
<%
end sub
%>