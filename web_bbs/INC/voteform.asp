<%
sub showvoteForm()
dim e
%>
<form action="Savevote.asp?boardID=<%=request("boardid")%>" method="POST" onSubmit="submitonce(this)" name="frmAnnounce">

  <div align="center"><center>
<script src="inc/ubbcode.js"></script>
<table bgColor="<%=Tablebackcolor%>" cellpadding=0 cellspacing=0 border=0 width="<%=tablewidth%>" cellspacing="0">
    <tr>
      <td width="100%">
<table cellpadding=3 cellspacing=1 border=0 width=100%>
    <tr>
      <td width="100%" bgcolor="<%=Tabletitlecolor%>" colspan=2><div align="left"><font color="<%=TableFontcolor%>"><p>&nbsp;&nbsp;<b>*Ϊ������Ŀ <%=boardstat%></b></font></td>
    </tr>
<%if membername="" then%>
        <tr bgcolor="<%=Tablebodycolor%>">
          <td width="20%"><font color="<%=TableContentcolor%>"><b>�û���</b></font></td>
          <td width="80%"><input name="username" value="<%if membername<>"" then%><%=htmlencode(membername)%><%else%><%if boardskin=2 then response.write "����"%><%end if%>" class=FormClass>&nbsp;&nbsp;<font color="<%=AlertFontColor%>"><b>*</b></font><a href=reg.asp><font color="<%=TableContentcolor%>">��û��ע�᣿</font></a> 
          </td>
        </tr>
        <tr bgcolor="<%=Tablebodycolor%>">
          <td width="20%"><font color="<%=TableContentcolor%>"><b>����</b></font></td>
          <td width="80%"><input name="passwd" type="password" value="<%=htmlencode(memberword)%>" class=FormClass><font color="<%=AlertFontColor%>">&nbsp;&nbsp;<b>*</b></font><a href=lostpass.asp><font color="<%=TableContentcolor%>">�������룿</font></a></td>
        </tr>
<%end if%>
        <tr bgcolor="<%=Tablebodycolor%>">
          <td width="20%"><font color="<%=TableContentcolor%>"><b>�������</b></font>
              <SELECT name=font onchange=DoTitle(this.options[this.selectedIndex].value)>
              <OPTION selected value="">ѡ����</OPTION> <OPTION value=[ԭ��]>[ԭ��]</OPTION> 
              <OPTION value=[ת��]>[ת��]</OPTION> <OPTION value=[��ˮ]>[��ˮ]</OPTION> 
              <OPTION value=[����]>[����]</OPTION> <OPTION value=[����]>[����]</OPTION> 
              <OPTION value=[�Ƽ�]>[�Ƽ�]</OPTION> <OPTION value=[����]>[����]</OPTION> 
              <OPTION value=[ע��]>[ע��]</OPTION> <OPTION value=[��ͼ]>[��ͼ]</OPTION>
              <OPTION value=[����]>[����]</OPTION> <OPTION value=[����]>[����]</OPTION>
              <OPTION value=[����]>[����]</OPTION></SELECT></td>
		            <td width="80%"><font color="<%=TableContentcolor%>"><input name="subject" size=60 maxlength=80 class=FormClass>&nbsp;&nbsp;<font color="<%=AlertFontColor%>"><strong>*</strong></font>���ó��� 50 ������</font>
<INPUT TYPE="hidden" name="boardtype" value="<%=htmlencode(boardtype)%>">
<INPUT TYPE="hidden" name="skin" value="<%=request("skin")%>">
	 </td>
        </tr>
        <tr bgcolor="<%=Tablebodycolor%>">
          <td width="20%"><font color="<%=TableContentcolor%>"><b>ͶƱ��Ŀ </b> <br>
        <br>
        <li>ÿ��һ��ͶƱ��Ŀ�����<%=vote_num%>��</li>
        <li>�����Զ����ϣ������Զ�����</li><br>
        <br>
        <input type="radio" name="votetype" value="0" checked>
          ��ѡͶƱ<br>
          <input type="radio" name="votetype" value="1">
          ��ѡͶƱ</font></td>
	  <td width="80%"><textarea name="vote" cols="80" rows="8"></textarea>
	 </td>
        </tr>
        <tr bgcolor="<%=Tablebodycolor%>">
          <td width="20%" valign="top"><font color="<%=TableContentcolor%>"><b>��ǰ����</b><br><li>���������ӵ�ǰ��<BR></font></td>
          <td width="80%">
