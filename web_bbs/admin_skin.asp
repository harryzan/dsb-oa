<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=chkuser.asp-->
<!-- #include file="admin_config.asp" -->
<title><%=ForumName%>--管理页面</title>
<!--#include file="Forum_css.asp"-->

<BODY <%=ForumBody%>>
<%
	if not master or instr(session("flag"),"26")=0 then
		Errmsg=Errmsg+"<br>"+"<li>本页面为管理员专用，请<a href=admin_index.asp target=_top>登陆</a>后进入。<br><li>您没有管理本页面的权限。"
		call Error()
	else
		dim body
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
              <td width="100%" valign=top><p><font color="<%=TableContentColor%>">
<%
	select case request("action")
	case "news"
		call step1()
	case "step2"
		call saveskin()
	case "active"
		call active()
	case "delet"
		call delete()
	case "edit"
		call edit()
	case "savedit"
		call savedit()
	case else
		call skininfo()
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

	sub delete()
	set rs=conn.execute("select skinname from config where active=1 and id="&request("nskinid"))
	if rs.eof and rs.bof then
	conn.execute("delete from config where id="&request("nskinid"))
	response.write "删除成功。"
	else
	response.write "错误提示：当前使用的论坛模板不能删除，请先设置该模板为不是当前模板状态。"
	end if
	rs.close
	set rs=nothing
	end sub

	sub edit()
	set rs=conn.execute("select skinname from config where id="&request("skinid"))
%>
<form method="POST" action="?action=savedit">
<input type=hidden value="<%=request("skinid")%>" name="skinid">
<table width="95%" border="0" cellspacing="1" cellpadding="3"  align=center bordercolor=<%=aTablebackcolor%>>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td height="23" colspan="2" ><font color="<%=TableContentColor%>"><B>说明</B>：<BR>请详细填写以下信息，修改模板配置请返回点击相关连接。</font></td>
</tr>
<tr bgcolor=<%=Tabletitlecolor%>> 
<td height="23" colspan="2" ><font color=<%=TableFontcolor%>><b>修改模板名称</b></font></td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>模板名称</B></font></td>
<td width="60%"><font color="<%=TableContentColor%>"> 
<input type="text" name="SkinName" size="35" value="<%=rs(0)%>">
</td>
</tr>
<tr bgcolor=<%=Tabletitlecolor%>> 
<td width="40%"><font color="<%=TableContentColor%>">&nbsp;</td>
<td width="60%"><font color="<%=TableContentColor%>"> 
<div align="center"> 
<input type="submit" name="Submit" value="提交修改">
</div>
</td>
</tr>
</table>
</form>
<%
	rs.close
	set rs=nothing
	end sub

	sub savedit()
	conn.execute("update config set skinname='"&request("skinname")&"' where id="&request("skinid"))
	response.write "修改成功。"
	end sub

	sub skininfo()
%>
			  <form method=post action="admin_skin.asp?action=active">
              <table width="95%" border="0" cellspacing="3" cellpadding="0" align=center>
                <tr> 
                  <td colspan=2 bgcolor="<%=aTableTitleColor%>"> <font color="<%=TableContentColor%>">
                    <p><b>论坛模板选择管理</b>：<br>
                      注意：可点击相应模板进行统一查看和管理，可以设置某个模板为当前使用。由于相关的设置项目非常多，为了不至混淆，建议对当前使用的模板修改点击相应管理菜单进行修改，点击模板名称进行修改模板名。</p><B><a href=admin_skin.asp?action=news>添加新的模板</a></B></font>
                  </td>
                </tr>
                <tr bgcolor="<%=TableTitleColor%>"> 
                  <td width="83%" height=22><font color="<%=TablefontColor%>">&nbsp;<B>模板名称</B></font></td><td width="17%"><font color="<%=TablefontColor%>">&nbsp;<B>当前是否使用</B></font></td>
                </tr>
