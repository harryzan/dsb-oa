<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=inc/theme.asp-->
<!--#include file=chkuser.asp-->
<%
	stats="��������ҳ��"
	dim sql1,rs1
	dim id,rootid
	dim Maxid
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
		if chkboardmaster(boardid)=false then
			founderr=true
			Errmsg=Errmsg+"<br>"+"<li>�����Ǹð���������ϵͳ����Ա��"
		end if
	end if
	call nav()
	call headline(2)
	if founderr=true then
		call error()
	else
	dim title
	dim content
	set rs=server.createobject("adodb.recordset")
	call main()
	end if
	set rs=nothing
	call endline()
	sub main()
%>
<table cellpadding=0 cellspacing=0 border=0 width=<%=tablewidth%> bgcolor=<%=tablebackcolor%> align=center>
  <tr>
    <td>
      <table cellpadding=3 cellspacing=1 border=0 width=100%>
        <tr bgcolor='<%=Tabletitlecolor%>'>
          <td align=center colspan="2"><font color="<%=TablefontColor%>">��ӭ<b> <%=htmlencode(membername)%></b>�����������ҳ��</font></td>
        </tr>
            <tr bgcolor=<%=tablebodycolor%>>
              <td width="30%" valign=top><font color="<%=TableContentColor%>">
&nbsp;&nbsp;ע�⣺������������������Լ��������ɷ�������Ͱ������ã�����Ա���������а��淢����������Ϣ���й��������
<br><BR>
            <BR>
</font>
	      </td>
              <td width="70%" valign=top>
<font color="<%=TableContentColor%>">
      		<table cellpadding=0 cellspacing=0 border=0 width=100% align=center>
		  <tr>
			<td width="100%" height=24 bgcolor=<%=aTableTitlecolor%>>
<font color="<%=TableContentColor%>">
<B>ע��</B>��<BR>
                  ��ҳ��Ϊ����ר�ã��ڽ��й������õ�ʱ�򣬲�Ҫ����������ã�������ģ�������д����������ȷ����д��<BR><b>
                  ����ѡ�<a href=admin_boardaset.asp?boardid=<%=boardid%>><font color="<%=TableContentColor%>">��̳���淢��</font></a> 
                  <%if master then%>
                  | <b><a href=admin_boardaset.asp?action=manage&boardid=<%=boardid%>><font color="<%=TableContentColor%>">�������</font></a> 
                  <%end if%>
                  </b></font> </td>
              </tr>
		</table>
<%
	select case request("action")
	case "new"
		call savenews()
	case "manage"
		call manage()
	case "edit"
		call edit()
	case "updat"
		call update()
	case "del"
		call del()
	case "editbminfo"
		call editbminfo()
	case "saveditbm"
		call savebminfo()
	case "editbmset"
		call editbmset()
	case "savebmset"
		call savebmset()
	case "editbmcolor"
		call editbmcolor()
	case "savebmcolor"
		call savebmcolor()
	case else
	call news()
	end select
%></font>
	      </td>
            </tr>
        </table>
        </td>
    </tr>
</table>
<%
end sub

sub news()
%>
<form action="admin_boardaset.asp?action=new" method=post name=FORM>
      		
  <table cellpadding=0 cellspacing=0 border=0 width=100% align=center>
    <tr> 
      <td width="20%" valign=top> 
        <div align="center"><font color="<%=TableContentColor%>">�������棺 </font></div>
      </td>
      <td width="80%"> 
        <%if master then%>
        <%
   sql="select boardid,boardtype from board"
   rs.open sql,conn,1,1
%>
        <select name="boardid" size="1">
          <option value="0">��̳��ҳ</option>
          <%
	do while not rs.eof
        response.write "<option value='"+CStr(rs("BoardID"))+"'>"+rs("Boardtype")+"</option>"+chr(13)+chr(10)
	rs.movenext
	loop
	rs.close
%>
        </select>
        <%else%>
        <%
	sql="select boardtype from board where boardid="&boardid
	rs.open sql,conn,1,1
	boardtype=rs("boardtype")
%>
        <select name="boardid" size="1">
          <option value="<%=boardid%>"><%=boardtype%></option>
        </select>
        <%end if%>
      </td>
    </tr>
    <tr> 
      <td width="20%" valign=top> 
        <div align="center"><font color="<%=TableContentColor%>">�����ˣ� </font></div>
      </td>
      <td width="80%">
        <input type=text name=username size=36 value="<%=membername%>" disabled>
        <input type=hidden name=username value="<%=membername%>">
      </td>
    </tr>
    <tr> 
      <td width="20%" valign=top> 
        <div align="center"><font color="<%=TableContentColor%>">���⣺ </font></div>
      </td>
      <td width="80%">
        <input type=text name=title size=36>
      </td>
    </tr>
    <tr> 
      <td width="20%" valign=top> 
        <div align="center"><font color="<%=TableContentColor%>">���ݣ� </font></div>
      </td>
      <td width="80%">
        <textarea cols=35 rows=6 name="content"></textarea>
      </td>
    </tr>
    <tr>
      <td width="100%" valign=top colspan="2" align=center> 
        <input type=Submit value="�� ��" name=Submit">
        &nbsp; 
        <input type="reset" name="Clear" value="�� ��">
      </td>
    </tr>
  </table>
