<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!-- #include file="chkuser.asp" -->
<!--#include file="inc/theme.asp"-->
<!--#include file="inc/char.asp"-->
<%
	stats="您的收藏夹"
	call nav()
	call headline(1)
%>
	        <table cellpadding=0 cellspacing=0 border=0 width=<%=TableWidth%> bgcolor="<%=tablebackcolor%>" align=center>
	                <tr>
	                    <td>
	                    <table cellpadding=3 cellspacing=1 border=0 width=100%>
<%
	set rs=server.createobject("adodb.recordset")
	if membername="" then
		Errmsg=Errmsg+"<br>"+"<li>您还没有<a href=login.asp>登陆论坛</a>，不能查看收藏。如果您还没有<a href=reg.asp>注册</a>，请先<a href=reg.asp>注册</a>！"
		Founderr=true
	end if
	if Founderr then
		call error()
	else
		if request("action")="delet" then
			call delete()
		else
			call favlist()
		end if
		if Founderr then call error()
	end if
%>
				</table>
			</td></tr>
</table>
<%
	sub favlist()
	sql="select * from bookmark where username='"&membername&"' order by id desc"
	rs.open sql,conn,1,1
	if rs.eof and rs.bof then
		Errmsg=Errmsg+"<br>"+"<li>您的收藏夹还没有收藏，您可以收藏论坛指定贴子，当收藏中有数据后，本信息将自动删除！"
		Founderr=true
	else
%>
	                        <tr>
	                        <td bgcolor="<%=tabletitlecolor%>" align=center valign=top colspan="3"><b><font color=<%=TableFontColor%>>>> 您的收藏夹 <<</font></b></td></tr>
  <tr bgcolor="<%=tablebodycolor%>">
    <td width="70%"><font color="<%=TableContentColor%>">标题</font></td>
    <td width="20%"><font color="<%=TableContentColor%>">时间</font></td>
    <td width="10%"><font color="<%=TableContentColor%>">操作</font></td>
  </tr>
<%
	do while not rs.eof
%>
  <tr bgcolor="<%=tablebodycolor%>">
    <td width="70%"><a href="<%=rs("url")%>"><%=htmlencode(rs("topic"))%></a></td>
    <td width="20%"><font color="<%=TableContentColor%>"><%=rs("addtime")%></font></td>
    <td width="10%"><a href="favlist.asp?action=delet&id=<%=rs("id")%>"><img src="pic/a_delete.gif" border=0></a></td>
  </tr>
<%
	rs.movenext
	loop
	end if
	rs.close
	end sub

	sub error()
%>
	                        <tr>
	                        <td bgcolor="<%=tabletitlecolor%>" align=center valign=top><b><font color=<%=TableFontColor%>>> 错误信息 <<</font></b></td></tr>
	                        <tr>
	                            <td bgcolor="<%=tablebodycolor%>" valign=top style="LEFT: 0px; WIDTH: 100%; WORD-WRAP: break-word"><br><font color="<%=TableContentColor%>">
	                        <p><blockquote><%=errmsg%>
</blockquote></p></font>
	                        </td>
	                        </tr>
<%
	end sub

	sub delete()
	if isInteger(request("id")) then
	sql="delete from bookmark where username='"&membername&"' and id="&cstr(request("id"))
	conn.execute sql
	end if
%>
	                        <tr>
	                        <td bgcolor="<%=tabletitlecolor%>" align=center valign=top><b><font color=<%=TableFontColor%>>> 操作成功 <<</font></b></td></tr>
	                        <tr>
	                            <td bgcolor="<%=tablebodycolor%>" valign=top style="LEFT: 0px; WIDTH: 100%; WORD-WRAP: break-word"><br><font color="<%=TableContentColor%>">
	                        <p><blockquote>已删除您的收藏夹中相应纪录，<a href="javascript:history.go(-1)">返回收藏</a>。
</blockquote></p></font>
	                        </td>
	                        </tr>
<%
	end sub
	set rs=nothing	
	call endline()
%>
<!--#include file="footer.asp"-->
