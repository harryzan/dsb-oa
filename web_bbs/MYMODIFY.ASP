<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!-- #include file="chkuser.asp" -->
<!--#include file="inc/char.asp"-->
<!--#include file="inc/theme.asp"-->
<!--#include file="md5.asp"-->
<!--#include file="inc/chkinput.asp"-->
<%
stats="修改资料"
dim sex
dim showre
dim password
dim quesion
dim answer
dim face,width,height
dim email
dim birthday
dim usercookies
if not founduser then
  	errmsg=errmsg+"<br>"+"<li>您没有<a href=login.asp target=_blank>登录</a>。"
	founderr=true
else
	if request("action")="updat" then
		if request("sex")="" then
			errmsg=errmsg+"<br>"+"<li>请选择您的性别。"
			founderr=true
		elseif request("sex")=0 or request("sex")=1 then
			sex=request("sex")
		else
			errmsg=errmsg+"<br>"+"<li>您输入的字符非法。"
			founderr=true
		end if
		
		if request("showRe")="" then
			errmsg=errmsg+"<br>"+"<li>请选择有回帖时是否提示您。"
			founderr=true
		elseif request("showRe")=0 or request("showRe")=1 then
			showRe=request("showRe")
		else
			errmsg=errmsg+"<br>"+"<li>您输入的字符非法。"
			founderr=true
		end if
		
	if master then		
		if request("psw")="" then
		  	errmsg=errmsg+"<br>"+"<li>请输入您的密码。"
			founderr=true
		elseif trim(request("psw"))=trim(memberword) then
			password=request("psw")
		else
			password=md5(request("psw"))
		end if
	end if
		
	dim kkk
	kkk="1"
	if kkk="2" then
		if request("quesion")="" then
		  	errmsg=errmsg+"<br>"+"<li>请输入密码提示问题。"
			founderr=true
		else
		quesion=request("quesion")
		end if
		if request("answer")="" then
		  	errmsg=errmsg+"<br>"+"<li>请输入密码提示问题答案。"
			founderr=true
		elseif request("answer")=request("oldanswer") then
			answer=request("answer")
		else
		answer=md5(request("answer"))
		end if
		
	end if
	
		if request("myface")<>"" then
			if request("width")="" or request("height")="" then
				errmsg=errmsg+"<br>"+"<li>请输入图片的宽度和高度。"
				founderr=true
			elseif not isInteger(request("width")) or not isInteger(request("height")) then
				errmsg=errmsg+"<br>"+"<li>您输入的字符不合法。"
				founderr=true
			elseif request("width")<20 or request("width")>120 then
				errmsg=errmsg+"<br>"+"<li>您输入的图片宽度不符合标准。"
				founderr=true
			elseif request("height")<20 or request("height")>120 then
				errmsg=errmsg+"<br>"+"<li>您输入的图片高度不符合标准。"
				founderr=true
			else
				face=request("myface")
				width=request("width")
				height=request("height")
			end if
		else
			if request("face")="" then
				errmsg=errmsg+"<br>"+"<li>请选择您的个性头像。"
				founderr=true
			elseif Instr(request("face"),picurl)>0 then
				face=request("face")
				width=32
				height=32
			else
				errmsg=errmsg+"<br>"+"<li>您选择了错误的头像。"
				founderr=true
			end if
		end if
		if IsValidEmail(request("Email"))=false then
   			errmsg=errmsg+"<br>"+"<li>您的Email有错误。"
   			founderr=true
		else
			Email=request("Email")
		end if
		if request("oicq")<>"" then
			if not isnumeric(request("oicq")) or len(request("oicq"))>10 then
			errmsg=errmsg+"<br>"+"<li>Oicq号码只能是4-10位数字，您可以选择不输入。"
			founderr=true
			end if
		end if
		if request.Form("birthyear")="" or request.form("birthmonth")="" or request.form("birthday")="" then
		birthday=""
		else
		birthday=trim(Request.Form("birthyear"))&"-"&trim(Request.Form("birthmonth"))&"-"&trim(Request.Form("birthday"))
		if not isdate(birthday) then birthday=""
		end if
	else
		call nav()
		call headline(1)
		call userinfo()
	end if
end if

if founderr then
	call nav()
	call headline(1)
	call error()
else
	if request("action")="updat" then
		if founderr then
			call nav()
			call headline(1)
			call error()
		else
			call update()
			call nav()
			call headline(1)
			if founderr then
			call error()
			else
			call success()
			end if
		end if
	end if
end if
call endline()

sub userinfo()
	set rs=server.createobject("adodb.recordset")
	sql="Select * from [User] where username='"&trim(membername)&"'"
	rs.open sql,conn,1,1
	if rs.eof and rs.bof then
		errmsg=errmsg+"<br>"+"<li>该用户名不存在。"
		founderr=true
	else