</form>
<%
end sub

sub savenews()
	dim username,title,content
	if request("boardid")<>"" then
		boardid=request("boardid")
	else
		Errmsg=Errmsg+"<br>"+"<li>�������˴���Ĳ�����"
		founderr=true
	end if
	if request("username")="" then
		Errmsg=Errmsg+"<br>"+"<li>�����뷢���ߡ�"
		founderr=true
	else
		username=request("username")
	end if
	if request("title")="" then
		Errmsg=Errmsg+"<br>"+"<li>�����빫����⡣"
		founderr=true
	else
		title=request("title")
	end if
	if request("content")="" then
		Errmsg=Errmsg+"<br>"+"<li>�����빫�����ݡ�"
		founderr=true
	else
		content=request("content")
	end if
	if founderr=true then
		call error()
	else
		sql="select * from bbsnews"
		rs.open sql,conn,1,3
		rs.addnew
		rs("username")=username
		rs("title")=title
		rs("content")=content
		rs("addtime")=Now()
		rs("boardid")=boardid
		rs.update
		rs.close
		call success()
	end if
end sub

sub manage()
	if master=false then
	exit sub
	end if
	sql="select * from bbsnews"
	rs.open sql,conn,1,1
%>
      		<table cellpadding=0 cellspacing=0 border=0 width=100% align=center>
		  <tr><td width="80%" valign=top height=22>
<font color="<%=TableContentColor%>">����</font>
		  </td>
		  <td width="20%">
<font color="<%=TableContentColor%>">����</font>
		  </td></tr>
<%do while not rs.eof%>
		  <tr><td width="80%" valign=top height=22><a href=admin_boardaset.asp?action=edit&id=<%=rs("id")%>&boardid=<%=rs("boardid")%>><font color="<%=TableContentColor%>"><%=rs("title")%></font></a>
		  </td>
		  <td width="20%"><a href=admin_boardaset.asp?action=del&id=<%=rs("id")%>&boardid=<%=boardid%>><font color="<%=TableContentColor%>">ɾ��</font></a>
		  </td></tr>
<%
	rs.movenext
	loop
	rs.close
%></table>
<%
end sub

sub edit()
%>
<form action="admin_boardaset.asp?action=updat&id=<%=request("id")%>" method=post>
      		<table cellpadding=0 cellspacing=0 border=0 width=100% align=center>
		  <tr><td width="20%" valign=top>
<font color="<%=TableContentColor%>">�������棺</font>
		  </td>
		  <td width="80%">
<%
	dim sel
   	sql="select boardid,boardtype from board"
   	rs.open sql,conn,1,1
%>
<select name="boardid" size="1">
<option value="0" <%if request("boardid")=0 then%>selected<%end if%>>��̳��ҳ</option>
<%
	do while not rs.eof
	if Cint(request("boardid"))=Cint(rs("boardid")) then
	sel="selected"
	else
	sel=""
	end if
        response.write "<option value='"+CStr(rs("BoardID"))+"' "&sel&">"+rs("Boardtype")+"</option>"+chr(13)+chr(10)
	rs.movenext
	loop
	rs.close
%>        
          </select>
		  </td></tr>
<%
	sql="select * from bbsnews where id="&cstr(request("id"))
	rs.open sql,conn,1,1
%>
		  <tr><td width="20%" valign=top>
<font color="<%=TableContentColor%>">�����ˣ�</font>
		  </td>
		  <td width="80%"><input type=text name=username size=36 value=<%=rs("username")%>></td></tr>
		  <tr><td width="20%" valign=top>
<font color="<%=TableContentColor%>">���⣺</font>
		  </td>
		  <td width="80%"><input type=text name=title size=36 value=<%=rs("title")%>></td></tr>
		  <tr><td width="20%" valign=top>
<font color="<%=TableContentColor%>">���ݣ�</font>
		  </td>
		  <td width="80%"><textarea cols=35 rows=6 name="content">
<%
	    content=replace(rs("content"),"<br>",chr(13))
            content=replace(content,"&nbsp;"," ")
            response.write ""&content&""
	    rs.close
%>
		  </textarea></td>
		  </tr>
		  <tr><td width="100%" valign=top colspan="2" align=center>
<input type=Submit value="�� ��" name=Submit"> &nbsp; <input type="reset" name="Clear" value="�� ��">
		  </td></tr>
		</table>
</form>
<%
end sub

