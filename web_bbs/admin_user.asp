<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!--#include file=inc/char.asp-->
<!--#include file=chkuser.asp-->
<title><%=ForumName%>--����ҳ��</title>
<!--#include file="Forum_css.asp"-->
<BODY <%=ForumBody%>>
<%
	if not master or instr(session("flag"),"11")=0 then
		Errmsg=Errmsg+"<br>"+"<li>��ҳ��Ϊ����Աר�ã���<a href=admin_index.asp target=_top>��½</a>����롣<br><li>��û�й���ҳ���Ȩ�ޡ�"
		call Error()
	else
%>
<table cellpadding=0 cellspacing=0 border=0 width=<%=tablewidth%> bgcolor=<%=tablebackcolor%> align=center>
  <tr>
    <td>
      <table cellpadding=3 cellspacing=1 border=0 width=100%>
        <tr bgcolor='<%=Tabletitlecolor%>'>
        <td><font color="<%=TablefontColor%>">��ӭ<b>
<%=membername%></b>�������ҳ��</font>
        </td>
        </tr>
            <tr bgcolor=<%=tablebodycolor%>>
              <td width="100%" valign=top>
<font color="<%=TableContentColor%>">
              <%
   	dim totalPut   
   	dim CurrentPage
   	dim TotalPages
   	dim j
   	dim idlist
   	dim title
	dim sel
	
	if request("sel")="" then
	sel=0
	else
    sel=request("sel")
	end if

	title=CheckStr(request("txtitle"))

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
%>
        <div align="center">      <font color=red>����û���������Ӧ����</font> </div>
            <table width="100%" border="0" cellspacing="1" cellpadding="3" align="center">
              <tr><form name="searchuser" method="POST" action="admin_user.asp">

                
                  <td width="67%" align="right" valign="bottom"> �û���������: 
                    <input type="text" name="txtitle" size="13" class="buttonface">  ��������: 
                    <select name="sel" class="buttonface">
                      <option value="0" <% if sel=0 then %>selected<% end if %>>�����û�</option>
                      <option value="1" <% if sel=1 then %>selected<% end if %>>�����û�</option>
                      <option value="2" <% if sel=2 then %>selected<% end if %>>�����û�</option>
                      <option value="3" <% if sel=3 then %>selected<% end if %>>�����û�</option>
                      <option value="4" <% if sel=4 then %>selected<% end if %>>���</option>
                      <option value="5" <% if sel=5 then %>selected<% end if %>>��½����10��</option>
                      <option value="6" <% if sel=6 then %>selected<% end if %>>��½���</option>
                      <option value="7" <% if sel=7 then %>selected<% end if %>>�Ƹ����</option>
                      <option value="8" <% if sel=8 then %>selected<% end if %>>��������10��</option>
                      <option value="9" <% if sel=9 then %>selected<% end if %>>�������</option>
                    </select>
                    <input type="submit" value="��ʼ��������" name="title" class="buttonface">
                  </td>
                </form>
              </tr>
            </table>
            
              <form method=Post action="admin_user.asp?sel=<%=sel%>">
