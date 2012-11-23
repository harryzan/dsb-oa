<!--#include file="conn.asp"-->
<!--#include file="inc/char.asp"-->
<!--#include file="inc/const.asp"-->
<!--#include file="chkuser.asp"-->
<%
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
	conn.close
	set conn=nothing
	response.redirect("index.asp")
%>
