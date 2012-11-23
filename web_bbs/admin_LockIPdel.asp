<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=chkuser.asp-->
<title><%=ForumName%>--管理页面</title>
<!--#include file="Forum_css.asp"-->

<BODY <%=ForumBody%>>
<%
	if not master or instr(session("flag"),"57")=0 then
		Errmsg=Errmsg+"<br>"+"<li>本页面为管理员专用，请<a href=admin_index.asp target=_top>登陆</a>后进入。<br><li>您没有管理本页面的权限。"
		call Error()
	else
%>
<table cellpadding=0 cellspacing=0 border=0 width=<%=tablewidth%> bgcolor=<%=tablebackcolor%> align=center>
  <tr>
    <td>
      <table cellpadding=3 cellspacing=1 border=0 width=100%>
        <tr bgcolor='<%=Tabletitlecolor%>'>
        <td align=center><font color="<%=TablefontColor%>">欢迎<b><%=membername%></b>进入管理页面</font>
        </td>
        </tr>
            <tr bgcolor=<%=tablebodycolor%>>
              
	 <td width="100%" valign=top> <font color="<%=TableContentColor%>">
	  <%
   	dim totalPut   
   	dim CurrentPage
   	dim TotalPages
   	dim j
   	dim idlist
   	dim title

	title=request("txtitle")
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
	       		call deleteannounce(id)
		next
     		else
			call deleteannounce(clng(idlist))
     		end if
  	end if 
%><body>
	  <div align="center"><center> <form method=Post action="admin_LockIPdel.asp"> <div align="center"> 
	  <%
	sql="select id,sip1,sip2 from LockIP order by id desc"
	Set rs= Server.CreateObject("ADODB.Recordset")
	rs.open sql,conn,0,1

  	if rs.eof and rs.bof then
       		response.write "<p align='center'> 还 没 有 IP 限 制 数 据 </p>"
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
            		showpage totalput,MaxAnnouncePerPage,"admin_LockIPdel.asp" 
       		else 
          		if (currentPage-1)*MaxAnnouncePerPage<totalPut then 
            			rs.move  (currentPage-1)*MaxAnnouncePerPage
            			dim bookmark 
            			bookmark=rs.bookmark  
            			showContent 
             			showpage totalput,MaxAnnouncePerPage,"admin_LockIPdel.asp" 
        		else 
	        		currentPage=1 
           			showContent 
           			showpage totalput,MaxAnnouncePerPage,"admin_LockIPdel.asp" 
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
        <tr>
          <td width="46" align="center" bgcolor="<%=aTabletitlecolor%>" height="20"><font color="<%=TableContentColor%>"><strong>ID号</strong></font></td>
          <td width="200" align="center" bgcolor="<%=aTabletitlecolor%>"><font color="<%=TableContentColor%>"><strong>起始IP</strong></font></td>
		  <td width="200" align="center" bgcolor="<%=aTabletitlecolor%>"><font color="<%=TableContentColor%>"><strong>结尾IP</strong></font></td>
          <td width="68" align="center" bgcolor="<%=aTabletitlecolor%>"><input type='submit'  value='删除'></td>
        </tr>
<%do while not rs.eof%>
        <tr align=center>
          <td height="23" width="46"><font color="<%=TableContentColor%>"><p align="center"><%=rs("id")%></font></td>
          <td width="200"><font color="<%=TableContentColor%>"><%=rs("sip1")%></font></td>
          <td width="200"><font color="<%=TableContentColor%>"><%=rs("sip2")%></font></td>
		  <td width="68"><p align="center"><input type='checkbox' name='selAnnounce' value='<%=cstr(rs("ID"))%>'></td>
        </tr>
<% 
	i=i+1
	if i>=MaxAnnouncePerPage then exit do
	rs.movenext
	loop
%>
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
    response.write "&nbsp;共<b>"&totalnumber&"</b>个记录 <b>"&MaxAnnouncePerPage&"</b>个记录/页 "
       
end function

  sub deleteannounce(id)
    dim rs,sql
    set rs=server.createobject("adodb.recordset")
    sql="delete from LockIP where id="&cstr(id)
    conn.execute sql
    if err.Number<>0 then
	err.clear
	response.write "删 除 失 败 !<br>"
    else
        response.write "删 除 成 功！<br>"
    end if
  End sub
%></font>
	      </td>
            </tr>
        </table>
        </td>
    </tr>
</table>
<%end if%>