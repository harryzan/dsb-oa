<!--#include file="conn.asp"-->
<!--#include file="inc/char.asp" -->
<!-- #include file="inc/const.asp" -->
<!-- #include file="chkuser.asp" -->
<!--#include file="inc/theme.asp"-->
<%
	'on error resume next
	dim currentpage,page_count,Pcount
	dim totalrec,endpage
	dim stype,pSearch,nSearch,keyword
	dim searchboard,ordername
	dim searchdate,searchDateLimit,searchday
	stats="搜索结果"
	stype=request("stype")
	pSearch=request("pSearch")
	nSearch=request("nSearch")
	keyword=trim(checkStr(request("keyword")))
	boardid=request("boardid")
	if isempty(request("page")) or isNull(request("page")) or (request("page")="")  then
		currentPage=1
	else
		if isInteger(request("page")) then
			currentPage=cint(request("page"))
        	else
			currentPage=1
        	end if
        	if err.number<>0 then 
			err.clear
            		currentPage=1
        	end if
	end if
	if stype<3 then
	if not isInteger(boardid)  then
		Errmsg=Errmsg+"<br>"+"<li>版面id必须是整数。"
		founderr=true
	end if
	if keyword="" then
		Errmsg=Errmsg+"<br>"+"<li>必须输入查询关键字。"
		founderr=true
	end if

	'搜索多少天内帖子
	searchDateLimit=180
	if request("SearchDate")="ALL" then
	searchday=" "
	else
	if not isInteger(request("SearchDate"))  then
		Errmsg=Errmsg+"<br>"+"<li>搜索多少天必须是整数。"
		founderr=true
	else
	searchday=" datediff('d',dateandtime,Now()) < "&request("SearchDate")&" and "
	end if
	end if
	if cint(boardid)<1 then
	searchboard=""
	else
	searchboard=" boardid="&boardid&" and "
	end if
	end if
	if boardid="" or isnull(boardid) then boardid=0
	'response.write boardid
	'response.end
	call nav()
	call headline(1)
	if founderr then
		call error()
	else
		call search()
		if founderr then call error()
	end if
	call endline()
	sub search()
	sql=""
	set rs=server.createobject("adodb.recordset")
	select case stype
	case 1
		select case nSearch
		'搜索主题帖子作者
		case 1
		sql="select top 1000 locktopic,boardid,rootid,announceid,body,Expression,topic,username,child,hits,dateandtime from bbs1 where username='"&keyword&"' and "&searchboard&" "&searchday&" parentid=0 ORDER BY announceID desc"
		ordername="搜索主题作者帖子"
		'搜索回复帖子作者
		case 2
		sql="select top 1000 locktopic,boardid,rootid,announceid,body,Expression,topic,username,child,hits,dateandtime from bbs1 where username='"&keyword&"' and "&searchboard&" "&searchday&" parentid>0 ORDER BY announceID desc"
		ordername="搜索回复作者帖子"
		'两者都搜索
		case 3
		sql="select top 1000  locktopic,boardid,rootid,announceid,body,Expression,topic,username,child,hits,dateandtime from bbs1 where  "&searchboard&" "&searchday&" username='"&keyword&"' ORDER BY announceID desc"
		ordername="搜索主题和回复作者帖子"
		end select
	case 2
		select case pSearch
		'搜索主题关键字
		case 1
		sql="select top 1000 locktopic,boardid,rootid,announceid,body,Expression,topic,username,child,hits,dateandtime from bbs1 where  "&searchboard&" "&searchday&" (" & translate(keyword,"topic") & ") ORDER BY announceID desc"
		'搜索内容关键字
		ordername="搜索主题"
		case 2
		sql="select top 1000  locktopic,boardid,rootid,announceid,body,Expression,topic,username,child,hits,dateandtime from bbs1 where   "&searchboard&" "&searchday&" (" & translate(keyword,"body") & ") ORDER BY announceID desc"
		'两者都搜索
		ordername="搜索内容"
		case 3
		sql="select top 1000  locktopic,boardid,rootid,announceid,body,Expression,topic,username,child,hits,dateandtime from bbs1 where   "&searchboard&" "&searchday&" (" & translate(keyword,"topic") & " or " & translate(keyword,"body") & ") ORDER BY announceID desc"
		ordername="搜索主题和内容"
		end select
	case 3
		sql="select top 50  locktopic,boardid,rootid,announceid,body,Expression,topic,username,child,hits,dateandtime from bbs1 ORDER BY announceID desc"
		ordername="最新50帖"
	end select
	'response.write sql
	if sql="" then
		Errmsg=Errmsg+"<br>"+"<li>请指定查询条件。"
		founderr=true
		exit sub
	end if
	rs.open sql,conn,1,1

	if err.number<>0 then 
		Errmsg=Errmsg+"<br>"+"<li>数据库出错，查询失败。"
		founderr=true
	else
		if rs.eof and rs.bof then
		Errmsg=Errmsg+"<br>"+"<li>没有找到您要查询的内容。"
		founderr=true
		else
			rs.PageSize = MaxAnnouncePerpage
			rs.AbsolutePage=currentpage
			page_count=0
      			totalrec=rs.recordcount
           		call searchinfo()
			call listPages3()
		end if
	end if
	set rs=nothing
	end sub

	sub searchinfo()
