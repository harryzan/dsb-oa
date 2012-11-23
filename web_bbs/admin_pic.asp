<!--#include file =conn.asp-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=chkuser.asp-->
<title><%=ForumName%>--管理页面</title>
<!--#include file="Forum_css.asp"-->
<meta NAME=GENERATOR Content=""Microsoft FrontPage 3.0"" CHARSET=GB2312>
<BODY <%=ForumBody%>>
<%
	if not master or instr(session("flag"),"24")=0 then
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
        <td align=center colspan="2"><font color="<%=TablefontColor%>">欢迎<b><%=membername%></b>进入管理页面</font>
        </td>
        </tr>
            <tr bgcolor=<%=tablebodycolor%>>
              <td width="100%" valign=top><font color="<%=TableContentColor%>">
<%
if request("action")="save" then
call saveconst()
else
call consted()
end if
if founderr then call error()
%></font>
	      </td>
            </tr>
        </table>
        </td>
    </tr>
</table>
<%
end sub

sub consted()
dim sel
%>
<form method="POST" action=admin_pic.asp?action=save>
  <table width="95%" border="0" cellspacing="1" cellpadding="3"  align=center bordercolor=<%=aTablebackcolor%>>
    <tr bgcolor=<%=aTabletitlecolor%>> 
      <td height="23" colspan="2" ><font color="<%=TableContentColor%>"><B>说明</B>：<BR>
        1、复选框中选择的为当前的使用设置模板，点击可查看该模板设置，点击别的模板直接查看该模板并修改设置。您可以将您下面的设置保存在多个论坛风格模板中<BR>
        2、您也可以将下面设定的信息保存并应用到具体的分论坛设置中，可多选<BR>
        3、如果您想在一个版面引用别的版面或模板的配置，只要点击该版面或模板名称，保存的时候选择要保存到的版面名称或模板名称即可。<br>
        4、以下图片均保存于论坛pic目录中，如要更换也请将图放于该目录</font></td>
    </tr>
    <tr> 
      <td width="100%" colspan=2><font color="<%=TableContentColor%>"><B>当前使用主模板</B>（可将设置保存到下列模板中）<BR>
        <%
set rs = server.CreateObject ("adodb.recordset")
sql="select * from config"
rs.open sql,conn,1,1
do while not rs.eof
if request("skinid")="" then
	if request("boardid")="" then
	if rs("active")=1 then
	sel="checked"
	else
	sel=""
	end if
	else
	sel=""
	end if
else
	if rs("id")=cint(request("skinid")) then
	sel="checked"
	else
	sel=""
	end if
end if
response.write "<input type=checkbox name=skinid value="&rs("id")&" "&sel&"><a href=admin_pic.asp?skinid="&rs("id")&"><font color="&TableContentColor&">"&rs("skinname")&"</font></a>&nbsp;"
rs.movenext
loop
rs.close
set rs=nothing
%>
        </font> </td>
    </tr>
    <tr> 
      <td width="100%" colspan=2><font color="<%=TableContentColor%>"><B>当前使用分论坛模板</B>（可将设置保存到下列论坛中）<BR>
        <%
