<!--#include file =conn.asp-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=chkuser.asp-->
<title><%=ForumName%>--����ҳ��</title>
<!--#include file="Forum_css.asp"-->
<meta NAME=GENERATOR Content=""Microsoft FrontPage 3.0"" CHARSET=GB2312>
<BODY <%=ForumBody%>>
<%
	if not master or instr(session("flag"),"33")=0 then
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
if request("action")="Restore" then
	dim dbpath,backpath,fso
	Dbpath=request.form("Dbpath")
	backpath=request.form("backpath")
	if dbpath="" then
	response.write "��������Ҫ�ָ��ɵ����ݿ�ȫ��"	
	else
	Dbpath=server.mappath(Dbpath)
	end if
	backpath=server.mappath(backpath)
	'Response.write Backpath
	Set Fso=server.createobject("scripting.filesystemobject")
	if fso.fileexists(dbpath) then  					
		fso.copyfile Dbpath,Backpath
		response.write "�ɹ��ָ����ݣ�"
	else
		response.write "����Ŀ¼�²������ı����ļ���"	
	end if
else
%>
		 			<table width=100% cellspacing=0 cellpadding=0 bgcolor='<%=atablebackcolor%>'>		  							  				
  				<tr bgcolor=<%=tablebodycolor%>>
  					<td height=25 ><font color="<%=TableContentColor%>">
   					&nbsp;&nbsp;<B>�ָ���̳����</B>( ��ҪFSO֧�֣�FSO��ذ����뿴΢����վ )</font>
  					</td>
  				</tr>
  				<form method="post" action="ADMIN_RestoreData.asp?action=Restore">
  				<tr bgcolor=<%=tablebodycolor%>>
  					<td height=100 ><font color="<%=TableContentColor%>">
  						&nbsp;&nbsp;�������ݿ�·��(���)��<input type=text size=30 name=DBpath value="DataBackup\ipromis.MDB">&nbsp;&nbsp;<BR>
  						&nbsp;&nbsp;Ŀ�����ݿ�·��(���)��<input type=text size=30 name=backpath value="<%=db%>"><BR>&nbsp;&nbsp;��д����ǰʹ�õ����ݿ�·�����粻�븲�ǵ�ǰ�ļ���������������ע��·���Ƿ���ȷ����Ȼ���޸�conn.asp�ļ������Ŀ���ļ����͵�ǰʹ�����ݿ���һ�µĻ��������޸�conn.asp�ļ�<BR>
						&nbsp;&nbsp;<input type=submit value="�ָ�����"> <br>
  						-----------------------------------------------------------------------------------------<br>
                    &nbsp;&nbsp;��������д����������ݿ�·��ȫ�����������Ĭ�ϱ������ݿ��ļ�ΪDataBackup\esbpbbs.MDB���밴�����ı����ļ������޸ġ�<br>
  						&nbsp;&nbsp;������������������������ķ������ݣ��Ա�֤�������ݰ�ȫ��<br>
  						&nbsp;&nbsp;ע�⣺����·��������������ռ��Ŀ¼�����·��</font>
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
%>
