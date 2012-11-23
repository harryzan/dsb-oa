<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=inc/theme.asp-->
<!--#include file=chkuser.asp-->
<%
	stats="版主管理页面"
	dim sql1,rs1
	dim id,rootid
	dim Maxid
	if founduser=false then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>请登陆后进行操作。"
	end if
	if request("boardid")="" then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>请指定论坛版面。"
	elseif not isInteger(request("boardid")) then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>非法的版面参数。"
	else
		boardid=request("boardid")
		if chkboardmaster(boardid)=false then
			founderr=true
			Errmsg=Errmsg+"<br>"+"<li>您不是该版面斑竹或者系统管理员。"
		end if
	end if
	call nav()
	call headline(2)
	if founderr=true then
		call error()
	else
	dim title
	dim content
	set rs=server.createobject("adodb.recordset")
	call main()
	end if
	set rs=nothing
	call endline()
	sub main()
%>
<table cellpadding=0 cellspacing=0 border=0 width=<%=tablewidth%> bgcolor=<%=tablebackcolor%> align=center>
  <tr>
    <td>
      <table cellpadding=3 cellspacing=1 border=0 width=100%>
        <tr bgcolor='<%=Tabletitlecolor%>'>
          <td align=center colspan="2"><font color="<%=TablefontColor%>">欢迎<b> <%=htmlencode(membername)%></b>进入版主管理页面</font></td>
        </tr>
            <tr bgcolor=<%=tablebodycolor%>>
              <td width="30%" valign=top><font color="<%=TableContentColor%>">
&nbsp;&nbsp;注意：各个版面版主可以在自己版面自由发布公告和版面设置，管理员可以在所有版面发布，并对信息进行管理操作。
<br><BR>
            <BR>
</font>
	      </td>
              <td width="70%" valign=top>
<font color="<%=TableContentColor%>">
      		<table cellpadding=0 cellspacing=0 border=0 width=100% align=center>
		  <tr>
			<td width="100%" height=24 bgcolor=<%=aTableTitlecolor%>>
<font color="<%=TableContentColor%>">
<B>注意</B>：<BR>
                  本页面为版主专用，在进行管理设置的时候，不要随意更改设置，如需更改，必须填写完整或者正确的填写。<BR><b>
                  管理选项：<a href=admin_boardaset.asp?boardid=<%=boardid%>><font color="<%=TableContentColor%>">论坛公告发布</font></a> 
                  <%if master then%>
                  | <b><a href=admin_boardaset.asp?action=manage&boardid=<%=boardid%>><font color="<%=TableContentColor%>">公告管理</font></a> 
                  <%end if%>
                  </b></font> </td>
              </tr>
		</table>
<%
	select case request("action")
	case "new"
		call savenews()
	case "manage"
		call manage()
	case "edit"
		call edit()
	case "updat"
		call update()
	case "del"
		call del()
	case "editbminfo"
		call editbminfo()
	case "saveditbm"
		call savebminfo()
	case "editbmset"
		call editbmset()
	case "savebmset"
		call savebmset()
	case "editbmcolor"
		call editbmcolor()
	case "savebmcolor"
		call savebmcolor()
	case else
	call news()
	end select
%></font>
	      </td>
            </tr>
        </table>
        </td>
    </tr>
</table>
<%
end sub

sub news()
%>
<form action="admin_boardaset.asp?action=new" method=post name=FORM>
      		
  <table cellpadding=0 cellspacing=0 border=0 width=100% align=center>
    <tr> 
      <td width="20%" valign=top> 
        <div align="center"><font color="<%=TableContentColor%>">发布版面： </font></div>
      </td>
      <td width="80%"> 
        <%if master then%>
        <%
   sql="select boardid,boardtype from board"
   rs.open sql,conn,1,1
%>
        <select name="boardid" size="1">
          <option value="0">论坛首页</option>
          <%
	do while not rs.eof
        response.write "<option value='"+CStr(rs("BoardID"))+"'>"+rs("Boardtype")+"</option>"+chr(13)+chr(10)
	rs.movenext
	loop
	rs.close
%>
        </select>
        <%else%>
        <%
	sql="select boardtype from board where boardid="&boardid
	rs.open sql,conn,1,1
	boardtype=rs("boardtype")
