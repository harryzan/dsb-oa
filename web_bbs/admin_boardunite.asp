<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=chkuser.asp-->
<title><%=ForumName%>--管理页面</title>
<!--#include file="Forum_css.asp"-->

<BODY <%=ForumBody%>>
<%
	dim str
	if not master or instr(session("flag"),"03")=0 then
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
          <td width="100%" valign=top> 
<font color="<%=TableContentColor%>">
            <table width="100%" border="0" cellspacing="3" cellpadding="0">
              <tr>
                <td><font color="<%=TableContentColor%>">1．注意事项： 在下面，您将看到目前所有的论坛列表。不能在同一个版面内进行操作。您可以将一个论坛和另外一个论坛进行合并，合并后两个论坛所有帖子转入合并论坛，被合并论坛将被删除且不可恢复。</font>
                </td>
              </tr>
            </table>
<%
if Request("action") = "unite" then
	call unite()
else
	call boardinfo()
end if
end sub

sub boardinfo()
%><br>
            <table width="95%" border="0" cellspacing="3" cellpadding="0" align=center>
	      <tr>
		<td><font color="<%=TableContentColor%>">
<%
	set rs = server.CreateObject ("Adodb.recordset")
	sql="select boardid,boardtype from board"
	rs.open sql,conn,1,1
	if rs.eof and rs.bof then
		response.write "没有论坛"
	else
		response.write "<form action=admin_boardunite.asp?action=unite method=post>"
		response.write "将论坛"
		response.write "<select name=oldboard size=1>"
		do while not rs.eof
		response.write "<option value="&rs("boardid")&">"&rs("boardtype")&"</option>"
		rs.movenext
		loop
		response.write "</select>"
	end if
	rs.close
	sql="select * from board"
	rs.open sql,conn,1,1
	if rs.eof and rs.bof then
		response.write "没有论坛"
	else
		response.write "合并到"
		response.write "<select name=newboard size=1>"
		do while not rs.eof
		response.write "<option value="&rs("boardid")&">"&rs("boardtype")&"</option>"
		rs.movenext
		loop
		response.write "</select>"
	end if
	rs.close
	set rs=nothing
	response.write "<input type=submit name=Submit value=执行></form>"
%></font>
		</td>
	      </tr>
            </table>
<%
end sub

sub unite()
dim newboard
dim oldboard
%><br>
            <table width="95%" border="0" cellspacing="3" cellpadding="0" align=center>
	      <tr>
		<td><font color="<%=TableContentColor%>">
<%
if cint(request("newboard"))=cint(request("oldboard")) then
response.write "请不要在相同版面内进行操作。"
else
newboard=cint(request("newboard"))
oldboard=cint(request("oldboard"))
'更新论坛帖子数据
conn.execute("update bbs1 set boardid="&newboard&" where boardid="&oldboard)
'更新新论坛帖子计数
set rs=conn.execute("select lastbbsnum,lasttopicnum,todayNum from board where boardid="&oldboard)
conn.execute("update board set lastbbsnum=lastbbsnum+"&rs(0)&",lasttopicnum=lasttopicnum+"&rs(1)&",todaynum=todaynum+"&rs(2)&" where boardid="&newboard)
'删除被合并论坛
conn.execute("delete from board where boardid="&oldboard)
response.write "合并成功，已经将被合并论坛所有数据转入您所合并论坛。"
end if
%></font>
		</td>
	      </tr>
            </table>
<%
end sub
%>