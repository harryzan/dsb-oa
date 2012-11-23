<!--#include file =conn.asp-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=chkuser.asp-->
<title><%=ForumName%>--管理页面</title>
<!--#include file="Forum_css.asp"-->
<meta NAME=GENERATOR Content=""Microsoft FrontPage 3.0"" CHARSET=GB2312>
<BODY <%=ForumBody%>>
<%
	if not master or instr(session("flag"),"35")=0 then
		Errmsg=Errmsg+"<br>"+"<li>本页面为管理员专用，请<a href=admin_index.asp target=_top>登陆</a>后进入。<br><li>您没有管理本页面的权限。"
		call Error()
	
	end if


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
              <td width="100%" valign=top>
<font color="<%=TableContentColor%>">
 <% 	
	on error resume next
 	Sub ShowSpaceInfo(drvpath)
 		dim fso,d,size,showsize
 		set fso=server.createobject("scripting.filesystemobject") 		
 		drvpath=server.mappath(drvpath) 		 		
 		set d=fso.getfolder(drvpath) 		
 		size=d.size
 		showsize=size & "&nbsp;Byte" 
 		if size>1024 then
 		   size=(size\1024)
 		   showsize=size & "&nbsp;KB"
 		end if
 		if size>1024 then
 		   size=(size/1024)
 		   showsize=formatnumber(size,2) & "&nbsp;MB"		
 		end if
 		if size>1024 then
 		   size=(size/1024)
 		   showsize=formatnumber(size,2) & "&nbsp;GB"	   
 		end if   
 		response.write "<font face=verdana>" & showsize & "</font>"
 	End Sub	
 	
 	Sub Showspecialspaceinfo(method)
 		dim fso,d,fc,f1,size,showsize,drvpath 		
 		set fso=server.createobject("scripting.filesystemobject")
 		drvpath=server.mappath("pic")
 		drvpath=left(drvpath,(instrrev(drvpath,"\")-1))
 		set d=fso.getfolder(drvpath) 		
 		
 		if method="All" then 		
 			size=d.size
 		elseif method="Program" then
 			set fc=d.Files
 			for each f1 in fc
 				size=size+f1.size
 			next	
 		end if	
 		
 		showsize=size & "&nbsp;Byte" 
 		if size>1024 then
 		   size=(size\1024)
 		   showsize=size & "&nbsp;KB"
 		end if
 		if size>1024 then
 		   size=(size/1024)
 		   showsize=formatnumber(size,2) & "&nbsp;MB"		
 		end if
 		if size>1024 then
 		   size=(size/1024)
 		   showsize=formatnumber(size,2) & "&nbsp;GB"	   
 		end if   
 		response.write "<font face=verdana>" & showsize & "</font>"
 	end sub 	 	 	
 	
 	Function Drawbar(drvpath)
 		dim fso,drvpathroot,d,size,totalsize,barsize
 		set fso=server.createobject("scripting.filesystemobject")
 		drvpathroot=server.mappath("pic")
 		drvpathroot=left(drvpathroot,(instrrev(drvpathroot,"\")-1))
 		set d=fso.getfolder(drvpathroot)
 		totalsize=d.size
 		
 		drvpath=server.mappath(drvpath) 		
 		set d=fso.getfolder(drvpath)
 		size=d.size
 		
 		barsize=cint((size/totalsize)*400)
 		Drawbar=barsize
 	End Function 	
 	
 	Function Drawspecialbar()
 		dim fso,drvpathroot,d,fc,f1,size,totalsize,barsize
 		set fso=server.createobject("scripting.filesystemobject")
 		drvpathroot=server.mappath("pic")
 		drvpathroot=left(drvpathroot,(instrrev(drvpathroot,"\")-1))
 		set d=fso.getfolder(drvpathroot)
 		totalsize=d.size
 		
 		set fc=d.files
 		for each f1 in fc
 			size=size+f1.size
 		next	
 		
 		barsize=cint((size/totalsize)*400)
 		Drawspecialbar=barsize
 	End Function 	
 %>

 			<table width=550 cellspacing=1 cellpadding=0 bgcolor=<%=tablebordercolor%>>		  							  				
  				<tr>
  					<td height=25><font color="<%=TableContentColor%>">
  					&nbsp;&nbsp;系统空间占用情况</font>
  					</td>
  				</tr> 	
 				<tr>
 					<td> 	<font color="<%=TableContentColor%>">		
 			<blockquote> 			
 			<%
 			fsoflag=1
 			if fsoflag=1 then
 			%>
 			<br> 			
 			常规数据占用空间：&nbsp;<img src="pic/bar1.gif" width=<%=drawbar("data")%> height=10>&nbsp;<%showSpaceinfo("data")%><br><br>
 			备份数据占用空间：&nbsp;<img src="pic/bar1.gif" width=<%=drawbar("databackup")%> height=10>&nbsp;<%showSpaceinfo("databackup")%><br><br>
 			程序文件占用空间：&nbsp;<img src="pic/bar1.gif" width=<%=drawspecialbar%> height=10>&nbsp;<%showSpecialSpaceinfo("Program")%><br><br>
 			心情图片占用空间：&nbsp;<img src="pic/bar1.gif" width=<%=drawbar("images")%> height=10>&nbsp;<%showSpaceinfo("face")%><br><br>
 			系统图片占用空间：&nbsp;<img src="pic/bar1.gif" width=<%=drawbar("pic")%> height=10>&nbsp;<%showSpaceinfo("pic")%><br><br>
 			上传头像占用空间：&nbsp;<img src="pic/bar1.gif" width=<%=drawbar("uploadFace")%> height=10>&nbsp;<%showSpaceinfo("uploadFace")%><br><br>
 			上传图片占用空间：&nbsp;<img src="pic/bar1.gif" width=<%=drawbar("uploadImages")%> height=10>&nbsp;<%showSpaceinfo("uploadImages")%><br><br>	
 			系统占用空间总计：<br><img src="pic/bar1.gif" width=400 height=10> <%showspecialspaceinfo("All")%>
 			<%
 			else
 				response.write "<br><li>本功能已经被关闭"
 			end if
 			%>
 			</blockquote> 		</font>	
 					</td>
 				</tr>
 			</table>		
 		</td> 		

