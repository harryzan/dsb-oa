<!--#include file="conn.asp"-->
<!-- #include file="inc/char.asp" -->
<!-- #include file="inc/char_cfrom.asp" -->
<!-- #include file="inc/char_board.asp" -->
<!-- #include file="inc/const.asp" -->
<!-- #include file="chkuser.asp" -->
<!--#include file="inc/theme.asp"-->
<!--#include file="inc/birthday.asp"-->
<!-- #include file="inc/ubbcode.asp" -->
<%
	Dim AnnounceID
	Dim RootID
	Dim Star,nSkin,SkinPic,Skiname
	Dim Topic_1,IsTop,IsBest,IsVote
	Dim UserName,view,times
	Dim onlineUserList
	Dim UserSign,grs
	Dim Page_Count,TotalRec,abgcolor,bgcolor
	i=1
	UserSign=false
	if boardmaster or master then
		guestlist=""
	else
		guestlist=" lockboard=0 and "
	end if

	stats="浏览帖子"
    	if foundErr then
		call nav()
		call headline(2)
		call error()
	else
    		call chkInput()
		if founderr then
			call nav()
			call headline(2)
			call error()
		else
    		call chktopic()
			if founderr then
				call nav()
				call headline(2)
				call error()
			else
				call nav()
				call headline(2)
				call TopicTop()
				call showTopic_1()
				call listpage()
				if cint(skin)=1 then
				call treelist()
				end if
				if founderr then
				call error()
				else
				call fastreply()
				end if
			end if
		end if
	end if
	call endline()

	sub chktopic()
	if cint(boardskin)=6 then
		if membername="" then
		response.write "<script>location.href='login.asp'</script>"
		response.end
		end if
	elseif cint(boardskin)=5 then
		if membername="" then
			founderr=true
			Errmsg=Errmsg+"<br>"+"<li>本论坛为认证论坛，请<a href=login.asp><font color="&TableContentColor&">登陆</font></a>并确认您的用户名已经得到管理员的认证后进入。"
			exit sub
		else
			if chkboardlogin(BoardID,membername)=false then
			founderr=true
			Errmsg=Errmsg+"<br>"+"<li>本论坛为认证论坛，请确认您的用户名已经得到管理员的认证后进入。"
			exit sub
			end if
		end if
	end if
    conn.execute("update bbs1 set hits=hits+1 where AnnounceID="&AnnounceID&"")
	sql="select topic,istop,isbest,UserName,hits,times,rootid,isvote from bbs1 where AnnounceID=(select rootid from bbs1 where Announceid="&Announceid&")"
	set rs=server.createobject("adodb.recordset")
	rs.open sql,conn,1,1
	if not(rs.bof and rs.eof) then
		topic_1=rs(0)
		istop=rs(1)
		isbest=rs(2)
		UserName=rs(3)
		view=rs(4)
		times=rs(5)
		rootid=rs(6)
		isVote=rs(7)
		stats=""&boardtype&"浏览："&topic_1&""
		if UserName=membername and membername<>"" then call readRe()
	else
		foundErr = true
		ErrMsg=ErrMsg+"<br>"+"<li>您指定的贴子不存在</li>"
	end if
	rs.close
	set rs=nothing
	end sub

	sub topicTop()