<%
	set rs=conn.execute("select id,active,skinname from config order by id desc")
	do while not rs.eof
%>
                <tr> 
                  <td height=25>&nbsp;<a href="admin_skin.asp?action=edit&skinid=<%=rs("id")%>"><%=rs(2)%></a>（<a href="admin_var.asp?skinid=<%=rs("id")%>"><font color="<%=Boardlinkcolor%>"><U>基本信息</U></font></a> | <a href="admin_use.asp?skinid=<%=rs("id")%>"><font color="<%=Boardlinkcolor%>"><U>使用设置</U></font></a> | <a href="admin_color.asp?skinid=<%=rs("id")%>"><font color="<%=Boardlinkcolor%>"><U>界面设置</U></font></a> | <a href="admin_pic.asp?skinid=<%=rs("id")%>"><font color="<%=Boardlinkcolor%>"><U>图片设置</U></font></a> | <a href="admin_ads.asp?skinid=<%=rs("id")%>"><font color="<%=Boardlinkcolor%>"><U>广告设置</U></font></a> | <a href="admin_skin.asp?action=delet&nskinid=<%=rs("id")%>" onclick="{if(confirm('删除后不可恢复，确定删除吗?')){return true;}return false;}"><font color="<%=Boardlinkcolor%>"><U>删除</U></font></a>）</td>
				  <td>&nbsp;<input type=radio name=skinid value="<%=rs(0)%>" <%if rs(1)=1 then%>checked<%end if%>></td>
                </tr>
<%
	rs.movenext
	loop
	rs.close
	set rs=nothing
%>
                <tr bgcolor="<%=TableTitleColor%>"> 
                  <td width="80%" height=22 align=right><font color="<%=TablefontColor%>">&nbsp;当前论坛默认使用模板只能选择一个&nbsp;</font></td><td width="50%"><font color="<%=TableContentColor%>"><input type=submit value="提 交" name=submit></td>
                </tr>
	       </table>
		   </form>
<%
	end sub

	sub step1()
%>
<form method="POST" action=?action=step2>
<table width="95%" border="0" cellspacing="1" cellpadding="3"  align=center bordercolor=<%=aTablebackcolor%>>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td height="23" colspan="2" ><font color="<%=TableContentColor%>"><B>说明</B>：<BR>请详细填写以下信息，只有填写完所有步骤的信息，该模板才能保存到论坛模板列表中。</font></td>
</tr>
<tr bgcolor=<%=Tabletitlecolor%>> 
<td height="23" colspan="2" ><font color=<%=TableFontcolor%>><b>论坛基本信息</b>(本模板其它信息在本步操作完成后在管理页面中修改)</font></td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>模板名称</B></td>
<td width="60%"><font color="<%=TableContentColor%>"> 
<input type="text" name="SkinName" size="35">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>论坛名称</B></td>
<td width="60%"><font color="<%=TableContentColor%>"> 
<input type="text" name="ForumName" size="35" value="<%=ForumName%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>论坛的url</B></td>
<td width="60%"><font color="<%=TableContentColor%>"> 
<input type="text" name="ForumURL" size="35" value="<%=ForumURL%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>主页名称</B></td>
<td width="60%"><font color="<%=TableContentColor%>"> 
<input type="text" name="CompanyName" size="35" value="<%=CompanyName%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>主页URL</B></td>
<td width="60%"><font color="<%=TableContentColor%>"> 
<input type="text" name="HostUrl" size="35" value="<%=HostUrl%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>SMTP Server地址</B><BR>只有在论坛使用设置中打开了发送邮件功能，该填写内容方有效</td>
<td width="60%"><font color="<%=TableContentColor%>"> 
<input type="text" name="SMTPServer" size="35" value="<%=SMTPServer%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>论坛管理员Email</B><BR>给用户发送邮件时，显示的来源Email信息</td>
<td width="60%"><font color="<%=TableContentColor%>"> 
<input type="text" name="SystemEmail" size="35" value="<%=SystemEmail%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>论坛首页Logo地址</B><BR>显示在论坛首页，添加论坛如果没有填写logo地址，则使用该内容</td>
<td width="60%"><font color="<%=TableContentColor%>"> 
<input type="text" name="Logo" size="35" value="<%=ForumLogo%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>论坛图片目录</B></td>
<td width="60%"><font color="<%=TableContentColor%>"> 
<input type="text" name="Picurl" size="35" value="<%=picurl%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>论坛表情目录</B></td>
<td width="60%"><font color="<%=TableContentColor%>"> 
<input type="text" name="Faceurl" size="35" value="<%=Faceurl%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>论坛所在时区</B></td>
<td width="60%"><font color="<%=TableContentColor%>"> 
<input type="text" name="GMT" size="35" value="<%=GMT%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>版权信息</B></td>
<td width="60%"><font color="<%=TableContentColor%>"> 
<input type="text" name="Copyright" size="35" value="<%=Copyright%>">
</td>
</tr>
<tr bgcolor=<%=Tabletitlecolor%>> 
<td width="40%"><font color="<%=TableContentColor%>">&nbsp;</td>
<td width="60%"><font color="<%=TableContentColor%>"> 
<div align="center"> 
<input type="submit" name="Submit" value="下一步">
</div>
</td>
</tr>
</table>
</form>
<%
	end sub

	sub saveskin()