%>
            <table cellpadding=0 cellspacing=0 border=0 width="<%=tablewidth%>" align=center>
            <tr><td><font color="<%=bodyfontColor%>">查询<%=searchDate%>天内的帖子，<%=ordername%>
<%if totalrec>=1000 then%>
最多只能查询到<font color=<%=AlertFontColor%>>1000</font>条纪录，更多的就不显示了
<%else%>共查询到
<font color=<%=AlertFontColor%>><%=totalrec%></font>个结果</font>
<%end if%>
		</td>
            </tr>
            </table>
            <table cellpadding=0 cellspacing=0 border=0 width="<%=tablewidth%>" bgcolor=<%=Tablebackcolor%> align=center>
            <tr><td height=1>
		</td>
            </tr>
            </table>
<TABLE bgColor="<%=Tablebackcolor%>" border=0 cellPadding=0 cellSpacing=0 width="<%=tablewidth%>" align=center>
  <TBODY>
  <TR>
    <td bgcolor=<%=Tablebackcolor%> valign=middle width=1></td>
    <TD align=middle height=25 bgColor="<%=Tabletitlecolor%>" width=32><font color=<%=TableFontcolor%>>状态</font></TD> 
    <td bgcolor=<%=Tablebackcolor%> valign=middle width=1></td>
    <TD align=middle bgColor="<%=Tabletitlecolor%>" width=*><font color=<%=TableFontcolor%>>主 题  (点心情符为开新窗浏览)</font></TD> 
    <td bgcolor=<%=Tablebackcolor%> valign=middle width=1></td>
    <TD align=middle bgColor="<%=Tabletitlecolor%>" width=80><font color=<%=TableFontcolor%>>作 者 </font></TD> 
    <td bgcolor=<%=Tablebackcolor%> valign=middle width=1></td>
    <TD align=middle bgColor="<%=Tabletitlecolor%>" width=64><font color=<%=TableFontcolor%>>回复/人气</font></TD>
    <td bgcolor=<%=Tablebackcolor%> valign=middle width=1></td> 
    <TD align=middle bgColor="<%=Tabletitlecolor%>" width=195><font color=<%=TableFontcolor%>>作者 | 发表时间</font></TD>
    <td bgcolor=<%=Tablebackcolor%> valign=middle width=1></td></TR> 
</TBODY></TABLE>
            <table cellpadding=0 cellspacing=0 border=0 width="<%=tablewidth%>" bgcolor=<%=Tablebackcolor%> align=center>
            <tr><td height=1>
		</td>
            </tr>
            </table>
<%
       while (not rs.eof) and (not page_count = rs.PageSize)
%>
<TABLE bgColor="<%=Tablebackcolor%>" border=0 cellPadding=0 cellSpacing=0 width="<%=tablewidth%>" align=center>
  <TBODY>
  <TR> 
    <td bgcolor=<%=Tablebackcolor%> valign=middle width=1 height=24></td>
    <TD align=middle bgColor="<%=Tablebodycolor%>" width=32><font color=<%=TableContentcolor%>>
<%if rs("locktopic")=1 then%><img src=<%=picurl%>lockfolder.gif alt="本主题已锁定"><%else%><%if rs("child")>=10 then%><img src=<%=picurl%>hotfolder.gif><%else%><img src=<%=picurl%>folder.gif><%end if%><%end if%></font>
    </TD> 
    <td bgcolor=<%=Tablebackcolor%> valign=middle width=1></td>
    <TD bgColor=<%=Tablebodycolor%> width=*><font color=<%=TableContentcolor%>><a href='dispbbs.asp?boardID=<%=rs("boardID")%>&RootID=<%=rs("RootID")%>&ID=<%=rs("announceID")%>&skin=1' target=_blank><img src='<%=faceurl%><%if instr(rs("Expression"),facename)>0 then%><%=rs("Expression")%><%else%>face1.gif<%end if%>' border=0 alt="开新窗口浏览此主题"></a> <a href='dispbbs.asp?boardID=<%=rs("boardID")%>&RootID=<%=rs("RootID")%>&ID=<%=rs("announceID")%>'><%if rs("topic")="" then%><%=left(htmlencode(replace(rs("body"),chr(10)," ")),26)%>...<%else%><%=htmlencode(rs("topic"))%><%end if%></a></font>    </TD> 
    <td bgcolor=<%=Tablebackcolor%> valign=middle width=1></td>
    <TD align=middle bgColor="<%=Tablebodycolor%>"  width=80><font color=<%=TableContentcolor%>><a href="dispuser.asp?name=<%=htmlencode(rs("username"))%>"><%=htmlencode(rs("username"))%></a></font></TD> 
    <td bgcolor=<%=Tablebackcolor%> valign=middle width=1></td>
    <TD align=middle bgColor="<%=Tablebodycolor%>" width=64><font color=<%=TableContentcolor%>><%=rs("child")%>/<%=rs("hits")%></font></TD> 
    <td bgcolor=<%=Tablebackcolor%> valign=middle width=1></td>
    <TD bgColor=<%=Tablebodycolor%> width=195><font color=<%=TableContentcolor%>>&nbsp;
