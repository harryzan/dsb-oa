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
	stats="����ʵ�"
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
   					errmsg=errmsg+"<br>"+"<li>����Email�д���!</li>"
   					founderr=true
				else
					email=trim(Request.Form("mail"))
				end if
				call announceinfo()
				if founderr then
					call Error()
				else
					if EmailFlag=0 then
						errmsg=errmsg+"<br>"+"<li>����̳��֧�ַ����ʼ���</li>"
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
		ErrMsg=ErrMsg+"<br>"+"<li>��ָ������̳���治����</li>"
		exit sub
	end if
	rs.close
	'Rs.open "Select topic from bbs1 Where announceID="&AnnounceID&"",conn,1,1
     	set rs=conn.execute("select topic from bbs1 where announceID="&rootID&"")
	if not(rs.bof and rs.eof) then
		topic=rs("topic")
	else
		foundErr = true
		ErrMsg=ErrMsg+"<br>"+"<li>��ָ�������Ӳ�����</li>"
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
	mailbody=mailbody &"BODY   {	FONT-FAMILY: ����; FONT-SIZE: 9pt;}"
	mailbody=mailbody &"TD	   {	FONT-FAMILY: ����; FONT-SIZE: 9pt	}</style>"
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
	announce=announce &"--&nbsp;&nbsp;���ߣ�"&rs("username")&"<br>"
	announce=announce &"--&nbsp;&nbsp;����ʱ�䣺"&rs("dateandtime")&"<br><br>"
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
    <b>����ʵ�</b></font></td></tr>
    <tr>
    <td bgcolor=<%=tablebodycolor%> valign=middle colspan=2><font color="<%=TableContentColor%>">
    <b>�ѱ�������ʵݡ�</b><br>����ȷ������Ҫ�ʵݵ��ʼ���ַ��</font>
        </td></tr><tr>
    
    <td bgcolor=<%=atablebodycolor%>><font color="<%=TableContentColor%>"><b>�ʵݵ� Email ��ַ��</b></font></td>
    <td bgcolor=<%=atablebodycolor%>><input type=text size=40 name="mail"></td>
    </tr><tr>
    <td colspan=2 bgcolor=<%=tabletitlecolor%> align=center><input type=submit value="�� ��" name="Submit"></table></td></form></tr></table>
<%
	end sub
    
    	sub chkInput
	if request("boardid")="" then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>��ָ����̳���档"
	elseif not isInteger(request("boardid")) then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>�Ƿ��İ��������"
	else
		boardid=request("boardid")
	end if
	if request("id")="" then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>��ָ��������ӡ�"
	elseif not isInteger(request("id")) then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>�Ƿ������Ӳ�����"
	else
		AnnounceID=request("id")
	end if
	if request("RootID")="" then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>��ָ��������ӡ�"
	elseif not isInteger(request("RootID")) then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>�Ƿ������Ӳ�����"
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
      <td width="100%" bgcolor=<%=tabletitlecolor%>><font color="<%=TablefontColor%>">�ɹ�������ʵ�</font></td>
    </tr>
    <tr> 
      <td width="100%" bgcolor=<%=tablebodycolor%>><font color="<%=TableContentColor%>">��ϲ�������Ĵ���ʵݷ��ͳɹ���</font>
      </td>
    </tr>
    <tr align="center"> 
      <td width="100%" bgcolor=<%=tabletitlecolor%>>
<a href="javascript:history.go(-1)"> << ������һҳ</a>
      </td>
    </tr>  
    </table>   </td></tr></table>
<%
end sub
%>
<!--#include file="footer.asp"-->
