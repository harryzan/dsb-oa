<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!-- #include file="chkuser.asp" -->
<!-- #include file="inc/char.asp" -->
<!--#include file="inc/theme.asp"-->
<%
    	Rem ----------------------
    	Rem ------������ʼ------
    	Rem ----------------------
	dim username
	dim locktype
	stats="�����û�"
	if not master then
	Errmsg=Errmsg+"<br>"+"<li>�����ǹ���Ա��û��Ȩ�޽��д��������"
	Founderr=true
	end if
	if request("name")="" then
		Errmsg=Errmsg+"<br>"+"<li>��ָ�����������û���"
		Founderr=true
	else
		username=CheckStr(request("name"))
	end if
	if founderr then
		call nav()
		call headline(1)
		call error()
	else
		call nav()
		call headline(1)
		if request("action")="power" then
			call Poweruser()
		else
			call lockuser()
		end if
		if founderr then call error()
	end if
	call endline()
	sub lockuser()
		if request("action")="lock_1" then
			conn.execute("update [user] set LockUser=1 where username='"&username&"' and userclass<20")
			locktype="����"
		elseif request("action")="lock_2" then
			conn.execute("update [user] set LockUser=2 where username='"&username&"' and userclass<20")
			locktype="����"
		elseif request("action")="lock_3" then
			conn.execute("update [user] set LockUser=0 where username='"&username&"' and userclass<20")
			locktype="����"
		else
		Errmsg=Errmsg+"<br>"+"<li>��ָ����ȷ�Ĳ�����"
		Founderr=true
		exit sub
		end if
		call success()
	end sub

	sub Poweruser()
if request("checked")="yes" then
	dim doWealth,douserEP,douserCP,douserPower
	dim doWealthMsg,douserEPMsg,douserCPMsg,douserPowerMsg,allMsg
	dim title,content,ip
	if not isnumeric(request("doWealth")) or request("doWealth")="0" or request("doWealth")="" then
	doWealth=0
	doWealthMsg=""
	else
	doWealth=request("doWealth")
	doWealthMsg="��Ǯ" & request("doWealth") & "��"
	end if

	if not isnumeric(request("douserEP")) or request("douserEP")="0" or request("douserEP")="" then
	douserEP=0
	douserEPMsg=""
	else
	douserEP=request("douserEP")
	douserEPMsg="����" & request("douserEP") & "��"
	end if

	if not isnumeric(request("douserCP")) or request("douserCP")="0" or request("douserCP")="" then
	douserCP=0
	douserCPMsg=""
	else
	douserCP=request("douserCP")
	douserCPMsg="����" & request("douserCP") & "��"
	end if

	if not isnumeric(request("douserPower")) or request("douserPower")="0" or request("douserPower")="" then
	douserPower=0
	douserPowerMsg=""
	else
	douserPower=request("douserPower")
	douserPowerMsg="����" & request("douserPower")
	end if

	if doWealthMsg="" and douserEPMsg="" and douserCPMsg="" and douserPowerMsg="" then
	allmsg="û�ж��û����з�ֵ����"
	else
	allmsg="�û�������" & doWealthMsg & douserEPMsg & douserCPMsg & douserPowerMsg
	end if
	'response.write allmsg
	'response.end
	title=request.form("title")
	content=request.form("content")
	content="ԭ��" & title & content
	if request.form("title")="" and request.form("content")="" then
		Errmsg=Errmsg+"<br><li>��д������ԭ��"
		founderr=true
		exit sub
	end if

	sql="insert into log (l_touser,l_username,l_content,l_ip) values ('"&username&"','"&membername&"','�û�������"&content& "��"&allmsg&"','"&ip&"')"
	conn.execute(sql)
	if allmsg<>"" then
		conn.execute("update [user] set userWealth=userWealth+"&doWealth&",userCP=userCP+"&douserCP&",userEP=userEP+"&douserEP&",userPower=userPower+"&douserPower&" where username='"&username&"'")
	end if
	locktype="�û�����"
	call success()
else
%><FORM METHOD=POST ACTION="admin_lockuser.asp?action=power">
<table width="70%" border="0" cellspacing="1" cellpadding="3" align="center" bgcolor="<%=TableBackColor%>">
  <tr> 
    <td bgcolor="<%=TabletitleColor%>" height=24><b>
      <font color="<%=TableFontColor%>">��̳�������ģ�����Ҫ���еĲ����ǽ����û�</font></b></td>
  </tr>   
  <tr> 
    <td bgcolor="<%=TablebodyColor%>" height=24><b>
      <font color="<%=TableContentColor%>">��������</font></b>��  
	  <select name="title" size=1>
<option value="">�Զ���</option>
<option value="��η��������">��η��������</option>
<option value="�����������й���">�����������й���</option>
<option value="��η����ˮ����">��η����ˮ����</option>
<option value="��η���������">��η���������</option>
	  </select>
	  <input type="text" name="content" size=50>  *</td>
  </tr>   
  <tr> 
    <td bgcolor="<%=TablebodyColor%>" height=24><b>
      <font color="<%=TableContentColor%>">�û�����</font></b>��  ��Ǯ
	<select name="doWealth" size=1>

<%for i=-50 to 50%>
<option value="<%=i%>" <%if cint(i)=cint(0) then%>selected<%end if%>><%=i%></option>
<%next%>
	</select>&nbsp;����
	<select name="douserCP" size=1>

<%for i=-50 to 50%>
<option value="<%=i%>" <%if cint(i)=cint(0) then%>selected<%end if%>><%=i%></option>
<%next%>
	</select>&nbsp;����
	<select name="douserEP" size=1>

<%for i=-50 to 50%>
<option value="<%=i%>" <%if cint(i)=cint(0) then%>selected<%end if%>><%=i%></option>
<%next%>
	</select>&nbsp;����
	<select name="douserPower" size=1>

<%for i=-5 to 5%>
<option value="<%=i%>" <%if cint(i)=cint(0) then%>selected<%end if%>><%=i%></option>
<%next%>
	</select>
  *</td>
  </tr> 
<input type=hidden value="yes" name="checked">
<input type=hidden value="<%=username%>" name="name">
  <tr> 
    <td bgcolor="<%=TabletitleColor%>" height=24>
      <font color="<%=TableFontColor%>">������ʹ�ù���Ա�Ĺ���ְ�ܣ�����Ա���в���������¼&nbsp;<input type="submit" name=submit value="ȷ�ϲ���"></font></td>
  </tr>   
</table>
</FORM>
<%
end if
	end sub
sub success()
%>
    <table cellpadding=0 cellspacing=0 border=0 width=95% bgcolor=<%=Tablebackcolor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
    <tr align="center"> 
      <td width="100%" bgcolor=<%=Tabletitlecolor%>>�ɹ����û�����</td>
    </tr>
    <tr> 
      <td width="100%" bgcolor=<%=Tablebodycolor%>><li>��ѡ����û��Ѿ�<%=locktype%>��<br>
      </td>
    </tr>
    <tr align="center"> 
      <td width="100%" bgcolor=<%=Tabletitlecolor%>>
<a href="dispuser.asp?name=<%=username%>"> << �����û�ҳ��</a>
      </td>
    </tr>  
    </table>   </td></tr></table>
<%
end sub
%>
<!--#include file="footer.asp"-->
