<!--#include file =conn.asp-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=chkuser.asp-->
<title><%=ForumName%>--管理页面</title>
<!--#include file="Forum_css.asp"-->
<meta NAME=GENERATOR Content=""Microsoft FrontPage 3.0"" CHARSET=GB2312>
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
<BODY <%=ForumBody%>>
<%
	if not master or instr(session("flag"),"22")=0 then
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
<form method="POST" action=admin_use.asp?action=save>
<table width="95%" border="0" cellspacing="1" cellpadding="3"  align=center bordercolor=<%=aTablebackcolor%> style="font-size:9pt;line-height: 13pt">
<tr bgcolor=<%=aTabletitlecolor%>> 
<td height="23" colspan="2" ><font color="<%=TableContentColor%>"><B>说明</B>：<BR>1、复选框中选择的为当前的使用设置模板，点击可查看该模板设置，点击别的模板直接查看该模板并修改设置。您可以将您下面的设置保存在多个论坛风格模板中<BR>2、您也可以将下面设定的信息保存并应用到具体的分论坛设置中，可多选<BR>3、如果您想在一个版面引用别的版面或模板的配置，只要点击该版面或模板名称，保存的时候选择要保存到的版面名称或模板名称即可。</font></td>
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
response.write "<input type=checkbox name=skinid value="&rs("id")&" "&sel&"><a href=admin_use.asp?skinid="&rs("id")&"><font color="&TableContentColor&">"&rs("skinname")&"</font></a>&nbsp;"
rs.movenext
loop
rs.close
set rs=nothing
%></font>
</td></tr>
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
response.write "<input type=checkbox name=boardid value="&rs("boardid")&" "&sel&"><a href=admin_use.asp?boardid="&rs("boardid")&"><font color="&TableContentColor&">" & rs("boardtype") & "</font></a>&nbsp;"
rs.movenext
loop
rs.close
set rs=nothing
%></font>
</td></tr>
<%
if boardid>0 then
call admin_board()
call admin_config()
else
call admin_config()
call admin_board()
end if
%>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td width="50%"><font color="<%=TableContentColor%>">&nbsp;</td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<div align="center"> 
<input type="submit" name="Submit" value="提 交">
</div>
</td>
</tr>
</table>
</form>
<%
end sub

sub saveconst()
dim Forum_Setting
if trim(request("skinid"))="" and trim(request("boardid"))="" then
Founderr=true
Errmsg=Errmsg+"<br>"+"<li>请选择保存的模板名称"
else
Forum_Setting=request.Form("TimeAdjust") & "," & request.Form("ScriptTimeOut") & "," & request.Form("EmailFlag") & "," & request.Form("Uploadpic") & "," & request.Form("IpFlag") & "," & request.Form("FromFlag") & "," & request.Form("TitleFlag") & "," & request.Form("uploadFlag") & "," & request.Form("kicktime") & "," & request.Form("guestlogin") & "," & request.Form("openmsg") & "," & request.Form("MaxAnnouncePerPage") & "," & request.Form("Maxtitlelist") & "," & request.Form("AnnounceMaxBytes") & "," & request.Form("online_u") & "," & request.Form("online_g") & "," & request.Form("LinkFlag") & "," & request.Form("TopicFlag") & "," & request.Form("VoteFlag") & "," & request.Form("ReflashFlag") & "," & request.Form("ReflashTime") & "," & request.Form("ForumStop") & "," & request.Form("RegTime") & "," & request.Form("EmailReg") & "," & request.Form("EmailRegOne") & "," & request.Form("RegFlag") & "," & request.Form("online_n") & "," & request.Form("ViewUser_g") & "," & request.Form("ViewUser_u") & "," & request.Form("BirthFlag") & "," & request.Form("runtime") & "," & request.Form("FastLogin") & "," & request.Form("GroupFlag") & "," & request.Form("uploadsize") & "," & request.Form("strAllowForumCode") & "," & request.Form("strAllowHTML") & "," & request.Form("strIMGInPosts") & "," & request.Form("strIcons") & "," & request.Form("strflash") & "," & request.Form("vote_num") & "," & request.Form("facenum") & "," & request.Form("imgnum") & "," & request.Form("relaypost") & "," & request.Form("relayposttime") & "," & request.Form("facename") & "," & request.Form("imgname") & "," & request.Form("smsflag") & "," & request.Form("SendRegEmail") & "," & request.Form("Search_G") & "," & request.Form("bmflag_1") & "," & request.Form("bmflag_2") & "," & request.Form("bmflag_3") & "," & request.Form("bmflag_4") & "," & request.Form("bmflag_5") & "," & request.Form("RegFaceNum") & "," & request.Form("viewcolor") & "," & request.Form("SmallPaper") & "," & request.Form("SmallPaper_g") & "," & request.Form("SmallPaper_m")
Forum_Setting=Forum_Setting & "," & request.Form("FontSize") & "," & request.Form("FontHeight") & "," & request.Form("BbsUserInfo") & "," & request.Form("DvbbsSkin") & "," & request.Form("SkinFontNum") & "," & request.Form("UpLoadPath") & "," & request.Form("UserubbCode") & "," & request.Form("UserHtmlCode") & "," & request.Form("UserImgCode") & "," & request.Form("TopUserNum") & "," & request.Form("PostRetrun") & "," & request.Form("UserPostAdmin") & "," & request.Form("bbsEven") & "," & request.Form("bbsEvenView")
if request("skinid")<>"" then
sql="update config set Forum_Setting='"&Forum_Setting&"',StopReadme='"&request.Form("StopReadme")&"',Forum_upload='"&request.Form("Forum_upload")&"' where id in ( "&request("skinid")&" )"
conn.execute(sql)
end if
if request("boardid")<>"" then
sql="update board set Forum_Setting='"&Forum_Setting&"',StopReadme='"&request.Form("StopReadme")&"',Forum_upload='"&request.Form("Forum_upload")&"' where boardid in ( "&request("boardid")&" )"
conn.execute(sql)
end if
response.write "设置成功。"
end if
end sub

