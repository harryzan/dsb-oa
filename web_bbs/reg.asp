<!--#include file="conn.asp"-->
<!-- #include file="inc/const.asp" -->
<!--#include file="inc/char.asp"-->
<!-- #include file="chkuser.asp" -->
<!--#include file="inc/theme.asp"-->
<%
	Errmsg=Errmsg+"<br>"+"<li>系统不支持用户自行注册，请联系系统管理员。</li>"
	Founderr=true
	call error()
	response.end
	
	stats="用户注册"
	call nav()
	call headline(1)
	call main()
	call endline()
%>
<%sub main()%>
    <table cellpadding=6 cellspacing=1 border=0 width=<%=tablewidth%> align=center>
    
    <tr>
    <td bgcolor=<%=TableTitlecolor%> align=center><font color="<%=TablefontColor%>">
    <form action="reg_1.asp" method="post">
    <b>服务条款和声明</b></font>
    </td>
    </tr>
    <td bgcolor=<%=tablebodycolor%> align=left>
<font color=<%=tablecontentcolor%>>
     <b>继续注册前请先阅读论坛协议</b><p>
欢迎您加入本站点参加交流和讨论，本站点为公共论坛，为维护网上公共秩序和社会稳定，请您自觉遵守以下条款：<BR><BR>
一、不得利用本站危害国家安全、泄露国家秘密，不得侵犯国家社会集体的和公民的合法权益，不得利用本站制作、复制和传播下列信息： <BR>
　（一）煽动抗拒、破坏宪法和法律、行政法规实施的；<BR>
　（二）煽动颠覆国家政权，推翻社会主义制度的；<BR>
　（三）煽动分裂国家、破坏国家统一的；<BR>
　（四）煽动民族仇恨、民族歧视，破坏民族团结的；<BR>
　（五）捏造或者歪曲事实，散布谣言，扰乱社会秩序的；<BR>
　（六）宣扬封建迷信、淫秽、色情、赌博、暴力、凶杀、恐怖、教唆犯罪的；<BR>
　（七）公然侮辱他人或者捏造事实诽谤他人的，或者进行其他恶意攻击的；<BR>
　（八）损害国家机关信誉的；<BR>
　（九）其他违反宪法和法律行政法规的；<BR>
　（十）进行商业广告行为的。<BR>
二、互相尊重，对自己的言论和行为负责。 <BR>
<p></font>
    </td>
    </tr>
    <tr>
    <td bgcolor=<%=TableTitlecolor%> align=center>
    <center><input type="submit" value="我同意"></center>
    </td></form></tr></table>
    </td></tr></table>
<%end sub%>
<!--#include file="footer.asp"-->
