<!--#include file=grade.asp-->
<%
sub nav()
	response.write "<html><head><meta NAME=GENERATOR Content=""Microsoft FrontPage 4.0"" CHARSET=GB2312><title>"&ForumName&"--"&stats&"</title>"
%>
<!--#include file=js.asp-->
<!--#include file=online.asp-->
<!--#include file=../Forum_css.asp-->
<%
	response.write "</head>"&_
				"<body  "&Forumbody&">"

response.write "<table width="&TableWidth&" border=0 cellpadding=3 cellspacing=0 align=center height=6><tr><td bgcolor="&NavDarkColor&"></td></tr></table>"&_
			"<table width="&TableWidth&" cellspacing=0 cellpadding=3 border=0 bgcolor="& NavLighcolor &" align=center>"&_
			"<tr>"&_
			"<td valign=middle ><font color="&tablecontentcolor&"> >>" 

REM if membername="" then
REM 	response.write "欢迎您，<a href=login.asp>请先登陆</a> | <a href=reg.asp>注册</a>"
REM else
REM 	response.write "欢迎您，<b>"& membername &"</b>： <a href=login.asp>重登陆</a> | <a href=MYMODIFY.ASP?name="& membername &">"&_
REM 				"信息</a> | <a href=usersms.asp>短消息</a> "
REM end if

if membername="" then
	response.write "欢迎您! "
else
	response.write "欢迎您，<b>"& membername &"</b>： <a href=MYMODIFY.ASP?name="& membername &">"&_
				"信息</a> | <a href=usersms.asp>短消息</a> "
end if

response.write " | <a href=toplist.asp?orders=1 >排行</a> | <a href=query.asp?boardid="&boardid&">搜索</a>"
REM response.write " | <a href=logout.asp>退出</a>"
if master then
	response.write " | <a href=admin_index.asp>管理</a>"
end if

REM response.write "</td><td valign=middle align=right>"&_
REM 			"<a href='"& ForumURL &"'><img src="&picurl&P_gohome&" border=0></a>"&_
REM 			"</td></tr></table>"
response.write "</td><td valign=middle align=right>"&_			
			"</td></tr></table>"

	response.write "<table width="&tablewidth&" align=center cellspacing=0 cellpadding=1  border=0>"&_
			"<tr><td align=left width=""50%"">"
	if membername<>"" then
	response.write "<img src=pic/mybbs.gif><a href=topicwithme.asp?s=1 target=_top>我参与的主题</a>  |  <a href=topicwithme.asp?s=2 target=_top>已被回复的我的发言</a>"
	end if
	response.write "</td><td align=right width=""50%"">"

if membername<>"" then
	call getRe()
	if Cint(newincept())>Cint(0) then
		response.write "<bgsound src="&picurl&"mail.wav border=0>"
		if openmsg=0 then
		response.write "<img src="&picurl&"newmail.gif><a href=javascript:openScript('messanger.asp?action=read&id="&inceptid(1)&"&sender="&inceptid(2)&"',500,400)>您有新短消息</a>"
		else
		response.write "<script language=JavaScript>openScript('messanger.asp?action=read&id="&inceptid(1)&"&sender="&inceptid(2)&"',500,400)</script>"
		end if
	end if
end if

response.write "</td></tr></table>"
end sub

'统计留言
function newincept()
rs=conn.execute("Select Count(id) From Message Where flag=0 and issend=1 and delR=0 And incept='"& membername &"'")
    newincept=rs(0)
	set rs=nothing
	if isnull(newincept) then newincept=0
end function
function inceptid(stype)
rs=conn.execute("Select top 1 id,sender From Message Where flag=0 and issend=1 and delR=0 And incept='"& membername &"'")
	if stype=1 then
	inceptid=rs(0)
	else
	inceptid=rs(1)
	end if
	set rs=nothing
end function

sub getRe()
	if userid<>"" then
	dim reAnn,ID,reBoardid
	set rs=conn.execute("select ReAnn from [user] where userid="& userid &" and showRe=1 and reAnn is not null")
	if not(rs.eof and rs.bof) then
		reAnn=rs("reAnn")
		reBoardID=split(reAnn,"|")(0)
		ID=split(reAnn,"|")(1)
		response.write "<img src="&picurl&"newmail.gif><a href='dispbbs.asp?boardID="&reBoardID&"&rootID="&ID&"&ID="&ID&"' target=_blank>您的帖子有人回复了</a>"
	end if
	rs.close
	set rs=nothing
	end if
end sub
sub headline(files)
	dim backpage
	response.write "<TABLE border=0 width=""95%"" align=center><TBODY><TR>"&_
			"<TD vAlign=top width=""30%""><a href='index.asp'><img border=0 src="&Forumlogo&"></TD>"&_
			"<TD valign=middle align=top><font color="&bodyfontcolor&"> &nbsp;&nbsp;<img src="&picurl&P_folder&" border=0>&nbsp;&nbsp;<a href=index.asp>"&ForumName&"</a><br>"
	if instr(lcase(request.ServerVariables("PATH_INFO")),"dispbbs")>0 then
	backpage="<a href=javascript:history.go(-1)>[返回]</a>"
	end if
	Select Case files
	case 1
	response.write "&nbsp;&nbsp;<img src="&picurl&"bar.gif border=0 width=15 height=15><img src="&picurl&P_ofolder&" border=0>&nbsp;&nbsp;<a href=list.asp?boardid="&boardid&">"&stats&"</a>"
	case 2
	response.write "&nbsp;&nbsp;<img src="&picurl&"bar.gif border=0 width=15 height=15><img src="&picurl&P_folder&" border=0>&nbsp;&nbsp;"&_
			"<a href=list.asp?boardid="&boardid&"><font color="&BodyFontColor&">"&boardtype&"</a>"&backpage&""&_ 
			"<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="&picurl&"bar.gif border=0 width=15 height=15><img src="&picurl&P_ofolder&" border=0>&nbsp;&nbsp;"&htmlencode(replace(stats,boardtype,""))&""
	end select
	response.write "<a name=top></a></font></TD></TR></TBODY></TABLE><br>"
end sub
%>