sub admin_config()
%>
<tr bgcolor=<%=Tabletitlecolor%>> 
<td height="23" colspan="2" ><font color="<%=TableContentColor%>"><a name="config"><b>论坛总使用设置</b>
</a>(如果您正在<a href="#board"><font color=red>设置分论坛</font></a>，下列内容可忽略)</font></td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>论坛当前状态</U><BR>维护期间可设置关闭论坛使用</td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<input type=radio name="ForumStop" value=0 <%if cint(ForumStop)=0 then%>checked<%end if%>>打开&nbsp;
<input type=radio name="ForumStop" value=1 <%if cint(ForumStop)=1 then%>checked<%end if%>>关闭&nbsp;
</td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>维护说明</U><BR>在论坛关闭情况下显示，支持html语法</td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<textarea name="StopReadme" cols="40" rows="3"><%=StopReadme%></textarea>
</td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>服务器时差</U></td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<select name="TimeAdjust">
<%for i=-23 to 23%>
<option value="<%=i%>" <%if cint(i)=cint(TimeAdjust) then%>selected<%end if%>><%=i%>
<%next%>
</select>
</td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>脚本超时时间</U><BR>默认为300，一般不做更改</td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<input type="text" name="ScriptTimeOut" size="3" value="<%=ScriptTimeOut%>">&nbsp;秒
</td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>一个Email只能注册一个帐号</U></td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<input type=radio name="EmailRegOne" value=0 <%if cint(EmailRegOne)=0 then%>checked<%end if%>>关闭&nbsp;
<input type=radio name="EmailRegOne" value=1 <%if cint(EmailRegOne)=1 then%>checked<%end if%>>打开&nbsp;
</td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>开启短信欢迎新注册用户</U></td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<input type=radio name="smsflag" value=0 <%if cint(smsflag)=0 then%>checked<%end if%>>关闭&nbsp;
<input type=radio name="smsflag" value=1 <%if cint(smsflag)=1 then%>checked<%end if%>>打开&nbsp;
</td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>客人是否允许查看会员资料</U></td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<input type=radio name="ViewUser_g" value=0 <%if cint(ViewUser_g)=0 then%>checked<%end if%>>否&nbsp;
<input type=radio name="ViewUser_g" value=1 <%if cint(ViewUser_g)=1 then%>checked<%end if%>>是&nbsp;
</td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>用户是否允许查看会员资料</U></td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<input type=radio name="ViewUser_u" value=0 <%if cint(ViewUser_u)=0 then%>checked<%end if%>>否&nbsp;
<input type=radio name="ViewUser_u" value=1 <%if cint(ViewUser_u)=1 then%>checked<%end if%>>是&nbsp;
</td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>快速登陆位置</U></td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<select name="FastLogin">
<option value="1" <%if cint(FastLogin)=1 then%>selected<%end if%>>顶部
<option value="2" <%if cint(FastLogin)=2 then%>selected<%end if%>>底部
<option value="0" <%if cint(FastLogin)="0" then%>selected<%end if%>>不显示
</select>
</td>
</tr>
<!--tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>注册头像个数</U><BR>默认为60，如要增加新的头像图片，可适当增加其数字<BR>保存目录为<%=picurl%>，增加的头像必须采用image+数字的命名方式<BR>如image61.gif，如替换原头像图片也采用这样的命名方式</td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<input type="text" name="regfacenum" size="3" value="<%=regfacenum%>">&nbsp;个
</td>
</tr-->

