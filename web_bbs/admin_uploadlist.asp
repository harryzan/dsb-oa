<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=chkuser.asp-->
<title><%=ForumName%>--����ҳ��</title>
<!--#include file="Forum_css.asp"-->

<BODY <%=ForumBody%>>
<%
	if not master or instr(session("flag"),"55")=0 then
		Errmsg=Errmsg+"<br>"+"<li>��ҳ��Ϊ����Աר�ã���<a href=admin_index.asp target=_top>��½</a>����롣<br><li>��û�й���ҳ���Ȩ�ޡ�"
		call Error()
	else
		call main()
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
              <td width="100%" valign=top><p>
              <table width="100%" border="0" cellspacing="3" cellpadding="0">
                <tr> 
                  <td bgcolor=<%=atabletitlecolor%>> <font color="<%=TableContentColor%>">
                    <p><b>����ϴ��ļ�</b>�������ܱ��������֧��FSOȨ�޷���ʹ�ã�FSOʹ�ð��������΢����վ���ļ�Ŀ¼Ϊuploadimages���������������֧��FSO���ֶ�����</p></font>
                  </td>
                </tr>
                <tr> 
                  <td>	<font color="<%=TableContentColor%>">
<%
'Created by shatan Jan 8
dim objFSO
dim uploadfolder
dim uploadfiles
dim upname
dim upfilename
Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
if request("filename")<>"" then
objFSO.DeleteFile(Server.MapPath("uploadimages\"&request("filename")))
end if
Set uploadFolder=objFSO.GetFolder(Server.MapPath("uploadimages\"))
Set uploadFiles=uploadFolder.Files
For Each Upname In uploadFiles
upfilename="uploadimages/"&upname.name
response.write "<a href="""&upfilename&""">"&upfilename&"</a> <a href='?filename="&upname.name&"'>ɾ��</a><br>"
next
set uploadFolder=nothing
set uploadFiles=nothing
%></font>
		</td>
            </tr>
        </table>
        </td>
    </tr>
</table>
<%
	end sub
%>