sub update()
	dim username,title,content
	if request("boardid")<>"" then
		boardid=request("boardid")
	else
		exit sub
	end if
	if request("username")="" then
		Errmsg=Errmsg+"<br>"+"<li>�����뷢���ߡ�"
		founderr=true
	else
		username=request("username")
	end if
	if request("title")="" then
		Errmsg=Errmsg+"<br>"+"<li>�����빫����⡣"
		founderr=true
	else
		title=request("title")
	end if
	if request("content")="" then
		Errmsg=Errmsg+"<br>"+"<li>�����빫�����ݡ�"
		founderr=true
	else
		content=request("content")
	end if
	if founderr=true then
		call error()
	else
		sql="select * from bbsnews where id="&cstr(request("id"))
		rs.open sql,conn,1,3
		rs("username")=username
		rs("title")=title
		rs("content")=content
		rs("addtime")=Now()
		rs("boardid")=boardid
		rs.update
		rs.close
		call success()
	end if
end sub

sub del()
	sql="delete from bbsnews where id="&cstr(request("id"))
	conn.execute(sql)
	call success()
end sub

sub success()
%><br><br>
�ɹ����������
<%
end sub

sub editbminfo()
dim master_1
dim rs_c
if bmflag_1=0 then
Errmsg=Errmsg+"<br>"+"<li>�������������δ���š�"
call error()
exit sub
end if
%>
 <form action ="admin_boardaset.asp?action=saveditbm&boardid=<%=boardid%>" method=post>           
<%
set rs_c= server.CreateObject ("adodb.recordset")
sql = "select * from class"
rs_c.open sql,conn,1,1
set rs= server.CreateObject ("adodb.recordset")
sql = "select * from board where boardid="+CSTr(boardid)
rs.open sql,conn,1,1
if rs.eof and rs.bof then
Errmsg=Errmsg+"<br>"+"<li>��û��ָ����Ӧ��̳ID�����ܽ��й���"
call error()
exit sub
end if
master_1=split(rs("boardmaster"),"|")
if membername<>master_1(0) then
Errmsg=Errmsg+"<br>"+"<li>�����Ϊ������ר�á�"
call error()
exit sub
end if
%>            
<input type='hidden' name=editid value='<%=boardid%>'>
            
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr bgcolor=<%=aTableTitleColor%>> 
      <td width="52%" height=22><font color="<%=TableContentColor%>"><b>�ֶ����ƣ�</b></font> </td>
      <td width="48%"> 
        <div align="center"><font color="<%=TableContentColor%>"><b>����ֵ��</b></font></div>
      </td>
    </tr>
    <tr> 
      <td width="52%"><font color="<%=TableContentColor%>">��̳��ţ�ע�ⲻ�ܺͱ����̳�����ͬ��</font></td>
      <td width="48%"> <font color="<%=TableContentColor%>"><%=rs("boardid")%> </font></td>
    </tr>
    <tr> 
      <td width="52%"><font color="<%=TableContentColor%>">��̳��</font></td>
      <td width="48%"> <font color="<%=TableContentColor%>"><%=rs("boardtype")%></font> </td>
    </tr>
    <tr> 
      <td width="52%"><font color="<%=TableContentColor%>">����˵��</font></td>
      <td width="48%"> 
        <input type="text" name="readme" size="24" value='<%=rs("readme")%>'>
      </td>
    </tr>
    <tr> 
      <td width="52%"><font color="<%=TableContentColor%>">����(������������|�ָ����磺ɳ̲С��|wodeail)��</font></td>
      <td width="48%"> 
        <input type="text" name="boardmaster" size="24"  value='<%=rs("boardmaster")%>'>
      </td>
    </tr>
    <tr bgcolor=<%=aTableTitleColor%>> 
      <td width="52%">&nbsp;</td>
      <td width="48%"> 
        <input type="submit" name="Submit" value="�ύ">
      </td>
    </tr>
  </table>
</form>
<%
rs.close
end sub

sub savebminfo()
	sql = "select * from board where boardid="+Cstr(request("boardid"))
	rs.Open sql,conn,1,3
if rs.eof and rs.bof then
Errmsg=Errmsg+"<br>"+"<li>��û��ָ����Ӧ��̳ID�����ܽ��й���"
call error()
exit sub
end if
	rs("boardmaster") = Request("boardmaster")
	rs("readme") = Request("readme")
	rs.Update 
	rs.Close 
	response.write "<p>��̳�޸ĳɹ���"
end sub

sub editbmset()
dim chkedit
dim master_1
chkedit=false
set rs=conn.execute("select boardmaster from board where boardid="&request("boardid"))
if rs.eof and rs.bof then
Errmsg=Errmsg+"<br>"+"<li>��û��ָ����Ӧ��̳ID�����ܽ��й���"
call error()
exit sub
end if
master_1=split(rs(0),"|")
if bmflag_5=1 then
chkedit=true
else
if bmflag_3=0 then
chkedit=false
elseif bmflag_3=1 and membername=master_1(0) then
chkedit=true
else
chkedit=false
end if
end if
if master then
chkedit=true
end if
if chkedit=false then
	Errmsg=Errmsg+"<br>"+"<li>�����δ�������š�"
	call error()
