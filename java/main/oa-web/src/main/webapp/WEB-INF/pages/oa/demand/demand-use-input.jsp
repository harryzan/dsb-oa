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
        function moderator(){
            var returnvalue = window.showModalDialog("${ctx}/common/tree/sys-user-tree", 1);
            if(returnvalue){
                document.getElementById("moderatorname").value = returnvalue.split(",")[0];
                document.getElementById("moderatorid").value = returnvalue.split(",")[1];
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
            <form action="demand-use!save?id=${id}" method="post" onsubmit="javascript:return check_form(this)">
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
                            <td width="70%">&nbsp;
                                <input name="name" type="text" class="input_one" value="${name}">
                                </td>
                          </tr>
                          <tr class="textone12">
                              <td width="30%"><div align="right">需求日期：</div></td>
                              <td width="70%">&nbsp;
                                  <input id="demanddate" name="demanddate" type="text" class="input_one" value="${demanddate}"><img src="${themesPath}/oldimages/calendar.gif"  width="13" height="12" style="cursor:pointer;" onclick="calendar(demanddate, 'date');" /></td>
                          </tr>
                          <tr class="textone1">
                            <td><div align="right">描述：</div></td>
                            <td height="60">&nbsp;
                                <textarea name="desc" class="input_five" rows="10">${desc}</textarea></td>
                          </tr>
                          </c:if>

                          <c:if test="${type.name == '会议'}">
                              <tr class="textone12">
                                  <td width="30%"><div align="right">会议名称：</div></td>
                                  <td width="70%">&nbsp;
                                      <input name="name" type="text" class="input_one" value="${name}">
                                  </td>
                              </tr>
                              <tr class="textone1">
                                  <td width="30%"><div align="right">会议主题：</div></td>
                                  <td width="70%">&nbsp;
                                      <input name="title" type="text" class="input_chang" value="${title}">
                                  </td>
                              </tr>
                              <tr class="textone12">
                                  <td><div align="right">主持人：</div></td>
                                  <td height="60">&nbsp;
                                      <input type="hidden" name="moderatorid" id="moderatorid" value="${moderator.id}"/>
                                      <input name="moderatorname" id="moderatorname" value="${moderator.displayname}" type="text" class="input_one" readonly />
                                      <img src="${themesPath}/oldimages/ren.gif" width="16" height="16" style="cursor:pointer;" onclick="moderator()" >
                                  </td>
                              </tr>
                              <tr class="textone1">
                                  <td width="30%"><div align="right">使用日期：</div></td>
                                  <td width="70%">&nbsp;
                                      <input id="demanddate" name="demanddate" type="text" class="input_one" value="${demanddate}"><img src="${themesPath}/oldimages/calendar.gif"  width="13" height="12" style="cursor:pointer;" onclick="calendar(demanddate, 'datetime');" />
                                  至<input id="enddate" name="enddate" type="text" class="input_one" value="${enddate}"><img src="${themesPath}/oldimages/calendar.gif"  width="13" height="12" style="cursor:pointer;" onclick="calendar(enddate, 'datetime');" /></td>
                              </tr>
                              <tr class="textone12">
                                  <td width="30%"><div align="right">会议主题：</div></td>
                                  <td width="70%">&nbsp;
                                      <input name="title" type="text" class="input_chang" value="${title}">
                                  </td>
                              </tr>
                              <tr class="textone1">
                                  <td width="30%"><div align="right">参加人员：</div></td>
                                  <td width="70%">&nbsp;
                                      <input name="attendance" type="text" class="input_chang" value="${attendance}">
                                  </td>
                              </tr>
                              <tr class="textone12">
                                  <td width="30%"><div align="right">会议人数：</div></td>
                                  <td width="70%">&nbsp;
                                      <input name="personnum" type="text" class="input_one" value="${personnum}">
                                  </td>
                              </tr>
                              <tr class="textone1">
                                  <td width="30%"><div align="right">会议地点：</div></td>
                                  <td width="70%">&nbsp;
                                      <select name="room" id="room">
                                          <option value="一楼会议室">一楼会议室</option>
                                          <option value="二楼会议室">二楼会议室</option>
                                          <option value="四楼会议室">四楼会议室</option>
                                      </select>
                                  </td>
                              </tr>
                              <tr class="textone12">
                                  <td><div align="right">会务要求：</div></td>
                                  <td height="60">&nbsp;
                                      <textarea name="desc" class="input_five" rows="10">${desc}</textarea></td>
                              </tr>
                          </c:if>


                          <%--<tr class="textone1">--%>
                            <%--<td><div align="right">其他说明：</div></td>--%>
                            <%--<td height="60">&nbsp;--%>
                                <%--<textarea name="note" class="input_four">${note}</textarea></td>--%>
                          <%--</tr>--%>
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
                                  <td width="45%"><div align="right">
                                      <input type="submit" class="button_bc" name="input" value="完 成">
                                  </div></td>
                                  <td width="10%"><div align="center">
                                      <input type="reset" class="button_cc" name="input" value="重 写">
                                  </div></td>
                                  <td width="45%"><input type="button" class="button_cc" name="input" value="返 回" onClick="location='demand-use-grid';"></td>
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