%>
        <select name="boardid" size="1">
          <option value="<%=boardid%>"><%=boardtype%></option>
        </select>
        <%end if%>
      </td>
    </tr>
    <tr> 
      <td width="20%" valign=top> 
        <div align="center"><font color="<%=TableContentColor%>">发布人： </font></div>
      </td>
      <td width="80%">
        <input type=text name=username size=36 value="<%=membername%>" disabled>
        <input type=hidden name=username value="<%=membername%>">
      </td>
    </tr>
    <tr> 
      <td width="20%" valign=top> 
        <div align="center"><font color="<%=TableContentColor%>">标题： </font></div>
      </td>
      <td width="80%">
        <input type=text name=title size=36>
      </td>
    </tr>
    <tr> 
      <td width="20%" valign=top> 
        <div align="center"><font color="<%=TableContentColor%>">内容： </font></div>
      </td>
      <td width="80%">
        <textarea cols=35 rows=6 name="content"></textarea>
      </td>
    </tr>
    <tr>
      <td width="100%" valign=top colspan="2" align=center> 
        <input type=Submit value="发 送" name=Submit">
        &nbsp; 
        <input type="reset" name="Clear" value="清 除">
      </td>
    </tr>
  </table>
</form>
<%
end sub

sub savenews()
	dim username,title,content
	if request("boardid")<>"" then
		boardid=request("boardid")
	else
		Errmsg=Errmsg+"<br>"+"<li>您输入了错误的参数。"
		founderr=true
	end if
	if request("username")="" then
		Errmsg=Errmsg+"<br>"+"<li>请输入发布者。"
		founderr=true
	else
		username=request("username")
	end if
	if request("title")="" then
		Errmsg=Errmsg+"<br>"+"<li>请输入公告标题。"
		founderr=true
	else
		title=request("title")
	end if
	if request("content")="" then
		Errmsg=Errmsg+"<br>"+"<li>请输入公告内容。"
		founderr=true
	else
		content=request("content")
	end if
	if founderr=true then
		call error()
	else
		sql="select * from bbsnews"
		rs.open sql,conn,1,3
		rs.addnew
		rs("username")=username
		rs("title")=title
		rs("content")=content
		rs("addtime")=Now()
		rs("boardid")=boardid
		rs.update
		rs.close
		call success()
	end if
end sub

sub manage()
	if master=false then
	exit sub
	end if
	sql="select * from bbsnews"
	rs.open sql,conn,1,1
%>
      		<table cellpadding=0 cellspacing=0 border=0 width=100% align=center>
		  <tr><td width="80%" valign=top height=22>
<font color="<%=TableContentColor%>">标题</font>
		  </td>
		  <td width="20%">
<font color="<%=TableContentColor%>">操作</font>
		  </td></tr>
<%do while not rs.eof%>
		  <tr><td width="80%" valign=top height=22><a href=admin_boardaset.asp?action=edit&id=<%=rs("id")%>&boardid=<%=rs("boardid")%>><font color="<%=TableContentColor%>"><%=rs("title")%></font></a>
		  </td>
		  <td width="20%"><a href=admin_boardaset.asp?action=del&id=<%=rs("id")%>&boardid=<%=boardid%>><font color="<%=TableContentColor%>">删除</font></a>
		  </td></tr>
<%
	rs.movenext
	loop
	rs.close
%></table>
<%
end sub

sub edit()
%>
<form action="admin_boardaset.asp?action=updat&id=<%=request("id")%>" method=post>
      		<table cellpadding=0 cellspacing=0 border=0 width=100% align=center>
		  <tr><td width="20%" valign=top>
<font color="<%=TableContentColor%>">发布版面：</font>
		  </td>
		  <td width="80%">
<%
	dim sel
   	sql="select boardid,boardtype from board"
   	rs.open sql,conn,1,1
%>
<select name="boardid" size="1">
<option value="0" <%if request("boardid")=0 then%>selected<%end if%>>论坛首页</option>
<%
	do while not rs.eof
	if Cint(request("boardid"))=Cint(rs("boardid")) then
	sel="selected"
	else
	sel=""
	end if
        response.write "<option value='"+CStr(rs("BoardID"))+"' "&sel&">"+rs("Boardtype")+"</option>"+chr(13)+chr(10)
	rs.movenext
	loop
	rs.close
%>        
          </select>
		  </td></tr>
<%
	sql="select * from bbsnews where id="&cstr(request("id"))
	rs.open sql,conn,1,1
%>
		  <tr><td width="20%" valign=top>
<font color="<%=TableContentColor%>">发布人：</font>
		  </td>
		  <td width="80%"><input type=text name=username size=36 value=<%=rs("username")%>></td></tr>
		  <tr><td width="20%" valign=top>
<font color="<%=TableContentColor%>">标题：</font>
		  </td>
		  <td width="80%"><input type=text name=title size=36 value=<%=rs("title")%>></td></tr>
		  <tr><td width="20%" valign=top>
<font color="<%=TableContentColor%>">内容：</font>
		  </td>
		  <td width="80%"><textarea cols=35 rows=6 name="content">
<%
	    content=replace(rs("content"),"<br>",chr(13))
            content=replace(content,"&nbsp;"," ")
            response.write ""&content&""
	    rs.close
%>
		  </textarea></td>
		  </tr>
		  <tr><td width="100%" valign=top colspan="2" align=center>
