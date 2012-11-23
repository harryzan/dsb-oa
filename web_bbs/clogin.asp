<!--#include file="conn.asp"-->
<!--#include file="inc/const.asp"-->
<!--#include file="chkuser.asp"-->
<!--#include file="inc/char.asp"-->
<!--#include file="inc/theme.asp"-->
<!--#include file=md5.asp-->
<%
dim pass
if request("action")="chk" then
if memberword="" or memberword<>request("pass") then
pass=md5(request("pass"))
else
pass=request("pass")
end if
'response.write pass
'response.write request("user")
'response.end
%>
<meta NAME=GENERATOR Content="Microsoft FrontPage 4.0" CHARSET=GB2312>
<form name="login" action="http://chat.aspsky.net:8888/Login" method="post">
<input type="hidden" name=user value="<%=request("user")%>">
<input type="hidden" name=pass value="<%=pass%>">
<INPUT type="hidden" name="xb" value="<%=request("xb")%>">
<INPUT type="hidden" name="fullscreen" value="<%=request("fullscreen")%>">
<INPUT type="hidden" name="boxfunc" value="<%=request("boxfunc")%>">
</form>
<script LANGUAGE=javascript>
<!--
login.submit();
//-->
</script>
<%
else
call login()
end if
%>

<%sub chklogin()%>

<%end sub%>
<%sub login()

	stats="聊天登陆"
	call nav()
	call headline(1)
%>
<script>

function OnAllUsers() // 显示在线用户总列表
{	if(Server.RoomsCount() > 0)
	window.open(Server.GetRoomObject(0).URL+"AllUsers?r=" + Math.random(),"_AllUsers","toolbar=no,location=no,directories=no,menubar=no,scrollbars=yes,resizable=yes");
}
function OnFindUser() // 显示在线用户总列表
	{if(Server.RoomsCount() <= 0)	return;
	var strUserName = prompt("请输入您要查找的用户名?", "找谁?") ;
	if(strUserName == null || strUserName == "找谁?" || strUserName.length <1)	return ;
	window.open(Server.GetRoomObject(0).URL+"FindUser?user="+strUserName+"&r=" + Math.random(),"_FindUser","toolbar=no,location=no,directories=no,menubar=no,scrollbars=yes,resizable=yes");
}

function OnUserGuide() // 打开功能说明窗口
{	if(Server.RoomsCount() > 0)
	window.open(Server.GetRoomObject(0).URL+"UserGuide","_UserGuide","toolbar=no,location=no,directories=no,menubar=no,scrollbars=yes,resizable=yes");
}

/** 系统用脚本定义开始，普通用户不建议修改 **/
function ChatRoom()
{
	this.Title		;	// 房间名称
	this.URL		;	// 登录地址
	this.UserCount	;	// 在线人数
	this.MaxOnline	;	// 最高在线
	this.State		;	// 满员状态	0=正常 1=热闹 -1=满员禁止登录
	this.Topic		;	// 当前话题
	this.AdminNames ;	// 管理员名单
	this.RoomType	;	// 房间分类ID
	this.UserList = null;
	this.Private = false ; // 是否自建
	this.Locked = false ;  // 是否加锁	
}
function ChatServer()
{
	this.MaxOnline = 0 ;	// 最高在线
	this.RegUsers = 0 ;		// 总注册人数
	this.TotalUsers = 0 ;	// 当前在线人数
	
	this.m_pServer	= new Array();
	this.RoomsCount = function(){return this.m_pServer.length;}	// 房间数
	this.GetRoomObject = function(n) // 取得房间对象
	{	if(n < this.RoomsCount()) return this.m_pServer[n];
		return null;
	}
	this.SortRule= function(a, b)
	{	var n1 = a.UserCount ;
		var n2 = b.UserCount ;
		if(n1 == n2)	return 0 ;
		if(n1 > n2)		return -1 ;
		if(n1 < n2)		return 1;
	}
	this.Sort= function(){this.m_pServer.sort(this.SortRule);}
	this.Add = function(strTitle, strURL, nUserCount, nMax, nState, strTopic, strAdmins, nRoomType, bPrivate, bLocked)
	{	var obj = new ChatRoom() ;
		obj.Title		= strTitle ;	// 房间名称
		obj.URL			= strURL;		// 登录地址
		obj.UserCount	= nUserCount ;	// 在线人数
		obj.MaxOnline	= nMax ;		// 最高在线
		obj.State		= nState ;		// 满员状态	0=正常 1=超员 -1=满员禁止登录
		obj.Topic		= strTopic ;	// 当前话题
		obj.AdminNames	= strAdmins ;	// 管理员名单
		obj.RoomType	= nRoomType ;	// 房间分类ID
		obj.Private		= bPrivate ;	// 是否自建
		obj.Locked		= bLocked ;		// 是否加锁
		this.m_pServer[this.RoomsCount()] = obj ;
	}
	this.SetCount = function(nMax, nReg, nTotal)
	{	this.MaxOnline	= nMax ;
		this.RegUsers	= nReg ;
		this.TotalUsers = nTotal ;
	}
} 
/** 系统用脚本定义结束，普通用户不建议修改 **/
var Server = new ChatServer() ;
Server.Add("动网技术聊天室","http://202.99.67.48:8888/",0,0,0,"欢迎来到动网聊天室","沙滩小子,quest,木鸟","2",false,false);

