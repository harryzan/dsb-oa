<!--#include file=conn.asp-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=inc/email.asp-->
<!--#include file=chkuser.asp-->
<title><%=ForumName%>--����ҳ��</title>
<!--#include file="Forum_css.asp"-->

<BODY <%=ForumBody%>>
<%
	if not master or instr(session("flag"),"54")=0 then
		Errmsg=Errmsg+"<br>"+"<li>��ҳ��Ϊ����Աר�ã���<a href=admin_index.asp target=_top>��½</a>����롣<br><li>��û�й���ҳ���Ȩ�ޡ�"
		call Error()
	else
		dim topic,mailbody,email
		i=1
		set rs= server.createobject ("adodb.recordset")
		call main()
	end if

	sub main()
%>
<table cellpadding=0 cellspacing=0 border=0 width=<%=tablewidth%> bgcolor=<%=tablebackcolor%> align=center>
  <tr>
    <td>
      <table cellpadding=3 cellspacing=1 border=0 width=100%>
        <tr bgcolor='<%=Tabletitlecolor%>'>
        <td><font color="<%=TablefontColor%>">��ӭ<b><%=membername%></b>�������ҳ��</fnot>
        </td>
        </tr>
            <tr bgcolor=<%=tablebodycolor%>>
              <td width="100%" valign=top><font color="<%=TableContentColor%>">
<%
if request("action")="send" then
	call sendmail()
else
	call mail()
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

sub mail()
%>
<form action="admin_mailist.asp?action=send" method=post>
              <table width="100%" border="0" cellspacing="3" cellpadding="0">
                <tr> 
                  <td colspan="2" bgcolor=<%=atabletitlecolor%> height=20> <font color="<%=TableContentColor%>">
                    <b>��̳�ʼ��б�</b><br>
ע�⣺��������д���±��������ͣ���Ϣ�����͵�����ע��ʱ������д��������û����ʼ��б��ʹ�ý����Ĵ����ķ�������Դ��������ʹ�á�</font>
                  </td>
                </tr>
                <tr> 
                  <td> <font color="<%=TableContentColor%>">�ʼ����⣺</font></td>
		  <td><input type=text name=topic size=25></td>
                </tr>
                <tr> 
                  <td> <font color="<%=TableContentColor%>">�ʼ����ݣ�</font></td>
		  <td><textarea cols=35 rows=6 name="content"></textarea></td>
                </tr>
                <tr> 
                  <td colspan="2" bgcolor=<%=atabletitlecolor%> height=20> 
<input type=Submit value="�� ��" name=Submit"> &nbsp; <input type="reset" name="Clear" value="�� ��">
                  </td>
                </tr>
              </table>
</form>
<%
end sub

sub sendmail()
	if request("topic")="" then
		Errmsg=Errmsg+"<br>"+"<li>�������ʼ����⡣"
		founderr=true
	else
		topic=request("topic")
	end if
	if request("content")="" then
		Errmsg=Errmsg+"<br>"+"<li>�������ʼ����ݡ�"
		founderr=true
	else
		mailbody=request("content")
	end if
	if founderr=false then
	on error resume next
	sql="select username,useremail from [user]"
	rs.open sql,conn,1,1
	if not rs.eof and not rs.bof then
		alluser=rs.recordcount
		do while not rs.eof
		if rs("useremail")<>"" then
		email=rs("useremail")
			if EmailFlag=0 then
				errmsg=errmsg+"<br>"+"<li>����̳��֧�ַ����ʼ���"
				exit sub
			elseif EmailFlag=1 then
				call jmail(email)
			elseif EmailFlag=2 then
				call Cdonts(email)
			elseif EmailFlag=3 then
				call aspemail(email)
			end if
		i=i+1
		end if
		rs.movenext
		loop
		Errmsg=Errmsg+"<br>"+"<li>�ɹ�����"&i&"���ʼ���"
	end if
	rs.close
	set rs=nothing
	conn.close
	set conn=nothing
	end if
	response.write ""&Errmsg&""
end sub
%>