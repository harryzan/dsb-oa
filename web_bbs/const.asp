<%
	UserAgent=Trim(Request.Servervariables("HTTP_USER_AGENT"))
	If Instr(UserAgent,"Teleport")>0 or Instr(UserAgent,"WebZIP")>0 or Instr(UserAgent,"flashget")>0 or Instr(UserAgent,"offline")>0 Then
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
	dim index_ad_t,index_ad_f,index_moveFlag
	dim MovePic,MoveUrl,move_w,move_h,Board_moveFlag
	dim fixupPic,FixupUrl,Fixup_w,Fixup_h,Board_fixupFlag
	dim Tablebackcolor,aTablebackcolor,Tabletitlecolor,aTabletitlecolor
	dim Tablebodycolor,aTablebodycolor,TableFontcolor,TableContentcolor
	dim AlertFontColor,ContentTitle,ReplyColor,ForumBody,TableWidth,BodyFontColor,BoardLinkColor
	dim wealthReg,wealthAnnounce,wealthReannounce,wealthDel,wealthLogin
	dim epReg,epAnnounce,epReAnnounce,epDel,epLogin
	dim cpReg,cpAnnounce,cpReAnnounce,cpDel,cpLogin
	dim copyright,Version,Cookiepath,Badwords,Splitwords,StopReadme,Maxonline,MaxonlineDate
	dim pic_om,pic_ob,pic_ov,pic_ou,pic_oh,online_mc
	dim F_mode1_o,F_mode1_n,F_mode2_o,F_mode2_n,F_mode3_o,F_mode3_n,F_mode4_o
	dim F_mode_n,F_mode5_o,F_mode5_n,F_mode6_o,F_mode6_n,F_mode7_o,F_mode7_n
	dim F_link,P_post,P_vote,P_paper,P_reply,P_help

sub getConst()
	sql = "select * from config where active=1"
	set rs = server.CreateObject ("adodb.recordset")
	rs.open sql,conn,1,1
	Forum_info=split(rs(1),",")
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

	Forum_Setting=split(rs(2),",")
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

	Forum_ads=split(rs(3),",")
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

	Forum_body=split(rs(4),",")
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

	Forum_user=split(rs(5),",")
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

	Copyright=rs(6)
	Version=" "

	cookiepath=rs(7)
	badwords=rs(8)
	Splitwords=rs(9)
	StopReadme=rs(10)
	Maxonline=rs(11)
	MaxonlineDate=rs(12)

	Forum_pic=split(rs(18),",")
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
	Forum_boardpic=split(rs(19),",")
	F_link=Forum_boardpic(0)
	P_post=Forum_boardpic(1)
	P_vote=Forum_boardpic(2)
	P_paper=Forum_boardpic(3)
	P_reply=Forum_boardpic(4)
	P_help=Forum_boardpic(5)
	rs.close
	set rs=nothing
end sub
call getConst()
if cint(ForumStop)=1 then
response.write StopReadme
conn.close
set conn=nothing
response.end
end if
Server.ScriptTimeOut=ScriptTimeOut
%>
