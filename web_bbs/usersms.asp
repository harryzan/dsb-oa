<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!-- #include file="chkuser.asp" -->
<!--#include file="inc/char.asp"-->
<!--#include file="inc/theme.asp"-->
<!--#include file="inc/ubbcode.asp"-->
<%Response.Buffer = true%>
<html>
<head>
<title><%=ForumName%>--短消息</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<!--#include file=forum_css.asp-->
<script language="javascript">
function DoTitle(addTitle) { 
var revisedTitle; 
var currentTitle = document.messager.touser.value; 
revisedTitle = currentTitle+addTitle; 
document.messager.touser.value=revisedTitle; 
document.messager.touser.focus(); 
return; }
</script>
</head>
<body <%=Forumbody%>>
<%
	dim usersign
	usersign=false
	dim abgcolor
	dim msg
if not founduser then
  	errmsg=errmsg+"<br>"+"<li>您没有<a href=login.asp target=_blank>登录</a>。"
	founderr=true
else

end if
call nav()
response.write "<TABLE border=0 width="&tablewidth&" align=center><TBODY>"&_
				"<TR><TD align=left><a href='"& HostURL &"'><img border=0 src='"& Forumlogo &"'></a></TD>"&_
				"<TD Align=right>  <a href=usersms.asp?action=inbox><img src=pic/m_inbox.gif border=0 alt=收件箱></a> &nbsp; <a href=usersms.asp?action=outbox><img src=pic/M_outbox.gif border=0 alt=发件箱></a> &nbsp; <a href=usersms.asp?action=issend><img src=pic/M_issend.gif border=0 alt=已发送邮件></a>&nbsp; <a href=usersms.asp?action=recycle><img src=pic/M_recycle.gif border=0 alt=废件箱></a>&nbsp; <a href=friendlist.asp><img src=pic/M_address.gif border=0 alt=地址簿></a>&nbsp;<a href=usersms.asp?action=new&id=><img src=pic/m_write.gif border=0 alt=发送消息></a> &nbsp;<a href=usersms.asp?action=new&touser="&htmlencode(request("sender"))&"&id="&request("id")&"><img src=pic/m_reply.gif border=0 alt=回复消息></a> &nbsp;<a href=usersms.asp?action=fw&id="&request("id")&"><img src=pic/m_fw.gif border=0 alt=转发消息></a>&nbsp;<a href=usersms.asp?action=deletmsg&id="&request("id")&"><img src=pic/m_delete.gif border=0 alt=删除消息></a>"&_
				"</TD></TR></TBODY></TABLE><br>"
if founderr=true then
	call error()
else
	select case request("action")
	case "inbox"
		call inbox()
	case "outbox"
		call outbox()
	case "issend"
		call issend()
	case "recycle"
		call recycle()
	case "new"
		call sendmsg()
	case "read"
		call read()
	case "outread"
		call read()
	case "deletmsg"
		call delete()
	case "send"
		call savemsg()
	case "newmsg"
		call newmsg()
	case "fw"
		call fw()
	case "edit"
		call edit()
	case "savedit"
		call savedit()
	case "删除收件"
		call delinbox()
	case "清空收件箱"
		call AllDelinbox()
	case "删除发件"
		call deloutbox()
	case "清空发件箱"
		call AllDeloutbox()
	case "删除已发信息"
		call delissend()
	case "清空已发送信息"
		call AllDelissend()
	case "删除指定信息"
		call delrecycle()
	case "清空回收站"
		call AllDelrecycle()
	case else
		call inbox()
	end select
	if founderr then call error()
end if
'收件箱
sub inbox()
%>
<form action="usersms.asp" method=post name=inbox>
    <table cellpadding=0 cellspacing=0 border=0 width=<%=TableWidth%> bgcolor=<%=Tablebackcolor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
            <tr bgcolor=<%=Tabletitlecolor%>>
                <td align=center valign=middle width=30><font color="<%=TableFontColor%>"><b>已读</b></font></td>
                <td align=center valign=middle width=100><font color="<%=TableFontColor%>"><b>发件人</b></font></td>
                <td align=center valign=middle width=300><font color="<%=TableFontColor%>"><b>主题</b></font></td>
                <td align=center valign=middle width=150><font color="<%=TableFontColor%>"><b>日期</b></font></td>
                <td align=center valign=middle width=50><font color="<%=TableFontColor%>"><b>大小</b></font></td>
                <td align=center valign=middle width=30><font color="<%=TableFontColor%>"><b>操作</b></font></td>
            </tr>
