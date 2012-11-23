<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!--#include file="inc/char.asp"-->
<!--#include file="inc/theme.asp"-->
<!--#include file="chkuser.asp"-->
<%
	stats="帖子管理"
	dim rootid
	dim id
	dim Lasttopic,Lastpost
	dim lastrootid,lastpostuser
	dim ip,url
	dim title,content
	ip=Request.ServerVariables("REMOTE_ADDR")
	if founduser=false then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>请登陆后进行操作。"
	end if
	if request("boardid")="" then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>请指定论坛版面。"
	elseif not isInteger(request("boardid")) then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>非法的版面参数。"
	else
		boardid=request("boardid")
		if chkboardmaster(boardid)=false then
			founderr=true
			Errmsg=Errmsg+"<br>"+"<li>您不是该版面斑竹或者系统管理员。"
		end if
	end if
	if request("id")="" then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>请指定相关贴子。"
	elseif not isInteger(request("id")) then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>非法的贴子参数。"
	else
		id=request("id")
	end if
	if request("rootid")="" then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>请指定相关贴子。"
	elseif not isInteger(request("rootid")) then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>非法的贴子参数。"
	else
		rootid=request("rootid")
	end if

	dim doWealth,douserEP,douserCP
	dim doWealthMsg,douserEPMsg,douserCPMsg,allMsg
	call nav()
	call headline(2)
	if founderr=true then
		call Error()
	else
	set rs=server.createobject("adodb.recordset")
	select case request("action")
	case "lock"
		call lock()
	case "unlock"
		call unlock()
	case "delet"
		call delete()
	case "move"
		call Tmove()
	case "copy"
		call copy()
	case "istop"
		call istop()
	case "notop"
		call notop()
	case "dele"
		call dele()
	case "isbest"
		call isbest()
	case "nobest"
		call nobest()
	case "award"
		call award()
	case "punish"
		call punish()
	case else
		call main()
	end select
	if founderr=true then
		call error()
	end if
	set rs=nothing
	call endline()
	
	sub main()
	dim doWealth,douserEP,douserCP
	dim seldisable,reaction
	select case request("action")
	case "锁定"
	doWealth=0
	douserEP=0
	douserCP=0
	seldisable=""
	reaction="lock"
	case "解锁"
	doWealth=0
	douserEP=0
	douserCP=0
	seldisable=""
	reaction="unlock"
	case "删除主题"
	doWealth=-wealthDel
	douserEP=-epDel
	douserCP=-cpDel
	seldisable=""
	reaction="delet"
	case "删除跟帖"
	doWealth=-wealthDel
	douserEP=-epDel
	douserCP=-cpDel
	seldisable=""
	reaction="dele"
	case "精华"
	doWealth=BestWealth
	douserEP=BestUserEP
	douserCP=BestUserCP
	seldisable=""
	reaction="isbest"
	case "解除精华"
	doWealth=-BestWealth
	douserEP=-BestUserEP
	douserCP=-BestUserCP
	seldisable=""
	reaction="nobest"
	case "复制"
	doWealth=0
	douserEP=0
	douserCP=0
	seldisable="disabled"
	reaction="copy"
	case "固顶"
	doWealth=0
	douserEP=0
	douserCP=0
	seldisable=""
	reaction="istop"
	case "解固"
	doWealth=0
	douserEP=0
	douserCP=0
	seldisable=""
	reaction="notop"
	case "移动"
	doWealth=0
	douserEP=0
	douserCP=0
	seldisable="disabled"
	reaction="move"
	case "奖励"
	doWealth=5
	douserEP=1
	douserCP=2
	seldisable=""
	reaction="award"
	case "惩罚"
	doWealth=-5
	douserEP=-1
	douserCP=-2
	seldisable=""
	reaction="punish"
	case else
		Errmsg=Errmsg+"<br><li>请指定相关参数！"
		founderr=true
		exit sub
	end select

%>
<FORM METHOD=POST ACTION="admin_postings.asp?action=<%=reaction%>">
<table width="70%" border="0" cellspacing="1" cellpadding="3" align="center" bgcolor="<%=TableBackColor%>">
  <tr> 
    <td bgcolor="<%=TabletitleColor%>" height=24><b>
      <font color="<%=TableFontColor%>">论坛帖子管理中心－－您要进行的操作是<%=request("action")%></font></b></td>
  </tr>   
  <tr> 
    <td bgcolor="<%=TablebodyColor%>" height=24><b>
      <font color="<%=TableContentColor%>">操作理由</font></b>：  
	  <select name="title" size=1>
