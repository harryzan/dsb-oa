<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2009-5-15
  Time: 12:10:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/metaGrid.jsp" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>需求信息维护</title>

<link href="${themesPath}/oldcss/style.css" rel="stylesheet" type="text/css">

    <script type="text/javascript" src="${scriptsPath}/system/calendar.js"></script>
    <script type="text/javascript" src="${scriptsPath}/system/function.js"></script>
    <script type="text/javascript">
        function mainuser(){
            var returnvalue = window.showModalDialog("${ctx}/common/tree/sys-user-tree", 1);
            if(returnvalue){
                document.getElementById("mainusername").value = returnvalue.split(",")[0];
                document.getElementById("mainuserid").value = returnvalue.split(",")[1];
            }
        }
    </script>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<%--<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">--%>
  <%--<tr>--%>
    <%--<td width="13" height="12" valign="top" background="${themesPath}/oldimages/azuo.gif"><img src="${themesPath}/oldimages/a1.gif" width="13" height="13"></td>--%>
    <%--<td background="${themesPath}/oldimages/ashang.gif"></td>--%>
    <%--<td width="12" height="12" valign="top" nowrap background="${themesPath}/oldimages/ayou.gif"><img src="${themesPath}/oldimages/a2.gif" width="13" height="13"></td>--%>
  <%--</tr>--%>
  <%--<tr>--%>
    <%--<td background="${themesPath}/oldimages/azuo.gif"></td>--%>
    <%--<td  valign="top" bgcolor="#fbfbfb"><table width="100%"  border="0" cellpadding="0" cellspacing="0">--%>
      <%--<tr>--%>
        <%--<td width="10" height="27" nowrap background="${themesPath}/oldimages/bgzuo.gif">&nbsp;</td>--%>
        <%--<td background="${themesPath}/oldimages/bgz.gif"><table width="100%" height="10"  border="0" align="right" cellpadding="0" cellspacing="2">--%>
            <%--<tr>--%>
              <%--<td width="20" class="textone">&nbsp;</td>--%>
              <%--<td height="23" valign="bottom" class="textone" align="center"><strong style="font-weight:bold;">维护型号信息</strong></td>--%>
              <%--<td width="20">&nbsp;</td>--%>
            <%--</tr>--%>
        <%--</table></td>--%>
        <%--<td width="10" height="27" nowrap background="${themesPath}/oldimages/bgyou.gif">&nbsp;</td>--%>
      <%--</tr>--%>
      <%--<tr>--%>
        <%--<td background="${themesPath}/oldimages/bgtua.gif">&nbsp;</td>--%>
        <%--<td valign="top" bgcolor="#eff6fe">--%>
        <table width="100%" height="100%" border="0" align="center" cellpadding="0" cellspacing="1">
            <form action="demand-check!save?id=${id}" method="post" onsubmit="javascript:return check_form(this)">
                <input type ="hidden" name="gridParam" value='${gridParam}'>
                <tr>
                  <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="4" height="4" background="${themesPath}/oldimages/bg/shang.gif"><div align="right"><img src="${themesPath}/oldimages/bg/1.gif" width="4" height="4"></div></td>
                      <td height="4" background="${themesPath}/oldimages/bg/shang.gif"></td>
                      <td width="4" height="4" align="right"><img src="${themesPath}/oldimages/bg/2.gif" width="4" height="4"></td>
                    </tr>
                    <tr>
                      <td width="4" background="${themesPath}/oldimages/bg/zuo.gif"><img src="${themesPath}/oldimages/bg/zuo.gif" width="4" height="4"></td>
                      <td valign="top" bgcolor="#FFFFFF"><table width="100%" border="0" cellpadding="0" cellspacing="1">
                          <c:if test="${type.name != '会议'}">
                              <tr class="textone1">
                                  <td width="30%"><div align="right">名称：</div></td>
                                  <td width="70%">&nbsp;${name}
                                  </td>
                              </tr>
                              <tr class="textone12">
                                  <td width="30%"><div align="right">申请人：</div></td>
                                  <td width="70%">&nbsp;${user.displayname}</td>
                              </tr>
                              <tr class="textone1">
                                  <td width="30%"><div align="right">申请科室：</div></td>
                                  <td width="70%">&nbsp;${user.sysdept.name}</td>
                              </tr>
                              <tr class="textone12">
                                  <td width="30%"><div align="right">需求日期：</div></td>
                                  <td width="70%">&nbsp;${demanddate}</td>
                              </tr>
                              <tr class="textone1">
                                  <td><div align="right">描述：</div></td>
                                  <td height="60">&nbsp;${desc}</td>
                              </tr>
                          </c:if>
                          <c:if test="${type.name == '会议'}">
                              <tr class="textone1">
                                  <td width="30%"><div align="right">会议名称：</div></td>
                                  <td width="70%">&nbsp;${name}
                                  </td>
                              </tr>
                              <tr class="textone12">
                                  <td width="30%"><div align="right">会议主题：</div></td>
                                  <td width="70%">&nbsp;${title}
                                  </td>
                              </tr>
                              <tr class="textone1">
                                  <td width="30%"><div align="right">申请人：</div></td>
                                  <td width="70%">&nbsp;${user.displayname}(${user.sysdept.name})</td>
                              </tr>
                              <tr class="textone12">
                                  <td width="30%"><div align="right">主持人：</div></td>
                                  <td width="70%">&nbsp;${moderator.displayname}</td>
                              </tr>
                              <tr class="textone1">
                                  <td width="30%"><div align="right">使用时间：</div></td>
                                  <td width="70%">&nbsp;${demanddate}&nbsp;至&nbsp;${enddate}</td>
                              </tr>
                              <tr class="textone12">
                                  <td width="30%"><div align="right">参加人员：</div></td>
                                  <td width="70%">&nbsp;${attendance}
                                  </td>
                              </tr>
                              <tr class="textone1">
                                  <td width="30%"><div align="right">会议人数：</div></td>
                                  <td width="70%">&nbsp;${personnum}
                                  </td>
                              </tr>
                              <tr class="textone12">
                                  <td width="30%"><div align="right">会议地点：</div></td>
                                  <td width="70%">&nbsp;${room}
                                  </td>
                              </tr>
                              <tr class="textone1">
                                  <td><div align="right">会务要求：</div></td>
                                  <td height="60">&nbsp;${desc}</td>
                              </tr>
                          </c:if>
                          <tr class="textone12">
                              <td><div align="right">审核意见：</div></td>
                              <td height="60">${opinion}</td>
                          </tr>
                          <tr class="textone12">
                              <td><div align="right">审核人：</div></td>
                              <td height="60">${checker.displayname}&nbsp;&nbsp;${checkdate}</td>
                          </tr>
                          <tr class="textone1">
                              <td><div align="right">安排情况：</div></td>
                              <td height="60">&nbsp;${memo}</td>
                          </tr>
                          <tr class="textone12">
                              <td><div align="right">安排人：</div></td>
                              <td height="60">${memor.displayname}&nbsp;&nbsp;${memodate}</td>
                          </tr>
                          <tr class="textone1">
                              <td><div align="right">执行人：</div></td>
                              <td height="60">&nbsp;${mainuser.displayname}
                              </td>
                          </tr>
                          <tr class="textone12">
                              <td><div align="right">反馈意见：</div></td>
                              <td height="60">&nbsp;
                                  <textarea name="remind" class="input_five" rows="10">${remind}</textarea></td>
                          </tr>
                          <tr class="textone1">
                              <td><div align="right">反馈人：</div></td>
                              <td height="60">&nbsp;${reminder.displayname}
                              </td>
                          </tr>
                          <%--<tr class="textone12">--%>
                            <%--<td><div align="right">照片：</div></td>--%>
                            <%--<td>&nbsp;<span class="textxing" style ="cursor:pointer;" onclick="docdocument();">关联图片文档</span><input type ="hidden" name="documentid" value="${docdocument.id}" ></td>--%>
                          <%--</tr>--%>

                      </table></td>
                      <td width="4" background="${themesPath}/oldimages/bg/you.gif"><img src="${themesPath}/oldimages/bg/you.gif" width="4" height="4"></td>
                    </tr>
                    <tr>
                      <td width="4" height="4" background="${themesPath}/oldimages/bg/xia.gif"><div align="right"><img src="${themesPath}/oldimages/bg/3.gif" width="4" height="4"></div></td>
                      <td height="4" background="${themesPath}/oldimages/bg/xia.gif"></td>
                      <td width="4" align="right"><img src="${themesPath}/oldimages/bg/4.gif" width="4" height="4"></td>
                    </tr><tr>
                            <td colspan="3" bgcolor="#eff6fe"><table width="100%" border="0" cellspacing="1" cellpadding="0">
                                <tr valign="top">
                                  <td width="100%"><input type="button" class="button_cc" name="input" value="返 回" onClick="history.back();"></td>
                                </tr>
                            </table></td>
                          </tr>
                  </table>
                  </td>
                </tr>

            </form>
        </table>
        <%--</td><td background="${themesPath}/oldimages/bgtub.gif">&nbsp;</td>--%>
      <%--</tr>--%>
      <%--<tr>--%>
        <%--<td valign="top"><img src="${themesPath}/oldimages/bgtuc.gif" width="10" height="11"></td>--%>
        <%--<td height="11" background="${themesPath}/oldimages/bgxia.gif"></td>--%>
        <%--<td valign="top"><img src="${themesPath}/oldimages/bgtud.gif" width="10" height="11"></td>--%>
      <%--</tr>--%>
    <%--</table></td>--%>
    <%--<td background="${themesPath}/oldimages/ayou.gif">&nbsp;</td>--%>
  <%--</tr>--%>
  <%--<tr>--%>
    <%--<td width="13" height="12" background="${themesPath}/oldimages/axia.gif"><img src="${themesPath}/oldimages/a3.gif" width="13" height="13"></td>--%>
    <%--<td background="${themesPath}/oldimages/axia.gif"></td>--%>
    <%--<td width="19" height="12" valign="top"><img src="${themesPath}/oldimages/a4.gif" width="13" height="13"></td>--%>
  <%--</tr>--%>
<%--</table>--%>
<script type="text/javascript">
    function check_form(afrom){
        if(afrom.demandmodel.value == ""){
            Ext.MessageBox.alert("提示", "车辆型号不能为空！");
            return false;
        }
        return true;
    }
</script>
</body>
</html>