<input type=Submit value="修 改" name=Submit"> &nbsp; <input type="reset" name="Clear" value="清 除">
		  </td></tr>
		</table>
</form>
<%
end sub

sub update()
	dim username,title,content
	if request("boardid")<>"" then
		boardid=request("boardid")
	else
		exit sub
	end if
	if request("username")="" then
		Errmsg=Errmsg+"<br>"+"<li>请输入发布者。"
		founderr=true
	else
		username=request("username")
	end if
	if request("title")="" then
		Errmsg=Errmsg+"<br>"+"<li>请输入公告标题。"
		founderr=true
	else
		title=request("title")
	end if
	if request("content")="" then
		Errmsg=Errmsg+"<br>"+"<li>请输入公告内容。"
		founderr=true
	else
		content=request("content")
	end if
	if founderr=true then
		call error()
	else
		sql="select * from bbsnews where id="&cstr(request("id"))
		rs.open sql,conn,1,3
		rs("username")=username
		rs("title")=title
		rs("content")=content
		rs("addtime")=Now()
		rs("boardid")=boardid
		rs.update
		rs.close
		call success()
	end if
end sub

sub del()
	sql="delete from bbsnews where id="&cstr(request("id"))
	conn.execute(sql)
	call success()
end sub

sub success()
%><br><br>
成功：公告操作
<%
end sub

sub editbminfo()
dim master_1
dim rs_c
if bmflag_1=0 then
Errmsg=Errmsg+"<br>"+"<li>本项版主管理功能未开放。"
call error()
exit sub
end if
%>
 <form action ="admin_boardaset.asp?action=saveditbm&boardid=<%=boardid%>" method=post>           
<%
set rs_c= server.CreateObject ("adodb.recordset")
sql = "select * from class"
rs_c.open sql,conn,1,1
set rs= server.CreateObject ("adodb.recordset")
sql = "select * from board where boardid="+CSTr(boardid)
rs.open sql,conn,1,1
if rs.eof and rs.bof then
Errmsg=Errmsg+"<br>"+"<li>您没有指定相应论坛ID，不能进行管理。"
call error()
exit sub
end if
master_1=split(rs("boardmaster"),"|")
if membername<>master_1(0) then
Errmsg=Errmsg+"<br>"+"<li>本项功能为主版主专用。"
call error()
exit sub
end if
%>            
<input type='hidden' name=editid value='<%=boardid%>'>
            
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr bgcolor=<%=aTableTitleColor%>> 
      <td width="52%" height=22><font color="<%=TableContentColor%>"><b>字段名称：</b></font> </td>
      <td width="48%"> 
        <div align="center"><font color="<%=TableContentColor%>"><b>变量值：</b></font></div>
      </td>
    </tr>
    <tr> 
      <td width="52%"><font color="<%=TableContentColor%>">论坛序号（注意不能和别的论坛序号相同）</font></td>
      <td width="48%"> <font color="<%=TableContentColor%>"><%=rs("boardid")%> </font></td>
    </tr>
    <tr> 
      <td width="52%"><font color="<%=TableContentColor%>">论坛名</font></td>
      <td width="48%"> <font color="<%=TableContentColor%>"><%=rs("boardtype")%></font> </td>
    </tr>
    <tr> 
      <td width="52%"><font color="<%=TableContentColor%>">版面说明</font></td>
      <td width="48%"> 
        <input type="text" name="readme" size="24" value='<%=rs("readme")%>'>
      </td>
    </tr>
    <tr> 
      <td width="52%"><font color="<%=TableContentColor%>">版主(多版主添加请用|分隔，如：沙滩小子|wodeail)：</font></td>
      <td width="48%"> 
        <input type="text" name="boardmaster" size="24"  value='<%=rs("boardmaster")%>'>
      </td>
    </tr>
    <tr bgcolor=<%=aTableTitleColor%>> 
      <td width="52%">&nbsp;</td>
      <td width="48%"> 
        <input type="submit" name="Submit" value="提交">
      </td>
    </tr>
  </table>
</form>
<%
rs.close
end sub

sub savebminfo()
	sql = "select * from board where boardid="+Cstr(request("boardid"))
	rs.Open sql,conn,1,3
if rs.eof and rs.bof then
Errmsg=Errmsg+"<br>"+"<li>您没有指定相应论坛ID，不能进行管理。"
call error()
exit sub
end if
	rs("boardmaster") = Request("boardmaster")
	rs("readme") = Request("readme")
	rs.Update 
	rs.Close 
	response.write "<p>论坛修改成功！"
end sub

