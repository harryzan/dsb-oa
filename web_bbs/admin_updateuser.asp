<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!-- #include file="inc/char.asp" -->
<!--#include file="inc/grade.asp"-->
<!--#include file=chkuser.asp-->
<title><%=ForumName%>--����ҳ��</title>
<!--#include file="Forum_css.asp"-->

<BODY <%=ForumBody%>>
<%
	server.scriptTimeout=999999
	if not master or instr(session("flag"),"15")=0 then
		Errmsg=Errmsg+"<br>"+"<li>��ҳ��Ϊ����Աר�ã���<a href=admin_index.asp target=_top>��½</a>����롣<br><li>��û�й���ҳ���Ȩ�ޡ�"
		call Error()
	else
		dim body
		dim tmprs
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
        <td align=center colspan="2"><font color="<%=TablefontColor%>">��ӭ<b><%=membername%></b>�������ҳ��</font>
        </td>
        </tr>
            <tr bgcolor=<%=tablebodycolor%>>
              <td width="100%" valign=top><p><font color="<%=TableContentColor%>">
<%
	if request("action")="updat" then
		if request("submit")="���¼����û�����" then
		call updateTopic()
		elseif request("submit")="�����û��ȼ�" then
		call updategrade()
		else
		call updatemoney()
		end if
		response.write ""&body&""
	else
%>
              <table width="100%" border="0" cellspacing="3" cellpadding="0">
                <tr> 
                  <td bgcolor=<%=atabletitlecolor%>> <font color="<%=TableContentColor%>">
                    <p><b>�����û�����</b>��ִ�����в����Ƚ����ķ�������Դ������������ǳ��������½����ĸ������Դ��ʱ�䣬��������ʹ�ô�����</p></font>
                  </td>
                </tr>
                <tr> 
                  <td> <font color="<%=TableContentColor%>">
<form action="admin_updateuser.asp?action=updat" method=post>
<input type="submit" name="Submit" value="���¼����û�����">&nbsp;<BR><BR>ִ�б�������������̳�������¼��������û���������������<BR><BR>
<input type="submit" name="Submit" value="�����û��ȼ�">&nbsp;<BR><BR>ִ�б������������û�������������̳�ĵȼ��������¼����û��ȼ�����������Ӱ��ȼ�Ϊ������������ܰ��������ݡ�<BR><BR>
<input type="submit" name="Submit" value="�����û���Ǯ/����/����">&nbsp;<BR><BR>ִ�б������������û��ķ�����������̳������������¼����û��Ľ�Ǯ/����/������������Ҳ�����¼��������������ܰ��������ݣ�ע�⣺<font color=red>���Ƽ��û����б������������������ݺܶ��ʱ���뾡����Ҫʹ�ã����ұ������Ը�������ɾ�����ӵ�������Ӧ��ֵ�������㣬ֻ�ǰ��շ������ܵ���̳��ֵ���ý������㣬�������ز���</font>��
</form></font>
                  </td>
                </tr>
<%
	end if
%></font>
</p></td>
            </tr>
        </table>
        </td>
    </tr>
