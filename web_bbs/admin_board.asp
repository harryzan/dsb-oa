<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=chkuser.asp-->
<!--#include file=md5.asp-->
<title><%=ForumName%>--管理页面</title>
<!--#include file="Forum_css.asp"-->

<BODY <%=ForumBody%>>
<%
	dim str

	if not master or instr(session("flag"),"01")=0 then
		Errmsg=Errmsg+"<br>"+"<li>本页面为管理员专用，请<a href=admin_index.asp target=_top>登陆</a>后进入。<br><li>您没有管理本页面的权限。"
		call Error()
	else
		call main()
		conn.close
		set conn=nothing
	end if

	sub main()
%>
<table cellpadding=0 cellspacing=0 border=0 width=<%=tablewidth%> bgcolor=<%=tablebackcolor%> align=center>
  <tr>
    <td>
      <table cellpadding=3 cellspacing=1 border=0 width=100%>
        <tr bgcolor='<%=Tabletitlecolor%>'>
        <td><font color="<%=TablefontColor%>">欢迎<b><%=membername%></b>进入管理中心</font>
        </td>
        </tr>
            <tr bgcolor=<%=tablebodycolor%>>
          <td width="100%" valign=top> <font color="<%=TableContentColor%>">
            <table width="100%" border="0" cellspacing="3" cellpadding="0">
              <tr>
                <td><font color="<%=TableContentColor%>">1．注意事项： 在下面，您将看到目前所有的论坛分类。您可以编辑论坛分类名或是增加一个新的论坛到这个分类中。 也可以编辑或删除目前存在的论坛。您可以对目前的分类重新进行排列。 
                   <p><font color=<%=AlertFontColor%>>2.特别注意</font>：删除论坛同时将删除该论坛下所有帖子！删除分类同时删除下属论坛和其中帖子！ 操作时请完整填写表单信息。</font>
                </td>
              </tr>
              <tr>
              <td>
              <p align=cetner><b><a href=admin_board.asp><font color="<%=TableContentColor%>">论坛管理</font></a> | <a href="admin_board.asp?action=addclass"><font color="<%=TableContentColor%>">新建论坛分类</font></a></p>
              </td>
              <tr>
            </table>
<%
select case Request("action")
case "add"
	call add()
case "edit"
	call edit()
case "savenew"
	call savenew()
case "savedit"
	call savedit()
case "del"
	call del()
case "orders"
	call orders()
case "updatorders"
	call updateorders()
case "addclass"
	call addclass()
case "saveclass"
	call saveclass()
case "del1"
	call del1()
case "mode"
	call mode()
case "savemod"
	call savemod()
case else
	call boardinfo()
end select
end sub

sub add()
%>
 <form action ="admin_board.asp?action=savenew" method=post>
<%
	dim boardnum
	set rs = server.CreateObject ("Adodb.recordset")
	sql="select Max(boardid) from board"
	rs.open sql,conn,1,1
	if rs.eof and rs.bof then
	boardnum=1
	else
	boardnum=rs(0)+1
	end if
	rs.close
%><B>论坛其它设置请添加论坛后在论坛版面管理首页点击相应连接</B>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr bgcolor=<%=aTableTitlecolor%>> 
<td width="52%" height=24><font color="<%=TableContentColor%>"><b>说明</b> </td>
<td width="48%"><font color="<%=TableContentColor%>"><b>内容</b> </td>
</tr>
<tr> 
<td width="52%" height=24><font color="<%=TableContentColor%>"><B>论坛序号</B><BR>注意不能和别的论坛序号相同</font></td>
<td width="48%"> 
<input type="text" name="newboardid" size="24" value=<%=boardnum+1%>>
</td>
</tr>
<tr> 
<td width="52%" height=24><font color="<%=TableContentColor%>"><B>论坛名称</B></font></td>
<td width="48%"> 
<input type="text" name="boardtype" size="24">
</td>
</tr>
<tr> 
<td width="52%" height=24><font color="<%=TableContentColor%>"><B>所属类别</B></font></td>
<td width="48%"> 
<select name=class>
<%
	sql = "select * from class"
	rs.open sql,conn,1,1
	if rs.eof and rs.bof then
	response.write "<option value=>请先添加类别"
	else
	do while not rs.EOF