<option value="">自定义</option>
<option value="灌水">灌水</option>
<option value="广告">广告</option>
<option value="奖励">奖励</option>
<option value="好文章">好文章</option>
<option value="内容不符">内容不符</option>
<option value="重复发贴">重复发帖</option>
	  </select>
	  <input type="text" name="content" size=60>  *</td>
  </tr>   
<input type=hidden value="<%=id%>" name="id">
<input type=hidden value="<%=rootid%>" name="rootid">
<input type=hidden value="<%=boardid%>" name="boardid">
  <tr> 
    <td bgcolor="<%=TabletitleColor%>" height=24>
      <font color="<%=TableFontColor%>">请慎重使用版主的管理职能，版主所有操作将被记录&nbsp;<input type="submit" name=submit value="确认操作"></font></td>
  </tr>   
</table>
</FORM>
<%
	end sub

	sub award()
		dim topic,username
		set rs=conn.execute("select topic,username from bbs1 where announceid="&id)
		if rs.eof and rs.bof then
			Errmsg=Errmsg+"<br><li>没有找到相关帖子！"
			founderr=true
			exit sub
		else
			topic=rs(0)
			username=rs(1)
			if topic="" then
			topic="本帖子为回复帖子"
			end if
		end if
		rs.close
		title=request.form("title")
		content=request.form("content")
		content="原因：" & title & content
		if request.form("title")="" and request.form("content")="" then
		Errmsg=Errmsg+"<br><li>请写明操作原因。"
		founderr=true
		exit sub
		end if
		sql="insert into log (l_announceid,l_boardid,l_touser,l_username,l_content,l_ip) values ("&id&","&boardid&",'"&username&"','"&membername&"','奖励用户《"&topic&"》，"&content& "，"&allmsg&"','"&ip&"')"
		conn.execute(sql)
		if allmsg<>"" then
		conn.execute("update [user] set userWealth=userWealth+"&doWealth&",userCP=userCP+"&douserCP&",userEP=userEP+"&douserEP&" where username='"&username&"'")
		end if
		call success()
	end sub
	sub punish()
		dim topic,username
		set rs=conn.execute("select topic,username from bbs1 where announceid="&id)
		if rs.eof and rs.bof then
			Errmsg=Errmsg+"<br><li>没有找到相关帖子！"
			founderr=true
			exit sub
		else
			topic=rs(0)
			username=rs(1)
			if topic="" then
			topic="本帖子为回复帖子"
			end if
		end if
		rs.close
		title=request.form("title")
		content=request.form("content")
		content="原因：" & title & content
		if request.form("title")="" and request.form("content")="" then
		Errmsg=Errmsg+"<br><li>请写明操作原因。"
		founderr=true
		exit sub
		end if
		sql="insert into log (l_announceid,l_boardid,l_touser,l_username,l_content,l_ip) values ("&id&","&boardid&",'"&username&"','"&membername&"','惩罚用户《"&topic&"》，"&content& "，"&allmsg&"','"&ip&"')"
		conn.execute(sql)
		if allmsg<>"" then
		conn.execute("update [user] set userWealth=userWealth+"&doWealth&",userCP=userCP+"&douserCP&",userEP=userEP+"&douserEP&" where username='"&username&"'")
		end if
		call success()
	end sub

	sub lock()
		dim topic,username
		set rs=conn.execute("select topic,username from bbs1 where announceid="&id)
		if rs.eof and rs.bof then
			Errmsg=Errmsg+"<br><li>没有找到相关帖子！"
			founderr=true
			exit sub
		else
			topic=rs(0)
			username=rs(1)
			if topic="" then
			topic="本帖子为回复帖子"
			end if
		end if
		rs.close
		title=request.form("title")
		content=request.form("content")
		content="原因：" & title & content
		if request.form("title")="" and request.form("content")="" then
		Errmsg=Errmsg+"<br><li>请写明操作原因。"
		founderr=true
		exit sub
		end if
		sql="update bbs1 set locktopic=1 where boardid="&boardid&" and rootid="&cstr(rootid)
		conn.Execute(sql)
		sql="insert into log (l_announceid,l_boardid,l_touser,l_username,l_content,l_ip) values ("&id&","&boardid&",'"&username&"','"&membername&"','锁定帖子《"&topic&"》，"&content& "，"&allmsg&"','"&ip&"')"
		conn.execute(sql)
		if allmsg<>"" then
		conn.execute("update [user] set userWealth=userWealth+"&doWealth&",userCP=userCP+"&douserCP&",userEP=userEP+"&douserEP&" where username='"&username&"'")
		end if
		call success()
	end sub

	sub unlock()
		dim topic,username
		set rs=conn.execute("select topic,username from bbs1 where announceid="&id)
		if rs.eof and rs.bof then
			Errmsg=Errmsg+"<br><li>没有找到相关帖子！"
			founderr=true
			exit sub
		else
			topic=rs(0)
			username=rs(1)
			if topic="" then
			topic="本帖子为回复帖子"
			end if
		end if
		rs.close
		title=request.form("title")
		content=request.form("content")
		content="原因：" & title & content
		if request.form("title")="" and request.form("content")="" then
		Errmsg=Errmsg+"<br><li>请写明操作原因。"
		founderr=true
		exit sub
		end if
		sql="update bbs1 set locktopic=0 where boardid="&boardid&" and rootid="&cstr(rootid)
		conn.Execute(sql)

		sql="insert into log (l_announceid,l_boardid,l_touser,l_username,l_content,l_ip) values ("&id&","&boardid&",'"&username&"','"&membername&"','解除锁定《"&topic&"》，"&content& "，"&allmsg&"','"&ip&"')"
		conn.execute(sql)
		if allmsg<>"" then
		conn.execute("update [user] set userWealth=userWealth+"&doWealth&",userCP=userCP+"&douserCP&",userEP=userEP+"&douserEP&" where username='"&username&"'")
		end if
		conn.execute(sql)
		call success()
	end sub

	sub istop()
		dim topic,username
		set rs=conn.execute("select topic,username from bbs1 where announceid="&id)
		if rs.eof and rs.bof then
			Errmsg=Errmsg+"<br><li>没有找到相关帖子！"
			founderr=true
			exit sub
		else
			topic=rs(0)
			username=rs(1)
			if topic="" then
			topic="本帖子为回复帖子"
			end if
		end if
		rs.close
		title=request.form("title")
		content=request.form("content")
		content="原因：" & title & content
		if request.form("title")="" and request.form("content")="" then
		Errmsg=Errmsg+"<br><li>请写明操作原因。"
		founderr=true
		exit sub
		end if
	
		sql="update bbs1 set istop=1 where boardid="&boardid&" and rootid="&cstr(rootid)
		conn.Execute(sql)

		sql="insert into log (l_announceid,l_boardid,l_touser,l_username,l_content,l_ip) values ("&id&","&boardid&",'"&username&"','"&membername&"','固顶帖子《"&topic&"》，"&content& "，"&allmsg&"','"&ip&"')"
		conn.execute(sql)
		if allmsg<>"" then
		conn.execute("update [user] set userWealth=userWealth+"&doWealth&",userCP=userCP+"&douserCP&",userEP=userEP+"&douserEP&" where username='"&username&"'")
		end if
		call success()
	end sub

	sub notop()
		dim topic,username
		set rs=conn.execute("select topic,username from bbs1 where announceid="&id)
		if rs.eof and rs.bof then
			Errmsg=Errmsg+"<br><li>没有找到相关帖子！"
			founderr=true
			exit sub
		else
			topic=rs(0)
			username=rs(1)
			if topic="" then
			topic="本帖子为回复帖子"
			end if
		end if
		rs.close
		title=request.form("title")
		content=request.form("content")
		content="原因：" & title & content
		if request.form("title")="" and request.form("content")="" then
		Errmsg=Errmsg+"<br><li>请写明操作原因。"
		founderr=true
		exit sub
		end if
		sql="update bbs1 set istop=0 where boardid="&boardid&" and rootid="&cstr(rootid)
		conn.Execute(sql)

		sql="insert into log (l_announceid,l_boardid,l_touser,l_username,l_content,l_ip) values ("&id&","&boardid&",'"&username&"','"&membername&"','解除固顶《"&topic&"》，"&content& "，"&allmsg&"','"&ip&"')"
		conn.execute(sql)
		if allmsg<>"" then
		conn.execute("update [user] set userWealth=userWealth+"&doWealth&",userCP=userCP+"&douserCP&",userEP=userEP+"&douserEP&" where username='"&username&"'")
		end if
		call success()
	end sub

	sub isbest()
		dim topic,username
		set rs=conn.execute("select topic,username from bbs1 where announceid="&id)
		if rs.eof and rs.bof then
			Errmsg=Errmsg+"<br><li>没有找到相关帖子！"
			founderr=true
			exit sub
		else
			topic=rs(0)
			username=rs(1)
			if topic="" then
			topic="本帖子为回复帖子"
			end if
		end if
		rs.close
		title=request.form("title")
		content=request.form("content")
		content="原因：" & title & content
		if request.form("title")="" and request.form("content")="" then
		Errmsg=Errmsg+"<br><li>请写明操作原因。"
		founderr=true
		exit sub
		end if
		sql="update bbs1 set isbest=1 where boardid="&boardid&" and announceid="&cstr(id)
		conn.Execute(sql)

		sql="insert into log (l_announceid,l_boardid,l_touser,l_username,l_content,l_ip) values ("&id&","&boardid&",'"&username&"','"&membername&"','加入精华《"&topic&"》，"&content& "，"&allmsg&"','"&ip&"')"
		conn.execute(sql)
		conn.execute("update [user] set userWealth=userWealth+"&doWealth&",userCP=userCP+"&douserCP&",userEP=userEP+"&douserEP&",userIsBest=userisBest+1 where username='"&username&"'")
		call success()
	end sub

	sub nobest()
		dim topic,username
		set rs=conn.execute("select topic,username from bbs1 where announceid="&id)
		if rs.eof and rs.bof then
			Errmsg=Errmsg+"<br><li>没有找到相关帖子！"
			founderr=true
			exit sub
		else
			topic=rs(0)
			username=rs(1)
			if topic="" then
			topic="本帖子为回复帖子"
			end if
		end if
		rs.close

		title=request.form("title")
		content=request.form("content")
		content="原因：" & title & content
		if request.form("title")="" and request.form("content")="" then
		Errmsg=Errmsg+"<br><li>请写明操作原因。"
		founderr=true
		exit sub
		end if

		sql="update bbs1 set isbest=0 where boardid="&boardid&" and announceid="&cstr(id)
		conn.Execute(sql)

		sql="insert into log (l_announceid,l_boardid,l_touser,l_username,l_content,l_ip) values ("&id&","&boardid&",'"&username&"','"&membername&"','解除精华《"&topic&"》，"&content& "，"&allmsg&"','"&ip&"')"
		conn.execute(sql)

		conn.execute("update [user] set userWealth=userWealth+"&doWealth&",userCP=userCP+"&douserCP&",userEP=userEP+"&douserEP&",userIsBest=userisBest-1 where username='"&username&"'")
		call success()
	end sub

	sub dele()
		dim topic,username
		set rs=conn.execute("select topic,username from bbs1 where announceid="&id)
		if rs.eof and rs.bof then
			Errmsg=Errmsg+"<br><li>没有找到相关帖子！"
			founderr=true
			exit sub
		else
			topic=rs(0)
			username=rs(1)
			if topic="" then
			topic="本帖子为回复帖子"
			end if
		end if
		rs.close
		title=request.form("title")
		content=request.form("content")
		content="原因：" & title & content
		if request.form("title")="" and request.form("content")="" then
		Errmsg=Errmsg+"<br><li>请写明操作原因。"
		founderr=true
		exit sub
		end if

		dim LastPostime
		sql="update bbs1 set locktopic=2 where boardid="&boardid&" and ParentID<>0 and announceid="&cstr(id)
		conn.Execute(sql)
		sql="select Max(announceid) from bbs1 where not locktopic=2 and rootid="&rootid&" and boardid="&boardid
		set rs=conn.Execute(sql)
		LastPostime=rs(0)
		rs.close
	
		dim todaynum
		sql="select count(*) from bbs1 where announceid="&id&" and dateandtime>#"&date()&"#"
		set rs=conn.execute(sql)
		todaynum=rs(0)
		rs.close
	
		call LastCount(boardid)
		call BoardNumSub(boardid,0,1,todayNum)

		call AllboardNumSub(todayNum,1,0)

		sql="update bbs1 set times="&LastPostime&" where rootid="&rootid&" and boardid="&boardid
		conn.execute(sql)
		sql="update bbs1 set child=child-1 where announceid="&rootid&" and boardid="&boardid
		conn.execute(sql)
	
		sql="insert into log (l_announceid,l_boardid,l_touser,l_username,l_content,l_ip) values ("&id&","&boardid&",'"&username&"','"&membername&"','删除帖子《"&topic&"》，"&content& "，"&allmsg&"','"&ip&"')"
		conn.execute(sql)
		if allmsg<>"" then
		conn.execute("update [user] set userWealth=userWealth+"&doWealth&",userCP=userCP+"&douserCP&",userEP=userEP+"&douserEP&",article=article-1,userDel=userDel-1 where username='"&username&"'")
		end if
		call success()
	end sub

	sub delete()
		dim topic,username
		set rs=conn.execute("select topic,username from bbs1 where announceid="&id)
		if rs.eof and rs.bof then
			Errmsg=Errmsg+"<br><li>没有找到相关帖子！"
			founderr=true
			exit sub
		else
			topic=rs(0)
			username=rs(1)
			if topic="" then
			topic="本帖子为回复帖子"
			end if
		end if
		rs.close
		title=request.form("title")
		content=request.form("content")
		content="原因：" & title & content
		if request.form("title")="" and request.form("content")="" then
		Errmsg=Errmsg+"<br><li>请写明操作原因。"
		founderr=true
		exit sub
		end if
	
		dim todaynum,postnum
		sql="select count(*) from bbs1 where rootid="&rootid
		set rs=conn.execute(sql)
		postNum=rs(0)
		sql="select count(*) from bbs1 where rootid="&rootid&" and dateandtime>#"&date()&"#"
		set rs=conn.execute(sql)
		todayNum=rs(0)
		
		if allmsg<>"" then
		set rs=server.createobject("adodb.recordset")
		sql="select username from bbs1 where rootid="&rootid
		rs.open sql,conn,0,1
		do while not rs.eof
		conn.execute("update [user] set userWealth=userWealth+"&doWealth&",userCP=userCP+"&douserCP&",userEP=userEP+"&douserEP&",article=article-1,userDel=userDel-1 where username='"&username&"'")
		rs.movenext
		loop
		set rs=nothing
		end if
	
		sql="update bbs1 set locktopic=2 where rootid="&cstr(rootid)
		conn.Execute(sql)
	
		call LastCount(boardid)
		call BoardNumSub(boardid,1,postNum,todayNum)
		call AllboardNumSub(todayNum,postNum,1)

		sql="insert into log (l_announceid,l_boardid,l_touser,l_username,l_content,l_ip) values ("&id&","&boardid&",'"&username&"','"&membername&"','删除主题《"&topic&"》，"&content& "，"&allmsg&"','"&ip&"')"
		conn.execute(sql)
		call success()
	end sub

	sub Tmove()
		dim topic,username
		set rs=conn.execute("select topic,username from bbs1 where announceid="&id)
		if rs.eof and rs.bof then
			Errmsg=Errmsg+"<br><li>没有找到相关帖子！"
			founderr=true
			exit sub
		else
			topic=rs(0)
			username=rs(1)
			if topic="" then
			topic="本帖子为回复帖子"
			end if
		end if
		rs.close
		title=request.form("title")
		content=request.form("content")
		content="原因：" & title & content
		if request.form("title")="" and request.form("content")="" then
		Errmsg=Errmsg+"<br><li>请写明操作原因。"
		founderr=true
		exit sub
		end if

	dim newboardid
	if request("checked")="yes" then
		if request("boardid")=request("newboardid") then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>不能在相同版面内进行转移操作。"
		elseif not isInteger(request("newboardid")) then
			founderr=true
			Errmsg=Errmsg+"<br>"+"<li>非法的版面参数。"
			exit sub
		else
			newboardid=request("newboardid")
			sql="select boardid,announceid,Parentid from bbs1 where announceid="&id&" and boardid="&cstr(boardid)
			rs.open sql,conn,0,1
			if rs.eof and rs.bof then
				founderr=true
				Errmsg=Errmsg+"<br>"+"<li>您选择的贴子并不存在。"
			else
				if rs("Parentid")<>0 then
				founderr=true
				Errmsg=Errmsg+"<br>"+"<li>您必须选择一个主题，而不是贴子。"
				end if
			end if
			rs.close
		end if
		if founderr=false then
			if request("leavemessage")="yes" then
				'ON ERROR RESUME NEXT

			elseif request("leavemessage")="no" then
				dim newtopic
				sql="select topic from bbs1 where announceid="&rootid
				rs.open sql,conn,0,1
				newtopic=rs("topic") & "-->" & membername & "转移"
				rs.close
				sql="update bbs1 set topic='"&newtopic&"' where announceid="&rootid
				conn.execute(sql)
				sql="update bbs1 set boardid="&newboardid&" where rootid="&rootid
				conn.Execute(sql)
				
				dim postNum,todayNum
				sql="select count(*) from bbs1 where rootid="&rootid
				rs.open sql,conn,0,1
				postNum=rs(0)
				rs.close
				sql="select count(*) from bbs1 where rootid="&rootid&" and dateandtime>=#"&date()&"#"
				rs.open sql,conn,0,1
				todayNum=rs(0)
				rs.close
				
