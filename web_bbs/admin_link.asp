<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=chkuser.asp-->

<title><%=ForumName%>--����ҳ��</title>
<!--#include file="Forum_css.asp"-->

<BODY <%=ForumBody%>>
<%
	if not master or instr(session("flag"),"04")=0 then
		Errmsg=Errmsg+"<br>"+"<li>��ҳ��Ϊ����Աר�ã���<a href=admin_index.asp target=_top>��½</a>����롣<br><li>��û�й���ҳ���Ȩ�ޡ�"
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
        <td><font color="<%=TablefontColor%>">��ӭ<b><%=membername%></b>�������ҳ��</font>
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
    <td width="30%"><font color="<%=TableContentColor%>">��̳���ƣ� </font></td>
    <td width="70%"> 
      <input type="text" name="name" size=40>
    </td>
  </tr>
  <tr> 
    <td width="30%"><font color="<%=TableContentColor%>">����URL�� </font></td>
    <td width="70%"> 
      <input type="text" name="url" size=40>
    </td>
  </tr>
  <tr> 
    <td width="30%"><font color="<%=TableContentColor%>">����LOGO��ַ��</font> </td>
    <td width="70%"> 
      <input type="text" name="logo" size=40>
    </td>
  </tr>
  <tr> 
    <td height="15" width="30%"><font color="<%=TableContentColor%>">��̳��飺</font> </td>
    <td height="15" width="70%"> 
      <input type="text" name="readme" size=40>
    </td>
  </tr>
  <tr> 
    <td height="15" colspan="2"> 
      <div align="center"> 
        <input type="submit" name="Submit" value="���">
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
    <td width="30%"><font color="<%=TableContentColor%>">��̳���ƣ� </font></td>
    <td width="70%"> 
      <input type="text" name="name" size=40 value=<%=rs("boardname")%>>
    </td>
  </tr>
  <tr> 
    <td width="30%"><font color="<%=TableContentColor%>">����URL��</font> </td>
    <td width="70%"> 
      <input type="text" name="url" size=40 value=<%=rs("url")%>>
    </td>
  </tr>
  <tr> 
    <td width="30%"><font color="<%=TableContentColor%>">����LOGO��ַ�� </font></td>
    <td width="70%"> 
      <input type="text" name="logo" size=40 <%if not isempty(Tlink(1)) then%>value="<%=Tlink(1)%>"<%end if%>>
    </td>
  </tr>
  <tr> 
    <td height="15" width="30%"><font color="<%=TableContentColor%>">��̳��飺 </font></td>
    <td height="15" width="70%"> 
      <input type="text" name="readme" size=40 value=<%=Tlink(0)%>>
    </td>
  </tr>
  <tr> 
    <td height="15" colspan="2"> 
      <div align="center"> 
        <input type="submit" name="Submit" value="�޸�">
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
                <td><font color="<%=TableContentColor%>">ע����� <br>
                  �����棬��������Ŀǰ���е�������̳�������Ա༭������̳����������һ���µ�������̳�� Ҳ���Ա༭��ɾ��Ŀǰ���ڵ�������̳�������Զ�Ŀǰ���������½������С� </font>
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
                <td height="22"><a href="admin_link.asp?action=add"><font color="<%=TableContentColor%>">�����µ�������̳</font></a></td>
              </tr>
            </table>
<%
	do while not rs.eof
         Tlink=split(rs(2),"$")