<%
	set rs=server.createobject("adodb.recordset")
	sql="select * from message where incept='"&trim(membername)&"' and issend=1 and delR=0 order by flag,sendtime desc"
	rs.open sql,conn,1,1
	if rs.eof and rs.bof then
%>
                <tr>
                <td bgcolor=<%=Tablebodycolor%> align=center valign=middle colspan=6><font color="<%=TableContentColor%>">您的收件箱中没有任何内容。</font></td>
                </tr>
<%else%>
<%do while not rs.eof%>
                <tr bgcolor=<%if rs("flag")=0 then%>"<%=aTablebodycolor%>"<%else%>"<%=Tablebodycolor%>"<%end if%>>
                    <td align=center valign=middle><%if rs("flag")=0 then%><img src="pic/m_news.gif"><%else%><img src="<%=picurl%>m_olds.gif"><%end if%></td>
                    <td align=center valign=middle><%if rs("flag")=0 then%><b><%end if%><a href="dispuser.asp?name=<%=htmlencode(rs("sender"))%>" target=_blank><%=htmlencode(rs("sender"))%></a></td>
                    <td align=left><a href="usersms.asp?action=read&id=<%=rs("id")%>&sender=<%=rs("sender")%>"><%if rs("flag")=0 then%><b><%end if%><%=htmlencode(rs("title"))%></a>	</td>
                    <td><font color="<%=TableContentColor%>"><%if rs("flag")=0 then%><b><%end if%><%=rs("sendtime")%></font></td>
                    <td><font color="<%=TableContentColor%>"><%if rs("flag")=0 then%><b><%end if%><%=len(rs("content"))%>Byte</font></td>
                <td align=center valign=middle width=30><input type=checkbox name=id value=<%=rs("id")%>></td>
                </tr>
<%
	rs.movenext
	loop
	end if
	rs.close
	set rs=nothing
%>
                
        <tr bgcolor="<%=Tabletitlecolor%>"> 
          <td align=right valign=middle colspan=6><font color="<%=TablefontColor%>">节省每一分空间，请及时删除无用信息&nbsp;<input type=checkbox name=chkall value=on onclick="CheckAll(this.form)">选中所有显示记录&nbsp;<input type=submit name=action onclick="{if(confirm('确定删除选定的纪录吗?')){this.document.inbox.submit();return true;}return false;}" value="删除收件">&nbsp;<input type=submit name=action onclick="{if(confirm('确定清除收件箱所有的纪录吗?')){this.document.inbox.submit();return true;}return false;}" value="清空收件箱"></font></td>
                </tr>
                </table></td></tr></table></form>
<%
end sub
'收件逻辑删除，置于回收站，入口字段delR，可用于批量及单个删除
sub delinbox()
dim delid
delid=replace(request("id"),"'","")
if delid="" or isnull(delid) then
Errmsg=Errmsg+"<li>"+"请选择相关参数。"
Founderr=true
else
	conn.execute("update message set delR=1 where incept='"&trim(membername)&"' and id in ("&delid&")")
	msg=msg+"<br>"+"<li><b>恭喜您，删除短信息成功。</b><br>删除的消息将转移到您的回收站。"
	call success()
end if
end sub
sub AllDelinbox()
	conn.execute("update message set delR=1 where incept='"&trim(membername)&"' and delR=0")
	msg=msg+"<br>"+"<li><b>恭喜您，删除短信息成功。</b><br>删除的消息将转移到您的回收站。"
	call success()
end sub