Server.SetCount(0, 34180, 0);

/* 如不希望自建聊天室与固定聊天室显示在同一界面，请掉下面两行或改成: var PrivateServer = new ChatServer(); */
var PrivateServer = Server ; 

PrivateServer.SetCount(0, 34180, 0);
</script>
<form  action="cLogin.asp?action=chk" method="POST" name="Login"> 
<center>
<iframe src="http://chat.aspsky.net:8888/login" width="95%" height=25 marginwidth=0 marginheight=0 hspace=0 vspace=0 frameborder=0 scrolling=NO></iframe></center>
<table cellpadding=0 cellspacing=0 border=0 width="<%=tablewidth%>" bgcolor=<%=Tablebackcolor%> align=center>
    <tr>    
        <td>
        <table cellpadding=6 cellspacing=1 border=0 width=100%>
    <tr>
    <td bgcolor=<%=Tablebodycolor%> valign=middle colspan=2 align=center><font color="<%=TablecontentColor%>">
	[<a href="javascript:OnFindUser();">聊友查寻</a>]
	[<a href="javascript:OnAllUsers();">在线用户列表</a>]
	[<a href="javascript:OnUserGuide();">积分说明</a>]
	</font></td></tr>
    <tr>
    <td bgcolor=<%=Tabletitlecolor%> valign=middle colspan=2 align=center><font color="<%=TableFontColor%>">
    <b>请输入您的用户名、密码登陆</b></font></td></tr>
    <tr>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>">请输入您的用户名</font></td>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><INPUT name=user type=text value="<%=membername%>"> &nbsp; <a href="reg.asp">没有注册？</a></td></tr>
    <tr>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>">请输入您的密码</font></td>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><INPUT name=pass type=password value="<%=memberword%>"> &nbsp; <a href="lostpass.asp">忘记密码？</a></td></tr>
    <tr>
    <td bgcolor=<%=Tablebodycolor%> valign=top width=30%><font color="<%=TableContentColor%>"><b> 选项</b></font></td>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>">
<INPUT type="radio"  name="xb" value="0">小姐<INPUT type="radio"  name="xb" value="1">先生<INPUT type="radio"  name="xb" value="2">保密&nbsp;&nbsp;
<INPUT type="checkbox" name="boxfunc"><font size=2>启用包厢功能</font>
	</font>
                </td></tr>
    <tr>
    <td bgcolor=<%=Tabletitlecolor%> valign=middle colspan=2 align=center>
<INPUT name="submit" type="submit" value="进入聊天室"></td></tr></table></td></tr></table>
</form>

<script>Login.user.focus();</script>
<%
call endline()
end sub
%>
<!--#include file="footer.asp"-->