<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!-- #include file="chkuser.asp" -->
<!-- #include file="inc/char.asp" -->
<!--#include file="inc/theme.asp"-->
<%
    	Rem ----------------------
    	Rem ------主程序开始------
    	Rem ----------------------
	dim headnum
	if boardid=0 then
	stats="论坛总事件记录"
	headnum=1
	else
	stats=BoardType & "事件记录"
	headnum=2
	end if
	if bbseven=0 then
	Errmsg=Errmsg+"<br>"+"<li>该版面事件记录未公开，请浏览其他版面！"
	Founderr=true
	end if
	if master then founderr=false
	if founderr then
		call nav()
		call headline(headnum)
		call error()
	else
		call nav()
		call headline(headnum)
		if request("action")="dellog" then
		call batch()
		else
		call boardeven()
		end if
		if founderr then call error()
	end if
	call endline()
	REM 显示版面信息---Headinfo
	sub boardeven()
	dim totalrec
	dim n
	dim currentpage,page_count,Pcount
        currentPage=request("page")
	if currentpage="" or not isInteger(currentpage) then
		currentpage=1
	else
		currentpage=clng(currentpage)
		if err then
			currentpage=1
			err.clear
		end if
	end if
%>
<%if master then%>
<div align=center>管理员请点击操作时间切换到管理状态</div>
<%end if%>
<form action="bbseven.asp?action=dellog" method=post name=even>
<input type=hidden name=boardid value="<%=boardid%>">
<table width="<%=TableWidth%>" border="0" cellspacing="1" cellpadding="3" align="center" bgcolor="<%=TableBackColor%>">
  <tr bgcolor="<%=TableTitleColor%>" align=center> 
    <td width="15%" height=25>对象</td>
    <td width="50%">事件内容(<a href="bbseven.asp">查看所有事件记录</a>)</td>
    <td width="20%"><a href="bbseven.asp?action=batch&boardid=<%=boardid%>">操作时间</a></td>
    <td width="15%">操作人</td>
  </tr> 
<%
	dim bgcolor
	set rs=server.createobject("adodb.recordset")
	if boardid>0 then
	sql="select * from log where l_boardid="&boardid&" order by l_addtime desc"
	else
	sql="select * from log order by l_addtime desc"
	end if
	rs.open sql,conn,1,1
	if rs.bof and rs.eof then
%>
<tr bgcolor="<%=TablebodyColor%>"> 
    <td colspan=4 height=25>本版还没有任何事件</td>
</tr>
<%
	else
		rs.PageSize = MaxAnnouncePerpage
		rs.AbsolutePage=currentpage
		page_count=0
      		totalrec=rs.recordcount
		while (not rs.eof) and (not page_count = rs.PageSize)

		if bgcolor=TableBodyColor then
		bgcolor=aTableBodyColor
		else
		bgcolor=TableBodyColor
		end if
%>
<tr bgcolor="<%=bgColor%>"> 
    <td align=center height=24><a href=dispuser.asp?name=<%=htmlencode(rs("l_touser"))%> target=_blank><%=rs("l_touser")%></a></td>
    <td><%=rs("l_content")%></td>
    <td><%if request("action")="batch" then%><input type="checkbox" name="lid" value="<%=rs("l_id")%>"><%end if%><%=rs("l_addtime")%></td>
    <td align=center>
<%if bbsEvenView=1 or master then%>
<a href=dispuser.asp?name=<%=htmlencode(rs("l_username"))%> target=_blank><%=rs("l_username")%></a>
<%else%>
保密
<%end if%>
</td>
</tr>
<%
	  	page_count = page_count + 1
		rs.movenext
		wend
	dim endpage
	Pcount=rs.PageCount
	response.write "<tr bgcolor="&tablebodycolor&"><td valign=middle nowrap colspan=4 height=25>"&_
			"<font color="&bodyfontColor&">分页： "

	if currentpage > 4 then
	response.write "<a href=""?page=1&boardid="&boardid&""">[1]</a> ..."
	end if
	if Pcount>currentpage+3 then
	endpage=currentpage+3
	else
	endpage=Pcount
	end if
	for i=currentpage-3 to endpage
	if not i<1 then
		if i = clng(currentpage) then
        response.write " <font color="&AlertFontColor&">["&i&"]</font>"
		else
        response.write " <a href=""?page="&i&"&boardid="&boardid&""">["&i&"]</a>"
		end if
	end if
	next
	if currentpage+3 < Pcount then 
	response.write "... <a href=""?page="&Pcount&"&boardid="&boardid&""">["&Pcount&"]</a>"
	end if
	response.write "</font></td></tr>"
	rs.close
	set rs=nothing	
	end if
	if request("action")="batch" then
	response.write "<tr><td bgcolor="&tablebodycolor&" colspan=4>请选择要删除的事件，<input type=checkbox name=chkall value=on onclick=""CheckAll(this.form)"">全选 <input type=submit name=Submit value=执行  onclick=""{if(confirm('您确定执行的操作吗?')){this.document.even.submit();return true;}return false;}""></td></tr>"
	end if
%>
</table>
<script language="JavaScript">
<!--
function CheckAll(form)  {
  for (var i=0;i<form.elements.length;i++)    {
    var e = form.elements[i];
    if (e.name != 'chkall')       e.checked = form.chkall.checked; 
   }
  }
//-->
</script>
<%
	end sub

	sub batch()
	dim lid
	if founduser=false then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>请登陆后进行操作。"
	end if
	if request("boardid")="" then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>请指定论坛版面。"
	elseif not isInteger(request("boardid")) then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>非法的版面参数。"
	else
		boardid=request("boardid")
		if not master then
			founderr=true
			Errmsg=Errmsg+"<br>"+"<li>您不是该版面斑竹或者系统管理员。"
		end if
	end if
	if request("lid")="" then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>请指定相关事件。"
	else
		lid=CheckStr(request.Form("lid"))
	end if
	if founderr then exit sub
	conn.execute("delete from log where l_id in ("&lid&")")
	if err.number<>0 then
        	err.clear
		ErrMsg=ErrMsg+"<Br>"+"<li>数据库操作失败，请以后再试:"&err.Description 
  		exit sub
	else
		call success()
	end if
	end sub
sub success()
%>
    <table cellpadding=0 cellspacing=0 border=0 width=95% bgcolor=<%=aTablebackcolor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
    <tr align="center"> 
      <td width="100%" bgcolor=<%=aTabletitlecolor%>>成功：事件操作</td>
    </tr>
    <tr> 
      <td width="100%" bgcolor=<%=Tablebodycolor%>><li>您选择的事件已经删除。<br>
      </td>
    </tr>
    <tr align="center"> 
      <td width="100%" bgcolor=<%=aTabletitlecolor%>>
<a href="bbseven.asp?boardid=<%=request("boardid")%>"> << 返回事件页面</a>
      </td>
    </tr>  
    </table>   </td></tr></table>
<%
end sub
%>
<!--#include file="footer.asp"-->
