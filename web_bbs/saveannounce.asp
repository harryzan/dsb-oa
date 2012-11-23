<!--#include file="conn.asp"-->
<!-- #include file="inc/char.asp" -->
<!-- #include file="inc/char_board.asp" -->
<!-- #include file="inc/char_login.asp" -->
<!-- #include file="inc/chkinput.asp" -->
<!-- #include file="inc/const.asp" -->
<!-- #include file="chkuser.asp" -->
<!--#include file="inc/theme.asp"-->
<!--#include file="md5.asp"-->
<%
	rem ----------------------
	rem ------主程序开始------
	rem ----------------------
	dim announceid
	dim UserName
	dim userPassword
	dim useremail
	dim Topic
	dim body
	dim dateTimeStr
	dim ip
	dim Expression
	dim signflag
	dim mailflag
	dim boardstat
	dim usercookies

	rem ------获得asp文件参数------
	call getInput()
	
	rem -----检查user输入数据的合法性------	
	call chkData()	

	if FoundErr then
		call nav()
		call headline(2)
  	       	call Error()
	else
		call checkUser()
		call nav()
		call headline(2)
		if FoundErr then
  	       		call Error()
		else
			call saveAnnounce()
		end if	
	end if
	set rs=nothing
	call endline()
	
	

	rem ----------------------
	rem ------主程序结束------
	rem ----------------------
	rem 检测用户输入数据合法性
	sub checkUser()
	select case boardskin
	case 1

	case 2
		exit sub
	case 3
		if not(boardmaster or master) then
		Founderr=true
		Errmsg=Errmsg+"<br>"+"<li>评论论坛，坛主和版主允许发言，其他<a href=reg.asp><font color="&TableContentColor&">注册用户</font></a>只能回复"
		exit sub
		end if
	case 4
		if not(boardmaster or master) then
		Founderr=true
		Errmsg=Errmsg+"<br>"+"<li>精华区，只允许版主和坛主发言和操作"
		exit sub
		end if
	case 5
		if username="" then
			founderr=true
			Errmsg=Errmsg+"<br>"+"<li>本论坛为认证论坛，请<a href=login.asp>登陆</a>并确认您的用户名已经得到管理员的认证后进入。"
			exit sub
		else
			if chkboardlogin(boardid,username)=false then
			founderr=true
			Errmsg=Errmsg+"<br>"+"<li>本论坛为认证论坛，请确认您的用户名已经得到管理员的认证后进入。"
			exit sub
			end if
		end if
	case 6
		if username="" then
		Founderr=true
		Errmsg=Errmsg+"<br>"+"<li>正规论坛，只有<a href=login.asp><font color="&TableContentColor&">登陆用户</a>才能浏览论坛并发言"
		exit sub
		end if
	end select

	usercookies=request.Cookies("esbpbbs")("usercookies")
	if isnull(usercookies) or usercookies="" then usercookies=3

	if chkuserlogin(username,userpassword,usercookies,2)=false then
		errmsg=errmsg+"<br>"+"<li>您的用户名并不存在，或者您的密码错误，或者您的帐号已被管理员锁定。"
		founderr=true
		exit sub
	end if

	if lockboard=2 then
		if not master then
			Errmsg=ErrMsg+"<Br>"+"<li>您没有权限在本版面发布贴子！"
			FoundErr=true
		end if
	end if
	stats=boardtype & "发表帖子成功"
	end sub

	rem 保存贴子信息
	sub saveAnnounce()
	dim LastPost,uploadpic_n,Forumupload,u
	dim LastPostTimes
        DateTimeStr=CSTR(NOW()+TIMEADJUST/24)
		Sql="insert into bbs1(Boardid,ParentID,Child,username,topic,body,DateAndTime,hits,length,rootid,layer,orders,ip,Expression,locktopic,signflag,emailflag,istop,isbest,isvote,times) values "&_
				"("&_
				boardid&",0,0,'"&_
				username&"','"&_
				topic&"','"&_
				body&"','"&_
				DateTimeStr&"',0,'"&_
				strlength(body)&"',0,1,0,'"&ip&"','"&_
				Expression&"',0,"&signflag&","&mailflag&",0,0,0,0)"
		'response.write sql
		conn.execute(sql)
		if topic="" then
			Topic=cutStr(body,20)
		else
			Topic=cutStr(topic,20)
		end if
		set rs=conn.execute("select top 1 announceid from bbs1 order by announceid desc")
        	announceid=rs(0)
		Forumupload=split(Forum_upload,",")
		for u=0 to ubound(Forumupload)
		if instr(body,"[upload="&Forumupload(u)&"]") and instr(body,"[/upload]")>0 then
			UpLoadPic_n=Forumupload(u)
			exit for
		end if
		next
		LastPost=replace(username,"$","") & "$" & Announceid & "$" & DateTimeStr & "$" & replace(cutStr(body,20),"$","") & "$" & UpLoadPic_n
		sql="update bbs1 set rootid="&announceid&",times="&announceid&",LastPost='"&LastPost&"' where announceid="&announceid
		conn.execute(sql)

		if datediff("d",LastPostTime,Now())=0 then
		sql="update board set lastbbsnum=lastbbsnum+1,lasttopicnum=lasttopicnum+1,todaynum=todaynum+1,LastPost='"&LastPost&"' where boardid="&cstr(boardID)
		else
		sql="update board set lastbbsnum=lastbbsnum+1,lasttopicnum=lasttopicnum+1,todaynum=1,LastPost='"&LastPost&"' where boardid="&cstr(boardID)
		end if
		conn.execute(sql)
	
        sql = "update [user] set article=article+1 where username='"&username&"'"
		conn.execute(sql)


	
		
		set rs=conn.execute("select LastPost from config where active=1")
		LastPostTimes=split(rs(0),"$")
		LastPostTime=LastPostTimes(2)
		if not isdate(LastPostTime) then LastPostTime=Now()
		if datediff("d",LastPostTime,Now())=0 then
		sql="update config set topicnum=topicnum+1,bbsnum=bbsnum+1,todayNum=todayNum+1,LastPost='"&LastPost&"' where active=1"
		else
		sql="update config set topicnum=topicnum+1,bbsnum=bbsnum+1,todayNum=1,LastPost='"&LastPost&"' where active=1"
		end if
		conn.execute(sql)
  		if err.number<>0 then
	       	err.clear
			ErrMsg=ErrMsg+"<Br>"+"<li>数据库操作失败，请以后再试"&err.Description 
  	       	call Error()
		else
			call success()
    		end if
	set rs=nothing
	end sub

	rem ------获得asp文件参数------
	sub getInput()
	if request("boardid")="" then
		FoundErr=true
		Errmsg=Errmsg+"<br>"+"<li>请指定论坛版面。"
	elseif not isInteger(request("boardid")) then
		FoundErr=true
		Errmsg=Errmsg+"<br>"+"<li>非法的版面参数。"
	else
		boardID=request("boardID")
	end if
	IP=Request.ServerVariables("REMOTE_ADDR") 
	Expression=Checkstr(Request.Form("Expression")&".gif")
   	Topic=Checkstr(trim(request("subject")))
   	Body=Checkstr(trim(request.form("Content")))
   	UserName=Checkstr(trim(request("username")))
   	boardtype=Checkstr(trim(request("boardtype")))
	signflag=Checkstr(trim(request("signflag")))
	mailflag=Checkstr(trim(request("emailflag")))
   	UserPassWord=md5(Checkstr(trim(request("passwd"))))
	if signflag="yes" then
		signflag=1
	else
		signflag=0
	end if
	if mailflag="yes" then
		mailflag=1
	else
		mailflag=0
	end if
	end sub

	rem -----检查user输入数据的合法性------	
	function chkData()
	dim rndnum,num1
	if boardmaster or master then
		guestlist=""
	else
		guestlist=" lockboard=0 and "
	end if

	if instr(Expression,"face")=0 then
	Expression="face0.gif"
	end if

	'if chkpost=false then
   	'	ErrMsg=ErrMsg+"<Br>"+"<li>您提交的数据不合法，请不要从外部提交发言。"
   	'	FoundErr=True
	'end if
	if UserName="" or UserPassWord="" then
		username=membername
		UserPassWord=memberword
	end if
	if UserName="" or strLength(UserName)>20 then
   		ErrMsg=ErrMsg+"<Br>"+"<li>请输入姓名(长度不能大于20)"
   		FoundErr=True
	end if
	if Topic="" then
   		FoundErr=True
   		if Len(ErrMsg)=0 then
      			ErrMsg=ErrMsg+"<Br>"+"<li>主题不应为空。"
   		else
      			ErrMsg=ErrMsg+"<Br>"+"<li>主题不应为空。"
   		end if
	elseif strLength(topic)>100 then
   		FoundErr=True
   		if strLength(ErrMsg)=0 then
      			ErrMsg=ErrMsg+"<Br>"+"<li>主题长度不能超过100"
   		else
      			ErrMsg=ErrMsg+"<Br>"+"<li>主题长度不能超过100"
   		end if
			end if
	if strLength(body)>AnnounceMaxBytes then
   		ErrMsg=ErrMsg+"<Br>"+"<li>发言内容不得大于" & CSTR(AnnounceMaxBytes) & "bytes"
   		FoundErr=true
	end if
    if body="" then
	ErrMsg=ErrMsg+"<Br>"+"<li>没有填写内容。"
   		FoundErr=true
      	end if
	session("lastpost")=Now()
	if err.number<>0 then err.clear
	end function

	sub success()
	dim PostRetrunName
	select case PostRetrun
	case 1
	response.write "<meta http-equiv=refresh content=""3;URL=index.asp"">"
	PostRetrunName="首页"
	case 2
	response.write "<meta http-equiv=refresh content=""3;URL=list.asp?boardid="&boardid&""">"
	PostRetrunName="您所发布的论坛"
	case 3
	response.write "<meta http-equiv=refresh content=""3;URL=dispbbs.asp?boardid="&boardid&"&rootid="&announceid&"&id="&announceid&"&star="&request("star")&""">"
	PostRetrunName="您所发表的帖子"
	end select

	response.write "<br><table cellpadding=0 cellspacing=0 border=0 width="&tablewidth&" bgcolor="&tablebackcolor&" align=center>"&_
		"<tr><td><table cellpadding=3 cellspacing=1 border=0 width=""100%"">"&_
		"<tr align=center><td width=""100%"" bgcolor="&tabletitlecolor&"><b><FONT COLOR="&TableFontcolor&">状态：您发表帖子成功</font></b></td>"&_
		"</tr><tr><td width=""100%"" bgcolor="&tablebodycolor&">"&_
		"<FONT COLOR="&TableContentcolor&">本页面将在3秒后自动返回"&PostRetrunName&"，<b>您可以选择以下操作：</b><br><ul>"&_
		"<li><a href=""index.asp""><font color="""&TableContentcolor&""">返回首页</font></a></li>"&_
		"<li><a href=""list.asp?boardid="&boardid&"""><font color="""&TableContentcolor&""">"&boardtype&"</font></a></li>"&_
		"<li><a href=""dispbbs.asp?boardid="&boardid&"&rootid="&announceid&"&id="&announceid&"&star="&request("star")&"""><font color="""&TableContentcolor&""">发表的帖子</font></a></li>"&_
		"</ul></td></tr></table></td></tr></table>"
	end sub
%>
<!--#include file="footer.asp"-->