'发件箱
sub outbox()
%>
<form action="usersms.asp" method=post name=inbox>
    <table cellpadding=0 cellspacing=0 border=0 width=<%=TableWidth%> bgcolor=<%=Tablebackcolor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
            <tr bgcolor=<%=Tabletitlecolor%>>
                <td align=center valign=middle width=30><font color="<%=TableFontColor%>"><b>已读</b></font></td>
                <td align=center valign=middle width=100><font color="<%=TableFontColor%>"><b>收件人</b></font></td>
                <td align=center valign=middle width=300><font color="<%=TableFontColor%>"><b>主题</b></font></td>
                <td align=center valign=middle width=150><font color="<%=TableFontColor%>"><b>日期</b></font></td>
                <td align=center valign=middle width=50><font color="<%=TableFontColor%>"><b>大小</b></font></td>
                <td align=center valign=middle width=30><font color="<%=TableFontColor%>"><b>操作</b></font></td>
            </tr>
<%
	set rs=server.createobject("adodb.recordset")
	sql="select * from message where sender='"&trim(membername)&"' and issend=0 and delS=0 order by sendtime desc"
	rs.open sql,conn,1,1
	if rs.eof and rs.bof then
%>
                <tr>
                <td bgcolor=<%=Tablebodycolor%> align=center valign=middle colspan=6><font color="<%=TableContentColor%>">您的发件箱中没有任何内容。</font></td>
                </tr>
<%else%>
<%do while not rs.eof%>
                <tr bgcolor=<%if rs("flag")=0 then%>"<%=aTablebodycolor%>"<%else%>"<%=Tablebodycolor%>"<%end if%>>
                    <td align=center valign=middle><img src="<%=picurl%>m_issend_2.gif"></td>
                    <td align=center valign=middle><%if rs("flag")=0 then%><b><%end if%><a href="dispuser.asp?name=<%=htmlencode(rs("incept"))%>" target=_blank><%=htmlencode(rs("incept"))%></a></td>
                    <td align=left><a href="usersms.asp?action=edit&id=<%=rs("id")%>"><%if rs("flag")=0 then%><b><%end if%><%=htmlencode(rs("title"))%></a>	</td>
                    <td><font color="<%=TableContentColor%>"><%if rs("flag")=0 then%><b><%end if%><%=rs("sendtime")%></font></td>
                    <td><font color="<%=TableContentColor%>"><%if rs("flag")=0 then%><b><%end if%><%=len(rs("content"))%>Byte</font></td>
                <td align=center valign=middle width=30><input type=checkbox name=id value=<%=rs("id")%>></td>
                </tr>
<%
	rs.movenext
	loop
	end if
	rs.close
	set rs=nothing
%>
                
        <tr bgcolor="<%=Tabletitlecolor%>"> 
          <td align=right valign=middle colspan=6><font color="<%=TablefontColor%>">节省每一分空间，请及时删除无用信息&nbsp;<input type=checkbox name=chkall value=on onclick="CheckAll(this.form)">选中所有显示记录&nbsp;<input type=submit name=action onclick="{if(confirm('确定删除选定的纪录吗?')){this.document.inbox.submit();return true;}return false;}" value="删除发件">&nbsp;<input type=submit name=action onclick="{if(confirm('确定清除发件箱所有的纪录吗?')){this.document.inbox.submit();return true;}return false;}" value="清空发件箱"></font></td>
                </tr>
                </table></td></tr></table></form>
<%
end sub
'发件逻辑删除，置于回收站，入口字段delS，可用于批量及单个删除
sub deloutbox()
dim delid
delid=replace(request("id"),"'","")
if delid="" or isnull(delid) then
Errmsg=Errmsg+"<li>"+"请选择相关参数。"
Founderr=true
else
	conn.execute("update message set delS=1 where sender='"&trim(membername)&"' and issend=0 and id in ("&delid&")")
	msg=msg+"<br>"+"<li><b>恭喜您，删除短信息成功。</b><br>删除的消息将转移到您的回收站。"
	call success()
end if
end sub
sub AllDeloutbox()
	conn.execute("update message set delS=1 where sender='"&trim(membername)&"' and delS=0 and issend=0")
	msg=msg+"<br>"+"<li><b>恭喜您，删除短信息成功。</b><br>删除的消息将转移到您的回收站。"
	call success()
