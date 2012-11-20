<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
    <%--<%@ include file="/common/metaGrid.jsp" %>--%>
    <%--<%@ include file="/common/metaMocha.jsp" %>--%>

    <link href="${themesPath}/css/style.css" rel="stylesheet" type="text/css">

    <script type="text/javascript">
        function printme()
        {
            window.print();
        }
    </script>
</head>

<body bgcolor="#FFFFFF" onload="printme();">
<table width="98%" border="0" align="center">
<form action="work-flow!save?id=${id}" method="post">
<tr>
    <td height="50" align="center" class="table_gw_title">中共上海市委党史研究室签发文稿纸</td>
  </tr>
  <tr>
    <td><table width="700" border="0" align="center" cellpadding="0" cellspacing="0" class="table_gw">
      <tr>
        <td height="50" colspan="4" class="table_gw_td" ><table width="98%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="18%" height="50">发文号</td>
            <td width="82%">
                ${workno}
                </td>
          </tr>
        </table></td>
        <td width="113" class="table_gw_td"><table width="98%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td width="18%" height="50" nowrap="nowrap">缓急 </td>
              <td width="82%">
                      ${fast}
              </td>
            </tr>
          </table></td>
        <td width="117" class="table_gw_td"><table width="98%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td width="18%" height="50" nowrap="nowrap">密级 </td>
              <td width="82%">
                      ${security}
              </td>
            </tr>
          </table></td>
      </tr>
      <tr>
        <td colspan="3" class="table_gw_td"><table width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td height="50">签发</td>
          </tr>
          <tr>
            <td height="100" valign="top">
                <%--<textarea name="sign" id="sign" class="input_three" >${sign}</textarea>--%>
                        ${signuser.displayname}
            </td>
          </tr>
          <tr>
            <td height="50" align="right">
                    ${signdate}
                </td>
          </tr>
        </table>          </td>
        <td colspan="3" class="table_gw_td"><table width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td height="50">会签</td>
          </tr>
          <tr>
            <td height="100" valign="top">
                <%--<textarea name="allsign" id="allsign" class="input_three" >${allsign}</textarea>--%>
                        ${allsignuser.displayname}
            </td>
          </tr>
          <tr>
            <td height="50" align="right">
                    ${allsigndate}
            </td>
          </tr>
        </table></td>
        </tr>
      
      <tr>
        <td height="50" colspan="6" class="table_gw_td"><table width="98%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td width="10%" height="50">主送:</td>
              <td width="90%">
                      ${senduser.displayname}
              </td>
            </tr>
          </table></td>
        </tr>
      <tr>
        <td height="50" colspan="6" class="table_gw_td"><table width="98%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td width="10%" height="50">抄送：</td>
              <td width="90%">
                      ${ccuser.displayname}
              </td>
            </tr>
          </table></td>
        </tr>
      <tr>
        <td height="50" colspan="6" class="table_gw_td"><table width="98%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td width="10%" height="50">抄报：</td>
              <td width="90%">
                      ${ctuser.displayname}
              </td>
            </tr>
          </table></td>
        </tr>
      <tr>
        <td height="50" colspan="2"  class="table_gw_td"><table width="98%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td width="18%" height="50" nowrap="nowrap">拟稿单位：</td>
              <td width="82%" nowrap="nowrap">${writedept.name} </td>
            </tr>
          </table></td>
        <td width="148"  class="table_gw_td"><table width="98%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td width="18%" height="50" nowrap="nowrap">拟稿：</td>
              <td width="82%" nowrap="nowrap">
                  ${writeuser.displayname}
                  <%--<c:if test='${step == 1}'>--%>
                      <%--<input name="workno" id="workno" type="text" class="input_one" value="${workno}"/>--%>
                  <%--</c:if>--%>
                  <%--<c:if test='${step != 1}'>--%>
                      <%--${workno}--%>
                  <%--</c:if>--%>
                  <%--<input type="hidden" name="writeuserid" id="writeuserid"/>--%>
                  <%--<input name="writeusername" id="writeusername" type="text" class="input_one" readonly />--%>
                  <%--<img src="${themesPath}/oldimages/ren.gif" width="16" height="16" style="cursor:pointer;" onclick="writeuser()" >--%>
              </td>
            </tr>
          </table></td>
        <td width="137" nowrap="nowrap"  class="table_gw_td"><table width="98%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td width="18%" height="50" nowrap="nowrap">核稿：</td>
              <td width="82%" nowrap="nowrap">
                      ${checkuser.displayname}
                </td>
            </tr>
          </table></td>
        <td colspan="2"  class="table_gw_td"><table width="98%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td width="18%" height="50" nowrap="nowrap">修改：</td>
              <td width="82%" nowrap="nowrap">
                      ${modifyuser.displayname}
                  </td>
            </tr>
          </table></td>
        </tr>
      <tr>
        <td height="50" colspan="2"  class="table_gw_td"><table width="98%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td width="41%" height="50" nowrap="nowrap">打字：</td>
              <td width="59%" nowrap="nowrap">
                      ${typeuser.displayname}
              </td>
            </tr>
          </table></td>
        <td  class="table_gw_td"><table width="98%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td width="18%" height="50" nowrap="nowrap">校对：</td>
              <td width="82%" nowrap="nowrap">
                      ${collateuser.displayname}
              </td>
            </tr>
          </table></td>
        <td  class="table_gw_td"><table width="98%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td width="18%" height="50" nowrap="nowrap">印刷：</td>
              <td width="82%" nowrap="nowrap">
                      ${printuser.displayname}
              </td>
            </tr>
          </table></td>
        <td colspan="2"  class="table_gw_td"><table width="98%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td width="18%" height="50" nowrap="nowrap">份数：</td>
              <td width="82%">
                      ${num}
              </td>
            </tr>
          </table></td>
        </tr>
      <tr>
        <td height="50" colspan="6"  class="table_gw_td"><table width="98%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td width="10%" height="50">附件：</td>
              <td width="90%">
                  <s:iterator value ="attachs">${filename}
                  </s:iterator>&nbsp;&nbsp;
              </td>
            </tr>
          </table></td>
        </tr>
      <tr>
        <td height="50" colspan="6"  class="table_gw_td"><table width="98%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td width="10%" height="50">主题词：</td>
              <td width="90%">
                      ${keyword}
              </td>
            </tr>
          </table></td>
        </tr>
      <tr>
        <td height="50" colspan="6"  class="table_gw_td"><table width="98%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td width="10%" height="100">标题： </td>
              <td width="90%">
                      ${title}
              </td>
            </tr>
          </table></td>
        </tr>
      <td height="50" colspan="6"  class="table_gw_td"><table width="98%" border="0" cellpadding="0" cellspacing="0">
          <tr>
              <td width="10%" height="100">内容： </td>
              <td width="90%">
                      ${content}
              </td>
          </tr>
      </table></td>
      </tr>
    </table></td>
  </tr>
</form>
</table>
</body>
</html>