if IsVote=1 then
	Dim vrs,vote,vote_1,votenum,votenum_1,m
	set vrs=conn.execute("select vote,votenum,votetype,voteuser from vote where AnnounceID="&RootID&"")
	if not (vrs.eof and vrs.bof) then
	vote=split(vrs("vote"),"|")
	votenum=split(vrs("votenum"),"|")
	response.write "<table width="&TableWidth&" border=0 cellspacing=1 cellpadding=3 align=center bgcolor="&TableBackColor&" style=""table-layout:fixed;word-break:break-all""><tr bgcolor="&TableTitleColor&"><td colspan=2 height=25><font color="&TableFontColor&"><B>[投票]："&Topic_1&"</B></font></td></tr><form action=postvote.asp?BoardID="&BoardID&"&AnnounceID="&AnnounceID&"&action="&vrs("votetype")&" method=POST>"
	for i = 0 to ubound(votenum)
		votenum_1=cint(votenum_1)+votenum(i)
	next
	if votenum_1=0 then votenum_1=1
	for m = 0 to ubound(vote)
		if cint(vrs("votetype"))=0 then
		vote_1=vote_1&"<tr bgcolor="&TablebodyColor&"><td width=""60%"" height=25>"&m+1&".  <input type=radio name=postvote value="""&m&""">"&htmlencode(vote(m))&"</td><td width=""40%""><font color="&AlertFontColor&"><img src="&picurl&"bar"&m+1&".gif width="&Cint(replace(FormatPercent(votenum(m)/votenum_1),"%",""))*3.3&" height=8> <b>"&votenum(m)&"票</b></font></td></tr>"
		else
		vote_1=vote_1&"<tr bgcolor="&TablebodyColor&"><td width=""60%"" height=25>"&m+1&".  <input type=checkbox name=postvote_"&m&" value="""&m&""">"&ubbcode(vote(m))&"</td><td width=""40%""><font color="&AlertFontColor&"><img src="&picurl&"bar"&m+1&".gif width="&Cint(replace(FormatPercent(votenum(m)/votenum_1),"%",""))*3.3&" height=8> <b>"&votenum(m)&"票</b></font></td></tr>"
		end if
	next
	response.write vote_1
	vote_1=""

	if VoteFlag=1 then
	response.write "<tr bgcolor="&aTablebodyColor&"><td colspan=2 height=25><input type=submit name=Submit value='投 票'></td>"
	else
		if membername="" then
		response.write "<tr bgcolor="&aTablebodyColor&"><td colspan=2 height=25><font color="&AlertFontColor&">您还没有登陆，不能进行投票。</font></td>"
		else
			if instr(vrs("voteuser"),membername)>0 then
			response.write "<tr bgcolor="&aTablebodyColor&"><td colspan=2 height=25><font color="&AlertFontColor&">您已经投过票了，请看结果吧。</font></td>"
			else
			response.write "<tr bgcolor="&aTablebodyColor&"><td colspan=2 height=25><input type=submit name=Submit value='投 票'></td>"
			end if
		end if
	end if
	response.write "</tr></form></table><BR>"
	end if
	set vrs=nothing
end if
	response.write "<table cellpadding=0 cellspacing=0 border=0 width="""&TableWidth&""" align=center>"&_
			"<tr><td align=left width=""30%"" valign=middle>&nbsp; <a href=announce.asp?BoardID="&BoardID&">"&_ 
			"<img src="&picurl&P_post&" alt=发表一个新主题 border=0></a>"&_ 
			"&nbsp;<a href=reannounce.asp?BoardID="&BoardID&"&RootID="&RootID&"&id="&AnnounceID&">"&_ 
			"<img src="&picurl&P_reply&" alt=回复主题 border=0></a></td>"&_
			"<td align=right width=""70%"" valign=middle>您是本帖的第 <B>"&view&"</B> 个阅读者<a href=go.asp?BoardID="&BoardID&"&sid="&times&"><img src="&picurl&P_backTopic&" border=0 alt=浏览上一篇主题 width=52 height=12></a>&nbsp;　<a href=javascript:this.location.reload()><img src="&picurl&P_reflash&" border=0 alt=刷新本主题 width=40 height=12></a> &nbsp;<a href=?BoardID="&BoardID&"&RootID="&RootID&"&id="&AnnounceID&"&star="&star&"&skin="&nskin&"><img src="&picurl&skinpic&" width=40 height=12 border=0 alt="&skiname&"显示贴子></a>　<a href=go.asp?BoardID="&BoardID&"&sid="&times&"&action=next><img src="&picurl&P_nexttopic&" border=0 alt=浏览下一篇主题 width=52 height=12></a></td>"&_
			"</tr></table>"
	response.write "<table cellpadding=0 cellspacing=0 border=0 width="""&TableWidth&""" bgcolor=#FFFFFF align=center>"&_
			"<tr> <td height=1> </td></tr></table>"

	response.write "<table cellpadding=0 cellspacing=0 border=0 width="""&TableWidth&""" bgcolor="&TableBackColor&" align=center>"&_
			"<tr><td height=1> </td></tr></table>"
	end sub

	sub ShowTopic_1()
	response.write "<table cellpadding=0 cellspacing=0 border=0 width="""&TableWidth&""" align=center><tr> "&_
			"<td bgcolor="&TableBackColor&" valign=middle width=1 height=24> </td>"&_
			"<td bgcolor="&TableTitleColor&" align=left valign=middle width=*>"&_ 
			"<table cellpadding=0 cellspacing=1 border=0 width=""100%"">"&_
			"<tr><td bgcolor="&TableTitleColor&" align=left valign=middle width=""65%""><font color="&TableFontColor&">"&_
            "&nbsp;<b>* 贴子主题</B>： "&htmlencode(topic_1)&"</font> </td><td width=""35%"" align=right>"&_
			"&nbsp;<a href=report.asp?BoardID="&BoardID&"&RootID="&RootID&"&id="&AnnounceID&"><img src="&picurl&P_report&" alt=报告本帖给版主 border=0></a>&nbsp;"&_ 
			" <a href=#><span style=""CURSOR: hand"" onClick=""window.external.AddFavorite('"&ForumURL&"dispbbs.asp?BoardID="&BoardID&"&RootID="&rootid&"&id="&AnnounceID&"', ' "&ForumName&" - "&htmlencode(replace(topic_1,"&#39;",""))&"')""><IMG SRC="&picurl&P_iefav&" BORDER=0 width=15 height=15 alt=把本贴加入IE收藏夹></span></a>"&_
			"&nbsp;</td></tr>"&_
			"</table></td><td bgcolor="&TableBackColor&" valign=middle width=1 height=24> </td>"&_
			"</tr></table>"&_
			"<table cellpadding=0 cellspacing=0 border=0 width="""&TableWidth&""" bgcolor="&TableBackColor&" align=center>"&_
			"<tr> <td height=1> </td></tr></table>"
	if boardskin=2 then
	if cint(skin)=1 then
	sql="Select AnnounceID,BoardID,UserName,Topic,dateandtime,body,Expression,ip,RootID,signflag,isbest,isvote from bbs1 where BoardID="&BoardID&" and AnnounceID="&AnnounceID&" and not locktopic=2"
	else
	sql="Select AnnounceID,BoardID,UserName,Topic,dateandtime,body,Expression,ip,RootID,signflag,isbest,isvote from bbs1 where BoardID="&BoardID&" and RootID="&RootID&" and not locktopic=2 order by AnnounceID"
	end if
	else
	if cint(skin)=1 then
	sql="Select B.AnnounceID,B.BoardID,B.UserName,B.Topic,B.dateandtime,B.body,B.Expression,B.ip,B.RootID,B.signflag,B.isbest,B.isvote,U.UserName,U.useremail,U.homepage,U.oicq,U.sign,U.userclass,U.title,U.width,U.height,U.article,U.face,U.addDate,U.userWealth,U.userEP,U.userCP,U.birthday,U.sex,u.UserGroup,u.LockUser from bbs1 B inner join [user] U on U.UserName=B.UserName where B.BoardID="&BoardID&" and B.AnnounceID="&AnnounceID&" and not B.locktopic=2"
	else
	sql="Select B.AnnounceID,B.BoardID,B.UserName,B.Topic,B.dateandtime,B.body,B.Expression,B.ip,B.RootID,B.signflag,B.isbest,B.isvote,U.UserName,U.useremail,U.homepage,U.oicq,U.sign,U.userclass,U.title,U.width,U.height,U.article,U.face,U.addDate,U.userWealth,U.userEP,U.userCP,U.birthday,U.sex,u.UserGroup,u.LockUser from bbs1 B inner join [user] U on U.UserName=B.UserName where B.BoardID="&BoardID&" and B.RootID="&RootID&" and not B.locktopic=2 order by B.AnnounceID"
	end if
	end if
	set rs=server.createobject("adodb.recordset")
	rs.open sql,conn,1,1
	if not(rs.eof and rs.bof) then
			rs.PageSize = Maxtitlelist
			rs.AbsolutePage=star
			page_count=0
			totalrec=rs.recordcount 
			call showannounce_1()
	else
		foundErr = true
		ErrMsg=ErrMsg+"<br>"+"<li>您指定的贴子不存在</li>"
		exit sub
	end if
	end sub

	sub showannounce_1()
	Dim Topic,DateAndTime,Body,Expression,ip,SignFlag,Isvote
	Dim useremail,homepage,oicq,sign,userclass,title,width,uheight,article,face
	Dim addtime,userWealth,userEP,userCP,userbirth,sex,UserGroup,usercolor,namestyle
	Dim Comefrom,LockUser
	while (not rs.eof) and (not page_count = rs.PageSize)

	AnnounceID=rs(0)
	BoardID=rs(1)
	UserName=rs(2)
	topic=rs(3)
	dateandtime=rs(4)
	body=rs(5)
	Expression=rs(6)
	ip=rs(7)
	RootID=rs(8)
	signflag=rs(9)
	isbest=rs(10)
	isvote=rs(11)
	if boardskin=2 then
	set grs=conn.execute("select useremail,homepage,oicq,sign,userclass,title,width,height,article,face,addDate,userWealth,userEP,userCP,birthday,sex,UserGroup,LockUser from [user] where username='"&username&"'")
	if grs.eof and grs.bof then
	useremail=""
	homepage=""
	oicq=""
	sign=""
	userclass=1
	title=""
	width=32
	uheight=32
	article=1
	face="pic/image1.gif"
	addtime=now()
	userWealth=1
	userEP=1
	userCP=1
	userbirth=""
	sex=1
	UserGroup=""
	LockUser=0
	else
	useremail=grs(0)
	homepage=grs(1)
	oicq=grs(2)
	sign=grs(3)
	userclass=grs(4)
	title=grs(5)
	width=grs(6)
	uheight=grs(7)
	article=grs(8)
	face=grs(9)
	addtime=grs(10)
	userWealth=grs(11)
	userEP=grs(12)
	userCP=grs(13)
	userbirth=grs(14)
	sex=grs(15)
	UserGroup=htmlencode(grs(16))
	LockUser=grs(17)
	end if
	else
	useremail=rs(13)
	homepage=rs(14)
	oicq=rs(15)
	sign=rs(16)
	userclass=rs(17)
	title=rs(18)
	width=rs(19)
	uheight=rs(20)
	article=rs(21)
	face=rs(22)
	addtime=rs(23)
	userWealth=rs(24)
	userEP=rs(25)
	userCP=rs(26)
	userbirth=rs(27)
	sex=rs(28)
	UserGroup=htmlencode(rs(29))
	LockUser=rs(30)
	end if
	if isnumeric(userclass) then
	if userclass=18 then
	namestyle="filter:glow(color="&vip_mc&",strength=2)"
	usercolor=vip_fc
	elseif userclass=19 then
	namestyle="filter:glow(color="&bmaster_mc&",strength=2)"
	usercolor=bmaster_fc
	elseif userclass=20 then
	namestyle="filter:glow(color="&master_mc&",strength=2)"
	usercolor=master_fc
	else
	namestyle="filter:glow(color="&user_mc&",strength=2)"
	usercolor=user_fc
	end if
	end if
	if bgcolor=TableBodyColor then
		bgcolor=aTableBodyColor
		abgcolor=TableBodyColor
	else
		bgcolor=TableBodyColor
		abgcolor=aTableBodyColor
	end if
	if userbirth="" or isnull(userbirth) then
	userbirth=""
	else
	userbirth=astro(userbirth)
	end if
	response.write "<table cellpadding=0 cellspacing=0 border=0 width="""&TableWidth&""" align=center>"&_
		"<tr><td bgcolor="&TableBackColor&" valign=middle width=1 height=24> </td>"&_
		"<td bgcolor="&bgcolor&">"&_ 
		"<table width=""100%"" cellpadding=4 cellspacing=0><tr>"&_ 
        "<td bgcolor="&bgcolor&" valign=top width=""180"" rowspan=2><img src="""" width=0 height=4><BR><table width=""100%"" cellpadding=4 cellspacing=0><tr><td style="&namestyle&">"&_
        "  &nbsp;<a name="&AnnounceID&"><font color="&usercolor&"><B>"&htmlencode(UserName)&"</B></font></a></td><td>&nbsp;"&isOnline(UserName,sex)&"</td></tr></table>"