sub editbmset()
dim chkedit
dim master_1
chkedit=false
set rs=conn.execute("select boardmaster from board where boardid="&request("boardid"))
if rs.eof and rs.bof then
Errmsg=Errmsg+"<br>"+"<li>您没有指定相应论坛ID，不能进行管理。"
call error()
exit sub
end if
master_1=split(rs(0),"|")
if bmflag_5=1 then
chkedit=true
else
if bmflag_3=0 then
chkedit=false
elseif bmflag_3=1 and membername=master_1(0) then
chkedit=true
else
chkedit=false
end if
end if
if master then
chkedit=true
end if
if chkedit=false then
	Errmsg=Errmsg+"<br>"+"<li>本项功能未对您开放。"
	call error()
else
%>
<form method="POST" action=admin_boardaset.asp?action=savebmset&boardid=<%=request("boardid")%>>
<table width="95%" border="0" cellspacing="1" cellpadding="3"  align=center bordercolor=<%=aTablebackcolor%>>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td height="23" colspan="2" ><font color="<%=TableContentColor%>"><b>论坛使用设置</b></font></td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>帖子上传图片</B><BR>用于帖子图片的上传，如分论坛已经设置，以分论坛为准</font></td>
<td width="60%"> <font color="<%=TableContentColor%>">
<input type=radio name="Uploadpic" value=0 <%if cint(Uploadpic)=0 then%>checked<%end if%>>关闭&nbsp;
<input type=radio name="Uploadpic" value=1 <%if cint(Uploadpic)=1 then%>checked<%end if%>>打开&nbsp;</font>
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>用户IP</B><BR>该选择对版主和管理员无效</font></td>
<td width="60%"> <font color="<%=TableContentColor%>">
<input type=radio name="IpFlag" value=0 <%if cint(IpFlag)=0 then%>checked<%end if%>>保密&nbsp;
<input type=radio name="IpFlag" value=1 <%if cint(IpFlag)=1 then%>checked<%end if%>>公开&nbsp;</font>
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>用户来源</B><BR>该选择对版主和管理员无效<BR>为节省资源建议关闭</font></td>
<td width="60%"> <font color="<%=TableContentColor%>">
<input type=radio name="FromFlag" value=0 <%if cint(FromFlag)=0 then%>checked<%end if%>>保密&nbsp;
<input type=radio name="FromFlag" value=1 <%if cint(FromFlag)=1 then%>checked<%end if%>>公开&nbsp;</font>
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>客人浏览论坛</B><BR>可设置是否允许客人浏览论坛</font></td>
<td width="60%"> <font color="<%=TableContentColor%>">
<input type=radio name="guestlogin" value=0 <%if cint(guestlogin)=0 then%>checked<%end if%>>允许&nbsp;
<input type=radio name="guestlogin" value=1 <%if cint(guestlogin)=1 then%>checked<%end if%>>不允许&nbsp;</font>
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>在线名单显示客人在线</B><BR>为节省资源建议关闭</font></td>
<td width="60%"> <font color="<%=TableContentColor%>">
<input type=radio name="online_g" value=0 <%if cint(online_g)=0 then%>checked<%end if%>>关闭&nbsp;
<input type=radio name="online_g" value=1 <%if cint(online_g)=1 then%>checked<%end if%>>打开&nbsp;</font>
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>在线名单显示用户在线</B><BR>为节省资源建议关闭</font></td>
<td width="60%"> <font color="<%=TableContentColor%>">
<input type=radio name="online_u" value=0 <%if cint(online_u)=0 then%>checked<%end if%>>关闭&nbsp;
<input type=radio name="online_u" value=1 <%if cint(online_u)=1 then%>checked<%end if%>>打开&nbsp;</font>
</td>
</tr>
<tr> 
<td height="17" width="40%"><font color="<%=TableContentColor%>"><B>帖子内容最大的字节数</B><BR>请输入数字</font></td>
<td height="17" width="60%"> <font color="<%=TableContentColor%>">
<input type="text" name="AnnounceMaxBytes" size="6" value="<%=AnnounceMaxBytes%>">&nbsp;字节</font>
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>每页显示最多纪录</B><BR>用于论坛所有和分页有关的项目</font></td>
<td width="60%"> <font color="<%=TableContentColor%>">
<input type="text" name="MaxAnnouncePerPage" size="3" value="<%=MaxAnnouncePerPage%>">&nbsp;条</font>
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>浏览贴子每页显示贴子数</B></font></td>
<td width="60%"> <font color="<%=TableContentColor%>">
<input type="text" name="Maxtitlelist" size="3" value="<%=Maxtitlelist%>">&nbsp;条</font>
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>发贴模式</B><BR>高级模式为显示所有项目</font></td>
<td width="60%"> <font color="<%=TableContentColor%>">
<input type=radio name="TopicFlag" value=0 <%if cint(TopicFlag)=0 then%>checked<%end if%>>普通&nbsp;
<input type=radio name="TopicFlag" value=1 <%if cint(TopicFlag)=1 then%>checked<%end if%>>高级&nbsp;</font>
</td>
</tr>

