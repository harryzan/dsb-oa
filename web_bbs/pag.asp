<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!-- #include file="chkuser.asp" -->
<!-- #include file="inc/char.asp" -->
<!-- #include file="inc/chkinput.asp" -->
<!-- #include file="inc/email.asp" -->
<!-- #include file="inc/theme.asp" -->
<!-- #include file="inc/ubbcode.asp" -->
<%
	dim announceid
	dim username
	dim rootid
	dim topic
	dim mailbody
	dim email
	dim announce
	dim abgcolor
	dim usersign
	usersign=false
	stats="打包邮递"
    	call chkInput()

	call nav()
	call headline(1)
    	if foundErr then
		call Error()
	else
		call showPage()
	end if
	call endline()
	sub showPage()
		'on error resume next
		if foundErr then
			call Error()
		else
			if request("action")="sendmail" then
				if IsValidEmail(trim(Request.Form("mail")))=false then
   					errmsg=errmsg+"<br>"+"<li>您的Email有错误!</li>"
   					founderr=true
				else
					email=trim(Request.Form("mail"))
				end if
				call announceinfo()
				if founderr then
					call Error()
				else
					if EmailFlag=0 then
						errmsg=errmsg+"<br>"+"<li>本论坛不支持发送邮件。</li>"
   						founderr=true
						call error()
					elseif EmailFlag=1 then
						call jmail(email)
						call success()
					elseif EmailFlag=2 then
						call Cdonts(email)
						call success()
					elseif EmailFlag=3 then
						call aspemail(email)
						call success()
					end if
				end if
			else
				call pag()
			end if
		end if
		if err.number<>0 then err.clear
	end sub

	sub announceinfo()
   	set rs=server.createobject("adodb.recordset")
	sql="select boardtype from board where boardID="&BoardID
   	rs.open sql,conn,1,1
	if not(rs.bof and rs.eof) then
   		boardtype=rs("boardtype")
	else
		foundErr = true
		ErrMsg=ErrMsg+"<br>"+"<li>您指定的论坛版面不存在</li>"
		exit sub
	end if
	rs.close
	'Rs.open "Select topic from bbs1 Where announceID="&AnnounceID&"",conn,1,1
     	set rs=conn.execute("select topic from bbs1 where announceID="&rootID&"")
	if not(rs.bof and rs.eof) then
		topic=rs("topic")
	else
		foundErr = true
		ErrMsg=ErrMsg+"<br>"+"<li>您指定的贴子不存在</li>"
		exit sub
	end if
	rs.close
	mailbody=mailbody &"<style>A:visited {	TEXT-DECORATION: none	}"
	mailbody=mailbody &"A:active  {	TEXT-DECORATION: none	}"
	mailbody=mailbody &"A:hover   {	TEXT-DECORATION: underline overline	}"
	mailbody=mailbody &"A:link 	  {	text-decoration: none;}"
	mailbody=mailbody &"A:visited {	text-decoration: none;}"
	mailbody=mailbody &"A:active  {	TEXT-DECORATION: none;}"
	mailbody=mailbody &"A:hover   {	TEXT-DECORATION: underline overline}"
	mailbody=mailbody &"BODY   {	FONT-FAMILY: 宋体; FONT-SIZE: 9pt;}"
	mailbody=mailbody &"TD	   {	FONT-FAMILY: 宋体; FONT-SIZE: 9pt	}</style>"
	mailbody=mailbody &"<TABLE border=0 width='95%' align=center><TBODY><TR>"
	mailbody=mailbody &"<TD valign=middle align=top>"
	mailbody=mailbody &"-&nbsp;&nbsp;<b>"&ForumName&"</b>&nbsp;&nbsp;("&ForumURL&"index.asp)<br>"
	mailbody=mailbody &"--&nbsp;&nbsp;<b>"&boardtype&"</b>&nbsp;&nbsp;("&ForumURL&"list.asp?boardid="&boardid&")<br>"
	mailbody=mailbody &"----&nbsp;&nbsp;<b>"&htmlencode(topic)&"</b>&nbsp;&nbsp;("&ForumURL&"dispbbs.asp?boardid="&boardid&"&rootid="&rootid&"&id="&announceid&")"
	mailbody=mailbody &"</TD></TR></TBODY></TABLE><br><hr>"

	Rs.open "Select UserName,Topic,dateandtime,body from bbs1 where boardid="&boardid&" and rootid="&rootid&" order by announceid",conn,1,1
       	do while not rs.eof

	announce=announce &"<TABLE border=0 width='95%' align=center><TBODY><TR>"
	announce=announce &"<TD valign=middle align=top>"
	announce=announce &"--&nbsp;&nbsp;作者："&rs("username")&"<br>"
	announce=announce &"--&nbsp;&nbsp;发布时间："&rs("dateandtime")&"<br><br>"
	announce=announce &"--&nbsp;&nbsp;"&htmlencode(rs("topic"))&"<br>"
	announce=announce &""&ubbcode(rs("body"))&""
	announce=announce &"<hr></TD></TR></TBODY></TABLE>"

          rs.movenext
        loop	
	rs.close
	set rs=nothing
	mailbody=mailbody+announce
	mailbody=mailbody &""&Copyright&"&nbsp;&nbsp;"&Version&""
'	response.write mailbody
'	mailbody=""
	end sub

	sub pag()
%>
<table cellpadding=0 cellspacing=0 border=0 width=460 bgcolor=<%=tablebackcolor%> align=center>
    <tr>
        <td>
        <table cellpadding=6 cellspacing=1 border=0 width=100%>
        
    <form action="pag.asp?action=sendmail&boardid=<%=boardid%>&rootid=<%=rootid%>&id=<%=announceid%>" method=post>
    <tr>
    <td bgcolor=<%=tabletitlecolor%> valign=middle colspan=2 align=center><font color="<%=TableFontColor%>">
    <b>打包邮递</b></font></td></tr>
    <tr>
    <td bgcolor=<%=tablebodycolor%> valign=middle colspan=2><font color="<%=TableContentColor%>">
    <b>把本帖打包邮递。</b><br>请正确输入你要邮递的邮件地址！</font>
        </td></tr><tr>
    
    <td bgcolor=<%=atablebodycolor%>><font color="<%=TableContentColor%>"><b>邮递的 Email 地址：</b></font></td>
    <td bgcolor=<%=atablebodycolor%>><input type=text size=40 name="mail"></td>
    </tr><tr>
    <td colspan=2 bgcolor=<%=tabletitlecolor%> align=center><input type=submit value="发 送" name="Submit"></table></td></form></tr></table>
<%
	end sub
    
    	sub chkInput
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
    	end sub

sub success()
%>
    <table cellpadding=0 cellspacing=0 border=0 width=460 bgcolor=<%=tablebackcolor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
    <tr align="center"> 
      <td width="100%" bgcolor=<%=tabletitlecolor%>><font color="<%=TablefontColor%>">成功：打包邮递</font></td>
    </tr>
    <tr> 
      <td width="100%" bgcolor=<%=tablebodycolor%>><font color="<%=TableContentColor%>">恭喜您，您的打包邮递发送成功。</font>
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
%>
<!--#include file="footer.asp"-->
