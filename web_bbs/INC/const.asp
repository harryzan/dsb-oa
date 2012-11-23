<%
	REM ========论坛基本变量定义=======
	dim UserAgent,Stats
	dim sql,rs
	UserAgent=Trim(lcase(Request.Servervariables("HTTP_USER_AGENT")))
	If Instr(UserAgent,"teleport")>0 or Instr(UserAgent,"webzip")>0 or Instr(UserAgent,"flashget")>0 or Instr(UserAgent,"offline")>0 Then
	response.redirect "error.htm"
        response.end
	end if
	dim ForumName,ForumURL,CompanyName,HostUrl
	dim SMTPServer,SystemEmail,ForumLogo,Picurl,Faceurl,GMT
	dim TimeAdjust,ScriptTimeOut,EmailFlag,Uploadpic,IpFlag
	dim FromFlag,TitleFlag,uploadFlag,kickTime,guestlogin,openmsg
	dim MaxAnnouncePerPage,Maxtitlelist,AnnounceMaxBytes
	dim online_u,online_g,LinkFlag,TopicFlag
	dim VoteFlag,ReflashFlag,ReflashTime
	dim ForumStop,RegTime,EmailReg,EmailRegOne,RegFlag
	dim online_n,ViewUser_g,ViewUser_u,BirthFlag
	dim runtime,FastLogin,GroupFlag
	dim index_ad_t,index_ad_f,index_moveFlag,index_fixupFlag
	dim MovePic,MoveUrl,move_w,move_h,Board_moveFlag
	dim fixupPic,FixupUrl,Fixup_w,Fixup_h,Board_fixupFlag
	dim Tablebackcolor,aTablebackcolor,Tabletitlecolor,aTabletitlecolor
	dim Tablebodycolor,aTablebodycolor,TableFontcolor,TableContentcolor
	dim AlertFontColor,ContentTitle,ReplyColor,ForumBody,TableWidth,BodyFontColor,BoardLinkColor
	dim user_fc,user_mc,bmaster_fc,bmaster_mc,master_fc,master_mc,vip_fc,vip_mc
	dim wealthReg,wealthAnnounce,wealthReannounce,wealthDel,wealthLogin
	dim epReg,epAnnounce,epReAnnounce,epDel,epLogin
	dim cpReg,cpAnnounce,cpReAnnounce,cpDel,cpLogin
	dim copyright,Version,Cookiepath,Badwords,Splitwords,StopReadme,Maxonline,MaxonlineDate
	dim pic_om,pic_ob,pic_ov,pic_ou,pic_oh,online_mc,viewcolor
	dim F_mode1_o,F_mode1_n,F_mode2_o,F_mode2_n,F_mode3_o,F_mode3_n,F_mode4_o
	dim F_mode4_n,F_mode5_o,F_mode5_n,F_mode6_o,F_mode6_n,F_mode7_o,F_mode7_n
	dim F_link,P_post,P_vote,P_paper,P_reply,P_help,P_gohome,P_folder,P_ofolder
	dim P_newmsg,P_mytopic,P_treeview,P_flatview,P_nexttopic,P_backTopic,P_reflash,P_call
	dim P_save,P_report,P_print,P_EmailPost,P_bbsfav,P_EmailPage,P_iefav,P_sms,P_search,P_userinfo
	dim P_Email,P_oicq,P_icq,P_msn,P_homepage,P_quote,P_edit,P_delete,P_copy,P_isbest,P_ip,P_friend
	dim P_opentopic,P_hotTopic,P_closeTopic,P_istop,P_Tisbest,P_newTopic
	dim P_userlist,P_Top20,P_nowTime,P_online_s,P_birth,P_userfrom,P_isvote
	dim uploadsize,Forum_upload,relaypost,relayposttime,facenum,imgnum,facename,imgname
	dim strAllowForumCode,strAllowHTML,strIMGInPosts,strIcons,strflash,vote_Num
	dim guestlist,boardtype,lockboard,boardskin,master_2,todaynum
	dim bold,italicize,underline,center,url1,email1,image,swf,Shockwave,rm,mp,qt,quote1,fly,move,glow,shadow
	dim smsflag,SendRegEmail,Search_G,bmflag_1,bmflag_2,bmflag_3,bmflag_4,bmflag_5,RegFaceNum
	dim i,boardid,LastTopicNum,LastPostTime,LastPostInfo
	REM ======论坛新增变量定义0320+======
	Dim NavLighColor,NavDarkColor,IEbarColor
	Dim SmallPaper,SmallPaper_g,SmallPaper_m
	Dim FontSize,FontHeight,BbsUserInfo,DvbbsSkin,SkinFontNum,UpLoadPath
	Dim UserubbCode,UserHtmlCode,UserImgCode,TopUserNum,PostRetrun,UserPostAdmin
	Dim BestWealth,BestuserCP,BestuserEP,bbsEven,bbsEvenView
	dim scriptname
	scriptname=lcase(request.ServerVariables("PATH_INFO"))
	
