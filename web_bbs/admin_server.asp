<!-- #include file="conn.asp" -->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=chkuser.asp-->
<title><%=ForumName%>--����ҳ��</title>
<!--#include file="Forum_css.asp"-->
<meta NAME=GENERATOR Content=""Microsoft FrontPage 3.0"" CHARSET=GB2312>
<BODY <%=ForumBody%>>
<%
	if not master or instr(session("flag"),"29")=0 then
		Errmsg=Errmsg+"<br>"+"<li>��ҳ��Ϊ����Աר�ã���<a href=admin_index.asp target=_top>��½</a>����롣<br><li>��û�й���ҳ���Ȩ�ޡ�"
		call Error()
	else

	Dim theInstalledObjects(14)
    theInstalledObjects(0) = "MSWC.AdRotator"
    theInstalledObjects(1) = "MSWC.BrowserType"
    theInstalledObjects(2) = "MSWC.NextLink"
    theInstalledObjects(3) = "MSWC.Tools"
    theInstalledObjects(4) = "MSWC.Status"
    theInstalledObjects(5) = "MSWC.Counters"
    theInstalledObjects(6) = "IISSample.ContentRotator"
    theInstalledObjects(7) = "IISSample.PageCounter"
    theInstalledObjects(8) = "MSWC.PermissionChecker"
    theInstalledObjects(9) = "Scripting.FileSystemObject"
    theInstalledObjects(10) = "adodb.connection"
    
    theInstalledObjects(11) = "SoftArtisans.FileUp"
    theInstalledObjects(12) = "SoftArtisans.FileManager"
    theInstalledObjects(13) = "LyfUpload.UploadFile"
    theInstalledObjects(14) = "Persits.Upload.1"

		call main()
	end if

	sub main()
%>
<table cellpadding=0 cellspacing=0 border=0 width=<%=tablewidth%> bgcolor=<%=tablebackcolor%> align=center>
  <tr>
    <td>
      <table cellpadding=3 cellspacing=1 border=0 width=100%>
        <tr bgcolor='<%=Tabletitlecolor%>'>
        <td align=center colspan="2"><font color="<%=TablefontColor%>">��ӭ<b><%=membername%></b>�������ҳ��</font>
        </td>
        </tr>
            <tr bgcolor=<%=tablebodycolor%>>
              <td width="100%" valign=top><font color="<%=TableContentColor%>"> <%call servervar()%></font></td>
            </tr>
        </table>
        </td>
    </tr>
</table>
<%
end sub

sub servervar()
%>
              
<table width="100%" border="0" cellspacing="3" cellpadding="0">
  <tr> 
    <td colspan="2" bgcolor=<%=atabletitlecolor%> height=20> <font color="<%=TableContentColor%>"><b>�������йصı���</b></font> 
    </td>
  </tr>
  <tr> 
    <td width="30%" valign=top><font color="<%=TableContentColor%>">��ʾ�ͻ�����������HTTP����</font></td>
    <td width="70%"><font color="<%=TableContentColor%>"><%=request.ServerVariables("All_Http")%></font></td>
  </tr>
  <tr> 
    <td width="30%" valign=top><font color="<%=TableContentColor%>">��ȡISAPIDLL��metabase·��</font></td>
    <td width="70%"><font color="<%=TableContentColor%>"><%=request.ServerVariables("APPL_MD_PATH")%></font></td>
  </tr>
  <tr> 
    <td width="30%" valign=top><font color="<%=TableContentColor%>">��ʾվ������·��</font></td>
    <td width="70%"><font color="<%=TableContentColor%>"><%=request.ServerVariables("APPL_PHYSICAL_PATH")%></font></td>
  </tr>
  <tr> 
    <td width="30%" valign=top><font color="<%=TableContentColor%>">·����Ϣ</font></td>
    <td width="70%"><font color="<%=TableContentColor%>"><%=request.ServerVariables("PATH_INFO")%></font></td>
  </tr>
  <tr> 
    <td width="30%" valign=top><font color="<%=TableContentColor%>">��ʾ�������IP��ַ</font></td>
    <td width="70%"><font color="<%=TableContentColor%>"><%=request.ServerVariables("REMOTE_ADDR")%></font></td>
  </tr>
  <tr> 
    <td width="30%" valign=top><font color="<%=TableContentColor%>">������IP��ַ</font></td>
    <td width="70%"><font color="<%=TableContentColor%>"><%=Request.ServerVariables("LOCAL_ADDR")%></font></td>
  </tr>
  <tr> 
    <td width="30%" valign=top><font color="<%=TableContentColor%>">��ʾִ��SCRIPT������·��</font></td>
    <td width="70%"><font color="<%=TableContentColor%>"><%=request.ServerVariables("SCRIPT_NAME")%></font></td>
  </tr>
  <tr> 
    <td width="30%" valign=top><font color="<%=TableContentColor%>">���ط���������������DNS��������IP��ַ</font></td>
    <td width="70%"><font color="<%=TableContentColor%>"><%=request.ServerVariables("SERVER_NAME")%></font></td>
  </tr>
  <tr> 
    <td width="30%" valign=top><font color="<%=TableContentColor%>">���ط�������������Ķ˿�</font></td>
    <td width="70%"><font color="<%=TableContentColor%>"><%=request.ServerVariables("SERVER_PORT")%></font></td>
  </tr>
  <tr> 
    <td width="30%" valign=top><font color="<%=TableContentColor%>">Э������ƺͰ汾</font></td>
    <td width="70%"><font color="<%=TableContentColor%>"><%=request.ServerVariables("SERVER_PROTOCOL")%></font></td>
  </tr>
  <tr> 
    <td width="30%" valign=top><font color="<%=TableContentColor%>">�����������ƺͰ汾</font></td>
    <td width="70%"><font color="<%=TableContentColor%>"><%=request.ServerVariables("SERVER_SOFTWARE")%></font></td>
  </tr>
  <tr> 
    <td width="30%" valign=top><font color="<%=TableContentColor%>">����������ϵͳ</font></td>
    <td width="70%"><font color="<%=TableContentColor%>"><%=Request.ServerVariables("OS")%></font></td>
  </tr>
  <tr> 
    <td width="30%" valign=top><font color="<%=TableContentColor%>">�ű���ʱʱ��</font></td>
    <td width="70%"><font color="<%=TableContentColor%>"><%=Server.ScriptTimeout%> 
      </font>��</td>
  </tr>
  <tr> 
    <td width="30%" valign=top><font color="<%=TableContentColor%>">������CPU����</font></td>
    <td width="70%"><font color="<%=TableContentColor%>"><%=Request.ServerVariables("NUMBER_OF_PROCESSORS")%> 
      ��</font></td>
  </tr>
  <tr> 
    <td width="30%" valign=top><font color="<%=TableContentColor%>">��������������</font></td>
    <td width="70%"><font color="<%=TableContentColor%>"><%=ScriptEngine & "/"& ScriptEngineMajorVersion &"."&ScriptEngineMinorVersion&"."& ScriptEngineBuildVersion %></font></td>
  </tr>
  <tr> 
    <td colspan="2" bgcolor=<%=atabletitlecolor%> height=20> <font color="<%=TableContentColor%>"> 
      <b>���֧�����</b></font> </td>
  </tr>
  <tr> 
    <td colspan="2" height=20> <font color="<%=TableContentColor%>"> 
      <%
