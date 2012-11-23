<!--#include file="conn.asp"-->
<!--#include file="inc/const.asp"-->
<!--#include file="inc/char.asp"-->
<!--#include file="chkuser.asp"-->
<!--#include file="inc/theme.asp"-->
<!-- #include file="inc/chkinput.asp" -->
<!--#include file="md5.asp"-->
<%
	dim msg
	stats="发布小字报"
	call nav()
	if boardid=0 then
	founderr=true
	Errmsg=Errmsg+"<br><li>请选择您要发布小字报的版面！"
	end if
	if cint(smallpaper)=0 then
	founderr=true
	Errmsg=Errmsg+"<br><li>该版面没有开放小字报功能！"
	end if
	if smallpaper_g=1 then
	msg="本版面所有人均可发布小字报"
		if membername<>"" then
		membername=membername
		else
		membername="客人"
		end if
	else
	msg="本版面只允许会员发布小字报"
	membername=membername
	end if
	if founderr then
	call headline(1)
	call error()
	else
		call headline(2)
		if request("action")="savepaper" then
			call savepaper()
			if founderr then call error()
		else
			call main()
		end if
	end if
	call endline()
	sub main()
	conn.execute("delete from SmallPaper where datediff('d',s_addtime,Now())>1")
%>
<form action="smallpaper.asp?action=savepaper" method="post"> 
<table cellpadding=0 cellspacing=0 border=0 width="<%=tablewidth%>" bgcolor=<%=Tablebackcolor%> align=center>
    <tr>    
        <td>
        <table cellpadding=6 cellspacing=1 border=0 width=100%>
    <tr>
    <td bgcolor=<%=Tabletitlecolor%> valign=middle colspan=2 align=center><font color="<%=TableFontColor%>">
    <b>请详细填写以下信息</b>(<%=msg%>)</font></td></tr>
    <tr>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>"><b>用户名</b></font></td>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><INPUT name=username type=text value="<%=membername%>"> &nbsp; <a href="reg.asp">没有注册？</a></td></tr>
    <tr>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>"><b>密 码</b></font></td>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><INPUT name=password type=password value="<%=memberword%>"> &nbsp; <a href="lostpass.asp">忘记密码？</a></td></tr>
    <tr>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>"><b>标 题</b>(最多80字)</font></td>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><INPUT name="title" type=text size=60></td></tr>
    <tr>
    <td bgcolor=<%=Tablebodycolor%> valign=top width=30%>
<font color="<%=TableContentColor%>"><b>内 容</b><BR>
在本版发布小字报将您将付<font color="<%=AlertFontColor%>"><b><%=smallpaper_m%></b></font>元费用<br>
<font color="<%=AlertFontColor%>"><b>48</b></font>小时内发表的小字报将随机抽取<font color="<%=AlertFontColor%>"><b>5</b></font>条滚动显示于论坛上<br>
<li>HTML标签： <%if strAllowHTML=0 then%>不可用<%else%>允许<%end if%>
<li>UBB 标签： <%if strAllowForumCode=0 then%>不可用<%else%>允许<%end if%>
<li>内容不得超过500字
</font></td>
    <td bgcolor=<%=Tablebodycolor%> valign=middle>
<textarea class="smallarea" cols="60" name="Content" rows="8" wrap="VIRTUAL"></textarea>
<INPUT name="boardid" type=hidden value="<%=boardid%>">
                </td></tr>
    <tr>
    <td bgcolor=<%=Tabletitlecolor%> valign=middle colspan=2 align=center><input type=submit name="submit" value="发 布"></td></tr></table></td></tr></table>
</form>
<%end sub%>
<%
sub savepaper()
	dim username
	dim password
	dim title
	dim content
   	UserName=Checkstr(trim(request.form("username")))
   	PassWord=Checkstr(trim(request.form("password")))
   	Title=Checkstr(trim(request.form("title")))
   	Content=Checkstr(request.form("Content"))
	if chkpost=false then
   		ErrMsg=ErrMsg+"<Br>"+"<li>您提交的数据不合法，请不要从外部提交发言。"
   		FoundErr=True
	end if
	if UserName="" then
   		ErrMsg=ErrMsg+"<Br>"+"<li>请输入姓名"
   		FoundErr=True
	end if
	if title="" then
   		FoundErr=True
      		ErrMsg=ErrMsg+"<Br>"+"<li>主题不应为空。"
	elseif strLength(title)>80 then
   		FoundErr=True
      		ErrMsg=ErrMsg+"<Br>"+"<li>主题长度不能超过80"
	end if
	if content="" then
		ErrMsg=ErrMsg+"<Br>"+"<li>没有填写内容。"
   		FoundErr=true
	elseif strLength(content)>500 then
   		ErrMsg=ErrMsg+"<Br>"+"<li>发言内容不得大于500"
   		FoundErr=true
	end if
	'客人不允许发，验证用户
	if not founderr and Cint(smallpaper_g)=0 then
		if PassWord<>memberword then
		password=md5(password)
		end if
		set rs=server.createobject("adodb.recordset")
		sql="Select userWealth From [User] Where UserName='"&UserName&"' and UserPassWord='"&PassWord&"'"
		rs.open sql,conn,1,3
		if rs.eof and rs.bof then
   		ErrMsg=ErrMsg+"<Br>"+"<li>您输入的用户名或密码不正确，请重新输入。"
   		FoundErr=true
		else
			if Clng(rs("UserWealth"))<Clng(SmallPaper_m) then
   			ErrMsg=ErrMsg+"<Br>"+"<li>您没有足够的金钱来发布小字报，快到论坛浇点水吧。"
   			FoundErr=true
			else
			rs("UserWealth")=rs("UserWealth")-Cint(SmallPaper_m)
			rs.update	
			end if
		end if
		rs.close
		set rs=nothing
	end if
	if founderr then
		exit sub
	else
		sql="insert into smallpaper (s_boardid,s_username,s_title,s_content) values "&_
		"("&_
		boardid&",'"&_
		username&"','"&_
		title&"','"&_
		content&"')"
		'response.write sql
		conn.execute(sql)
  		if err.number<>0 then
	       		err.clear
			ErrMsg=ErrMsg+"<Br>"+"<li>数据库操作失败，请以后再试"&err.Description
			founderr=true
  	       		exit sub
		else
			call success()
    		end if
	end if
end sub
sub success()
	response.write "<meta http-equiv=refresh content=""4;URL=list.asp?boardid="&boardid&""">"

	response.write "<br><table cellpadding=0 cellspacing=0 border=0 width="&tablewidth&" bgcolor="&tablebackcolor&" align=center>"&_
		"<tr><td><table cellpadding=3 cellspacing=1 border=0 width=""100%"">"&_
		"<tr align=center><td width=""100%"" bgcolor="&tabletitlecolor&"><b><FONT COLOR="&TableFontcolor&">状态：您发布小字报成功</font></b></td>"&_
		"</tr><tr><td width=""100%"" bgcolor="&tablebodycolor&">"&_
		"<FONT COLOR="&TableContentcolor&">本页面将在3秒后自动返回您所发表的版面，<b>您可以选择以下操作：</b><br><ul>"&_
		"<li><a href=""index.asp""><font color="""&TableContentcolor&""">返回首页</font></a></li>"&_
		"<li><a href=""list.asp?boardid="&boardid&"""><font color="""&TableContentcolor&""">"&boardtype&"</font></a></li>"&_
		"</ul></td></tr></table></td></tr></table>"
end sub
%>
<!--#include file="footer.asp"-->