end sub

'已发送信息
sub issend()
%>
<form action="usersms.asp" method=post name=inbox>
    <table cellpadding=0 cellspacing=0 border=0 width=<%=TableWidth%> bgcolor=<%=Tablebackcolor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
            <tr bgcolor=<%=Tabletitlecolor%>>
                <td align=center valign=middle width=30><font color="<%=TableFontColor%>"><b>已读</b></font></td>
                <td align=center valign=middle width=100><font color="<%=TableFontColor%>"><b>收件人</b></font></td>
                <td align=center valign=middle width=300><font color="<%=TableFontColor%>"><b>主题</b></font></td>
                <td align=center valign=middle width=150><font color="<%=TableFontColor%>"><b>日期</b></font></td>
                <td align=center valign=middle width=50><font color="<%=TableFontColor%>"><b>大小</b></font></td>
                <td align=center valign=middle width=30><font color="<%=TableFontColor%>"><b>操作</b></font></td>
            </tr>
<%
	set rs=server.createobject("adodb.recordset")
	sql="select * from message where sender='"&trim(membername)&"' and issend=1 and delS=0 order by sendtime desc"
	rs.open sql,conn,1,1
	if rs.eof and rs.bof then
%>
                <tr>
                <td bgcolor=<%=Tablebodycolor%> align=center valign=middle colspan=6><font color="<%=TableContentColor%>">您的已发送信息中没有任何内容。</font></td>
                </tr>
<%else%>
<%do while not rs.eof%>
                <tr bgcolor=<%if rs("flag")=0 then%>"<%=aTablebodycolor%>"<%else%>"<%=Tablebodycolor%>"<%end if%>>
                    <td align=center valign=middle><img src="<%=picurl%>m_issend_1.gif"></td>
                    <td align=center valign=middle><%if rs("flag")=0 then%><b><%end if%><a href="dispuser.asp?name=<%=htmlencode(rs("incept"))%>" target=_blank><%=htmlencode(rs("incept"))%></a></td>
                    <td align=left><a href="usersms.asp?action=outread&id=<%=rs("id")%>"><%if rs("flag")=0 then%><b><%end if%><%=htmlencode(rs("title"))%></a>	</td>
                    <td><font color="<%=TableContentColor%>"><%if rs("flag")=0 then%><b><%end if%><%=rs("sendtime")%></font></td>
                    <td><font color="<%=TableContentColor%>"><%if rs("flag")=0 then%><b><%end if%><%=len(rs("content"))%>Byte</font></td>
                <td align=center valign=middle width=30><input type=checkbox name=id value=<%=rs("id")%>></td>
                </tr>
<%
	rs.movenext
	loop
	end if
	rs.close
	set rs=nothing
%>
                
        <tr bgcolor="<%=Tabletitlecolor%>"> 
          <td align=right valign=middle colspan=6><font color="<%=TablefontColor%>">节省每一分空间，请及时删除无用信息&nbsp;<input type=checkbox name=chkall value=on onclick="CheckAll(this.form)">选中所有显示记录&nbsp;<input type=submit name=action onclick="{if(confirm('确定删除选定的纪录吗?')){this.document.inbox.submit();return true;}return false;}" value="删除已发信息">&nbsp;<input type=submit name=action onclick="{if(confirm('确定清除已发送信息所有的纪录吗?')){this.document.inbox.submit();return true;}return false;}" value="清空已发送信息"></font></td>
                </tr>
                </table></td></tr></table></form>
<%
end sub
'已发送逻辑删除，置于回收站，入口字段delS，可用于批量及单个删除
'delS：0未操作，1发送者删除，2发送者从回收站删除
sub delissend()
dim delid
delid=replace(request("id"),"'","")
if delid="" or isnull(delid) then
Errmsg=Errmsg+"<li>"+"请选择相关参数。"
Founderr=true
else
	conn.execute("update message set delS=1 where sender='"&trim(membername)&"' and issend=1 and id in ("&delid&")")
	msg=msg+"<br>"+"<li><b>恭喜您，删除短信息成功。</b><br>删除的消息将转移到您的回收站。"
	call success()