%>
<option value=<%=rs("id")%>><%=rs("class")%> 
<%
	rs.MoveNext 
	loop
	end if
	rs.Close 
%>
</select>
</td>
</tr>
<tr> 
<td width="52%" height=24><font color="<%=TableContentColor%>"><B>版面说明</B></font></td>
<td width="48%"> 
<input type="text" name="readme" size="24">
</td>
</tr>
<tr> 
<td width="52%" height=24><font color="<%=TableContentColor%>"><B>论坛版主</B><BR>多版主添加请用|分隔，如：沙滩小子|wodeail</font></td>
<td width="48%"> 
<input type="text" name="boardmaster" size="24">
</td>
</tr>
<tr> 
<td width="52%" height=24><font color="<%=TableContentColor%>"><B>是否为隐含版面</B><BR>0表示开放，1表示隐含</font></td>
<td width="48%"> 
<select name="lockboard">
<option value="0" selected>0 
<option value="1">1 
</select>
</td>
</tr>
<tr> 
<td width="52%" height=24><font color="<%=TableContentColor%>"><B>首页显示论坛图片</B><BR>出现在首页论坛版面介绍左边<BR>请直接填写图片URL</font></td>
<td width="48%"> 
<input type="text" name="indexIMG" size="35" value="">
</td>
</tr>
<tr bgcolor="<%=atabletitlecolor%>"> 
<td width="52%" height=24>&nbsp;</td>
<td width="48%"> 
<input type="submit" name="Submit" value="添加论坛">
</td>
</tr>
</table>
</form>
<%
set rs=nothing
end sub

sub edit()
%>
 <form action ="admin_board.asp?action=savedit" method=post>           
<%
dim rs_c
set rs_c= server.CreateObject ("adodb.recordset")
sql = "select * from class"
rs_c.open sql,conn,1,1
set rs= server.CreateObject ("adodb.recordset")
sql = "select * from board where boardid="+CSTr(request("editid"))
rs.open sql,conn,1,1
%>            
<input type='hidden' name=editid value='<%=Request("editid")%>'>
<B>论坛其它修改设置请在论坛版面管理首页点击相应连接</B>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr bgcolor=<%=aTableTitleColor%>> 
<td width="52%" height=24><font color="<%=TableContentColor%>"><b>说明</b> </font></td>
<td width="48%"> 
<div align="center"><font color="<%=TableContentColor%>"><b>内容</b></font></div>
</td>
</tr>
<tr> 
<td width="52%" height=24><font color="<%=TableContentColor%>"><B>论坛序号</B><BR>注意不能和别的论坛序号相同</font></td>
<td width="48%"> 
<input type="text" name="newboardid" size="3"  value = '<%=rs("boardid")%>'>
</td>
</tr>
<tr> 
<td width="52%" height=24><font color="<%=TableContentColor%>"><B>论坛名称</B></font></td>
<td width="48%"> 
<input type="text" name="boardtype" size="24"  value = '<%=rs("boardtype")%>'>
</td>
</tr>
<tr> 
<td width="52%" height=24><font color="<%=TableContentColor%>"><B>所属类别</B></font></td>
<td width="48%"> 
<select name=class>
<% do while not rs_c.EOF%>
<option value=<%=rs_c("id")%> <% if cint(rs("class")) = rs_c("id") then%> selected <%end if%>><%=rs_c("class")%> 
<%
rs_c.MoveNext 
loop
rs_c.Close 
%>
</select>
</td>
</tr>
<tr> 
<td width="52%" height=24><font color="<%=TableContentColor%>"><B>版面说明</B></font></td>
<td width="48%"> 
<input type="text" name="readme" size="24" value='<%=rs("readme")%>'>
</td>
</tr>
<tr> 
<td width="52%" height=24><font color="<%=TableContentColor%>"><B>论坛版主</B><BR>多斑竹添加请用|分隔，如：沙滩小子|wodeail</font></td>
<td width="48%"> 
<input type="text" name="boardmaster" size="24"  value='<%=rs("boardmaster")%>'>
</td>
</tr>
<tr> 
<td width="52%" height=24><font color="<%=TableContentColor%>"><B>是否为隐含版面</B><BR>0表示开放，1表示隐含</font></td>
<td width="48%"> 
<select name="lockboard">
<option value="0" <%if rs("lockboard")=0 then%>selected<%end if%>>0 
<option value="1" <%if rs("lockboard")=1 then%>selected<%end if%>>1 
</select>
</td>
</tr>
<tr> 
<td width="52%" height=24><font color="<%=TableContentColor%>"><B>首页显示论坛图片</B><BR>出现在首页论坛版面介绍左边<BR>请直接填写图片URL</font></td>
<td width="48%">
<input type="text" name="indexIMG" size="35" value="<%=rs("indexIMG")%>">
</td>
</tr>
<tr bgcolor=<%=aTableTitleColor%>> 
<td width="52%" height=24>&nbsp;</td>
<td width="48%"> 
<input type="submit" name="Submit" value="提交修改">
</td>
</tr>
</table>
</form>
<%
rs.close
end sub
sub mode()
dim boarduser
%>
 <form action ="admin_board.asp?action=savemod" method=post>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr bgcolor=<%=aTableTitlecolor%>> 
