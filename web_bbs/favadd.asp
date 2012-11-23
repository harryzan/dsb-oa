<!-- #include file="conn.asp" -->
<!-- #include file="inc/char.asp" -->
<!-- #include file="inc/const.asp" -->
<!-- #include file="chkuser.asp" -->
<!--#include file="inc/theme.asp"-->
<%
	rem ----------------------
	rem ------主程序开始------
	rem ----------------------
	dim announceid
	dim rootid
	dim topic
	dim url
	stats="论坛收藏夹"
	if membername="" then
		Errmsg=Errmsg+"<br>"+"<li>您还没有<a href=reg.asp>登录</a>。"
		Founderr=true
	end if
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
	if request("RootID")="" then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>请指定相关贴子。"
	elseif not isInteger(request("RootID")) then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>非法的贴子参数。"
	else
		RootID=request("RootID")
	end if
	call nav()
	call headline(1)
	if founderr then
		call Error()
	else
		url="dispbbs.asp?"
		url=url+"boardid="+boardid+"&rootid="+rootid+"&id="+announceid
		call chkurl()
		if founderr=true then
			call Error()
		else
			call favadd()
			if founderr=true then
				call Error()
			else
				call success()
			end if
		end if
	end if
	call endline()

	sub chkurl()
		sql="select topic,rootid,announceid,boardid from bbs1 where announceid="&cstr(announceid)&" and rootid="&cstr(rootid)&" and boardid="&cstr(boardid)
		set rs=server.createobject("adodb.recordset")
		rs.open sql,conn,1,1
		if rs.eof and rs.bof then
			Errmsg=Errmsg+"<br>"+"<li>没有相关贴子。"
			Founderr=true
		else
			topic=rs("topic")
		end if
		rs.close
		set rs=nothing
	end sub
	sub favadd()
		sql="select * from bookmark where url='"&trim(url)&"'"
		set rs=server.createobject("adodb.recordset")
		rs.open sql,conn,1,3
		if not rs.eof and not rs.bof then
			Errmsg=Errmsg+"<br>"+"<li>该贴子已经在收藏夹中。"
			Founderr=true
		else
		rs.addnew
		rs("username")=membername
		rs("topic")=topic
		rs("url")=url
		rs("addtime")=Now()
		rs.update
		end if
		rs.close
		set rs=nothing
	end sub

	sub success()
%>
    <table cellpadding=0 cellspacing=0 border=0 width=<%=TableWidth%> bgcolor=<%=tablebackcolor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
    <tr align="center"> 
      <td width="100%" bgcolor=<%=tabletitlecolor%>><font color="<%=TablefontColor%>">成功：帖子收藏</font></td>
    </tr>
    <tr> 
      <td width="100%" bgcolor=<%=tablebodycolor%>><font color="<%=TableContentColor%>"><b>本帖子已经收入您在论坛的<a href=favlist.asp>收藏夹</a></b><br><br></font>
      </td>
    </tr>
    <tr align="center"> 
      <td width="100%" bgcolor=<%=tabletitlecolor%>>
<a href="javascript:history.go(-1)"> << 返回上一页</a>
      </td>
    </tr>  
    </table>   </td></tr></table>
<%
	end sub

   	rem ----------------------
	rem ------主程序结束------
	rem ----------------------
%>
<!--#include file="footer.asp"-->
