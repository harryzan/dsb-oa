<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!--#include file="inc/char.asp"-->
<!--#include file="inc/theme.asp"-->
<!--#include file="chkuser.asp"-->
<%
	dim topicid
	stats="���ӹ���"
	topicid=request("topicid")
	if request("action")<>"��ջ���վ" then
		if topicid="" or isnull(topicid) then
		Errmsg=Errmsg+"<li>"+"��ѡ��������Ӻ���в�����"
		Founderr=true
		end if
	end if
	if not master then
	Errmsg=Errmsg+"<li>"+"������ϵͳ����Ա��������û�е�½��"
	Founderr=true
	end if
	call nav()
	call headline(1)
	if founderr=true then
		call error()
	else
		if request("action")="ɾ��" then
			call delete()
		elseif request("action")="��ԭ" then
			call redel()
		elseif request("action")="��ջ���վ" then
			call Alldel()
		else
		Errmsg=Errmsg+"<li>"+"��ָ�����������"
		Founderr=true
		end if
		if founderr=true then call error()
	end if
	call endline()
	sub delete()
	conn.execute("delete from bbs1 where Announceid in ("&TopicID&")")

	sql="insert into log (l_username,l_content) values ('"&membername&"','��ȫɾ������')"
	conn.execute(sql)
	call success()
	end sub

	sub redel()
	sql="update bbs1 set locktopic=0 where Announceid in ("&TopicID&")"
	conn.execute(sql)

	set rs=conn.execute("select username from bbs1 where Announceid in ("&TopicID&")")
	do while not rs.eof
	sql="update [user] set article=article+1,userWealth=userWealth+"&wealthDel&",userEP=userEP+"&epDel&" where username='"&rs(0)&"'"
	conn.execute(sql)
	rs.movenext
	loop
	set rs=nothing
	sql="insert into log (l_username,l_content) values ('"&membername&"','��ԭ����')"
	conn.execute(sql)
	call success()
	end sub

	sub AllDel()
	conn.execute("delete from bbs1 where locktopic=2")

	sql="insert into log (l_username,l_content) values ('"&membername&"','��ջ���վ')"
	conn.execute(sql)
	call success()
	end sub

sub success()
%>
    <table cellpadding=0 cellspacing=0 border=0 width=<%=tablewidth%> bgcolor=<%=Tablebackcolor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
    <tr align="center"> 
      <td width="100%" bgcolor=<%=Tabletitlecolor%>><font color="<%=TablefontColor%>">�ɹ������Ӳ���</font></td>
    </tr>
    <tr> 
      <td width="100%" bgcolor=<%=Tablebodycolor%>><font color="<%=TableContentColor%>"><li>���Ӳ����ɹ���<li>���Ĳ�����Ϣ�Ѿ���¼�ڰ���<br></font>
      </td>
    </tr>
    <tr align="center"> 
      <td width="100%" bgcolor=<%=Tabletitlecolor%>>
<a href="recycle.asp"><font color="<%=TablefontColor%>"> << ���ػ���վ</font></a>
      </td>
    </tr>  
    </table>   </td></tr></table>
<%
end sub
%>
<!--#include file="footer.asp"-->