<td width="52%" height=22><font color="<%=TableContentColor%>"><b>说明：</b> </font></td>
<td width="48%"><font color="<%=TableContentColor%>"><b>操作：</b> </font></td>
</tr>
<tr> 
<td width="52%" height=22><font color="<%=TableContentColor%>"><B>论坛名称</B></td>
<td width="48%"> <font color="<%=TableContentColor%>">
<%
set rs= server.CreateObject ("adodb.recordset")
sql="select boardid,boardtype,boarduser,boardskin from board where boardid="&request("boardid")
rs.open sql,conn,1,1
if rs.eof and rs.bof then
response.write "该版面并不存在。"
else
response.write rs(1)
response.write "<input type=hidden value="&rs(0)&" name=boardid>"
boarduser=rs(2)
boardskin=rs(3)
end if
rs.close
set rs=nothing
%></font>
</td>
</tr>
<tr> 
<td width="52%"><font color="<%=TableContentColor%>"><B>论坛类型</B>：<br>
常规论坛：允许会员发贴回帖，所有用户可浏览<BR>
开放论坛：所有用户可发贴回帖浏览<BR>
</td>
<td width="48%" valign=top> 
<select name="boardskin" size=1>
<option value=1 <%if boardskin=1 then%> selected <%end if%>>常规论坛</option>
<option value=2 <%if boardskin=2 then%> selected <%end if%>>开放论坛</option>
</select>
</td>
</tr>
<tr bgcolor="<%=atabletitlecolor%>"> 
<td width="52%" height=22>&nbsp;</td>
<td width="48%"> 
<input type="submit" name="Submit" value="设定">
</td>
</tr>
</table>
</form>
<%
end sub