end if
end sub
sub AllDelissend()
	conn.execute("update message set delS=1 where sender='"&trim(membername)&"' and delS=0 and issend=1")
	msg=msg+"<br>"+"<li><b>恭喜您，删除短信息成功。</b><br>删除的消息将转移到您的回收站。"
	call success()
end sub
'回收站
sub recycle()
%>
<form action="usersms.asp" method=post name=inbox>
    <table cellpadding=0 cellspacing=0 border=0 width=<%=TableWidth%> bgcolor=<%=Tablebackcolor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
            <tr bgcolor=<%=Tabletitlecolor%>>
                <td align=center valign=middle width=30><font color="<%=TableFontColor%>"><b>已读</b></font></td>
                <td align=center valign=middle width=100><font color="<%=TableFontColor%>"><b>名字</b></font></td>
                <td align=center valign=middle width=300><font color="<%=TableFontColor%>"><b>主题</b></font></td>
                <td align=center valign=middle width=150><font color="<%=TableFontColor%>"><b>日期</b></font></td>
                <td align=center valign=middle width=50><font color="<%=TableFontColor%>"><b>大小</b></font></td>
                <td align=center valign=middle width=30><font color="<%=TableFontColor%>"><b>操作</b></font></td>
            </tr>
<%
	set rs=server.createobject("adodb.recordset")
	sql="select * from message where ((sender='"&trim(membername)&"' and delS=1) or (incept='"&trim(membername)&"' and delR=1)) and not delS=2 order by sendtime desc"
	rs.open sql,conn,1,1
	if rs.eof and rs.bof then
%>
                <tr>
                <td bgcolor=<%=Tablebodycolor%> align=center valign=middle colspan=6><font color="<%=TableContentColor%>">您的废件箱中没有任何内容。</font></td>
                </tr>
<%else%>
<%do while not rs.eof%>
                <tr bgcolor=<%if rs("flag")=0 then%>"<%=aTablebodycolor%>"<%else%>"<%=Tablebodycolor%>"<%end if%>>
                    <td align=center valign=middle><font face="宋体" color="#333333"><%if rs("flag")=0 then%><img src="pic/m_news.gif"><%else%><img src="pic/m_olds.gif"><%end if%></font></td>
                    <td align=center valign=middle><%if rs("flag")=0 then%><b><%end if%><a href="dispuser.asp?name=<%=htmlencode(rs("incept"))%>" target=_blank><%=htmlencode(rs("incept"))%></a></td>
                    <td align=left><a href="usersms.asp?action=read&id=<%=rs("id")%>"><%if rs("flag")=0 then%><b><%end if%><%=htmlencode(rs("title"))%></a>	</td>
                    <td><font color="<%=TableContentColor%>"><%if rs("flag")=0 then%><b><%end if%><%=rs("sendtime")%></font></td>
                    <td><font color="<%=TableContentColor%>"><%if rs("flag")=0 then%><b><%end if%><%=len(rs("content"))%>Byte</font></td>
                <td align=center valign=middle width=30><input type=checkbox name=id value=<%=rs("id")%>></td>
                </tr>
<%
	rs.movenext
	loop
	end if
	rs.close
	set rs=nothing
%>
                
        <tr bgcolor="<%=Tabletitlecolor%>"> 
          <td align=right valign=middle colspan=6><font color="<%=TablefontColor%>">节省每一分空间，请及时删除无用信息&nbsp;<input type=checkbox name=chkall value=on onclick="CheckAll(this.form)">选中所有显示记录&nbsp;<input type=submit name=action onclick="{if(confirm('确定删除选定的纪录吗?')){this.document.inbox.submit();return true;}return false;}" value="删除指定信息">&nbsp;<input type=submit name=action onclick="{if(confirm('确定清除回收站所有的纪录吗?')){this.document.inbox.submit();return true;}return false;}" value="清空回收站"></font></td>
                </tr>
                </table></td></tr></table></form>
