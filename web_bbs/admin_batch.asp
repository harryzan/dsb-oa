<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!--#include file="inc/char.asp"-->
<!--#include file="inc/theme.asp"-->
<!--#include file="chkuser.asp"-->
<%
	stats="������������"
	dim rootid
	dim id
	dim Lasttopic,Lastpost
	dim lastrootid,lastpostuser
	dim ip,url
	dim title,content
	ip=Request.ServerVariables("REMOTE_ADDR")
	if founduser=false then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>���½����в�����"
	end if
	if request("boardid")="" then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>��ָ����̳���档"
	elseif not isInteger(request("boardid")) then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>�Ƿ��İ��������"
	else
		boardid=request("boardid")
		if chkboardmaster(boardid)=false then
			founderr=true
			Errmsg=Errmsg+"<br>"+"<li>�����Ǹð����������ϵͳ����Ա��"
		end if
	end if
	if request.form("announceid")="" then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>��ָ��������ӡ�"
	end if
	'response.write request.form("announceid")
	'response.end
	call nav()
	call headline(2)
	if founderr=true then
		call Error()
	else
	set rs=server.createobject("adodb.recordset")
	select case request("action")
	case "lock"
		call lock()
	case "dele"
		call delete()
	case "move"
		call Tmove()
	case "istop"
		call istop()
	case "isbest"
		call isbest()
	case else
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>��ѡ����ز�����"
	end select
	if founderr then call error()
	end if
	set rs=nothing
	call endline()

	sub lock()
	Dim id
	for i=1 to request.form("Announceid").count
	ID=replace(request.form("Announceid")(i),"'","")
	conn.execute("update bbs1 set LockTopic=1 where BoardID="&BoardID&" And Announceid=" & ID)
	next
	sql="insert into log (l_announceid,l_boardid,l_touser,l_username,l_content,l_ip) values ("&id&","&boardid&",'more','"&membername&"','��������','"&ip&"')"
	conn.execute(sql)
	call success()
	end sub

	sub delete()
	Dim id
	for i=1 to request.form("Announceid").count
	ID=replace(request.form("Announceid")(i),"'","")
	set rs=conn.execute("select username from bbs1 where BoardID="&BoardID&" And rootid=" & ID)
	do while not rs.eof
	conn.execute("update [user] set userWealth=userWealth-"&wealthDel&",userCP=userCP-"&cpDel&",userEP=userEP-"&epDel&" where username='"&rs(0)&"'")
	rs.movenext
	call BoardNumSub(boardid,1,1)
	call AllboardNumSub(1,1)
	loop
	rs.close
	conn.execute("update bbs1 set LockTopic=2 where BoardID="&BoardID&" And rootid=" & ID)
	next
	call LastCount(boardid)
	sql="insert into log (l_announceid,l_boardid,l_touser,l_username,l_content,l_ip) values ("&id&","&boardid&",'more','"&membername&"','����ɾ��','"&ip&"')"
	conn.execute(sql)
	boardtoday(boardid)
	alltodays()
	call success()
	end sub

	sub Tmove()
	Dim id,newboard
	if request.form("newboard")="" or isnull(request.form("newboard")) then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>�����������ת��������ѡ�������̳��"
		exit sub
	elseif Cint(request.form("newboard"))=Cint(boardid) then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>�벻Ҫѡ����ͬ����̳����ת�Ʋ�����"
		exit sub
	else
	newboard=request.form("newboard")
	end if
	for i=1 to request.form("Announceid").count
	ID=replace(request.form("Announceid")(i),"'","")
	set rs=conn.execute("select count(*) from bbs1 where BoardID="&BoardID&" And rootid=" & ID)
	call BoardNumSub(boardid,1,rs(0))
	call BoardNumAdd(newboard,1,rs(0))
	rs.close
	conn.execute("update bbs1 set boardid="&newboard&" where BoardID="&BoardID&" And rootid=" & ID)
	next
	call LastCount(boardid)
	sql="insert into log (l_announceid,l_boardid,l_touser,l_username,l_content,l_ip) values ("&id&","&boardid&",'more','"&membername&"','�����ƶ�','"&ip&"')"
	conn.execute(sql)
	boardtoday(boardid)
	alltodays()
	call success()
	end sub

	sub istop()
	Dim id
	for i=1 to request.form("Announceid").count
	ID=replace(request.form("Announceid")(i),"'","")
	conn.execute("update bbs1 set istop=1 where BoardID="&BoardID&" And Announceid=" & ID)
	next
	sql="insert into log (l_announceid,l_boardid,l_touser,l_username,l_content,l_ip) values ("&id&","&boardid&",'more','"&membername&"','�����̶�','"&ip&"')"
	conn.execute(sql)
	call success()
	end sub

	sub isbest()
	Dim id
	for i=1 to request.form("Announceid").count
	ID=replace(request.form("Announceid")(i),"'","")
	conn.execute("update bbs1 set isbest=1 where Announceid=" & ID)
	next
	sql="insert into log (l_announceid,l_boardid,l_touser,l_username,l_content,l_ip) values ("&id&","&boardid&",'more','"&membername&"','��������','"&ip&"')"
	conn.execute(sql)
	call success()
	end sub

	'����ָ����̳��Ϣ
	function LastCount(boardid)
		dim LastTopic,body,LastRootid,LastPostTime,LastPostUser
		dim LastPost,uploadpic_n
		set rs=conn.execute("select top 1 topic,body,rootid,dateandtime,username from bbs1 where not locktopic=2 and boardid="&boardid&" and not locktopic=2 order by announceid desc")
		if not(rs.eof and rs.bof) then
			Lasttopic=rs(0)
			body=rs(1)
			LastRootid=rs(2)
			LastPostTime=rs(3)
			LastPostUser=rs(4)
		else
			LastTopic="��"
			LastRootid=0
			LastPostTime=now()
			LastPostUser="��"
		end if
		if Lasttopic="" or isnull(Lasttopic) then LastTopic=left(body,20)
		rs.close
		set rs=nothing
		LastPost=LastPostUser & "$" & LastRootid & "$" & LastPostTime & "$" & replace(left(LastTopic,20),"$","") & "$" & UpLoadPic_n
		sql="update board set LastPost='"&LastPost&"' where boardid="&boardid
		conn.execute(sql)
	end function
	
	'���淢��������
	sub BoardNumAdd(boardid,topicNum,postNum)
		sql="update board set lastbbsnum=lastbbsnum+"&postNum&",lasttopicNum=lasttopicNum+"&topicNum&" where boardid="&boardid
		conn.execute(sql)
	end sub
	
	'���淢��������
	sub BoardNumSub(boardid,topicNum,postNum)
		sql="update board set lastbbsnum=lastbbsnum-"&postNum&",lasttopicNum=lasttopicNum-"&topicNum&" where boardid="&boardid
		'response.write sql
		'response.end
		conn.execute(sql)
	end sub
	
	
	'������̳����������
	function AllboardNumAdd(postNum,topicNum)
		sql="update config set BbsNum=bbsNum+"&postNum&",TopicNum=topicNum+"&TopicNum
		conn.execute(sql)
	end function

	'������̳����������
	function AllboardNumSub(postNum,topicNum)
		sql="update config set BbsNum=bbsNum-"&postNum&",TopicNum=topicNum-"&TopicNum
		conn.execute(sql)
	end function
	'��������
	function boardtoday(boardid)
		dim tmprs
    	tmprs=conn.execute("Select count(announceid) from bbs1 Where datediff('d',dateandtime,Now())=0 and boardid="&boardid)
    	boardtoday=tmprs(0)
	set tmprs=nothing 
	if isnull(boardtoday) then boardtoday=0
	conn.execute("update board set todaynum="&boardtoday&" where boardid="&boardid)
	end function 
	function alltodays()
		dim tmprs
    	tmprs=conn.execute("Select count(announceid) from bbs1 Where datediff('d',dateandtime,Now())=0")
    	alltodays=tmprs(0)
	set tmprs=nothing
	if isnull(alltodays) then alltodays=0
	conn.execute("update config set todaynum="&alltodays&"")
	end function
sub success()
%>
    <table cellpadding=0 cellspacing=0 border=0 width=95% bgcolor=<%=aTablebackcolor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
    <tr align="center"> 
      <td width="100%" bgcolor=<%=aTabletitlecolor%>>�ɹ������Ӳ���</td>
    </tr>
    <tr> 
      <td width="100%" bgcolor=<%=Tablebodycolor%>><li>���Ӳ����ɹ���<li>���Ĳ�����Ϣ�Ѿ���¼�ڰ���<br>
      </td>
    </tr>
    <tr align="center"> 
      <td width="100%" bgcolor=<%=aTabletitlecolor%>>
<a href="list.asp?boardid=<%=request("boardid")%>&action=batch"> << ������̳</a>
      </td>
    </tr>  
    </table>   </td></tr></table>
<%
end sub
%>
<!--#include file=footer.asp-->