'更新论坛贴子数据

	call LastCount(boardid)
	call BoardNumSub(boardid,1,postNum,todayNum)
	call LastCount(newboardid)
	call BoardNumAdd(newboardid,1,postNum,todayNum)

'更新论坛数据结束


	sql="insert into log (l_announceid,l_boardid,l_touser,l_username,l_content,l_ip) values ("&id&","&boardid&",'"&username&"','"&membername&"','转移主题《"&topic&"》，"&content& "，"&allmsg&"','"&ip&"')"
	conn.execute(sql)
				call success()
			else
				founderr=true
				Errmsg=Errmsg+"<br>"+"<li>请选择相应操作。"
			end if
		end if
	else
%>
            <table cellpadding=0 cellspacing=0 border=0 width=95% bgcolor=<%=aTablebackcolor%> align=center>
                <tr>
                    <td>
                    <table cellpadding=6 cellspacing=1 border=0 width=100%>
                        <tr>
                        <td bgcolor=<%=aTabletitlecolor%> valign=middle align=center colspan=2>
                        <form action="admin_postings.asp" method="post">
                        <input type=hidden name="action" value="move">
                        <input type=hidden name="checked" value="yes">
                        <input type=hidden name="boardid" value="<%=request("boardid")%>">
                        <input type=hidden name="rootid" value="<%=request("rootid")%>">
                        <input type=hidden name="id" value="<%=request("id")%>">
