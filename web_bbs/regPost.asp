<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!--#include file="inc/char.asp"-->
<!--#include file="inc/chkinput.asp"-->
<!--#include file="inc/email.asp"-->
<!--#include file="chkuser.asp"-->
<!--#include file="inc/theme.asp"-->
<!--#include file="md5.asp"-->
<%
	stats="�û�ע��"
	dim username
	dim sex
	dim pass1
	dim pass2
	dim password
	dim useremail
	dim face,width,height
	dim oicq
	dim sign
	dim showRe
	dim birthday
	dim mailbody
	dim sendmsg
	dim rndnum,num1
	dim quesion
	dim answer
	dim topic,SendMail

	call chkinput
sub chkinput()


	if chkpost=false then
   		ErrMsg=ErrMsg+"<Br>"+"<li>���ύ�����ݲ��Ϸ����벻Ҫ���ⲿ�ύ���ԡ�"
   		FoundErr=True
	end if
	if request("name")="" or strLength(request("name"))>20 then
		errmsg=errmsg+"<br>"+"<li>�����������û���(���Ȳ��ܴ���20)��"
		founderr=true
	else
		username=trim(request("name"))
	end if
	if Instr(request("name"),"=")>0 or Instr(request("name"),"%")>0 or Instr(request("name"),chr(32))>0 or Instr(request("name"),"?")>0 or Instr(request("name"),"&")>0 or Instr(request("name"),";")>0 or Instr(request("name"),",")>0 or Instr(request("name"),"'")>0 or Instr(request("name"),",")>0 or Instr(request("name"),chr(34))>0 or Instr(request("name"),chr(9))>0 or Instr(request("name"),"��")>0 or Instr(request("name"),"$")>0 then
	errmsg=errmsg+"<br>"+"<li>�û����к��зǷ��ַ���"
		founderr=true
	else
		username=trim(request("name"))
	end if

	splitwords=split(splitwords,",")
	for i = 0 to ubound(splitwords)
		if instr(username,splitwords(i))>0 then
			errmsg=errmsg+"<br>"+"<li>��������û�������ϵͳ��ֹע���ַ���"
			founderr=true
			exit for
		end if
	next

	if request("sex")=0 or request("sex")=1 then
		sex=request("sex")
	else
		sex=1
	end if
	
	if request("showRe")=0 or request("showRe")=1 then
		showRe=request("showRe")
	else
		showRe=1
	end if	
		if request("psw")="" or len(request("psw"))>10 or len(request("psw"))<6 then
		errmsg=errmsg+"<br>"+"<li>��������������(���Ȳ��ܴ���10С��6)��"
		founderr=true
		else
		pass1=request("psw")
		end if
		if request("pswc")="" or strLength(request("pswc"))>10 or len(request("pswc"))<6 then
		errmsg=errmsg+"<br>"+"<li>������ȷ������(���Ȳ��ܴ���10С��6)��"
		founderr=true
		else
		pass2=request("pswc")
		end if
		if pass1<>pass2 then
		errmsg=errmsg+"<br>"+"<li>������������ȷ�����벻һ�¡�"
		founderr=true
		else
		password=md5(pass2)
		end if

	if request("quesion")="" then
	  	errmsg=errmsg+"<br>"+"<li>������������ʾ���⡣"
		founderr=true
	else
		quesion=request("quesion")
	end if
	if request("answer")="" then
	  	errmsg=errmsg+"<br>"+"<li>������������ʾ����𰸡�"
		founderr=true
	elseif request("answer")=request("oldanswer") then
		answer=request("answer")
	else
		answer=md5(request("answer"))
	end if

	if IsValidEmail(trim(request("e_mail")))=false then
   		errmsg=errmsg+"<br>"+"<li>����Email�д���"
   		founderr=true
	else
		useremail=checkStr((request("e_mail")))
	end if
	if request.form("myface")<>"" then
		if request("width")="" or request("height")="" then
			errmsg=errmsg+"<br>"+"<li>������ͼƬ�Ŀ�Ⱥ͸߶ȡ�"
			founderr=true
		elseif not isInteger(request("width")) or not isInteger(request("height")) then
			errmsg=errmsg+"<br>"+"<li>��������ַ����Ϸ���"
			founderr=true
		elseif request("width")<20 or request("width")>120 then
			errmsg=errmsg+"<br>"+"<li>�������ͼƬ��Ȳ����ϱ�׼��"
			founderr=true
		elseif request("height")<20 or request("height")>120 then
			errmsg=errmsg+"<br>"+"<li>�������ͼƬ�߶Ȳ����ϱ�׼��"
			founderr=true
		else
			face=request("myface")
			width=request("width")
			height=request("height")
		end if
	else
		if request("face")<>"" then
			if Instr(request("face"),picurl)>0 then
			face=request("face")
			width=32
			height=32
			end if
		end if
	end if
