<%
   function isInteger(para)
       on error resume next
       dim str
       dim l,i
       if isNUll(para) then 
          isInteger=false
          exit function
       end if
       str=cstr(para)
       if trim(str)="" then
          isInteger=false
          exit function
       end if
       l=len(str)
       for i=1 to l
           if mid(str,i,1)>"9" or mid(str,i,1)<"0" then
              isInteger=false 
              exit function
           end if
       next
       isInteger=true
       if err.number<>0 then err.clear
   end function
sub error()
%><br>
    <table cellpadding=0 cellspacing=0 border=0 width=95% bgcolor=<%=atablebackcolor%> align=center>
        <tr>
            <td>
                <table cellpadding=3 cellspacing=1 border=0 width=100%>
    <tr align="center"> 
      <td width="100%" bgcolor=<%=atabletitlecolor%>><b>��̳������Ϣ</b></td>
    </tr>
    <tr> 
      <td width="100%" bgcolor=<%=atablebodycolor%>><b>��������Ŀ���ԭ��</b><br><br>
<li>���Ƿ���ϸ�Ķ���<a href=help.asp>�����ļ�</a>
<%=errmsg%>
      </td>
    </tr>
    <tr align="center"> 
      <td width="100%" bgcolor=<%=atabletitlecolor%>>
<a href="javascript:history.go(-1)"> << ������һҳ</a>
      </td>
    </tr>  
    </table>   </td></tr></table>
<%
end sub
function browser(info)
    if Instr(info,"NetCaptor 6.5.0")>0 then
        browser="� �� ����NetCaptor 6.5.0"
    elseif Instr(info,"MyIe 3.1")>0 then
        browser="� �� ����MyIe 3.1"
    elseif Instr(info,"NetCaptor 6.5.0RC1")>0 then
        browser="� �� ����NetCaptor 6.5.0RC1"
    elseif Instr(info,"NetCaptor 6.5.PB1")>0 then
        browser="� �� ����NetCaptor 6.5.PB1"
    elseif Instr(info,"MSIE 5.5")>0 then
        browser="� �� ����Internet Explorer 5.5"
    elseif Instr(info,"MSIE 6.0")>0 then
        browser="� �� ����Internet Explorer 6.0"
    elseif Instr(info,"MSIE 6.0b")>0 then
        browser="� �� ����Internet Explorer 6.0b"
    elseif Instr(info,"MSIE 5.01")>0 then
        browser="� �� ����Internet Explorer 5.01"
    elseif Instr(info,"MSIE 5.0")>0 then
        browser="� �� ����Internet Explorer 5.00"
    elseif Instr(info,"MSIE 4.0")>0 then
        browser="� �� ����Internet Explorer 4.01"
    else
        browser="� �� ����δ֪"
    end if
end function
function system(info)
    if Instr(info,"NT 5.1")>0 then
        system=system+"����ϵͳ��Windows XP"
    elseif Instr(info,"Tel")>0 then
        system=system+"����ϵͳ��Telport"
		    elseif Instr(info,"webzip")>0 then
        system=system+"����ϵͳ��webzip"
		    elseif Instr(info,"flashget")>0 then
        system=system+"����ϵͳ��flashget"
		    elseif Instr(info,"offline")>0 then
        system=system+"����ϵͳ��offline"
    elseif Instr(info,"NT 5")>0 then
        system=system+"����ϵͳ��Windows 2000"
    elseif Instr(info,"NT 4")>0 then
        system=system+"����ϵͳ��Windows NT4"
    elseif Instr(info,"98")>0 then
        system=system+"����ϵͳ��Windows 98"
    elseif Instr(info,"95")>0 then
        system=system+"����ϵͳ��Windows 95"
    else
        system=system+"����ϵͳ��δ֪"
    end if
end function

function DateToStr(dtDateTime)
    DateToStr = year(dtDateTime) & doublenum(Month(dtdateTime)) & doublenum(Day(dtdateTime)) & doublenum(Hour(dtdateTime)) & doublenum(Minute(dtdateTime)) & doublenum(Second(dtdateTime)) & ""
end function
function doublenum(fNum)
    if fNum > 9 then 
        doublenum = fNum 
    else 
        doublenum = "0" & fNum
    end if
end function

function HTMLEncode(fString)
if not isnull(fString) then
    fString = replace(fString, ">", "&gt;")
    fString = replace(fString, "<", "&lt;")

    fString = Replace(fString, CHR(32), "&nbsp;")
    fString = Replace(fString, CHR(34), "&quot;")
    fString = Replace(fString, CHR(39), "&#39;")
    fString = Replace(fString, CHR(13), "")
    fString = Replace(fString, CHR(10) & CHR(10), "</P><P> ")
    fString = Replace(fString, CHR(10), "<BR> ")
    HTMLEncode = fString
end if
end function
'�û���Դ
function address(sip)
	if isnumeric(left(sip,2)) then
	set iprs=server.createobject("adodb.recordset")
	if sip="127.0.0.1" then sip="192.168.0.1"
	str1=left(sip,instr(sip,".")-1)
	sip=mid(sip,instr(sip,".")+1)
	str2=left(sip,instr(sip,".")-1)
	sip=mid(sip,instr(sip,".")+1)
	str3=left(sip,instr(sip,".")-1)
	str4=mid(sip,instr(sip,".")+1)
	if isNumeric(str1)=0 or isNumeric(str2)=0 or isNumeric(str3)=0 or isNumeric(str4)=0 then

	else
    num=cint(str1)*256*256*256+cint(str2)*256*256+cint(str3)*256+cint(str4)-1
	ipsql="select Top 1 country,city from address where ip1 <="&num&" and ip2 >="&num&""
	iprs.open ipsql,conn,1,1
		if iprs.eof and iprs.bof then 
		country="����"
		city=""
		else
		country=iprs("country")
		city=iprs("city")
		end if
	iprs.close
	set iprs=nothing
	end if
	address=country&city
	else
	address="δ֪"
	end if
end function
	dim UserAgent
	UserAgent=Trim(Request.Servervariables("HTTP_USER_AGENT"))
	If Instr(UserAgent,"Teleport")>0 or Instr(UserAgent,"WebZIP")>0 or Instr(UserAgent,"flashget")>0 or Instr(UserAgent,"offline")>0 or Instr(UserAgent,"googlebot")>0 Then
		'Errmsg=Errmsg+"<br>"+"<li>�Ƿ�����������벻Ҫʹ��Teleport��WebZip����������ر�վ��</li>"
			'Founderr=true
			'call error()
response.redirect "error.htm"
        response.end
	end if
%>