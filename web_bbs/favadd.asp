<!-- #include file="conn.asp" -->
<!-- #include file="inc/char.asp" -->
<!-- #include file="inc/const.asp" -->
<!-- #include file="chkuser.asp" -->
<!--#include file="inc/theme.asp"-->
<%
	rem ----------------------
	rem ------������ʼ------
	rem ----------------------
	dim announceid
	dim rootid
	dim topic
	dim url
	stats="��̳�ղؼ�"
	if membername="" then
		Errmsg=Errmsg+"<br>"+"<li>����û��<a href=reg.asp>��¼</a>��"
		Founderr=true
	end if
	if request("boardid")="" then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>��ָ����̳���档"
	elseif not isInteger(request("boardid")) then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>�Ƿ��İ��������"
	else
		boardid=request("boardid")
	end if
	if request("id")="" then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>��ָ��������ӡ�"
	elseif not isInteger(request("id")) then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>�Ƿ������Ӳ�����"
	else
		AnnounceID=request("id")
	end if
	if request("RootID")="" then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>��ָ��������ӡ�"
	elseif not isInteger(request("RootID")) then
		founderr=true
		Errmsg=Errmsg+"<br>"+"<li>�Ƿ������Ӳ�����"
	else
		RootID=request("RootID")
	end if
	call nav()
	call headline(1)
	if founderr then
		call Error()
	else
		url="dispbbs.asp?"
		url=url+"boardid="+boardid+"&rootid="+rootid+"&id="+announceid
		call chkurl()
		if founderr=true then
			call Error()
		else
			call favadd()
			if founderr=true then
				call Error()
			else
				call success()
			end if
		end if
	end if
	call endline()

	sub chkurl()
		sql="select topic,rootid,announceid,boardid from bbs1 where announceid="&cstr(announceid)&" and rootid="&cstr(rootid)&" and boardid="&cstr(boardid)
		set rs=server.createobject("adodb.recordset")
		rs.open sql,conn,1,1
		if rs.eof and rs.bof then
			Errmsg=Errmsg+"<br>"+"<li>û��������ӡ�"
			Founderr=true
		else
			topic=rs("topic")
		end if
		rs.close
		set rs=nothing
	end sub
	sub favadd()
		sql="select * from bookmark where url='"&trim(url)&"'"
		set rs=server.createobject("adodb.recordset")
		rs.open sql,conn,1,3
		if not rs.eof and not rs.bof then
			Errmsg=Errmsg+"<br>"+"<li>�������Ѿ����ղؼ��С�"
			Founderr=true
		else
		rs.addnew
		rs("username")=membername
		rs("topic")=topic
		rs("url")=url
		rs("addtime")=Now()
		rs.update
		end if
		rs.close
		set rs=nothing
	end sub

	sub success()
%>
    <table cellpadding=0 cellspacing=0 border=0 width=<%=TableWidth%> bgcolor=<%=tablebackcolor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
    <tr align="center"> 
      <td width="100%" bgcolor=<%=tabletitlecolor%>><font color="<%=TablefontColor%>">�ɹ��������ղ�</font></td>
    </tr>
    <tr> 
      <td width="100%" bgcolor=<%=tablebodycolor%>><font color="<%=TableContentColor%>"><b>�������Ѿ�����������̳��<a href=favlist.asp>�ղؼ�</a></b><br><br></font>
      </td>
    </tr>
    <tr align="center"> 
      <td width="100%" bgcolor=<%=tabletitlecolor%>>
<a href="javascript:history.go(-1)"> << ������һҳ</a>
      </td>
    </tr>  
    </table>   </td></tr></table>
<%
	end sub

   	rem ----------------------
	rem ------���������------
	rem ----------------------
%>
<!--#include file="footer.asp"-->
