<!-- #include file="inc/char_cfrom.asp" -->
<%
function online(boardid)
	dim tmprs
	guests="客人"
	if boardid=0 then
	sql="Select count(id) from online where username<>'"&guests&"'"
	else
	sql="Select count(id) from online where username<>'"&guests&"' and boardid="&boardid
	end if
    	set tmprs=conn.execute(sql) 
    	online=tmprs(0) 
	set tmprs=nothing 
	if isnull(online) then online=0
end function 
function guest(boardid)
	dim tmprs
	guests="客人"
	if boardid=0 then
	sql="Select count(id) from online where username='"&guests&"'"
	else
	sql="Select count(id) from online where username='"&guests&"' and boardid="&boardid
	end if
	set tmprs=conn.execute(sql) 
    	guest=tmprs(0) 
	set tmprs=nothing
	if isnull(guest) then guest=0
end function
function allonline()
	dim tmprs
	tmprs=conn.execute("Select count(id) from online") 
	allonline=tmprs(0) 
	set tmprs=nothing 
	if isnull(allonline) then allonline=0
end function
sub onlineuser(online_u,online_g,boardid)
if boardid>0 and (cint(online_u)=1 or cint(online_g)=1) then
response.write "<tr><td colspan=2 bgcolor="&TableBodyColor&"><table cellpadding=2 cellspacing=1 border=0 width=""100%"" style=""word-break:break-all;"">"
end if
	if cint(online_u)=1 then
	guests="客人"
	dim sip
    	dim acip
	dim j,i
	dim online_face,userip,userfrom,useracfrom,onlineusername
	dim grade18,grade19,grade20
	i=8
	grade18=grade(18)
	grade19=grade(19)
	grade20=grade(20)
	'用户信息
	if boardid=0 then
	sql="select username,startime,lastimebk,ip,stats,userclass,browser,actforip,comefrom,actCome from online where username<>'"&guests&"'"
	else
	sql="select username,startime,lastimebk,ip,stats,userclass,browser,actforip,comefrom,actCome from online where username<>'"&guests&"' and boardid="&boardid
	end if
	set rs=server.createobject("adodb.recordset")
	rs.open sql,conn,0,1
	do while not rs.eof
	if i>7 then 
	response.write "<tr><td width=""14%"">"
	i=1
	else
	response.write "<td width=""14%"">"
	end if
	sip=rs(3)
	acip=rs(7)
	if rs(5)=grade20 then
	online_face="<img src="&picurl&pic_om&" alt="&rs(5)&" width=12 height=11>"
	elseif  rs(5)=grade19 then
	online_face="<img src="&picurl&pic_ob&" alt="&rs(5)&" width=12 height=11>"
	response.write ""
	elseif rs(5)=grade18 then
	online_face="<img src="&picurl&pic_ov&" alt="&rs(5)&" width=12 height=11>"
	else
	online_face="<img src="&picurl&pic_ou&" width=12 height=11>&nbsp;"
	end if

	if membername=rs(0) then
	onlineusername="<font color="&online_mc&">"&htmlencode(rs(0))&"</font>"
	else
	onlineusername=htmlencode(rs(0))
	end if
	response.write ""&online_face&"&nbsp;<a href=dispuser.asp?name="&htmlencode(rs(0))&" target=_blank alt=""目前位置："&htmlencode(rs(4))&"<br>来访时间："&rs(1)&"<br>活动时间："&rs(2)&"<br>"&system(rs(6))&"<br>"&browser(rs(6))&""&_
		"<br>真实ＩＰ："&userip&"<br>来源鉴定："&userfrom&useracfrom&""">"&onlineusername&"</a>&nbsp;"
	userfrom=""
	useracfrom=""
	rs.movenext
	response.write "</td>"
	if i=7 then response.write "</tr>"
	i=i+1
	loop
	rs.close
	set rs=nothing
	end if
	if cint(online_g)=1 then
	i=8
	'客人信息
	if boardid=0 then
	sql="select username,startime,lastimebk,ip,stats,userclass,browser,actforip,comefrom,actCome,id from online where username='"&guests&"'"
	else
	sql="select username,startime,lastimebk,ip,stats,userclass,browser,actforip,comefrom,actCome,id from online where username='"&guests&"' and boardid="&boardid
	end if
	set rs=server.createobject("adodb.recordset")
	rs.open sql,conn,0,1
	if rs.eof and rs.bof then
	response.write "<br>"
	else
	do while not rs.eof
	if i>7 then 
	response.write "<tr><td width=""14%"">"
	i=1
	else
	response.write "<td width=""14%"">"
	end if
	sip=rs(3)
	acip=rs(7)

	online_face="<img src="&picurl&pic_oh&">"
	if IpFlag=0 then
		if boardmaster or master then 
		        if acip <> "" then
				userip=acip
		        else
				userip=sip
		        end if
		else
			userip="已设置保密"
		end if
	else
		if acip <> "" then
        		userip=acip
        	else
			userip=sip
	        end if
	end if

	if FromFlag=0 then
		if boardmaster or master then 
        		if acip <> "" then
				userfrom=rs(9)
		        else
				userfrom=rs(8)
		        end if
		else
			userfrom="已设置保密"
		end if
	else
        	if acip <> "" then
			userfrom=rs(9)
		else
			userfrom=rs(8)
		end if
	end if

	if acip <> "" then
		useracfrom="&#13;&#10;代理ＩＰ："
		if IpFlag=0 then
			if boardmaster or master then 
			useracfrom=useracfrom & sip
			else
			useracfrom=useracfrom & "已设置保密"
			end if
		else
			useracfrom=useracfrom & sip
		end if
		useracfrom=useracfrom & "&#13;&#10;代理鉴定："
		if FromFlag=0 then
			if boardmaster or master then
			useracfrom=useracfrom & rs(8)
			else
			useracfrom=useracfrom & "已设置保密"
			end if
		else
			useracfrom=useracfrom & rs(8)
		end if
	end if
	if trim(session("userid"))<>"" and isnumeric(session("userid")) then
		if int(session("userid"))=int(rs(10)) then
			onlineusername="<font color="&online_mc&">客人</font>"
		else
			onlineusername="客人"
		end if
	else
	onlineusername="客人"
	end if
	response.write ""&online_face&"&nbsp;<a href=dispuser.asp?name="&htmlencode(rs(0))&" target=_blank alt=""目前位置："&htmlencode(rs(4))&"<br>来访时间："&rs(1)&"<br>活动时间："&rs(2)&"<br>"&system(rs(6))&"<br>"&browser(rs(6))&""&_
		"<br>真实ＩＰ："&userip&"<br>来源鉴定："&userfrom&useracfrom&""">"&onlineusername&"</a>&nbsp;"
	userfrom=""
	useracfrom=""
	rs.movenext
	response.write "</td>"
	if i=7 then response.write "</tr>"
	i=i+1
	loop
	end if
	rs.close
	set rs=nothing
end if

if boardid>0 and (cint(online_u)=1 or cint(online_g)=1) then
response.write "</TABLE>"
end if
end sub
%>