<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>是否显示页面执行时间</B></font></td>
<td width="60%"> <font color="<%=TableContentColor%>">
<input type=radio name="runtime" value=0 <%if cint(runtime)=0 then%>checked<%end if%>>否&nbsp;
<input type=radio name="runtime" value=1 <%if cint(runtime)=1 then%>checked<%end if%>>是&nbsp;</font>
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>上传文件类型</B><BR>使用逗号隔开</font></td>
<td width="60%"> 
<input type="text" name="Forum_upload" size="35" value="<%=Forum_upload%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>上传文件大小</B><BR>请填写数字</font></td>
<td width="60%"> 
<input type="text" name="uploadsize" size="6" value="<%=uploadsize%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>是否开启UBB代码</B></font></td>
<td width="60%"> <font color="<%=TableContentColor%>">
<input type=radio name="strAllowForumCode" value=0 <%if cint(strAllowForumCode)=0 then%>checked<%end if%>>关闭&nbsp;
<input type=radio name="strAllowForumCode" value=1 <%if cint(strAllowForumCode)=1 then%>checked<%end if%>>打开&nbsp;</font>
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>是否开启HTML代码</B></font></td>
<td width="60%"> <font color="<%=TableContentColor%>">
<input type=radio name="strAllowHTML" value=0 <%if cint(strAllowHTML)=0 then%>checked<%end if%>>关闭&nbsp;
<input type=radio name="strAllowHTML" value=1 <%if cint(strAllowHTML)=1 then%>checked<%end if%>>打开&nbsp;</font>
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>是否开启贴图标签</B></font></td>
<td width="60%"> <font color="<%=TableContentColor%>">
<input type=radio name="strIMGInPosts" value=0 <%if cint(strIMGInPosts)=0 then%>checked<%end if%>>关闭&nbsp;
<input type=radio name="strIMGInPosts" value=1 <%if cint(strIMGInPosts)=1 then%>checked<%end if%>>打开&nbsp;</font>
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>是否开启表情标签</B></font></td>
<td width="60%"> <font color="<%=TableContentColor%>">
<input type=radio name="strIcons" value=0 <%if cint(strIcons)=0 then%>checked<%end if%>>关闭&nbsp;
<input type=radio name="strIcons" value=1 <%if cint(strIcons)=1 then%>checked<%end if%>>打开&nbsp;</font>
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>是否开启Flash标签</B></font></td>
<td width="60%"> <font color="<%=TableContentColor%>">
<input type=radio name="strflash" value=0 <%if cint(strflash)=0 then%>checked<%end if%>>关闭&nbsp;
<input type=radio name="strflash" value=1 <%if cint(strflash)=1 then%>checked<%end if%>>打开&nbsp;</font>
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>版面配色公开</B></font></td>
<td width="60%"> <font color="<%=TableContentColor%>">
<input type=radio name="viewcolor" value=0 <%if cint(viewcolor)=0 then%>checked<%end if%>>关闭&nbsp;
<input type=radio name="viewcolor" value=1 <%if cint(viewcolor)=1 then%>checked<%end if%>>打开&nbsp;</font>
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>是否允许未登陆用户搜索</B></font></td>
<td width="60%"> 
<input type=radio name="Search_G" value=0 <%if cint(Search_G)=0 then%>checked<%end if%>>允许&nbsp;
<input type=radio name="Search_G" value=1 <%if cint(Search_G)=1 then%>checked<%end if%>>不允许&nbsp;
</td>
</tr>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td width="40%">&nbsp;</td>
<td width="60%"> 
<div align="center"> 
<input type="submit" name="Submit" value="提 交">
</div>
</td>
</tr>
</table>
</form>
<%
end if
end sub
sub savebmset()
dim chkedit
dim master_1
chkedit=false
set rs=conn.execute("select boardmaster from board where boardid="&request("boardid"))
if rs.eof and rs.bof then
Errmsg=Errmsg+"<br>"+"<li>您没有指定相应论坛ID，不能进行管理。"
call error()
exit sub
end if
master_1=split(rs(0),"|")
if bmflag_5=1 then
chkedit=true
else
if bmflag_3=0 then
chkedit=false
elseif bmflag_3=1 and membername=master_1(0) then
chkedit=true
else
chkedit=false
end if
end if
if master then
chkedit=true
end if
dim Forum_setting
if chkedit=false then
	Errmsg=Errmsg+"<br>"+"<li>本项功能未对您开放。"
	call error()