<tr bgcolor=<%=aTabletitlecolor%>> 
<td height="23" colspan="2" ><font color="<%=TableContentColor%>"><b>下列设置对分论坛生效</b>(如果您正在<a href="#board"><font color=red>设置分论坛</font></a>，下列内容一般可忽略)</font></td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>在线名单显示客人在线</U><BR>为节省资源建议关闭</td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<input type=radio name="online_g" value=0 <%if cint(online_g)=0 then%>checked<%end if%>>关闭&nbsp;
<input type=radio name="online_g" value=1 <%if cint(online_g)=1 then%>checked<%end if%>>打开&nbsp;
</td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>在线名单显示用户在线</U><BR>为节省资源建议关闭</td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<input type=radio name="online_u" value=0 <%if cint(online_u)=0 then%>checked<%end if%>>关闭&nbsp;
<input type=radio name="online_u" value=1 <%if cint(online_u)=1 then%>checked<%end if%>>打开&nbsp;
</td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>允许同时在线数</U><BR>如不想限制，可设置为999999</td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<input type="text" name="online_n" size="6" value="<%=online_n%>">&nbsp;人
</td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>新短消息弹出窗口</U></td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<input type=radio name="openmsg" value=0 <%if cint(openmsg)=0 then%>checked<%end if%>>否&nbsp;
<input type=radio name="openmsg" value=1 <%if cint(openmsg)=1 then%>checked<%end if%>>是&nbsp;
</td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>是否显示页面执行时间</U></td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<input type=radio name="runtime" value=0 <%if cint(runtime)=0 then%>checked<%end if%>>否&nbsp;
<input type=radio name="runtime" value=1 <%if cint(runtime)=1 then%>checked<%end if%>>是&nbsp;
</td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>上传文件大小</U><BR>请填写数字</td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<input type="text" name="uploadsize" size="6" value="<%=uploadsize%>"> K
</td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>用户签名是否开启UBB代码</U></td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<input type=radio name="UserubbCode" value=0 <%if UserubbCode=0 then%>checked<%end if%>>关闭&nbsp;
<input type=radio name="UserubbCode" value=1 <%if UserubbCode=1 then%>checked<%end if%>>打开&nbsp;
</td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>用户签名是否开启HTML代码</U></td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<input type=radio name="UserHtmlCode" value=0 <%if UserHtmlCode=0 then%>checked<%end if%>>关闭&nbsp;
<input type=radio name="UserHtmlCode" value=1 <%if UserHtmlCode=1 then%>checked<%end if%>>打开&nbsp;
</td>
</tr>
<tr> 
<td height="17" width="50%"><U>用户排行列表个数</U></td>
<td height="17" width="50%"> 
<input type="text" name="TopUserNum" size="6" value="<%=TopUserNum%>">&nbsp;个
</td>
</tr>
<%
end sub

