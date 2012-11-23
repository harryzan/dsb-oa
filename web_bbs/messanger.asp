<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!-- #include file="chkuser.asp" -->
<!--#include file="inc/char.asp"-->
<!--#include file="inc/ubbcode.asp"-->
<html>
<head>
<title><%=ForumName%>--短消息</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<!--#include file="Forum_css.asp"-->
</head>
<body <%=ForumBody%>" onkeydown="if(event.keyCode==13 && event.ctrlKey)messager.submit()">
<%
	dim msg
	dim abgcolor
	dim usersign
	usersign=false
	set rs=server.createobject("adodb.recordset")

if membername="" then
  	errmsg=errmsg+"<br>"+"<li>您没有<a href=login.asp target=_blank>登录</a>。"
	founderr=true
else

end if

if founderr=true then
	call error()
else
	if request("action")="new" then
	call sendmsg()
	elseif request("action")="read" or request("action")="outread" then
	call read()
	elseif request("action")="delete" then
	call delete()
	elseif request("action")="send" then
	call savemsg()
	elseif request("action")="newmsg" then
	call newmsg()
	elseif request("action")="fw" then
	call fw()
	else
  	errmsg=errmsg+"<br>"+"<li>请指定正确的参数。"
	founderr=true
	end if
	if founderr then call error()
end if
'发送信息
sub sendmsg()
dim sendtime,title,content
if request("id")<>"" and isNumeric(request("id")) then
set rs=server.createobject("adodb.recordset")
sql="select sendtime,title,content from message where incept='"&membername&"' and id="&request("id")
rs.open sql,conn,1,1
if not(rs.eof and rs.bof) then
sendtime=rs("sendtime")
title="RE " & rs("title")
content=rs("content")
end if
rs.close
set rs=nothing
end if
%>
<form action="messanger.asp" method=post name=messager>
<input type=hidden name="action" value="send">
  <table cellpadding=0 cellspacing=0 border=0 width="<%=tablewidth%>" bgcolor=<%=Tablebackcolor%> align=center>
    <tr> 
      <td> 
        <table cellpadding=3 cellspacing=1 border=0 width=100%>
          <tr> 
            <td bgcolor=<%=Tabletitlecolor%> align=center colspan=3><font color="<%=TablefontColor%>"><b>发送短消息</b>（请输入完整信息）</font></td>
          </tr>
          <tr> 
            <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>"><b>收件人：</b><BR>使用逗号（,）分开，最多5位用户</font></td>
            <td bgcolor=<%=Tablebodycolor%> valign=middle>
              <input type=text name="touser" value="<%=request("touser")%>" size=20>
              <SELECT name=font onchange=DoTitle(this.options[this.selectedIndex].value)>
              <OPTION selected value="">选择</OPTION>
<%
set rs=server.createobject("adodb.recordset")
sql="select F_friend from Friend where F_username='"&membername&"' order by F_addtime desc"
rs.open sql,conn,1,1
do while not rs.eof
%>
			  <OPTION value="<%=rs(0)%>"><%=rs(0)%></OPTION> 
<%
rs.movenext
loop
rs.close
set rs=nothing
%>
			  </SELECT>
            </td>
          </tr>
          <tr> 
            <td bgcolor=<%=Tablebodycolor%> valign=top width=30%><font color="<%=TableContentColor%>"><b>标题：</b></font></td>
            <td bgcolor=<%=Tablebodycolor%> valign=middle>
              <input type=text name="title" size=36 maxlength=80>
            </td>
          </tr>
          <tr> 
            <td bgcolor=<%=Tablebodycolor%> valign=top width=30%><font color="<%=TableContentColor%>"><b>内容：</b><br>Ctrl+Enter发送</font></td>
            <td bgcolor=<%=Tablebodycolor%> valign=middle>
              <textarea cols=35 rows=6 name="message" title="Ctrl+Enter发送">