dim ars
dim Forum_info
dim Forum_copyright
dim skinname
Forum_info=Request("ForumName") & "," & Request("ForumURL") & "," & Request("CompanyName") & "," & Request("HostUrl") & "," & Request("SMTPServer") & "," & Request("SystemEmail") & "," & Request("Logo") & "," & Request("Picurl") & "," & Request("Faceurl") & "," & Request("GMT")
Forum_copyright=request("copyright")
skinName=request("skinname")

set Ars=conn.execute("select * from config where active=1")

set rs = server.CreateObject ("adodb.recordset")
sql="select * from config"
rs.open sql,conn,1,3
rs.addnew
rs("Forum_body")=ars("Forum_body")
rs("Forum_info")=Forum_info
rs("Forum_copyright")=Forum_copyright
rs("skinname")=skinname
rs("Forum_Setting")=ars("Forum_Setting")
rs("StopReadme")=ars("StopReadme")
rs("Forum_upload")=ars("Forum_upload")
rs("Forum_ubb")=ars("Forum_ubb")
rs("Forum_statepic")=ars("Forum_statepic")
rs("Forum_topicpic")=ars("Forum_topicpic")
rs("Forum_boardpic")=ars("Forum_boardpic")
rs("Forum_pic")=ars("Forum_pic")
rs("Forum_ads")=ars("Forum_ads")
rs("Forum_user")=ars("Forum_user")
rs("badwords")=badwords
rs("splitwords")=splitwords
rs("birthuser")=ars("birthuser")
rs("Maxonline")=ars("Maxonline")
rs("MaxonlineDate")=ars("MaxonlineDate")
rs("LastPost")="$$"&Now()&"$$"
rs("active")=0
rs.update
rs.close
set rs=nothing
response.write "模板添加成功。"
	end sub

	sub active()
	set rs=conn.execute("select * from config where active=1")
	conn.execute("update config set active=0 where active=1")
	conn.execute("update config set active=1,Maxonline="&rs("Maxonline")&",MaxonlineDate='"&rs("MaxonlineDate")&"',TopicNum="&rs("TopicNum")&",BbsNum="&rs("BbsNum")&",TodayNum="&rs("TodayNum")&",UserNum="&rs("UserNum")&",lastUser='"&rs("lastUser")&"' where id="&request("skinid"))
	response.write "更新成功，<a href=admin_skin.asp>返回</a>。"
	rs.close
	set rs=nothing
	end sub
%>