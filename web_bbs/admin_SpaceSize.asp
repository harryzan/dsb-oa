<!--#include file =conn.asp-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=chkuser.asp-->
<title><%=ForumName%>--����ҳ��</title>
<!--#include file="Forum_css.asp"-->
<meta NAME=GENERATOR Content=""Microsoft FrontPage 3.0"" CHARSET=GB2312>
<BODY <%=ForumBody%>>
<%
	if not master or instr(session("flag"),"35")=0 then
		Errmsg=Errmsg+"<br>"+"<li>��ҳ��Ϊ����Աר�ã���<a href=admin_index.asp target=_top>��½</a>����롣<br><li>��û�й���ҳ���Ȩ�ޡ�"
		call Error()
	
	end if


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
  					&nbsp;&nbsp;ϵͳ�ռ�ռ�����</font>
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
 			��������ռ�ÿռ䣺&nbsp;<img src="pic/bar1.gif" width=<%=drawbar("data")%> height=10>&nbsp;<%showSpaceinfo("data")%><br><br>
 			��������ռ�ÿռ䣺&nbsp;<img src="pic/bar1.gif" width=<%=drawbar("databackup")%> height=10>&nbsp;<%showSpaceinfo("databackup")%><br><br>
 			�����ļ�ռ�ÿռ䣺&nbsp;<img src="pic/bar1.gif" width=<%=drawspecialbar%> height=10>&nbsp;<%showSpecialSpaceinfo("Program")%><br><br>
 			����ͼƬռ�ÿռ䣺&nbsp;<img src="pic/bar1.gif" width=<%=drawbar("images")%> height=10>&nbsp;<%showSpaceinfo("face")%><br><br>
 			ϵͳͼƬռ�ÿռ䣺&nbsp;<img src="pic/bar1.gif" width=<%=drawbar("pic")%> height=10>&nbsp;<%showSpaceinfo("pic")%><br><br>
 			�ϴ�ͷ��ռ�ÿռ䣺&nbsp;<img src="pic/bar1.gif" width=<%=drawbar("uploadFace")%> height=10>&nbsp;<%showSpaceinfo("uploadFace")%><br><br>
 			�ϴ�ͼƬռ�ÿռ䣺&nbsp;<img src="pic/bar1.gif" width=<%=drawbar("uploadImages")%> height=10>&nbsp;<%showSpaceinfo("uploadImages")%><br><br>	
 			ϵͳռ�ÿռ��ܼƣ�<br><img src="pic/bar1.gif" width=400 height=10> <%showspecialspaceinfo("All")%>
 			<%
 			else
 				response.write "<br><li>�������Ѿ����ر�"
 			end if
 			%>
 			</blockquote> 		</font>	
 					</td>
 				</tr>
 			</table>		
 		</td> 		

