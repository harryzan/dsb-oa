<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=chkuser.asp-->
<title><%=ForumName%>--管理页面</title>
<!--#include file="Forum_css.asp"-->

<BODY <%=ForumBody%>>
<%

	if not master or instr(session("flag"),"56")=0 then
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
        <td align=center><font color="<%=TablefontColor%>">欢迎<b><%=membername%></b>进入管理页面</font>
        </td>
        </tr>
            <tr bgcolor=<%=tablebodycolor%>>
              <td width="100%" valign=top><p>
              <table width="100%" border="0" cellspacing="3" cellpadding="0">
                <tr> 
                  <td bgcolor=<%=atabletitlecolor%>> <font color="<%=TableContentColor%>">
                    
		<p><b>添加ip来源限制</b>：</p></font>
                  </td>
                </tr>
                <tr> 
                  <td>	<font color="<%=TableContentColor%>">
<%
dim sip,str1,str2,str3,str4,num_1,num_2
if request.querystring("action")="save" then
	sip=cstr(request.form("ip1"))
	'dot=instr(ip,".")-1
	'response.write dot
	str1=left(sip,cint(instr(sip,".")-1))
	sip=mid(sip,cint(instr(sip,"."))+1)
	str2=left(sip,cint(instr(sip,"."))-1)
	sip=mid(sip,cint(instr(sip,"."))+1)
	str3=left(sip,cint(instr(sip,"."))-1)
	str4=mid(sip,cint(instr(sip,"."))+1)
	num_1=cint(str1)*256*256*256+cint(str2)*256*256+cint(str3)*256+cint(str4)-1

	sip=cstr(request.form("ip2"))
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
	sql="select * from LockIP"
	rs.open sql,conn,1,3
	rs.addnew
	rs("ip1")=num_1
	rs("ip2")=num_2
	rs("sip1")=request.form("ip1")
	rs("sip2")=request.form("ip2")
	rs.update
	rs.close
	set rs=nothing
	conn.close
	set conn=nothing
	response.write "添加成功！"
else
%>
            
		<form action="admin_LockIP.asp?action=save" method="post">
		 <table width="100%" border="0" cellspacing="3" cellpadding="0">
                <tr> 
                  
		   <td width="18%" height="2"><font color="<%=TableContentColor%>">要加入的限制IP段：</font></td>
                  <td width="52%" height="2"><font color="<%=TableContentColor%>"> 起始I&nbsp;P：
                    <input type="text" name="ip1" size="30"><br>结尾I&nbsp;P：&nbsp;<input type="text" name="ip2" size="30"><br></font>
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