sub savemod()
dim boarduser
dim boarduser_1
dim userlen
set rs= server.CreateObject ("adodb.recordset")
sql="select boardskin,boarduser from board where boardid="&request("boardid")
rs.open sql,conn,1,3
rs("boardskin")=request("boardskin")
response.write "<p>论坛设置成功！<br><br>"
if cint(request("boardskin"))=5 then
	if trim(request("vipuser"))<>"" then
	boarduser=request("vipuser")
	boarduser=split(boarduser,chr(13)&chr(10))
	for i = 0 to ubound(boarduser)
	if not (boarduser(i)="" or boarduser(i)=" ") then
		boarduser_1=""&boarduser_1&""&boarduser(i)&","
	end if
	next
	userlen=len(boarduser_1)
	if boarduser_1<>"" then
		boarduser=left(boarduser_1,userlen-1)
		rs("boarduser")=boarduser
		response.write "<p>添加用户："&boarduser&"<br><br>"
	else
		response.write "<p><font color=red>你没有添加认证用户</font><br><br>"
	end if
	end if
end if
rs.update
rs.close
set rs=nothing
end sub

sub boardinfo()
dim rs_1,rs_2
dim sql_1,sql_2
	    set rs_1 = server.CreateObject ("adodb.recordset")
            set rs_2 = server.CreateObject ("adodb.recordset")
            sql_2 = "select * from class order by id"
            rs_2.Open sql_2,conn,1,1
	    do while not rs_2.Eof
%>
            <table width="100%" border="0" cellspacing="3" cellpadding="0">
              <tr bgcolor="<%=aTableTitleColor%>">

                <td height="21"><font color="<%=TableContentColor%>"><B><%=rs_2("id")%>,分类名：<%=rs_2("class")%></b>    <a href="admin_board.asp?action=add"><font color="<%=TableContentColor%>">新增论坛</font></a> | <a href=admin_board.asp?action=orders&id=<%=rs_2("id")%>><font color="<%=TableContentColor%>">分类排序修改</font></a> | <a href=admin_board.asp?action=del1&id=<%=rs_2("id")%> onclick="{if(confirm('删除将包括该分类下所有论坛的所有帖子，确定删除吗?')){return true;}return false;}"><font color="<%=TableContentColor%>">删除分类</font></a></font></td>
              </tr>
            </table>
<%
            sql_1 = "select boardid,boardtype,readme from board where class="&rs_2("id")&" order by boardid"
            rs_1.Open sql_1,conn,1,1
            do while not rs_1.EOF 
            %>
            <table width="100%" border="0" cellspacing="3" cellpadding="0">
              <tr> 
                <td height="18"><font color="<%=TableContentColor%>"><%=rs_1("boardid")%>,<%=rs_1("boardtype")%></font></td>
              </tr>
              <tr>
                <td height="15"><a href="admin_board.asp?action=edit&editid=<%=rs_1("boardid")%>"><font color="<%=Boardlinkcolor%>"><U>基本信息一</U></font></a> | <a href="admin_var.asp?boardid=<%=rs_1("boardid")%>"><font color="<%=Boardlinkcolor%>"><U>基本信息二</U></font></a> | <a href="admin_use.asp?boardid=<%=rs_1("boardid")%>"><font color="<%=Boardlinkcolor%>"><U>使用设置</U></font></a> | <a href="admin_color.asp?boardid=<%=rs_1("boardid")%>"><font color="<%=Boardlinkcolor%>"><U>界面设置</U></font></a> | <a href="admin_pic.asp?boardid=<%=rs_1("boardid")%>"><font color="<%=Boardlinkcolor%>"><U>图片设置</U></font></a> | <a href="admin_ads.asp?boardid=<%=rs_1("boardid")%>"><font color="<%=Boardlinkcolor%>"><U>广告设置</U></font></a> | <a href="admin_board.asp?action=mode&boardid=<%=rs_1("boardid")%>"><font color="<%=Boardlinkcolor%>"><U>论坛模式</U></font></a> | <a href="admin_board.asp?action=del&editid=<%=rs_1("boardid")%>" onclick="{if(confirm('删除将包括该论坛所有帖子，确定删除吗?')){return true;}return false;}"><font color="<%=Boardlinkcolor%>"><U>删除</U></a></td>
              </tr>
            </table>
<hr color=black height=1 width="70%" align=left>
<%
		  rs_1.MoveNext
		  loop
                  rs_1.Close 
        rs_2.MoveNext 
        Loop
        rs_2.Close
