<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!-- #include file="chkuser.asp" -->
<!-- #include file="inc/char.asp" -->
<!-- #include file="inc/chkinput.asp" -->
<!-- #include file="inc/email.asp" -->
<!-- #include file="inc/theme.asp" -->
<%
	dim announceid
	dim username
	dim rootid
	dim topic
	dim mailbody
	dim email
	dim content
	dim postname
	dim incepts
	dim announce
    	Rem ------获取参数(get or post的)------
    	Rem ------包括版面的ID和页次------
	stats="发送帖子"
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
   					errmsg=errmsg+"<br>"+"<li>您的Email有错误。</li>"
   					founderr=true
				else
					email=trim(Request.Form("mail"))
				end if
				if request("postname")="" then
   					errmsg=errmsg+"<br>"+"<li>请输入您的姓名。</li>"
   					founderr=true
				else
					postname=request("postname")
				end if
				if request("incept")="" then
   					errmsg=errmsg+"<br>"+"<li>请输入收件人姓名。</li>"
   					founderr=true
				else
					incepts=request("incept")
				end if
				if request("content")="" then
   					errmsg=errmsg+"<br>"+"<li>邮件内容不能为空。</li>"
   					founderr=true
				else
					content=request("content")
				end if
				if founderr then
					call error()
				else
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
     	set rs=conn.execute("select topic from bbs1 where announceID="&rootID&"")
	if not(rs.bof and rs.eof) then
'		topic=rs("topic")
		topic="您的朋友"&postname&"给您发来了一个"&ForumName&"上的贴子"
	else
		foundErr = true
		ErrMsg=ErrMsg+"<br>"+"<li>您指定的贴子不存在</li>"
		exit sub
	end if
	rs.close
	set rs=nothing
	mailbody=mailbody &"<style>A:visited {	TEXT-DECORATION: none	}"
	mailbody=mailbody &"A:active  {	TEXT-DECORATION: none	}"
	mailbody=mailbody &"A:hover   {	TEXT-DECORATION: underline overline	}"
	mailbody=mailbody &"A:link 	  {	text-decoration: none;}"
	mailbody=mailbody &"A:visited {	text-decoration: none;}"
	mailbody=mailbody &"A:active  {	TEXT-DECORATION: none;}"
	mailbody=mailbody &"A:hover   {	TEXT-DECORATION: underline overline}"
	mailbody=mailbody &"BODY   {	FONT-FAMILY: 宋体; FONT-SIZE: 9pt;}"
	mailbody=mailbody &"TD	   {	FONT-FAMILY: 宋体; FONT-SIZE: 9pt	}</style>"
	mailbody=mailbody &"<TABLE border=0 width='95%' align=center><TBODY><TR><TD>"
	mailbody=mailbody &""&incepts&"，您好：<br><br>"
	mailbody=mailbody &"您的朋友"&postname&"给您发来了一个"&ForumName&"--"&boardtype&"上的贴子<BR><br>"
	mailbody=mailbody &"标题是："&htmlencode(topic)&"<br><br>"
	mailbody=mailbody &""&htmlencode(content)&"<br><br>"
	mailbody=mailbody &"您可以到<a href=HTTP://WWW.DONGHAI-BRIDGE.COM.CN/club/dispbbs.asp?boardid="&boardid&"&rootid="&rootid&"&id="&Announceid&">"&topic&"</a>这里浏览这个贴子<br>"
	mailbody=mailbody &""&Copyright&"&nbsp;&nbsp;"&Version&""
	mailbody=mailbody &"</TD></TR></TBODY></TABLE>"
'	response.write mailbody
'	mailbody=""
	end sub

	sub pag()
%>
<table cellpadding=0 cellspacing=0 border=0 width="<%=tablewidth%>" bgcolor=<%=tablebackcolor%> align=center>
    <tr>
        <td>
        <table cellpadding=6 cellspacing=1 border=0 width=100%>
        
    <form action="sendpage.asp?action=sendmail&boardid=<%=boardid%>&rootid=<%=rootid%>&id=<%=announceid%>" method=post>
    <tr>
    <td bgcolor=<%=tabletitlecolor%> valign=middle colspan=2 align=center><font color="<%=TablefontColor%>">
    <b>发送邮件给朋友</b></font></td></tr>
    <tr>
    <td bgcolor=<%=tablebodycolor%> valign=middle colspan=2><font color="<%=TableContentColor%>">
    <b>通过邮件发送本帖子给您的朋友。</b>　下列所有项必填，并请输入正确的邮件地址！
    <br>你可以添加一些自己的信息在下面的内容框内。至于这个帖子的主题和 URL 你可以不必写，因为本程序会在发送的 Email 中自动添加的！</font>
        </td></tr>
    <tr>
    <td bgcolor=<%=tablebodycolor%>><font color="<%=TableContentColor%>"><b>您的姓名：</b></font></td>
    <td bgcolor=<%=tablebodycolor%>><input type=text size=40 name="postname"></td>
    </tr><tr>
    <td bgcolor=<%=atablebodycolor%>><font color="<%=TableContentColor%>"><b>您朋友的名字：</b></font></td>
    <td bgcolor=<%=atablebodycolor%>><input type=text size=40 name="incept"></td>
    </tr><tr>
    <td bgcolor=<%=tablebodycolor%>><font color="<%=TableContentColor%>"><b>您朋友的 Email：</b></font></td>
    <td bgcolor=<%=tablebodycolor%>><input type=text size=40 name="mail"></td>
    </tr><tr>
    <td bgcolor=<%=atablebodycolor%>><font color="<%=TableContentColor%>"><b>消息内容：</b></font></td>
    <td bgcolor=<%=atablebodycolor%>><textarea name="content" cols="55" rows="6">我想你对 '<%=ForumName%>' 的这个帖子内容会感兴趣的！请去看看！</textarea></td>
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
    <table cellpadding=0 cellspacing=0 border=0 width="95%" bgcolor=<%=tablebackcolor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
    <tr align="center"> 
      <td width="100%" bgcolor=<%=tabletitlecolor%>><font color="<%=TablefontColor%>">成功：发送页面</font></td>
    </tr>
    <tr> 
      <td width="100%" bgcolor=<%=tablebodycolor%>><font color="<%=TableContentColor%>">恭喜您，您的页面发送成功。</font>
      </td>
    </tr>
    <tr align="center"> 
      <td width="100%" bgcolor=<%=tabletitlecolor%>>
<a href="javascript:history.go(-1)"><font color="<%=TablefontColor%>"> << 返回上一页</font></a>
      </td>
    </tr>  
    </table>   </td></tr></table>
<%
end sub
	stats="发送页面"
%>
<!--#include file="footer.asp"-->
</BODY></HTML>
