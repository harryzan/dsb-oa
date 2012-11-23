<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!-- #include file="chkuser.asp" -->
<!-- #include file="inc/char.asp" -->
<!--#include file="inc/recycle_list.asp"-->
<!--#include file="inc/theme.asp"-->
<%
    	Rem ----------------------
    	Rem ------主程序开始------
    	Rem ----------------------
   	dim username
   	dim bBoardEmpty
	dim totalrec
	dim n,RowCount
	dim p
	dim currentpage,page_count,Pcount
	dim arrRow1

	stats="论坛回收站"
	if founderr then
		call nav()
		call headline(1)
		call error()
	else
    	call chkInput()
		if founderr then
			call nav()
			call headline(1)
			call error()
		else
			call nav()
			call headline(1)
			call boardtop()
			call AnnounceList1()
			call listPages3()
			if founderr=true then call error()
		end if
	end if
	call endline()
	REM 显示版面信息---Headinfo
	sub boardtop()

	response.write "<style>TABLE {BORDER-TOP: 0px; BORDER-LEFT: 0px; BORDER-BOTTOM: 1px; }TD {BORDER-RIGHT: 0px; BORDER-TOP: 0px; color: #000000; }</style>"

	response.write "<script language=javascript src=inc/list.js></script>"

response.write "<br><table cellpadding=0 cellspacing=0 border=0 width="&tablewidth&" align=center><tr>"&_
			"<td align=center width=2 valign=middle> </td>"&_
			"<td align=left valign=middle> <font color="&TableContentColor&">本页面只有系统管理员可进行操作</font></td>"&_
			"<td align=right> </td></tr></table>"
	end sub


    
	sub chkInput
		'on error resume next
        	currentPage=request("page")
		if currentpage="" or not isInteger(currentpage) then
			currentpage=1
		else
			currentpage=clng(currentpage)
			if err then
				currentpage=1
				err.clear
			end if
		end if
	end sub

%>
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
<!--#include file="footer.asp"-->
