<!--#include file=conn.asp-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=inc/grade.asp-->
<!--#include file=chkuser.asp-->
<title><%=ForumName%>--����ҳ��</title>
<!--#include file="Forum_css.asp"-->

<BODY <%=ForumBody%>>
<%
	if not master or instr(session("flag"),"12")=0 then
		Errmsg=Errmsg+"<br>"+"<li>��ҳ��Ϊ����Աר�ã���<a href=admin_index.asp target=_top>��½</a>����롣<br><li>��û�й���ҳ���Ȩ�ޡ�"
		call Error()
	else
		call main()
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
if request("action")="save" then
call savegrade()
else
call gradeinfo()
end if
%></font>
	      </td>
            </tr>
        </table>
        </td>
    </tr>
</table>
<%
end sub

sub gradeinfo()
%>
<form method="POST" action=admin_grade.asp?action=save>
<table width="95%" border="0" cellspacing="1" cellpadding="3"  align=center bordercolor=<%=aTablebackcolor%>>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td height="23" colspan="2" ><font color="<%=TableContentColor%>"><b>�û��ȼ��趨</b>���ȼ�18Ϊ������ȼ�19Ϊ�������ȼ�20Ϊ�ܰ�����������ֻ�趨��ʾ���ƺ�ͼƬ���������û��֡�ͼƬĿ¼pic���������ҪFSO֧�֣�FSO��ذ��������΢����վ��������վ��֧��FSO�����ֶ��޸�Pic���ͼƬ�ļ��Լ�inc/grade.asp�ļ���</font></td>
</tr>
<%for i=1 to 20%>
<tr> 
<td width="30%"><font color="<%=TableContentColor%>"><b>�ȼ�<B><%=i%></B>����</font></td>
<td width="70%"> 
<input type="text" name="level<%=i%>" size="35" value="<%=grade(i)%>">
</td>
</tr>
<tr> 
<td width="30%"><font color="<%=TableContentColor%>">������������</font></td>
<td width="70%"> 
<input type="text" name="point<%=i%>" size="35" value="<%=point(i)%>">
</td>
</tr>
<tr> 
<td width="30%"><font color="<%=TableContentColor%>">�ȼ�<B><%=i%></B>ͼƬ��ַ</font></td>
<td width="70%"> 
<input type="text" name="pic<%=i%>" size="35" value="<%=gradepic(i)%>">
<img src=<%=picurl%><%=gradepic(i)%>></td>
</tr>
<%next%>
<tr bgcolor=<%=aTabletitlecolor%>> 
<td width="30%">&nbsp;</td>
<td width="70%"> 
<div align="center"> 
<input type="submit" name="Submit" value="�� ��">
</div>
</td>
</tr>
</table>
</form>
<%
end sub'Created by shatan Jan 8
sub savegrade()
	Dim objFSO, objTextFile
	Set objFSO = CreateObject("Scripting.FileSystemObject")	
	Set objTextFile = objFSO.CreateTextFile(Server.MapPath("inc/grade.asp"),TRUE)
		
	objTextFile.WriteLine("<" & "%")
	objTextFile.WriteLine("function grade(level)")
	objTextFile.WriteLine("dim user_level")
	objTextFile.WriteLine("Select Case level")
	for i=1 to 20
	objTextFile.WriteLine("case "&i&"")
	objTextFile.WriteLine("	user_level="""&request("level"&i)&"""")
	next
	objTextFile.WriteLine("Case Else")
	objTextFile.WriteLine("user_level="""&request("level1")&"""")
	objTextFile.WriteLine("end Select")
	objTextFile.WriteLine("grade=user_level")
	objTextFile.WriteLine("end function")

	objTextFile.WriteLine("function point(p)")
	objTextFile.WriteLine("dim level_point")
	objTextFile.WriteLine("Select Case p")
	for i=1 to 17
	objTextFile.WriteLine("case "&i&"")
	objTextFile.WriteLine("	level_point="&request("point"&i)&"")
	next
	objTextFile.WriteLine("end Select")
	objTextFile.WriteLine("point=level_point")
	objTextFile.WriteLine("end function")

	objTextFile.WriteLine("function gradepic(pic)")
	objTextFile.WriteLine("dim level_pic")
	objTextFile.WriteLine("Select Case pic")
	for i=1 to 20
	objTextFile.WriteLine("case "&i&"")
	objTextFile.WriteLine("	level_pic="""&request("pic"&i)&"""")
	next
	objTextFile.WriteLine("end Select")
	objTextFile.WriteLine("gradepic=level_pic")
	objTextFile.WriteLine("end function")

	objTextFile.WriteLine("%" & ">")		
		
	objTextFile.Close
	Set objTextFile = Nothing
	Set objFSO = Nothing
%>
<center><p><b>���óɹ���</b>
<%
end sub
%>