<!--#include file=conn.asp-->
<!-- #include file="inc/char.asp" -->
<!-- #include file="inc/const.asp" -->
<!-- #include file="chkuser.asp" -->
<!--#include file="inc/theme.asp"-->
<%
	dim times
	stats="��ת����"
	if request("boardid")="" then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>��ָ����̳���档"
	elseif not isInteger(request("boardid")) then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>�Ƿ��İ��������"
	else
		boardid=request("boardid")
	end if
	if request("sid")="" then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>��ָ��������ӡ�"
	elseif not isInteger(request("sid")) then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>�Ƿ������Ӳ�����"
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
		Errmsg=Errmsg+"<br>"+"<li>û���ҵ���һƪ���ӣ���<a href=list.asp?boardid="&boardid&">����</a>��"
	else
		response.redirect "dispbbs.asp?boardid="&boardid&"&RootID="&rs(1)&"&ID="&rs(0)&""
	end if
	else
	set rs=conn.execute("select top 1 Announceid,rootid from bbs1 where times<"&times&" and boardid="&boardid&" order by times desc")
	if rs.eof and rs.bof then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>û���ҵ���һƪ���ӣ���<a href=list.asp?boardid="&boardid&">����</a>��"
	else
		response.write "<script>location.href='dispbbs.asp?boardid="&boardid&"&RootID="&rs(1)&"&ID="&rs(0)&"'</script>"
	end if
	end if
	end sub
	set rs=nothing
%>
<!-- #include file="footer.asp" -->