%>
          </td>
            </tr>
        </table>      
        </td>
       </tr>
</table>
<%
set rs_1=nothing
set rs_2=nothing
end sub

sub savenew()
dim Forum_info,Forum_setting,Forum_ubb,Forum_body,Forum_ads,Forum_user
dim Forum_pic,Forum_boardpic,Forum_TopicPic,Forum_statePic,Forum_copyright
	set rs = server.CreateObject ("adodb.recordset")
	if request("boardtype")="" then
		Errmsg=Errmsg+"<br>"+"<li>请输入论坛名称。"
		Founderr=true
	end if
	if request("class")="" then
		Errmsg=Errmsg+"<br>"+"<li>请选择论坛分类。"
		Founderr=true
	end if
	if request("boardmaster")="" then
		Errmsg=Errmsg+"<br>"+"<li>请输入版主姓名。"
		Founderr=true
	end if
	if request("readme")="" then
		Errmsg=Errmsg+"<br>"+"<li>请输入论坛说明。"
		Founderr=true
	end if
	if request("lockboard")="" then
		Errmsg=Errmsg+"<br>"+"<li>请选择论坛开放状态。"
		Founderr=true
	end if
	if founderr=true then
	response.write ""&Errmsg&""
	else
		dim boardid
		sql="select boardid from board where boardid="+cstr(request("newboardid"))
		rs.open sql,conn,1,1
		if not rs.eof and not rs.bof then
			response.write "您不能指定和别的论坛一样的序号。"
			exit sub
		else
			boardid=request("newboardid")
		end if
		rs.close
	sql="select * from config where active=1"
	rs.open sql,conn,1,1
	Forum_Info=rs("Forum_Info")
	Forum_Setting=rs("Forum_Setting")
	Forum_ads=rs("Forum_ads")
	Forum_Body=rs("Forum_Body")
	Forum_user=rs("Forum_user")
	Forum_copyright=rs("Forum_copyright")
	Badwords=rs("Badwords")
	Splitwords=rs("Splitwords")
	StopReadme=rs("StopReadme")
	Forum_pic=rs("Forum_pic")
	Forum_boardpic=rs("Forum_boardpic")
	Forum_TopicPic=rs("Forum_TopicPic")
	Forum_statePic=rs("Forum_statePic")
	Forum_upload=rs("Forum_upload")
	Forum_ubb=rs("Forum_ubb")
	rs.close
	sql = "select * from board"
	rs.Open sql,conn,1,3
	rs.AddNew
	rs("boardid") = Request("newboardid")
	rs("boardtype") = Request.Form ("boardtype")
	rs("class") = Request.Form  ("class")
	rs("boardmaster") = Request("boardmaster")
	rs("readme") = Request("readme")
	rs("lockboard") = Trim(Request("lockboard"))
	rs("indexIMG")=request.form("indexIMG")
	rs("lasttopicnum") = 0 
	rs("lastbbsnum") = 0 
	rs("lasttopicnum") = 0 
	rs("todaynum") = 0 
	rs("boardskin")=1
	rs("LastPost")="$$"&Now()&"$$"

	rs("Forum_Info")=Forum_Info
	rs("Forum_Setting")=Forum_Setting
	rs("Forum_ads")=Forum_ads
	rs("Forum_Body")=Forum_Body
	rs("Forum_user")=Forum_user
	rs("Forum_copyright")=Forum_copyright
	rs("Badwords")=Badwords
	rs("Splitwords")=Splitwords
	rs("StopReadme")=StopReadme
	rs("Forum_pic")=Forum_pic
	rs("Forum_boardpic")=Forum_boardpic
	rs("Forum_TopicPic")=Forum_TopicPic
	rs("Forum_statePic")=Forum_statePic
	rs("Forum_upload")=Forum_upload
	rs("Forum_ubb")=Forum_ubb

	rs.Update 
	rs.Close 
	call addmaster(Request("boardmaster"))
	response.write "<p>论坛添加成功！<br><br>"&str
	end if
	set rs=nothing