<%
	dim usernum
	dim topnum
	set rs=conn.execute("select usernum from config where active=1")
	usernum=rs(0)
	if title<>"" then
	sql="select userid,username,logins,article,userwealth,userep,usercp from [user] where username='"&trim(title)&"' order by userid desc"

	else

	if currentpage=1 then
		topnum=" top "&MaxAnnouncePerpage&" "
	else
		topnum=""
	end if
	select case sel
	   case 0
	   sql="select "&topnum&" userid,username,logins,article,userwealth,userep,usercp,lockuser from [user] order by userid desc"
	   case 1
	   sql="select userid,username,logins,article,userwealth,userep,usercp,lockuser from [user] where lockuser=1 order by userid desc"
	   case 2
	   sql="select userid,username,logins,article,userwealth,userep,usercp,lockuser from [user] where lockuser=3 order by userid desc"
	   case 3
           sql="select userid,username,logins,article,userwealth,userep,usercp,lockuser from [user] where lockuser=2 order by userid desc"
	   case 4
           sql="select userid,username,logins,article,userwealth,userep,usercp,lockuser from [user] where userclass=18 order by userid desc"
	   case 5
	   sql="select userid,username,logins,article,userwealth,userep,usercp,lockuser from [user] where logins<=10 order by userid asc"
	   case 6
	   sql="select "&topnum&"  userid,username,logins,article,userwealth,userep,usercp,lockuser from [user] order by logins desc"
	   case 7
	   sql="select "&topnum&"  userid,username,logins,article,userwealth,userep,usercp,lockuser from [user] order by userwealth desc"
	   case 8
	   sql="select userid,username,logins,article,userwealth,userep,usercp,lockuser from [user] where article<=10 order by userid asc"
	   case 9
	   sql="select "&topnum&"  userid,username,logins,article,userwealth,userep,usercp,lockuser from [user] order by article desc"
	end select
	end if
	Set rs= Server.CreateObject("ADODB.Recordset")
	'response.write sql
	rs.open sql,conn,1,1

  	if rs.eof and rs.bof then
       		response.write "<p align='center'> �� û �� �� �� �� �� </p>"
   	else
		if currentpage=1 and (sel=0 or sel=6 or sel=7 or sel=9) then
		totalput=usernum
		else
      		totalPut=rs.recordcount 
		end if
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
            		showpage totalput,MaxAnnouncePerPage,"admin_user.asp" 
       		else 
          		if (currentPage-1)*MaxAnnouncePerPage<totalPut then 
            			rs.move  (currentPage-1)*MaxAnnouncePerPage
            			dim bookmark 
            			bookmark=rs.bookmark  
            			showContent 
             			showpage totalput,MaxAnnouncePerPage,"admin_user.asp" 
        		else 
	        		currentPage=1 
           			showContent 
           			showpage totalput,MaxAnnouncePerPage,"admin_user.asp" 
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
              <table border="0" cellspacing="0" width="100%"  cellpadding="0" align="center">
                <tr> 
                  <td width="11%" align="center" bgcolor="<%=aTabletitlecolor%>" height="20"><strong>ID��</strong></td>
                  <td width="29%" align="center" bgcolor="<%=aTabletitlecolor%>"><strong>�û���</strong></td>
                  <td align="center" bgcolor="<%=aTabletitlecolor%>" width="14%"><b>��½����</b></td>
                  <td align="center" bgcolor="<%=aTabletitlecolor%>" width="15%"><b>������</b></td>
                  <td align="center" bgcolor="<%=aTabletitlecolor%>" width="13%"><b>�ܲƸ�</b></td>
              
                  <td width="10%" align="center" bgcolor="<%=aTabletitlecolor%>"> 
                    <input type='submit'  value='ɾ��' class="buttonface" name="submit">
                  </td>
                </tr>
                <%do while not rs.eof%>
                <tr> 
                  <td height="23" width="11%"> 
                    <p align="center"><%=rs("userid")%> 
                  </td>
                  <td width="29%"> 
                    <p align="center"><a href="admin_modiuser.asp?name=<%=htmlencode(rs("username"))%>"><%=htmlencode(rs("username"))%></a> 
                  </td>
                  <td width="14%"> 
                    <div align="center"><%=rs("logins")%></div>
                  </td>
                  <td width="15%"> 
                    <div align="center"><%=rs("article")%></div>
                  </td>
                  <td width="13%"> 
                    <div align="center"><%=rs("userwealth")+rs("userep")+rs("usercp")%></div>
                  </td>
                 
                  <td width="10%"> 
                    <p align="center"> 
                      
                      <input type='checkbox' name='selAnnounce' value='<%=cstr(rs("userID"))%>'>
                  </td>
                </tr>
                <% 
	i=i+1
	if i>=MaxAnnouncePerPage then exit do
	rs.movenext
	loop
%>
              </table>
            </form>
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
    response.write "��ҳ ��һҳ&nbsp;"
  else
    response.write "<a href="&filename&"?page=1&txtitle="&request("txtitle")&"&sel="&sel&">��ҳ</a>&nbsp;"
    response.write "<a href="&filename&"?page="&CurrentPage-1&"&txtitle="&request("txtitle")&"&sel="&sel&">��һҳ</a>&nbsp;"
  end if
  if n-currentpage<1 then
    response.write "��һҳ βҳ"
  else
    response.write "<a href="&filename&"?page="&(CurrentPage+1)&"&txtitle="&request("txtitle")&"&sel="&sel&">"
    response.write "��һҳ</a> <a href="&filename&"?page="&n&"&txtitle="&request("txtitle")&"&sel="&sel&">βҳ</a>"
  end if
   response.write "&nbsp;ҳ�Σ�</font><strong><font color=red>"&CurrentPage&"</font>/"&n&"</strong>ҳ "
    response.write "&nbsp;��<b>"&totalnumber&"</b>���û� <b>"&MaxAnnouncePerPage&"</b>���û�/ҳ "
       
end function

  sub deleteannounce(id)
    dim rs,sql
    set rs=server.createobject("adodb.recordset")
if request("submit")="ɾ��" then
    sql="delete from [user] where userid="&cstr(id)
    if err.Number<>0 then
	err.clear
	response.write "ɾ �� ʧ �� !<br>"
    else
        response.write "�û�"&cstr(id)&"��ɾ���ˣ�<br>"
    end if
  else
   sql="update [user] set lockuser=0 where userid="&cstr(id)
       response.write "�û�"&cstr(id)&"����׼��Ϊ��Ա��<br>"
   end if
   conn.execute sql

  End sub
%>
	      </td>
            </tr>
        </table>
        </td>
    </tr>
</table>
<%end if%>