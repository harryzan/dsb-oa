<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!-- #include file="chkuser.asp" -->
<!--#include file=inc/theme.asp -->
<!--#include file="inc/char.asp"-->
<%
	Dim LastLogin,birthnum
	dim Guests

Rem ��ҳ������Ϣ
sub index_head()
	Stats="��̳��ҳ"
	call nav()
	sql="select top 1 TopicNum,BbsNum,TodayNum,UserNum,lastUser from config where active=1"
	set rs=server.createobject("adodb.recordset")
	rs.open sql,conn,0,1
	if isnull(index_ad_t) or index_ad_t="" then
	response.write "<TABLE border=0 width="&TableWidth&" align=center><TBODY>"&_
				"<TR><TD align=left><a href='index.asp'><img border=0 src='"& Forumlogo &"'></a></TD>"&_
				"<TD Align=right>"&_				
				"����������<font color="&AlertFontColor&"><b>"& rs(2) &"</b></font>"&_
				" | ����������<b>"& rs(0) &"</b> | ����������<b>"& rs(1) &"</b> | "&_
				"ע���Ա<B>"& rs(3) &"</B>"&_
				"<p><img src="&picurl&P_newTopic&"> <a href=queryresult.asp?stype=3>�鿴����</a><img src="&picurl&P_Top20&"> <a href=toplist.asp?orders=1>��������</a></font>"&_
				"</TD></TR></TBODY></TABLE><br>"
	else
	response.write "<TABLE border=0 width="&TableWidth&" align=center><TBODY>"&_
				"<TR><TD align=left><a href='"& HostURL &"'><img border=0 src='"& Forumlogo &"'></a></TD>"&_
				"<TD Align=center width=470>"&index_ad_t&"</td><td align=right style=""line-height: 15pt"">"&_
				"<BR><img src="&picurl&P_newTopic&"> <a href=queryresult.asp?stype=3>�鿴����</a><BR><img src="&picurl&P_Top20&"> <a href=toplist.asp?orders=1>��������</a></font>"&_
				"</TD></TR><tr><td colspan=3 align=right><font color="&BodyFontColor&">����������<font color="&AlertFontColor&"><b>"& rs(2) &"</b></font>"&_
				" | ����������<b>"& rs(0) &"</b> | ����������<b>"& rs(1) &"</b> | "&_
				"ע���Ա<B>"& rs(3) &"</B> | "&_
				"</td></tr></TBODY></TABLE><br>"
	end if
	response.write "<style>"&_
				"TABLE {BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 1px; }"&_
				"TD {BORDER-RIGHT: 0px; BORDER-TOP: 0px;  }"&_
				"</style>"&_
				"<table cellspacing=0 border=0 width="&TableWidth&" bgcolor="""&Tablebackcolor&""" align=center><tr><td height=1></td></tr></table>"&_
				"<table cellpadding=6 cellspacing=0 width="&TableWidth&" align=center  bordercolor="&Tablebackcolor&" border=1>"&_
				"<TR><TD bgColor="""&Tablebodycolor&""" colSpan=8>"&_
				"<IMG align=absMiddle src="&Picurl&P_call&">  <font color="&TableContentcolor&">��̳��Ϣ�㲥:"

	rs.close
	if FoundUser then
	sql="select lastlogin from [user] where username='"&membername&"'"
	set rs=conn.execute(sql)
	lastlogin=rs(0)
	rs.close
	set rs=nothing
	end if
	if isnull(lastlogin) or lastlogin="" then lastlogin=now()
	sql="select top 1 boardid,title,addtime from bbsnews where boardid=0 order by addtime desc"
	set rs=server.createobject("adodb.recordset")
	rs.open sql,conn,0,1
	if rs.bof and rs.eof then
		response.write "<b><a href=announcements.asp?boardid=0 target=_blank>��ǰû�й���</a></b>("&now()&")"
	else
		response.write "<b><a href=announcements.asp?boardid=0 target=_blank>"&rs(1)&"</a></b> ("&rs(2)&")"
	end if
	rs.close
	set rs=nothing
	response.write "</font></TD></TR></table>"
end sub

Rem ��ҳ��������
sub index_body()
if membername="" or membername="����" then
	if cint(fastlogin)=1 then call fast_login()
end if
response.write "<table cellpadding=6 cellspacing=0 width="&TableWidth&" align=center  bordercolor="""&Tablebackcolor&""" border=1>"&_
        "<TR bgColor="""&Tabletitlecolor&""">"&_
        "<TD  width=26><B><FONT COLOR="&TableFontcolor&">״̬</font></b></TD>"&_
        "<TD vAlign=center width=*><B><FONT COLOR="&TableFontcolor&">��̳����</FONT></B></TD>"&_
        "<TD vAlign=center align=middle width=80><B><FONT COLOR="&TableFontcolor&">����</FONT></B></TD>"&_
        "<TD vAlign=center noWrap align=middle width=38><B><FONT COLOR="&TableFontcolor&">����</FONT></B> </TD>"&_
        "<TD vAlign=center noWrap align=middle width=38><B><FONT COLOR="&TableFontcolor&">����</FONT></B> </TD>"&_
        "<TD vAlign=center noWrap align=middle width=168><B><FONT COLOR="&TableFontcolor&">��󷢱�</FONT></B> </TD>"&_
		"</TR></table>"
	sql="select id,class from class order by id"
	set rs=server.createobject("adodb.recordset")
	rs.open sql,conn,0,1
	do while not rs.eof
response.write "<table cellpadding=6 cellspacing=0 width="&TableWidth&" align=center  bordercolor="""&Tablebackcolor&""" border=1>"&_
        "<TR><TD bgColor="""&aTablebodycolor&""" colSpan=6><B>"&rs(1)&"</B></TD></TR>"
	call board(rs(0))
	response.write "</table>"
	rs.movenext
	loop
	rs.close
	set rs=nothing
	if master then
	response.write "<table cellpadding=6 cellspacing=0 width="&TableWidth&" align=center  bordercolor="""&Tablebackcolor&""" border=1>"&_
        "<TR><TD bgColor="""&Tablebodycolor&""" colSpan=7><B>��̳����վ</B></TD></TR>"

response.write "<TR><TD vAlign=top align=middle width=26 bgColor="""&aTablebodycolor&""">"
response.write "<img src=pic/ifolder.gif width=13 height=16 alt=��̳����վ>"

response.write "</TD><TD vAlign=top width=* bgColor="""&Tablebodycolor&""" colspan=6> <a href=""recycle.asp""><font color="&BoardLinkColor&">��̳���а������ɾ�������ӡ�</font></a>"
response.write "</TD></TR>"

	response.write "</table>"
	end if
if membername="" or membername="����" then
	if cint(fastlogin)=2 then call fast_login()
end if
	response.write "<BR>"

	Rem ������̳
	dim Tlink,Readme,logo
	set rs=server.createobject("adodb.recordset")
	sql="select boardname,readme,url from bbslink order by id"
	rs.open sql,conn,1,1
	if not rs.eof and not rs.bof then
response.write "<table cellspacing=0 border=0 width="&TableWidth&" bgcolor="""&Tablebackcolor&""" align=center><tr><td height=1></td></tr></table>"&_
		"<table cellpadding=6 cellspacing=0 width="&TableWidth&" align=center  bordercolor="""&Tablebackcolor&""" border=1>"&_
        "<TR><TD bgColor="""&Tabletitlecolor&""" colSpan=2><font color="&TableFontcolor&"><b>��-=> ������̳</b></font></TD></TR>"
	select case LinkFlag
	case 0
	do while not rs.eof
	Tlink=split(rs(1),"$")
	readme=Tlink(0)
	if ubound(Tlink)=0 then
	logo="<font color="&BoardLinkColor&">"&htmlencode(rs(0))&"</font>"
	else
	logo="<img src="&Tlink(1)&" border=0>"
	end if
	response.write "<tr bgcolor="""&aTablebodycolor&"""><TD vAlign=top align=middle width=26><IMG src="&picurl&F_link&"> </TD><TD vAlign=top bgColor="""&Tablebodycolor&"""><a href="&rs(2)&" target=_blank><font color="&BoardLinkColor&">"&htmlencode(rs(0))&"</font></a><br>"&htmlencode(readme)&"</TD></TR>"
	rs.movenext
	loop
	case 1
	response.write "<tr bgcolor="""&aTablebodycolor&"""><TD vAlign=top align=middle width=26><IMG src="&picurl&F_link&"> </TD><TD vAlign=top bgColor="""&Tablebodycolor&""">"
	do while not rs.eof
	Tlink=split(rs(1),"$")
	readme=Tlink(0)
	if ubound(Tlink)=0 then
	logo="<font color="&BoardLinkColor&">"&htmlencode(rs(0))&"</font>"
	else
	logo="<img src="&Tlink(1)&" border=0>"
	end if
	response.write "<a href="&rs(2)&" target=_blank title="&htmlencode(rs(0))&"&#13;&#10;"&htmlencode(readme)&"><font color="&BoardLinkColor&">"&htmlencode(rs(0))&"</font></a>������"
	rs.movenext
	loop
	response.write "</TD></tr>"
	case 2
	do while not rs.eof
	Tlink=split(rs(1),"$")
	readme=Tlink(0)
	if ubound(Tlink)=0 then
	logo="<font color="&BoardLinkColor&">"&htmlencode(rs(0))&"</font>"
	else
	logo="<img src="&Tlink(1)&" border=0>"
	end if
	response.write "<tr bgcolor="""&aTablebodycolor&"""><TD vAlign=top align=middle width=26><IMG src="&picurl&F_link&"> </TD><TD vAlign=top bgColor="""&Tablebodycolor&"""><a href="&rs(2)&" target=_blank><table align=left><tr><td><a href="&rs(2)&" target=_blank title="&htmlencode(rs(0))&"&#13;&#10;"&htmlencode(readme)&">"&logo&"</a></td><td width=10></td></tr></table><font color="&BoardLinkColor&">"&htmlencode(rs(0))&"</font></a><br>"&htmlencode(readme)&"</TD></TR>"
	rs.movenext
	loop
	case 3
	response.write "<tr bgcolor="""&aTablebodycolor&"""><TD vAlign=top align=middle width=26><IMG src="&picurl&F_link&"> </TD><TD vAlign=top bgColor="""&Tablebodycolor&""">"
	do while not rs.eof
	Tlink=split(rs(1),"$")
	readme=Tlink(0)
	if ubound(Tlink)=0 then
	logo="<font color="&BoardLinkColor&">"&htmlencode(rs(0))&"</font>"
	else
	logo="<img src="&Tlink(1)&" border=0>"
	end if
	response.write "<a href="&rs(2)&" target=_blank title="&htmlencode(rs(0))&"&#13;&#10;"&htmlencode(readme)&">"&logo&"</a>������"
	rs.movenext
	loop
	response.write "</TD></tr>"
	end select
	response.write "</table>"
	end if
	rs.close
	set rs=nothing

if instr(scriptname,"index.asp")>0 or instr(scriptname,"list.asp")>0 then
	if index_moveFlag=1 then
	call admove()
	end if
	if index_fixupFlag=1 then
	call fixup()
	end if
end if
end sub
call index_head()
call index_body()
call endline()

Rem ������Ϣ
sub board(id)
	dim sql1,rs1
	dim boardview
	dim master_1
	if boardmaster or master then
	sql1="select boardid,boardtype,class,readme,lastbbsnum,boardmaster,lockboard,lasttopicnum,indexIMG,boardskin,boarduser,LastPost from board "
	sql1=sql1&" where class="&id&" order by boardid"
	else
	sql1="select boardid,boardtype,class,readme,lastbbsnum,boardmaster,lockboard,lasttopicnum,indexIMG,boardskin,boarduser,LastPost from board "
	sql1=sql1&" where class="&id&" and lockboard=0 order by boardid"
	end if
	set rs1=server.createobject("adodb.recordset")
	rs1.open sql1,conn,1,1
	do while not rs1.eof
	LastPostInfo=split(rs1(11),"$")
response.write "<TR><TD vAlign=top align=middle width=26 bgColor="""&aTablebodycolor&""">"

if not isdate(LastPostInfo(2)) then LastPostInfo(2)=Now()
select case rs1(9)
case 1
	if datediff("h",lastlogin,LastPostInfo(2))=0 then
	response.write "<img src="&picurl&F_mode1_n&" width=13 height=16 alt=������̳����������>"
	else
	response.write "<img src="&picurl&F_mode1_o&" width=13 height=16 alt=������̳����������>"
	end if
case 2
	if datediff("h",lastlogin,LastPostInfo(2))=0 then
	response.write "<img src="&picurl&F_mode2_n&" width=13 height=16 alt=������̳����������>"
	else
	response.write "<img src="&picurl&F_mode2_o&" width=13 height=16 alt=������̳����������>"
	end if
case 3
	if datediff("h",lastlogin,LastPostInfo(2))=0 then
	response.write "<img src="&picurl&F_mode3_n&" width=13 height=16 alt=������̳����������>"
	else
	response.write "<img src="&picurl&F_mode3_o&" width=13 height=16 alt=������̳����������>"
	end if
case 4
	if datediff("h",lastlogin,LastPostInfo(2))=0 then
	response.write "<img src="&picurl&F_mode4_n&" width=13 height=16 alt=����������������>"
	else
	response.write "<img src="&picurl&F_mode4_o&" width=13 height=16 alt=����������������>"
	end if
case 5
	if datediff("h",lastlogin,LastPostInfo(2))=0 then
	response.write "<img src="&picurl&F_mode5_n&" width=13 height=16 alt=��֤��̳����������>"
	else
	response.write "<img src="&picurl&F_mode5_o&" width=13 height=16 alt=��֤��̳����������>"
	end if
	boardview="��֤��̳"
case 6
	if datediff("h",lastlogin,LastPostInfo(2))=0 then
	response.write "<img src="&picurl&F_mode6_n&" width=13 height=16 alt=������̳����������>"
	else
	response.write "<img src="&picurl&F_mode6_o&" width=13 height=16 alt=������̳����������>"
	end if
	boardview="������̳"
end select

response.write "</TD><TD vAlign=top width=* bgColor="""&Tablebodycolor&"""><font color="&TableContentColor&"> <a href=""list.asp?boardid="&rs1(0)&"""><font color="&BoardLinkColor&">"&rs1(1)&"</font></a>����<font color=gray>"&boardview&"</font><br>"
if rs1(8)<>"" then
	response.write "<table align=left><tr><td><img src="&rs1(8)&" align=top></td><td width=20></td></tr></table>"