%>
<form action="mymodify.asp?action=updat&username=<%=htmlencode(membername)%>" method=POST name="theForm">
<table cellpadding=0 cellspacing=0 border=0 width=<%=tablewidth%> bgcolor=<%=Tablebackcolor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
    <tr align="center"> 
      <td colspan="2" width="100%" bgcolor=<%=Tabletitlecolor%> height=25><font color="<%=TablefontColor%>"><b><%=htmlencode(RS("username"))%>修改资料</b></font></td>
    </tr>
      <tr bgcolor=<%=Tablebodycolor%>>    
        <td width="40%"><font color="<%=TableContentColor%>"><B>性别</B>：<BR>请选择您的性别</font></td>   
        <td width="60%"><input type="radio" value="1"<%if rs("sex")=1 then%> checked <%end if%>name="Sex">男
      <input type="radio" name="Sex"<%if rs("sex")=0 then%> checked <%end if%> value="0">女</td>
</td>   
      </tr>   
      <tr bgcolor='<%=Tablebodycolor%>'  <%if master=false then%>style="display:none"<%end if%>>    
        <td width="40%"><font color="<%=TableContentColor%>"><B>密码</B>：<BR>如要修改请直接输入</font></td>   
        <td width="60%">    
          <input type="password" name="psw" value="<%=htmlencode(RS("userpassword"))%>" size=30 maxlength=13 <%if master=false then%>readonly<%end if%>>   
        <font color="#FF0000">*</font></td>   
      </tr>   
      <tr bgcolor='<%=Tablebodycolor%>'  style="display:none">    
        <td width="40%"><font color="<%=TableContentColor%>"><B>密码问题</B>：<BR>请填写做为密码答案依据</font></td>   
        <td width="60%">    
          <input type=text name="quesion" size=30 value="<%=htmlencode(rs("quesion"))%>" readonly>
        </td>   
      </tr>  
      <tr bgcolor='<%=Tablebodycolor%>'  style="display:none">    
        <td width="40%"><font color="<%=TableContentColor%>"><B>问题答案</B>：<BR>请认真填写以便您日后取回密码<BR>答案采用了MD5加密，只供取回密码使用，如要修改可直接填写。</font></td>   
        <td width="60%">    
          <input type=text name="answer" size=30 value="<%=htmlencode(rs("answer"))%>" readonly>
          <input type=hidden name="oldanswer" value="<%=htmlencode(rs("answer"))%>">
        </td>   
      </tr>  
      <tr bgcolor=<%=Tablebodycolor%>>    
        <td width="40%"><font color="<%=TableContentColor%>"><B>Email地址</B>：<BR>请输入有效的邮件地址，这将保证您在论坛中的私人资料。</font></td>   
        <td width="60%">    
          <input type="TEXT" name="Email" size=30 maxlength=50 value="<%if trim(rs("useremail"))<>"" then%><%=htmlencode(rs("useremail"))%><%end if%>">   
        </td>   
      </tr>   
      <tr bgcolor=<%=Tablebodycolor%>>    
        <td width="40%" valign=top><font color="<%=TableContentColor%>"><B>头像</B>：<BR>
</font>
		</td>   
        <td width="60%">    <font color="<%=TableContentColor%>">
<select name=face style="font-family:arial" size=1 
onChange="document.images['face'].src=options[selectedIndex].value; 
parent.document.forms[0].myface.value=options[selectedIndex].value"> 
<% 
	Dim OldfaceStr,LenOldfaceStr,OldfaceNum 
	OldfaceStr = rs("face") 
	
	LenOldfaceStr = Len( OldfaceStr ) 
	if LenOldfaceStr = 14 then OldfaceNum = Left( Right(OldfaceStr,5),1 ) 
	if LenOldfaceStr = 15 then OldfaceNum = Left( Right(OldfaceStr,6),2 ) 
	if LenOldfaceStr = 16 then OldfaceNum = Left( Right(OldfaceStr,7),3 ) 
	
	OldfaceNum = Cint( OldfaceNum ) 

	for i=1 to OldfaceNum
	if OldfaceNum - i = 0 then
%> 
   <option value='<%=picurl%>Image<%=i%>.gif' selected>Image<%=i%></option> 
     <% else %> 
   <option value='Pic/Image<%=i%>.gif'>Image<%=i%></option> 
<%
	end if 
	next
%> 
                </select>&nbsp;&nbsp;<img id=face src="<%=rs("face")%>" width=<%=rs("width")%> height=<%=rs("height")%>><BR><BR>
<input type="hidden" name="myface" size=20 maxlength=100 value=<%=rs("face")%>> <input type="hidden" name="width" size=3 maxlength=3 value=<%=rs("width")%>>
	 <input type="hidden" name="height" size=3 maxlength=3 value=<%=rs("height")%>><a href="allface.asp" target="_blank" title="头像预览列表">[<font color=red>头像预览</font>]</a><br>
