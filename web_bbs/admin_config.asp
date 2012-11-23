<%
REM 管理栏目设置
dim menu(6,10)
menu(0,0)="论坛管理"
menu(0,1)="论坛版面管理,admin_board.asp"
menu(0,2)="更新论坛数据,admin_updateboard.asp"
menu(0,3)="合并论坛数据,admin_boardunite.asp"
menu(0,4)="批量删除,admin_alldel.asp"

menu(1,0)="用户管理"
menu(1,1)="用户数据管理,admin_user.asp"

menu(2,0)="论坛设置"
menu(2,1)="论坛基本信息,admin_var.asp"
menu(2,2)="论坛使用设置,admin_use.asp"
menu(2,3)="论坛界面设置,admin_color.asp"
menu(2,4)="论坛图片设置,admin_pic.asp"
menu(2,5)="论坛模板选择管理,admin_skin.asp"
menu(2,6)="语句过滤(注册&帖子),admin_badword.asp"
menu(2,7)="查看服务器设置,admin_server.asp"

menu(3,0)="数据处理"
menu(3,1)="搜索帖子,admin_query.asp"
menu(3,2)="备份数据库,admin_BackupData.asp"
menu(3,3)="恢复数据库,admin_RestoreData.asp"
menu(3,4)="系统占用空间统计,admin_SpaceSize.asp"

menu(4,0)="管理操作"
menu(4,1)="添加管理员,admin_addadmin.asp"
menu(4,2)="管理员权限管理,admin_admin.asp"
menu(4,3)="修改密码,MYMODIFY.ASP"

menu(5,0)="其它管理"
menu(5,1)="论坛公告发布管理,admin_boardaset.asp?boardid=0"
menu(5,2)="短消息广播和管理,admin_message.asp"
menu(5,3)="管理上传文件,admin_uploadlist.asp"


REM 版权和版本设置，非授权情况下请勿随意更改
REM 版权所有(使用权)可改为使用者，但一定要加上技术支持字样

Copyright="版权所有：  "

if instr(Copyright,"")=0 then

conn.execute("update config set Forum_Copyright='"&Copyright&"'")

end if

REM 更新论坛使用目录
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