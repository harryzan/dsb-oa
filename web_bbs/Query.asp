<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!-- #include file="chkuser.asp" -->
<!--#include file="inc/char.asp"-->
<!--#include file="inc/theme.asp"-->
<%
	stats="论坛搜索"
   	dim sel
   	dim username
	if Search_G=1 and membername="" then
		Errmsg=Errmsg+"<br>"+"<li>本论坛设置为未登陆用户不能搜索，请<a href=login.asp>登陆</a>。"
		founderr=true
	end if
	if founderr then
		call nav()
		call headline(1)
		call error()
	else
		call main()
	end if
sub main()

	if boardmaster or master then
		guestlist=""
	else
		guestlist=" lockboard=0 and "
	end if
   	boardid=request("boardid")
	if BoardID="" or not isInteger(BoardID) then
		boardid=0
	else
		boardid=request("boardid")
	end if
	call nav()
	call headline(1)
%>
    <table cellpadding=0 cellspacing=0 border=0 width="<%=tablewidth%>" bgcolor="<%=TableBackColor%>" align=center>
    <tr><td>
    <table cellpadding=5 cellspacing=1 border=0 width=100%>
    
						<tr>
						<td bgcolor="<%=TableTitleColor%>" valign=middle colspan=2 align="center">
						<p><form action="queryresult.asp" method="post">
						<font color="<%=TableFontColor%>"><b>请输入要搜索的关键字</b></font></td></tr>
						<tr>
						<td bgcolor="<%=TableBodyColor%>" colspan=2 align="center" valign="middle"><font  color="<%=TableContentColor%>">
						(同时查询多个条件使用'<font  color="<%=AlertFontColor%>">or</font>' 分隔关键字，查询同时满足某条件使用'<font  color="<%=AlertFontColor%>">and</font>'分隔关键字)</font><br><br><input type=text size=40 name="keyword"></td></tr>
                        <tr>
						<td bgcolor="<%=aTableBodyColor%>" valign=middle colspan=2 align=center><font  color="<%=TableContentColor%>"><b>搜索选项</b></font></td></tr>

                        <tr>
						<td bgcolor="<%=TableBodyColor%>" align="right" valign="middle"><font color="<%=TableContentColor%>">
                        <b>作者搜索</b></font>&nbsp;<input name="sType" type="radio" value="1">
                        </td>
                        <td bgcolor="<%=TableBodyColor%>" align="left" valign="middle">
                        <select name="nSearch">
						                  <option value=1>搜索主题作者
						                  <option value=2>搜索回复作者
						                  <option value=3>两者都搜索
						                  </select>
						                  
                        </td>
                        </tr>
                        <tr>
                        <td bgcolor="<%=TableBodyColor%>" align="right" valign="middle"><font color="<%=TableContentColor%>">
                        <b>关键字搜索</b></font>&nbsp;<input name="sType" type="radio" value="2" checked>
                        </td>
                        <td bgcolor="<%=TableBodyColor%>" align="left" valign="middle">
                        <select name="pSearch">
						                  <option value=1>在主题中搜索关键字
						                  <!--<option value=2>在贴子内容中搜索关键字
						                  <option value=3>两者都搜索-->
						                  </select>
						                  
                        </td>
                        </tr>
                        <tr>
                        <td bgcolor="<%=TableBodyColor%>" align="right" valign="middle"><font color="<%=TableContentColor%>">
                        <b>日期范围</b></font>
                        </td>
                        <td bgcolor="<%=TableBodyColor%>" align="left" valign="middle">
<select name=SearchDate class=smallsel> <option value=ALL>所有日期<option value=1>昨天以来<option  selected value=5>5天以来<option value=10>10天以来<option value=30>30天以来</option></select> 
						                  
                        </td>
                        </tr>
                        <tr>
						<td bgcolor="<%=aTableBodyColor%>" valign="middle" colspan=2 align=center><font color="<%=TableContentColor%>"><b>请选择要搜索的论坛 (不要选那些用 >> 和 << 括起来的，那只是类别名，不是论坛)</b></font></td></tr>
						<tr>
						<td bgcolor="<%=TableBodyColor%>" colspan="2" valign="middle" align="center"><font color="<%=TableContentColor%>">
                        <b>搜索论坛： &nbsp; 
<select name=boardid size=1>
<option value=0>所有论坛</option>
<%
	dim rs1,sql1
	dim arrRow,arrRow1,ii
	sql="select id,class from class order by id"
	set rs=server.createobject("adodb.recordset")
	set rs1=server.createobject("adodb.recordset")
	rs.open sql,conn,1,1
	if not(rs.eof and rs.bof) then
	arrRow=rs.getRows
	rs.close : set rs=nothing

	for i=0 to Ubound(arrRow,2)
	response.write "<option value=0>>>&nbsp;"& arrRow(1,i) &" <<"

		sql1="select boardid,boardtype from board where "&guestlist&" class="& arrRow(0,i)&" order by boardid"
		set rs1=server.createobject("adodb.recordset")
		rs1.open sql1,conn,1,1
		if rs1.eof and rs1.bof then
			rs1.close : set rs1=nothing
			response.write "<option value=0>没有论坛"
		else
			arrRow1=rs1.getrows
			rs1.close : set rs1=nothing
			for ii=0 to Ubound(arrRow1,2)
				response.write "<option value="& arrRow1(0,ii) &""
				if boardid<>"" then
				if cint(boardid)=cint(arrRow1(0,ii)) then response.write " selected "
				end if
				response.write ">"& arrRow1(1,ii)
			next
			arrRow1=null
		end if
	next
	arrRow=null
	end if
%>
</select>
						</b></td>
						</tr>
						<tr>
						<td bgcolor="<%=TableTitleColor%>" valign=middle colspan=2 align=center>
						<input type=submit value="开始搜索">
						</td></form></tr></table></td></tr></table>
<%
end sub

call endline()
%>
<!--#include file="footer.asp"-->