</font>
        </td>   
      </tr>	  
      <tr bgcolor=<%=Tablebodycolor%>>    
        <td width="40%"><font color="<%=TableContentColor%>"><B>个人照片</B>：<BR>如果您有照片在网上，请输入网页地址。此项可选</font></td>   
        <td width="60%">    
          <input type="TEXT" name="userphoto" value="<%if trim(rs("userphoto"))<>"" then%><%=htmlencode(rs("userphoto"))%><%end if%>" size=30 maxlength=100>   
        </td>   
      </tr>   
      <tr bgcolor=<%=Tablebodycolor%>>    
        <td width="40%"><font color="<%=TableContentColor%>"><B>联系地址</B>：<BR>此项可选</font></td>   
        <td width="60%">    
          <input type="TEXT" name="URL" size="70" value="<%if trim(rs("homepage"))<>"" then%><%=htmlencode(rs("homepage"))%><%end if%>" size=30 maxlength=100>   
        </td>   
      </tr>   
      <tr bgcolor=<%=Tablebodycolor%>>    
        <td width="40%"><font color="<%=TableContentColor%>"><B>有回帖时是否提示您</B>：<BR>当您的帖子有人回复后有信息通知您</font></td>   
        <td width="60%">    <font color="<%=TableContentColor%>">
			<input type="radio" name="showRe" value="1" <% if rs("showRe") then response.write "checked" %> >
			提示我
			<input type="radio" name="showRe" value="0" <% if not rs("showRe") then response.write "checked" %> >
			不提示</font>
        </td>   
      </tr>	  
      <tr bgcolor=<%=Tablebodycolor%>>    
        <td valign=top width="40%"><font color="<%=TableContentColor%>"><B>签名</B>：<BR>不能超过 300 个字符   
          <br>   
          文字将出现在您发表的文章的结尾处。</font></td>   
        <td width="60%">    
          <textarea name="Signature" rows=5 cols=60 wrap=PHYSICAL><%if rs("sign")<>"" then%>
<%
dim signtrue
signtrue=replace(rs("sign"),"<BR>",chr(13))
signtrue=replace(signtrue,"&nbsp;"," ")
%><%=signtrue%><%end if%></textarea>   
        </td>   
      </tr> 
    <tr align="center"> 
      <td colspan="2" width="100%" bgcolor=<%=Tabletitlecolor%>>
            <input type=Submit value="更 新" name="Submit"> &nbsp; <input type="reset" name="Submit2" value="清 除">
      </td>
    </tr>  
    </table>   </td></tr></table> 
</form>   
</body>
</html> 
<%
	end if
	rs.close
	set rs=nothing
end sub

sub update()
	set rs=server.createobject("adodb.recordset")
	sql="Select * from [User] where username='"&trim(membername)&"'"
	rs.open sql,conn,1,3
	if rs.eof and rs.bof then
		errmsg=errmsg+"<br>"+"<li>该用户名不存在。"
		founderr=true
	else
	  if master then
		rs("userpassword")=password
		end if
		rs("useremail")=email
		'rs("quesion")=quesion
		'rs("answer")=answer
		rs("homepage")=request("url")
		rs("face")=face
		rs("width")=width
		rs("height")=height
		rs("sex")=sex
		rs("sign")=trim(request("Signature"))
		rs("oicq")=request("oicq")
		rs("icq")=request("icq")
		rs("msn")=request("msn")
		rs("userphoto")=request("userphoto")
		rs("showRe")=showRe
		rs("UserGroup")=request("GroupName")
		if rs("userclass")>5 then
		if request("title")<>"" then
		rs("title")=htmlencode(request("title"))
		end if
		end if
		if birthday<>"" then
		rs("birthday")=birthday
		end if
		rs.Update
        	rs.close
			set rs=nothing
        	        usercookies=request("usercookies")
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
			
  			Response.Cookies("esbpbbs")("password") = password
			Response.Cookies("esbpbbs").path=cookiepath
	end if
end sub

sub success()
%>
<table cellpadding=0 cellspacing=0 border=0 width="<%=tablewidth%>" bgcolor=<%=Tablebackcolor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
    <tr align="center"> 
      <td width="100%" bgcolor=<%=Tabletitlecolor%>><font color="<%=TablefontColor%>">成功：修改资料</font></td>
    </tr>
    <tr> 
      <td width="100%" bgcolor=<%=Tablebodycolor%>><font color="<%=TableContentColor%>"><b>恭喜您，您的资料修改成功</b></font><br>
      </td>
    </tr>
    <tr align="center"> 
      <td width="100%" bgcolor=<%=Tabletitlecolor%>>
<a href="MYMODIFY.ASP?name=<%=htmlencode(membername)%>"> << 返回上一页</a>
      </td>
    </tr>  
    </table>   </td></tr></table>
<%
end sub
	set rs=nothing 
	stats="修改个人资料"
%>   
<!--#include file=footer.asp-->