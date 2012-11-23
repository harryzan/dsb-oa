<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=chkuser.asp-->

<title><%=ForumName%>--管理页面</title>
<!--#include file="Forum_css.asp"-->

<BODY <%=ForumBody%>>
<%
	if not master or instr(session("flag"),"04")=0 then
		Errmsg=Errmsg+"<br>"+"<li>本页面为管理员专用，请<a href=admin_index.asp target=_top>登陆</a>后进入。<br><li>您没有管理本页面的权限。"
		call Error()
	else
		dim body
                dim readme,Tlink
		call main()
		set rs=nothing
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
	if request("action") = "add" then 
		call addlink()
	elseif request("action")="edit" then
		call editlink()
	elseif request("action")="savenew" then
		call savenew()
	elseif request("action")="savedit" then
		call savedit()
	elseif request("action")="del" then
		call del()
	elseif request("action")="orders" then
		call orders()
	elseif request("action")="updatorders" then
		call updateorders()
	else
		call linkinfo()
	end if
%>     <p><%=body%></p></font>
	</td></tr></table>
        </td>
    </tr>
</table>

<%
end sub

sub addlink()
%>
<form action="admin_link.asp?action=savenew" method = post>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="30%"><font color="<%=TableContentColor%>">论坛名称： </font></td>
    <td width="70%"> 
      <input type="text" name="name" size=40>
    </td>
  </tr>
  <tr> 
    <td width="30%"><font color="<%=TableContentColor%>">连接URL： </font></td>
    <td width="70%"> 
      <input type="text" name="url" size=40>
    </td>
  </tr>
  <tr> 
    <td width="30%"><font color="<%=TableContentColor%>">连接LOGO地址：</font> </td>
    <td width="70%"> 
      <input type="text" name="logo" size=40>
    </td>
  </tr>
  <tr> 
    <td height="15" width="30%"><font color="<%=TableContentColor%>">论坛简介：</font> </td>
    <td height="15" width="70%"> 
      <input type="text" name="readme" size=40>
    </td>
  </tr>
  <tr> 
    <td height="15" colspan="2"> 
      <div align="center"> 
        <input type="submit" name="Submit" value="添加">
      </div>
    </td>
  </tr>
</table>
</form>
<%
end sub

sub editlink()
	on error resume next
	set rs= server.createobject ("adodb.recordset")
	sql = "select * from bbslink where id="+cstr(Request("id"))
	rs.open sql,conn,1,1
	Tlink=split(rs("readme"),"$")
%>
<form action="admin_link.asp?action=savedit" method=post>
<input type=hidden name=id value=<%=Request("id")%>>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td width="30%"><font color="<%=TableContentColor%>">论坛名称： </font></td>
    <td width="70%"> 
      <input type="text" name="name" size=40 value=<%=rs("boardname")%>>
    </td>
  </tr>
  <tr> 
    <td width="30%"><font color="<%=TableContentColor%>">连接URL：</font> </td>
    <td width="70%"> 
      <input type="text" name="url" size=40 value=<%=rs("url")%>>
    </td>
  </tr>
  <tr> 
    <td width="30%"><font color="<%=TableContentColor%>">连接LOGO地址： </font></td>
    <td width="70%"> 
      <input type="text" name="logo" size=40 <%if not isempty(Tlink(1)) then%>value="<%=Tlink(1)%>"<%end if%>>
    </td>
  </tr>
  <tr> 
    <td height="15" width="30%"><font color="<%=TableContentColor%>">论坛简介： </font></td>
    <td height="15" width="70%"> 
      <input type="text" name="readme" size=40 value=<%=Tlink(0)%>>
    </td>
  </tr>
  <tr> 
    <td height="15" colspan="2"> 
      <div align="center"> 
        <input type="submit" name="Submit" value="修改">
      </div>
    </td>
  </tr>
</table>
</form>
<%
	rs.close
	set rs=nothing
end sub

sub linkinfo()
%>
            <table width="100%" border="0" cellspacing="3" cellpadding="0">
              <tr>
                <td><font color="<%=TableContentColor%>">注意事项： <br>
                  在下面，您将看到目前所有的联盟论坛。您可以编辑联盟论坛名或是增加一个新的联盟论坛。 也可以编辑或删除目前存在的联盟论坛。您可以对目前的联盟重新进行排列。 </font>
                </td>
              </tr>
            </table>
<%
	set rs= server.createobject ("adodb.recordset")
	sql = " select * from bbslink order by id"
	rs.open sql,conn,1,1
       
       
%> 
<br>
            <table width="100%" border="0" cellspacing="3" cellpadding="0">
              <tr bgcolor="<%=atabletitlecolor%>"> 
                <td height="22"><a href="admin_link.asp?action=add"><font color="<%=TableContentColor%>">增加新的联盟论坛</font></a></td>
              </tr>
            </table>
<%
	do while not rs.eof
         Tlink=split(rs(2),"$")