response.write "&nbsp;&nbsp;注册："& year(addtime) &"-"& month(addtime) &"-"& day(addtime)
	response.write "<BR> &nbsp;&nbsp;文章："&article&"  <br>&nbsp;&nbsp;"&_
			"</td><td bgcolor="&bgcolor&" width=1 height=100% rowspan=2>"&_ 
            "<table width=1 height=""100%"" cellpadding=0 cellspacing=0 bgcolor="&TableTitleColor&">"&_
            "<tr><td width=1></td></tr></table></td>"&_
			"<td bgcolor="&bgcolor&" valign=top width=* height=""95%""><img src="""" width=0 height=4><BR>"
	if not (BbsUserInfo=2 or BbsUserInfo=3) then
    response.write "<a href=usersms.asp?action=new&touser="&HTMLEncode(UserName)&" target=_blank>"&_
			"<img src="&picurl&P_sms&" border=0 alt=给"&HTMLEncode(UserName)&"发送一个短消息></a>&nbsp;"&_
            "<a href=dispuser.asp?name="&HTMLEncode(UserName)&" target=_blank>"&_
			"<img src="&picurl&P_userinfo&" border=0 alt=查看"&HTMLEncode(UserName)&"的个人资料></a>&nbsp;"&_
		"<a href=reannounce.asp?BoardID="&BoardID&"&RootID="&RootID&"&id="&AnnounceID&">"&_
			"<img src="&picurl&"reply_a.gif border=0 alt=回复这个贴子></a><BR><hr width=""100%"" size=1 color=#777777>"
	end if
    response.write ""&_
            "<table cellpadding=0 cellspacing=0 width=""95%"" style=""table-layout:fixed; word-break:break-all"">"&_
            "<tr><td width=32 align=left valign=top>"
if LockUser=2 then
	response.write "</td><td>================================<br><font color=#00008B>该用户发言已被管理员屏蔽</font><br>================================"
else
	response.write "</td><td><font style=""font-size:"&FontSize&"pt;line-height: "&FontHeight&"pt""><b>"& htmlencode(topic) &"</b><br>"
	response.write ubbcode(body) 
end if
if signflag=1 then
	UserSign=true
	if sign<>"" then
		response.write "</font><p>----------------------------------------------<br>"&ubbcode(sign)&""
	end if
end if
	response.write " </td><td width=16> </td></tr></table></td></tr><tr>"&_ 
			"<td class=bottomline bgcolor="&bgcolor&" valign=bottom> "&_
            "<hr width=100% size=1 color=#777777>"&_
            "<table width=100% cellpadding=0 cellspacing=0><tr><td align=left valign=middle> "
	if membername<>"" then
		if UserName=membername or boardmaster or master then
			response.write "&nbsp; <a href=editannounce.asp?BoardID="&BoardID&"&RootID="&RootID&"&id="&AnnounceID&"><img src="&picurl&P_edit&" border=0 alt=编辑这个贴子 align=absmiddle></a>"
		end if
	end if
	if BbsUserInfo<4 then
	response.write "&nbsp;<a href=dispuser.asp?name="&HTMLEncode(UserName)&" target=_blank><img src="&picurl&P_userinfo&" border=0 alt=查看"&HTMLEncode(UserName)&"的个人资料 align=absmiddle></a>"
	end if
	if (BbsUserInfo=2 or BbsUserInfo=3) then
	response.write "  <a href=reannounce.asp?BoardID="&BoardID&"&RootID="&RootID&"&id="&AnnounceID&"&reply=true>"&_
			"<img src="&picurl&P_quote&" border=0 alt=引用回复这个贴子 align=absmiddle></a>&nbsp; "&_
		"<a href=reannounce.asp?BoardID="&BoardID&"&RootID="&RootID&"&id="&AnnounceID&">"&_
			"<img src="&picurl&"reply_a.gif border=0 alt=回复这个贴子 align=absmiddle></a>"
	end if
	response.write "</td><td align=left valign=bottom>"
	response.write " 发贴时间： "&dateandtime&" </td>"
	response.write "<td align=right nowarp valign=bottom width=110>"
	if boardmaster or master then
		if AnnounceID<>RootID then				
		response.write "<a href=admin_postings.asp?action=删除跟帖&BoardID="&BoardID&"&ID="&AnnounceID&"&RootID="&RootID&"&username="&htmlencode(UserName)&" title=注意：本操作将删除单个贴子><img src="&picurl&P_delete&" border=0></a> "
		end if
	end if
	response.write "</td><td align=right valign=bottom width=4> </td></tr></table>"&_
			"<img src="""" width=0 height=4><BR></td></tr></table></td>"&_
			"<td bgcolor="&TableBackColor&" valign=middle width=1 height=24> </td></tr></table>"
	response.write "<table cellpadding=0 cellspacing=0 border=0 width=""95%"" bgcolor="&TableBackColor&" align=center>"&_
			"<tr><td height=1> </td></tr></table>"
	page_count = page_count + 1
	rs.movenext
	wend
	end sub

	sub listpage()
	Dim Pcount,endpage
	Pcount=rs.PageCount
	response.write "<table border=0 cellpadding=0 cellspacing=3 width="""&TableWidth&""" align=center>"&_
			"<tr><td valign=middle nowrap>"&_
			"本主题贴数<b>"&totalrec&"</b>，分页： "

	if star > 4 then
	response.write "<a href=""?BoardID="&BoardID&"&RootID="&RootID&"&id="&AnnounceID&"&star=1&skin="&request("skin")&""">[1]</a> ..."
	end if
	if Pcount>star+3 then
	endpage=star+3
	else
	endpage=Pcount
	end if
	for i=star-3 to endpage
	if not i<1 then
		if i = clng(star) then
        response.write " <font color="&AlertFontColor&">["&i&"]</font>"
		else
        response.write " <a href=""?BoardID="&BoardID&"&RootID="&RootID&"&id="&AnnounceID&"&star="&i&"&skin="&request("skin")&""">["&i&"]</a>"
		end if
	end if
	next
	if star+3 < Pcount then 
	response.write "... <a href=""?BoardID="&BoardID&"&RootID="&RootID&"&id="&AnnounceID&"&star="&Pcount&"&skin="&request("skin")&""">["&Pcount&"]</a>"
	end if

	rs.close
	set rs=nothing
	if boardskin=2 then set grs=nothing
	response.write "</td><td valign=middle nowrap align=right><select onchange=""if(this.options[this.selectedIndex].value!=''){location=this.options[this.selectedIndex].value;}""><option selected>跳转论坛至...</option>"

	dim rs1,sql1
	sql="select id,class from class order by id"
	set rs=server.createobject("adodb.recordset")
	set rs1=server.createobject("adodb.recordset")
	rs.open sql,conn,1,1
	if not(rs.eof and rs.bof) then
	do while not rs.eof
	response.write "<option style=BACKGROUND-COLOR:"&TableTitleColor&">╋ "& rs(1) &"</option>"

		sql1="select boardid,boardtype from board where "&guestlist&" class="& rs(0)&" order by boardid"
		set rs1=server.createobject("adodb.recordset")
		rs1.open sql1,conn,1,1
		if rs1.eof and rs1.bof then
			rs1.close : set rs1=nothing
			response.write "<option>没有论坛</option>"
		else
			do while not rs1.eof
				response.write "<option value=""list.asp?boardid="&rs1(0)&""">　├" & rs1(1) & "</option>"
			rs1.movenext
			loop
			rs1.close
			set rs1=nothing
		end if

	rs.movenext
	loop
	rs.close
	set rs=nothing
	end if
	response.write "</select></td></tr></table>"
	end sub

	sub treelist()
	dim outtext,bytestr,fontcolor
	response.write "<br>"
	response.write "<table cellpadding=0 cellspacing=0 border=0 width="""&TableWidth&""" align=center>"&_
			"<tr bgcolor="&TableTitleColor&"><td align=left width=90% valign=middle> <font color="&TableFontColor&">&nbsp;<b>*树形目录</b></td>"&_
			"<td width=10% align=right valign=middle height=24> <a href=#top><img src=pic/gotop.gif border=0><font color="&TableFontColor&">顶端</font></a>&nbsp;</td></tr>"
	set rs=server.createobject("adodb.recordset")
   	sql="select AnnounceID,parentID,BoardID,UserName,Topic,DateAndTime,hits,length,RootID,layer,orders,Expression,times,body from bbs1 where BoardID="&cstr(BoardID)&" and RootID="&RootID&" and not Locktopic=2 order by RootID desc,orders"
   	rs.open sql,conn,1,1
	if not(rs.eof and rs.bof) then
       do while not (rs.eof or err.number<>0)
          if bgcolor=TableBodyColor then
			bgcolor=aTableBodyColor
          	outtext=outtext&"<TR bgColor="&bgcolor&"><td width=""100%"" height=22 colspan=2>"
          else
			bgcolor=TableBodyColor
          	outtext=outtext&"<TR bgColor="&bgcolor&"><td width=""100%"" height=22 colspan=2>"
          end if         
          if clng(AnnounceID)=rs(0) then
			fontcolor="<font color="&AlertFontColor&">"
		  else
		    fontcolor=""
		  end if
          bytestr="("+cstr(rs("length"))
          if rs("Length")-1=1 then
                bytestr=bytestr+"字)"
		  else
	        bytestr=bytestr+"字)"
      	  end if
         if rs("length")=0 then
         	bytestr="(空)"
         end if
 
	  dim i 
	  if rs("layer")>1 then
	  	for i=2 to rs("layer")
			 outtext=outtext & " &nbsp; &nbsp; "
	  	next
		outtext=outtext & "回复："
	  else
	      outtext=outtext & "主题："
	  end if
	  if instr(rs("Expression"),"face")>0 then
          outtext=outtext & "&nbsp;<img src="&faceurl&rs("Expression")&">  "
	  else
	      outtext=outtext & "&nbsp;<img src="&faceurl&"face1.gif>  "
	  end if
          outtext=outtext &  "<a href='dispbbs.asp?BoardID="&BoardID&"&RootID="&cstr(rs("RootID"))&"&ID="&Cstr(rs("AnnounceID"))&"&skin=1'>" & fontcolor
	if rs("topic")="" or isnull(rs("topic")) then
   	   if len(rs("body"))>35 then
	   	outtext=outtext & mid(htmlencode(replace(rs("body"),chr(10),"")),1,49)+".."
	   else
	   	outtext=outtext & htmlencode(replace(rs("body"),chr(10),""))
	   end if
	else
   	   if len(rs("Topic"))>35 then
	   	outtext=outtext & mid(htmlencode(rs("Topic")),1,49)+".."
	   else
	   	outtext=outtext & htmlencode(rs("Topic"))
	   end if
	end if

          outtext=outtext & "</font></a><I><font color=gray>"&bytestr&" － "
          outtext=outtext & "<a href=dispuser.asp?name="&htmlencode(rs("UserName"))&" target=_blank title='作者资料'><font color=gray>" 
          outtext=outtext & HTMLEncode(rs("UserName"))
          outtext=outtext & "</font></a>，" & Formatdatetime(rs("DateAndTime"),1)

 		outtext =outtext & "</font></I></td></tr>"
          rs.movenext
          response.write outtext
          outtext=""

       loop
	end if
	rs.close
	set rs=nothing
	response.write "</table><br>"
	end sub

	sub fastreply()

	if boardskin<>4 then
	response.write "<table cellpadding=0 cellspacing=0 border=0 width="""&TableWidth&""" align=center>"&_
			"<tr bgcolor="&TableTitleColor&"><td align=left width=90% valign=middle> <font color="&TableFontColor&">&nbsp;<b>*快速回复</b>："&htmlencode(topic_1)&"</font></td>"&_
			"<td width=10% align=right valign=middle height=24> <a href=#top><img src=pic/gotop.gif border=0><font color="&TableFontColor&">顶端</font></a>&nbsp;</td></tr></table>"

	response.write "<TABLE cellSpacing=1 cellPadding=1 width="""&TableWidth&""" border=0 align=center>"&_
			"<TBODY> <TR bgColor="&TableBackColor&"><TD vAlign=top colSpan=3> "&_
			"<TABLE cellSpacing=0 cellPadding=3 width=""100%"" bgColor="&TableTitleColor&" border=0>"&_
			"<form action=SaveReAnnounce.asp?method=fastreply&BoardID="&BoardID&" method=POST  name=frmAnnounce onSubmit=submitonce(this)>"&_
			"<input type=hidden name=followup value="&request("id")&">"&_
			"<input type=hidden name=RootID value="&RootID&">"&_
			"<INPUT TYPE=hidden name=boardtype value="&htmlencode(boardtype)&">"&_
			"<TBODY>"
	if membername="" then
	response.write "<TR bgColor="&TableBodyColor&"><TD noWrap width=175>你的用户名:</TD>"&_
            "<TD><INPUT maxLength=25 size=15 value="""&membername&""" name=UserName >"&_
            "&nbsp;&nbsp; <A href=reg.asp>还没注册?</A> 密码:"&_ 
            "<INPUT type=password maxLength=13 size=15 value="""&memberword&""" name=passwd >"&_
            "&nbsp;&nbsp; <A href=lostpass.asp>忘记密码?</A></TD></TR>"
	end if
	response.write "<TR bgColor="&aTableBodyColor&"> <TD vAlign=top noWrap><b>内容</b><br>"
	response.write "<li>最多"&AnnounceMaxBytes\1024&"KB </TD><TD> "&_
			"<TEXTAREA name=Content cols=80 rows=6 wrap=VIRTUAL title=可以使用Ctrl+Enter直接提交贴子  onkeydown=ctlent()></TEXTAREA>"&_
            "</TD></TR><TR bgColor="&TableBodyColor&"><TD noWrap>"&_ 
            "<INPUT type=checkbox CHECKED value=yes name=signflag>"&_
            "显示签名 </TD><TD width=""100%""> <font color="&TableContentColor&">"&_
            "<input type=Submit value=OK!发表我的回应帖子 name=Submit>"&_
            "&nbsp;<input type=button value='预 览' name=Button onclick=gopreview()>&nbsp;<input type=reset name=Clear value=清空内容！>"&_
            "[<font color="&AlertFontColor&">Ctrl+Enter直接提交贴子</font>]</font> </TD>"&_
			"</TR></FORM></TBODY></TABLE></TD></TR> </TBODY> </TABLE>"
%>
		<form name=preview action=preview.asp method=post target=preview_page>
		<input type=hidden name=title value=""><input type=hidden name=body value="">
		</form>
		<script>
		function gopreview()
		{
		//document.forms[1].title.value=document.forms[0].subject.value;
		document.forms[1].body.value=document.forms[0].Content.value;
		var popupWin = window.open('preview.asp', 'preview_page', 'scrollbars=yes,width=750,height=450');
		document.forms[1].submit()
		}
		</script>
<%
	if err.number<>0 then err.clear
	end if
	response.write "<p> "
	if (boardmaster or master) and Clng(request("ID"))=Clng(rootid) then
		response.write "<TABLE cellSpacing=0 cellPadding=0 width="""&TableWidth&""" border=0 align=center>"&_
				"<tr valign=center> <td width =100% align=right> "&_
				"<a href=admin_postings.asp?action=删除主题&BoardID="&BoardID&"&ID="&rootid&"&RootID="&RootID&"&username="&server.urlencode(UserName)&" title=注意：本操作将删除本主题所有贴子，不能恢复>删除</a>"&_ 
				"  | <a href=admin_postings.asp?action=移动&BoardID="&BoardID&"&ID="&rootid&"&RootID="&RootID&" title=移动主题>移动</a>  |  "
    response.write "<a href=""admin_boardaset.asp?BoardID="&BoardID&""">发布公告</a>"
	response.write "</td></tr></table>"
	end if 
	end sub

   	sub chkInput
	'on error resume next
	if request("boardid")="" then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>请指定论坛版面。"
	elseif not isInteger(request("boardid")) then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>非法的版面参数。"
	else
		boardid=request("boardid")
	end if
	if request("id")="" then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>请指定相关贴子。"
	elseif not isInteger(request("id")) then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>非法的贴子参数。"
	else
		AnnounceID=request("id")
	end if
	if request("star")="" then
		star=1
	elseif not isInteger(request("star")) then
		star=1
	else
		star=request("star")
	end if

	if request("skin")="" then
		skin=DvbbsSkin
	elseif not isInteger(request("skin")) then
		skin=DvbbsSkin
	else
		skin=request("skin")
	end if
	if skin=1 then
		nskin=0
		skinpic=P_flatview
		skiname="平板"
	elseif skin="0" then
		nskin=1
		skinpic=P_treeview
		skiname="树形"
	else
		skin=0
		nskin=1
		skinpic=P_treeview
		skiname="树形"
	end if
    end sub

