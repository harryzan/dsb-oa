<!-- #include file="conn.asp" -->
<!-- #include file="inc/const.asp" -->
<!--#include file="chkuser.asp"-->
<!-- #include file="inc/char.asp" -->
<!--#include file="inc/chkinput.asp"-->
<%
	stats="ע���û�"
	dim username
	dim useremail
	if request("username")="" or strLength(request("username"))>20 then
		errmsg=errmsg+"<br>"+"<li>�����������û���(���Ȳ��ܴ���20)��"
		founderr=true
	else
		username=trim(request("username"))
	end if
	if Instr(request("username"),"=")>0 or Instr(request("username"),"%")>0 or Instr(request("username"),chr(32))>0 or Instr(request("username"),"?")>0 or Instr(request("username"),"&")>0 or Instr(request("username"),";")>0 or Instr(request("username"),",")>0 or Instr(request("username"),"'")>0 or Instr(request("username"),",")>0 or Instr(request("username"),chr(34))>0 or Instr(request("username"),chr(9))>0 or Instr(request("username"),"��")>0 or Instr(request("username"),"$")>0 then
	errmsg=errmsg+"<br>"+"<li>�û����к��зǷ��ַ���"
		founderr=true
	else
		username=trim(request("username"))
	end if

	splitwords=split(splitwords,",")
	for i = 0 to ubound(splitwords)
		if instr(username,splitwords(i))>0 then
			errmsg=errmsg+"<br>"+"<li>��������û�������ϵͳ��ֹע���ַ���"
			founderr=true
			exit for
		end if
	next
	
	if IsValidEmail(trim(request("email")))=false then
   		errmsg=errmsg+"<br>"+"<li>����Email�д���"
   		founderr=true
	else
		useremail=checkStr((request("email")))
	end if
	if not founderr then
	if cint(EmailRegOne)=1 then
	sql="select username,useremail from [user] where username='"&username&"' or useremail='"&useremail&"'"
	else
	sql="select username,useremail from [user] where username='"&username&"'"
	end if
	set rs=conn.execute(sql)
	if not rs.eof and not rs.bof then
		if cint(EmailRegOne)=1 and rs("useremail")=useremail then
		errmsg=errmsg+"<br>"+"<li>�Բ��𣬱���̳�Ѿ�������һ��Emailֻ��ע��һ���ʺţ�������ѡ������Email��"
		else
		errmsg=errmsg+"<br>"+"<li>�Բ�����������û����Ѿ���ע�ᡣ"
		end if
		founderr=true
	else
		founderr=false
	end if
	rs.close
	set rs=nothing
	end if
%>
<html><head>
<meta NAME=GENERATOR Content="Microsoft FrontPage 4.0" CHARSET=GB2312>
<title><%=ForumName%>--<%=stats%></title>
<!--#include file=Forum_css.asp--></head>
<body <%=ForumBody%>>
<p>&nbsp;</p>
<table cellpadding=0 cellspacing=0 border=0 width="<%=tablewidth%>" bgcolor=<%=Tablebackcolor%> align=center>
  <tr>
    <td>
<table cellpadding=3 cellspacing=1 border=0 width=100%>
<TBODY> 
<TR align=middle bgcolor=<%=Tabletitlecolor%>> 
<TD height=24><b><font color="<%=TableFontColor%>">�û�������</font></b></TD>
</TR>
<TR bgcolor=<%=Tablebodycolor%>> 
<TD height=24><font color="<%=TableContentColor%>">
<%
if founderr then
response.write Errmsg
else
response.write "��ϲ��������д���û���Emailͨ����⣬��������ע�ᣡ<br>�����������ע����Ϣ��д������лл��"
end if
%></font></TD>
</TR>
</TBODY>
</TABLE>
    </td>
  </tr>
</table>
<%call endline()%>
<!-- #include file="footer.asp" -->