Dim strClass
    strClass = Trim(Request.Form("classname"))
    If "" <> strClass then
    Response.Write "<br>��ָ��������ļ������"
      If Not IsObjInstalled(strClass) then 
        Response.Write "<br><font color=red>���ź����÷�������֧��" & strclass & "�����</font>"
      Else
        Response.Write "<br><font color=green>��ϲ���÷�����֧��" & strclass & "�����</font>"
      End If
      Response.Write "<br>"
    end if
%>
      </font> </td>
  </tr>
  <tr> 
    <td colspan="2" height=20> <font color="<%=TableContentColor%>"> <b>����IIS�Դ����</b></font> 
    </td>
  </tr>
  <tr> 
    <td colspan="2" height=20> <font color="<%=TableContentColor%>"> <table border=0 width="95%" cellspacing=1 cellpadding=0>
        <tr height=22 align=center> 
          <td width="70%"><font color="<%=TableContentColor%>">�� �� �� ��</font></td>
          <td width="15%"><font color="<%=TableContentColor%>">֧ ��</font></td>
          <td width="15%"><font color="<%=TableContentColor%>">��֧��</font></td>
        </tr>
        <%
    dim i
    For i=0 to 10
      Response.Write "<TR align=center height=22><TD align=left>&nbsp;" & theInstalledObjects(i) & "<font color=#888888>&nbsp;"
	  select case i
		case 9
		Response.Write "(FSO �ı��ļ���д)"
		case 10
		Response.Write "(ACCESS ���ݿ�)"
	  end select
	  Response.Write "</font></td>"
      If Not IsObjInstalled(theInstalledObjects(i)) Then 
        Response.Write "<td></td><td><font color=red><b>��</b></font></td>"
      Else
        Response.Write "<td><b>��</b></td><td></td>"
      End If
      Response.Write "</TR>" & vbCrLf
    Next
    %>
      </table></td>
  </tr>
  <tr> 
    <td colspan="2" height=20> <font color="<%=TableContentColor%>"><b>���������������</font> 
    </td>
  </tr>
  <tr> 
    <td colspan="2" height=20> <table border=0 width="95%" cellspacing=1 cellpadding=0>
        <tr height=22 align=center> 
          <td width="70%"><font color="<%=TableContentColor%>">�� �� �� ��</font></td>
          <td width="15%"><font color="<%=TableContentColor%>">֧ ��</font></td>
          <td width="15%"><font color="<%=TableContentColor%>">��֧��</font></td>
        </tr>
        <%

    For i=11 to UBound(theInstalledObjects)
      Response.Write "<TR align=center height=18><TD align=left>&nbsp;" & theInstalledObjects(i) & "<font color=#888888>&nbsp;"
	  select case i
		case 11
		Response.Write "(SA-FileUp �ļ��ϴ�)"
		case 12
		Response.Write "(SA-FM �ļ�����)"
		case 13
		Response.Write "(LyfUpload �ļ��ϴ�)"
		case 14
		Response.Write "(ASPUpload �ļ��ϴ�)"
		
	  end select
	  Response.Write "</font></td>"
      If Not IsObjInstalled(theInstalledObjects(i)) Then 
        Response.Write "<td></td><td><font color=red><b>��</b></font></td>"
      Else
        Response.Write "<td><b>��</b></td><td></td>"
      End If

      Response.Write "</TR>" & vbCrLf
    Next
    %>
      </table></td>
  </tr>
</table>
<%
end sub
Function IsObjInstalled(strClassString)
On Error Resume Next
IsObjInstalled = False
Err = 0
Dim xTestObj
Set xTestObj = Server.CreateObject(strClassString)
If 0 = Err Then IsObjInstalled = True
Set xTestObj = Nothing
Err = 0
End Function
%>