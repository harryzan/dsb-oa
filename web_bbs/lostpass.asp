<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!--#include file="inc/char.asp"-->
<!--#include file="inc/email.asp"-->
<!--#include file="inc/theme.asp"-->
<!--#include file="chkuser.asp"-->
<!--#include file="md5.asp"-->
<%
  Errmsg=Errmsg+"<br>"+"<li>ϵͳ��֧���û�����ע�ᣬ����ϵϵͳ����Ա��</li>"
	Founderr=true
	call error()
	response.end
	
	Founderr=false
	dim username,answer,password
	stats="��������"
	call nav()
	call headline(1)
	if founderr then
		call error()
	else
		if request("action")="step1" then
			call step1()
		elseif request("action")="step2" then
			call step2()
		elseif request("action")="step3" then
			call step3()
		else
			call main()
		end if
		if founderr then call error()
	end if
	call endline()

sub step1()
	if request("username")="" then
		Founderr=true
		Errmsg=Errmsg+"<br>"+"<li>�����������û�����"
		exit sub
	else
		username=replace(request("username"),"'","")
	end if
	set rs=conn.execute("Select Quesion,Answer,Username,userclass from [user] where username='"&username&"'")
	if rs.eof and rs.bof then
		Founderr=true
		Errmsg=Errmsg+"<br>"+"<li>��������û����������ڣ����������롣"
	else
		if rs(0)="" or isnull(rs(0)) then
		Founderr=true
		Errmsg=Errmsg+"<br>"+"<li>���û�û����д�������⼰�𰸣�ֻ����д���û����ܼ�����"
		elseif rs(3)>18 then
		Founderr=true
		Errmsg=Errmsg+"<br>"+"<li>�������ܰ���ȡ�����������̳����Ա��ϵ��"
		else
%>
<form action="lostpass.asp?action=step2" method="post"> 
<table cellpadding=0 cellspacing=0 border=0 width="<%=tablewidth%>" bgcolor=<%=Tablebackcolor%> align=center>
    <tr>    
        <td>
        <table cellpadding=6 cellspacing=1 border=0 width=100%>

    <tr>
    <td bgcolor=<%=Tabletitlecolor%> valign=middle colspan=2 align=center><font color="<%=TableFontColor%>">
    <b>ȡ������</b>���ڶ������ش����⣩</font></td></tr>
    <tr>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>"><b>�ʣ��⣺</b></font></td>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>"><%=rs(0)%></font></td>
    </tr>
    <tr>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>"><b>�𣠰���</b></font></td>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><INPUT name="answer" type=text></td>
    </tr>
    <tr>
    <td bgcolor=<%=Tablebodycolor%> colspan=2><font color="<%=TableContentColor%>">
    <b>˵����</b>����д����ȷ������𰸡�</font></td></tr>
    <tr>
    <td bgcolor=<%=Tabletitlecolor%> valign=middle colspan=2 align=center><input type=submit name="submit" value="�� ��"></td></tr>
</table></td></tr></table>
<input type=hidden value="<%=username%>" name=username>
</form>
<%
		end if
	end if
	rs.close
	set rs=nothing
end sub

sub step2()
	if request("username")="" then
		Founderr=true
		Errmsg=Errmsg+"<br>"+"<li>�����������û�����"
		exit sub
	else
		username=replace(request("username"),"'","")
	end if
	if chkpost=false then
   		ErrMsg=ErrMsg+"<Br>"+"<li>���ύ�����ݲ��Ϸ����벻Ҫ���ⲿ�ύ���ԡ�"
   		FoundErr=True
		exit sub
	end if
	if request("answer")="" then
		Founderr=true
		Errmsg=Errmsg+"<br>"+"<li>��������������𰸡�"
		exit sub
	else
		answer=md5(request("answer"))
	end if
	set rs=conn.execute("select answer,quesion,userclass from [user] where username='"&username&"' and answer='"&answer&"'")
	if rs.eof and rs.bof then
		Founderr=true
		Errmsg=Errmsg+"<br>"+"<li>�����������𰸲���ȷ�����������롣"
	else
		if rs(2)>18 then
		Founderr=true
		Errmsg=Errmsg+"<br>"+"<li>�������ܰ���ȡ�����������̳����Ա��ϵ��"
		exit sub
		end if
%>
<form action="lostpass.asp?action=step3" method="post"> 
<table cellpadding=0 cellspacing=0 border=0 width=<%=tablewidth%> bgcolor=<%=Tablebackcolor%> align=center>
    <tr>    
        <td>
        <table cellpadding=6 cellspacing=1 border=0 width=100%>

    <tr>
    <td bgcolor=<%=Tabletitlecolor%> valign=middle colspan=2 align=center><font color="<%=TablefontColor%>">
    <b>ȡ������</b>�����������޸����룩</font></td></tr>
    <tr>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>"><b>�ʣ��⣺</b></font></td>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>"><%=rs(1)%></font></td>
    </tr>
    <tr>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>"><b>�𣠰���</b></font></td>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>"><%=request("answer")%></font></td>
    </tr>
    <tr>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>"><b>�����룺</b></font></td>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><input type=password name=password></td>
    </tr>
    <tr>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>"><b>ȷ�������룺</b></font></td>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><input type=password name=repassword></td>
    </tr>
    <tr>
    <td bgcolor=<%=Tablebodycolor%> colspan=2><font color="<%=TableContentColor%>">
    <b>˵����</b>����д������̳�����룬����ס������д��Ϣ��</font></td></tr>
    <tr>
    <td bgcolor=<%=Tabletitlecolor%> valign=middle colspan=2 align=center><input type=submit name="submit" value="�� ��"></td></tr>
