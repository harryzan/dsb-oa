<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=chkuser.asp-->
<title><%=ForumName%>--管理页面</title>
<!--#include file="Forum_css.asp"-->

<BODY <%=ForumBody%>>
<%
	if not master or instr(session("flag"),"44")=0 then
		Errmsg=Errmsg+"<br>"+"<li>本页面为管理员专用，请<a href=admin_index.asp target=_top>登陆</a>后进入。<br><li>您没有管理本页面的权限。"
		call Error()
	else
'response.write MaxAnnouncePerPage
'response.end
%>
<table cellpadding=0 cellspacing=0 border=0 width=<%=tablewidth%> bgcolor=<%=tablebackcolor%> align=center>
  <tr>
    <td>
      <table cellpadding=3 cellspacing=1 border=0 width=100%>
        <tr bgcolor='<%=Tabletitlecolor%>'>
        <td><font color="<%=TablefontColor%>">欢迎<b><%=membername%></b>进入管理页面</font>
        </td>
        </tr>
            <tr bgcolor=<%=tablebodycolor%>>
              <td width="100%" valign=top><font color="<%=TableContentColor%>">
<%
   	dim totalPut   
   	dim CurrentPage
   	dim TotalPages
   	dim i,j
   	dim idlist
   	dim title
   	dim sql
   	dim rs

	title=request("txtitle")
	content=request("content")
   	if not isempty(request("page")) then
      		currentPage=cint(request("page"))
  	else
      		currentPage=1
   	end if
  	if not isempty(request("selAnnounce")) then
     		idlist=request("selAnnounce")
     		if instr(idlist,",")>0 then
		dim idarr
		idArr=split(idlist)
		dim id
		for i = 0 to ubound(idarr)
	       		id=clng(idarr(i))
	       		'call deleteannounce(id)
		next
     		else
			'call deleteannounce(clng(idlist))
     		end if
  	end if 
%>

<body>
<div align="center"><center>

<form name="searchuser" method="POST" action="admin_log.asp">
<font color="<%=AlertFontColor%>">点击用户名进行相应操作</font>，  查找用户:  <input type="text" name="txtitle" size="13"><input type="submit" value="查询" name="title">
</form>
<form method=Post action="admin_log.asp">
    <div align="center">
<%
	sql="select * from log where l_username like '%"&trim(title)&"%' or l_content like '"&content&"' order by l_id desc"
	Set rs= Server.CreateObject("ADODB.Recordset")
	rs.open sql,conn,1,1

  	if rs.eof and rs.bof then
       		response.write "<p align='center'> 还 没 有 任 何 记 录 </p>"
   	else
      		totalPut=rs.recordcount 
      		if currentpage<1 then 
          		currentpage=1 
      		end if 
		MaxAnnouncePerpage=Clng(MaxAnnouncePerpage)
      		if (currentpage-1)*MaxAnnouncePerPage>totalput then 
	   		if (totalPut mod MaxAnnouncePerPage)=0 then 
	     			currentpage= totalPut \ MaxAnnouncePerPage 
	   		else 
	      			currentpage= totalPut \ MaxAnnouncePerPage + 1 
	   		end if 
      		end if 
       		if currentPage=1 then 
            		showContent 
            		showpage totalput,MaxAnnouncePerPage,"admin_log.asp" 
       		else 
          		if (currentPage-1)*MaxAnnouncePerPage<totalPut then 
            			rs.move  (currentPage-1)*MaxAnnouncePerPage
            			dim bookmark 
            			bookmark=rs.bookmark  
            			showContent 
             			showpage totalput,MaxAnnouncePerPage,"admin_log.asp" 
        		else 
	        		currentPage=1 
           			showContent 
           			showpage totalput,MaxAnnouncePerPage,"admin_log.asp" 
	      		end if 
	   	end if
   	rs.close
   	end if
	        
   	set rs=nothing  
   	conn.close
   	set conn=nothing
  

   	sub showContent
       	dim i
	   i=0

