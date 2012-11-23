<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=chkuser.asp-->
<title><%=ForumName%>--管理页面</title>
<!--#include file="Forum_css.asp"-->

<BODY  <%=ForumBody%>>
<%
	if not master or instr(session("flag"),"52")=0 then
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
        <td><font color=<%=tablefontcolor%>>欢迎<b><%=membername%></b>进入管理页面</font>
        </td>
        </tr>
            <tr bgcolor=<%=tablebodycolor%>>
              <td width="100%" valign=top><p>
              <table width="100%" border="0" cellspacing="3" cellpadding="0">
                <tr> 
                  <td bgcolor=<%=atabletitlecolor%>> <font color=<%=tablecontentcolor%>>
                    <p><b>添加ip数据来源</b>：</p></font>
                  </td>
                </tr>
                <tr> 
                  <td>	<font color=<%=tablecontentcolor%>>
<%
	dim sip,str1,str2,str3,str4,num_1,num_2
if request("action") = "save" then
	sip=cstr(request("ip1"))
	'dot=instr(ip,".")-1
	'response.write dot
	str1=left(sip,cint(instr(sip,".")-1))
	sip=mid(sip,cint(instr(sip,"."))+1)
	str2=left(sip,cint(instr(sip,"."))-1)
	sip=mid(sip,cint(instr(sip,"."))+1)
	str3=left(sip,cint(instr(sip,"."))-1)
	str4=mid(sip,cint(instr(sip,"."))+1)
	num_1=cint(str1)*256*256*256+cint(str2)*256*256+cint(str3)*256+cint(str4)-1

	sip=cstr(request("ip2"))
	str1=left(sip,instr(sip,".")-1)
	sip=mid(sip,instr(sip,".")+1)
	str2=left(sip,instr(sip,".")-1)
	sip=mid(sip,instr(sip,".")+1)
	str3=left(sip,instr(sip,".")-1)
	str4=mid(sip,instr(sip,".")+1)
	num_2=cint(str1)*256*256*256+cint(str2)*256*256+cint(str3)*256+cint(str4)-1
	'response.write num_1 &","& num_2
	'response.end
set rs = server.CreateObject ("adodb.recordset")
sql="select Top 1 country,city,ip1,ip2 from address where (ip1 <="&num_1&" and ip2 >="&num_1&") or (ip1 <="&num_2&" and ip2 >="&num_2&")"
rs.open sql,conn,1,3
if rs.eof and rs.bof then
rs.addnew
rs("ip1")=num_1
rs("ip2")=num_2
rs("country")=trim(request("country"))
if request("city")<>"" then
rs("city")=trim(request("city"))
end if
rs.update
response.write "添加成功！"
else
response.write "您添加的IP地址已经存在于地址列表中，您可以对其进行修改或<a href=admin_address.asp><font color="&tablecontentcolor&">返回</font></a>。"
%>
            <form action="admin_address.asp?action=edit" method=post>
              <table width="100%" border="0" cellspacing="3" cellpadding="0">
                <tr> 
                  <td width="25%" height="2"><font color=<%=tablecontentcolor%>>以下是您要修改的信息：</font></td>
                  <td width="52%" height="2"><font color=<%=tablecontentcolor%>>
                    <input type="hidden" name="ip1" value="<%=num_1%>"><input type="hidden" name="ip2" value="<%=num_1%>">来源国家：<input type="text" name="country" size="30" value="<%=rs("country")%>"><br>来源城市：<input type="text" name="city" size="30" value="<%=rs("city")%>"></font>
                  </td>
                  <td width="25%" height="2" valign="bottom"> 
                    <div align="left"> 
                      <input type="submit" name="Submit" value="提交">
                    </div>
                  </td>
                </tr>
              </table>
            </form>
<%
end if
rs.close
set rs=nothing
elseif request("action")="edit" then
set rs = server.CreateObject ("adodb.recordset")
sql="select Top 1 country,city from address where (ip1 <="&request("ip1")&" and ip2 >="&request("ip1")&") or (ip1 <="&request("ip2")&" and ip2 >="&request("ip2")&")"
rs.open sql,conn,1,3
rs("country")=trim(request("country"))
if request("city")<>"" then
rs("city")=trim(request("city"))
end if
rs.update
rs.close
set rs=nothing
response.write "添加成功！"
else
%>
            <form action="admin_address.asp?action=save" method=post>
              <table width="100%" border="0" cellspacing="3" cellpadding="0">
                <tr> 
                  <td width="18%" height="2"><font color=<%=tablecontentcolor%>>要加入的来源IP段：</font></td>
                  <td width="52%" height="2"><font color=<%=tablecontentcolor%>> 起始I&nbsp;P：
                    <input type="text" name="ip1" size="30"><br>结尾I&nbsp;P：&nbsp;<input type="text" name="ip2" size="30"><br>来源国家：<input type="text" name="country" size="30"><br>来源城市：<input type="text" name="city" size="30"></font>
                  </td>
                  <td width="30%" height="2" valign="bottom"> 
                    <div align="left"> 
                      <input type="submit" name="Submit" value="提交">
                    </div>
                  </td>
                </tr>
              </table>
            </form>
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