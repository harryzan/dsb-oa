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
    	Rem ------��ȡ����(get or post��)------
    	Rem ------���������ID��ҳ��------
	stats="��������"
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
   					errmsg=errmsg+"<br>"+"<li>����Email�д���</li>"
   					founderr=true
				else
					email=trim(Request.Form("mail"))
				end if
				if request("postname")="" then
   					errmsg=errmsg+"<br>"+"<li>����������������</li>"
   					founderr=true
				else
					postname=request("postname")
				end if
				if request("incept")="" then
   					errmsg=errmsg+"<br>"+"<li>�������ռ���������</li>"
   					founderr=true
				else
					incepts=request("incept")
				end if
				if request("content")="" then
   					errmsg=errmsg+"<br>"+"<li>�ʼ����ݲ���Ϊ�ա�</li>"
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
     	set rs=conn.execute("select topic from bbs1 where announceID="&rootID&"")
	if not(rs.bof and rs.eof) then
'		topic=rs("topic")
		topic="��������"&postname&"����������һ��"&ForumName&"�ϵ�����"
	else
		foundErr = true
		ErrMsg=ErrMsg+"<br>"+"<li>��ָ�������Ӳ�����</li>"
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
	mailbody=mailbody &"BODY   {	FONT-FAMILY: ����; FONT-SIZE: 9pt;}"
	mailbody=mailbody &"TD	   {	FONT-FAMILY: ����; FONT-SIZE: 9pt	}</style>"
	mailbody=mailbody &"<TABLE border=0 width='95%' align=center><TBODY><TR><TD>"
	mailbody=mailbody &""&incepts&"�����ã�<br><br>"
	mailbody=mailbody &"��������"&postname&"����������һ��"&ForumName&"--"&boardtype&"�ϵ�����<BR><br>"
	mailbody=mailbody &"�����ǣ�"&htmlencode(topic)&"<br><br>"
	mailbody=mailbody &""&htmlencode(content)&"<br><br>"
	mailbody=mailbody &"�����Ե�<a href=HTTP://WWW.DONGHAI-BRIDGE.COM.CN/club/dispbbs.asp?boardid="&boardid&"&rootid="&rootid&"&id="&Announceid&">"&topic&"</a>��������������<br>"
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
    <b>�����ʼ�������</b></font></td></tr>
    <tr>
    <td bgcolor=<%=tablebodycolor%> valign=middle colspan=2><font color="<%=TableContentColor%>">
    <b>ͨ���ʼ����ͱ����Ӹ��������ѡ�</b>������������������������ȷ���ʼ���ַ��
    <br>��������һЩ�Լ�����Ϣ����������ݿ��ڡ�����������ӵ������ URL ����Բ���д����Ϊ��������ڷ��͵� Email ���Զ���ӵģ�</font>
        </td></tr>
    <tr>
    <td bgcolor=<%=tablebodycolor%>><font color="<%=TableContentColor%>"><b>����������</b></font></td>
    <td bgcolor=<%=tablebodycolor%>><input type=text size=40 name="postname"></td>
    </tr><tr>
    <td bgcolor=<%=atablebodycolor%>><font color="<%=TableContentColor%>"><b>�����ѵ����֣�</b></font></td>
    <td bgcolor=<%=atablebodycolor%>><input type=text size=40 name="incept"></td>
    </tr><tr>
    <td bgcolor=<%=tablebodycolor%>><font color="<%=TableContentColor%>"><b>�����ѵ� Email��</b></font></td>
    <td bgcolor=<%=tablebodycolor%>><input type=text size=40 name="mail"></td>
    </tr><tr>
    <td bgcolor=<%=atablebodycolor%>><font color="<%=TableContentColor%>"><b>��Ϣ���ݣ�</b></font></td>
    <td bgcolor=<%=atablebodycolor%>><textarea name="content" cols="55" rows="6">������� '<%=ForumName%>' ������������ݻ����Ȥ�ģ���ȥ������</textarea></td>
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
    <table cellpadding=0 cellspacing=0 border=0 width="95%" bgcolor=<%=tablebackcolor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
    <tr align="center"> 
      <td width="100%" bgcolor=<%=tabletitlecolor%>><font color="<%=TablefontColor%>">�ɹ�������ҳ��</font></td>
    </tr>
    <tr> 
      <td width="100%" bgcolor=<%=tablebodycolor%>><font color="<%=TableContentColor%>">��ϲ��������ҳ�淢�ͳɹ���</font>
      </td>
    </tr>
    <tr align="center"> 
      <td width="100%" bgcolor=<%=tabletitlecolor%>>
<a href="javascript:history.go(-1)"><font color="<%=TablefontColor%>"> << ������һҳ</font></a>
      </td>
    </tr>  
    </table>   </td></tr></table>
<%
end sub
	stats="����ҳ��"
%>
<!--#include file="footer.asp"-->
</BODY></HTML>
