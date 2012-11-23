<!--#include file="conn.asp"-->
<!--#include file="inc/char.asp"-->
<!-- #include file="inc/const.asp" -->
<!-- #include file="chkuser.asp" -->
<!--#include file="inc/grade.asp"-->
<!--#include file="inc/theme.asp"-->
<!--#include file="inc/ubbcode.asp"-->
<!--#include file="inc/birthday.asp"-->
<%
stats="查询个人资料"
dim username
dim abgcolor
username=trim(checkStr(request("name")))
founderr=false
dim usersign
usersign=true
if ViewUser_g=0 and membername="" then
	Errmsg=Errmsg+"<br>"+"<li>客人不允许查看会员资料。"
	founderr=true
end if
if ViewUser_u=0 then
	Errmsg=Errmsg+"<br>"+"<li>论坛设定不允许查看会员资料。"
	founderr=true
end if
if username="" then
   	ErrMsg=Errmsg+"<br>"+"<li>错误的参数。"
	founderr=true
end if
call nav()
call headline(1)
if founderr then
	call error()
else
	call main()
	if founderr then call error()
end if
sub main()
	dim stat,OnlineTime
	dim Srs
	dim Stockmoney,bankmoney,usergrade,boardmaster
	set rs=server.createobject("adodb.recordset")
	sql="select * from [User] where username='"&UserName&"'"
	rs.open sql,conn,1,1
	if err.number<>0 then 
		ErrMsg=Errmsg+"<br>"+"<li>数据库操作失败："&err.description
		founderr=true
		exit sub
	end if
	if rs.eof and rs.bof then
	ErrMsg=Errmsg+"<br>"+"<li>您查询的名字不存在"
	founderr=true
	exit sub
	else
%>
<table width="<%=TableWidth%>" border="0" cellspacing="0" cellpadding="3" align="center">
  <tr> 
    <td>
<b><%=htmlencode(username)%></b> 
</td>
    <td align="right">
<%
	set Srs=conn.execute("select stats,startime from online where username='"&username&"'")
	if Srs.eof and Srs.bof then
	stat=""
	OnlineTime="[离线]"
	else
	stat="当前位置：["&Srs(0)&"]"
	OnlineTime="[在线：" & datediff("n",Srs(1),Now()) & "Mins]"
	end if
	Srs.close
	set Srs=nothing
%>
 <%=stat%>


<%=OnlineTime%>  </td>
  </tr>
</table>
<table width="<%=TableWidth%>" border="0" cellspacing="1" cellpadding="3" align="center" bgcolor="<%=TableBackColor%>" style="table-layout:fixed;word-break:break-all">
  <col width=20%><col width=*><col width=40%> 
  <tr> 
    <td colspan="2" bgcolor="<%=TabletitleColor%>"><b><img src="<%=picurl%>arrow1.gif" width="13" height="13">
      <font color="<%=TableFontColor%>">基本资料</font></b></td>
    <td rowspan="9" align="center" bgcolor="<%=TablebodyColor%>" width="40%" valign=top>
<%if not isnull(rs("userphoto")) and rs("userphoto")<>"" then%>
<img src="<%=htmlencode(FilterJS(rs("userPhoto")))%>">
<%end if%>
    </td>
  </tr>   
  <tr bgcolor="<%=TablebodyColor%>"> 
    <td width="20%" align="right">性 别：</td>
    <td><font color="<%=TableContentColor%>">
<%if rs("sex")=0 then   
    response.write("女")   
else   
    response.write("男")   
end if   
%></font> </td>
  </tr>
  <tr bgcolor="<%=aTablebodyColor%>"> 
    <td width="20%" align="right">Ｅｍａｉｌ：</td>
    <td>
<%if trim(rs("useremail"))<>"" then%>
<a href="mailto:<%=htmlencode(rs("useremail"))%>"><%=htmlencode(rs("useremail"))%></a> 
<%else%>
<font color=gray>未填</font>
<%end if%></td>
  </tr>
  <tr bgcolor="<%=TablebodyColor%>"> 
    <td width="20%" align="right">联系地址：</td>
    <td><%if trim(rs("homepage"))<>"" then%>
<%=htmlencode(rs("homepage"))%>
    <%=htmlencode(rs("homepage"))%>
<%else%><font color=gray>未填</font>
<%end if%></td>
  </tr>
  <tr  bgcolor="<%=aTablebodyColor%>"> 
    <td align="right" width="40%" colspan="2">
<b><a href="usersms.asp?action=new&touser=<%=htmlencode(username)%>"><font color="<%=TableFontColor%>">给他留言</font></a> </b></td>
  </tr>
</table>
<br>
<table width="<%=TableWidth%>" border="0" cellspacing="1" cellpadding="3" align="center" bgcolor="<%=TableBackColor%>">
  <tr bgcolor="<%=TableTitleColor%>"> 
    <td colspan="4"><b><img src="<%=picurl%>arrow1.gif" width="13" height="13"> 论坛属性</b></td>
  </tr>
  <tr bgcolor="<%=TablebodyColor%>"> 
    <td width="15%" align="right">帖子总数：</td>
    <td width="35%"><b><%=rs("article")%></b> 篇</td>
	<td width="15%" align="right">被删除率：</td>
    <td width="35%"><b></b> <font color=<%=AlertFontColor%>><b><%if rs("userDel")>0 or rs("article")>0 then%><%=FormatPercent(-rs("userDel")/rs("article"))%><%else%>%<%end if%></b></font> 
    </td>
  </tr>

  <tr bgcolor="<%=TablebodyColor%>"> 
    <td width="15%" align="right">登陆次数：</td>
    <td width="35%"><b><%=rs("logins")%></b> 
    </td>
	    <td width="15%" align="right">上次登录：</td>
    <td width="35%"><b><%=rs("lastlogin")%></b></td>
  </tr>
  <tr bgcolor="<%=TablebodyColor%>"> 
    <td width="15%" align="right">注册日期：</td>
    <td  width="35%"><b><%=rs("addDAte")%></b></td>
<td width="15%" align="right">&nbsp;</td>
    <td  width="35%">&nbsp;</td>
  </tr>
</table>
<br>

<br>
<table width="<%=TableWidth%>" border="0" cellspacing="1" cellpadding="3" align="center" bgcolor="<%=TableBackColor%>">
  <tr bgcolor="<%=TableTitleColor%>"> 
    <td><b><img src="<%=picurl%>arrow1.gif" width="13" height="13"> 
      最近活动－－<a href="queryResult.asp?stype=1&nSearch=3&keyword=<%=HTMLEncode(UserName)%>&SearchDate=ALL&boardid=0">搜索该用户所有帖子</a></b></td>
  </tr>
<%
set srs=conn.execute("select top 5 rootid,boardid,dateandtime,topic,expression from bbs1 where parentid=0 and username='"&username&"' and not locktopic=2 order by announceid desc")
do while not srs.eof
%>
  <tr bgcolor="<%=TablebodyColor%>"> 
    <td align="left">&nbsp;<img src="face/<%=srs(4)%>" width=14 height=14>&nbsp;<a href="dispbbs.asp?boardid=<%=srs(1)%>&rootid=<%=srs(0)%>&id=<%=srs(0)%>"><%=htmlencode(srs(3))%>&nbsp;--&nbsp;<%=srs(2)%></td>
  </tr>
<%
srs.movenext
loop
srs.close
set srs=nothing
%>
</table>
<%end if%>
</body>
</html>
<%
rs.close
set rs=nothing
end sub
call endline()
%>
<!--#include file=footer.asp-->