<%for i=1 to 9%>
	<input type="radio" value="face<%=i%>" name="Expression" <%if i=1 then response.write "checked"%>><img src="face/face<%=i%>.gif" WIDTH="15" HEIGHT="15">&nbsp;&nbsp;
<%next%>
<br>
<%for i=10 to 18%>
	<input type="radio" value="face<%=i%>" name="Expression"><img src="face/face<%=i%>.gif" WIDTH="15" HEIGHT="15">&nbsp;&nbsp;
<%next%>
 </td>
        </tr>
        <tr bgcolor="<%=Tablebodycolor%>">
          <td width="20%" valign=top><font color="<%=TableContentcolor%>">
<b>����</b><br><br>
�ڴ���̳��<br>
<li>HTML��ǩ�� <%if strAllowHTML=0 then%>������<%else%>����<%end if%>
<li>UBB��ǩ�� <%if strAllowForumCode=0 then%>������<%else%>����<%end if%>
<li>��ͼ��ǩ�� <%if strIcons=0 then%>������<%else%>����<%end if%>
<li>Flash��ǩ�� <%if strflash=0 then%>������<%else%>����<%end if%>
<li>�����ַ�ת���� <%if strIMGInPosts=0 then%>������<%else%>����<%end if%>
<li>�ϴ�ͼƬ�� <%if Uploadpic=0 then%>������<%else%>����<%end if%>
<li>���<%=AnnounceMaxBytes\1024%>KB</font>
	  </td>
          <td width="80%">
<%if TopicFlag=1 then%>
<!--#include file="getubb.asp"-->
<%end if%>
<textarea class="smallarea" cols="80" name="Content" rows="12" wrap="VIRTUAL" title="����ʹ��Ctrl+Enterֱ���ύ����" class=FormClass onkeydown=ctlent()></textarea>
          </td>
        </tr>
		<tr>
                <td bgcolor="<%=Tablebodycolor%>" valign=top colspan=2><font color="<%=TableContentcolor%>"><b>�������ͼ�����������м�����Ӧ�ı���</B><br></font>&nbsp;

<%for e=1 to 9%>
                	<img src="<%=picurl&Imgname%>0<%=e%>.gif" border=0 onclick="insertsmilie('[<%=Imgname%>0<%=e%>]')" style="CURSOR: hand">
<%next%>
<%for e=10 to ImgNum%>
                	<img src="<%=picurl&Imgname&e%>.gif" border=0 onclick="insertsmilie('[<%=Imgname&e%>]')" style="CURSOR: hand">
<%next%>
    		</td>
                </tr>
                <tr bgcolor="<%=Tablebodycolor%>">
                <td valign=top><font color="<%=TableContentcolor%>"><b>ѡ��</b><p><a href="boardhelp.asp?boardid=<%=boardid%>"><img src="<%=picurl%>help_b.gif" border=0></a></font></td>
                <td valign=middle><font color="<%=TableContentcolor%>"><input type=checkbox name="signflag" value="yes" checked>�Ƿ���ʾ����ǩ����<br>
                <input type=checkbox name="emailflag" value="yes">�лظ�ʱʹ���ʼ�֪ͨ����
<BR><BR></font></td>
                </tr><tr bgcolor="<%=Tablebodycolor%>">
                <td valign=middle colspan=2 align=center><font color="<%=TableContentcolor%>">
                <input type=Submit value="�� ��" name=Submit> &nbsp; <input type=button value='Ԥ ��' name=Button onclick=gopreview()>&nbsp;<input type="reset" name="Clear" value="�� ��">
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