end sub

sub savedit()
	dim newboardid
	set rs = server.CreateObject ("adodb.recordset")
	if request("newboardid")=request("editid") then
		newboardid=request("newboardid")
	else
		sql="select boardid from board where boardid="+cstr(request("newboardid"))
		rs.open sql,conn,1,1
		if not rs.eof and not rs.bof then
			response.write "您不能指定和别的论坛一样的序号。"
			exit sub
		else
			newboardid=request("newboardid")
		end if
		rs.close
	end if
	sql = "select * from board where boardid="+Cstr(request("editid"))
	rs.Open sql,conn,1,3
	rs("boardid") = Request.Form ("newboardid")
	rs("boardtype") = Request.Form ("boardtype")
	rs("class") = Request.Form  ("class")
	rs("boardmaster") = Request("boardmaster")
	rs("readme") = Request("readme")
	rs("lockboard") = Trim(Request("lockboard"))
	rs("indexIMG")=request.form("indexIMG")
	rs.Update 
	rs.Close
	set rs=nothing
	if request("newboardid")<>request("editid") then
	conn.execute("update bbs1 set boardid="&Request.Form ("newboardid")&" where boardid="+Cstr(request("editid")))
	end if
	call addmaster(Request("boardmaster"))
	response.write "<p>论坛修改成功！<br><br>"&str
end sub

sub del()
	set rs = server.CreateObject ("adodb.recordset")
	sql = "delete from board where boardid="+Cstr(Request("editid"))
	conn.execute(sql)
	sql = "delete from bbs1 where boardid="+cstr(Request("editid"))
	conn.execute(sql)
	set rs=nothing
	response.write "<p>论坛修改成功！"
end sub

sub del1()
	set rs = server.CreateObject ("adodb.recordset")
	sql = "delete from class where id="+Cstr(Request("id"))
	conn.execute(sql)
	sql = "delete from board where class="+Cstr(Request("id"))
	conn.execute(sql)
	sql="select boardid from board where class="+Cstr(Request("id"))
	rs.open sql,conn,1,1
	do while not rs.eof
	sql_1 = "delete from bbs1 where boardid="+cstr(rs("boardid"))
	conn.execute(sql_1)
	rs.movenext
	loop
	rs.close
	set rs=nothing
	response.write "<p>分类删除成功！"
end sub

sub orders()
%><br>
            <table width="95%" border="0" cellspacing="3" cellpadding="0" align=center>
              <tr> 
                <td height="22"><font color="<%=TableContentColor%>"><b>论坛分类重新排序修改</b><br>
注意：请在相应论坛分类的排序表单内输入相应的排列序号，注意不能和别的论坛分类有相同的排列序号。</font>
		</td>
              </tr>
	      <tr>
		<td><font color="<%=TableContentColor%>">
<%
	set rs = server.CreateObject ("Adodb.recordset")
	sql="select * from class where id="&cstr(request("id"))
	rs.open sql,conn,1,1
	if rs.eof and rs.bof then
		response.write "没有找到相应的论坛分类。"
	else
		response.write "<form action=admin_board.asp?action=updatorders method=post>"
		response.write "<input type=text name=classname size=25 value="&rs("class")&">"
		response.write "  <input type=text name=newid size=2 value="&rs("id")&">"
		response.write "<input type=hidden name=id value="&request("id")&">"
		response.write "<input type=submit name=Submit value=修改></form>"
	end if
	rs.close
	set rs=nothing
%>
		</td>
	      </tr>
            </table>
<%
end sub

