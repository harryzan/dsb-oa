<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=chkuser.asp-->
<title><%=ForumName%>--管理页面</title>
<!--#include file="Forum_css.asp"-->

<BODY <%=ForumBody%>>
<%
	if not master or instr(session("flag"),"55")=0 then
		Errmsg=Errmsg+"<br>"+"<li>本页面为管理员专用，请<a href=admin_index.asp target=_top>登陆</a>后进入。<br><li>您没有管理本页面的权限。"
		call Error()
	else
		call main()
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
              <td width="100%" valign=top><p>
              <table width="100%" border="0" cellspacing="3" cellpadding="0">
                <tr> 
                  <td bgcolor=<%=atabletitlecolor%>> <font color="<%=TableContentColor%>">
                    <p><b>浏览上传文件</b>：本功能必须服务器支持FSO权限方能使用，FSO使用帮助请浏览微软网站。文件目录为uploadimages，如果您服务器不支持FSO请手动管理。</p></font>
                  </td>
                </tr>
                <tr> 
                  <td>	<font color="<%=TableContentColor%>">
<%
'Created by shatan Jan 8
dim objFSO
dim uploadfolder
dim uploadfiles
dim upname
dim upfilename
Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
if request("filename")<>"" then
objFSO.DeleteFile(Server.MapPath("uploadimages\"&request("filename")))
end if
Set uploadFolder=objFSO.GetFolder(Server.MapPath("uploadimages\"))
Set uploadFiles=uploadFolder.Files
For Each Upname In uploadFiles
upfilename="uploadimages/"&upname.name
response.write "<a href="""&upfilename&""">"&upfilename&"</a> <a href='?filename="&upname.name&"'>删除</a><br>"
next
set uploadFolder=nothing
set uploadFiles=nothing
%></font>
		</td>
            </tr>
        </table>
        </td>
    </tr>
</table>
<%
	end sub
%>