else
%>
<form method="POST" action=admin_boardaset.asp?action=savebmset&boardid=<%=request("boardid")%>>
<table width="95%" border="0" cellspacing="1" cellpadding="3"  align=center bordercolor=<%=aTablebackcolor%>>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td height="23" colspan="2" ><font color="<%=TableContentColor%>"><b>��̳ʹ������</b></font></td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>�����ϴ�ͼƬ</B><BR>��������ͼƬ���ϴ��������̳�Ѿ����ã��Է���̳Ϊ׼</font></td>
<td width="60%"> <font color="<%=TableContentColor%>">
<input type=radio name="Uploadpic" value=0 <%if cint(Uploadpic)=0 then%>checked<%end if%>>�ر�&nbsp;
<input type=radio name="Uploadpic" value=1 <%if cint(Uploadpic)=1 then%>checked<%end if%>>��&nbsp;</font>
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>�û�IP</B><BR>��ѡ��԰����͹���Ա��Ч</font></td>
<td width="60%"> <font color="<%=TableContentColor%>">
<input type=radio name="IpFlag" value=0 <%if cint(IpFlag)=0 then%>checked<%end if%>>����&nbsp;
<input type=radio name="IpFlag" value=1 <%if cint(IpFlag)=1 then%>checked<%end if%>>����&nbsp;</font>
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>�û���Դ</B><BR>��ѡ��԰����͹���Ա��Ч<BR>Ϊ��ʡ��Դ����ر�</font></td>
<td width="60%"> <font color="<%=TableContentColor%>">
<input type=radio name="FromFlag" value=0 <%if cint(FromFlag)=0 then%>checked<%end if%>>����&nbsp;
<input type=radio name="FromFlag" value=1 <%if cint(FromFlag)=1 then%>checked<%end if%>>����&nbsp;</font>
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>���������̳</B><BR>�������Ƿ�������������̳</font></td>
<td width="60%"> <font color="<%=TableContentColor%>">
<input type=radio name="guestlogin" value=0 <%if cint(guestlogin)=0 then%>checked<%end if%>>����&nbsp;
<input type=radio name="guestlogin" value=1 <%if cint(guestlogin)=1 then%>checked<%end if%>>������&nbsp;</font>
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>����������ʾ��������</B><BR>Ϊ��ʡ��Դ����ر�</font></td>
<td width="60%"> <font color="<%=TableContentColor%>">
<input type=radio name="online_g" value=0 <%if cint(online_g)=0 then%>checked<%end if%>>�ر�&nbsp;
<input type=radio name="online_g" value=1 <%if cint(online_g)=1 then%>checked<%end if%>>��&nbsp;</font>
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>����������ʾ�û�����</B><BR>Ϊ��ʡ��Դ����ر�</font></td>
<td width="60%"> <font color="<%=TableContentColor%>">
<input type=radio name="online_u" value=0 <%if cint(online_u)=0 then%>checked<%end if%>>�ر�&nbsp;
<input type=radio name="online_u" value=1 <%if cint(online_u)=1 then%>checked<%end if%>>��&nbsp;</font>
</td>
</tr>
<tr> 
<td height="17" width="40%"><font color="<%=TableContentColor%>"><B>�������������ֽ���</B><BR>����������</font></td>
<td height="17" width="60%"> <font color="<%=TableContentColor%>">
<input type="text" name="AnnounceMaxBytes" size="6" value="<%=AnnounceMaxBytes%>">&nbsp;�ֽ�</font>
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>ÿҳ��ʾ����¼</B><BR>������̳���кͷ�ҳ�йص���Ŀ</font></td>
<td width="60%"> <font color="<%=TableContentColor%>">
<input type="text" name="MaxAnnouncePerPage" size="3" value="<%=MaxAnnouncePerPage%>">&nbsp;��</font>
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>�������ÿҳ��ʾ������</B></font></td>
<td width="60%"> <font color="<%=TableContentColor%>">
<input type="text" name="Maxtitlelist" size="3" value="<%=Maxtitlelist%>">&nbsp;��</font>
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>����ģʽ</B><BR>�߼�ģʽΪ��ʾ������Ŀ</font></td>
<td width="60%"> <font color="<%=TableContentColor%>">
<input type=radio name="TopicFlag" value=0 <%if cint(TopicFlag)=0 then%>checked<%end if%>>��ͨ&nbsp;
<input type=radio name="TopicFlag" value=1 <%if cint(TopicFlag)=1 then%>checked<%end if%>>�߼�&nbsp;</font>
</td>
</tr>