set rs = server.CreateObject ("adodb.recordset")
sql="select * from board"
rs.open sql,conn,1,1
do while not rs.eof
if request("boardid")<>"" or isnumeric(request("boardid")) then
if rs("boardid")=cint(request("boardid")) then
sel="checked"
else
sel=""
end if
end if
response.write "<input type=checkbox name=boardid value="&rs("boardid")&" "&sel&"><a href=admin_pic.asp?boardid="&rs("boardid")&"><font color="&TableContentColor&">" & rs("boardtype") & "</font></a>&nbsp;"
rs.movenext
loop
rs.close
set rs=nothing
%>
        </font> </td>
    </tr>
    <tr bgcolor=<%=aTabletitlecolor%>> 
      <td height="23" colspan="2" ><font color="<%=TableContentColor%>"><b>在线图片设置</b></font></td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>论坛管理员</B></font></td>
      <td width="60%"> <input type="text" name="pic_om" size="20" value="<%=pic_om%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=pic_om%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>论坛版主</B></font></td>
      <td width="60%"> <input type="text" name="pic_ob" size="20" value="<%=pic_ob%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=pic_ob%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>普通会员</B></font></td>
      <td width="60%"> <input type="text" name="pic_ou" size="20" value="<%=pic_ou%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=pic_ou%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>客人或隐身会员</B></font></td>
      <td width="60%"> <input type="text" name="pic_oh" size="20" value="<%=pic_oh%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=pic_oh%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>突出显示自己的颜色</B></font></td>
      <td width="60%"> <input type="text" name="online_mc" size="20" value="<%=online_mc%>"> 
        &nbsp;&nbsp;<font color=<%=online_mc%>>自己</font> </td>
    </tr>
    <tr bgcolor=<%=aTabletitlecolor%>> 
      <td height="23" colspan="2" ><font color=<%=TableFontcolor%>><b>论坛图例</b></font></td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>常规论坛－－有新帖子</B></font></td>
      <td width="60%"> <input type="text" name="F_mode1_n" size="20" value="<%=F_mode1_n%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=F_mode1_n%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>常规论坛－－无新帖子</B></font></td>
      <td width="60%"> <input type="text" name="F_mode1_o" size="20" value="<%=F_mode1_o%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=F_mode1_o%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>开放论坛－－有新帖子</B></font></td>
      <td width="60%"> <input type="text" name="F_mode2_n" size="20" value="<%=F_mode2_n%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=F_mode2_n%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>开放论坛－－无新帖子</B></font></td>
      <td width="60%"> <input type="text" name="F_mode2_o" size="20" value="<%=F_mode2_o%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=F_mode2_o%>> </td>
    </tr>
    <tr bgcolor=<%=aTabletitlecolor%>> 
      <td height="23" colspan="2" ><font color=<%=TableFontcolor%>><b>论坛主体图标</b></font></td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>发表帖子</B></font></td>
      <td width="60%"> <input type="text" name="P_post" size="20" value="<%=P_post%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_post%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>回复帖子</B></font></td>
      <td width="60%"> <input type="text" name="P_reply" size="20" value="<%=P_reply%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_reply%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>帮助</B></font></td>
      <td width="60%"> <input type="text" name="P_help" size="20" value="<%=P_help%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_help%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>返回首页</B></font></td>
      <td width="60%"> <input type="text" name="P_gohome" size="20" value="<%=P_gohome%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_gohome%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>返回上级目录</B></font></td>
      <td width="60%"> <input type="text" name="P_folder" size="20" value="<%=P_folder%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_folder%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>当前目录</B></font></td>
      <td width="60%"> <input type="text" name="P_ofolder" size="20" value="<%=P_ofolder%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_ofolder%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>新的短消息</B></font></td>
      <td width="60%"> <input type="text" name="P_newmsg" size="20" value="<%=P_newmsg%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_newmsg%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>我发表的主题</B></font></td>
      <td width="60%"> <input type="text" name="P_mytopic" size="20" value="<%=P_mytopic%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_mytopic%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>树形浏览帖子模式</B></font></td>
      <td width="60%"> <input type="text" name="P_treeview" size="20" value="<%=P_treeview%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_treeview%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>平板形浏览帖子模式</B></font></td>
      <td width="60%"> <input type="text" name="P_flatview" size="20" value="<%=P_flatview%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_flatview%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>下一篇帖子</B></font></td>
      <td width="60%"> <input type="text" name="P_nexttopic" size="20" value="<%=P_nexttopic%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_nexttopic%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>上一篇帖子</B></font></td>
      <td width="60%"> <input type="text" name="P_backTopic" size="20" value="<%=P_backTopic%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_backTopic%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>刷新浏览</B></font></td>
      <td width="60%"> <input type="text" name="P_reflash" size="20" value="<%=P_reflash%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_reflash%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>论坛公告</B></font></td>
      <td width="60%"> <input type="text" name="P_call" size="20" value="<%=P_call%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_call%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>打开的主题</B></font></td>
      <td width="60%"> <input type="text" name="P_opentopic" size="20" value="<%=P_opentopic%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_opentopic%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>查看最新的帖子</B></font></td>
      <td width="60%"> <input type="text" name="P_newTopic" size="20" value="<%=P_newTopic%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_newTopic%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>查看用户列表</B></font></td>
      <td width="60%"> <input type="text" name="P_userlist" size="20" value="<%=P_userlist%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_userlist%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>查看发贴排行</B></font></td>
      <td width="60%"> <input type="text" name="P_Top20" size="20" value="<%=P_Top20%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_Top20%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>当前时间</B></font></td>
      <td width="60%"> <input type="text" name="P_nowTime" size="20" value="<%=P_nowTime%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_nowTime%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>在线用户（左边状态栏）</B></font></td>
      <td width="60%"> <input type="text" name="P_online_s" size="20" value="<%=P_online_s%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_online_s%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>用户信息（左边状态栏）</B></font></td>
      <td width="60%"> <input type="text" name="P_userfrom" size="20" value="<%=P_userfrom%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_userfrom%>> </td>
    </tr>
    <tr bgcolor=<%=aTabletitlecolor%>> 
      <td height="23" colspan="2" ><font color=<%=TableFontcolor%>><b>论坛帖子图标</b></font></td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>报告本帖给版主</B></font></td>
      <td width="60%"> <input type="text" name="P_report" size="20" value="<%=P_report%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_report%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>把本帖加入IE收藏</B></font></td>
      <td width="60%"> <input type="text" name="P_iefav" size="20" value="<%=P_iefav%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_iefav%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>发送短信给好友</B></font></td>
      <td width="60%"> <input type="text" name="P_sms" size="20" value="<%=P_sms%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_sms%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>浏览用户信息</B></font></td>
      <td width="60%"> <input type="text" name="P_userinfo" size="20" value="<%=P_userinfo%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_userinfo%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>搜索用户发表帖子</B></font></td>
      <td width="60%"> <input type="text" name="P_search" size="20" value="<%=P_search%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_search%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>用户联系地址</B></font></td>
      <td width="60%"> <input type="text" name="P_homepage" size="20" value="<%=P_homepage%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_homepage%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>编辑帖子</B></font></td>
      <td width="60%"> <input type="text" name="P_edit" size="20" value="<%=P_edit%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_edit%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>删除帖子</B></font></td>
      <td width="60%"> <input type="text" name="P_delete" size="20" value="<%=P_delete%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_delete%>> </td>
    </tr>
    <tr> 
      <td><font color="<%=TableContentColor%>"><B>复制帖子</B></font></td>
      <td width="60%"> <input type="text" name="P_copy" size="20" value="<%=P_copy%>"> 
        &nbsp;&nbsp;<img src=<%=picurl%><%=P_copy%>> </td>
    </tr>

    <tr bgcolor=<%=aTabletitlecolor%>> 
      <td><font color="<%=TableContentColor%>">&nbsp;</td>
      <td width="60%"> <div align="center"> 
          <input type="submit" name="Submit" value="提 交">
        </div></td>
    </tr>
  </table>
