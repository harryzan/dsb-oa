<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!-- #include file="inc/char.asp" -->
<!-- #include file="chkuser.asp" -->
<script>
if (top.location==self.location){
	top.location="index.asp"
}
</script>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<!--#include file="forum_css.asp"-->
</head>

<body bgcolor=<%=Tablebodycolor%> text="#000000" leftmargin="0" topmargin="0">
<form name="form" method="post" action="saveannouce_upfile.asp?boardid=<%=request("boardid")%>" enctype="multipart/form-data" >
<input type="hidden" name="filepath" value="<%=UpLoadPath%>">
<input type="hidden" name="act" value="upload">
图片
<input type="file" name="file1" size=10>
<input type="submit" name="Submit" value="上传" onclick="parent.document.forms[0].Submit.disabled=true,
parent.document.forms[0].Submit2.disabled=true;"> 类型：gif，jpg，限制：<%=uploadsize%>K
</form>
</body>
</html>
<%
conn.close
set conn=nothing
%>