</table>
<%
'	response.write ""&body&""
	end sub

	sub updateTopic()
	dim userTopic
	'conn.execute("update [user] set article="&allnum(username)&"")
	set rs=server.createobject("adodb.recordset")
	sql="select username from [user] order by userid desc"
	rs.open sql,conn,1,1
	do while not rs.eof
		userTopic=allnum(rs(0))
		conn.execute("update [user] set article="&userTopic&" where username='"&rs(0)&"'")
	rs.movenext
	loop
	rs.close
	set rs=nothing
	body=body+"<br>"+"�����û����ݳɹ�("&now()&")��"
	end sub

	sub updatemoney()
	dim userTopic,userReply,userWealth
	dim userEP,userCP
	set rs=server.createobject("adodb.recordset")
	sql="select username,logins from [user] order by userid desc"
	rs.open sql,conn,1,1
	do while not rs.eof
		userTopic=TopicNum(rs(0))
		userreply=replyNum(rs(0))
		userwealth=rs(1)*wealthLogin + userTopic*wealthAnnounce + userreply*wealthReannounce
		userEP=rs(1)*epLogin + userTopic*epAnnounce + userreply*epReAnnounce
		userCP=rs(1)*cpLogin + userTopic*cpAnnounce + userreply*cpReAnnounce
		conn.execute("update [user] set userWealth="&userWealth&",userep="&userep&",usercp="&usercp&" where username='"&rs(0)&"'")
	rs.movenext
	loop
	rs.close
	set rs=nothing
	body=body+"<br>"+"�����û����ݳɹ�("&now()&")��"
	end sub

	sub updategrade()
	conn.execute("update [user] set userclass=1 where article<0")

	conn.execute("update [user] set userclass=1 where (article>="&point(1)&" and article<"&point(2)&") and not (userclass=18 or userclass=19 or  userclass=20)")
	conn.execute("update [user] set userclass=2 where (article>="&point(2)&" and article<"&point(3)&") and not (userclass=18 or userclass=19 or  userclass=20)")
	conn.execute("update [user] set userclass=3 where (article>="&point(3)&" and article<"&point(4)&") and not (userclass=18 or userclass=19 or  userclass=20)")
	conn.execute("update [user] set userclass=4 where (article>="&point(4)&" and article<"&point(5)&") and not (userclass=18 or userclass=19 or  userclass=20)")
	conn.execute("update [user] set userclass=5 where (article>="&point(5)&" and article<"&point(6)&") and not (userclass=18 or userclass=19 or  userclass=20)")
	conn.execute("update [user] set userclass=6 where (article>="&point(6)&" and article<"&point(7)&") and not (userclass=18 or userclass=19 or  userclass=20)")
	conn.execute("update [user] set userclass=7 where (article>="&point(7)&" and article<"&point(8)&") and not (userclass=18 or userclass=19 or  userclass=20)")
	conn.execute("update [user] set userclass=8 where (article>="&point(8)&" and article<"&point(9)&") and not (userclass=18 or userclass=19 or  userclass=20)")
	conn.execute("update [user] set userclass=9 where (article>="&point(9)&" and article<"&point(10)&") and not (userclass=18 or userclass=19 or  userclass=20)")
	conn.execute("update [user] set userclass=10 where (article>="&point(10)&" and article<"&point(11)&") and not (userclass=18 or userclass=19 or  userclass=20)")	
	conn.execute("update [user] set userclass=11 where (article>="&point(11)&" and article<"&point(12)&") and not (userclass=18 or userclass=19 or  userclass=20)")
	conn.execute("update [user] set userclass=12 where (article>="&point(12)&" and article<"&point(13)&") and not (userclass=18 or userclass=19 or  userclass=20)")
	conn.execute("update [user] set userclass=13 where (article>="&point(13)&" and article<"&point(14)&") and not (userclass=18 or userclass=19 or  userclass=20)")
	conn.execute("update [user] set userclass=14 where (article>="&point(14)&" and article<"&point(15)&") and not (userclass=18 or userclass=19 or  userclass=20)")
	conn.execute("update [user] set userclass=15 where (article>="&point(15)&" and article<"&point(16)&") and not (userclass=18 or userclass=19 or  userclass=20)")
	conn.execute("update [user] set userclass=16 where (article>="&point(16)&" and article<"&point(17)&") and not (userclass=18 or userclass=19 or  userclass=20)")

	conn.execute("update [user] set userclass=17 where article>="&point(17)&" and not (userclass=18 or userclass=19 or  userclass=20)")
	body=body+"<br>"+"�����û����ݳɹ�("&now()&")��"
	end sub

	function TopicNum(username)
	set tmprs=conn.execute("select count(announceid) from bbs1 where ParentID=0 and username='"&username&"'")
	TopicNum=tmprs(0)
	if isnull(TopicNum) then TopicNum=0
	set tmprs=nothing
	end function
	function replyNum(username)
	set tmprs=conn.execute("select count(announceid) from bbs1 where not ParentID=0 and username='"&username&"'")
	replyNum=tmprs(0)
	if isnull(replyNum) then replyNum=0
	set tmprs=nothing
	end function
	function allnum(username)
	set tmprs=conn.execute("select count(announceid) from bbs1 where username='"&username&"'")
	allnum=tmprs(0)
	if isnull(allnum) then allnum=0
	set tmprs=nothing
	end function
%>