end sub

sub saveuserinfo()

	set rs=server.createobject("adodb.recordset")
	if cint(EmailRegOne)=1 then
	sql="select * from [user] where username='"&username&"' or useremail='"&useremail&"'"
	else
	sql="select * from [user] where username='"&username&"'"
	end if
	rs.open sql,conn,1,3
	if not rs.eof and not rs.bof then
		if cint(EmailRegOne)=1 and rs("useremail")=useremail then
		errmsg=errmsg+"<br>"+"<li>�Բ��𣬱���̳�Ѿ�������һ��Emailֻ��ע��һ���ʺţ�������ѡ������Email��"
		else
		errmsg=errmsg+"<br>"+"<li>�Բ�����������û����Ѿ���ע�ᡣ"
		end if
		founderr=true
	else
		rs.addnew
		rs("username")=username
		rs("userpassword")=password
		rs("useremail")=useremail
		rs("userclass")=1
		rs("quesion")=quesion
		rs("answer")=answer
		
		if request("Signature")<>"" then
		rs("sign")=trim(request("Signature"))
		end if
		if request("oicq")<>"" then
		rs("oicq")=request("oicq")
		end if
		if request("icq")<>"" then
		rs("icq")=request("icq")
		end if
		if request("msn")<>"" then
		rs("msn")=request("msn")
		end if
        	Rs("article")=0
        	Rs("sex")=sex
		Rs("showRe")=showRe
		if birthday<>"" then
		rs("birthday")=birthday
		end if
		rs("UserGroup")=request("GroupName")
        	Rs("addDate")=NOW()
		if face<>"" then
		rs("face")=face
        	Rs("width")=width
        	Rs("height")=height
		end if
		rs("logins")=1
        	Rs("lastlogin")=NOW()
		rs("userWealth")=wealthReg
		rs("userEP")=epReg
		rs("usercP")=cpReg
		rs.update
		rs.close
		set rs=nothing
		conn.execute("update config set usernum=usernum+1,lastuser='"&username&"'")
	end if
end sub

call nav()
call headline(1)
if founderr=true then
	call error()
else
	call saveuserinfo()
	if founderr=true then
		call error()
	else
		if smsflag=1 then
		call senduser()
		end if
		call reginfo()
		session("regtime")=now()
	end if
end if
call endline()

sub sendusermail()
	on error resume next
	topic="����" & Forumname & "��ע������"
	mailbody=mailbody &"<style>A:visited {	TEXT-DECORATION: none	}"
	mailbody=mailbody &"A:active  {	TEXT-DECORATION: none	}"
	mailbody=mailbody &"A:hover   {	TEXT-DECORATION: underline overline	}"
	mailbody=mailbody &"A:link 	  {	text-decoration: none;}"
	mailbody=mailbody &"A:visited {	text-decoration: none;}"
	mailbody=mailbody &"A:active  {	TEXT-DECORATION: none;}"
	mailbody=mailbody &"A:hover   {	TEXT-DECORATION: underline overline}"
	mailbody=mailbody &"BODY   {	FONT-FAMILY: ����; FONT-SIZE: 9pt;}"
	mailbody=mailbody &"TD	   {	FONT-FAMILY: ����; FONT-SIZE: 9pt	}</style>"
	mailbody=mailbody &"<TABLE border=0 width='95%' align=center><TBODY><TR>"
	mailbody=mailbody &"<TD valign=middle align=top>"
	mailbody=mailbody &""&htmlencode(username)&"�����ã�<br><br>"
	mailbody=mailbody &"��ӭ��ע�᱾��̳�����ǽ��ṩ������õ���̳����<br>"
	mailbody=mailbody &"����������ע����Ϣ��<br>"
	mailbody=mailbody &"ע������"&htmlencode(username)&"<br>"
	if cint(Emailreg)=1 then
	mailbody=mailbody &"��  �룺"&htmlencode(rndnum)&"<br>"
	else
	mailbody=mailbody &"��  �룺"&htmlencode(request("psw"))&"<br>"
	end if
	mailbody=mailbody &"<br><br>"
	mailbody=mailbody &"<center><font color=red>�ٴθ�л��ע�᱾ϵͳ��������һ��������������ϼ�԰��</font>"
	mailbody=mailbody &"</TD></TR></TBODY></TABLE><br><hr width=95% size=1>"
	mailbody=mailbody & Copyright & " &nbsp;&nbsp; " & Version
