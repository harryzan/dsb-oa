<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=chkuser.asp-->
<!-- #include file="admin_config.asp" -->
<title><%=ForumName%>--����ҳ��</title>
<!--#include file="Forum_css.asp"-->

<BODY  <%=ForumBody%>>
<%
	if not master or instr(session("flag"),"05")=0 then
		Errmsg=Errmsg+"<br>"+"<li>��ҳ��Ϊ����Աר�ã���<a href=admin_index.asp target=_top>��½</a>����롣<br><li>��û�й���ҳ���Ȩ�ޡ�"
		call Error()
	else
		dim body
		if request("action")="alldel" then
			call alldel()
		elseif request("action")="userdel" then
			call del()
		elseif request("action")="alldelTopic" then
			call alldelTopic()
		elseif request("action")="delUser" then
			call delUser()
		else
		call main()
		end if
		conn.close
		set conn=nothing
	end if

	sub main()
%>
<p>��</p>
            <table cellpadding=0 cellspacing=0 border=0 width="<%=tablewidth%>" bgcolor="<%=TableBackColor%>" align=center>
            <tr><td>
            <table cellpadding=6 cellspacing=1 border=0 width=100%>
            <tr>
            <td bgcolor="<%=TableTitleColor%>" valign=middle colspan=2 align=center>
            <font color="<%=TableFontcolor%>">
            <b>��������ϸ�����Ա����ɾ��ģʽ[����ɾ��]</b></font></td></tr>
            <tr>
            <td bgcolor="<%=TableBodyColor%>" valign=middle colspan=2><font color="<%=TableContentcolor%>"><b>������뻹ԭ���ӣ��뵽��̳����վ��</b>
            <br>���������������ɾ����̳���ӡ������ȷ��������������ϸ������������Ϣ��</font></td>
            <form action="admin_alldel.asp?action=userdel" method="post">
            <tr>
            <td bgcolor="<%=TableBodyColor%>" valign=middle><font color="<%=TableContentcolor%>">�������û�����ɾ��ĳ�û�����������</font></td>
            <td bgcolor="<%=TableBodyColor%>" valign=middle><input type=text name="username"> <input type=submit name="submit" value="�� ��"></td></tr></form>
<form action="admin_alldel.asp?action=alldel" method="post">
            <tr>
                <td bgcolor="<%=TableBodyColor%>" valign=middle><font color="<%=TableContentcolor%>">ɾ��ָ������������</font></td>
            <td bgcolor="<%=TableBodyColor%>" valign=middle>
<select name=TimeLimited size=1> 
<option value=all>ɾ�����е�����
<option value=1>ɾ��һ��ǰ������
<option value=2>ɾ������ǰ������
<option value=7>ɾ��һ����ǰ������
<option value=15>ɾ�������ǰ������
<option value=30>ɾ��һ����ǰ������
<option value=60>ɾ��������ǰ������
<option value=180>ɾ������ǰ������
</select>
</select><input type=submit name="submit" value="�� ��"></td></tr></form>
<form action="admin_alldel.asp?action=alldelTopic" method="post">
            <tr>
                <td bgcolor="<%=TableBodyColor%>" valign=middle><font color="<%=TableContentcolor%>">ɾ��ָ��������û�лظ�������</font></td>
            <td bgcolor="<%=TableBodyColor%>" valign=middle>
<select name=TimeLimited size=1> 
<option value=all>ɾ�����е�
<option value=1>ɾ��һ��ǰ��
<option value=2>ɾ������ǰ��
<option value=7>ɾ��һ����ǰ��
<option value=15>ɾ�������ǰ��
<option value=30>ɾ��һ����ǰ��
<option value=60>ɾ��������ǰ��
<option value=180>ɾ������ǰ��
</select>
</select><input type=submit name="submit" value="�� ��"></td></tr></form>
<form action="admin_alldel.asp?action=delUser" method="post">
            <tr>
            <td bgcolor="<%=TableBodyColor%>" valign=middle><font color="<%=TableContentcolor%>">ɾ��ָ��������û�е�½���û�</font></td>
            <td bgcolor="<%=TableBodyColor%>" valign=middle>
<select name=TimeLimited size=1> 
<option value=all>ɾ�����е�
<option value=1>ɾ��һ��ǰ��
<option value=2>ɾ������ǰ��
<option value=7>ɾ��һ����ǰ��
<option value=15>ɾ�������ǰ��
<option value=30>ɾ��һ����ǰ��
<option value=60>ɾ��������ǰ��
<option value=180>ɾ������ǰ��
</select>
</select><input type=submit name="submit" value="�� ��"></td></tr></form>
</table></td></tr></table>
<%
	end sub
	sub del()
		dim titlenum
		if request("username")="" then
			founderr=true
			errmsg=errmsg+"<br>"+"<li>�����뱻����ɾ���û�����"
			exit sub
		end if
    		rs=conn.execute("Select Count(announceID) from bbs1 where username='"&replace(request("username"),"'","")&"'") 
    		titlenum=rs(0) 
		if isnull(titlenum) then titlenum=0
		sql="update bbs1 set locktopic=2 where username='"&replace(request("username"),"'","")&"'"
		conn.Execute(sql)
		sql="update [user] set article=article-"&titlenum&",userWealth=userWealth-"&titlenum*wealthDel&",userEP=userEP-"&titlenum*epDel&",userCP=userCP-"&titlenum*cpDel&" where username='"&replace(request("username"),"'","")&"'"
		conn.Execute(sql)
		call success()
	end sub

	sub alldel()
	Dim TimeLimited
	TimeLimited=request.form("TimeLimited")
	if TimeLimited="all" then
	conn.execute("update bbs1 set LockTopic=2")
	else
	conn.execute("update bbs1 set LockTopic=2 where datediff('d',DateAndTime,Now())>"&TimeLimited&"")
	end if
	call success()
	end sub
	sub alldelTopic()
	Dim TimeLimited
	TimeLimited=request.form("TimeLimited")
	if TimeLimited="all" then
	conn.execute("update bbs1 set LockTopic=2 where ParentID=0 and Child=0")
	else
	conn.execute("update bbs1 set LockTopic=2 where ParentID=0 and Child=0 and  datediff('d',DateAndTime,Now())>"&TimeLimited&"")
	end if
	call success()
	end sub

	sub delUser()
	Dim TimeLimited
	TimeLimited=request.form("TimeLimited")
	if TimeLimited="all" then
	conn.execute("delete from [user]")
	else
	conn.execute("delete from [user] where datediff('d',LastLogin,Now())>"&TimeLimited&"")
	end if
	call success()
	end sub

	sub success()
%>
            <table cellpadding=0 cellspacing=0 border=0 width="<%=tablewidth%>" bgcolor="<%=Tablebackcolor%>" align=center>
            <tr><td>
            <table cellpadding=6 cellspacing=1 border=0 width=100%>
            <tr>
            <td bgcolor="<%=Tabletitlecolor%>" valign=middle colspan=2 align=center>
            <font color="<%=TableFontcolor%>">ɾ���ɹ������Ҫ��ȫɾ�������뵽��̳����վ<BR>��������������̳�����и���һ����̳���ݣ�����<a href=admin_alldel.asp><font color="<%=TableFontcolor%>">����</font></a></font></td></tr>
</table>
            </table></td></tr></table>
<%
	end sub
%>
<!--#include file="footer.asp"-->