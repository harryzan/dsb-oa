<!--#include file="conn.asp"-->
<!--#include file="inc/const.asp"-->
<!--#include file="inc/char.asp"-->
<!--#include file="chkuser.asp"-->
<!--#include file="inc/theme.asp"-->
<!-- #include file="inc/chkinput.asp" -->
<!--#include file="md5.asp"-->
<%
	dim msg
	stats="����С�ֱ�"
	call nav()
	if boardid=0 then
	founderr=true
	Errmsg=Errmsg+"<br><li>��ѡ����Ҫ����С�ֱ��İ��棡"
	end if
	if cint(smallpaper)=0 then
	founderr=true
	Errmsg=Errmsg+"<br><li>�ð���û�п���С�ֱ����ܣ�"
	end if
	if smallpaper_g=1 then
	msg="�����������˾��ɷ���С�ֱ�"
		if membername<>"" then
		membername=membername
		else
		membername="����"
		end if
	else
	msg="������ֻ�����Ա����С�ֱ�"
	membername=membername
	end if
	if founderr then
	call headline(1)
	call error()
	else
		call headline(2)
		if request("action")="savepaper" then
			call savepaper()
			if founderr then call error()
		else
			call main()
		end if
	end if
	call endline()
	sub main()
	conn.execute("delete from SmallPaper where datediff('d',s_addtime,Now())>1")
%>
<form action="smallpaper.asp?action=savepaper" method="post"> 
<table cellpadding=0 cellspacing=0 border=0 width="<%=tablewidth%>" bgcolor=<%=Tablebackcolor%> align=center>
    <tr>    
        <td>
        <table cellpadding=6 cellspacing=1 border=0 width=100%>
    <tr>
    <td bgcolor=<%=Tabletitlecolor%> valign=middle colspan=2 align=center><font color="<%=TableFontColor%>">
    <b>����ϸ��д������Ϣ</b>(<%=msg%>)</font></td></tr>
    <tr>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>"><b>�û���</b></font></td>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><INPUT name=username type=text value="<%=membername%>"> &nbsp; <a href="reg.asp">û��ע�᣿</a></td></tr>
    <tr>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>"><b>�� ��</b></font></td>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><INPUT name=password type=password value="<%=memberword%>"> &nbsp; <a href="lostpass.asp">�������룿</a></td></tr>
    <tr>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>"><b>�� ��</b>(���80��)</font></td>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><INPUT name="title" type=text size=60></td></tr>
    <tr>
    <td bgcolor=<%=Tablebodycolor%> valign=top width=30%>
<font color="<%=TableContentColor%>"><b>�� ��</b><BR>
�ڱ��淢��С�ֱ���������<font color="<%=AlertFontColor%>"><b><%=smallpaper_m%></b></font>Ԫ����<br>
<font color="<%=AlertFontColor%>"><b>48</b></font>Сʱ�ڷ����С�ֱ��������ȡ<font color="<%=AlertFontColor%>"><b>5</b></font>��������ʾ����̳��<br>
<li>HTML��ǩ�� <%if strAllowHTML=0 then%>������<%else%>����<%end if%>
<li>UBB ��ǩ�� <%if strAllowForumCode=0 then%>������<%else%>����<%end if%>
<li>���ݲ��ó���500��
</font></td>
    <td bgcolor=<%=Tablebodycolor%> valign=middle>
<textarea class="smallarea" cols="60" name="Content" rows="8" wrap="VIRTUAL"></textarea>
<INPUT name="boardid" type=hidden value="<%=boardid%>">
                </td></tr>
    <tr>
    <td bgcolor=<%=Tabletitlecolor%> valign=middle colspan=2 align=center><input type=submit name="submit" value="�� ��"></td></tr></table></td></tr></table>