<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>�Ƿ���ʾҳ��ִ��ʱ��</B></font></td>
<td width="60%"> <font color="<%=TableContentColor%>">
<input type=radio name="runtime" value=0 <%if cint(runtime)=0 then%>checked<%end if%>>��&nbsp;
<input type=radio name="runtime" value=1 <%if cint(runtime)=1 then%>checked<%end if%>>��&nbsp;</font>
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>�ϴ��ļ�����</B><BR>ʹ�ö��Ÿ���</font></td>
<td width="60%"> 
<input type="text" name="Forum_upload" size="35" value="<%=Forum_upload%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>�ϴ��ļ���С</B><BR>����д����</font></td>
<td width="60%"> 
<input type="text" name="uploadsize" size="6" value="<%=uploadsize%>">
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>�Ƿ���UBB����</B></font></td>
<td width="60%"> <font color="<%=TableContentColor%>">
<input type=radio name="strAllowForumCode" value=0 <%if cint(strAllowForumCode)=0 then%>checked<%end if%>>�ر�&nbsp;
<input type=radio name="strAllowForumCode" value=1 <%if cint(strAllowForumCode)=1 then%>checked<%end if%>>��&nbsp;</font>
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>�Ƿ���HTML����</B></font></td>
<td width="60%"> <font color="<%=TableContentColor%>">
<input type=radio name="strAllowHTML" value=0 <%if cint(strAllowHTML)=0 then%>checked<%end if%>>�ر�&nbsp;
<input type=radio name="strAllowHTML" value=1 <%if cint(strAllowHTML)=1 then%>checked<%end if%>>��&nbsp;</font>
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>�Ƿ�����ͼ��ǩ</B></font></td>
<td width="60%"> <font color="<%=TableContentColor%>">
<input type=radio name="strIMGInPosts" value=0 <%if cint(strIMGInPosts)=0 then%>checked<%end if%>>�ر�&nbsp;
<input type=radio name="strIMGInPosts" value=1 <%if cint(strIMGInPosts)=1 then%>checked<%end if%>>��&nbsp;</font>
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>�Ƿ��������ǩ</B></font></td>
<td width="60%"> <font color="<%=TableContentColor%>">
<input type=radio name="strIcons" value=0 <%if cint(strIcons)=0 then%>checked<%end if%>>�ر�&nbsp;
<input type=radio name="strIcons" value=1 <%if cint(strIcons)=1 then%>checked<%end if%>>��&nbsp;</font>
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>�Ƿ���Flash��ǩ</B></font></td>
<td width="60%"> <font color="<%=TableContentColor%>">
<input type=radio name="strflash" value=0 <%if cint(strflash)=0 then%>checked<%end if%>>�ر�&nbsp;
<input type=radio name="strflash" value=1 <%if cint(strflash)=1 then%>checked<%end if%>>��&nbsp;</font>
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>������ɫ����</B></font></td>
<td width="60%"> <font color="<%=TableContentColor%>">
<input type=radio name="viewcolor" value=0 <%if cint(viewcolor)=0 then%>checked<%end if%>>�ر�&nbsp;
<input type=radio name="viewcolor" value=1 <%if cint(viewcolor)=1 then%>checked<%end if%>>��&nbsp;</font>
</td>
</tr>
<tr> 
<td width="40%"><font color="<%=TableContentColor%>"><B>�Ƿ�����δ��½�û�����</B></font></td>
<td width="60%"> 
<input type=radio name="Search_G" value=0 <%if cint(Search_G)=0 then%>checked<%end if%>>����&nbsp;
<input type=radio name="Search_G" value=1 <%if cint(Search_G)=1 then%>checked<%end if%>>������&nbsp;
</td>
</tr>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td width="40%">&nbsp;</td>
<td width="60%"> 
<div align="center"> 
<input type="submit" name="Submit" value="�� ��">
</div>
</td>
</tr>
</table>
</form>
<%
end if
end sub
sub savebmset()
dim chkedit
dim master_1
chkedit=false
set rs=conn.execute("select boardmaster from board where boardid="&request("boardid"))
if rs.eof and rs.bof then
Errmsg=Errmsg+"<br>"+"<li>��û��ָ����Ӧ��̳ID�����ܽ��й���"
call error()
exit sub
end if
master_1=split(rs(0),"|")
if bmflag_5=1 then
chkedit=true
else
if bmflag_3=0 then
chkedit=false
elseif bmflag_3=1 and membername=master_1(0) then
chkedit=true
else
chkedit=false
end if
end if
if master then
chkedit=true
end if
dim Forum_setting
if chkedit=false then
	Errmsg=Errmsg+"<br>"+"<li>�����δ�������š�"
	call error()