end if
response.write rs1(3)
response.write "</TD><TD vAlign=center align=middle bgColor="""&aTablebodycolor&""" width=80>"
master_1=split(rs1(5), "|")
for i = 0 to ubound(master_1)
	if i>2 then
	master_2=master_2
	else
	master_2=""+master_2+"<a href=dispuser.asp?name="+master_1(i)+" target=_blank><font color="&TableContentcolor&">"+master_1(i)+"</a><br>"
	end if
next
if i>3 then master_2=master_2 & "<font color=gray>More...</font>"
response.write master_2
master_2=""

response.write "</TD>"&_
		"<TD vAlign=center noWrap align=middle width=38 bgColor="""&Tablebodycolor&""">"&rs1(7)&"</TD>"&_
        "<TD vAlign=center noWrap align=middle width=38 bgColor="""&Tablebodycolor&""">"&rs1(4)&"</TD>"&_
        "<TD noWrap width=168 bgColor="""&aTablebodycolor&""">"
if rs1(9)=5 then
	response.write "��֤��̳��ָ���û�����鿴��"
else
	response.write "���⣺<a href='dispbbs.asp?Boardid="&rs1(0)&"&ID="&LastPostInfo(1)&"&rootID="&LastPostInfo(1)&"&skin=1'>"&htmlencode(LastPostInfo(3))&"</a><br>"
	response.write "��󷢱�<a href=dispuser.asp?name="&htmlencode(LastPostInfo(0))&" target=_blank>"&htmlencode(LastPostInfo(0))&"</a>��<IMG border=0 src="&picurl&"lastpost.gif><br>" & FormatDateTime(LastPostInfo(2),1) & "��" & FormatDateTime(LastPostInfo(2),4)
end if
response.write "</TD></TR>"
boardview=""
		rs1.movenext
		loop
		rs1.close
		set rs1=nothing
end sub

sub fast_login()
	response.write "<table width="&TableWidth&" cellpadding=6 cellspacing=0 align=center bordercolor="""&Tablebackcolor&""" border=1><tr><td bgColor="""&Tabletitlecolor&""" colSpan=7><font color="&TableFontcolor&"><b>-=&gt; �������ٵ�¼���</b>"&_
	"[<a href=reg.asp><font color="&TableFontcolor&">ע���û�</font></a>]��[<a href=lostpass.asp style=""CURSOR: help""><font color="&TableFontcolor&">��������</font></a>]</b><br>"&_
    "</font></td></tr><form action=chklogin.asp method=post><tr><td align=middle bgColor="""&Tablebodycolor&""""&_
	"width=26><img src="&picurl&P_userlist&" width=16 height=16></td><td bgColor="""&Tablebodycolor&""" colSpan=6 width=*>"&_
	"&nbsp;�û�����<input maxLength=16 name=username size=12>"&_
	"�������룺<input maxLength=20 name=password size=12 type=password>"&_
	" ����<select name=CookieDate><option selected value=0>������</option>"&_
	"<option value=1>����һ��</option><option value=2>����һ��</option><option value=3>����һ��</option>"&_
    "</select>����<input type=submit name=submit value=""�� ½""></font></td></tr></form></table>"
end sub

function birthday()
	dim age
	dim birthuser
	dim foundbirth
	foundbirth=false
	birthNum=0
	'on error resume next
	set rs=server.createobject("adodb.recordset")
	sql="select birthuser from config where active=1"
	rs.open sql,conn,1,1
	if not isnull(rs(0)) or rs(0)<>"" then
	birthuser=split(rs(0),"$")
	if ubound(birthuser)<3 then
		foundbirth=false
	elseif datediff("d",birthuser(2),Now())>0 then
		foundbirth=false
	else
		foundbirth=true
	end if
	else
	foundbirth=false
	end if
	if not foundbirth then
		set rs=conn.execute("select username,birthday from [user] where month(birthday)=month(Now()) and day(birthday)=day(Now())")
		if rs.eof and rs.bof then
		birthday="����û�����ѹ�����"
		else
		do while not rs.eof
		if isdate(rs(1)) then
			age=datediff("yyyy",rs(1),Now())
			birthday=birthday & "<a href=dispuser.asp?name="&rs(0)&" title=ף"&age&"�����տ��֣� target=_blank>"&rs(0)&"</a>��"
			birthNum=birthNum+1
		end if
		rs.movenext
		loop
		end if
		rs.close
		set rs=nothing
		conn.execute("update config set birthuser='" & birthday & "$" & birthNum & "$" & Now() & "' where active=1")
	else
		birthday=birthuser(0)
		birthNum=birthuser(1)
	end if
end function
%>
<!--#include file="online_l.asp"-->
<!--#include file="inc/ad_fixup.asp"-->
<!--#include file="footer.asp"-->