end sub

sub senduser()
dim sender,title,body
sender=Forumname
title=Forumname&"��ӭ���ĵ���"
body=Forumname&"ȫ�������Ա��ӭ���ĵ���"&chr(10)&"�����κ������뼰ʱ��ϵϵͳ����Ա��"&chr(10)&"�����κ�ʹ���ϵ�������鿴��̳������"&chr(10)&"��л��ע�᱾ϵͳ��������һ��������������ϼ�԰��"
sql="insert into message(incept,sender,title,content,sendtime,flag,issend) values('"&username&"','"&sender&"','"&title&"','"&body&"',Now(),0,1)"
conn.Execute(sql)
end sub

sub reginfo()
%>
<table cellpadding=0 cellspacing=0 border=0 width="<%=tablewidth%>" bgcolor=<%=Tablebackcolor%> align=center>
        <tr>
            <td>
                
<table cellpadding=3 cellspacing=1 border=0 width=100%>
<TBODY> 
<TR align=middle bgcolor=<%=Tabletitlecolor%>> 
<TD colSpan=2 height=24><font color="<%=TablefontColor%>"><b>���û�ע��ɹ�</b><br><%=sendmsg%></font></TD>
</TR>
<TR bgcolor=<%=Tablebodycolor%>> 
<TD width=40%><font color="<%=TableContentColor%>"><B>�û���</B>��</font></TD>
<TD width=60%> <font color="<%=TableContentColor%>">
<%=request("name")%></font>
</TR>
<TR bgcolor=<%=Tablebodycolor%>> 
<TD width=40%><font color="<%=TableContentColor%>"><B>����</B>��</font>
</TD>
<TD width=60%> <font color="<%=TableContentColor%>">
<%=request("psw")%>
</font>
</TD>
</TR>
<TR bgcolor=<%=Tablebodycolor%>> 
<TD width=40%><font color="<%=TableContentColor%>"><B>��������</B>��</font></TD>
<TD> <font color="<%=TableContentColor%>">
<%=request("quesion")%></font>
</TD>
</TR>
<TR bgcolor=<%=Tablebodycolor%>> 
<TD width=40%><font color="<%=TableContentColor%>"><B>�����</B>��</font></TD>
<TD> <font color="<%=TableContentColor%>">
<%=request("answer")%></font>
</TD>
</TR>
<TR bgcolor=<%=Tablebodycolor%>> 
<TD width=40%><font color="<%=TableContentColor%>"><B>Email��ַ</B>��</font></TD>
<TD width=60%> <font color="<%=TableContentColor%>">
<%=useremail%></font></TD>
</TR>
<TR bgcolor=<%=Tablebodycolor%>> 
<TD width=40%><font color="<%=TableContentColor%>"><B>�Ա�</B>��</font></TD>
<TD width=60%> <font color="<%=TableContentColor%>">
            <%if sex=1 then%>
            �� 
            <%else%>
            Ů 
            <%end if%></font></TD>
</TR>
<TR bgcolor=<%=Tablebodycolor%>> 
<TD width=40%><font color="<%=TableContentColor%>"><B>ͷ��</B>��</font></TD>
<TD width=60%> 
<img src="<%=face%>"> 
</td>
</TR>
<tr bgcolor=<%=Tablebodycolor%>> 
<td width=40%><font color="<%=TableContentColor%>"><B>�ظ���ʾ</B>��</font></td>
<td width=60%><font color="<%=TableContentColor%>">
<%if showRe=1 then
response.write "��ʾ"
else
response.write "����ʾ"
end if
%></font>
</tr>



<TR bgcolor=<%=Tablebodycolor%>> 
<TD width=40%><font color="<%=TableContentColor%>"><B>ǩ��</B>��</font></TD>
<TD width=60%> <font color="<%=TableContentColor%>">
            <%if trim(request("Signature"))="" then%>
            δ��д 
            <%else%>
            <%=trim(request("Signature"))%> 
            <%end if%></font>
</TD>
</TR>

        <TR align=middle bgcolor=<%=Tabletitlecolor%>> 
          <TD colSpan=2 align=center> <a href=login.asp><font color="<%=TablefontColor%>">���½��̳</font></a> </TD>
        </TR>
</TBODY> 
</TABLE>
</td></tr></table>
<%
end sub
%>
<!--#include file="footer.asp"-->
