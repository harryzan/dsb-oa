<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=chkuser.asp-->
<title><%=ForumName%>--����ҳ��</title>
<!--#include file="Forum_css.asp"-->

<BODY <%=ForumBody%>>
<%
	if not master or instr(session("flag"),"02")=0 then
		Errmsg=Errmsg+"<br>"+"<li>��ҳ��Ϊ����Աר�ã���<a href=admin_index.asp target=_top>��½</a>����롣<br><li>��û�й���ҳ���Ȩ�ޡ�"
		call Error()
	else
		dim tmprs
		dim body
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
        <td><font color="<%=TablefontColor%>">��ӭ<b><%=membername%></b>�����������</font>
        </td>
        </tr>
            <tr bgcolor=<%=tablebodycolor%>>
              <td width="100%" valign=top><p><font color="<%=TableContentColor%>">
<%
	if request("action")="updat" then
		if request("submit")="������̳����" then
		call updateboard()
		else
		call updateall()
		end if
		response.write body
	else
%>
              <table width="100%" border="0" cellspacing="3" cellpadding="0">
                <tr> 
                  <td bgcolor=<%=atabletitlecolor%>> 
                    <font color="<%=TableContentColor%>"><p><b>������̳����</b>��</p></font>
                  </td>
                </tr>
                <tr> 
                  <td> <font color="<%=TableContentColor%>">
            <form action="admin_updateboard.asp?action=updat" method=post>
<input type="submit" name="Submit" value="������̳����">&nbsp;<BR><BR>���ｫ���¼���ÿ����̳����������ͻظ������������ӣ����ظ���Ϣ�ȣ�����ÿ��һ��ʱ������һ�Ρ�
<BR><BR>
<input type="submit" name="Submit" value="������̳������">&nbsp;<BR><BR>���ｫ���¼���������̳����������ͻظ������������ӣ��������û��ȣ�����ÿ��һ��ʱ������һ�Ρ�
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

	sub updateboard()
	dim allarticle
	dim alltopic
	dim Ers,Esql
	dim Maxid
	dim lastpost
	dim username,dateandtime,rootid,topic
	set rs=server.createobject("adodb.recordset")
	sql="select boardid,boardtype from board"
	rs.open sql,conn,1,1
	if rs.eof and rs.bof then
		Errmsg=Errmsg+"<br>"+"<li>��̳��û�а��棬������Ӱ��档"
		call error()
		exit sub
	else
	do while not rs.eof
    	tmprs=conn.execute("Select count(announceid) from bbs1 where boardid="&rs("boardid")&"")
    	allarticle=tmprs(0)
	set tmprs=nothing
	if isnull(allarticle) then allarticle=0
    	tmprs=conn.execute("Select count(announceid) from bbs1 where boardid="&rs("boardid")&" and parentID=0")
    	alltopic=tmprs(0)
	set tmprs=nothing
	if isnull(alltopic) then alltopic=0

	set Ers=server.createobject("adodb.recordset")
	Ers=conn.execute("select Max(announceid) from bbs1 where boardid="&rs("boardid")&"")
	Maxid=Ers(0)

	if isnull(Maxid) then
	username="��"
	dateandtime=now()
	rootid=0
	topic="��"
	else
	Ers=conn.execute("select username,dateandtime,rootid,topic,body from bbs1 where announceid="&Maxid&"")
	username=Ers("username")
	dateandtime=Ers("dateandtime")
	rootid=Ers("rootid")
		if Ers("topic")="" then
		topic=left(Ers("body"),20)
		else
		topic=left(Ers("topic"),20)
		end if
	end if

	LastPost=username & "$" & rootid & "$" & dateandtime & "$" & replace(topic,"$","") & "$"
	Esql="update board set lastbbsnum="&allarticle&",lasttopicnum="&alltopic&",TodayNum="&todays(rs("boardid"))&",LastPost='"&LastPost&"' where boardid="&rs("boardid")&""
	'response.write esql
	conn.execute(Esql)
	body=body &"������̳���ݳɹ���"&rs("boardtype")&"����"&allarticle&"ƪ���ӣ�"&alltopic&"ƪ���⣬������"&todays(rs("boardid"))&"ƪ���ӡ�<br>"
	rs.movenext
	loop
	end if
	rs.close
	set rs=nothing
	end sub

	sub updateall()
	sql="update config set TopicNum="&titlenum()&",BbsNum="&gettipnum()&",TodayNum="&alltodays()&",UserNum="&allusers()&",lastUser='"&newuser()&"'"
	conn.execute(sql)
	body=body &"��������̳���ݳɹ���ȫ����̳����"&gettipnum()&"ƪ���ӣ�"&titlenum()&"ƪ���⣬������"&alltodays()&"ƪ���ӣ���"&allusers()&"�û������¼���Ϊ"&newuser()&"��<br>"
	end sub
function todays(boardid)
    	tmprs=conn.execute("Select count(announceid) from bbs1 Where datediff('d',dateandtime,Now())=0 and boardid="&boardid&"")
    	todays=tmprs(0)
	set tmprs=nothing
	if isnull(todays) then todays=0
end function
function alltodays()
    	tmprs=conn.execute("Select count(announceid) from bbs1 Where datediff('d',dateandtime,Now())=0")
    	alltodays=tmprs(0)
	set tmprs=nothing
	if isnull(alltodays) then alltodays=0
end function

function allusers() 
    	tmprs=conn.execute("Select count(userid) from [user]") 
    	allusers=tmprs(0) 
	set tmprs=nothing 
	if isnull(allusers) then allusers=0 
end function 
function newuser()
	set tmprs=server.createobject("adodb.recordset")
    	sql="Select top 1 username from [user] order by userid desc"
	tmprs.open sql,conn,1,1
	if tmprs.eof and tmprs.bof then
	newuser="û�л�Ա"
	else
    	newuser=tmprs("username")
	end if
	set tmprs=nothing
end function 

function gettipnum() 
    	tmprs=conn.execute("Select Count(announceID) from bbs1") 
    	gettipnum=tmprs(0) 
	set tmprs=nothing 
	if isnull(gettipnum) then gettipnum=0 
end function 

function titlenum() 
    	tmprs=conn.execute("Select Count(announceID) from bbs1 where parentID=0") 
    	titlenum=tmprs(0) 
	set tmprs=nothing 
	if isnull(titlenum) then titlenum=0 
end function 
%>