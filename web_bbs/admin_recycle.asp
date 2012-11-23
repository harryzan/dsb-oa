<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!--#include file="inc/char.asp"-->
<!--#include file="inc/theme.asp"-->
<!--#include file="chkuser.asp"-->
<%
	dim topicid
	stats="帖子管理"
	topicid=request("topicid")
	if request("action")<>"清空回收站" then
		if topicid="" or isnull(topicid) then
		Errmsg=Errmsg+"<li>"+"请选择相关帖子后进行操作。"
		Founderr=true
		end if
	end if
	if not master then
	Errmsg=Errmsg+"<li>"+"您不是系统管理员或者您还没有登陆。"
	Founderr=true
	end if
	call nav()
	call headline(1)
	if founderr=true then
		call error()
	else
		if request("action")="删除" then
			call delete()
		elseif request("action")="还原" then
			call redel()
		elseif request("action")="清空回收站" then
			call Alldel()
		else
		Errmsg=Errmsg+"<li>"+"请指定所需参数。"
		Founderr=true
		end if
		if founderr=true then call error()
	end if
	call endline()
	sub delete()
	conn.execute("delete from bbs1 where Announceid in ("&TopicID&")")

	sql="insert into log (l_username,l_content) values ('"&membername&"','完全删除帖子')"
	conn.execute(sql)
	call success()
	end sub

	sub redel()
	sql="update bbs1 set locktopic=0 where Announceid in ("&TopicID&")"
	conn.execute(sql)

	set rs=conn.execute("select username from bbs1 where Announceid in ("&TopicID&")")
	do while not rs.eof
	sql="update [user] set article=article+1,userWealth=userWealth+"&wealthDel&",userEP=userEP+"&epDel&" where username='"&rs(0)&"'"
	conn.execute(sql)
	rs.movenext
	loop
	set rs=nothing
	sql="insert into log (l_username,l_content) values ('"&membername&"','还原帖子')"
	conn.execute(sql)
	call success()
	end sub

	sub AllDel()
	conn.execute("delete from bbs1 where locktopic=2")

	sql="insert into log (l_username,l_content) values ('"&membername&"','清空回收站')"
	conn.execute(sql)
	call success()
	end sub

sub success()
%>
    <table cellpadding=0 cellspacing=0 border=0 width=<%=tablewidth%> bgcolor=<%=Tablebackcolor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
    <tr align="center"> 
      <td width="100%" bgcolor=<%=Tabletitlecolor%>><font color="<%=TablefontColor%>">成功：帖子操作</font></td>
    </tr>
    <tr> 
      <td width="100%" bgcolor=<%=Tablebodycolor%>><font color="<%=TableContentColor%>"><li>帖子操作成功。<li>您的操作信息已经记录在案。<br></font>
      </td>
    </tr>
    <tr align="center"> 
      <td width="100%" bgcolor=<%=Tabletitlecolor%>>
<a href="recycle.asp"><font color="<%=TablefontColor%>"> << 返回回收站</font></a>
      </td>
    </tr>  
    </table>   </td></tr></table>
<%
end sub
%>
<!--#include file="footer.asp"-->