<%
end sub
'用户能完全删除收到信息和逻辑删除所发送信息，逻辑删除所发送信息设置入口字段delS参数为2
sub delrecycle()
dim delid
delid=replace(request("id"),"'","")
'response.write delid
if delid="" or isnull(delid) then
Errmsg=Errmsg+"<li>"+"请选择相关参数。"
Founderr=true
exit sub
else
	conn.execute("delete from message where incept='"&membername&"' and delR=1 and id in ("&delid&")")
	conn.execute("update message set delS=2 where sender='"&trim(membername)&"' and delS=1 and id in ("&delid&")")
	msg=msg+"<br>"+"<li><b>恭喜您，删除短信息成功。</b><br>删除的消息将不可恢复。"
	call success()
end if
end sub
sub AllDelrecycle()
	conn.execute("delete from message where incept='"&membername&"' and delR=1")	
	conn.execute("update message set delS=2 where sender='"&trim(membername)&"' and delS=1")
	msg=msg+"<br>"+"<li><b>恭喜您，删除短信息成功。</b><br>删除的消息将不可恢复。"
	call success()
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
'发送信息
sub sendmsg()
dim title,content,sendtime
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
<form action="usersms.asp" method=post name=messager>
  <table cellpadding=0 cellspacing=0 border=0 width=<%=TableWidth%> bgcolor=<%=Tablebackcolor%> align=center>
    <tr> 
      <td> 
        <table cellpadding=3 cellspacing=1 border=0 width=100%>
          <tr> 
            <td bgcolor=<%=Tabletitlecolor%> colspan=2 align=center> 
              <input type=hidden name="action" value="send">
              <font color="<%=TablefontColor%>"><b>发送短消息</b>--请完整输入下列信息</font></td>
          </tr>
          <tr> 
            <td bgcolor=<%=Tablebodycolor%> valign=middle width=70><font color="<%=TableContentColor%>"><b>收件人：</b></font></td>
            <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>">
              <input type=text name="touser" value="<%=request("touser")%>" size=50>
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
			  &nbsp;使用逗号（,）分开，最多5位用户</font>
            </td>
          </tr>
          <tr> 
            <td bgcolor=<%=Tablebodycolor%> valign=top><font color="<%=TableContentColor%>"><b>标题：</b></font></td>
            <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>">
              <input type=text name="title" size=50 maxlength=80 value="<%=title%>">&nbsp;请限定50字内</font>
            </td>
          </tr>
          <tr> 
            <td bgcolor=<%=Tablebodycolor%> valign=top><font color="<%=TableContentColor%>"><b>内容：</b><br></font></td>
            <td bgcolor=<%=Tablebodycolor%> valign=middle>
              <textarea cols=70 rows=8 name="message" title="">

<%if request("id")<>"" then%>
============= 在 <%=sendtime%> 您来信中写道： ============
<%=content%>
========================================================<%end if%></textarea>
            </td>
          </tr>
          <tr> 
            <td bgcolor=<%=Tabletitlecolor%> valign=middle colspan=2 align=center> 
              <input type=Submit value="发送" name=Submit>
              &nbsp; 
              <input type=Submit value="保存" name=Submit>
              &nbsp; 
              <input type="reset" name="Clear" value="清除">
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</form>
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
<form action="usersms.asp" method=post name=messager>
  <table cellpadding=0 cellspacing=0 border=0 width=<%=TableWidth%> bgcolor=<%=Tablebackcolor%> align=center>
    <tr> 
      <td> 
        <table cellpadding=3 cellspacing=1 border=0 width=100%>
          <tr> 
            <td bgcolor=<%=Tabletitlecolor%> colspan=2 align=center> 
              <input type=hidden name="action" value="send">
              <font color="<%=TablefontColor%>"><b>发送短消息</b>--请完整输入下列信息</font></td>
          </tr>
          <tr> 
            <td bgcolor=<%=Tablebodycolor%> valign=middle width=70><font color="<%=TableContentColor%>"><b>收件人：</b></font></td>
            <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>">
              <input type=text name="touser" value="<%=request("touser")%>" size=50>&nbsp;使用逗号（,）分开，最多5位用户</font>
            </td>
          </tr>
          <tr> 
            <td bgcolor=<%=Tablebodycolor%> valign=top><font color="<%=TableContentColor%>"><b>标题：</b></font></td>
            <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>">
              <input type=text name="title" size=50 maxlength=80 value="Fw：<%=title%>">&nbsp;请限定50字内</font>
            </td>
          </tr>
          <tr> 
            <td bgcolor=<%=Tablebodycolor%> valign=top><font color="<%=TableContentColor%>"><b>内容：</b><br></font></td>
            <td bgcolor=<%=Tablebodycolor%> valign=middle>
              <textarea cols=70 rows=8 name="message" title="">


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
              <input type="reset" name="Clear" value="清除">
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</form>
<%
end sub
'更改信息
sub edit()
dim incept,title,content,id
if request("id")<>"" or isNumeric(request("id")) then
	set rs=server.createobject("adodb.recordset")
