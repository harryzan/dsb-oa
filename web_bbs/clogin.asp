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

	stats="�����½"
	call nav()
	call headline(1)
%>
<script>

function OnAllUsers() // ��ʾ�����û����б�
{	if(Server.RoomsCount() > 0)
	window.open(Server.GetRoomObject(0).URL+"AllUsers?r=" + Math.random(),"_AllUsers","toolbar=no,location=no,directories=no,menubar=no,scrollbars=yes,resizable=yes");
}
function OnFindUser() // ��ʾ�����û����б�
	{if(Server.RoomsCount() <= 0)	return;
	var strUserName = prompt("��������Ҫ���ҵ��û���?", "��˭?") ;
	if(strUserName == null || strUserName == "��˭?" || strUserName.length <1)	return ;
	window.open(Server.GetRoomObject(0).URL+"FindUser?user="+strUserName+"&r=" + Math.random(),"_FindUser","toolbar=no,location=no,directories=no,menubar=no,scrollbars=yes,resizable=yes");
}

function OnUserGuide() // �򿪹���˵������
{	if(Server.RoomsCount() > 0)
	window.open(Server.GetRoomObject(0).URL+"UserGuide","_UserGuide","toolbar=no,location=no,directories=no,menubar=no,scrollbars=yes,resizable=yes");
}

/** ϵͳ�ýű����忪ʼ����ͨ�û��������޸� **/
function ChatRoom()
{
	this.Title		;	// ��������
	this.URL		;	// ��¼��ַ
	this.UserCount	;	// ��������
	this.MaxOnline	;	// �������
	this.State		;	// ��Ա״̬	0=���� 1=���� -1=��Ա��ֹ��¼
	this.Topic		;	// ��ǰ����
	this.AdminNames ;	// ����Ա����
	this.RoomType	;	// �������ID
	this.UserList = null;
	this.Private = false ; // �Ƿ��Խ�
	this.Locked = false ;  // �Ƿ����	
}
function ChatServer()
{
	this.MaxOnline = 0 ;	// �������
	this.RegUsers = 0 ;		// ��ע������
	this.TotalUsers = 0 ;	// ��ǰ��������
	
	this.m_pServer	= new Array();
	this.RoomsCount = function(){return this.m_pServer.length;}	// ������
	this.GetRoomObject = function(n) // ȡ�÷������
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
		obj.Title		= strTitle ;	// ��������
		obj.URL			= strURL;		// ��¼��ַ
		obj.UserCount	= nUserCount ;	// ��������
		obj.MaxOnline	= nMax ;		// �������
		obj.State		= nState ;		// ��Ա״̬	0=���� 1=��Ա -1=��Ա��ֹ��¼
		obj.Topic		= strTopic ;	// ��ǰ����
		obj.AdminNames	= strAdmins ;	// ����Ա����
		obj.RoomType	= nRoomType ;	// �������ID
		obj.Private		= bPrivate ;	// �Ƿ��Խ�
		obj.Locked		= bLocked ;		// �Ƿ����
		this.m_pServer[this.RoomsCount()] = obj ;
	}
	this.SetCount = function(nMax, nReg, nTotal)
	{	this.MaxOnline	= nMax ;
		this.RegUsers	= nReg ;
		this.TotalUsers = nTotal ;
	}
} 
/** ϵͳ�ýű������������ͨ�û��������޸� **/
var Server = new ChatServer() ;
Server.Add("��������������","http://202.99.67.48:8888/",0,0,0,"��ӭ��������������","ɳ̲С��,quest,ľ��","2",false,false);

Server.SetCount(0, 34180, 0);

/* �粻ϣ���Խ���������̶���������ʾ��ͬһ���棬����������л�ĳ�: var PrivateServer = new ChatServer(); */
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
	[<a href="javascript:OnFindUser();">���Ѳ�Ѱ</a>]
	[<a href="javascript:OnAllUsers();">�����û��б�</a>]
	[<a href="javascript:OnUserGuide();">����˵��</a>]
	</font></td></tr>
    <tr>
    <td bgcolor=<%=Tabletitlecolor%> valign=middle colspan=2 align=center><font color="<%=TableFontColor%>">
    <b>�����������û����������½</b></font></td></tr>
    <tr>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>">�����������û���</font></td>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><INPUT name=user type=text value="<%=membername%>"> &nbsp; <a href="reg.asp">û��ע�᣿</a></td></tr>
    <tr>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>">��������������</font></td>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><INPUT name=pass type=password value="<%=memberword%>"> &nbsp; <a href="lostpass.asp">�������룿</a></td></tr>
    <tr>
    <td bgcolor=<%=Tablebodycolor%> valign=top width=30%><font color="<%=TableContentColor%>"><b> ѡ��</b></font></td>
    <td bgcolor=<%=Tablebodycolor%> valign=middle><font color="<%=TableContentColor%>">
<INPUT type="radio"  name="xb" value="0">С��<INPUT type="radio"  name="xb" value="1">����<INPUT type="radio"  name="xb" value="2">����&nbsp;&nbsp;
<INPUT type="checkbox" name="boxfunc"><font size=2>���ð��Ṧ��</font>
	</font>
                </td></tr>
    <tr>
    <td bgcolor=<%=Tabletitlecolor%> valign=middle colspan=2 align=center>
<INPUT name="submit" type="submit" value="����������"></td></tr></table></td></tr></table>
</form>

<script>Login.user.focus();</script>
<%
call endline()
end sub
%>
<!--#include file="footer.asp"-->