<%
sub showForm()
dim e
%>
<form action="SaveAnnounce.asp?boardID=<%=request("boardid")%>" method="POST" onSubmit="submitonce(this)" name="frmAnnounce">
<div align="center"><center>
<script src="inc/ubbcode.js"></script>
<table bgColor="<%=Tablebackcolor%>" cellpadding=0 cellspacing=0 border=0 width="<%=TableWidth%>" cellspacing="0">
    <tr>
      <td width="100%">
<table cellpadding=3 cellspacing=1 border=0 width=100%>
    <tr>
      <td width="100%" bgcolor="<%=Tabletitlecolor%>" colspan=2><div align="left"><font color="<%=TableFontcolor%>"><p>&nbsp;&nbsp;<b>*Ϊ������Ŀ <%=boardstat%></b></font></td>
    </tr>
<%if membername="" then%>
        <tr bgcolor="<%=TablebodyColor%>">
          <td width="20%"><font color="<%=TableContentcolor%>"><b>�û���</b></font></td>
          <td width="80%"><input name="username" value="<%if membername<>"" then%><%=htmlencode(membername)%><%else%><%if boardskin=2 then response.write "����"%><%end if%>" class=FormClass>
          &nbsp;<font color="<%=AlertFontColor%>">&nbsp;</font><a href=reg.asp><font color="<%=TableContentcolor%>">��û��ע�᣿</font></a> 
        </td>
        </tr>
        <tr bgcolor="<%=TablebodyColor%>">
          <td width="20%"><font color="<%=TableContentcolor%>"><b>����</b></td>
          <td width="80%"><input name="passwd" type="password" value="<%=htmlencode(memberword)%>" class=FormClass>
          <font color="<%=AlertFontColor%>">&nbsp;&nbsp;</font><a href=lostpass.asp><font color="<%=TableContentcolor%>">�������룿</font></a></td>
        </tr>
<%end if%>
        <tr bgcolor="<%=TablebodyColor%>">
          <td width="20%"><font color="<%=TableContentcolor%>"><b>�������</b>
              <SELECT name=font onchange=DoTitle(this.options[this.selectedIndex].value)>
              <OPTION selected value="">ѡ����</OPTION> <OPTION value=[ԭ��]>[ԭ��]</OPTION> 
              <OPTION value=[ת��]>[ת��]</OPTION> <OPTION value=[��ˮ]>[��ˮ]</OPTION> 
              <OPTION value=[����]>[����]</OPTION> <OPTION value=[����]>[����]</OPTION> 
              <OPTION value=[�Ƽ�]>[�Ƽ�]</OPTION> <OPTION value=[����]>[����]</OPTION> 
              <OPTION value=[ע��]>[ע��]</OPTION> <OPTION value=[��ͼ]>[��ͼ]</OPTION>
              <OPTION value=[����]>[����]</OPTION> <OPTION value=[����]>[����]</OPTION>
              <OPTION value=[����]>[����]</OPTION></SELECT>
	  </td>
		            <td width="80%"><font color="<%=TableContentcolor%>"><input name="subject" size=60 maxlength=80 class=FormClass>&nbsp;&nbsp;<font color="<%=AlertFontColor%>"><strong>*</strong></font>���ó��� 50 ������</font>
<INPUT TYPE="hidden" name="boardtype" value="<%=htmlencode(boardtype)%>">
<INPUT TYPE="hidden" name="skin" value="<%=request("skin")%>">
	 </td>
        </tr>
        <tr bgcolor="<%=TablebodyColor%>">
          <td width="20%" valign=top><font color="<%=TableContentcolor%>">
<b>����</b><br><br>
�ڴ���̳��<br>
<li>�ϴ�ͼƬ�� <%if Uploadpic=0 then%>������<%else%>����<%end if%>
<li>���<%=AnnounceMaxBytes\1024%>KB</font>
	  </td>
          <td width="80%">
<% if Uploadpic=1 then %>
<iframe name="ad" frameborder=0 width=100% height=30 scrolling=no src=saveannounce_upload.asp?boardid=<%=boardid%>></iframe> 
<br>
<% end if %>
<%if TopicFlag=1 then%>
<!--#include file="getubb.asp"-->
<%end if%>
<textarea class="smallarea" cols="80" name="Content" rows="12" wrap="VIRTUAL" title="����ʹ��Ctrl+Enterֱ���ύ����" class=FormClass onkeydown=ctlent()></textarea>
          </td>
        </tr>
                <tr bgcolor="<%=TablebodyColor%>">
                <td valign=top><font color="<%=TableContentcolor%>"><b>ѡ��</b><p><a href="boardhelp.asp?boardid=<%=boardid%>"><img src="<%=picurl%>help_b.gif" border=0></a></font></td>
                <td valign=middle><font color="<%=TableContentcolor%>"><input type=checkbox name="signflag" value="yes" checked>�Ƿ���ʾ����ǩ����<br></font>
<BR><BR></td>
                </tr><tr bgcolor="<%=TablebodyColor%>">
                <td valign=middle colspan=2 align=center><font color="<%=TableContentcolor%>">
                <input type=Submit value="�� ��" name=Submit> &nbsp; <input type=button value='Ԥ ��' name=Button onclick=gopreview()>&nbsp;
<input type="reset" name="Submit2" value="�� ��">
                </td></form></tr>
      </table>
      </td>
    </tr>
  </table>
  </center></div>
</form>
		<form name=preview action=preview.asp method=post target=preview_page>
		<input type=hidden name=title value=""><input type=hidden name=body value="">
		</form>
		<script>
		function gopreview()
		{
		document.forms[1].title.value=document.forms[0].subject.value;
		document.forms[1].body.value=document.forms[0].Content.value;
		var popupWin = window.open('preview.asp', 'preview_page', 'scrollbars=yes,width=750,height=450');
		document.forms[1].submit()
		}
		</script>
<%
	end sub
%>