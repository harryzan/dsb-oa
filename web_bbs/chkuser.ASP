<%
	dim Founderr,Errmsg
	dim Founduser,userid
	Founduser=false
	Founderr=false
	dim membername,memberword,memberclass
	dim skin
	membername=checkStr(request.cookies("esbpbbs")("username"))
	memberword=checkStr(request.cookies("esbpbbs")("password"))
	memberclass=checkStr(request.cookies("esbpbbs")("userclass"))
	dim guibin,boardmaster,master
	guibin=false
	boardmaster=false
	master=false
	if membername<>"" then
		sql="select userclass,userid from [user] where username='"&membername&"' and userpassword='"&memberword&"'"
		set rs=server.createobject("adodb.recordset")
		rs.open sql,conn,1,1
		if rs.eof and rs.bof then
			Errmsg=Errmsg+"<br>"+"<li>一般程序保护错误，您试图进行不合法的操作。<li>您的密码不正确，请<a href=logout.asp><font color="&TableContentColor&">退出论坛</font></a>或者<a href=login.asp><font color="&TableContentColor&">重新登陆</font></a>。"
			Founderr=true
		else
			founduser=true
			if rs(0)=18 then
				guibin=true
			elseif rs(0)=19 then
				boardmaster=true
			elseif rs(0)=20 then
				master=true
			else
				founduser=true
			end if
			userid=rs(1)
		end if
		rs.close
		set rs=nothing
	end if

	function chkboardmaster(boardid)
	dim brs,ckboardmaster
	chkboardmaster=false
	if master then
		chkboardmaster=true
	else
	if boardmaster then
	sql="select boardmaster,boardid from board where boardid="&boardid
	set brs=server.createobject("adodb.recordset")
	brs.open sql,conn,0,1
	if brs.eof and brs.bof then
		chkboardmaster=false
	else
		ckboardmaster=split(brs(0),"|")
		for i=0 to ubound(ckboardmaster)
			if trim(ckboardmaster(i))=trim(membername) then
			chkboardmaster=true
			else
			chkboardmaster=false
			end if
			if chkboardmaster then exit for
		next
	end if
	brs.close
	set brs=nothing
	else
	chkboardmaster=false
	end if
	end if
	end function
%>