sub readRe()
	dim rs1,ID
	set rs1=conn.execute("select reAnn from [user] where UserID="&UserID&" and reAnn is not null")
	if not (rs1.eof and rs1.bof) then
		ID=split(rs1("reAnn"),"|")(1)
		if clng(ID)=clng(RootID) then
			conn.execute ("update [user] set reAnn=null where UserID="&UserID)
		end if
	end if
	rs1.close
	set rs1=nothing
end sub

function isOnline(UserName,sex)
	dim ors
	set ors=conn.execute("select username from online where username='"&username&"'")
	if ors.eof and ors.bof then
		if sex=1 then
		isonline="<img src=pic/ofMale.gif>"
		else
		isonline="<img src=pic/ofFeMale.gif>"
		end if
	else
		if sex=1 then
		isonline="<img src=pic/Male.gif>"
		else
		isonline="<img src=pic/FeMale.gif>"
		end if
	end if
	ors.close
	set ors=nothing
end function
Function GetIp(IP)
dim ips
ips=Split(ip,".")
GetIp=ips(0)&"."&ips(1)&".*.*"
end Function
%>
<!--#include file=footer.asp -->
<script language=javascript>
ie = (document.all)? true:false
if (ie){
function ctlent(eventobject){if(event.ctrlKey && window.event.keyCode==13){this.document.frmAnnounce.submit();}}
}

function submitonce(theform){
//if IE 4+ or NS 6+
if (document.all||document.getElementById){
//screen thru every element in the form, and hunt down "submit" and "reset"
for (i=0;i<theform.length;i++){
var tempobj=theform.elements[i]
if(tempobj.type.toLowerCase()=="submit"||tempobj.type.toLowerCase()=="reset")
//disable em
tempobj.disabled=true
}
}
}
</script>