<%if request("id")<>"" then%>
====== 在 <%=sendtime%> 您来信中写道： ======
<%=content%>
==========================================
<%end if%>
			  </textarea>
            </td>
          </tr>
          <tr> 
            <td bgcolor=<%=Tabletitlecolor%> valign=middle colspan=2 align=center> 

              <input type=Submit value="发送" name=Submit>
              &nbsp; 
              <input type=Submit value="保存" name=Submit>
              &nbsp; 
              <input type="button" name="close" value="关闭" onclick="window.close">
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</form>
<%
end sub
'读取信息
sub read()
if request("id")="" or not isNumeric(request("id")) then
Errmsg=Errmsg+"<br>"+"<li>请指定相关参数。"
Founderr=true
exit sub
end if
	set rs=server.createobject("adodb.recordset")
	if request("action")="read" then
   	sql="update message set flag=1 where ID="&cstr(request("id"))
	conn.execute(sql)
	end if
	sql="select * from message where (incept='"&membername&"' or sender='"&membername&"') and id="&cstr(request("id"))
	rs.open sql,conn,1,1
	if rs.eof and rs.bof then
		errmsg=errmsg+"<br>"+"<li>你是不是跑到别人的信箱啦、或者该信息已经收件人删除。"
		founderr=true
	end if
	if not founderr then
%>
<table cellpadding=0 cellspacing=0 border=0 width="<%=tablewidth%>" bgcolor=<%=Tablebackcolor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
                
            <tr>
                <td bgcolor=<%=Tabletitlecolor%> align=center colspan=3><font color="<%=TablefontColor%>"><b>欢迎使用短消息接收，<%=membername%></b></font></td>
            </tr>
            <tr>
                <td bgcolor=<%=Tablebodycolor%> valign=middle align=center colspan=3><a href="messanger.asp?action=delete&id=<%=rs("id")%>"><img src="<%=picurl%>m_delete.gif" border=0 alt="删除消息"></a> &nbsp; <a href="messanger.asp?action=new"><img src="<%=picurl%>m_write.gif" border=0 alt="发送消息"></a> &nbsp;<a href="messanger.asp?action=new&touser=<%=htmlencode(rs("sender"))%>"><img src="<%=picurl%>m_reply.gif" border=0 alt="回复消息"></a>&nbsp;<a href="messanger.asp?action=fw&id=<%=request("id")%>"><img src=<%=picurl%>m_fw.gif border=0 alt=转发消息></a></td>
            </tr>
                <tr>
                    <td bgcolor=<%=Tabletitlecolor%>><font color="<%=TablefontColor%>">
<%if request("action")="outread" then%>
                    在<b><%=rs("sendtime")%></b>，您发送此消息给<b><%=htmlencode(rs("incept"))%></b>！
<%else%>
		    在<b><%=rs("sendtime")%></b>，<b><%=htmlencode(rs("sender"))%></b>给您发送的消息！
<%end if%></font></td>
                </tr>
                <tr>
                    <td bgcolor=<%=Tablebodycolor%> valign=top align=left><font color=<%=TableContentColor%>>
                    <b>消息标题：<%=htmlencode(rs("title"))%></b><hr size=1>
                    <%=ubbcode(rs("content"))%></font>
		    </td>
                </tr>
<%
rs.close
set rs=nothing
	sql="select id,sender from message where incept='"&membername&"' and flag=0 and issend=1 and id>"&cstr(request("id")&" order by sendtime")
	set rs=conn.execute(sql)
	if not (rs.eof and rs.bof) then
%>
                <tr>
                    <td bgcolor=<%=Tablebodycolor%> valign=top align=right><a href=messanger.asp?action=read&id=<%=rs(0)%>&sender=<%=rs(1)%>>[读取下一条信息]</a>
		    </td>
                </tr>
<%
end if
rs.close
set rs=nothing
%>
                </table></td></tr></table>
