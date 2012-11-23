<!--#include file=conn.asp-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=inc/grade.asp-->
<!--#include file=chkuser.asp-->
<title><%=ForumName%>--管理页面</title>
<!--#include file="Forum_css.asp"-->

<BODY <%=ForumBody%>>
<%
	if not master or instr(session("flag"),"12")=0 then
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
        <td><font color="<%=TablefontColor%>">欢迎<b><%=membername%></b>进入管理页面</font>
        </td>
        </tr>
            <tr bgcolor=<%=tablebodycolor%>>
              <td width="100%" valign=top><font color="<%=TableContentColor%>">
<%
if request("action")="save" then
call savegrade()
else
call gradeinfo()
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

sub gradeinfo()
%>
<form method="POST" action=admin_grade.asp?action=save>
<table width="95%" border="0" cellspacing="1" cellpadding="3"  align=center bordercolor=<%=aTablebackcolor%>>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td height="23" colspan="2" ><font color="<%=TableContentColor%>"><b>用户等级设定</b>：等级18为贵宾，等级19为版主，等级20为总版主，这三项只设定显示名称和图片，不用设置积分。图片目录pic，本项功能需要FSO支持，FSO相关帮助请浏览微软网站，如您网站不支持FSO，请手动修改Pic相关图片文件以及inc/grade.asp文件。</font></td>
</tr>
<%for i=1 to 20%>
<tr> 
<td width="30%"><font color="<%=TableContentColor%>"><b>等级<B><%=i%></B>名称</font></td>
<td width="70%"> 
<input type="text" name="level<%=i%>" size="35" value="<%=grade(i)%>">
</td>
</tr>
<tr> 
<td width="30%"><font color="<%=TableContentColor%>">升级所需文章</font></td>
<td width="70%"> 
<input type="text" name="point<%=i%>" size="35" value="<%=point(i)%>">
</td>
</tr>
<tr> 
<td width="30%"><font color="<%=TableContentColor%>">等级<B><%=i%></B>图片地址</font></td>
<td width="70%"> 
<input type="text" name="pic<%=i%>" size="35" value="<%=gradepic(i)%>">
<img src=<%=picurl%><%=gradepic(i)%>></td>
</tr>
<%next%>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td width="30%">&nbsp;</td>
<td width="70%"> 
<div align="center"> 
<input type="submit" name="Submit" value="提 交">
</div>
</td>
</tr>
</table>
</form>
<%
end sub'Created by shatan Jan 8
sub savegrade()
	Dim objFSO, objTextFile
	Set objFSO = CreateObject("Scripting.FileSystemObject")	
	Set objTextFile = objFSO.CreateTextFile(Server.MapPath("inc/grade.asp"),TRUE)
		
	objTextFile.WriteLine("<" & "%")
	objTextFile.WriteLine("function grade(level)")
	objTextFile.WriteLine("dim user_level")
	objTextFile.WriteLine("Select Case level")
	for i=1 to 20
	objTextFile.WriteLine("case "&i&"")
	objTextFile.WriteLine("	user_level="""&request("level"&i)&"""")
	next
	objTextFile.WriteLine("Case Else")
	objTextFile.WriteLine("user_level="""&request("level1")&"""")
	objTextFile.WriteLine("end Select")
	objTextFile.WriteLine("grade=user_level")
	objTextFile.WriteLine("end function")

	objTextFile.WriteLine("function point(p)")
	objTextFile.WriteLine("dim level_point")
	objTextFile.WriteLine("Select Case p")
	for i=1 to 17
	objTextFile.WriteLine("case "&i&"")
	objTextFile.WriteLine("	level_point="&request("point"&i)&"")
	next
	objTextFile.WriteLine("end Select")
	objTextFile.WriteLine("point=level_point")
	objTextFile.WriteLine("end function")

	objTextFile.WriteLine("function gradepic(pic)")
	objTextFile.WriteLine("dim level_pic")
	objTextFile.WriteLine("Select Case pic")
	for i=1 to 20
	objTextFile.WriteLine("case "&i&"")
	objTextFile.WriteLine("	level_pic="""&request("pic"&i)&"""")
	next
	objTextFile.WriteLine("end Select")
	objTextFile.WriteLine("gradepic=level_pic")
	objTextFile.WriteLine("end function")

	objTextFile.WriteLine("%" & ">")		
		
	objTextFile.Close
	Set objTextFile = Nothing
	Set objFSO = Nothing
%>
<center><p><b>设置成功！</b>
<%
end sub
%>