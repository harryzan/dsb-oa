<!--#include file =conn.asp-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=chkuser.asp-->
<title><%=ForumName%>--����ҳ��</title>
<!--#include file="Forum_css.asp"-->
<meta NAME=GENERATOR Content=""Microsoft FrontPage 3.0"" CHARSET=GB2312>
<BODY  <%=ForumBody%>>
<%
	if not master or instr(session("flag"),"32")=0 then
		Errmsg=Errmsg+"<br>"+"<li>��ҳ��Ϊ����Աר�ã���<a href=admin_index.asp target=_top>��½</a>����롣<br><li>��û�й���ҳ���Ȩ�ޡ�"
		call Error()
	else
		dim dbpath
		dim bkfolder
		dim bkdbname
		dim fso
		dim folderpath,fso1,f
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
        <td align=center colspan="2"><font color="<%=TableFontColor%>">��ӭ<b><%=membername%></b>�������ҳ��</font>
        </td>
        </tr>
            <tr bgcolor=<%=tablebodycolor%>>
              <td width="100%" valign=top><font color="<%=TableContentColor%>">
<%
	if request("action")="Backup" then
	call backupdata()
	else
%>
		 		<table width=100% cellspacing=0 cellpadding=0 bgcolor='<%=atablebackcolor%>'>		  							  				
  				<tr bgcolor=<%=tablebodycolor%>>
  					<td height=25 ><font color="<%=TableContentColor%>">
  					&nbsp;&nbsp;<B>������̳����</B>( ��ҪFSO֧�֣�FSO��ذ����뿴΢����վ )</font>
  					</td>
  				</tr>
  				<form method="post" action="ADMIN_BackupData.asp?action=Backup">
  				<tr bgcolor=<%=tablebodycolor%>>
  					<td height=100 ><font color="<%=TableContentColor%>">
  						&nbsp;&nbsp;
						��ǰ���ݿ�·��(���·��)��<input type=text size=15 name=DBpath value="<%=db%>"><BR>&nbsp;&nbsp;
						�������ݿ�Ŀ¼(���·��)��<input type=text size=15 name=bkfolder value=Databackup>&nbsp;��Ŀ¼�����ڣ������Զ�����<BR>&nbsp;&nbsp;
						�������ݿ�����(��д����)��<input type=text size=15 name=bkDBname value=ipromis.MDB>&nbsp;�籸��Ŀ¼�и��ļ��������ǣ���û�У����Զ�����<BR>
						&nbsp;&nbsp;<input type=submit value="ȷ��"><br>
  						-----------------------------------------------------------------------------------------<br>
                    &nbsp;&nbsp;��������д����������ݿ�·��ȫ�����������Ĭ�����ݿ��ļ�ΪData\esbpbbs.MDB<br>
  						&nbsp;&nbsp;������������������������ķ������ݣ��Ա�֤�������ݰ�ȫ��<br>
  						&nbsp;&nbsp;ע�⣺����·��������������ռ��Ŀ¼�����·��				</font>
  					</td>
  				</tr>	
  				</form>
  			</table>
<%end if%></font>
          </td>
            </tr>
        </table>
        </td>
    </tr>
</table>

<%
end sub

sub backupdata()
		Dbpath=request.form("Dbpath")
		Dbpath=server.mappath(Dbpath)
		bkfolder=request.form("bkfolder")
		bkdbname=request.form("bkdbname")
		Set Fso=server.createobject("scripting.filesystemobject")
		if fso.fileexists(dbpath) then
			If CheckDir(bkfolder) = True Then
			fso.copyfile dbpath,bkfolder& "\"& bkdbname
			else
			MakeNewsDir bkfolder
			fso.copyfile dbpath,bkfolder& "\"& bkdbname
			end if
			response.write "�������ݿ�ɹ��������ݵ����ݿ�·��Ϊ" &bkfolder& "\"& bkdbname
		Else
			response.write "�Ҳ���������Ҫ���ݵ��ļ���"
		End if
end sub
'------------------���ĳһĿ¼�Ƿ����-------------------
Function CheckDir(FolderPath)
	folderpath=Server.MapPath(".")&"\"&folderpath
    Set fso1 = CreateObject("Scripting.FileSystemObject")
    If fso1.FolderExists(FolderPath) then
       '����
       CheckDir = True
    Else
       '������
       CheckDir = False
    End if
    Set fso1 = nothing
End Function
'-------------����ָ����������Ŀ¼---------
Function MakeNewsDir(foldername)
    Set fso1 = CreateObject("Scripting.FileSystemObject")
        Set f = fso1.CreateFolder(foldername)
        MakeNewsDir = True
    Set fso1 = nothing
End Function
%>