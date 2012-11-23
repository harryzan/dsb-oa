<%
	dim ComeFrom,actCome,statuserid
	statuserid=replace(Request.ServerVariables("REMOTE_HOST"),".","")
	set rs=server.createobject("adodb.recordset")
	if not isInteger(BoardID) then Boardid=0
	if not founduser then
		if session("userid")="" then
		ComeFrom=address(Request.ServerVariables("REMOTE_HOST"))
		actCome=address(Request.ServerVariables("HTTP_X_FORWARDED_FOR"))
		sql="select id from online where id="&statuserid
		rs.open sql,conn,0,1
		if rs.eof and rs.bof then
		sql="insert into online(id,username,userclass,ip,startime,lastimebk,boardid,browser,stats,actforip,ComeFrom,actCome) values "&_
				"("&statuserid&",'客人','客人','"&_
				Request.ServerVariables("REMOTE_HOST")&"',Now(),Now(),"&boardid&",'"&_
				Request.ServerVariables("HTTP_USER_AGENT")&"','论坛首页','"&_
                Request.ServerVariables("HTTP_X_FORWARDED_FOR")&"','"&ComeFrom&"','"&actCome&"')"
		conn.execute(sql)
		else
		sql="update online set lastimebk=Now(),boardid="&boardid&" where id="&statuserid
		conn.execute(sql)
		end if
		rs.close
		else
		sql="select id from online where id="&cstr(session("userid"))
		rs.open sql,conn,1,3
		if rs.eof and rs.bof then
		ComeFrom=address(Request.ServerVariables("REMOTE_HOST"))
		actCome=address(Request.ServerVariables("HTTP_X_FORWARDED_FOR"))
		sql="insert into online(id,username,userclass,ip,startime,lastimebk,boardid,browser,stats,actforip,ComeFrom,actCome) values "&_
				"("&statuserid&",'客人','客人','"&_
				Request.ServerVariables("REMOTE_HOST")&"',Now(),Now(),"&boardid&",'"&_
				Request.ServerVariables("HTTP_USER_AGENT")&"','论坛首页','"&_
                Request.ServerVariables("HTTP_X_FORWARDED_FOR")&"','"&ComeFrom&"','"&actCome&"')"
		conn.execute(sql)
		else
		sql="update online set lastimebk=Now(),boardid="&boardid&" where id="&cstr(session("userid"))
		conn.execute(sql)
		end if
		end if
		session("userid")=statuserid
	else
		sql="select id from online where username='"&membername&"'"
		rs.open sql,conn,1,3
		if rs.eof and rs.bof then
		ComeFrom=address(Request.ServerVariables("REMOTE_HOST"))
		actCome=address(Request.ServerVariables("HTTP_X_FORWARDED_FOR"))
		sql="insert into online(id,username,userclass,ip,startime,lastimebk,boardid,browser,stats,actforip,ComeFrom,actCome) values "&_
				"("&statuserid&",'"&membername&"','"&memberclass&"','"&_
				Request.ServerVariables("REMOTE_HOST")&"',Now(),Now(),"&boardid&",'"&_
				Request.ServerVariables("HTTP_USER_AGENT")&"','论坛首页','"&_
                Request.ServerVariables("HTTP_X_FORWARDED_FOR")&"','"&ComeFrom&"','"&actCome&"')"
		conn.execute(sql)
		else
		sql="update online set lastimebk=Now(),boardid="&boardid&" where username='"&membername&"'"
		'response.write sql
		conn.execute(sql)
		end if
		rs.close
		if session("userid")<>"" then
		Conn.Execute("delete from online where id="&session("userid"))
		session("userid")=""
		end if
	end if
	set rs=nothing


%>