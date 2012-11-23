<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=chkuser.asp-->
<title><%=ForumName%>--管理页面</title>
<!--#include file="Forum_css.asp"-->

<BODY <%=ForumBody%>>
<%
	if not master or instr(session("flag"),"34")=0 then
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
                    <p><b>SOL语句执行操作</b>：本操作仅限高级、对SQL编程比较熟悉的用户，您可以直接输入sql执行语句，比如delete from bbs1 where username='test'进行删除某用户帖子操作，在操作前请慎重考虑您的执行语句是否正确和完整，执行后不可恢复。</font></p></font>
                  </td>
                </tr>
                <tr> 
                  <td>	<font color="<%=TableContentColor%>">
<%
if request("action") = "save" then
dim SQL_Statement
SQL_Statement=Request("SQL_Statement")
if SQL_Statement<>Empty then
On Error Resume Next 
conn.Execute(SQL_Statement)
if err.number="0" then
response.write "执行成功"
else
response.write "语句有问题，具体出错如下：<br>"
response.write Err.Description
err.clear
end if
end if
else
%>
              <table width="80%" border="0" cellspacing="3" cellpadding="0">
                <tr> 
                  <td width="100%" height="2"><font color="<%=TableContentColor%>">
<Form Name=FormPst Method=Post Action="admin_connsql.asp?action=save">
<FieldSet>
<Legend>请输入SQL语句</Legend>
指令：<Input type="text" name="SQL_Statement" Size=60> <p>
<Input type="Submit" Value="送出"> <p>
</FieldSet>
</Form></font>
                  </td>
                </tr>
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