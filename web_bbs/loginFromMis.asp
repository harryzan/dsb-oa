<!--#include file="conn.asp"-->
<!--#include file="inc/const.asp"-->
<!--#include file="inc/char.asp"-->
<!--#include file="inc/char_login.asp"-->
<!--#include file="inc/char_cfrom.asp"-->
<!--#include file="chkuser.asp"-->
<!--#include file="inc/theme.asp"-->
<!--#include file="md5.asp"-->
<%

Server.ScriptTimeOut=9999999

	dim UserIP
	dim username
	dim userclass
	dim password
	dim article
	dim cookies_path_s,cookies_path_d,cookies_path,usercookies

	sub chkuser()
	  Dim str,url,uname,upass,uip,uport
	  uname = request("username")
	  uip = request("REMOTE_ADDR")
	  uport = "80"

      url="http://mis.shcjsq.com:"&uport&"/mis/system/user/Sys_chklogin.jsp?username="&uname&"&ip="&uip
	  'response.write url
	  'response.end

      str = getHTTPPage(url)      

      if str<>"" and instr(str,"true")=1 then
        
        '判断更新cookies目录
	    cookies_path_s=split(Request.ServerVariables("PATH_INFO"),"/")
        cookies_path_d=ubound(cookies_path_s)
	    cookies_path="/"
	    for i=1 to cookies_path_d-1
		    cookies_path=cookies_path&cookies_path_s(i)&"/"
	    next
	    if cookiepath<>cookies_path then
	      cookiepath=cookies_path
	      conn.execute("update config set cookiepath='"&cookiepath&"'")
	    end if
	    
	    dim rs,sql
	    sql = "select UserPassword from [user] where UserName='"&uname&"'"
	    set rs=server.createobject("adodb.recordset")
	    rs.open sql,conn,1,3
	    if rs.eof = false then
	      upass = trim(rs("UserPassword"))
	    end if
	    rs.close
	    set rs=nothing

	    usercookies="0"
	    'response.clear
	    'response.write "kkkk="&upass
	    'response.end
	    if chkuserlogin(uname,upass,usercookies,1)=false then
		    errmsg=errmsg+"<br>"+"<li>您的用户名并不存在，或者您的密码错误，或者您的帐号已被管理员锁定。"
		    founderr=true
	    end if
      else   
         errmsg=errmsg+"<br>"+"<li>您的用户名并不存在！请联系系统管理员！"      
         founderr = true
      end if
	end sub
	
	sub clearCookie
	  dim activeuser
	  membername=request.cookies("esbpbbs")("username")
	  if session("userid")<>"" then
  	  activeuser="delete from online where id="&session("userid")
  	  Conn.Execute activeuser
  	end if
  	if membername<>"" then
    	activeuser="delete from online where username='"&membername&"'"
    	Conn.Execute activeuser
  	end if
  	Response.Cookies("esbpbbs").path=cookiepath
  	Response.Cookies("esbpbbs")("username")=""
  	Response.Cookies("esbpbbs")("password")=""
  	Response.Cookies("esbpbbs")("userclass")=""
  	Response.Cookies("esbpbbs")("usercookies")=""
  	session("userid")=""
	end sub

	stats="用户登陆"
	call chkuser()
	
	if founderr then
		call nav()
		call headline(1)
		call error()
		
		call clearCookie
		
	else
		call nav()
		call headline(1)
		call success()
	end if	
	
	call endline()
	
	sub success()
	dim comeurl
%>
<%if instr(lcase(request("comeurl")),"regpost")>0 or instr(request("comeurl"),"login.asp")>0 or instr(request("comeurl"),"chklogin.asp")>0 or trim(request("comeurl"))="" then%>
	<meta HTTP-EQUIV=REFRESH CONTENT='0; URL=index.asp'>
<%comeurl="index.asp"%>
<%else%>
	<meta HTTP-EQUIV=REFRESH CONTENT='0; URL=<%=request("comeurl")%>'>
<%comeurl=request("comeurl")%>
<%end if%>
    <table cellpadding=0 cellspacing=0 border=0 width=<%=TableWidth%> bgcolor=<%=tablebackcolor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
	     <tr>
	      <td bgcolor="<%=tableTitleColor%>"><font color="<%=TableFontColor%>"><b>状态：您已经登录成功</b></font></td>
	    </tr>
	     <tr><td bgcolor="<%=tablebodycolor%>"><br><ul><li><a href="<%=comeurl%>"><font color="<%=TableContentColor%>">进入讨论区</font></a></li></ul></td></tr>
	  </table>   </td></tr></table>
<%
	end sub
%>
<!-- #include file=footer.asp -->

<%
Function getHTTPPage(Path)
  dim t
  t = GetBody(Path)
  getHTTPPage=BytesToBstr(t,"GB2312")
End function

Function GetBody(url) 
  'on error resume next
  dim Retrieval
  Set Retrieval = CreateObject("Microsoft.XMLHTTP") 
  With Retrieval 
  .Open "Get", url, False, "", "" 
  .Send 
  GetBody = .ResponseBody
  End With 
  Set Retrieval = Nothing 
End Function

'然后调用XMLHTTP组件创建一个对象并进行初始化设置。

Function BytesToBstr(body,Cset)
On Error Resume Next
  dim objstream
  set objstream = Server.CreateObject("adodb.stream")
  objstream.Type = 1
  objstream.Mode =3
  objstream.Open
  objstream.Write body
  objstream.Position = 0
  objstream.Type = 2
  objstream.Charset = Cset
  BytesToBstr = objstream.ReadText 
  objstream.Close
  set objstream = nothing
End Function

Function Newstring(wstr,strng)
  Newstring=Instr(lcase(wstr),lcase(strng))
  if Newstring<=0 then Newstring=Len(wstr)
End Function
%>
