<%
REM ������Ŀ����
dim menu(6,10)
menu(0,0)="��̳����"
menu(0,1)="��̳�������,admin_board.asp"
menu(0,2)="������̳����,admin_updateboard.asp"
menu(0,3)="�ϲ���̳����,admin_boardunite.asp"
menu(0,4)="����ɾ��,admin_alldel.asp"

menu(1,0)="�û�����"
menu(1,1)="�û����ݹ���,admin_user.asp"

menu(2,0)="��̳����"
menu(2,1)="��̳������Ϣ,admin_var.asp"
menu(2,2)="��̳ʹ������,admin_use.asp"
menu(2,3)="��̳��������,admin_color.asp"
menu(2,4)="��̳ͼƬ����,admin_pic.asp"
menu(2,5)="��̳ģ��ѡ�����,admin_skin.asp"
menu(2,6)="������(ע��&����),admin_badword.asp"
menu(2,7)="�鿴����������,admin_server.asp"

menu(3,0)="���ݴ���"
menu(3,1)="��������,admin_query.asp"
menu(3,2)="�������ݿ�,admin_BackupData.asp"
menu(3,3)="�ָ����ݿ�,admin_RestoreData.asp"
menu(3,4)="ϵͳռ�ÿռ�ͳ��,admin_SpaceSize.asp"

menu(4,0)="�������"
menu(4,1)="��ӹ���Ա,admin_addadmin.asp"
menu(4,2)="����ԱȨ�޹���,admin_admin.asp"
menu(4,3)="�޸�����,MYMODIFY.ASP"

menu(5,0)="��������"
menu(5,1)="��̳���淢������,admin_boardaset.asp?boardid=0"
menu(5,2)="����Ϣ�㲥�͹���,admin_message.asp"
menu(5,3)="�����ϴ��ļ�,admin_uploadlist.asp"


REM ��Ȩ�Ͱ汾���ã�����Ȩ����������������
REM ��Ȩ����(ʹ��Ȩ)�ɸ�Ϊʹ���ߣ���һ��Ҫ���ϼ���֧������

Copyright="��Ȩ���У�  "

if instr(Copyright,"")=0 then

conn.execute("update config set Forum_Copyright='"&Copyright&"'")

end if

REM ������̳ʹ��Ŀ¼
dim cookies_path_s
dim cookies_path_d
dim cookies_path

cookies_path_s=split(Request.ServerVariables("PATH_INFO"),"/")
cookies_path_d=ubound(cookies_path_s)
cookies_path="/"
for i=1 to cookies_path_d-1
if not (cookies_path_s(i)="upload" or cookies_path_s(i)="admin") then cookies_path=cookies_path&cookies_path_s(i)&"/"
next
cookiepath=cookies_path
conn.execute("update config set cookiepath='"&cookiepath&"'")
%>