else
Forum_Setting=TimeAdjust & "," & ScriptTimeOut & "," & EmailFlag & "," & request("Uploadpic") & "," & request("IpFlag") & "," & request("FromFlag") & "," & TitleFlag & "," & uploadFlag & "," & kicktime & "," & request("guestlogin") & "," & openmsg & "," & request("MaxAnnouncePerPage") & "," & request("Maxtitlelist") & "," & request("AnnounceMaxBytes") & "," & request("online_u") & "," & request("online_g") & "," & LinkFlag & "," & request("TopicFlag") & "," & request("VoteFlag") & "," & request("ReflashFlag") & "," & request("ReflashTime") & "," & ForumStop & "," & RegTime & "," & EmailReg & "," & EmailRegOne & "," & RegFlag & "," & online_n & "," & ViewUser_g & "," & ViewUser_u & "," & BirthFlag & "," & request("runtime") & "," & FastLogin & "," & GroupFlag & "," & request("uploadsize") & "," & request("strAllowForumCode") & "," & request("strAllowHTML") & "," & request("strIMGInPosts") & "," & request("strIcons") & "," & request("strflash") & "," & request("vote_num") & "," & facenum & "," & imgnum & "," & request("relaypost") & "," & request("relayposttime") & "," & facename & "," & imgname & "," & smsflag & "," & SendRegEmail & "," & request("Search_G") & "," & bmflag_1 & "," & bmflag_2 & "," & bmflag_3 & "," & bmflag_4 & "," & bmflag_5 & "," & RegFaceNum & "," & request("viewcolor") & "," & SmallPaper & "," & SmallPaper_g & "," & SmallPaper_m & "," & FontSize & "," & FontHeight & "," & BbsUserInfo & "," & DvbbsSkin & "," & SkinFontNum & "," & UpLoadPath & "," & UserubbCode & "," & UserHtmlCode & "," & UserImgCode & "," & TopUserNum & "," & PostRetrun & "," & UserPostAdmin & "," & bbsEven & "," & bbsEvenView
'response.write forum_setting
'response.end
sql="update board set Forum_Setting='"&Forum_Setting&"',Forum_upload='"&request("Forum_upload")&"' where boardid="&request("boardid")
conn.execute(sql)
response.write "设置成功。"
end if
end sub

sub editbmcolor()
dim master_1,chkedit
set rs=conn.execute("select boardmaster from board where boardid="&request("boardid"))
if rs.eof and rs.bof then
Errmsg=Errmsg+"<br>"+"<li>您没有指定相应论坛ID，不能进行管理。"
call error()
exit sub
end if
master_1=split(rs(0),"|")
if bmflag_5=1 then
chkedit=true
else
if bmflag_3=0 then
chkedit=false
elseif bmflag_3=1 and membername=master_1(0) then
chkedit=true
else
chkedit=false
end if
end if
if master then
chkedit=true
end if
if chkedit=false then
	Errmsg=Errmsg+"<br>"+"<li>本项功能未对您开放。"
	call error()
