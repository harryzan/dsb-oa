<!--#include file="conn.asp"-->
<!--#include file="md5.asp"-->
<%	
	dim username
	dim sex
	dim pass1
	dim pass2
	dim password
	dim useremail
	dim face,width,height
	dim oicq
	dim sign
	dim showRe
	dim birthday
	dim mailbody
	dim sendmsg
	dim rndnum,num1
	dim quesion
	dim answer
	dim topic,SendMail
	dim wealthReg,epReg,cpReg

	username = request("username")
	password = request("password")
	sex = request("sex")
	useremail = request("useremail")
	
	dim rs,sql
	set rs=server.createobject("adodb.recordset")
	sql="select * from [user] where username='"&username&"'"	
	rs.open sql,conn,1,3
	if not rs.eof and not rs.bof then
		response.write "error"
		response.end
	else
		rs.addnew
		rs("username")=username
		rs("userpassword")=md5(password)
		rs("useremail")=useremail
		rs("userclass")=1
		rs("quesion")= "8888"
		rs("answer")= "h5j6k7l9g0"
		
		if request("Signature")<>"" then
		  rs("sign")=trim(request("Signature"))
		end if
		if request("oicq")<>"" then
		  rs("oicq")=request("oicq")
		end if
		if request("icq")<>"" then
		  rs("icq")=request("icq")
		end if
		if request("msn")<>"" then
		  rs("msn")=request("msn")
		end if
    rs("article")=0
    rs("sex")=sex
		rs("showRe")=true
		if birthday<>"" then
		  rs("birthday")=birthday
		end if
		rs("UserGroup")=request("GroupName")
    rs("addDate")=NOW()
    face = "pic/Image1.gif"
    width = 32
    height = 32
		if face<>"" then
		  rs("face")=face
      rs("width")=width
      rs("height")=height
		end if
		rs("logins")=1
    rs("lastlogin")=NOW()
		rs("userWealth")=wealthReg
		rs("userEP")=epReg
		rs("usercP")=cpReg

		rs.update
		rs.close
		set rs=nothing
		conn.execute("update config set usernum=usernum+1,lastuser='"&username&"'")
	end if

CloseDatabase

response.clear
response.write "true"
%>