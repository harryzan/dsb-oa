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
<title>车辆信息维护</title>

<link href="${themesPath}/oldcss/style.css" rel="stylesheet" type="text/css">

    <script type="text/javascript" src="${scriptsPath}/system/calendar.js"></script>
    <script type="text/javascript" src="${scriptsPath}/system/function.js"></script>
    <script type="text/javascript">

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
<br>
<table width="90%" height="100%" border="0" align="center" cellpadding="0" cellspacing="1">
            <form action="car-drive!save?id=${id}" method="post" onSubmit="javascript:return check_form(this)">
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
                      <td valign="top" bgcolor="#FFFFFF"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                          <tr class="textone1">
                              <td colspan="4" align="center" class="text_title">派车安排</td>
                          </tr>
                          <tr class="textone1">
                            <td align="right" class="textone1">申请事由：</td>
                            <td colspan="3" class="textone1">&nbsp;
                            ${name} </td>
                          </tr>
                          <tr class="textone12">
                              <td width="19%" class="textone1"><div align="right">申请车别：</div></td>
                              <td width="11%" class="textone1">&nbsp;${cardesc}                              </td>
                              <td width="5%" class="textone1"><div align="right">人  数：</div></td>
                              <td width="65%" class="textone1">&nbsp;${usercount}                              </td>
                          </tr>
                          <tr class="textone1">
                              <td width="22%" class="textone1"><div align="right">发车时间：</div></td>
                              <td  colspan="3" class="textone1">&nbsp;
                                  ${startdate}</td>
                          </tr>
                          <tr class="textone12">
                              <td width="22%" class="textone1"><div align="right">返回时间：</div></td>
                              <td colspan="3" class="textone1">&nbsp;
                                  ${enddate}</td>
                          </tr>
                          <tr class="textone1">
                              <td width="22%" class="textone1"><div align="right">上车地点：</div></td>
                              <td colspan="3" class="textone1">&nbsp;
                                  ${place}                              </td>
                          </tr>
                          <tr class="textone12">
                              <td width="22%" class="textone1"><div align="right">行驶路线：</div></td>
                              <td colspan="3" class="textone1">&nbsp;
                                  ${drivingline}                              </td>
                          </tr>
                          <tr class="textone1">
                              <td width="22%" class="textone1"><div align="right">备注：</div></td>
                              <td colspan="3" class="textone1">&nbsp;
                                  ${desc}                              </td>
                          </tr>
                          <tr class="textone12">
                              <td width="22%" class="textone1"><div align="right">申请人：</div></td>
                              <td colspan="3" class="textone1">&nbsp;${user.displayname}&nbsp;${submitdate}                              </td>
                          </tr>
                          <tr class="textone1">
                              <td width="22%" class="textone1"><div align="right">批示意见：</div></td>
                              <td colspan="3" class="textone1">&nbsp;${opinion}                              </td>
                          </tr>
                          <tr class="textone12">
                              <td width="22%" class="textone1"><div align="right">批示人：</div></td>
                              <td colspan="3" class="textone1">&nbsp;${checker.displayname}&nbsp;${checkdate}                              </td>
                          </tr>
                          <tr class="textone1">
                              <td class="textone1"><div align="right">调度意见：</div></td>
                              <td  colspan="3" class="textone1">&nbsp;
                                  <textarea name="memo" class="input_long">${memo}</textarea>                              </td>
                          </tr>
                          <tr class="textone12">
                              <td width="22%" class="textone1"><div align="right">分配车辆：</div></td>
                              <td valign="center"  colspan="3" class="textone1">&nbsp;
                                  <select name="carid" id="carid">
                                      <c:forEach items="${cars}" var="car" varStatus="status">
                                          <option value="${car.id}">${car.carmodel} - ${car.carlicense}</option>
                                      </c:forEach>
                          </select>                          </tr>
                          <tr class="textone1">
                              <td width="22%" class="textone1"><div align="right">指定司机：</div></td>
                              <td valign="center" colspan="3" class="textone1">&nbsp;
                                  <select name="driverid" id="driverid">
                                      <c:forEach items="${drivers}" var="driver" varStatus="status">
                                          <option value="${driver.id}">${driver.name}</option>
                                      </c:forEach>
                          </select>                          </tr>
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
                                  <td width="45%"><input type="button" class="button_cc" name="input" value="返 回" onClick="history.back();"></td>
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
        if(afrom.carmodel.value == ""){
            Ext.MessageBox.alert("提示", "车辆型号不能为空！");
            return false;
        }
        return true;
    }
</script>
</body>
</html>