<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!-- #include file="chkuser.asp" -->
<!--#include file="inc/char.asp"-->
<!--#include file="inc/theme.asp"-->
<html>
<head>
<title><%=ForumName%>--短消息</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<LINK href="forum.css" rel=stylesheet>
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
<body <%=forumbody%>>
<%
	dim msg

if membername="" then
  	errmsg=errmsg+"<br>"+"<li>您没有<a href=login.asp target=_blank>登录</a>。"
	founderr=true
else

end if
call nav()
response.write "<TABLE border=0 width="&tablewidth&" align=center><TBODY>"&_
				"<TR><TD align=left><a href='"& HostURL &"'><img border=0 src='"& Forumlogo &"'></a></TD>"&_
				"<TD Align=right>  <a href=usersms.asp?action=inbox><img src=pic/m_inbox.gif border=0 alt=收件箱></a> &nbsp; <a href=usersms.asp?action=outbox><img src=pic/M_outbox.gif border=0 alt=发件箱></a> &nbsp; <a href=usersms.asp?action=issend><img src=pic/M_issend.gif border=0 alt=已发送邮件></a>&nbsp; <a href=usersms.asp?action=recycle><img src=pic/M_recycle.gif border=0 alt=废件箱></a>&nbsp; <a href=friendlist.asp><img src=pic/M_address.gif border=0 alt=地址簿></a>&nbsp;<a href=usersms.asp?action=new&id=><img src=pic/m_write.gif border=0 alt=发送消息></a> &nbsp;<a href=usersms.asp?action=new&touser="&htmlencode(request("sender"))&"&id="&request("id")&"><img src=pic/m_reply.gif border=0 alt=回复消息></a> &nbsp;<a href=usersms.asp?action=fw&id="&request("id")&"><img src=pic/m_fw.gif border=0 alt=转发消息></a>&nbsp;<a href=usersms.asp?action=delete&id="&request("id")&"><img src=pic/m_delete.gif border=0 alt=删除消息></a>"&_
				"</TD></TR></TBODY></TABLE><br>"
if founderr=true then
	call error()
else
	select case request("action")
	case "info"
		call info()
	case "addF"
		call addF()
	case "saveF"
		call saveF()
	case "删除"
		call DelFriend()
	case "清空好友"
		call AllDelFriend()
	case else
		call info()
	end select
	if founderr then call error()
end if
'收件箱
sub info()
%>
<form action="friendlist.asp" method=post name=inbox>
    <table cellpadding=0 cellspacing=0 border=0 width="<%=tablewidth%>" bgcolor=<%=Tablebackcolor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
            <tr bgcolor=<%=Tabletitlecolor%>>
                <td align=center valign=middle width="25%"><font color="<%=TableFontColor%>"><b>姓名</b></font></td>
                <td align=center valign=middle width="25%"><font color="<%=TableFontColor%>"><b>邮件</b></font></td>
                <td align=center valign=middle width="25%"><font color="<%=TableFontColor%>"><b>联系地址</b></font></td>
                <td align=center valign=middle width="10%"><font color="<%=TableFontColor%>"><b>发短信</b></font></td>
                <td align=center valign=middle width="5%"><font color="<%=TableFontColor%>"><b>操作</b></font></td>
            </tr>
<%
	set rs=server.createobject("adodb.recordset")
	sql="select F.*,U.useremail,U.homepage,U.oicq from Friend F inner join [user] U on F.F_Friend=U.username where F.F_username='"&trim(membername)&"' order by F.f_addtime desc"
	rs.open sql,conn,1,1
	if rs.eof and rs.bof then
%>
                <tr>
                <td bgcolor=<%=Tablebodycolor%> align=center valign=middle colspan=6><font color="<%=TableContentColor%>">您的好友列表中没有任何内容。</font></td>
                </tr>
<%else%>
<%do while not rs.eof%>
                <tr bgcolor="<%=Tablebodycolor%>">
                    <td align=center valign=middle><font color="<%=TableContentColor%>"><a href="dispuser.asp?name=<%=htmlencode(rs("F_friend"))%>" target=_blank><%=rs("F_friend")%></a></font></td>
                    <td align=center valign=middle><font color="<%=TableContentColor%>"><a href="mailto:<%=rs("useremail")%>"><%=rs("useremail")%></a></font></td>
                    <td align=center><font color="<%=TableContentColor%>"><%=rs("homepage")%></font></td>
                    <td align=center><a href="usersms.asp?action=new&touser=<%=htmlencode(rs("f_friend"))%>">发送</a></td>
                <td align=center><input type=checkbox name=id value=<%=rs("f_id")%>></td>
                </tr>