<input type=hidden value="<%=request.form("title")%>" name="title">
<input type=hidden value="<%=request.form("content")%>" name="content">
<input type=hidden value="<%=doWealth%>" name="doWealth">
<input type=hidden value="<%=dousercp%>" name="dousercp">
<input type=hidden value="<%=douserep%>" name="douserep">
                        <b>移动主题</b></td></tr>

                                    <tr>
                                    <td bgcolor=<%=Tablebodycolor%> valign=middle>
                                    <b>移动选项</td>
                                    <td bgcolor=<%=Tablebodycolor%> valign=middle>
                                    <!--<input name="leavemessage" type="radio" value="yes"> 移动并保留一个已经锁定的主题在原论坛<br>--><input name="leavemessage" type="radio" value="no" checked> 移动并将此主题从原论坛中删除
                                    </td>
                                    </tr>

                            <tr>
                        <td bgcolor=<%=Tablebodycolor%> valign=top><b>移动到：</b></td>
                        <td bgcolor=<%=Tablebodycolor%> valign=top>
<%
   sql="select boardid,boardtype from board"
   rs.open sql,conn,1,1
%>
<select name="newboardid" size="1">
<option value="">选择一个论坛</option>
<%
	do while not rs.eof
        response.write "<option value='"+CStr(rs("BoardID"))+"'>"+rs("Boardtype")+"</option>"+chr(13)+chr(10)
	rs.movenext
	loop
	rs.close
