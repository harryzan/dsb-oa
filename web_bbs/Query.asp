<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!-- #include file="chkuser.asp" -->
<!--#include file="inc/char.asp"-->
<!--#include file="inc/theme.asp"-->
<%
	stats="��̳����"
   	dim sel
   	dim username
	if Search_G=1 and membername="" then
		Errmsg=Errmsg+"<br>"+"<li>����̳����Ϊδ��½�û�������������<a href=login.asp>��½</a>��"
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
						<font color="<%=TableFontColor%>"><b>������Ҫ�����Ĺؼ���</b></font></td></tr>
						<tr>
						<td bgcolor="<%=TableBodyColor%>" colspan=2 align="center" valign="middle"><font  color="<%=TableContentColor%>">
						(ͬʱ��ѯ�������ʹ��'<font  color="<%=AlertFontColor%>">or</font>' �ָ��ؼ��֣���ѯͬʱ����ĳ����ʹ��'<font  color="<%=AlertFontColor%>">and</font>'�ָ��ؼ���)</font><br><br><input type=text size=40 name="keyword"></td></tr>
                        <tr>
						<td bgcolor="<%=aTableBodyColor%>" valign=middle colspan=2 align=center><font  color="<%=TableContentColor%>"><b>����ѡ��</b></font></td></tr>

                        <tr>
						<td bgcolor="<%=TableBodyColor%>" align="right" valign="middle"><font color="<%=TableContentColor%>">
                        <b>��������</b></font>&nbsp;<input name="sType" type="radio" value="1">
                        </td>
                        <td bgcolor="<%=TableBodyColor%>" align="left" valign="middle">
                        <select name="nSearch">
						                  <option value=1>������������
						                  <option value=2>�����ظ�����
						                  <option value=3>���߶�����
						                  </select>
						                  
                        </td>
                        </tr>
                        <tr>
                        <td bgcolor="<%=TableBodyColor%>" align="right" valign="middle"><font color="<%=TableContentColor%>">
                        <b>�ؼ�������</b></font>&nbsp;<input name="sType" type="radio" value="2" checked>
                        </td>
                        <td bgcolor="<%=TableBodyColor%>" align="left" valign="middle">
                        <select name="pSearch">
						                  <option value=1>�������������ؼ���
						                  <!--<option value=2>�����������������ؼ���
						                  <option value=3>���߶�����-->
						                  </select>
						                  
                        </td>
                        </tr>
                        <tr>
                        <td bgcolor="<%=TableBodyColor%>" align="right" valign="middle"><font color="<%=TableContentColor%>">
                        <b>���ڷ�Χ</b></font>
                        </td>
                        <td bgcolor="<%=TableBodyColor%>" align="left" valign="middle">
<select name=SearchDate class=smallsel> <option value=ALL>��������<option value=1>��������<option  selected value=5>5������<option value=10>10������<option value=30>30������</option></select> 
						                  
                        </td>
                        </tr>
                        <tr>
						<td bgcolor="<%=aTableBodyColor%>" valign="middle" colspan=2 align=center><font color="<%=TableContentColor%>"><b>��ѡ��Ҫ��������̳ (��Ҫѡ��Щ�� >> �� << �������ģ���ֻ���������������̳)</b></font></td></tr>
						<tr>
						<td bgcolor="<%=TableBodyColor%>" colspan="2" valign="middle" align="center"><font color="<%=TableContentColor%>">
                        <b>������̳�� &nbsp; 
<select name=boardid size=1>
<option value=0>������̳</option>
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
			response.write "<option value=0>û����̳"
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
						<input type=submit value="��ʼ����">
						</td></form></tr></table></td></tr></table>
<%
end sub

call endline()
%>
<!--#include file="footer.asp"-->