sub getConst()
dim Forum_info,Forum_setting,Forum_ubb,Forum_body,Forum_ads,Forum_user
dim Forum_pic,Forum_boardpic,Forum_TopicPic,Forum_statePic
dim master_1,boardmasterlist
if not isnumeric(request("boardid")) or request("boardid")="" or request("boardid")="0" or instr(scriptname,"index.asp")>0 then
	if not isnumeric(request("skinid")) or request("skinid")="" then
	sql = "select Forum_info,Forum_Setting,Forum_ads,Forum_body,Forum_user,Forum_Copyright,badwords,Splitwords,StopReadme,Forum_pic,Forum_boardpic,Forum_TopicPic,Forum_statePic,Forum_upload,Forum_ubb,cookiepath,Maxonline,MaxonlineDate from config where active=1"
	else
	sql = "select Forum_info,Forum_Setting,Forum_ads,Forum_body,Forum_user,Forum_Copyright,badwords,Splitwords,StopReadme,Forum_pic,Forum_boardpic,Forum_TopicPic,Forum_statePic,Forum_upload,Forum_ubb,cookiepath,Maxonline,MaxonlineDate from config where id="&request("skinid")
	end if
	boardid=0
else
	sql = "select Forum_info,Forum_Setting,Forum_ads,Forum_body,Forum_user,Forum_Copyright,badwords,Splitwords,StopReadme,Forum_pic,Forum_boardpic,Forum_TopicPic,Forum_statePic,Forum_upload,Forum_ubb,boardtype,lockboard,boardmaster,boardskin,todaynum,lasttopicnum,LastPost from board where "&guestlist&" boardid="&request("boardid")
	boardid=clng(request("boardid"))