</form>
<%
end sub

sub saveconst()
dim Forum_pic
if trim(request("skinid"))="" and trim(request("boardid"))="" then
Founderr=true
Errmsg=Errmsg+"<br>"+"<li>请选择保存的模板名称"
else
Forum_pic=request("pic_om") & "," & request("pic_ob") & "," & request("pic_ov") & "," & request("pic_ou") & "," & request("pic_oh") & "," & request("online_mc") & "," & request("F_mode1_o") & "," & request("F_mode1_n") & "," & request("F_mode2_o") & "," & request("F_mode2_n") & "," & request("F_mode3_o") & "," & request("F_mode3_n") & "," & request("F_mode4_n") & "," & request("F_mode4_n") & "," & request("F_mode5_o") & "," & request("F_mode5_n") & "," & request("F_mode6_o") & "," & request("F_mode6_n") & ",ifolder.gif,foldernew.gif"

dim Forum_boardpic
Forum_boardpic=request("F_link") & "," & request("P_post") & "," & request("P_vote") & "," & request("P_paper") & "," & request("P_reply") & "," & request("P_help") & "," & request("P_gohome") & "," & request("P_folder") & "," & request("P_ofolder") & "," & request("P_newmsg") & "," & request("P_mytopic") & "," & request("P_treeview") & "," & request("P_flatview") & "," & request("P_nexttopic") & "," & request("P_backTopic") & "," & request("P_reflash") & "," & request("P_call")

dim Forum_topicPic
Forum_TopicPic=request("P_save") & "," & request("P_report") & "," & request("P_print") & "," & request("P_EmailPost") & "," & request("P_bbsfav") & "," & request("P_EmailPage") & "," & request("P_iefav") & "," & request("P_sms") & "," & request("P_search") & "," & request("P_userinfo") & "," & request("P_Email") & "," & request("P_oicq") & "," & request("P_icq") & "," & request("P_msn") & "," & request("P_homepage") & "," & request("P_quote") & "," & request("P_edit") & "," & request("P_delete") & "," & request("P_copy") & "," & request("P_isbest") & "," & request("P_ip") & "," & request("P_friend")

dim Forum_statePic
Forum_statePic=request("P_opentopic") & "," & request("P_hotTopic") & "," & request("P_closeTopic") & "," & request("P_istop") & "," & request("P_Tisbest") & "," & request("P_newTopic") & "," & request("P_userlist") & "," & request("P_Top20") & "," & request("P_nowTime") & "," & request("P_online_s") & "," & request("P_birth") & "," & request("P_userfrom") & "," & request("P_isvote")

dim Forum_ubb
Forum_ubb=request("bold") & "," & request("italicize") & "," & request("underline") & "," & request("center") & "," & request("url1") & "," & request("email1") & "," & request("image") & "," & request("swf") & "," & request("Shockwave") & "," & request("rm") & "," & request("mp") & "," & request("qt") & "," & request("quote1") & "," & request("fly") & "," & request("move") & "," & request("glow") & "," & request("shadow")
'response.write Forum_Topicpic & "<br>" & Forum_boardpic & "<br>" & Forum_statePic
if request("skinid")<>"" then
sql = "update config set Forum_pic='"&Forum_pic&"',Forum_boardpic='"&Forum_boardpic&"',Forum_TopicPic='"&Forum_TopicPic&"',Forum_statePic='"&Forum_statePic&"',Forum_ubb='"&Forum_ubb&"' where id in ( "&request("skinid")&" )"
conn.execute(sql)
end if
if request("boardid")<>"" then
sql = "update board set Forum_pic='"&Forum_pic&"',Forum_boardpic='"&Forum_boardpic&"',Forum_TopicPic='"&Forum_TopicPic&"',Forum_statePic='"&Forum_statePic&"' where boardid in ( "&request("boardid")&" )"
conn.execute(sql)
end if
response.write "设置成功。"
end if
end sub
%>