<%
Rem ==========��̳��ҳ����=========
Rem �ж��û������
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

Rem �ж��û�����ϵͳ
function system(info)
    if Instr(info,"NT 5.1")>0 then
        system=system+"����ϵͳ��Windows XP"
    elseif Instr(info,"Tel")>0 then
        system=system+"����ϵͳ��Telport"
		    elseif Instr(lcase(info),"webzip")>0 then
        system=system+"����ϵͳ��webzip"
		    elseif Instr(lcase(info),"flashget")>0 then
        system=system+"����ϵͳ��flashget"
		    elseif Instr(lcase(info),"offline")>0 then
        system=system+"����ϵͳ��offline"
    elseif Instr(info,"NT 5")>0 then
        system=system+"����ϵͳ��Windows 2000"
    elseif Instr(info,"NT 4")>0 then
        system=system+"����ϵͳ��Windows NT4"
    elseif Instr(info,"9x")>0 then
        system=system+"����ϵͳ��Windows Me"
    elseif Instr(info,"98")>0 then
        system=system+"����ϵͳ��Windows 98"
    elseif Instr(info,"95")>0 then
        system=system+"����ϵͳ��Windows 95"
    else
        system=system+"����ϵͳ��δ֪"
    end if
end function
%>
