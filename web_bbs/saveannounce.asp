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
	rem ------������ʼ------
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

	rem ------���asp�ļ�����------
	call getInput()
	
	rem -----���user�������ݵĺϷ���------	
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
	rem ------���������------
	rem ----------------------
	rem ����û��������ݺϷ���
	sub checkUser()
	select case boardskin
	case 1

	case 2
		exit sub
	case 3
		if not(boardmaster or master) then
		Founderr=true
		Errmsg=Errmsg+"<br>"+"<li>������̳��̳���Ͱ��������ԣ�����<a href=reg.asp><font color="&TableContentColor&">ע���û�</font></a>ֻ�ܻظ�"
		exit sub
		end if
	case 4
		if not(boardmaster or master) then
		Founderr=true
		Errmsg=Errmsg+"<br>"+"<li>��������ֻ���������̳�����ԺͲ���"
		exit sub
		end if
	case 5
		if username="" then
			founderr=true
			Errmsg=Errmsg+"<br>"+"<li>����̳Ϊ��֤��̳����<a href=login.asp>��½</a>��ȷ�������û����Ѿ��õ�����Ա����֤����롣"
			exit sub
		else
			if chkboardlogin(boardid,username)=false then
			founderr=true
			Errmsg=Errmsg+"<br>"+"<li>����̳Ϊ��֤��̳����ȷ�������û����Ѿ��õ�����Ա����֤����롣"
			exit sub
			end if
		end if
	case 6
		if username="" then
		Founderr=true
		Errmsg=Errmsg+"<br>"+"<li>������̳��ֻ��<a href=login.asp><font color="&TableContentColor&">��½�û�</a>���������̳������"
		exit sub
		end if
	end select

	usercookies=request.Cookies("esbpbbs")("usercookies")
	if isnull(usercookies) or usercookies="" then usercookies=3

	if chkuserlogin(username,userpassword,usercookies,2)=false then
		errmsg=errmsg+"<br>"+"<li>�����û����������ڣ���������������󣬻��������ʺ��ѱ�����Ա������"
		founderr=true
		exit sub
	end if

	if lockboard=2 then
		if not master then
			Errmsg=ErrMsg+"<Br>"+"<li>��û��Ȩ���ڱ����淢�����ӣ�"
			FoundErr=true
		end if
	end if
	stats=boardtype & "�������ӳɹ�"
	end sub

	rem ����������Ϣ
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
			ErrMsg=ErrMsg+"<Br>"+"<li>���ݿ����ʧ�ܣ����Ժ�����"&err.Description 
  	       	call Error()
		else
			call success()
    		end if
	set rs=nothing
	end sub

	rem ------���asp�ļ�����------
	sub getInput()
	if request("boardid")="" then
		FoundErr=true
		Errmsg=Errmsg+"<br>"+"<li>��ָ����̳���档"
	elseif not isInteger(request("boardid")) then
		FoundErr=true
		Errmsg=Errmsg+"<br>"+"<li>�Ƿ��İ��������"
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

	rem -----���user�������ݵĺϷ���------	
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
   	'	ErrMsg=ErrMsg+"<Br>"+"<li>���ύ�����ݲ��Ϸ����벻Ҫ���ⲿ�ύ���ԡ�"
   	'	FoundErr=True
	'end if
	if UserName="" or UserPassWord="" then
		username=membername
		UserPassWord=memberword
	end if
	if UserName="" or strLength(UserName)>20 then
   		ErrMsg=ErrMsg+"<Br>"+"<li>����������(���Ȳ��ܴ���20)"
   		FoundErr=True
	end if
	if Topic="" then
   		FoundErr=True
   		if Len(ErrMsg)=0 then
      			ErrMsg=ErrMsg+"<Br>"+"<li>���ⲻӦΪ�ա�"
   		else
      			ErrMsg=ErrMsg+"<Br>"+"<li>���ⲻӦΪ�ա�"
   		end if
	elseif strLength(topic)>100 then
   		FoundErr=True
   		if strLength(ErrMsg)=0 then
      			ErrMsg=ErrMsg+"<Br>"+"<li>���ⳤ�Ȳ��ܳ���100"
   		else
      			ErrMsg=ErrMsg+"<Br>"+"<li>���ⳤ�Ȳ��ܳ���100"
   		end if
			end if
	if strLength(body)>AnnounceMaxBytes then
   		ErrMsg=ErrMsg+"<Br>"+"<li>�������ݲ��ô���" & CSTR(AnnounceMaxBytes) & "bytes"
   		FoundErr=true
	end if
    if body="" then
	ErrMsg=ErrMsg+"<Br>"+"<li>û����д���ݡ�"
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
	PostRetrunName="��ҳ"
	case 2
	response.write "<meta http-equiv=refresh content=""3;URL=list.asp?boardid="&boardid&""">"
	PostRetrunName="������������̳"
	case 3
	response.write "<meta http-equiv=refresh content=""3;URL=dispbbs.asp?boardid="&boardid&"&rootid="&announceid&"&id="&announceid&"&star="&request("star")&""">"
	PostRetrunName="�������������"
	end select

	response.write "<br><table cellpadding=0 cellspacing=0 border=0 width="&tablewidth&" bgcolor="&tablebackcolor&" align=center>"&_
		"<tr><td><table cellpadding=3 cellspacing=1 border=0 width=""100%"">"&_
		"<tr align=center><td width=""100%"" bgcolor="&tabletitlecolor&"><b><FONT COLOR="&TableFontcolor&">״̬�����������ӳɹ�</font></b></td>"&_
		"</tr><tr><td width=""100%"" bgcolor="&tablebodycolor&">"&_
		"<FONT COLOR="&TableContentcolor&">��ҳ�潫��3����Զ�����"&PostRetrunName&"��<b>������ѡ�����²�����</b><br><ul>"&_
		"<li><a href=""index.asp""><font color="""&TableContentcolor&""">������ҳ</font></a></li>"&_
		"<li><a href=""list.asp?boardid="&boardid&"""><font color="""&TableContentcolor&""">"&boardtype&"</font></a></li>"&_
		"<li><a href=""dispbbs.asp?boardid="&boardid&"&rootid="&announceid&"&id="&announceid&"&star="&request("star")&"""><font color="""&TableContentcolor&""">���������</font></a></li>"&_
		"</ul></td></tr></table></td></tr></table>"
	end sub
%>
<!--#include file="footer.asp"-->