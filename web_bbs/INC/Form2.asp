<%
sub showeditForm()
dim e
%>
<form action="SaveditAnnounce.asp?boardID=<%=boardID%>&RootID=<%=RootID%>&ID=<%=announceID%>" method="POST" name="frmAnnounce" onSubmit="submitonce(this)">
  <input type="hidden" name="followup" value="<%=AnnounceID%>"><input type="hidden" name="rootID" value="<%=RootID%>">
  <div align="center"><center>
<script src="inc/ubbcode.js"></script>
<table bgColor="<%=Tablebackcolor%>" cellpadding=0 cellspacing=0 border=0 width="95%" cellspacing="0">
    <tr>
      <td width="100%">
<table cellpadding=3 cellspacing=1 border=0 width=100%>
    <tr>
      <td width="100%" bgcolor="<%=Tabletitlecolor%>" colspan=2><div align="left"><font color=<%=TableFontColor%>><p><strong>&nbsp;&nbsp;<b>*Ϊ������Ŀ <%=boardstat%></font></b></td>
    </tr>
        <tr bgcolor=<%=TableBodyColor%>>
          <td width="20%"><font color=<%=TableContentColor%>><b>�û���</b></font></td>
          <td width="80%"><input name="username" value="<%=htmlencode(old_user)%>" >&nbsp;&nbsp;<font color="<%=AlertFontColor%>"><b>*</b></font><a href=reg.asp><font color=<%=TableContentColor%>>��û��ע�᣿</font></a> 
          </td>
        </tr>
        <tr bgcolor=<%=TableBodyColor%>>
          <td width="20%"><font color=<%=TableContentColor%>><b>����</b></font></td>
          <td width="80%"><font color=<%=TableContentColor%>><input name="passwd" type="password" value="<%=htmlencode(memberword)%>" ><font color="<%=AlertFontColor%>">&nbsp;&nbsp;<b>*</b></font><a href=lostpass.asp><font color=<%=TableContentColor%>>�������룿</font></a>�����༭����Ҫ����</font></td>
        </tr>
        <tr bgcolor=<%=TableBodyColor%>>
          <td width="20%"><font color=<%=TableContentColor%>><b>�������</b>
              <SELECT name=font onchange=DoTitle(this.options[this.selectedIndex].value)>
              <OPTION selected value="">ѡ����</OPTION> <OPTION value=[ԭ��]>[ԭ��]</OPTION> 
              <OPTION value=[ת��]>[ת��]</OPTION> <OPTION value=[��ˮ]>[��ˮ]</OPTION> 
              <OPTION value=[����]>[����]</OPTION> <OPTION value=[����]>[����]</OPTION> 
              <OPTION value=[�Ƽ�]>[�Ƽ�]</OPTION> <OPTION value=[����]>[����]</OPTION> 
              <OPTION value=[ע��]>[ע��]</OPTION> <OPTION value=[��ͼ]>[��ͼ]</OPTION>
              <OPTION value=[����]>[����]</OPTION> <OPTION value=[����]>[����]</OPTION>
              <OPTION value=[����]>[����]</OPTION></SELECT></font></td>
          <td width="80%"><input name="subject" size=60 maxlength=80 value="<%=htmlencode(Topic)%>" >&nbsp;&nbsp;<font color="<%=AlertFontColor%>"><strong>*</strong></font><font color=<%=TableContentColor%>>���ó��� 50 ������</font>
<INPUT TYPE="hidden" name="boardtype" value="<%=htmlencode(boardtype)%>">
<INPUT TYPE="hidden" name="skin" value="<%=request("skin")%>">
	 </td>
        </tr>
        <tr bgcolor=<%=TableBodyColor%>>
          <td width="20%" valign=top><font color=<%=TableContentColor%>>
<b>����</b><br><br>
�ڴ���̳��<br>
<li>�ϴ�ͼƬ�� <%if Uploadpic=0 then%>������<%else%>����<%end if%>
<li>���<%=AnnounceMaxBytes\1024%>KB</font>
	  </td>
          <td width="80%">
<%if TopicFlag=1 then%>
<!--#include file="getubb.asp"-->
<%end if%>
<textarea class="smallarea" cols="80" name="Content" rows="12" wrap="VIRTUAL"  onkeydown=ctlent()>
<%	if con<>"" then
	    content=replace(con,"<br>",chr(13))
            content=replace(content,"&nbsp;"," ")
            response.write content+chr(13)
	end if
%>
</textarea>
	</td>
        </tr>
                <tr bgcolor=<%=TableBodyColor%>>
                <td valign=top><font color=<%=TableContentColor%>><b>ѡ��</b><p><a href="boardhelp.asp?boardid=<%=boardid%>"><img src="<%=picurl%>help_b.gif" border=0></a></font></td>
                <td valign=middle><input type=checkbox name="signflag" value="yes" checked><font color=<%=TableContentColor%>>�Ƿ���ʾ����ǩ����</font>
<BR><BR></td>
                </tr><tr bgcolor=<%=TableBodyColor%>>
                <td valign=middle colspan=2 align=center>
                <input type=Submit value="�� ��" name=Submit"> &nbsp; <input type=button value='Ԥ ��' name=Button onclick=gopreview()>&nbsp;<input type="reset" name="Submit2" value="�� ��">
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
	if err.number<>0 then err.clear
end sub
%>