%>
<hr width=60% align=left color=black height=1>
            <table width="100%" border="0" cellspacing="3" cellpadding="0">
              <tr><td>��ţ�<b><font color=red><%=rs("id")%></font></b></td></tr>
              <tr> 
                <td><font color="<%=TableContentColor%>">���ƣ�<%=rs("boardname")%></font></td>
              </tr>
              <tr> 
                <td><font color="<%=TableContentColor%>">URL��<%=rs("url")%></font></td>
              </tr>
              <tr> 
                <td><font color="<%=TableContentColor%>">��飺<%=tlink(0)%></font></td>
              </tr>
              <tr> 
                <td><font color="<%=TableContentColor%>">ͼƬ��<%if ubound(Tlink)>1 then%><img src=<%=Tlink(1)%> ><%end if%></font></td>
              </tr>
              <tr align="left" valign="bottom"> 
                <td height="27"><font color="<%=TableContentColor%>"><a href="admin_link.asp?action=edit&id=<%=rs("id")%>"><font color="<%=TableContentColor%>">�༭��������̳</font></a> | <a href="admin_link.asp?action=del&id=<%=rs("id")%>"><font color="<%=TableContentColor%>">ɾ����������̳</font></a> | <a href="admin_link.asp?action=orders&id=<%=rs("id")%>"><font color="<%=TableContentColor%>">������̳��������</font></a></font></td>
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
                <td height="20"><a href="admin_link.asp?action=add"><font color="<%=TableContentColor%>">�����µ�������̳</font></a></td>
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
	body=body+"<br>"+"���³ɹ������������������"
else
	body=body+"<br>"+"����������������̳��Ϣ��"
end if
end sub

sub savedit()
	set rs= server.createobject ("adodb.recordset")
	sql = "select * from bbslink where id="+Cstr(request("id"))
	rs.Open sql,conn,1,3
	if rs.eof and rs.bof then
	body=body+"<br>"+"����û���ҵ�������̳��"
	else
	rs("boardname") = Trim(Request.Form ("name"))
	rs("readme") =  Trim(Request.Form ("readme")) &"$"& trim(request.Form("logo"))
	rs("url") = Request.Form ("url")
	rs.Update
	end if 
	rs.Close
	set rs=nothing
	body=body+"<br>"+"���³ɹ������������������"
end sub

sub del
	dim id
	id = request("id")
	sql="delete from bbslink where id="+id
	conn.Execute(sql)
	body=body+"<br>"+"ɾ���ɹ������������������"
end sub

sub orders()
%><br>
            <table width="95%" border="0" cellspacing="3" cellpadding="0" align=center>
              <tr> 
                <td height="22"><font color="<%=TableContentColor%>"><b>������̳��������</b><br>
ע�⣺������Ӧ��̳���������������Ӧ��������ţ�<font color=red>ע�ⲻ�ܺͱ��������̳����ͬ���������</font>��</font>
		</td>
              </tr>
	      <tr>
              <tr bgcolor="<%=atabletitlecolor%>"> 
                <td height="22" align=center><a href="admin_link.asp?action=add"><font color="<%=TableContentColor%>">�����µ�������̳</font></a></td>
              </tr>
	      <tr>
		<td><font color="<%=TableContentColor%>">
<%
	set rs= server.createobject ("adodb.recordset")
	sql="select * from bbslink where id="&cstr(request("id"))
	rs.open sql,conn,1,1
	if rs.eof and rs.bof then
		response.write "û���ҵ���Ӧ��������̳��"
	else
		response.write "<form action=admin_link.asp?action=updatorders method=post>"
		response.write ""&rs("boardname")&"  <input type=text name=newid size=2 value="&rs("id")&">"
		response.write "<input type=hidden name=id value="&request("id")&">"
		response.write "<input type=submit name=Submit value=�޸�></form>"
	end if
	rs.close
	set rs=nothing
%></font>
		</td>
	      </tr>
              <tr bgcolor="<%=atabletitlecolor%>"> 
                <td height="22" align=center><a href="admin_link.asp?action=add"><font color="<%=TableContentColor%>">�����µ�������̳</font></a></td>
              </tr>
            </table>
<%
end sub

sub updateorders()

	 sql="update bbslink set id="&request("newid")&" where id="&cstr(request("id"))
	conn.execute(sql)
	  response.write "<p align=center>���³ɹ���</p>"


end sub
%>