</table></td></tr></table>
<input type=hidden value="<%=request("answer")%>" name=answer>
<input type=hidden value="<%=username%>" name=username>
</form>
<%
	end if
	rs.close
	set rs=nothing
end sub

sub step3()
	if request("username")="" then
		Founderr=true
		Errmsg=Errmsg+"<br>"+"<li>�����������û�����"
		exit sub
	else
		username=replace(request("username"),"'","")
	end if
	if request("answer")="" then
		Founderr=true
		Errmsg=Errmsg+"<br>"+"<li>��������������𰸡�"
		exit sub
	else
		answer=md5(request("answer"))
	end if
	if request("password")="" then
		Founderr=true
		Errmsg=Errmsg+"<br>"+"<li>���������������롣"
		exit sub
	elseif request("repassword")="" then
		Founderr=true
		Errmsg=Errmsg+"<br>"+"<li>���ٴ��������������롣"
		exit sub
	elseif request("password")<>request("repassword") then
		Founderr=true
		Errmsg=Errmsg+"<br>"+"<li>��������������ȷ�ϲ�һ������ȷ������д����Ϣ��"
		exit sub
	else
		password=md5(request("password"))
	end if
	set rs=server.createobject("adodb.recordset")
	sql="select userpassword,quesion,userclass from [user] where username='"&username&"' and answer='"&answer&"'"
	rs.open sql,conn,1,3
	if rs.eof and rs.bof then
		Founderr=true
		Errmsg=Errmsg+"<br>"+"<li>�����������𰸲���ȷ�����������롣"
	else
		if rs(2)>18 then
		Founderr=true
		Errmsg=Errmsg+"<br>"+"<li>�������ܰ���ȡ�����������̳����Ա��ϵ��"
		exit sub
		end if
		rs("userpassword")=password
		rs.update
%>
<form action="login.asp" method="post"> 
<table cellpadding=0 cellspacing=0 border=0 width=<%=tablewidth%> bgcolor=<%=Tablebackcolor%> align=center>
    <tr>    
        <td>
        <table cellpadding=6 cellspacing=1 border=0 width=100%>

    <tr>
    <td bgcolor=<%=Tabletitlecolor%> valign=middle colspan=2 align=center><font color="<%=TablefontColor%>">
    <b>ȡ������</b>�����Ĳ����޸ĳɹ���</font></td></tr>
    <tr>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>"><b>�ʣ��⣺</b></font></td>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>"><%=rs(1)%></font></td>
    </tr>
    <tr>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>"><b>�𣠰���</b></font></td>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>"><%=request("answer")%></font></td>
    </tr>
    <tr>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>"><b>�����룺</b></font></td>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>"><%=request("password")%></font></td>
    </tr>
    <tr>
    <td bgcolor=<%=Tablebodycolor%> colspan=2><font color="<%=TableContentColor%>">
    <b>˵����</b>���ס���������벢ʹ��������<a href=login.asp>��½��̳</a>��</font></td></tr>
    <tr>
    <td bgcolor=<%=Tabletitlecolor%> valign=middle colspan=2 align=center><input type=submit name="submit" value="�� ��"></td></tr>
</table></td></tr></table>
</form>
<%
	end if
	rs.close
	set rs=nothing
end sub

sub main()
%>
<form action="lostpass.asp?action=step1" method="post"> 
<table cellpadding=0 cellspacing=0 border=0 width="<%=tablewidth%>" bgcolor=<%=Tablebackcolor%> align=center>
    <tr>    
        <td>
        <table cellpadding=6 cellspacing=1 border=0 width=100%>

    <tr>
    <td bgcolor=<%=Tabletitlecolor%> valign=middle colspan=2 align=center><font color="<%=TablefontColor%>">
    <b>ȡ������</b>����һ�����û�����</font></td></tr>
    <tr>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>">�����������û���</font></td>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><INPUT name="username" type=text></td>
    </tr>
    <tr>
    <td bgcolor=<%=Tablebodycolor%> colspan=2><font color="<%=TableContentColor%>">
    <b>˵����</b>������ֻ���޸��������룬���ܶ�ԭ��������޸ģ���ȷ�����Ѿ���д���������⼰�𰸡�</font></td></tr>
    <tr>
    <td bgcolor=<%=Tabletitlecolor%> valign=middle colspan=2 align=center><input type=submit name="submit" value="�� ��"></td></tr>
</table></td></tr></table>
</form>
<%
end sub
%>
<!--#include file="footer.asp"-->