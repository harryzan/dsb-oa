<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!-- #include file="chkuser.asp" -->
<!-- #include file="inc/char.asp" -->
<!--#include file="inc/theme.asp"-->
<%
    	Rem ----------------------
    	Rem ------主程序开始------
    	Rem ----------------------
	if boardid=0 then
	stats="论坛全部小字报"
	else
	stats=BoardType & "小字报"
	end if
	if smallpaper=0 then
	Errmsg=Errmsg+"<br>"+"<li>该版面未开放小子报，请浏览其他版面！"
	Founderr=true
	end if
	if founderr then
		call nav()
		call headline(2)
		call error()
	else
		call nav()
		call headline(2)
		if request("action")="delpaper" then
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
<%if boardmaster or master then%>
<div align=center>版主或管理员请点击人气切换到管理状态</div>
<%end if%>
<form action=allpaper.asp?action=delpaper method=post name=paper>
<input type=hidden name=boardid value="<%=boardid%>">
<table width="<%=TableWidth%>" border="0" cellspacing="1" cellpadding="3" align="center" bgcolor="<%=TableBackColor%>">
  <tr bgcolor="<%=TableTitleColor%>" align=center> 
    <td width="15%" height=25>用户</td>
    <td width="50%">标题</td>
    <td width="20%">发布时间</td>
    <td width="15%"><a href="allpaper.asp?action=batch&boardid=<%=boardid%>">人气</a></td>
  </tr> 
<%
	dim bgcolor
	set rs=server.createobject("adodb.recordset")
	sql="select * from smallpaper where s_boardid="&boardid&" order by s_addtime desc"
	rs.open sql,conn,1,1
	if rs.bof and rs.eof then
%>
<tr bgcolor="<%=TablebodyColor%>"> 
    <td colspan=4 height=25>本版还没有小字报</td>
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
<tr bgcolor="<%=bgcolor%>"> 
    <td align=center height=24><a href=dispuser.asp?name=<%=htmlencode(rs("s_username"))%> target=_blank><%=rs("s_username")%></a></td>
    <td><a href=javascript:openScript('viewpaper.asp?id=<%=rs("s_id")%>&boardid=<%=boardid%>',500,400)><%=rs("s_title")%></a></td>
    <td><%=rs("s_addtime")%></td>
    <td align=center><%if request("action")="batch" then%><input type="checkbox" name="sid" value="<%=rs("s_id")%>"><%else%><%=rs("s_hits")%><%end if%></td>
</tr>
<%
	  	page_count = page_count + 1
		rs.movenext
		wend
	dim endpage
	Pcount=rs.PageCount
	response.write "<table border=0 cellpadding=0 cellspacing=3 width="""&tablewidth&""" align=center>"&_
			"<tr><td valign=middle nowrap>"&_
			"<font color="&bodyfontColor&">页次：<b>"&currentpage&"</b>/<b>"&Pcount&"</b>页"&_
			"每页<b>"&MaxAnnouncePerpage&"</b> 共有<b>"&totalrec&"</b>条</td>"&_
			"<td valign=middle nowrap><div align=right><p>分页： "

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
	response.write "<tr><td bgcolor="&tablebodycolor&" colspan=4>请选择要删除的小字报，<input type=checkbox name=chkall value=on onclick=""CheckAll(this.form)"">全选 <input type=submit name=Submit value=执行  onclick=""{if(confirm('您确定执行的操作吗?')){this.document.paper.submit();return true;}return false;}""></td></tr>"
	end if
%>
</table></form>
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
	dim sid
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
		if chkboardmaster(boardid)=false then
			founderr=true
			Errmsg=Errmsg+"<br>"+"<li>您不是该版面斑竹或者系统管理员。"
		end if
	end if
	if request("sid")="" then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>请指定相关小字报。"
	else
		sid=CheckStr(request.Form("sid"))
	end if
	if founderr then exit sub
	conn.execute("delete from SmallPaper where s_boardid="&boardid&" and s_id in ("&sid&")")
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
      <td width="100%" bgcolor=<%=aTabletitlecolor%>>成功：小字报操作</td>
    </tr>
    <tr> 
      <td width="100%" bgcolor=<%=Tablebodycolor%>><li>您选择的小字报已经删除。<br>
      </td>
    </tr>
    <tr align="center"> 
      <td width="100%" bgcolor=<%=aTabletitlecolor%>>
<a href="allpaper.asp?boardid=<%=request("boardid")%>"> << 返回小字报页面</a>
      </td>
    </tr>  
    </table>   </td></tr></table>
<%
end sub
%>
<!--#include file="footer.asp"-->