else
Forum_Setting=TimeAdjust & "," & ScriptTimeOut & "," & EmailFlag & "," & request("Uploadpic") & "," & request("IpFlag") & "," & request("FromFlag") & "," & TitleFlag & "," & uploadFlag & "," & kicktime & "," & request("guestlogin") & "," & openmsg & "," & request("MaxAnnouncePerPage") & "," & request("Maxtitlelist") & "," & request("AnnounceMaxBytes") & "," & request("online_u") & "," & request("online_g") & "," & LinkFlag & "," & request("TopicFlag") & "," & request("VoteFlag") & "," & request("ReflashFlag") & "," & request("ReflashTime") & "," & ForumStop & "," & RegTime & "," & EmailReg & "," & EmailRegOne & "," & RegFlag & "," & online_n & "," & ViewUser_g & "," & ViewUser_u & "," & BirthFlag & "," & request("runtime") & "," & FastLogin & "," & GroupFlag & "," & request("uploadsize") & "," & request("strAllowForumCode") & "," & request("strAllowHTML") & "," & request("strIMGInPosts") & "," & request("strIcons") & "," & request("strflash") & "," & request("vote_num") & "," & facenum & "," & imgnum & "," & request("relaypost") & "," & request("relayposttime") & "," & facename & "," & imgname & "," & smsflag & "," & SendRegEmail & "," & request("Search_G") & "," & bmflag_1 & "," & bmflag_2 & "," & bmflag_3 & "," & bmflag_4 & "," & bmflag_5 & "," & RegFaceNum & "," & request("viewcolor") & "," & SmallPaper & "," & SmallPaper_g & "," & SmallPaper_m & "," & FontSize & "," & FontHeight & "," & BbsUserInfo & "," & DvbbsSkin & "," & SkinFontNum & "," & UpLoadPath & "," & UserubbCode & "," & UserHtmlCode & "," & UserImgCode & "," & TopUserNum & "," & PostRetrun & "," & UserPostAdmin & "," & bbsEven & "," & bbsEvenView
'response.write forum_setting
'response.end
sql="update board set Forum_Setting='"&Forum_Setting&"',Forum_upload='"&request("Forum_upload")&"' where boardid="&request("boardid")
conn.execute(sql)
response.write "���óɹ���"
end if
end sub

sub editbmcolor()
dim master_1,chkedit
set rs=conn.execute("select boardmaster from board where boardid="&request("boardid"))
if rs.eof and rs.bof then
Errmsg=Errmsg+"<br>"+"<li>��û��ָ����Ӧ��̳ID�����ܽ��й���"
call error()
exit sub
end if
master_1=split(rs(0),"|")
if bmflag_5=1 then
chkedit=true
else
if bmflag_3=0 then
chkedit=false
elseif bmflag_3=1 and membername=master_1(0) then
chkedit=true
else
chkedit=false
end if
end if
if master then
chkedit=true
end if
if chkedit=false then
	Errmsg=Errmsg+"<br>"+"<li>�����δ�������š�"
	call error()
