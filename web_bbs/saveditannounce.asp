<!--#include file="conn.asp"-->
<!-- #include file="inc/char.asp" -->
<!-- #include file="inc/char_board.asp" -->
<!-- #include file="inc/char_login.asp" -->
<!-- #include file="inc/chkinput.asp" -->
<!-- #include file="inc/const.asp" -->
<!-- #include file="chkuser.asp" -->
<!-- #include file="inc/theme.asp" -->
<% 
	dim announceid
	dim UserName
	dim userPassword
	dim useremail
	dim Topic
	dim body
	dim dateTimeStr
	dim ip
	dim Expression
	dim rootid
	dim signflag
	dim mailflag
	dim char_changed
	if  boardmaster or master then 
	char_changed = "[align=right][color=#000066][�������Ѿ���"&membername&"��"&Now()&"�༭��][/color][/align]"
	else
	char_changed = "[align=right][color=#000066][�������Ѿ���������"&Now()&"�༭��][/color][/align]"
	end if
   	UserName=trim(checkStr(request("username")))
   	UserPassWord=trim(request("passwd"))
   	IP=Request.ServerVariables("REMOTE_ADDR") 
   	Expression=Request.Form("Expression")&".gif"
   	BoardID=Request("boardID")
   	AnnounceID=Cstr(Request("ID"))
   	RootID=request("RootID")
   	Topic=trim(request("subject"))
   	Body=request("Content")+chr(13)+chr(10)+char_changed+chr(13)
	signflag=trim(request("signflag"))
	mailflag=trim(request("emailflag"))
	foundErr=false

	if founduser=false then
   		ErrMsg=ErrMsg+"<Br>"+"<li>���½������޸ġ�"
   		foundErr=True
	elseif membername<>username then
		if chkboardmaster(boardid)=false then
   		ErrMsg=ErrMsg+"<Br>"+"<li>������ϵͳ����Ա���߸ð������Ա��"
   		foundErr=True
		end if
	end if
	if signflag="yes" then
		signflag=1
	else
		signflag=0
	end if
	if mailflag="yes" then
		mailflag=1
	else
		mailflag=0
	end if
	dim rndnum,num1
	if instr(Expression,"face")=0 then
	Randomize
	Do While Len(rndnum)<1
	num1=CStr(Chr((57-48)*rnd+48))
	rndnum=rndnum&num1
	loop
	Expression="face" & rndnum & ".gif"
	end if
	if chkpost=false then
   		ErrMsg=ErrMsg+"<Br>"+"<li>���ύ�����ݲ��Ϸ����벻Ҫ���ⲿ�ύ���ԡ�"
   		FoundErr=True
	end if
	if AnnounceID="" then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>��ָ��������ӡ�"
	elseif not isInteger(AnnounceID) then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>�Ƿ������Ӳ�����"
	end if
	if UserName="" or strLength(UserName)>20 then
   		ErrMsg=ErrMsg+"<Br>"+"<li>����������(���Ȳ��ܴ���20)"
   		foundErr=True
	elseif Trim(UserPassWord)="" or strLength(UserPassWord)>16 then
   		ErrMsg=ErrMsg+"<Br>"+"<li>����������(���Ȳ��ܴ���16)"
   		foundErr=True
	end if
	if rootid=announceid then
	if Topic="" then
   		foundErr=True
      		ErrMsg=ErrMsg+"<Br>"+"<li>���ⲻӦΪ��"
	elseif strLength(topic)>100 then
   		foundErr=True
      		ErrMsg=ErrMsg+"<Br>"+"<li>���ⳤ�Ȳ��ܳ���100"
	end if
	end if
	if strLength(body)>AnnounceMaxBytes then
   		ErrMsg=ErrMsg+"<Br>"+"<li>�������ݲ��ô���" & CSTR(AnnounceMaxBytes) & "bytes"
   		foundErr=true
	end if
	stats=boardtype & "�༭���ӳɹ�"
	if foundErr=true then
		call nav()
		call headline(2)
   		call Error()
		call endline()
	else
		call nav()
		call headline(2)
		call saveedit()
	end if
	sub saveedit()
         	DateTimeStr=CSTR(NOW()+TIMEADJUST/24)
	     	Set rs = Server.CreateObject("ADODB.Recordset")
         	sql="SELECT *, UserName FROM bbs1 where username='"&trim(username)&"' and AnnounceID="&AnnounceID
  	     	rs.Open sql,conn,1,3
		if rs.eof then
			response.write"<script language=Javascript>"
			response.write"alert('���������Ǳ����ӵ����ߣ���Ȩ�޸ģ���');"
			response.write"location.href = 'javascript:history.back()'"
			response.write"</script>"
			set rs=nothing
    			response.end()
		elseif not master and rs("locktopic")=1 then
			Errmsg=ErrMsg+"<Br>"+"<li>�������Ѿ����������ܱ༭��"
			foundErr=true
			call error()
		else
	     		rs("Topic") =Topic
	     		rs("Body") =Body
	     		rs("DateAndTime") =DateTimeStr
	     		rs("length")=strlength(body)
         		rs("ip")=ip
         		rs("Expression")=Expression
         		rs("signflag")=signflag
         		rs("emailflag")=mailflag
	     		rs.Update
  	     		if err.number<>0 then
	       			err.clear
		   		ErrMsg=ErrMsg+"<Br>"+"<li>���ݿ����ʧ�ܣ����Ժ�����"&err.Description 
  	       			call Error()
	     		else
 	    		rs.close
	    		call success()
    			end if
  		end if
	end sub
	sub success()
	response.write "<meta http-equiv=refresh content=""4;URL=list.asp?boardid="&boardid&""">"

	response.write "<br><table cellpadding=0 cellspacing=0 border=0 width="&tablewidth&" bgcolor="&tablebackcolor&" align=center>"&_
		"<tr><td><table cellpadding=3 cellspacing=1 border=0 width=""100%"">"&_
		"<tr align=center><td width=""100%"" bgcolor="&tabletitlecolor&"><b><FONT COLOR="&TableFontcolor&">״̬�����������ӳɹ�</font></b></td>"&_
		"</tr><tr><td width=""100%"" bgcolor="&tablebodycolor&">"&_
		"<FONT COLOR="&TableContentcolor&">��ҳ�潫��3����Զ������������������ҳ�棬<b>������ѡ�����²�����</b><br><ul>"&_
		"<li><a href=""index.asp""><font color="""&TableContentcolor&""">������ҳ</font></a></li>"&_
		"<li><a href=""list.asp?boardid="&boardid&"""><font color="""&TableContentcolor&""">"&boardtype&"</font></a></li>"&_
		"</ul></td></tr></table></td></tr></table>"
		call endline()
	end sub
%>
<!--#include file="footer.asp"-->