sub admin_board()
%>
<tr bgcolor=<%=Tabletitlecolor%>> 
<td height="23" colspan="2" ><font color="<%=TableContentColor%>"><a name="board"><b>论坛版面使用设置</b>
</a>(如果您正在<a href="#config"><font color=red>设置总论坛</font></a>，下列内容可忽略)</font></td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>论坛风格</U><BR>讨论区风格为树形</td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<input type=radio name="DvbbsSkin" value=0 <%if DvbbsSkin=0 then%>checked<%end if%>>默认风格&nbsp;
<input type=radio name="DvbbsSkin" value=1 <%if DvbbsSkin=1 then%>checked<%end if%>>讨论区风格&nbsp;
</td>
</tr>
<tr> 
<td height="17" width="50%"><U>讨论区风格预览字数</U><BR>取消预览请填写0</td>
<td height="17" width="50%"> 
<input type="text" name="SkinFontNum" size="6" value="<%=SkinFontNum%>">&nbsp;字
</td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>帖子上传图片</U><BR>用于帖子图片的上传，如分论坛已经设置，以分论坛为准</td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<input type=radio name="Uploadpic" value=0 <%if cint(Uploadpic)=0 then%>checked<%end if%>>关闭&nbsp;
<input type=radio name="Uploadpic" value=1 <%if cint(Uploadpic)=1 then%>checked<%end if%>>打开&nbsp;
</td>
</tr>
<tr> 
<td height="17" width="50%"><U>帖子图片上传路径</U><BR>相对论坛目录路径</td>
<td height="17" width="50%"> 
<input type="text" name="UpLoadPath" size="10" value="<%=UpLoadPath%>">&nbsp;如：uploadFace
</td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>客人浏览论坛</U><BR>可设置是否允许客人浏览论坛</td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<input type=radio name="guestlogin" value=0 <%if cint(guestlogin)=0 then%>checked<%end if%>>允许&nbsp;
<input type=radio name="guestlogin" value=1 <%if cint(guestlogin)=1 then%>checked<%end if%>>不允许&nbsp;
</td>
</tr>
<tr> 
<td height="17" width="50%"><U>帖子内容最大的字节数</U><BR>请输入数字</td>
<td height="17" width="50%"> 
<input type="text" name="AnnounceMaxBytes" size="6" value="<%=AnnounceMaxBytes%>">&nbsp;字节
</td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>每页显示最多纪录</U><BR>用于论坛所有和分页有关的项目</td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<input type="text" name="MaxAnnouncePerPage" size="3" value="<%=MaxAnnouncePerPage%>">&nbsp;条
</td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>浏览贴子每页显示贴子数</U></td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<input type="text" name="Maxtitlelist" size="3" value="<%=Maxtitlelist%>">&nbsp;条
</td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>发贴模式</U><BR>高级模式为显示所有项目</td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<input type=radio name="TopicFlag" value=0 <%if cint(TopicFlag)=0 then%>checked<%end if%>>普通&nbsp;
<input type=radio name="TopicFlag" value=1 <%if cint(TopicFlag)=1 then%>checked<%end if%>>高级&nbsp;
</td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>主版主可增删副版主</U></td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<input type=radio name="bmflag_1" value=0 <%if cint(bmflag_1)=0 then%>checked<%end if%>>关闭&nbsp;
<input type=radio name="bmflag_1" value=1 <%if cint(bmflag_1)=1 then%>checked<%end if%>>打开&nbsp;
</td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>主版主可更改论坛使用设置</U></td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<input type=radio name="bmflag_3" value=0 <%if cint(bmflag_3)=0 then%>checked<%end if%>>关闭&nbsp;
<input type=radio name="bmflag_3" value=1 <%if cint(bmflag_3)=1 then%>checked<%end if%>>打开&nbsp;
</td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>所有版主均可更改论坛设置</U></td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<input type=radio name="bmflag_5" value=0 <%if cint(bmflag_5)=0 then%>checked<%end if%>>关闭&nbsp;
<input type=radio name="bmflag_5" value=1 <%if cint(bmflag_5)=1 then%>checked<%end if%>>打开&nbsp;
</td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>是否允许未登陆用户搜索</U></td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<input type=radio name="Search_G" value=0 <%if cint(Search_G)=0 then%>checked<%end if%>>允许&nbsp;
<input type=radio name="Search_G" value=1 <%if cint(Search_G)=1 then%>checked<%end if%>>不允许&nbsp;
</td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>帖子正文字号</U></td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<input type="text" name="FontSize" size="3" value="<%=FontSize%>">&nbsp;Pt，如15
</td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>帖子正文行距</U></td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<input type="text" name="FontHeight" size="3" value="<%=FontHeight%>">&nbsp;倍行距，如1.5
</td>
</tr>
<tr> 
<td width="50%"><font color="<%=TableContentColor%>"><U>发新帖后返回</U></td>
<td width="50%"><font color="<%=TableContentColor%>"> 
<input type=radio name="PostRetrun" value=1 <%if PostRetrun=1 then%>checked<%end if%>>首页&nbsp;
<input type=radio name="PostRetrun" value=2 <%if PostRetrun=2 then%>checked<%end if%>>论坛&nbsp;
<input type=radio name="PostRetrun" value=3 <%if PostRetrun=3 then%>checked<%end if%>>帖子&nbsp;
</td>
</tr>
<%
end sub
%>