<%
	rs.movenext
	loop
	end if
	rs.close
	set rs=nothing
%>
                
        <tr bgcolor="<%=Tabletitlecolor%>"> 
          <td align=right valign=middle colspan=6><input type=checkbox name=chkall value=on onclick="CheckAll(this.form)">选中所有显示记录&nbsp;<input type=button name=action onclick="location.href='friendlist.asp?action=addF'" value="添加好友">&nbsp;<input type=submit name=action onclick="{if(confirm('确定删除选定的纪录吗?')){this.document.inbox.submit();return true;}return false;}" value="删除">&nbsp;<input type=submit name=action onclick="{if(confirm('确定清除所有的纪录吗?')){this.document.inbox.submit();return true;}return false;}" value="清空好友"></td>
                </tr>
                </table></td></tr></table></form>
<%
end sub

sub delFriend()
dim delid
delid=request("id")
if delid="" or isnull(delid) or not isnumeric(delid) then
Errmsg=Errmsg+"<li>"+"请选择相关参数。"
Founderr=true
else
	conn.execute("delete from Friend where F_username='"&trim(membername)&"' and F_id in ("&delid&")")
	msg=msg+"<br>"+"<li><b>您已经删除选定的好友记录。"
	call success()
end if
end sub
sub AllDelFriend()
	conn.execute("delete from Friend where F_username='"&trim(membername)&"'")
	msg=msg+"<br>"+"<li><b>您已经删除了所有好友列表。"
	call success()
end sub

sub addF()
%>
<form action="Friendlist.asp" method=post name=messager>
  <table cellpadding=0 cellspacing=0 border=0 width="<%=tablewidth%>" bgcolor=<%=Tablebackcolor%> align=center>
    <tr> 
      <td> 
        <table cellpadding=3 cellspacing=1 border=0 width=100%>
          <tr> 
            <td bgcolor=<%=Tabletitlecolor%> colspan=2 align=center> 
              <input type=hidden name="action" value="saveF">
              <font color="<%=TablefontColor%>"><b>加入好友</b>--请完整输入下列信息</font></td>
          </tr>
          <tr> 
            <td bgcolor=<%=Tablebodycolor%> valign=middle width=70><font color="<%=TableContentColor%>"><b>好友：</b></font></td>
            <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>">
              <input type=text name="touser" size=50 value="<%=request("myFriend")%>">
			  &nbsp;使用逗号（,）分开，最多5位用户</font>
            </td>
          </tr>
          <tr> 
            <td bgcolor=<%=Tabletitlecolor%> valign=middle colspan=2 align=center> 
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

sub saveF()
	dim incept
	if request("touser")="" then
		errmsg=errmsg+"<br>"+"<li>您忘记填写发送对象了吧。"
		founderr=true
	else
		incept=checkStr(request("touser"))
		incept=split(incept,",")
	end if
	if not founderr then
		for i=0 to ubound(incept)
		set rs=server.createobject("adodb.recordset")
		sql="select username from [user] where username='"&incept(i)&"'"
		rs.open sql,conn,1,1
		if rs.eof and rs.bof then
			errmsg=errmsg+"<br>"+"<li>论坛没有这个用户，操作未成功。"
			founderr=true
		end if
		rs.close
		set rs=nothing

		if not founderr then
		sql="select F_friend from friend where F_username='"&membername&"' and  F_friend='"&incept(i)&"'"
		set rs=conn.execute(sql)
		if rs.eof and rs.bof then
		sql="insert into friend (F_username,F_friend,F_addtime) values ('"&membername&"','"&incept(i)&"',Now())"
		conn.execute(sql)
		end if
			if i>4 then
			errmsg=errmsg+"<br>"+"<li>每次最多只能添加5位用户，您的名单5位以后的请重新填写。"
			founderr=true
			exit for
			end if
		end if
		next
		if not founderr then
		msg=msg+"<br>"+"<li><b>恭喜您，好友添加成功。"
		call success()
		end if
	end if
end sub

sub success()
%>
    <table cellpadding=0 cellspacing=0 border=0 width="<%=tablewidth%>" bgcolor=<%=Tablebackcolor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
    <tr align="center"> 
      <td width="100%" bgcolor=<%=Tabletitlecolor%>><font color="<%=TablefontColor%>">成功：好友列表</font></td>
    </tr>
    <tr> 
      <td width="100%" bgcolor=<%=Tablebodycolor%>><font color="<%=TableContentColor%>"><%=msg%></font>
      </td>
    </tr>
    </table>   </td></tr></table>
<%
end sub
stats="好友列表"
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