else
%>
<form method="POST" action="?action=savebmcolor&boardid=<%=request("boardid")%>">
<table width="95%" border="0" cellspacing="1" cellpadding="3"  align=center bordercolor=<%=aTablebackcolor%>>
<script>
function color(para_URL){var URL =new String(para_URL)
window.open(URL,'','width=300,height=220,noscrollbars')}
</SCRIPT>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td height="23" colspan="3" ><font color="<%=TableContentColor%>"><b>论坛界面设置</b></font>&nbsp;单击 <a href="javascript:color('color.asp')"><font color="<%=TableContentColor%>">这里</font></a> 使用万用颜色拾取器</td>
</tr>
<tr> 
<td width="45%"><font color="<%=TableContentColor%>"><B>论坛BODY标签</B><br>
控制整个论坛风格的背景颜色或者背景图片等</font></td>
<td width="5%"></td>
<td width="50%"> 
<input type="text" name="ForumBody" size="35" value="<%=ForumBody%>">
</td>
</tr>
<tr bgcolor="<%=Tablebodycolor%>"> 
<td width="45%"><font color="<%=TableContentColor%>"><B>浏览器边框颜色</B></font></td>
<td width="5%" bgcolor="<%=IEbarcolor%>"></td>
<td width="50%"> 
<input type="text" name="iebarcolor" size="35" value="<%=iebarcolor%>">
</td>
</tr>
<tr bgcolor="<%=Tablebodycolor%>"> 
<td width="45%"><font color="<%=TableContentColor%>"><B>顶部菜单表格背景(深背景)</B></font></td>
<td width="5%" bgcolor="<%=NavDarkcolor%>"></td>
<td width="50%"> 
<input type="text" name="NavDarkcolor" size="35" value="<%=NavDarkcolor%>">
</td>
</tr>
<tr bgcolor="<%=Tablebodycolor%>"> 
<td width="45%"><font color="<%=TableContentColor%>"><B>顶部菜单表格背景(浅背景)</B></font></td>
<td width="5%" bgcolor="<%=Navlighcolor%>"></td>
<td width="50%"> 
<input type="text" name="Navlighcolor" size="35" value="<%=Navlighcolor%>">
</td>
</tr>
<tr> 
<td width="45%"><font color="<%=TableContentColor%>"><B>表格边框颜色一</B><br>
一般页面</font></td>
<td width="5%" bgcolor="<%=Tablebackcolor%>"></td>
<td width="50%"> 
<input type="text" name="Tablebackcolor" size="35" value="<%=Tablebackcolor%>">
</td>
</tr>
<tr> 
<td width="45%"><font color="<%=TableContentColor%>"><B>表格边框颜色二</B><br>
用户页面、提示页面</font></td>
<td width="5%" bgcolor="<%=aTablebackcolor%>"></td>
<td width="50%"> 
<input type="text" name="aTablebackcolor" size="35" value="<%=aTablebackcolor%>">
</td>
</tr>
<tr> 
<td width="45%"><font color="<%=TableContentColor%>"><B>标题表格颜色一（深背景）</B><br>
一般页面</font></td>
<td width="5%" bgcolor="<%=Tabletitlecolor%>"></td>
<td width="50%"> 
<input type="text" name="Tabletitlecolor" size="35" value="<%=Tabletitlecolor%>">
</td>
</tr>
<tr> 
<td width="45%"><font color="<%=TableContentColor%>"><B>标题表格颜色二（浅背景）</B><br>
用户页面、提示页面</font></td>
<td width="5%" bgcolor="<%=aTabletitlecolor%>"></td>
<td width="50%"> 
<input type="text" name="aTabletitlecolor" size="35" value="<%=aTabletitlecolor%>">
</td>
</tr>
<tr> 
<td width="45%"><font color="<%=TableContentColor%>"><B>表格体颜色一</B></font></td>
<td width="5%" bgcolor="<%=Tablebodycolor%>"></td>
<td width="50%"> 
<input type="text" name="Tablebodycolor" size="35" value="<%=Tablebodycolor%>">
</td>
</tr>
<tr> 
<td width="45%"><font color="<%=TableContentColor%>"><B>表格体颜色二</B>(1和2颜色在首页显示中穿插)</font></td>
<td width="5%" bgcolor="<%=aTablebodycolor%>"></td>
<td width="50%"> 
<input type="text" name="aTablebodycolor" size="35" value="<%=aTablebodycolor%>">
</td>
</tr>
<tr> 
<td width="45%"><font color="<%=TableContentColor%>"><B>表格标题栏字体颜色</B></font></td>
<td width="5%" bgcolor="<%=TableFontcolor%>"></td>
<td width="50%"> 
<input type="text" name="TableFontcolor" size="35" value="<%=TableFontcolor%>">
</td>
</tr>
<tr> 
<td width="45%"><font color="<%=TableContentColor%>"><B>表格内容栏字体颜色</B></font></td>
<td width="5%" bgcolor="<%=TableContentcolor%>"></td>
<td width="50%"> 
<input type="text" name="TableContentcolor" size="35" value="<%=TableContentcolor%>">
</td>
</tr>
<tr> 
<td width="45%"><font color="<%=TableContentColor%>"><B>警告提醒语句的颜色</B></font></td>
<td width="5%" bgcolor="<%=AlertFontColor%>"></td>
<td width="50%"> 
<input type="text" name="AlertFontColor" size="35" value="<%=AlertFontColor%>">
</td>
</tr>
<tr> 
<td width="45%"><font color="<%=TableContentColor%>"><B>显示帖子的时候，相关帖子，转发帖子，回复等的颜色</B></font></td>
<td width="5%" bgcolor="<%=ContentTitle%>"></td>
<td width="50%"> 
<input type="text" name="ContentTitle" size="35" value="<%=ContentTitle%>">
</td>
</tr>
<tr> 
<td width="45%"><font color="<%=TableContentColor%>"><B>网页字体颜色（表格外）</B></font></td>
<td width="5%" bgcolor="<%=BodyFontColor%>"></td>
<td width="50%"> 
<input type="text" name="BodyFontColor" size="35" value="<%=BodyFontColor%>">
</td>
</tr>
<tr> 
<td width="45%"><font color="<%=TableContentColor%>"><B>首页连接颜色</B><BR>如版面连接</font></td>
<td width="5%" bgcolor="<%=BoardLinkColor%>"></td>
<td width="50%"> 
<input type="text" name="BoardLinkColor" size="35" value="<%=BoardLinkColor%>">
</td>
</tr>
<tr> 
<td width="45%"><font color="<%=TableContentColor%>"><B>表格宽度</B></font></td>
<td width="5%"></td>
<td width="50%"> 
<input type="text" name="tablewidth" size="35" value="<%=tablewidth%>">
</td>
</tr>
<tr> 
<td width="45%"><font color="<%=TableContentColor%>"><B>一般用户名称字体颜色</B></font></td>
<td width="5%" bgcolor="<%=user_fc%>"></td>
<td width="50%"> 
<input type="text" name="user_fc" size="35" value="<%=user_fc%>">
</td>
</tr>
<tr> 
<td width="45%"><font color="<%=TableContentColor%>"><B>一般用户名称上的光晕颜色</B></font></td>
<td width="5%" bgcolor="<%=user_mc%>"></td>
<td width="50%"> 
<input type="text" name="user_mc" size="35" value="<%=user_mc%>">
</td>
</tr>
<tr> 
<td width="45%"><font color="<%=TableContentColor%>"><B>版主名称字体颜色</B></font></td>
<td width="5%" bgcolor="<%=bmaster_fc%>"></td>
<td width="50%"> 
<input type="text" name="bmaster_fc" size="35" value="<%=bmaster_fc%>">
</td>
</tr>
<tr> 
<td width="45%"><font color="<%=TableContentColor%>"><B>版主名称上的光晕颜色</B></font></td>
<td width="5%" bgcolor="<%=bmaster_mc%>"></td>
<td width="50%"> 
<input type="text" name="bmaster_mc" size="35" value="<%=bmaster_mc%>">
</td>
</tr>
<tr> 
<td width="45%"><font color="<%=TableContentColor%>"><B>管理员名称字体颜色</B></font></td>
<td width="5%" bgcolor="<%=master_fc%>"></td>
<td width="50%"> 
<input type="text" name="master_fc" size="35" value="<%=master_fc%>">
</td>
</tr>
<tr> 
<td width="45%"><font color="<%=TableContentColor%>"><B>版主名称上的光晕颜色</B></font></td>
<td width="5%" bgcolor="<%=master_mc%>"></td>
<td width="50%"> 
<input type="text" name="master_mc" size="35" value="<%=master_mc%>">
</td>
</tr>
<tr> 
<td width="45%"><font color="<%=TableContentColor%>"><B>贵宾名称字体颜色</B></font></td>
<td width="5%" bgcolor="<%=vip_fc%>"></td>
<td width="50%"> 
<input type="text" name="vip_fc" size="35" value="<%=vip_fc%>">
</td>
</tr>
<tr> 
<td width="45%"><font color="<%=TableContentColor%>"><B>贵宾名称上的光晕颜色</B></font></td>
<td width="5%" bgcolor="<%=vip_mc%>"></td>
<td width="50%"> 
<input type="text" name="vip_mc" size="35" value="<%=vip_mc%>">
</td>
</tr>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td width="45%">&nbsp;</td>
<td width="5%"></td>
<td width="50%"> 
<div align="center"> 
<input type="submit" name="Submit" value="提 交">
</div>
</td>
</tr>
</table>
</form>
<%
end if
end sub
sub savebmcolor()
dim Forum_body,master_1
dim chkedit
set rs=conn.execute("select boardmaster from board where boardid="&request("boardid"))
if rs.eof and rs.bof then
Errmsg=Errmsg+"<br>"+"<li>您没有指定相应论坛ID，不能进行管理。"
call error()
exit sub
end if
master_1=split(rs(0),"|")
if bmflag_5=1 then
chkedit=true
else
if bmflag_3=0 then
chkedit=false
elseif bmflag_3=1 and membername=master_1(0) then
chkedit=true
else
chkedit=false
end if
end if
if master then
chkedit=true
end if
if chkedit=false then
	Errmsg=Errmsg+"<br>"+"<li>本项功能未对您开放。"
	call error()
else
Forum_body=request("Tablebackcolor") & "," & request("aTablebackcolor") & "," & request("Tabletitlecolor") & "," & request("aTabletitlecolor") & "," & request("Tablebodycolor") & "," & request("aTablebodycolor") & "," & request("TableFontcolor") & "," & request("TableContentcolor") & "," & request("AlertFontColor") & "," & request("ContentTitle") & "," & request("AlertFontColor") & "," & request("ForumBody") & "," & request("TableWidth") & "," & request("BodyFontColor") & "," & request("BoardLinkColor") & "," & request("user_fc") & "," & request("user_mc") & "," & request("bmaster_fc") & "," & request("bmaster_mc") & "," & request("master_fc") & "," & request("master_mc") & "," & request("vip_fc") & "," & request("vip_mc") & "," & NavLighColor & "," & NavDarkColor & "," & IEbarColor
'response.write Forum_body
'response.end
sql = "update board set Forum_body='"&Forum_body&"' where boardid="&request("boardid")
conn.execute(sql)
response.write "设置成功！"
end if
end sub
%>
<!--#include file=footer.asp-->