sql="select id,incept,title,content from message where sender='"&membername&"' and issend=0 and id="&request("id")
rs.open sql,conn,1,1
if not(rs.eof and rs.bof) then
incept=rs("incept")
title=rs("title")
content=rs("content")
id=rs("id")
else
Errmsg=Errmsg+"<br>"+"<li>没有找到您要编辑的信息。"
Founderr=true
exit sub
end if
rs.close
set rs=nothing
else
Errmsg=Errmsg+"<br>"+"<li>请指定相关参数。"
Founderr=true
exit sub
end if
%>
<form action="usersms.asp" method=post name=messager>
  <table cellpadding=0 cellspacing=0 border=0 width=<%=TableWidth%> bgcolor=<%=Tablebackcolor%> align=center>
    <tr> 
      <td> 
        <table cellpadding=3 cellspacing=1 border=0 width=100%>
          <tr> 
            <td bgcolor=<%=Tabletitlecolor%> colspan=2 align=center> 
              <input type=hidden name="action" value="savedit"> 
              <input type=hidden name="id" value="<%=id%>">
              <font color="<%=TablefontColor%>"><b>发送短消息</b>--请完整输入下列信息</font></td>
          </tr>
          <tr> 
            <td bgcolor=<%=Tablebodycolor%> valign=middle width=70><font color="<%=TableContentColor%>"><b>收件人：</b></font></td>
            <td bgcolor=<%=Tablebodycolor%> valign=middle>
              <input type=text name="touser" value="<%=incept%>" size=70>
            </td>
          </tr>
          <tr> 
            <td bgcolor=<%=Tablebodycolor%> valign=top><font color="<%=TableContentColor%>"><b>标题：</b></font></td>
            <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>">
              <input type=text name="title" size=70 maxlength=80 value="<%=title%>">&nbsp;请限定50字内</font>
            </td>
          </tr>
          <tr> 
            <td bgcolor=<%=Tablebodycolor%> valign=top><font color="<%=TableContentColor%>"><b>内容：</b><br></font></td>
            <td bgcolor=<%=Tablebodycolor%> valign=middle>
              <textarea cols=70 rows=8 name="message" title=""><%=content%></textarea>
            </td>
          </tr>
          <tr> 
            <td bgcolor=<%=Tabletitlecolor%> valign=middle colspan=2 align=center> 
              <input type=Submit value="发送" name=Submit>
              &nbsp; 
              <input type=Submit value="保存" name=Submit>
              &nbsp; 
              <input type="reset" name="Clear" value="清除">
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
<table cellpadding=0 cellspacing=0 border=0 width=<%=TableWidth%> bgcolor=<%=Tablebackcolor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
                
            <tr>
                <td bgcolor=<%=Tabletitlecolor%> align=center><font  color="<%=TableFontColor%>"><b>欢迎使用短消息接收，<%=membername%></b></font></td>
            </tr>
                <tr>
                    <td bgcolor=<%=aTabletitlecolor%>><font color="<%=TableContentColor%>">
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
                </table></td></tr></table>
<%end if%>
<%
rs.close
set rs=nothing
end sub

