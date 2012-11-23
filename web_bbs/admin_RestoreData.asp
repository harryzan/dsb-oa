<!--#include file =conn.asp-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=chkuser.asp-->
<title><%=ForumName%>--管理页面</title>
<!--#include file="Forum_css.asp"-->
<meta NAME=GENERATOR Content=""Microsoft FrontPage 3.0"" CHARSET=GB2312>
<BODY <%=ForumBody%>>
<%
	if not master or instr(session("flag"),"33")=0 then
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
if request("action")="Restore" then
	dim dbpath,backpath,fso
	Dbpath=request.form("Dbpath")
	backpath=request.form("backpath")
	if dbpath="" then
	response.write "请输入您要恢复成的数据库全名"	
	else
	Dbpath=server.mappath(Dbpath)
	end if
	backpath=server.mappath(backpath)
	'Response.write Backpath
	Set Fso=server.createobject("scripting.filesystemobject")
	if fso.fileexists(dbpath) then  					
		fso.copyfile Dbpath,Backpath
		response.write "成功恢复数据！"
	else
		response.write "备份目录下并无您的备份文件！"	
	end if
else
%>
		 			<table width=100% cellspacing=0 cellpadding=0 bgcolor='<%=atablebackcolor%>'>		  							  				
  				<tr bgcolor=<%=tablebodycolor%>>
  					<td height=25 ><font color="<%=TableContentColor%>">
   					&nbsp;&nbsp;<B>恢复论坛数据</B>( 需要FSO支持，FSO相关帮助请看微软网站 )</font>
  					</td>
  				</tr>
  				<form method="post" action="ADMIN_RestoreData.asp?action=Restore">
  				<tr bgcolor=<%=tablebodycolor%>>
  					<td height=100 ><font color="<%=TableContentColor%>">
  						&nbsp;&nbsp;备份数据库路径(相对)：<input type=text size=30 name=DBpath value="DataBackup\ipromis.MDB">&nbsp;&nbsp;<BR>
  						&nbsp;&nbsp;目标数据库路径(相对)：<input type=text size=30 name=backpath value="<%=db%>"><BR>&nbsp;&nbsp;填写您当前使用的数据库路径，如不想覆盖当前文件，可自行命名（注意路径是否正确），然后修改conn.asp文件，如果目标文件名和当前使用数据库名一致的话，不需修改conn.asp文件<BR>
						&nbsp;&nbsp;<input type=submit value="恢复数据"> <br>
  						-----------------------------------------------------------------------------------------<br>
                    &nbsp;&nbsp;在上面填写本程序的数据库路径全名，本程序的默认备份数据库文件为DataBackup\esbpbbs.MDB，请按照您的备份文件自行修改。<br>
  						&nbsp;&nbsp;您可以用这个功能来备份您的法规数据，以保证您的数据安全！<br>
  						&nbsp;&nbsp;注意：所有路径都是相对与程序空间根目录的相对路径</font>
  					</td>
  				</tr>	
  				</form>
  			</table>
<%end if%></font>
			  </td>
            </tr>
        </table>
        </td>
    </tr>
</table>

<%
end sub
%>