%>
<hr width=60% align=left color=black height=1>
            <table width="100%" border="0" cellspacing="3" cellpadding="0">
              <tr><td>序号：<b><font color=red><%=rs("id")%></font></b></td></tr>
              <tr> 
                <td><font color="<%=TableContentColor%>">名称：<%=rs("boardname")%></font></td>
              </tr>
              <tr> 
                <td><font color="<%=TableContentColor%>">URL：<%=rs("url")%></font></td>
              </tr>
              <tr> 
                <td><font color="<%=TableContentColor%>">简介：<%=tlink(0)%></font></td>
              </tr>
              <tr> 
                <td><font color="<%=TableContentColor%>">图片：<%if ubound(Tlink)>1 then%><img src=<%=Tlink(1)%> ><%end if%></font></td>
              </tr>
              <tr align="left" valign="bottom"> 
                <td height="27"><font color="<%=TableContentColor%>"><a href="admin_link.asp?action=edit&id=<%=rs("id")%>"><font color="<%=TableContentColor%>">编辑此联盟论坛</font></a> | <a href="admin_link.asp?action=del&id=<%=rs("id")%>"><font color="<%=TableContentColor%>">删除此联盟论坛</font></a> | <a href="admin_link.asp?action=orders&id=<%=rs("id")%>"><font color="<%=TableContentColor%>">联盟论坛重新排序</font></a></font></td>
              </tr>
            </table>

<%
	rs.movenext
	loop
	rs.Close
	set rs=nothing
%>
<hr width=60% align=left color=black height=1>
            <table width="100%" border="0" cellspacing="3" cellpadding="0">
              <tr bgcolor=<%=atabletitlecolor%>> 
                <td height="20"><a href="admin_link.asp?action=add"><font color="<%=TableContentColor%>">增加新的联盟论坛</font></a></td>
              </tr>
            </table>
<%
end sub

sub savenew()
if Request("url")<>"" and Request("readme")<>"" and request("name")<>"" then
	dim linknum
	set rs= server.createobject ("adodb.recordset")
	sql = "select * from bbslink order by id desc"
	rs.Open sql,conn,1,3
	if rs.eof and rs.bof then
	linknum=1
	else
	linknum=rs("id")+1
	end if
	rs.AddNew 
	rs("id")=linknum
	rs("boardname") = Trim(Request.Form ("name"))
	rs("readme") =  Trim(Request.Form ("readme")) &"$"& trim(request.Form("logo"))
	rs("url") = Request.Form ("url")
	rs.Update 
	rs.Close
	set rs=nothing
	body=body+"<br>"+"更新成功，请继续其他操作。"
else
	body=body+"<br>"+"请输入完整联盟论坛信息。"
end if
end sub

sub savedit()
	set rs= server.createobject ("adodb.recordset")
	sql = "select * from bbslink where id="+Cstr(request("id"))
	rs.Open sql,conn,1,3
	if rs.eof and rs.bof then
	body=body+"<br>"+"错误，没有找到联盟论坛。"
	else
	rs("boardname") = Trim(Request.Form ("name"))
	rs("readme") =  Trim(Request.Form ("readme")) &"$"& trim(request.Form("logo"))
	rs("url") = Request.Form ("url")
	rs.Update
	end if 
	rs.Close
	set rs=nothing
	body=body+"<br>"+"更新成功，请继续其他操作。"
end sub

sub del
	dim id
	id = request("id")
	sql="delete from bbslink where id="+id
	conn.Execute(sql)
	body=body+"<br>"+"删除成功，请继续其他操作。"
end sub

sub orders()
%><br>
            <table width="95%" border="0" cellspacing="3" cellpadding="0" align=center>
              <tr> 
                <td height="22"><font color="<%=TableContentColor%>"><b>联盟论坛重新排序</b><br>
注意：请在相应论坛的排序表单内输入相应的排列序号，<font color=red>注意不能和别的联盟论坛有相同的排列序号</font>。</font>
		</td>
              </tr>
	      <tr>
              <tr bgcolor="<%=atabletitlecolor%>"> 
                <td height="22" align=center><a href="admin_link.asp?action=add"><font color="<%=TableContentColor%>">增加新的联盟论坛</font></a></td>
              </tr>
	      <tr>
		<td><font color="<%=TableContentColor%>">
<%
	set rs= server.createobject ("adodb.recordset")
	sql="select * from bbslink where id="&cstr(request("id"))
	rs.open sql,conn,1,1
	if rs.eof and rs.bof then
		response.write "没有找到相应的联盟论坛。"
	else
		response.write "<form action=admin_link.asp?action=updatorders method=post>"
		response.write ""&rs("boardname")&"  <input type=text name=newid size=2 value="&rs("id")&">"
		response.write "<input type=hidden name=id value="&request("id")&">"
		response.write "<input type=submit name=Submit value=修改></form>"
	end if
	rs.close
	set rs=nothing
%></font>
		</td>
	      </tr>
              <tr bgcolor="<%=atabletitlecolor%>"> 
                <td height="22" align=center><a href="admin_link.asp?action=add"><font color="<%=TableContentColor%>">增加新的联盟论坛</font></a></td>
              </tr>
            </table>
<%
end sub

sub updateorders()

	 sql="update bbslink set id="&request("newid")&" where id="&cstr(request("id"))
	conn.execute(sql)
	  response.write "<p align=center>更新成功！</p>"


end sub
%>