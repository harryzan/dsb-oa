<!--#include file=conn.asp-->
<!--#include file=inc/const.asp-->
<!--#include file=inc/char.asp-->
<title><%=ForumName%>--下载</title>
<!--#include file="Forum_css.asp"-->

<BODY bgcolor="#ffffff" alink="#333333" vlink="#333333" link="#333333" topmargin="20">
<%
	dim newversion,newid
	dim oldversion
	dim oldid
	dim conn_1
	dim connstr_1
	dim newdowndate,olddownload
	Set conn_1 = Server.CreateObject("ADODB.connection")
	connstr_1="Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath("version/dvbbs_version.mdb")
	conn_1.open connstr_1
	call main()

	sub main()
	set rs=conn_1.execute("select top 1 version,id,downdate from version order by addtime desc")
	newversion=rs(0)
	newid=rs(1)
	newdowndate=rs(2)
	rs.close
	set rs=nothing
	set rs=conn_1.execute("select top 1 version,id,download from version where type='正式版本' and download is not null order by addtime desc")
	oldversion=rs(0)
	oldid=rs(1)
	olddownload=rs(2)
	rs.close
	set rs=nothing
%>
<table cellpadding=0 cellspacing=0 border=0 width=95% bgcolor=<%=tablebackcolor%> align=center>
  <tr>
    <td>
      <table cellpadding=6 cellspacing=1 border=0 width=100%>
        <tr bgcolor='<%=Tabletitlecolor%>'>
          <td align=center><b>欢迎您使用动网论坛</b> </td>
        </tr>
            <tr bgcolor=<%=tablebodycolor%>>
              <td width="100%" valign=top>
<%
call consted()
%>
	      </td>
            </tr>
        </table>
        </td>
    </tr>
</table>
<%
end sub
sub consted()
%>
<table width="95%" border="0" cellspacing="1" cellpadding="3"  align=center 

bordercolor=<%=Tablebackcolor%>>
  <tr bgcolor=<%=aTabletitlecolor%>> 
    <td height="23" colspan="2" ><font color=<%=TableFontcolor%>><b>当前最新版本为：动网论坛 <%=newversion%></b>（预计提供下载日期：<%=newdowndate%>）</font></td>
  </tr>
  <tr> 
    <td height="23" colspan="2" > 
      <p><B>情况介绍</B>： <br>
        <br>
<%
	set rs=conn_1.execute("select * from content where vid="&newid&" order by id")
	if rs.eof and rs.bof then
	response.write "当前还没有功能加入……"
	else
	do while not rs.eof
	response.write "<FONT color=#b70000><B>·</B></FONT>["&rs("type")&"]<span style=""font-size:9pt;line-height: 15pt"">"&rs("title")&"<i><font color=gray>("&rs("addtime")&")</font></i></span><br>"
	rs.movenext
	loop
	end if
	rs.close
	set rs=nothing
%>
      </p>
      <p><b>当前提供下载版本为：动网论坛 <%=oldversion%></b><br>
        <br>
        <font color=<%=TableFontcolor%>><b>情况介绍 </b>：</font><br>
        <br>
<%
	if oldid<>newid then
	set rs=conn_1.execute("select * from content where vid="&oldid&" order by id")
	if rs.eof and rs.bof then
	response.write "当前还没有功能加入……"
	else
	do while not rs.eof
	response.write "<FONT color=#b70000><B>·</B></FONT>["&rs("type")&"]<span style=""font-size:9pt;line-height: 15pt"">"&rs("title")&"</span><br>"
	rs.movenext
	loop
	end if
	rs.close
	set rs=nothing
	end if
%>
    </td>
  </tr>
  <tr> 
    <td width="30%"><a href="<%=olddownload%>" target=_blank><B>点击下载论坛</B></a></td>
    <td width="70%">
    </td>
  </tr>
  <tr> 
    <td width="30%" valign=top><B>相关补丁</B>：</td>
    <td width="70%">
<%
	set rs=conn_1.execute("select * from version where type='论坛补丁' and clink="&oldid&" order by addtime")
	if rs.eof and rs.bof then
	response.write "本版本还没有相关补丁……"
	else
	do while not rs.eof
	response.write "<a href="&rs("download")&" target=_blank>动网论坛"&rs("version")&"</a>  ("&rs("addtime")&")<br>"
	rs.movenext
	loop
	end if
%>
    </td>
  </tr>
  <tr> 
    <td width="30%" valign=top><B>相关插件</B>：</td>
    <td width="70%">
<%
	set rs=conn_1.execute("select * from version where type='论坛插件' and clink="&oldid&" order by addtime")
	if rs.eof and rs.bof then
	response.write "本版本还没有相关插件……"
	else
	do while not rs.eof
	response.write "<a href="&rs("download")&" target=_blank>动网论坛"&rs("version")&"</a>  ("&rs("addtime")&")<br>"
	rs.movenext
	loop
	end if
	rs.close
	set rs=nothing
%>
    </td>
  </tr>
</table>
<%
end sub
call endline()
%>
<!--#include file=footer.asp-->