<%end if%>
<%
end sub
'转发信息
sub fw()
dim title,content,sender
if request("id")<>"" and isNumeric(request("id")) then
set rs=server.createobject("adodb.recordset")
sql="select title,content,sender from message where (incept='"&membername&"' or sender='"&membername&"') and id="&request("id")
rs.open sql,conn,1,1
if rs.eof and rs.bof then
Errmsg=Errmsg+"<br>"+"<li>请选择相关参数。"
Founderr=true
exit sub
else
title=rs("title")
content=rs("content")
sender=rs("sender")
end if
rs.close
set rs=nothing
end if
%>
<form action="messanger.asp" method=post name=messager>
  <table cellpadding=0 cellspacing=0 border=0 width=<%=tablewidth%> bgcolor=<%=Tablebackcolor%> align=center>
    <tr> 
      <td> 
        <table cellpadding=3 cellspacing=1 border=0 width=100%>
          <tr> 
            <td bgcolor=<%=Tabletitlecolor%> colspan=2 align=center> <font color="<%=TablefontColor%>">
              <input type=hidden name="action" value="send">
              <b>发送短消息</b>--请完整输入下列信息</font></td>
          </tr>
          <tr> 
            <td bgcolor=<%=Tablebodycolor%> valign=middle width=30%><font color="<%=TableContentColor%>"><b>收件人：</b><br>使用逗号（,）分开，最多5位用户</font></td>
            <td bgcolor=<%=Tablebodycolor%> valign=middle>
              <input type=text name="touser" value="<%=request("touser")%>" size=20>
              <SELECT name=font onchange=DoTitle(this.options[this.selectedIndex].value)>
              <OPTION selected value="">选择</OPTION>
<%
set rs=server.createobject("adodb.recordset")
sql="select F_friend from Friend where F_username='"&membername&"' order by F_addtime desc"
rs.open sql,conn,1,1
do while not rs.eof
%>
			  <OPTION value="<%=rs(0)%>"><%=rs(0)%></OPTION> 
<%
rs.movenext
loop
rs.close
set rs=nothing
%>
			  </SELECT>
            </td>
          </tr>
          <tr> 
            <td bgcolor=<%=Tablebodycolor%> valign=top><font color="<%=TableContentColor%>"><b>标题：</b><br>请限定50字内</font></td>
            <td bgcolor=<%=Tablebodycolor%> valign=middle>
              <input type=text name="title" size=36 maxlength=80 value="Fw：<%=title%>">&nbsp;
            </td>
          </tr>
          <tr> 
            <td bgcolor=<%=Tablebodycolor%> valign=top><font color="<%=TableContentColor%>"><b>内容：</b><br></font></td>
            <td bgcolor=<%=Tablebodycolor%> valign=middle>
              <textarea cols=35 rows=6 name="message" title="Ctrl+Enter发送">


