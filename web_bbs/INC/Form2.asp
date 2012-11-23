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
      <td width="100%" bgcolor="<%=Tabletitlecolor%>" colspan=2><div align="left"><font color=<%=TableFontColor%>><p><strong>&nbsp;&nbsp;<b>*为必填项目 <%=boardstat%></font></b></td>
    </tr>
        <tr bgcolor=<%=TableBodyColor%>>
          <td width="20%"><font color=<%=TableContentColor%>><b>用户名</b></font></td>
          <td width="80%"><input name="username" value="<%=htmlencode(old_user)%>" >&nbsp;&nbsp;<font color="<%=AlertFontColor%>"><b>*</b></font><a href=reg.asp><font color=<%=TableContentColor%>>您没有注册？</font></a> 
          </td>
        </tr>
        <tr bgcolor=<%=TableBodyColor%>>
          <td width="20%"><font color=<%=TableContentColor%>><b>密码</b></font></td>
          <td width="80%"><font color=<%=TableContentColor%>><input name="passwd" type="password" value="<%=htmlencode(memberword)%>" ><font color="<%=AlertFontColor%>">&nbsp;&nbsp;<b>*</b></font><a href=lostpass.asp><font color=<%=TableContentColor%>>忘记密码？</font></a>版主编辑不需要密码</font></td>
        </tr>
        <tr bgcolor=<%=TableBodyColor%>>
          <td width="20%"><font color=<%=TableContentColor%>><b>主题标题</b>
              <SELECT name=font onchange=DoTitle(this.options[this.selectedIndex].value)>
              <OPTION selected value="">选择话题</OPTION> <OPTION value=[原创]>[原创]</OPTION> 
              <OPTION value=[转帖]>[转帖]</OPTION> <OPTION value=[灌水]>[灌水]</OPTION> 
              <OPTION value=[讨论]>[讨论]</OPTION> <OPTION value=[求助]>[求助]</OPTION> 
              <OPTION value=[推荐]>[推荐]</OPTION> <OPTION value=[公告]>[公告]</OPTION> 
              <OPTION value=[注意]>[注意]</OPTION> <OPTION value=[贴图]>[贴图]</OPTION>
              <OPTION value=[建议]>[建议]</OPTION> <OPTION value=[下载]>[下载]</OPTION>
              <OPTION value=[分享]>[分享]</OPTION></SELECT></font></td>
          <td width="80%"><input name="subject" size=60 maxlength=80 value="<%=htmlencode(Topic)%>" >&nbsp;&nbsp;<font color="<%=AlertFontColor%>"><strong>*</strong></font><font color=<%=TableContentColor%>>不得超过 50 个汉字</font>
<INPUT TYPE="hidden" name="boardtype" value="<%=htmlencode(boardtype)%>">
<INPUT TYPE="hidden" name="skin" value="<%=request("skin")%>">
	 </td>
        </tr>
        <tr bgcolor=<%=TableBodyColor%>>
          <td width="20%" valign=top><font color=<%=TableContentColor%>>
<b>内容</b><br><br>
在此论坛中<br>
<li>上传图片： <%if Uploadpic=0 then%>不可用<%else%>允许<%end if%>
<li>最多<%=AnnounceMaxBytes\1024%>KB</font>
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
                <td valign=top><font color=<%=TableContentColor%>><b>选项</b><p><a href="boardhelp.asp?boardid=<%=boardid%>"><img src="<%=picurl%>help_b.gif" border=0></a></font></td>
                <td valign=middle><input type=checkbox name="signflag" value="yes" checked><font color=<%=TableContentColor%>>是否显示您的签名？</font>
<BR><BR></td>
                </tr><tr bgcolor=<%=TableBodyColor%>>
                <td valign=middle colspan=2 align=center>
                <input type=Submit value="发 表" name=Submit"> &nbsp; <input type=button value='预 览' name=Button onclick=gopreview()>&nbsp;<input type="reset" name="Submit2" value="清 除">
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