else
%>
<form method="POST" action="?action=savebmcolor&boardid=<%=request("boardid")%>">
<table width="95%" border="0" cellspacing="1" cellpadding="3"  align=center bordercolor=<%=aTablebackcolor%>>
<script>
function color(para_URL){var URL =new String(para_URL)
window.open(URL,'','width=300,height=220,noscrollbars')}
</SCRIPT>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td height="23" colspan="3" ><font color="<%=TableContentColor%>"><b>��̳��������</b></font>&nbsp;���� <a href="javascript:color('color.asp')"><font color="<%=TableContentColor%>">����</font></a> ʹ��������ɫʰȡ��</td>
</tr>
<tr> 
<td width="45%"><font color="<%=TableContentColor%>"><B>��̳BODY��ǩ</B><br>
����������̳���ı�����ɫ���߱���ͼƬ��</font></td>
<td width="5%"></td>
<td width="50%"> 
<input type="text" name="ForumBody" size="35" value="<%=ForumBody%>">
</td>
</tr>
<tr bgcolor="<%=Tablebodycolor%>"> 
<td width="45%"><font color="<%=TableContentColor%>"><B>������߿���ɫ</B></font></td>
<td width="5%" bgcolor="<%=IEbarcolor%>"></td>
<td width="50%"> 
<input type="text" name="iebarcolor" size="35" value="<%=iebarcolor%>">
</td>
</tr>
<tr bgcolor="<%=Tablebodycolor%>"> 
<td width="45%"><font color="<%=TableContentColor%>"><B>�����˵���񱳾�(���)</B></font></td>
<td width="5%" bgcolor="<%=NavDarkcolor%>"></td>
<td width="50%"> 
<input type="text" name="NavDarkcolor" size="35" value="<%=NavDarkcolor%>">
</td>
</tr>
<tr bgcolor="<%=Tablebodycolor%>"> 
<td width="45%"><font color="<%=TableContentColor%>"><B>�����˵���񱳾�(ǳ����)</B></font></td>
<td width="5%" bgcolor="<%=Navlighcolor%>"></td>
<td width="50%"> 
<input type="text" name="Navlighcolor" size="35" value="<%=Navlighcolor%>">
</td>
</tr>
<tr> 
<td width="45%"><font color="<%=TableContentColor%>"><B>���߿���ɫһ</B><br>
һ��ҳ��</font></td>
<td width="5%" bgcolor="<%=Tablebackcolor%>"></td>
<td width="50%"> 
<input type="text" name="Tablebackcolor" size="35" value="<%=Tablebackcolor%>">
</td>
</tr>
<tr> 
<td width="45%"><font color="<%=TableContentColor%>"><B>���߿���ɫ��</B><br>
�û�ҳ�桢��ʾҳ��</font></td>
<td width="5%" bgcolor="<%=aTablebackcolor%>"></td>
<td width="50%"> 
<input type="text" name="aTablebackcolor" size="35" value="<%=aTablebackcolor%>">
</td>
</tr>
<tr> 
<td width="45%"><font color="<%=TableContentColor%>"><B>��������ɫһ�������</B><br>
һ��ҳ��</font></td>
<td width="5%" bgcolor="<%=Tabletitlecolor%>"></td>
<td width="50%"> 
<input type="text" name="Tabletitlecolor" size="35" value="<%=Tabletitlecolor%>">
</td>
</tr>
<tr> 
<td width="45%"><font color="<%=TableContentColor%>"><B>��������ɫ����ǳ������</B><br>
�û�ҳ�桢��ʾҳ��</font></td>
<td width="5%" bgcolor="<%=aTabletitlecolor%>"></td>
<td width="50%"> 
<input type="text" name="aTabletitlecolor" size="35" value="<%=aTabletitlecolor%>">
</td>
</tr>
<tr> 
<td width="45%"><font color="<%=TableContentColor%>"><B>�������ɫһ</B></font></td>
<td width="5%" bgcolor="<%=Tablebodycolor%>"></td>
<td width="50%"> 
<input type="text" name="Tablebodycolor" size="35" value="<%=Tablebodycolor%>">
</td>
</tr>
<tr> 
<td width="45%"><font color="<%=TableContentColor%>"><B>�������ɫ��</B>(1��2��ɫ����ҳ��ʾ�д���)</font></td>
<td width="5%" bgcolor="<%=aTablebodycolor%>"></td>
<td width="50%"> 
<input type="text" name="aTablebodycolor" size="35" value="<%=aTablebodycolor%>">
</td>
</tr>
<tr> 
<td width="45%"><font color="<%=TableContentColor%>"><B>��������������ɫ</B></font></td>
<td width="5%" bgcolor="<%=TableFontcolor%>"></td>
<td width="50%"> 
<input type="text" name="TableFontcolor" size="35" value="<%=TableFontcolor%>">
</td>
</tr>
<tr> 
<td width="45%"><font color="<%=TableContentColor%>"><B>���������������ɫ</B></font></td>
<td width="5%" bgcolor="<%=TableContentcolor%>"></td>
<td width="50%"> 
<input type="text" name="TableContentcolor" size="35" value="<%=TableContentcolor%>">
</td>
</tr>
<tr> 
<td width="45%"><font color="<%=TableContentColor%>"><B>��������������ɫ</B></font></td>
<td width="5%" bgcolor="<%=AlertFontColor%>"></td>
<td width="50%"> 
<input type="text" name="AlertFontColor" size="35" value="<%=AlertFontColor%>">
</td>
</tr>
<tr> 
<td width="45%"><font color="<%=TableContentColor%>"><B>��ʾ���ӵ�ʱ��������ӣ�ת�����ӣ��ظ��ȵ���ɫ</B></font></td>
<td width="5%" bgcolor="<%=ContentTitle%>"></td>
<td width="50%"> 
<input type="text" name="ContentTitle" size="35" value="<%=ContentTitle%>">
</td>
</tr>
<tr> 
<td width="45%"><font color="<%=TableContentColor%>"><B>��ҳ������ɫ������⣩</B></font></td>
<td width="5%" bgcolor="<%=BodyFontColor%>"></td>
<td width="50%"> 
<input type="text" name="BodyFontColor" size="35" value="<%=BodyFontColor%>">
</td>
</tr>
<tr> 
<td width="45%"><font color="<%=TableContentColor%>"><B>��ҳ������ɫ</B><BR>���������</font></td>
<td width="5%" bgcolor="<%=BoardLinkColor%>"></td>
<td width="50%"> 
<input type="text" name="BoardLinkColor" size="35" value="<%=BoardLinkColor%>">
</td>
</tr>
<tr> 
<td width="45%"><font color="<%=TableContentColor%>"><B>�����</B></font></td>
<td width="5%"></td>
<td width="50%"> 
<input type="text" name="tablewidth" size="35" value="<%=tablewidth%>">
</td>
</tr>
<tr> 
<td width="45%"><font color="<%=TableContentColor%>"><B>һ���û�����������ɫ</B></font></td>
<td width="5%" bgcolor="<%=user_fc%>"></td>
<td width="50%"> 
<input type="text" name="user_fc" size="35" value="<%=user_fc%>">
</td>
</tr>
<tr> 
<td width="45%"><font color="<%=TableContentColor%>"><B>һ���û������ϵĹ�����ɫ</B></font></td>
<td width="5%" bgcolor="<%=user_mc%>"></td>
<td width="50%"> 
<input type="text" name="user_mc" size="35" value="<%=user_mc%>">
</td>
</tr>
<tr> 
<td width="45%"><font color="<%=TableContentColor%>"><B>��������������ɫ</B></font></td>
<td width="5%" bgcolor="<%=bmaster_fc%>"></td>
<td width="50%"> 
<input type="text" name="bmaster_fc" size="35" value="<%=bmaster_fc%>">
</td>
</tr>
<tr> 
<td width="45%"><font color="<%=TableContentColor%>"><B>���������ϵĹ�����ɫ</B></font></td>
<td width="5%" bgcolor="<%=bmaster_mc%>"></td>
<td width="50%"> 
<input type="text" name="bmaster_mc" size="35" value="<%=bmaster_mc%>">
</td>
</tr>
<tr> 
<td width="45%"><font color="<%=TableContentColor%>"><B>����Ա����������ɫ</B></font></td>
<td width="5%" bgcolor="<%=master_fc%>"></td>
<td width="50%"> 
<input type="text" name="master_fc" size="35" value="<%=master_fc%>">
</td>
</tr>
<tr> 
<td width="45%"><font color="<%=TableContentColor%>"><B>���������ϵĹ�����ɫ</B></font></td>
<td width="5%" bgcolor="<%=master_mc%>"></td>
<td width="50%"> 
<input type="text" name="master_mc" size="35" value="<%=master_mc%>">
</td>
</tr>
<tr> 
<td width="45%"><font color="<%=TableContentColor%>"><B>�������������ɫ</B></font></td>
<td width="5%" bgcolor="<%=vip_fc%>"></td>
<td width="50%"> 
<input type="text" name="vip_fc" size="35" value="<%=vip_fc%>">
</td>
</tr>
<tr> 
<td width="45%"><font color="<%=TableContentColor%>"><B>��������ϵĹ�����ɫ</B></font></td>
<td width="5%" bgcolor="<%=vip_mc%>"></td>
<td width="50%"> 
<input type="text" name="vip_mc" size="35" value="<%=vip_mc%>">
</td>
</tr>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td width="45%">&nbsp;</td>
<td width="5%"></td>
<td width="50%"> 
<div align="center"> 
<input type="submit" name="Submit" value="�� ��">
</div>
</td>
</tr>
</table>
</form>
<%
end if
end sub
sub savebmcolor()
dim Forum_body,master_1
dim chkedit
set rs=conn.execute("select boardmaster from board where boardid="&request("boardid"))
if rs.eof and rs.bof then
Errmsg=Errmsg+"<br>"+"<li>��û��ָ����Ӧ��̳ID�����ܽ��й���"
call error()
exit sub
end if
master_1=split(rs(0),"|")
if bmflag_5=1 then
chkedit=true
else
if bmflag_3=0 then
chkedit=false
elseif bmflag_3=1 and membername=master_1(0) then
chkedit=true
else
chkedit=false
end if
end if
if master then
chkedit=true
end if
if chkedit=false then
	Errmsg=Errmsg+"<br>"+"<li>�����δ�������š�"
	call error()
else
Forum_body=request("Tablebackcolor") & "," & request("aTablebackcolor") & "," & request("Tabletitlecolor") & "," & request("aTabletitlecolor") & "," & request("Tablebodycolor") & "," & request("aTablebodycolor") & "," & request("TableFontcolor") & "," & request("TableContentcolor") & "," & request("AlertFontColor") & "," & request("ContentTitle") & "," & request("AlertFontColor") & "," & request("ForumBody") & "," & request("TableWidth") & "," & request("BodyFontColor") & "," & request("BoardLinkColor") & "," & request("user_fc") & "," & request("user_mc") & "," & request("bmaster_fc") & "," & request("bmaster_mc") & "," & request("master_fc") & "," & request("master_mc") & "," & request("vip_fc") & "," & request("vip_mc") & "," & NavLighColor & "," & NavDarkColor & "," & IEbarColor
'response.write Forum_body
'response.end
sql = "update board set Forum_body='"&Forum_body&"' where boardid="&request("boardid")
conn.execute(sql)
response.write "���óɹ���"
end if
end sub
%>
<!--#include file=footer.asp-->
