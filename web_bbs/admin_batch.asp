<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!--#include file="inc/char.asp"-->
<!--#include file="inc/theme.asp"-->
<!--#include file="chkuser.asp"-->
<%
	stats="帖子批量管理"
	dim rootid
	dim id
	dim Lasttopic,Lastpost
	dim lastrootid,lastpostuser
	dim ip,url
	dim title,content
	ip=Request.ServerVariables("REMOTE_ADDR")
	if founduser=false then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>请登陆后进行操作。"
	end if
	if request("boardid")="" then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>请指定论坛版面。"
	elseif not isInteger(request("boardid")) then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>非法的版面参数。"
	else
		boardid=request("boardid")
		if chkboardmaster(boardid)=false then
			founderr=true
			Errmsg=Errmsg+"<br>"+"<li>您不是该版面版主或者系统管理员。"
		end if
	end if
	if request.form("announceid")="" then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>请指定相关帖子。"
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
		Errmsg=Errmsg+"<br>"+"<li>请选择相关参数。"
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
	sql="insert into log (l_announceid,l_boardid,l_touser,l_username,l_content,l_ip) values ("&id&","&boardid&",'more','"&membername&"','批量锁定','"&ip&"')"
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
	sql="insert into log (l_announceid,l_boardid,l_touser,l_username,l_content,l_ip) values ("&id&","&boardid&",'more','"&membername&"','批量删除','"&ip&"')"
	conn.execute(sql)
	boardtoday(boardid)
	alltodays()
	call success()
	end sub

	sub Tmove()
	Dim id,newboard
	if request.form("newboard")="" or isnull(request.form("newboard")) then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>如果您是批量转移帖子请选择相关论坛。"
		exit sub
	elseif Cint(request.form("newboard"))=Cint(boardid) then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>请不要选择相同的论坛进行转移操作。"
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
	sql="insert into log (l_announceid,l_boardid,l_touser,l_username,l_content,l_ip) values ("&id&","&boardid&",'more','"&membername&"','批量移动','"&ip&"')"
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
	sql="insert into log (l_announceid,l_boardid,l_touser,l_username,l_content,l_ip) values ("&id&","&boardid&",'more','"&membername&"','批量固顶','"&ip&"')"
	conn.execute(sql)
	call success()
	end sub

	sub isbest()
	Dim id
	for i=1 to request.form("Announceid").count
	ID=replace(request.form("Announceid")(i),"'","")
	conn.execute("update bbs1 set isbest=1 where Announceid=" & ID)
	next
	sql="insert into log (l_announceid,l_boardid,l_touser,l_username,l_content,l_ip) values ("&id&","&boardid&",'more','"&membername&"','批量精华','"&ip&"')"
	conn.execute(sql)
	call success()
	end sub

	'更新指定论坛信息
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
			LastTopic="无"
			LastRootid=0
			LastPostTime=now()
			LastPostUser="无"
		end if
		if Lasttopic="" or isnull(Lasttopic) then LastTopic=left(body,20)
		rs.close
		set rs=nothing
		LastPost=LastPostUser & "$" & LastRootid & "$" & LastPostTime & "$" & replace(left(LastTopic,20),"$","") & "$" & UpLoadPic_n
		sql="update board set LastPost='"&LastPost&"' where boardid="&boardid
		conn.execute(sql)
	end function
	
	'版面发帖数增加
	sub BoardNumAdd(boardid,topicNum,postNum)
		sql="update board set lastbbsnum=lastbbsnum+"&postNum&",lasttopicNum=lasttopicNum+"&topicNum&" where boardid="&boardid
		conn.execute(sql)
	end sub
	
	'版面发帖数减少
	sub BoardNumSub(boardid,topicNum,postNum)
		sql="update board set lastbbsnum=lastbbsnum-"&postNum&",lasttopicNum=lasttopicNum-"&topicNum&" where boardid="&boardid
		'response.write sql
		'response.end
		conn.execute(sql)
	end sub
	
	
	'所有论坛发帖数增加
	function AllboardNumAdd(postNum,topicNum)
		sql="update config set BbsNum=bbsNum+"&postNum&",TopicNum=topicNum+"&TopicNum
		conn.execute(sql)
	end function

	'所有论坛发帖数减少
	function AllboardNumSub(postNum,topicNum)
		sql="update config set BbsNum=bbsNum-"&postNum&",TopicNum=topicNum-"&TopicNum
		conn.execute(sql)
	end function
	'今日帖子
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
      <td width="100%" bgcolor=<%=aTabletitlecolor%>>成功：帖子操作</td>
    </tr>
    <tr> 
      <td width="100%" bgcolor=<%=Tablebodycolor%>><li>帖子操作成功。<li>您的操作信息已经记录在案。<br>
      </td>
    </tr>
    <tr align="center"> 
      <td width="100%" bgcolor=<%=aTabletitlecolor%>>
<a href="list.asp?boardid=<%=request("boardid")%>&action=batch"> << 返回论坛</a>
      </td>
    </tr>  
    </table>   </td></tr></table>
<%
end sub
%>
<!--#include file=footer.asp-->