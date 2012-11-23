<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!-- #include file="chkuser.asp" -->
<!-- #include file="inc/char.asp" -->
<!-- #include file="inc/char_board.asp" -->
<!-- #include file="inc/char_login.asp" -->
<!-- #include file="inc/chkinput.asp" -->
<!--#include file="inc/theme.asp"-->
<!-- #include file="inc/email.asp" -->
<!--#include file="md5.asp"-->
<%
	rem ----------------------
	rem ------主程序开始------
	rem ----------------------
	dim UserName
	dim userPassword
	dim useremail
	dim Topic
	dim body
	dim somerr
	dim dateTimeStr
	dim ParentID
	dim RootID
	dim iLayer
	dim iOrders
	dim ip
	dim announceid
	dim Expression
	dim signflag
	dim mailflag
	dim Email,mailbody,SendMail
	dim boardstat
	dim usercookies

	rem ------获取参数------
	call getInput()

	rem -----检查user输入数据的合法性------	
	call chkData()

	if foundErr=true then
		call nav()
		call headline(2)
		call Error()
	else
		call checkUser()
		call nav()
		call headline(2)
		if foundErr then
			call Error()
		else
			call saveReAnnounce()
		end if
	end if	
	call endline()
	

	rem ----------------------
	rem ------主程序结束------
	rem ----------------------
	rem 检测用户输入数据
	sub checkUser()
	select case boardskin
	case 1

	case 2
		exit sub
	case 3

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

   	set rs=server.createobject("adodb.recordset")
	sql="select locktopic from bbs1 where announceid="&cstr(rootid)
	rs.open sql,conn,1,1
	if not rs.eof and not rs.bof then
		if not master and rs("locktopic")=1 then
			Errmsg=ErrMsg+"<Br>"+"<li>本主题已经锁定，不能发表回复。"
			foundErr=true
			exit sub
		elseif rs("locktopic")=2 then
			Errmsg=ErrMsg+"<Br>"+"<li>本主题已经删除，不能发表回复。"
			foundErr=true
			exit sub
		end if
	end if
	rs.close
	set rs=nothing
	usercookies=request.Cookies("esbpbbs")("usercookies")
	if isnull(usercookies) or usercookies="" then usercookies=3

	if chkuserlogin(username,userpassword,usercookies,3)=false then
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
	stats=boardtype & "回复帖子成功"
	end sub

	rem 保存贴子信息
	sub saveReAnnounce()
	dim LastPost,LastPost_1,UpLoadPic_n
     	dim rsLayer
	dim LastPostTimes
     	set rsLayer=conn.execute("select layer,orders from bbs1 where announceid="&cstr(parentid)) 

      	if not(rsLayer.eof and rsLayer.bof) then
         	if isnull(rsLayer(0)) then
            		iLayer=0
         	else
            		iLayer=rslayer(0)
         	end if
         	if isNUll(rslayer(1)) then
            		iOrders=0
         	else
            		iOrders=rsLayer(1) 
         	end if
      	else
         	iLayer=0
         	iOrders=0
      	end if
      	rsLayer.close
	set rsLayer=nothing
      	if rootid<>0 then 
         	iLayer=ilayer+1
         	conn.execute "update bbs1 set orders=orders+1 where rootid="&cstr(RootID)&" and orders>"&cstr(iOrders)

         	iOrders=iOrders+1
     	end if      

      	DateTimeStr=CSTR(NOW()+TIMEADJUST/24)
		Sql="insert into bbs1(Boardid,ParentID,Child,username,topic,body,DateAndTime,hits,length,rootid,layer,orders,ip,Expression,locktopic,signflag,emailflag,istop,isbest,isvote,times) values "&_
				"("&_
				boardid&","&ParentID&",0,'"&_
				username&"','"&_
				topic&"','"&_
				body&"','"&_
				DateTimeStr&"',0,'"&_
				strlength(body)&"',"&RootID&","&ilayer&","&iorders&",'"&ip&"','"&_
				Expression&"',0,"&signflag&","&mailflag&",0,0,0,0)"
		conn.execute(sql)
		set rs=conn.execute("select top 1 announceid from bbs1 order by announceid desc")
        	announceid=rs(0)
		rs.close
		set rs=nothing
		if err.number<>0 then
          		err.clear
	       		ErrMsg=ErrMsg+"<Br>"+"<li>数据库操作失败，请以后再试:"&err.Description 
  	       		call Error()
		else
			if topic="" then
			Topic=replace(cutStr(body,14),chr(10),"")
			else
			Topic=replace(cutStr(topic,14),chr(10),"")
			end if
	      		sql="update bbs1 set child=child+1,times="&cstr(announceid)&" where rootID="&cstr(rootID)
          		conn.execute(sql)
			set rs=conn.execute("select LastPost from bbs1 where Announceid="&cstr(rootid))
			if not isnull(rs(0)) then
				LastPost=split(rs(0),"$")
				if ubound(LastPost)=4 then
				UploadPic_n=LastPost(4)
				else
				UploadPic_n=""
				end if
			end if
			LastPost_1=replace(username,"$","") & "$" & Announceid & "$" & DateTimeStr & "$" & replace(Topic,"$","") & "$" & UpLoadPic_n
			conn.execute("update bbs1 set LastPost='"&LastPost_1&"' where Announceid="&cstr(RootID))
		if datediff("d",LastPostTime,Now())=0 then
		sql="update board set lastbbsnum=lastbbsnum+1,todaynum=todaynum+1,LastPost='"&LastPost_1&"' where boardid="&cstr(boardID)
		else
		sql="update board set lastbbsnum=lastbbsnum+1,todaynum=1,LastPost='"&LastPost_1&"' where boardid="&cstr(boardID)
		end if
		conn.execute(sql)

		set rs=conn.execute("select LastPost from config where active=1")
		LastPostTimes=split(rs(0),"$")
		LastPostTime=LastPostTimes(2)
		if not isdate(LastPostTime) then LastPostTime=Now()
		if datediff("d",LastPostTime,Now())=0 then
		sql="update config set bbsnum=bbsnum+1,todayNum=todayNum+1,LastPost='"&LastPost_1&"' where active=1"
		else
		sql="update config set bbsnum=bbsnum+1,todayNum=1,LastPost='"&LastPost_1&"' where active=1"
		end if
		conn.execute(sql)
		
		 sql = "update [user] set article=article+1 where username='"&username&"'"
		conn.execute(sql)
		
			rem 主帖用户的回复帖子，看是否添加
			call haveRe()
		

	    		call success(somerr)
		end if
	end sub


	rem ------获得asp文件参数------
	sub getInput()
	if request("boardid")="" then
		foundErr=true
		Errmsg=Errmsg+"<br>"+"<li>请指定论坛版面。"
	elseif not isInteger(request("boardid")) then
		foundErr=true
		Errmsg=Errmsg+"<br>"+"<li>非法的版面参数。"
	else
		boardID=request("boardID")
	end if
	if request("followup")="" then
		foundErr=true
		Errmsg=Errmsg+"<br>"+"<li>非法的贴子参数。"
	elseif not isInteger(request("followup")) then
		foundErr=true
		Errmsg=Errmsg+"<br>"+"<li>非法的贴子参数。"
	else
		announceid=request("followup")
		ParentID=request("followup")
	end if
	if request("RootID")="" then
		foundErr=true
		Errmsg=Errmsg+"<br>"+"<li>非法的贴子参数。"
	elseif not isInteger(request("RootID")) then
		foundErr=true
		Errmsg=Errmsg+"<br>"+"<li>非法的贴子参数。"
	else
		rootID=request("RootID")
	end if
   	UserName=Checkstr(trim(request("username")))
   	UserPassWord=md5(Checkstr(trim(request("passwd"))))
	IP=Request.ServerVariables("REMOTE_ADDR") 
	Expression=Checkstr(Request.Form("Expression")&".gif")
   	Topic=Checkstr(trim(request("subject")))
   	Body=Checkstr(trim(request("Content")))
	signflag=Checkstr(trim(request("signflag")))
	mailflag=Checkstr(trim(request("emailflag")))
   	boardtype=Checkstr(trim(request("boardtype")))
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
	dim num1,rndnum
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
   		foundErr=True
	end if
	if strLength(topic)>100 then
   		foundErr=True
   		if strLength(ErrMsg)=0 then
      			ErrMsg=ErrMsg+"<Br>"+"<li>主题长度不能超过100"
   		else
      			ErrMsg=ErrMsg+"<Br>"+"<li>主题长度不能超过100"
   		end if
	end if
	if request("method")="Topic" then
		if topic="" then
			if body="" then
   				ErrMsg=ErrMsg+"<Br>"+"<li>主题和内容必须填写其一。"
   				foundErr=True
			end if
		end if
	end if
	if request("method")="fastreply" then
		if body="" then
   		ErrMsg=ErrMsg+"<Br>"+"<li>快速回复请填写发言内容。"
   		foundErr=True
		end if
	end if
	if strLength(body)>AnnounceMaxBytes then
   		ErrMsg=ErrMsg+"<Br>"+"<li>发言内容不得大于" & CSTR(AnnounceMaxBytes) & "bytes"
   		foundErr=true
	end if
	    if body="" then
	ErrMsg=ErrMsg+"<Br>"+"<li>没有填写内容。"
   		foundErr=true
      	end if
	session("lastpost")=Now()
	end function 
	
	sub haveRe()
		dim username1,rs1
		sql="select username from bbs1 where AnnounceID="&rootID
		rs1=conn.execute (sql)
		username1=rs1(0)
		set rs1=nothing
		
		if username<>username1 then
			sql="select count(*) from bbs1 where rootID="&rootID&" and username<>'"&username1&"'"
			rs1=conn.execute (sql)
			if rs1(0)=1 then
				sql="update [user] set reAnn='"&boardID&"|"& rootID &"' where username='"& username1 &"'"
				conn.execute sql
			end if
			set rs1=nothing
		end if
	end sub
	sub success(somerr)
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
		"<tr align=center><td width=""100%"" bgcolor="&tabletitlecolor&"><b><FONT COLOR="&TableFontcolor&">状态：您回复帖子成功</font></b></td>"&_
		"</tr><tr><td width=""100%"" bgcolor="&tablebodycolor&">"&_
		"<FONT COLOR="&TableContentcolor&">本页面将在3秒后自动返回"&PostRetrunName&"，<b>您可以选择以下操作：</b><br><ul>"&_
		"<li><a href=""index.asp""><font color="""&TableContentcolor&""">返回首页</font></a></li>"&_
		"<li><a href=""list.asp?boardid="&boardid&"""><font color="""&TableContentcolor&""">"&boardtype&"</font></a></li>"&_
		"<li><a href=""dispbbs.asp?boardid="&boardid&"&rootid="&rootid&"&id="&rootid&"&star="&request("star")&"""><font color="""&TableContentcolor&""">发表的帖子</font></a></li>"&_
		"</ul></td></tr></table></td></tr></table>"
	end sub
%>
<!--#include file="footer.asp"-->