sub updateorders()
	dim newid
	set rs = server.CreateObject ("Adodb.recordset")
	if request("newid")=request("id") then
		sql="update class set class='"&request("classname")&"' where id="&cstr(request("id"))
		conn.execute(sql)
		response.write "<p align=center>更新成功！</p>"
	else
	sql="select * from class where id="&cstr(request("newid"))
	rs.open sql,conn,1,1
	if not rs.eof and not rs.bof then
		response.write "您输入的序号和其他分类序号相同，请重新输入。"
	else
		sql="update class set id="&request("newid")&",class='"&request("classname")&"' where id="&cstr(request("id"))
		conn.execute(sql)
		sql="update board set class="&request("newid")&" where class="&cstr(request("id"))
		conn.execute(sql)
		response.write "<p align=center>更新成功！</p>"
	end if
	end if
	set rs=nothing
end sub

sub addclass()
	dim classnum
	set rs = server.CreateObject ("Adodb.recordset")
	sql="select id from class"
	rs.open sql,conn,1,1
	if rs.eof and rs.bof then
	classnum=0
	else
	classnum=rs.recordcount
	end if
	rs.close
%>
            <table width="95%" border="0" cellspacing="3" cellpadding="0" align=center>
              <tr> 
                <td height="22" bgcolor=<%=aTableTitleColor%>><font color="<%=TableContentColor%>"><b>添加新的论坛分类</b><br>
注意：请完整填写以下表单信息，注意不能和别的论坛分类有相同的排列序号。</font>
		</td>
              </tr>
<form action=admin_board.asp?action=saveclass method=post>
	      <tr>
		<td><font color="<%=TableContentColor%>">分类名：<input name=classname type=text size=25>  序号：
<input name=id type=text size=2 value=<%=classnum+1%>>   
<input type=submit name=Submit value=添加>
		</td>
	      </tr>
</form>
	    </table>
<%
set rs=nothing
end sub

sub saveclass()
	set rs = server.CreateObject ("Adodb.recordset")
	if request("id")="" or request("classname")="" then
		response.write "您输入的序号和原来的相同，不必更新啦：）"
	else
	sql="select * from class where id="&cstr(request("id"))
	rs.open sql,conn,1,1
	if not rs.eof and not rs.bof then
		response.write "您输入的序号和其他分类序号相同，请重新输入。"
	else
		sql="insert into class(id,class) values("&request("id")&",'"&request("classname")&"')"
		conn.execute(sql)
		response.write "<p align=center>更新成功！</p>"
	end if
	end if
	set rs=nothing
end sub

sub delclass()

end sub

sub addmaster(s)
	dim arr,i,rs,sql,pw
	randomize
	pw=Cint(rnd*9000)+1000
	if instr(s,"|")<>0 and instr(s,"|")<len(s) then
		arr=split(s,"|")
		set rs=server.createobject("adodb.recordset")
		for i=0 to Ubound(arr)
			sql="select username,userpassword,userclass from [user] where username='"& arr(i) &"'"
			rs.open sql,conn,1,3
			if rs.eof and rs.bof then
				rs.addnew
				rs("username")=arr(i)
				rs("userpassword")=md5(pw)
				rs("userclass")=19
				rs.update
				str=str&"你添加了以下用户：<b>" &arr(i) &"</b> 密码：<b>"& pw &"</b><br><br>"
			else
				if rs("userclass")<20 then
				rs("userclass")=19
				rs.update
				end if
			end if
			rs.close
		next
		set rs=nothing
	else
		set rs=server.createobject("adodb.recordset")
		sql="select username,userpassword,userclass from [user] where username='"& s &"'"
		rs.open sql,conn,1,3
		if rs.eof and rs.bof then
			rs.addnew
			rs("username")=s
			rs("userpassword")=md5(pw)
			rs("userclass")=19
			rs.update
			rs.close
			str=str&"你添加了以下用户：<b>" &s &"</b> 密码：<b>"& pw &"</b><br><br>"
		else
			if rs("userclass")<20 then
			rs("userclass")=19
			rs.update
			end if
		end if
		set rs=nothing
	end if
end sub
%>