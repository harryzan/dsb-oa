<!-- #include file="conn.asp" -->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=chkuser.asp-->
<title><%=ForumName%>--管理页面</title>
<!--#include file="Forum_css.asp"-->

<BODY <%=ForumBody%>>
<%
	if not master or instr(session("flag"),"27")=0 then
		Errmsg=Errmsg+"<br>"+"<li>本页面为管理员专用，请<a href=admin_index.asp target=_top>登陆</a>后进入。<br><li>您没有管理本页面的权限。"
		call Error()
	else
		call main()
	end if

	sub main()
%>
<table cellpadding=0 cellspacing=0 border=0 width=<%=tablewidth%> bgcolor=<%=tablebackcolor%> align=center>
  <tr>
    <td height="30"> 
      <table cellpadding=3 cellspacing=1 border=0 width=100%>
        <tr bgcolor='<%=Tabletitlecolor%>'>
        <td><font color="<%=TablefontColor%>">欢迎<b><%=membername%></b>进入管理页面</font>
        </td>
        </tr>
            <tr bgcolor=<%=tablebodycolor%>>              
          <td width="100%" valign=top><font color="<%=TableContentColor%>">
<%
dim objFSO
dim fdata
dim objCountFile
Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
if request("save")="" then
		Set objCountFile = objFSO.OpenTextFile(Server.MapPath("forum_css.asp"),1,True)
		If Not objCountFile.AtEndOfStream Then fdata = objCountFile.ReadAll
	else
		fdata=request("fdata")
		Set objCountFile=objFSO.CreateTextFile(Server.MapPath("forum_css.asp"),True)
		objCountFile.Write fdata
	end if
	objCountFile.Close
	Set objCountFile=Nothing
	Set objFSO = Nothing
%> 
<form method=post>
            <table width="100%" border="0" cellspacing="3" cellpadding="0">
              <tr> 
                <td width="3%" height="23">&nbsp;</td>
                <td width="97%" height="23"><font color="<%=TableContentColor%>">论坛模板编辑：<br>
                  &nbsp;&nbsp;&nbsp;&nbsp;注意：文件将被保存在你安装目录下的<font color="<%=AlertfontColor%>">FORUM.CSS</font>里，如果您的空间不支持<font color="<%=AlertfontColor%>">FSO</font>，请直接编辑该文件！如果您对CSS的属性不了解，请不要随意编辑。内容中带有<%%>的部分不要进行编辑</font></td>
              </tr>
              <tr> 
                <td width="3%">&nbsp; </td>
                <td width="97%"> 
                  <textarea name="fdata" cols="80" rows="20"><%=fdata%></textarea>
                </td>
              </tr>
              <tr> 
                <td width="3%">&nbsp;</td>
                <td width="97%"><font color="<%=TableContentColor%>">
                  <input type="reset" name="Reset" value="重新修改">
                  <input type="submit" name="save" value="提交修改"> 当前文件路径：<font color=<%=AlertfontColor%>><b><%=Server.MapPath("forum.css")%></b></font></font>
                </td>
              </tr>
            </table></form>
            <p>&nbsp;</p></font>
            </td>
            </tr>
        </table>
        </td>
    </tr>
</table>
<%

end sub%>