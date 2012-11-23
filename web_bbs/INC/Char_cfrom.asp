<%
Rem ==========论坛首页函数=========
Rem 判断用户浏览器
function browser(info)
    if Instr(info,"NetCaptor 6.5.0")>0 then
        browser="浏 览 器：NetCaptor 6.5.0"
    elseif Instr(info,"MyIe 3.1")>0 then
        browser="浏 览 器：MyIe 3.1"
    elseif Instr(info,"NetCaptor 6.5.0RC1")>0 then
        browser="浏 览 器：NetCaptor 6.5.0RC1"
    elseif Instr(info,"NetCaptor 6.5.PB1")>0 then
        browser="浏 览 器：NetCaptor 6.5.PB1"
    elseif Instr(info,"MSIE 5.5")>0 then
        browser="浏 览 器：Internet Explorer 5.5"
    elseif Instr(info,"MSIE 6.0")>0 then
        browser="浏 览 器：Internet Explorer 6.0"
    elseif Instr(info,"MSIE 6.0b")>0 then
        browser="浏 览 器：Internet Explorer 6.0b"
    elseif Instr(info,"MSIE 5.01")>0 then
        browser="浏 览 器：Internet Explorer 5.01"
    elseif Instr(info,"MSIE 5.0")>0 then
        browser="浏 览 器：Internet Explorer 5.00"
    elseif Instr(info,"MSIE 4.0")>0 then
        browser="浏 览 器：Internet Explorer 4.01"
    else
        browser="浏 览 器：未知"
    end if
end function

Rem 判断用户操作系统
function system(info)
    if Instr(info,"NT 5.1")>0 then
        system=system+"操作系统：Windows XP"
    elseif Instr(info,"Tel")>0 then
        system=system+"操作系统：Telport"
		    elseif Instr(lcase(info),"webzip")>0 then
        system=system+"操作系统：webzip"
		    elseif Instr(lcase(info),"flashget")>0 then
        system=system+"操作系统：flashget"
		    elseif Instr(lcase(info),"offline")>0 then
        system=system+"操作系统：offline"
    elseif Instr(info,"NT 5")>0 then
        system=system+"操作系统：Windows 2000"
    elseif Instr(info,"NT 4")>0 then
        system=system+"操作系统：Windows NT4"
    elseif Instr(info,"9x")>0 then
        system=system+"操作系统：Windows Me"
    elseif Instr(info,"98")>0 then
        system=system+"操作系统：Windows 98"
    elseif Instr(info,"95")>0 then
        system=system+"操作系统：Windows 95"
    else
        system=system+"操作系统：未知"
    end if
end function
%>