%>        
          </select>
			</td>
                        </tr>
                    <tr>
                <td bgcolor=<%=aTabletitlecolor%> valign=middle colspan=2 align=center><input type=submit name="submit" value="提 交"></td></tr></form></table></td></tr></table>
            </table>
            </td></tr>
            </table>
<%
	end if
	end sub

	sub copy()
		dim topic,username
		set rs=conn.execute("select topic,username from bbs1 where announceid="&id)
		if rs.eof and rs.bof then
			Errmsg=Errmsg+"<br><li>没有找到相关帖子！"
			founderr=true
			exit sub
		else
			topic=rs(0)
			username=rs(1)
			if topic="" then
			topic="本帖子为回复帖子"
			end if
		end if
		rs.close
		title=request.form("title")
		content=request.form("content")
		content="原因：" & title & content
		if request.form("title")="" and request.form("content")="" then
		Errmsg=Errmsg+"<br><li>请写明操作原因。"
		founderr=true
		exit sub
		end if
	
		if request("checked")="yes" then
		dim newboardid
		dim todaynum,postnum
		sql="select count(*) from bbs1 where rootid="&rootid
		set rs=conn.execute(sql)
		postNum=rs(0)
		sql="select count(*) from bbs1 where rootid="&rootid&" and dateandtime>#"&date()&"#"
		set rs=conn.execute(sql)
		todayNum=rs(0)
			if request("boardid")=request("newboardid") then
			founderr=true
			Errmsg=Errmsg+"<br>"+"<li>不能在相同版面内进行转移操作。"
			elseif not isInteger(request("newboardid")) then
				founderr=true
				Errmsg=Errmsg+"<br>"+"<li>非法的版面参数。"
				exit sub
			else
				newboardid=request("newboardid")
				rs.close
				sql="select boardid,announceid,Parentid from bbs1 where announceid="&id&" and boardid="&cstr(boardid)
				rs.open sql,conn,1,1
				if rs.eof and rs.bof then
					founderr=true
					Errmsg=Errmsg+"<br>"+"<li>您选择的贴子并不存在。"
				end if
				rs.close
			end if
			if founderr=false then
				'ON ERROR RESUME NEXT
				dim newtopic,body,dateandtime,length,ip,Expression
				dim announceid
				sql="select * from bbs1 where announceid="&id
				rs.open sql,conn,1,1
				newtopic=rs("topic") & "-->" & membername & "添加"
				username=rs("username")
				body=rs("body")
				DateAndTime=rs("DateAndTime")
				length=rs("length")
				ip=rs("ip")
				Expression=rs("Expression")
				rs.close
				sql="select * from bbs1"
				rs.open sql,conn,1,3
					rs.AddNew
				rs("BoardID")=newboardID
					rs("ParentID")=0
					rs("Child")=0
					rs("UserName")=UserName
					rs("Topic")=newTopic
					rs("Body")=Body
					rs("DateAndTime")=DateAndTime
					rs("hits")=0
					rs("length")=length
					rs("rootID")=0
					rs("layer")=1
					rs("orders")=0
					rs("ip")=ip
					rs("Expression")=Expression
					rs("locktopic")=0
					rs("signflag")=0
					rs("emailflag")=0
					rs("times")=0
					rs("isvote")=0
					rs("istop")=0
					rs("isbest")=0
					rs("LastPost")="$$$$"
					rs.Update
				rs.MoveLast
					announceid=rs("AnnounceID")
					rs("RootID")= announceid
					rs("Times")= announceid
					rs.Update
					rs.close
	
	'更新论坛贴子数据
	
		'LastCount(boardid)
		LastCount(Newboardid)
		call BoardNumAdd(newboardid,1,postNum,todayNum)
		call AllboardNumAdd(todayNum,postNum,1)
	
	
		sql="insert into log (l_announceid,l_boardid,l_touser,l_username,l_content,l_ip) values ("&id&","&boardid&",'"&username&"','"&membername&"','拷贝帖子《"&topic&"》，"&content& "，"&allmsg&"','"&ip&"')"
		conn.execute(sql)
	'更新论坛数据结束
				call success()
			end if
		else
