<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!-- #include file="chkuser.asp" -->
<!-- #include file="inc/char.asp" -->
<!--#include file="inc/theme.asp"-->
<%
    	Rem ----------------------
    	Rem ------主程序开始------
    	Rem ----------------------
	dim username
	dim locktype
	stats="管理用户"
	if not master then
	Errmsg=Errmsg+"<br>"+"<li>您不是管理员，没有权限进行此项操作！"
	Founderr=true
	end if
	if request("name")="" then
		Errmsg=Errmsg+"<br>"+"<li>请指定所操作的用户！"
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
			locktype="锁定"
		elseif request("action")="lock_2" then
			conn.execute("update [user] set LockUser=2 where username='"&username&"' and userclass<20")
			locktype="屏蔽"
		elseif request("action")="lock_3" then
			conn.execute("update [user] set LockUser=0 where username='"&username&"' and userclass<20")
			locktype="解锁"
		else
		Errmsg=Errmsg+"<br>"+"<li>请指定正确的参数！"
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
	doWealthMsg="金钱" & request("doWealth") & "，"
	end if

	if not isnumeric(request("douserEP")) or request("douserEP")="0" or request("douserEP")="" then
	douserEP=0
	douserEPMsg=""
	else
	douserEP=request("douserEP")
	douserEPMsg="经验" & request("douserEP") & "，"
	end if

	if not isnumeric(request("douserCP")) or request("douserCP")="0" or request("douserCP")="" then
	douserCP=0
	douserCPMsg=""
	else
	douserCP=request("douserCP")
	douserCPMsg="魅力" & request("douserCP") & "，"
	end if

	if not isnumeric(request("douserPower")) or request("douserPower")="0" or request("douserPower")="" then
	douserPower=0
	douserPowerMsg=""
	else
	douserPower=request("douserPower")
	douserPowerMsg="威望" & request("douserPower")
	end if

	if doWealthMsg="" and douserEPMsg="" and douserCPMsg="" and douserPowerMsg="" then
	allmsg="没有对用户进行分值操作"
	else
	allmsg="用户操作：" & doWealthMsg & douserEPMsg & douserCPMsg & douserPowerMsg
	end if
	'response.write allmsg
	'response.end
	title=request.form("title")
	content=request.form("content")
	content="原因：" & title & content
	if request.form("title")="" and request.form("content")="" then
		Errmsg=Errmsg+"<br><li>请写明操作原因。"
		founderr=true
		exit sub
	end if

	sql="insert into log (l_touser,l_username,l_content,l_ip) values ('"&username&"','"&membername&"','用户操作："&content& "，"&allmsg&"','"&ip&"')"
	conn.execute(sql)
	if allmsg<>"" then
		conn.execute("update [user] set userWealth=userWealth+"&doWealth&",userCP=userCP+"&douserCP&",userEP=userEP+"&douserEP&",userPower=userPower+"&douserPower&" where username='"&username&"'")
	end if
	locktype="用户操作"
	call success()
else
%><FORM METHOD=POST ACTION="admin_lockuser.asp?action=power">
<table width="70%" border="0" cellspacing="1" cellpadding="3" align="center" bgcolor="<%=TableBackColor%>">
  <tr> 
    <td bgcolor="<%=TabletitleColor%>" height=24><b>
      <font color="<%=TableFontColor%>">论坛管理中心－－您要进行的操作是奖励用户</font></b></td>
  </tr>   
  <tr> 
    <td bgcolor="<%=TablebodyColor%>" height=24><b>
      <font color="<%=TableContentColor%>">操作理由</font></b>：  
	  <select name="title" size=1>
<option value="">自定义</option>
<option value="多次发表好文章">多次发表好文章</option>
<option value="对社区建设有贡献">对社区建设有贡献</option>
<option value="多次发表灌水帖子">多次发表灌水帖子</option>
<option value="多次发表广告帖子">多次发表广告帖子</option>
	  </select>
	  <input type="text" name="content" size=50>  *</td>
  </tr>   
  <tr> 
    <td bgcolor="<%=TablebodyColor%>" height=24><b>
      <font color="<%=TableContentColor%>">用户操作</font></b>：  金钱
	<select name="doWealth" size=1>

<%for i=-50 to 50%>
<option value="<%=i%>" <%if cint(i)=cint(0) then%>selected<%end if%>><%=i%></option>
<%next%>
	</select>&nbsp;魅力
	<select name="douserCP" size=1>

<%for i=-50 to 50%>
<option value="<%=i%>" <%if cint(i)=cint(0) then%>selected<%end if%>><%=i%></option>
<%next%>
	</select>&nbsp;经验
	<select name="douserEP" size=1>

<%for i=-50 to 50%>
<option value="<%=i%>" <%if cint(i)=cint(0) then%>selected<%end if%>><%=i%></option>
<%next%>
	</select>&nbsp;威望
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
      <font color="<%=TableFontColor%>">请慎重使用管理员的管理职能，管理员所有操作将被记录&nbsp;<input type="submit" name=submit value="确认操作"></font></td>
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
      <td width="100%" bgcolor=<%=Tabletitlecolor%>>成功：用户操作</td>
    </tr>
    <tr> 
      <td width="100%" bgcolor=<%=Tablebodycolor%>><li>您选择的用户已经<%=locktype%>。<br>
      </td>
    </tr>
    <tr align="center"> 
      <td width="100%" bgcolor=<%=Tabletitlecolor%>>
<a href="dispuser.asp?name=<%=username%>"> << 返回用户页面</a>
      </td>
    </tr>  
    </table>   </td></tr></table>
<%
end sub
%>
<!--#include file="footer.asp"-->