%>
      <div align="center"><center>
<table border="0" cellspacing="0" width="100%"  cellpadding="0">
        <tr bgcolor="<%=aTabletitlecolor%>">
          <td width="100" align="center"><font color="<%=TableContentColor%>"><strong>用户名</strong></font></td>
          <td width="100" align="center"><font color="<%=TableContentColor%>"><strong>操作</strong></font></td>
          <td width="100" align="center"><font color="<%=TableContentColor%>"><strong>相关连接</strong></font></td>
          <td width="150" align="center"><font color="<%=TableContentColor%>"><strong>时间</strong></font></td>
          <td width="50" align="center"><font color="<%=TableContentColor%>">删除</font></td>
        </tr>
<%do while not rs.eof%>
        <tr>
          <td width="100" height=22><p align="center"><a href="admin_modiuser.asp?name=<%=htmlencode(rs("l_username"))%>"><font color="<%=TableContentColor%>"><%=htmlencode(rs("l_username"))%></font></a></td>
          <td width="100"><font color="<%=TableContentColor%>"><p align="center"><%=rs("l_content")%></font></td>
          <td width="100"><p align="center"><a href="<%=rs("l_url")%>"><font color="<%=TableContentColor%>">查看</font></a></td>
          <td width="150"><font color="<%=TableContentColor%>"><%=rs("l_addtime")%></font></td>
          <td width="50"><font color="<%=TableContentColor%>"><p align="center"><input type='checkbox' name='selAnnounce' value='<%=cstr(rs("l_ID"))%>'></font></td>
        </tr>
<% 
	i=i+1
	if i>=MaxAnnouncePerPage then exit do
	rs.movenext
	loop
%>
        <tr>
          <td width="100%" align="right" bgcolor="<%=aTabletitlecolor%>" colSpan=5><font color="<%=TableContentColor%>"><input type=checkbox name=chkall value=on onclick="CheckAll(this.form)">选中所有显示信息&nbsp;<input type='submit' value='删除'></font></td>
        </tr>
      </table>
      </center></div>
<%
   end sub 

function showpage(totalnumber,MaxAnnouncePerPage,filename)
  dim n
  if totalnumber mod MaxAnnouncePerPage=0 then
     n= totalnumber \ MaxAnnouncePerPage
  else
     n= totalnumber \ MaxAnnouncePerPage+1
  end if
  response.write "<p align='center'>&nbsp;"
  if CurrentPage<2 then
    response.write "首页 上一页&nbsp;"
  else
    response.write "<a href="&filename&"?page=1&txtitle="&request("txtitle")&">首页</a>&nbsp;"
    response.write "<a href="&filename&"?page="&CurrentPage-1&"&txtitle="&request("txtitle")&">上一页</a>&nbsp;"
  end if
  if n-currentpage<1 then
    response.write "下一页 尾页"
  else
    response.write "<a href="&filename&"?page="&(CurrentPage+1)&"&txtitle="&request("txtitle")&">"
    response.write "下一页</a> <a href="&filename&"?page="&n&"&txtitle="&request("txtitle")&">尾页</a>"
  end if
   response.write "&nbsp;页次：</font><strong><font color=red>"&CurrentPage&"</font>/"&n&"</strong>页 "
    response.write "&nbsp;共<b>"&totalnumber&"</b>条信息 <b>"&MaxAnnouncePerPage&"</b>条信息/页 "
       
end function

  sub deleteannounce(id)
    dim rs,sql
    set rs=server.createobject("adodb.recordset")
    sql="delete from log where l_id="&cstr(id)
    conn.execute sql
  End sub
%></font>
	      </td>
            </tr>
        </table>
        </td>
    </tr>
</table>
<script language="JavaScript">
<!--
function CheckAll(form)  {
  for (var i=0;i<form.elements.length;i++)    {
    var e = form.elements[i];
    if (e.name != 'chkall')       e.checked = form.chkall.checked; 
   }
  }
//-->
</script>
<%end if%>