%>
            <table cellpadding=0 cellspacing=0 border=0 width=95% bgcolor=<%=aTablebackcolor%> align=center>
                <tr>
                    <td>
                    <table cellpadding=6 cellspacing=1 border=0 width=100%>
                        <tr>
                        <td bgcolor=<%=aTabletitlecolor%> valign=middle align=center colspan=2>
                        <form action="admin_postings.asp" method="post">
                        <input type=hidden name="action" value="copy">
                        <input type=hidden name="checked" value="yes">
                        <input type=hidden name="boardid" value="<%=request("boardid")%>">
                        <input type=hidden name="rootid" value="<%=request("rootid")%>">
                        <input type=hidden name="id" value="<%=request("id")%>">
<input type=hidden value="<%=request.form("title")%>" name="title">
<input type=hidden value="<%=request.form("content")%>" name="content">
<input type=hidden value="<%=doWealth%>" name="doWealth">
<input type=hidden value="<%=dousercp%>" name="dousercp">
<input type=hidden value="<%=douserep%>" name="douserep">
                        <b>复制帖子</b></td></tr>

                                    <tr>
                                    <td bgcolor=<%=Tablebodycolor%> valign=middle>
                                    <b>操作说明</td>
                                    <td bgcolor=<%=Tablebodycolor%> valign=middle>
