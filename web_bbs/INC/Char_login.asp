<%
Rem ==========ÂÛÌ³µÇÂ½º¯Êý=========
Rem ÅÐ¶ÏÓÃ»§µÇÂ½
function chkuserlogin(username,password,usercookies,ctype)
	'ÅÐ¶Ï¸üÐÂcookiesÄ¿Â¼
	dim cookies_path_s
	dim cookies_path_d
	cookies_path_s=split(Request.ServerVariables("PATH_INFO"),"/")
	cookies_path_d=ubound(cookies_path_s)
	cookiepath="/"
	for i=1 to cookies_path_d-1
		cookiepath=cookiepath&cookies_path_s(i)&"/"
	next
	dim rsUser,article,userclass
	chkuserlogin=false
   	sql="select username,userpassword,lockuser,userclass,article,userWealth,userEP,userCP,usercookies,LastLogin from [User] where username='"&checkStr(username)&"'"
   	set rsUser=server.createobject("adodb.recordset")
	rsUser.open sql,conn,1,3
	if rsUser.eof and rsUser.bof then
		chkuserlogin=false
	else
		if trim(password)<>trim(rsUser(1)) then
			chkuserlogin=false
		elseif rsUser("lockuser")=1 then
			chkuserlogin=false
		else
			chkuserlogin=true
			article=rsUser("article")
			userclass=rsUser("userclass")
			if isnull(userclass) or userclass="" then userclass=1
			if userclass<>18 and userclass<>19 and userclass<>20 then
				if article<cint(point(2)) then userclass=1
				for i=2 to 16
				if article>=point(i) and article<point(i+1) then
				userclass=i
				exit for
				end if
				next
				if article>=point(17) then userclass=17
			end if
			select case ctype
			case 1
			if datediff("d",rsUser("LastLogin"),Now())=0 then
			sql="update [user] set userclass="&userclass&",lastlogin=Now(),logins=logins+1 where username='"&username&"'"
			else
			sql="update [user] set userWealth=userWealth+"&wealthLogin&",userEP=userEP+"&epLogin&",userCP=userCP+"&cpLogin&",userclass="&userclass&",lastlogin=Now(),logins=logins+1 where username='"&username&"'"
			end if
			case 2
			sql="update [user] set article=article+1,userWealth=userWealth+"&wealthAnnounce&",userEP=userEP+"&epAnnounce&",userCP=userCP+"&cpAnnounce&",userclass="&userclass&",lastlogin=Now() where username='"&username&"'"
			case 3
			sql="update [user] set article=article+1,userWealth=userWealth+"&wealthreAnnounce&",userEP=userEP+"&epreAnnounce&",userCP=userCP+"&cpreAnnounce&",userclass="&userclass&",lastlogin=Now() where username='"&username&"'"
			end select
			conn.execute(sql)
			if isnull(usercookies) or usercookies="" then usercookies=3
			select case usercookies
	       	 	case 0
  			Response.Cookies("esbpbbs")("usercookies") = usercookies
	        	case 1
	        	Response.Cookies("esbpbbs").Expires=Date+1
  			Response.Cookies("esbpbbs")("usercookies") = usercookies
	        	case 2
	        	Response.Cookies("esbpbbs").Expires=Date+31
  			Response.Cookies("esbpbbs")("usercookies") = usercookies
	        	case 3
	        	Response.Cookies("esbpbbs").Expires=Date+365
  			Response.Cookies("esbpbbs")("usercookies") = usercookies
	        	end select
			Response.Cookies("esbpbbs")("username") = rsUser("username")
			Response.Cookies("esbpbbs")("password") = PassWord
			Response.Cookies("esbpbbs")("userclass") = grade(userclass)
			Response.Cookies("esbpbbs").path=cookiepath
			'response.write cookiepath
			'response.end
		end if
	end if
	rsUser.close
	set rsUser=nothing
end function
%>
