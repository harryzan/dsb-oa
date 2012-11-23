<!--#include file=conn.asp-->
<!-- #include file="inc/char.asp" -->
<!-- #include file="inc/const.asp" -->
<!-- #include file="chkuser.asp" -->
<!--#include file="inc/theme.asp"-->
<%
	dim times
	stats="跳转主题"
	if request("boardid")="" then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>请指定论坛版面。"
	elseif not isInteger(request("boardid")) then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>非法的版面参数。"
	else
		boardid=request("boardid")
	end if
	if request("sid")="" then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>请指定相关贴子。"
	elseif not isInteger(request("sid")) then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>非法的贴子参数。"
	else
		times=request("sid")
	end if
	if founderr then
		call nav()
		call headline(1)
		call error()
	else
		call nav()
		call headline(1)
		call main()
		if founderr then call error()
	end if
	call endline()
	sub main()
	if request("action")="next" then
	set rs=conn.execute("select top 1 Announceid,rootid from bbs1 where times>"&times&" and boardid="&boardid&" order by times")
	if rs.eof and rs.bof then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>没有找到下一篇帖子，请<a href=list.asp?boardid="&boardid&">返回</a>。"
	else
		response.redirect "dispbbs.asp?boardid="&boardid&"&RootID="&rs(1)&"&ID="&rs(0)&""
	end if
	else
	set rs=conn.execute("select top 1 Announceid,rootid from bbs1 where times<"&times&" and boardid="&boardid&" order by times desc")
	if rs.eof and rs.bof then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>没有找到下一篇帖子，请<a href=list.asp?boardid="&boardid&">返回</a>。"
	else
		response.write "<script>location.href='dispbbs.asp?boardid="&boardid&"&RootID="&rs(1)&"&ID="&rs(0)&"'</script>"
	end if
	end if
	end sub
	set rs=nothing
%>
<!-- #include file="footer.asp" -->