帖子将复制到别的论坛，成为新的帖子，并保留在原来论坛
                                    </td>
                                    </tr>
                            <tr>
                        <td bgcolor=<%=Tablebodycolor%> valign=top><b>移动到：</b></td>
                        <td bgcolor=<%=Tablebodycolor%> valign=top>
<%
   sql="select boardid,boardtype from board"
   rs.open sql,conn,1,1
%>
<select name="newboardid" size="1">
<option value="">选择一个论坛</option>
<%
	do while not rs.eof
        response.write "<option value='"+CStr(rs("BoardID"))+"'>"+rs("Boardtype")+"</option>"+chr(13)+chr(10)
	rs.movenext
	loop
	rs.close
%>        
          </select>
			</td>
                        </tr>
                    <tr>
                <td bgcolor=<%=aTabletitlecolor%> valign=middle colspan=2 align=center><input type=submit name="submit" value="提 交"></td></tr></form></table></td></tr></table>
            </table>
            </td></tr>
            </table>
<%
	end if
	end sub

	sub upTopic()
	if request.Form("checked")="yes" then

	else
%>
            <table cellpadding=0 cellspacing=0 border=0 width=95% bgcolor=<%=Tablebackcolor%> align=center>
                <tr>
                    <td>
                    <table cellpadding=6 cellspacing=1 border=0 width=100%>
                        <tr>
                        <td bgcolor=<%=Tabletitlecolor%> valign=middle align=center colspan=2>
                        <form action="admin_postings.asp" method="post">
                        <input type=hidden name="action" value="upTopic">
                        <input type=hidden name="checked" value="yes">
                        <input type=hidden name="boardid" value="<%=request("boardid")%>">
                        <input type=hidden name="rootid" value="<%=request("rootid")%>">
                        <input type=hidden name="id" value="<%=request("id")%>">