sub savemsg()
	dim incept,title,message,subtype
	if request("touser")="" then
		errmsg=errmsg+"<br>"+"<li>您忘记填写发送对象了吧。"
		founderr=true
	else
		incept=checkStr(request("touser"))
		incept=split(incept,",")
	end if
	if request("title")="" then
		errmsg=errmsg+"<br>"+"<li>您还没有填写标题呀。"
		founderr=true
	else
		title=checkStr(request("title"))
	end if
	if request("message")="" then
		errmsg=errmsg+"<br>"+"<li>内容是必须要填写的噢。"
		founderr=true
	else
		message=checkStr(request("message"))
	end if
	if not founderr then
		for i=0 to ubound(incept)
		set rs=server.createobject("adodb.recordset")
		sql="select username from [user] where username='"&incept(i)&"'"
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
		else
		sql="insert into message (incept,sender,title,content,sendtime,flag,issend) values ('"&incept(i)&"','"&membername&"','"&title&"','"&message&"',Now(),0,0)"
		subtype="发件箱"
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
sub savedit()
	dim incept,title,message,subtype
	if request("id")="" or not isNumeric(request("id")) then
		Errmsg=Errmsg+"<br>"+"<li>请指定相关参数。"
		Founderr=true
		exit sub
	end if
	if request("touser")="" then
		errmsg=errmsg+"<br>"+"<li>您忘记填写发送对象了吧。"
		founderr=true
		exit sub
	else
		incept=checkStr(request("touser"))
	end if
	if request("title")="" then
		errmsg=errmsg+"<br>"+"<li>您还没有填写标题呀。"
		founderr=true
		exit sub
	else
		title=checkStr(request("title"))
	end if
	if request("message")="" then
		errmsg=errmsg+"<br>"+"<li>内容是必须要填写的噢。"
		founderr=true
		exit sub
	else
		message=checkStr(request("message"))
	end if
	if not founderr then
		set rs=server.createobject("adodb.recordset")
		sql="select username from [user] where username='"&incept&"'"
		rs.open sql,conn,1,1
		if rs.eof and rs.bof then
			errmsg=errmsg+"<br>"+"<li>论坛没有这个用户，看看你的发送对象写对了嘛？"
			founderr=true
			exit sub
		end if
		rs.close
		set rs=nothing

		if not founderr then
		if request("Submit")="发送" then
		sql="update message set incept='"&incept&"',sender='"&membername&"',title='"&title&"',content='"&message&"',sendtime=Now(),flag=0,issend=1 where id="&request("id")
		subtype="已发送信息"
		else
		sql="update message set incept='"&incept&"',sender='"&membername&"',title='"&title&"',content='"&message&"',sendtime=Now(),flag=0,issend=0 where id="&request("id")
		subtype="发件箱"
		end if
		conn.execute(sql)
		end if
		if not founderr then
		msg=msg+"<br>"+"<li><b>恭喜您，发送短信息成功。</b><br>发送的消息同时保存在您的"&subtype&"中。"
		call success()
		end if
	end if
end sub

sub success()
%>
    <table cellpadding=0 cellspacing=0 border=0 width=<%=TableWidth%> bgcolor=<%=Tablebackcolor%> align=center>
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

sub newmsg()
%>
    <table cellpadding=0 cellspacing=0 border=0 width=<%=TableWidth%> bgcolor=<%=Tablebackcolor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
    <tr align="center"> 
      <td width="100%" bgcolor=<%=Tabletitlecolor%>><font color="<%=TablefontColor%>">短消息通知</font></td>
    </tr>
    <tr> 
      <td width="100%" bgcolor=<%=Tablebodycolor%> align=center><br>
<a href=usersms.asp?action=inbox><img src="<%=picurl%>newmail.gif" border=0>有新的短消息</a><br>
                <br>
                <a href=usersms.asp?action=inbox>按此查看</a><br><br>
      </td>
    </tr>
    </table>   </td></tr></table>
<%
end sub
stats="发送短信"
call endline()
%>
<script language="JavaScript">
<!--
function CheckAll(form)  {
  for (var i=0;i<form.elements.length;i++)    {
    var e = form.elements[i];
    if (e.name != 'chkall')       e.checked = form.chkall.checked; 
   }
  }
//-->
</script>
<!--#include file="footer.asp"-->