</form>
<%end sub%>
<%
sub savepaper()
	dim username
	dim password
	dim title
	dim content
   	UserName=Checkstr(trim(request.form("username")))
   	PassWord=Checkstr(trim(request.form("password")))
   	Title=Checkstr(trim(request.form("title")))
   	Content=Checkstr(request.form("Content"))
	if chkpost=false then
   		ErrMsg=ErrMsg+"<Br>"+"<li>���ύ�����ݲ��Ϸ����벻Ҫ���ⲿ�ύ���ԡ�"
   		FoundErr=True
	end if
	if UserName="" then
   		ErrMsg=ErrMsg+"<Br>"+"<li>����������"
   		FoundErr=True
	end if
	if title="" then
   		FoundErr=True
      		ErrMsg=ErrMsg+"<Br>"+"<li>���ⲻӦΪ�ա�"
	elseif strLength(title)>80 then
   		FoundErr=True
      		ErrMsg=ErrMsg+"<Br>"+"<li>���ⳤ�Ȳ��ܳ���80"
	end if
	if content="" then
		ErrMsg=ErrMsg+"<Br>"+"<li>û����д���ݡ�"
   		FoundErr=true
	elseif strLength(content)>500 then
   		ErrMsg=ErrMsg+"<Br>"+"<li>�������ݲ��ô���500"
   		FoundErr=true
	end if
	'���˲���������֤�û�
	if not founderr and Cint(smallpaper_g)=0 then
		if PassWord<>memberword then
		password=md5(password)
		end if
		set rs=server.createobject("adodb.recordset")
		sql="Select userWealth From [User] Where UserName='"&UserName&"' and UserPassWord='"&PassWord&"'"
		rs.open sql,conn,1,3
		if rs.eof and rs.bof then
   		ErrMsg=ErrMsg+"<Br>"+"<li>��������û��������벻��ȷ�����������롣"
   		FoundErr=true
		else
			if Clng(rs("UserWealth"))<Clng(SmallPaper_m) then
   			ErrMsg=ErrMsg+"<Br>"+"<li>��û���㹻�Ľ�Ǯ������С�ֱ����쵽��̳����ˮ�ɡ�"
   			FoundErr=true
			else
			rs("UserWealth")=rs("UserWealth")-Cint(SmallPaper_m)
			rs.update	
			end if
		end if
		rs.close
		set rs=nothing
	end if
	if founderr then
		exit sub
	else
		sql="insert into smallpaper (s_boardid,s_username,s_title,s_content) values "&_
		"("&_
		boardid&",'"&_
		username&"','"&_
		title&"','"&_
		content&"')"
		'response.write sql
		conn.execute(sql)
  		if err.number<>0 then
	       		err.clear
			ErrMsg=ErrMsg+"<Br>"+"<li>���ݿ����ʧ�ܣ����Ժ�����"&err.Description
			founderr=true
  	       		exit sub
		else
			call success()
    		end if
	end if
end sub
sub success()
	response.write "<meta http-equiv=refresh content=""4;URL=list.asp?boardid="&boardid&""">"

	response.write "<br><table cellpadding=0 cellspacing=0 border=0 width="&tablewidth&" bgcolor="&tablebackcolor&" align=center>"&_
		"<tr><td><table cellpadding=3 cellspacing=1 border=0 width=""100%"">"&_
		"<tr align=center><td width=""100%"" bgcolor="&tabletitlecolor&"><b><FONT COLOR="&TableFontcolor&">״̬��������С�ֱ��ɹ�</font></b></td>"&_
		"</tr><tr><td width=""100%"" bgcolor="&tablebodycolor&">"&_
		"<FONT COLOR="&TableContentcolor&">��ҳ�潫��3����Զ�������������İ��棬<b>������ѡ�����²�����</b><br><ul>"&_
		"<li><a href=""index.asp""><font color="""&TableContentcolor&""">������ҳ</font></a></li>"&_
		"<li><a href=""list.asp?boardid="&boardid&"""><font color="""&TableContentcolor&""">"&boardtype&"</font></a></li>"&_
		"</ul></td></tr></table></td></tr></table>"
end sub
%>
<!--#include file="footer.asp"-->