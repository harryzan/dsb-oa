<!-- #include file="conn.asp" -->
<!-- #include file="inc/char.asp" -->
<!-- #include file="inc/const.asp" -->
<!-- #include file="chkuser.asp" -->
<!--#include file="inc/theme.asp"-->
<!--#include file="inc/voteForm.asp"-->
<!-- #include file="inc/char_board.asp" -->
<%
	rem ----------------------
	rem ------������ʼ------
	rem ----------------------

	dim boardstat
   	boardid=request("boardid")
	if BoardID="" or not isInteger(BoardID) then
		BoardID=1
	else
		BoardID=clng(BoardID)
		if err then
			BoardID=1
			err.clear
		end if
	end if

	select case boardskin
	case 1
		boardstat="������̳��ֻ����<a href=reg.asp>ע���Ա</a>����"
	case 2
		boardstat="������̳�����������˷���"
	case 3
		boardstat="������̳��̳���Ͱ��������ԣ�����<a href=reg.asp>ע���û�</a>ֻ�ܻظ�"
		if not(boardmaster or master) then
		Founderr=true
		Errmsg=Errmsg+"<br>"+"<li>������̳��̳���Ͱ��������ԣ�����<a href=reg.asp>ע���û�</a>ֻ�ܻظ�"
		end if
	case 4
		boardstat="��������ֻ���������̳�����ԺͲ���"
		if not(boardmaster or master) then
		Founderr=true
		Errmsg=Errmsg+"<br>"+"<li>��������ֻ���������̳�����ԺͲ���"
		end if
	case 5
		boardstat="��֤��̳����̳���Ͱ����⣬����<a href=reg.asp>ע���û�</a>��½��̳��Ҫ��֤"
		if membername="" then
			founderr=true
			Errmsg=Errmsg+"<br>"+"<li>����̳Ϊ��֤��̳����<a href=login.asp>��½</a>��ȷ�������û����Ѿ��õ�����Ա����֤����롣"
		else
			if chkboardlogin(boardid,membername)=false then
			founderr=true
			Errmsg=Errmsg+"<br>"+"<li>����̳Ϊ��֤��̳����ȷ�������û����Ѿ��õ�����Ա����֤����롣"
			end if
		end if
	case 6
		boardstat="������̳��ֻ��<a href=login.asp>��½�û�</a>���������̳������"
		if membername="" then
		Founderr=true
		Errmsg=Errmsg+"<br>"+"<li>������̳��ֻ��<a href=login.asp>��½�û�</a>���������̳������"
		end if
	end select
	
	stats=""&boardtype&"����ͶƱ"
	if founderr then
		call nav()
		call headline(2)
		call error()
	else
		call nav()
		call headline(2)
		call showvoteForm()
	end if
	call endline()

   	rem ----------------------
	rem ------���������------
	rem ----------------------
%>

<!--#include file="footer.asp"-->