end if
	set rs = server.CreateObject ("adodb.recordset")
	rs.open sql,conn,1,1
	if rs.eof and rs.bof then
	response.write "请指定正确的参数。"
	response.end
	else
	Forum_info=split(rs(0),",")
	ForumName=Forum_info(0)
	ForumURL=Forum_info(1)
	CompanyName=Forum_info(2)
	HostUrl=Forum_info(3)
	SMTPServer=Forum_info(4)
	SystemEmail=Forum_info(5)
	ForumLogo=Forum_info(6)
	Picurl=Forum_info(7)
	Faceurl=Forum_info(8)
	GMT=Forum_info(9)

	Forum_Setting=split(rs(1),",")
	TimeAdjust=Forum_Setting(0)
	ScriptTimeOut=Forum_Setting(1)
	EmailFlag=Forum_Setting(2)
	Uploadpic=Forum_Setting(3)
	IpFlag=Forum_Setting(4)
	FromFlag=Forum_Setting(5)
	TitleFlag=Forum_Setting(6)
	uploadFlag=Forum_Setting(7)
	kicktime=Forum_Setting(8)
	guestlogin=Forum_Setting(9)
	openmsg=Forum_Setting(10)
	MaxAnnouncePerPage=Forum_Setting(11)
	Maxtitlelist=Forum_Setting(12)
	AnnounceMaxBytes=Forum_Setting(13)
	online_u=Forum_Setting(14)
	online_g=Forum_Setting(15)
	LinkFlag=Forum_Setting(16)
	TopicFlag=Forum_Setting(17)
	VoteFlag=Forum_Setting(18)
	ReflashFlag=Forum_Setting(19)
	ReflashTime=Forum_Setting(20)
	ForumStop=Forum_Setting(21)
	RegTime=Forum_Setting(22)
	EmailReg=Forum_Setting(23)
	EmailRegOne=Forum_Setting(24)
	RegFlag=Forum_Setting(25)
	online_n=Forum_Setting(26)
	ViewUser_g=Forum_Setting(27)
	ViewUser_u=Forum_Setting(28)
	BirthFlag=Forum_Setting(29)
	runtime=Forum_Setting(30)
	FastLogin=Forum_Setting(31)
	GroupFlag=Forum_Setting(32)
	uploadsize=Forum_Setting(33)
	strAllowForumCode=Forum_Setting(34)
	strAllowHTML=Forum_Setting(35)
	strIMGInPosts=Forum_Setting(36)
	strIcons=Forum_Setting(37)
	strflash=Forum_Setting(38)
	vote_Num=Forum_Setting(39)
	facenum=Forum_Setting(40)
	imgnum=Forum_Setting(41)
	relaypost=Forum_Setting(42)
	relayposttime=Forum_Setting(43)
	facename=Forum_Setting(44)
	imgname=Forum_Setting(45)
	smsflag=Forum_Setting(46)
	SendRegEmail=Forum_Setting(47)
	Search_G=Forum_Setting(48)
	bmflag_1=Forum_Setting(49)
	bmflag_2=Forum_Setting(50)
	bmflag_3=Forum_Setting(51)
	bmflag_4=Forum_Setting(52)
	bmflag_5=Forum_Setting(53)
	
	REM regfacenum=Forum_Setting(54)
	rem modify by cjp 20050728
	regfacenum=18
	
	viewcolor=Forum_Setting(55)
	SmallPaper=Forum_Setting(56)
	SmallPaper_g=Forum_Setting(57)
	SmallPaper_m=Forum_Setting(58)
	FontSize=Forum_Setting(59)
	FontHeight=Forum_Setting(60)
	BbsUserInfo=Forum_Setting(61)
	DvbbsSkin=Forum_Setting(62)
	SkinFontNum=Forum_Setting(63)
	UpLoadPath=Forum_Setting(64)
	UserubbCode=Forum_Setting(65)
	UserHtmlCode=Forum_Setting(66)
	UserImgCode=Forum_Setting(67)
	TopUserNum=Forum_Setting(68)
	PostRetrun=Forum_Setting(69)
	UserPostAdmin=Forum_Setting(70)
	bbsEven=Forum_Setting(71)
	bbsEvenView=Forum_Setting(72)

	Forum_ads=split(rs(2),"$")
	index_ad_t=Forum_ads(0)
	index_ad_f=Forum_ads(1)
	index_moveFlag=Forum_ads(2)
	MovePic=Forum_ads(3)
	MoveUrl=Forum_ads(4)
	move_w=Forum_ads(5)
	move_h=Forum_ads(6)
	Board_moveFlag=Forum_ads(7)
	fixupPic=Forum_ads(8)
	FixupUrl=Forum_ads(9)
	Fixup_w=Forum_ads(10)
	Fixup_h=Forum_ads(11)
	Board_fixupFlag=Forum_ads(12)
	index_fixupFlag=Forum_ads(13)

	Forum_body=split(rs(3),",")
	Tablebackcolor=Forum_body(0)
	aTablebackcolor=Forum_body(1)
	Tabletitlecolor=Forum_body(2)
	aTabletitlecolor=Forum_body(3)
	Tablebodycolor=Forum_body(4)
	aTablebodycolor=Forum_body(5)
	TableFontcolor=Forum_body(6)
	TableContentcolor=Forum_body(7)
	AlertFontColor=Forum_body(8)
	ContentTitle=Forum_body(9)
	ReplyColor=Forum_body(10)
	ForumBody=Forum_body(11)
	TableWidth=Forum_body(12)
	BodyFontColor=Forum_body(13)
	BoardLinkColor=Forum_body(14)
	user_fc=Forum_body(15)
	user_mc=Forum_body(16)
	bmaster_fc=Forum_body(17)
	bmaster_mc=Forum_body(18)
	master_fc=Forum_body(19)
	master_mc=Forum_body(20)
	vip_fc=Forum_body(21)
	vip_mc=Forum_body(22)
	NavLighColor=Forum_body(23)
	NavDarkColor=Forum_body(24)
	IEbarColor=Forum_body(25)

	Forum_user=split(rs(4),",")
	wealthReg=Forum_user(0)
	wealthAnnounce=Forum_user(1)
	wealthReannounce=Forum_user(2)
	wealthDel=Forum_user(3)
	wealthLogin=Forum_user(4)
	epReg=Forum_user(5)
	epAnnounce=Forum_user(6)
	epReAnnounce=Forum_user(7)
	epDel=Forum_user(8)
	epLogin=Forum_user(9)
	cpReg=Forum_user(10)
	cpAnnounce=Forum_user(11)
	cpReAnnounce=Forum_user(12)
	cpDel=Forum_user(13)
	cpLogin=Forum_user(14)
	BestWealth=Forum_user(15)
	BestuserCP=Forum_user(16)
	BestuserEP=Forum_user(17)

	Copyright=rs(5)
	Version=" "

	badwords=rs(6)
	Splitwords=rs(7)
	StopReadme=rs(8)

	Forum_pic=split(rs(9),",")
	pic_om=Forum_pic(0)
	pic_ob=Forum_pic(1)
	pic_ov=Forum_pic(2)
	pic_ou=Forum_pic(3)
	pic_oh=Forum_pic(4)
	online_mc=Forum_pic(5)
	F_mode1_o=Forum_pic(6)
	F_mode1_n=Forum_pic(7)
	F_mode2_o=Forum_pic(8)
	F_mode2_n=Forum_pic(9)
	F_mode3_o=Forum_pic(10)
	F_mode3_n=Forum_pic(11)
	F_mode4_o=Forum_pic(12)
	F_mode4_n=Forum_pic(13)
	F_mode5_o=Forum_pic(14)
	F_mode5_n=Forum_pic(15)
	F_mode6_o=Forum_pic(16)
	F_mode6_n=Forum_pic(17)
	F_mode7_o=Forum_pic(18)
	F_mode7_n=Forum_pic(19)

	Forum_boardpic=split(rs(10),",")
	F_link=Forum_boardpic(0)
	P_post=Forum_boardpic(1)
	P_vote=Forum_boardpic(2)
	P_paper=Forum_boardpic(3)
	P_reply=Forum_boardpic(4)
	P_help=Forum_boardpic(5)
	P_gohome=Forum_boardpic(6)
	P_folder=Forum_boardpic(7)
	P_ofolder=Forum_boardpic(8)
	P_newmsg=Forum_boardpic(9)
	P_mytopic=Forum_boardpic(10)
	P_treeview=Forum_boardpic(11)
	P_flatview=Forum_boardpic(12)
	P_nexttopic=Forum_boardpic(13)
	P_backTopic=Forum_boardpic(14)
	P_reflash=Forum_boardpic(15)
	P_call=Forum_boardpic(16)

	Forum_TopicPic=split(rs(11),",")
	P_save=Forum_TopicPic(0)
	P_report=Forum_TopicPic(1)
	P_print=Forum_TopicPic(2)
	P_EmailPost=Forum_TopicPic(3)
	P_bbsfav=Forum_TopicPic(4)
	P_EmailPage=Forum_TopicPic(5)
	P_iefav=Forum_TopicPic(6)
	P_sms=Forum_TopicPic(7)
	P_search=Forum_TopicPic(8)
	P_userinfo=Forum_TopicPic(9)
	P_Email=Forum_TopicPic(10)
	P_oicq=Forum_TopicPic(11)
	P_icq=Forum_TopicPic(12)
	P_msn=Forum_TopicPic(13)
	P_homepage=Forum_TopicPic(14)
	P_quote=Forum_TopicPic(15)
	P_edit=Forum_TopicPic(16)
	P_delete=Forum_TopicPic(17)
	P_copy=Forum_TopicPic(18)
	P_isbest=Forum_TopicPic(19)
	P_ip=Forum_TopicPic(20)
	P_friend=Forum_TopicPic(21)

	Forum_statePic=split(rs(12),",")
	P_opentopic=Forum_statePic(0)
	P_hotTopic=Forum_statePic(1)
	P_closeTopic=Forum_statePic(2)
	P_istop=Forum_statePic(3)
	P_Tisbest=Forum_statePic(4)
	P_newTopic=Forum_statePic(5)
	P_userlist=Forum_statePic(6)
	P_Top20=Forum_statePic(7)
	P_nowTime=Forum_statePic(8)
	P_online_s=Forum_statePic(9)
	P_birth=Forum_statePic(10)
	P_userfrom=Forum_statePic(11)
	P_isvote=Forum_statePic(12)

	Forum_upload=rs(13)
	Forum_ubb=split(rs(14),",")
	bold=Forum_ubb(0)
	italicize=Forum_ubb(1)
	underline=Forum_ubb(2)
	center=Forum_ubb(3)
	url1=Forum_ubb(4)
	email1=Forum_ubb(5)
	image=Forum_ubb(6)
	swf=Forum_ubb(7)
	Shockwave=Forum_ubb(8)
	rm=Forum_ubb(9)
	mp=Forum_ubb(10)
	qt=Forum_ubb(11)
	quote1=Forum_ubb(12)
	fly=Forum_ubb(13)
	move=Forum_ubb(14)
	glow=Forum_ubb(15)
	shadow=Forum_ubb(16)
	if not isnumeric(request("boardid")) or request("boardid")="" or request("boardid")="0" or instr(scriptname,"index.asp")>0 then
	cookiepath=rs(15)
	Maxonline=rs(16)
	MaxonlineDate=rs(17)
	else
	boardtype=rs(15)
	lockboard=rs(16)
	boardmasterlist=rs(17)
	boardskin=rs(18)
	todaynum=rs(19)
	LastTopicNum=rs(20)
	LastPostInfo=split(rs(21),"$")
	if not isdate(LastPostInfo(2)) then LastPostInfo(2)=Now()
	LastPostTime=LastPostInfo(2)
	stats=boardtype
		if trim(boardmasterlist)<>"" then
			master_1=split(boardmasterlist, "|")
			for i = 0 to ubound(master_1)
			master_2=""+master_2+"<a href=""dispuser.asp?name="+master_1(i)+""" target=_blank title=点击查看该版主资料>"+master_1(i)+"</a>&nbsp;"
			next
		else
			master_2="无版主"
		end if
	end if
	end if
	rs.close
	set rs=nothing
end sub
call getConst()
if instr(scriptname,"admin")=0 and instr(scriptname,"stat")=0 then
	if cint(ForumStop)=1 then
	response.write StopReadme
	conn.close
	set conn=nothing
	response.end
	end if
end if
if (instr(scriptname,"list.asp")>0 and instr(scriptname,"toplist")=0 and instr(scriptname,"uploadlist")=0 and instr(scriptname,"friendlist")=0 and instr(scriptname,"favlist")=0) or instr(scriptname,"dispbbs")>0 then
end if

if instr(scriptname,"admin")=0 and instr(scriptname,"stat")=0 then
	if LockIP(Request.ServerVariables("REMOTE_ADDR")) then
	response.write "<table align=center height=20% style=font-size:12px><tr><td>您的IP已经被限制不能访问本论坛，请和管理员联系"&SystemEmail&"。</td></tr></table>"
	response.end
	end if
end if

if cint(guestlogin)=1 and not (boardskin=5 or boardskin=4) then
boardskin=6
end if
Server.ScriptTimeOut=ScriptTimeOut

Dim RequestStr,splitqword
RequestStr=lcase(Request.ServerVariables("Query_String"))
splitqword="delete|update|alter|drop|sp_|create"
splitqword=split(splitqword,"|")
for i=0 to ubound(splitqword)
if instr(1,RequestStr,splitqword(i))>0 then
	response.write "非法的参数。"
	response.end
	exit for
end if
next
%>