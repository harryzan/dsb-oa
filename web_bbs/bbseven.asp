<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!-- #include file="chkuser.asp" -->
<!-- #include file="inc/char.asp" -->
<!--#include file="inc/theme.asp"-->
<%
    	Rem ----------------------
    	Rem ------������ʼ------
    	Rem ----------------------
	dim headnum
	if boardid=0 then
	stats="��̳���¼���¼"
	headnum=1
	else
	stats=BoardType & "�¼���¼"
	headnum=2
	end if
	if bbseven=0 then
	Errmsg=Errmsg+"<br>"+"<li>�ð����¼���¼δ������������������棡"
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
	REM ��ʾ������Ϣ---Headinfo
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
<div align=center>����Ա��������ʱ���л�������״̬</div>
<%end if%>
<form action="bbseven.asp?action=dellog" method=post name=even>
<input type=hidden name=boardid value="<%=boardid%>">
<table width="<%=TableWidth%>" border="0" cellspacing="1" cellpadding="3" align="center" bgcolor="<%=TableBackColor%>">
  <tr bgcolor="<%=TableTitleColor%>" align=center> 
    <td width="15%" height=25>����</td>
    <td width="50%">�¼�����(<a href="bbseven.asp">�鿴�����¼���¼</a>)</td>
    <td width="20%"><a href="bbseven.asp?action=batch&boardid=<%=boardid%>">����ʱ��</a></td>
    <td width="15%">������</td>
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
    <td colspan=4 height=25>���滹û���κ��¼�</td>
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
����
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
			"<font color="&bodyfontColor&">��ҳ�� "

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
	response.write "<tr><td bgcolor="&tablebodycolor&" colspan=4>��ѡ��Ҫɾ�����¼���<input type=checkbox name=chkall value=on onclick=""CheckAll(this.form)"">ȫѡ <input type=submit name=Submit value=ִ��  onclick=""{if(confirm('��ȷ��ִ�еĲ�����?')){this.document.even.submit();return true;}return false;}""></td></tr>"
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
		Errmsg=Errmsg+"<br>"+"<li>���½����в�����"
	end if
	if request("boardid")="" then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>��ָ����̳���档"
	elseif not isInteger(request("boardid")) then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>�Ƿ��İ��������"
	else
		boardid=request("boardid")
		if not master then
			founderr=true
			Errmsg=Errmsg+"<br>"+"<li>�����Ǹð���������ϵͳ����Ա��"
		end if
	end if
	if request("lid")="" then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>��ָ������¼���"
	else
		lid=CheckStr(request.Form("lid"))
	end if
	if founderr then exit sub
	conn.execute("delete from log where l_id in ("&lid&")")
	if err.number<>0 then
        	err.clear
		ErrMsg=ErrMsg+"<Br>"+"<li>���ݿ����ʧ�ܣ����Ժ�����:"&err.Description 
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
      <td width="100%" bgcolor=<%=aTabletitlecolor%>>�ɹ����¼�����</td>
    </tr>
    <tr> 
      <td width="100%" bgcolor=<%=Tablebodycolor%>><li>��ѡ����¼��Ѿ�ɾ����<br>
      </td>
    </tr>
    <tr align="center"> 
      <td width="100%" bgcolor=<%=aTabletitlecolor%>>
<a href="bbseven.asp?boardid=<%=request("boardid")%>"> << �����¼�ҳ��</a>
      </td>
    </tr>  
    </table>   </td></tr></table>
<%
end sub
%>
<!--#include file="footer.asp"-->