<input type=hidden value="<%=request.form("title")%>" name="title">
<input type=hidden value="<%=request.form("content")%>" name="content">
<input type=hidden value="<%=doWealth%>" name="doWealth">
<input type=hidden value="<%=dousercp%>" name="dousercp">
<input type=hidden value="<%=douserep%>" name="douserep">
                        <b>提升帖子</b></td></tr>

                                    <tr>
                                    <td bgcolor=<%=Tablebodycolor%> valign=middle>
                                    <b>操作说明</td>
                                    <td bgcolor=<%=Tablebodycolor%> valign=middle>
将版面某一主题和某一主题的位置互换，也就是把某一比较靠后的主题和靠前的主题替换，要求输入两个主题的RootID号，主题的RootID号可通过点开主题看浏览器地址栏获得
                                    </td>
                                    </tr>
                            <tr>
                        <td bgcolor=<%=Tablebodycolor%> valign=top><b>请填写Rootid(数字)：</b></td>
                        <td bgcolor=<%=Tablebodycolor%> valign=top>
						靠后主题 <input type="text" name="OldRootid" value="<%=request("rootid")%>">&nbsp;&nbsp;
						靠前主题 <input type="text" name="NewRootid">
						</td>
                        </tr>
                    <tr>
                <td bgcolor=<%=aTabletitlecolor%> valign=middle colspan=2 align=center><input type=submit name="submit" value="提 交"></td></tr></form></table></td></tr></table>
            </table>
            </td></tr>
            </table>
<%
	end if
	end sub

sub success()
%>
    <table cellpadding=0 cellspacing=0 border=0 width=95% bgcolor=<%=aTablebackcolor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
    <tr align="center"> 
      <td width="100%" bgcolor=<%=aTabletitlecolor%>>成功：帖子操作</td>
    </tr>
    <tr> 
      <td width="100%" bgcolor=<%=Tablebodycolor%>><li>帖子操作成功。<li>您的操作信息已经记录在案。<br>
      </td>
    </tr>
    <tr align="center"> 
      <td width="100%" bgcolor=<%=aTabletitlecolor%>>
<a href="list.asp?boardid=<%=request("boardid")%>"> << 返回论坛</a>
      </td>
    </tr>  
    </table>   </td></tr></table>
<%
end sub
	

	'更新指定论坛信息
	function LastCount(boardid)
		dim LastTopic,body,LastRootid,LastPostTime,LastPostUser
		dim LastPost,uploadpic_n
		set rs=conn.execute("select top 1 topic,body,rootid,dateandtime,username from bbs1 where not locktopic=2 and boardid="&boardid&" and not locktopic=2 order by announceid desc")
		if not(rs.eof and rs.bof) then
			Lasttopic=rs(0)
			body=rs(1)
			LastRootid=rs(2)
			LastPostTime=rs(3)
			LastPostUser=rs(4)
		else
			LastTopic="无"
			LastRootid=0
			LastPostTime=now()
			LastPostUser="无"
		end if
		if Lasttopic="" or isnull(Lasttopic) then LastTopic=left(body,20)
		rs.close
		set rs=nothing
		LastPost=LastPostUser & "$" & LastRootid & "$" & LastPostTime & "$" & replace(left(LastTopic,20),"$","") & "$" & UpLoadPic_n
		sql="update board set LastPost='"&LastPost&"' where boardid="&boardid
		conn.execute(sql)
	end function
	
	'版面发帖数增加
	sub BoardNumAdd(boardid,topicNum,postNum,todayNum)
		sql="update board set lastbbsnum=lastbbsnum+"&postNum&",lasttopicNum=lasttopicNum+"&topicNum&",todayNum=todayNum+"&todayNum&" where boardid="&boardid
		conn.execute(sql)
	end sub
	
	'版面发帖数减少
	sub BoardNumSub(boardid,topicNum,postNum,todayNum)
		sql="update board set lastbbsnum=lastbbsnum-"&postNum&",lasttopicNum=lasttopicNum-"&topicNum&",todayNum=todayNum-"&todayNum&" where boardid="&boardid
		'response.write sql
		'response.end
		conn.execute(sql)
	end sub
	
	
	'所有论坛发帖数增加
	function AllboardNumAdd(todayNum,postNum,topicNum)
		sql="update config set TodayNum=todayNum+"&todaynum&",BbsNum=bbsNum+"&postNum&",TopicNum=topicNum+"&TopicNum
		conn.execute(sql)
	end function

	'所有论坛发帖数减少
	function AllboardNumSub(todayNum,postNum,topicNum)
		sql="update config set TodayNum=todayNum-"&todaynum&",BbsNum=bbsNum-"&postNum&",TopicNum=topicNum-"&TopicNum
		conn.execute(sql)
	end function

end if
%>
<!--#include file="footer.asp"-->