========== 下面是转发信息 =========
原发件人：<%=sender%><%=chr(13)&chr(13)%>
<%=content%>
===================================</textarea>
            </td>
          </tr>
          <tr> 
            <td bgcolor=<%=Tabletitlecolor%> valign=middle colspan=2 align=center> 
              <input type=Submit value="发送" name=Submit>
              &nbsp; 
              <input type=Submit value="保存" name=Submit>
              &nbsp; 
              <input type="button" name="close" value="关闭" onclick="window.close">
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</form>
<%
end sub
sub savemsg()
	dim incept,title,message,subtype
	if request("touser")="" then
		errmsg=errmsg+"<br>"+"<li>您忘记填写发送对象了吧。"
		founderr=true
	else
		incept=CheckStr(request("touser"))
		incept=split(incept,",")
	end if
	if request("title")="" then
		errmsg=errmsg+"<br>"+"<li>您还没有填写标题呀。"
		founderr=true
	else
		title=CheckStr(request("title"))
	end if
	if request("message")="" then
		errmsg=errmsg+"<br>"+"<li>内容是必须要填写的噢。"
		founderr=true
	else
		message=CheckStr(request("message"))
	end if
	if not founderr then
		for i=0 to ubound(incept)
		set rs=server.createobject("adodb.recordset")
		sql="select username from [user] where username='"&replace(incept(i),"'","")&"'"
		rs.open sql,conn,1,1
		if rs.eof and rs.bof then
			errmsg=errmsg+"<br>"+"<li>论坛没有这个用户，看看你的发送对象写对了嘛？"
			founderr=true
		end if
		rs.close
		set rs=nothing

		if not founderr then
		if request("Submit")="发送" then
		sql="insert into message (incept,sender,title,content,sendtime,flag,issend) values ('"&incept(i)&"','"&membername&"','"&title&"','"&message&"',Now(),0,1)"
		subtype="已发送信息"
                elseif request("Submit")="保存" then
		sql="insert into message (incept,sender,title,content,sendtime,flag,issend) values ('"&incept(i)&"','"&membername&"','"&title&"','"&message&"',Now(),0,0)"
		subtype="发件箱"
		else
		sql="insert into message (incept,sender,title,content,sendtime,flag,issend) values ('"&incept(i)&"','"&membername&"','"&title&"','"&message&"',Now(),0,1)"
		subtype="已发送信息"
		end if
		conn.execute(sql)
			if i>4 then
			errmsg=errmsg+"<br>"+"<li>最多只能发送给5个用户，您的名单5位以后的请重新发送"
			founderr=true
			exit for
			end if
		end if
		next
		if not founderr then
		msg=msg+"<br>"+"<li><b>恭喜您，发送短信息成功。</b><br>发送的消息同时保存在您的"&subtype&"中。"
		call success()
		end if
	end if
end sub

sub success()
%>
    <table cellpadding=0 cellspacing=0 border=0 width=<%=tablewidth%> bgcolor=<%=Tablebackcolor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
    <tr align="center"> 
      <td width="100%" bgcolor=<%=Tabletitlecolor%>><font color="<%=TablefontColor%>">成功：短信息</font></td>
    </tr>
    <tr> 
      <td width="100%" bgcolor=<%=Tablebodycolor%>><font color="<%=TableContentColor%>"><%=msg%></font>
      </td>
    </tr>
    </table>   </td></tr></table>
<%
end sub

sub delete()
dim delid
delid=request("id")
if not isNumeric(request("id")) or delid="" or isnull(delid) then
Errmsg=Errmsg+"<li>"+"请选择相关参数。"
Founderr=true
else
	conn.execute("update message set delR=1 where incept='"&trim(membername)&"' and id="&delid)
	conn.execute("update message set delS=1 where sender='"&trim(membername)&"' and id="&delid)
	msg=msg+"<br>"+"<li><b>恭喜您，删除短信息成功。</b><br>删除的消息将置于您的回收站内。"
	call success()
end if
end sub

sub newmsg()
%>
    <table cellpadding=0 cellspacing=0 border=0 width=<%=tablewidth%> bgcolor=<%=aTablebackcolor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
    <tr align="center"> 
      <td width="100%" bgcolor=<%=Tabletitlecolor%>><font color="<%=TablefontColor%>">短消息通知</font></td>
    </tr>
    <tr> 
      <td width="100%" bgcolor=<%=Tablebodycolor%> align=center><br>
<font color="<%=TableContentColor%>"><a href=messanger.asp?action=inbox><img src="<%=picurl%>newmail.gif" border=0>有新的短消息</a><br>
                <br>
                <a href=messanger.asp?action=inbox>按此查看</a><br><br>
                </font>
      </td>
    </tr>
    <tr align="center"> 
      <td width="100%" bgcolor=<%=Tabletitlecolor%>>  
      </td>
    </tr>  
    </table>   </td></tr></table>
<%
end sub
set rs=nothing
stats="发送短信"
call endline()
%>
<script language="javascript">
function DoTitle(addTitle) { 
var revisedTitle; 
var currentTitle = document.messager.touser.value; 
revisedTitle = currentTitle+addTitle; 
document.messager.touser.value=revisedTitle; 
document.messager.touser.focus(); 
return; }
</script>
<!--#include file="footer.asp"-->