<%=FormatDateTime(rs("dateandtime"),2)%>&nbsp;<%=FormatDateTime(rs("dateandtime"),4)%>
&nbsp;<font color="<%=alertfontcolor%>">|</font>&nbsp;
<a href="javascript:openScript('dispuser.asp?name=<%=htmlencode(rs("username"))%>',350,300)"><%=htmlencode(rs("username"))%></a>
</FONT></TD>
    <td bgcolor=<%=Tablebackcolor%> valign=middle width=1></td></TR> 
</TBODY></TABLE>
            <table cellpadding=0 cellspacing=0 border=0 width="<%=tablewidth%>" bgcolor=<%=Tablebackcolor%>  align=center>
            <tr><td height=1>
		</td>
            </tr>
            </table>
<%
	  page_count = page_count + 1
          rs.movenext
        wend
	end sub

	sub listPages3()

	Pcount=rs.PageCount
	response.write "<table border=0 cellpadding=0 cellspacing=3 width="""&tablewidth&""" align=center>"&_
			"<tr><td valign=middle nowrap>"&_
			"<font color="&bodyfontcolor&">页次：<b>"&currentpage&"</b>/<b>"&Pcount&"</b>页"&_
			"每页<b>"&MaxAnnouncePerpage&"</b> 帖子数<b>"&totalrec&"</b></font></td>"&_
			"<td valign=middle nowrap><font color="&bodyfontcolor&"><div align=right><p>分页： "

	if currentpage > 4 then
	response.write "<a href=""?page=1&stype="&stype&"&pSearch="&pSearch&"&nSearch="&nSearch&"&keyword="&keyword&"&SearchDate="&request("SearchDate")&"&boardid="&boardid&""">[1]</a> ..."
	end if
	if Pcount>currentpage+3 then
	endpage=currentpage+3
	else
	endpage=Pcount
	end if
	for i=currentpage-3 to endpage
	if not i<1 then
		if i = clng(currentpage) then
        response.write " <font color="&AlertFontColor&">["&i&"]</font>"
		else
        response.write " <a href=""?page="&i&"&stype="&stype&"&pSearch="&pSearch&"&nSearch="&nSearch&"&keyword="&keyword&"&SearchDate="&request("SearchDate")&"&boardid="&boardid&""">["&i&"]</a>"
		end if
	end if
	next
	if currentpage+3 < Pcount then 
	response.write "... <a href=""?page="&Pcount&"&stype="&stype&"&pSearch="&pSearch&"&nSearch="&nSearch&"&keyword="&keyword&"&SearchDate="&request("SearchDate")&"&boardid="&boardid&""">["&Pcount&"]</a>"
	end if
	response.write "</p></div></font></td></tr></table>"
	rs.close
	set rs=nothing
	end sub

public function translate(sourceStr,fieldStr)
rem 处理逻辑表达式的转化问题
  dim  sourceList
  dim resultStr
  dim i,j
  if instr(sourceStr," ")>0 then 
     dim isOperator
     isOperator = true
     sourceList=split(sourceStr)
     '--------------------------------------------------------
     rem Response.Write "num:" & cstr(ubound(sourceList)) & "<br>"
     for i = 0 to ubound(sourceList)
        rem Response.Write i 
    Select Case ucase(sourceList(i))
    Case "AND","&","和","与"
        resultStr=resultStr & " and "
        isOperator = true
    Case "OR","|","或"
        resultStr=resultStr & " or "
        isOperator = true
    Case "NOT","!","非","！","！"
        resultStr=resultStr & " not "
        isOperator = true
    Case "(","（","（"
        resultStr=resultStr & " ( "
        isOperator = true
    Case ")","）","）"
        resultStr=resultStr & " ) "
        isOperator = true
    Case Else
        if sourceList(i)<>"" then
            if not isOperator then resultStr=resultStr & " and "
            if inStr(sourceList(i),"%") > 0 then
                resultStr=resultStr&" "&fieldStr& " like '" & replace(sourceList(i),"'","''") & "' "
            else
                resultStr=resultStr&" "&fieldStr& " like '%" & replace(sourceList(i),"'","''") & "%' "
            end if
                isOperator=false
        End if    
    End Select
        rem Response.write resultStr+"<br>"
     next 
     translate=resultStr
  else '单条件
     if inStr(sourcestr,"%") > 0 then
         translate=" " & fieldStr & " like '" & replace(sourceStr,"'","''") &"' "
     else
    translate=" " & fieldStr & " like '%" & replace(sourceStr,"'","''") &"%' "
     End if
     rem 前后各加一个空格，免得连sql时忘了加，而出错。
  end if  
end function
%>
<!--#include file="footer.asp"-->