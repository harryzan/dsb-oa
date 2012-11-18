<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
    <%@ include file="/common/metaGrid.jsp" %>
    <%@ include file="/common/metaMocha.jsp" %>

    <link href="${themesPath}/css/style.css" rel="stylesheet" type="text/css">
    <style type="text/css">
<!--
.STYLE1 {color: #FF0000}
-->
</style>
    <script type="text/javascript">
        function signuser(){
            var returnvalue = window.showModalDialog("${ctx}/common/tree/sys-user-tree", 1);
            if(returnvalue){
                document.getElementById("signusername").value = returnvalue.split(",")[0];
                document.getElementById("signuserid").value = returnvalue.split(",")[1];
            }
        }

        function allsignuser(){
            var returnvalue = window.showModalDialog("${ctx}/common/tree/sys-user-tree", 1);
            if(returnvalue){
                document.getElementById("allsignusername").value = returnvalue.split(",")[0];
                document.getElementById("allsignuserid").value = returnvalue.split(",")[1];
            }
        }

        function senduser(){
            var returnvalue = window.showModalDialog("${ctx}/common/tree/sys-user-tree", 1);
            if(returnvalue){
                document.getElementById("sendusername").value = returnvalue.split(",")[0];
                document.getElementById("senduserid").value = returnvalue.split(",")[1];
            }
        }

        function ccuser(){
            var returnvalue = window.showModalDialog("${ctx}/common/tree/sys-user-tree", 1);
            if(returnvalue){
                document.getElementById("ccusername").value = returnvalue.split(",")[0];
                document.getElementById("ccuserid").value = returnvalue.split(",")[1];
            }
        }

        function ctuser(){
            var returnvalue = window.showModalDialog("${ctx}/common/tree/sys-user-tree", 1);
            if(returnvalue){
                document.getElementById("ctusername").value = returnvalue.split(",")[0];
                document.getElementById("ctuserid").value = returnvalue.split(",")[1];
            }
        }

        function writeuser(){
            var returnvalue = window.showModalDialog("${ctx}/common/tree/sys-user-tree", 1);
            if(returnvalue){
                document.getElementById("writeusername").value = returnvalue.split(",")[0];
                document.getElementById("writeuserid").value = returnvalue.split(",")[1];
            }
        }

        function checkuser(){
            var returnvalue = window.showModalDialog("${ctx}/common/tree/sys-user-tree", 1);
            if(returnvalue){
                document.getElementById("checkusername").value = returnvalue.split(",")[0];
                document.getElementById("checkuserid").value = returnvalue.split(",")[1];
            }
        }

        function modifyuser(){
            var returnvalue = window.showModalDialog("${ctx}/common/tree/sys-user-tree", 1);
            if(returnvalue){
                document.getElementById("modifyusername").value = returnvalue.split(",")[0];
                document.getElementById("modifyuserid").value = returnvalue.split(",")[1];
            }
        }

        function typeuser(){
            var returnvalue = window.showModalDialog("${ctx}/common/tree/sys-user-tree", 1);
            if(returnvalue){
                document.getElementById("typeusername").value = returnvalue.split(",")[0];
                document.getElementById("typeuserid").value = returnvalue.split(",")[1];
            }
        }

        function collateuser(){
            var returnvalue = window.showModalDialog("${ctx}/common/tree/sys-user-tree", 1);
            if(returnvalue){
                document.getElementById("collateusername").value = returnvalue.split(",")[0];
                document.getElementById("collateuserid").value = returnvalue.split(",")[1];
            }
        }

        function printuser(){
            var returnvalue = window.showModalDialog("${ctx}/common/tree/sys-user-tree", 1);
            if(returnvalue){
                document.getElementById("printusername").value = returnvalue.split(",")[0];
                document.getElementById("printuserid").value = returnvalue.split(",")[1];
            }
        }

        function docdocument(){
            var documentid = document.getElementById("documentid").value;
            if(!documentid) {
                documentid = "";
            }
//            alert(documentid);
            var returnvalue = window.showModalDialog("${ctx}/common/document/doc-client-category!main?modelname=work-flow&documentid=" + documentid, null, "dialogWidth:870px;");
            if(returnvalue != null && returnvalue != "" && returnvalue != undefined){
                document.getElementById("documentid").value = returnvalue;
            }
        }
    </script>
</head>

<body bgcolor="#FFFFFF">
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
                <c:if test='${step == 1}'>
                <input name="workno" id="workno" type="text" class="input_one" value="${workno}"/>
                </c:if>
                <c:if test='${step != 1}'>
                ${workno}
                </c:if>
                </td>
          </tr>
        </table></td>
        <td width="113" class="table_gw_td"><table width="98%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td width="18%" height="50" nowrap="nowrap">缓急 </td>
              <td width="82%">
                  <c:if test='${step == 1}'>
                      <input name="fast" id="fast" type="text" class="input_one2" value="${fast}"/>
                  </c:if>
                  <c:if test='${step != 1}'>
                      ${fast}
                  </c:if>
              </td>
            </tr>
          </table></td>
        <td width="117" class="table_gw_td"><table width="98%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td width="18%" height="50" nowrap="nowrap">密级 </td>
              <td width="82%">
                  <c:if test='${step == 1}'>
                      <input name="security" id="security" type="text" class="input_one2" value="${security}"/>
                  </c:if>
                  <c:if test='${step != 1}'>
                      ${security}
                  </c:if>
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
                    <c:if test='${step == 5}'>
                        <input type="hidden" name="signuserid" id="signuserid"/>
                        <input name="signusername" id="signusername" type="text" class="input_one" readonly />
                        <img src="${themesPath}/oldimages/ren.gif" width="16" height="16" style="cursor:pointer;" onclick="signuser()" >
                    </c:if>
                    <c:if test='${step != 5}'>
                        ${signuser.displayname}
                    </c:if>
            </td>
          </tr>
          <tr>
            <td height="50" align="right">
                <c:if test='${step == 5}'>
                    <input name="signday" id="signday" class="input_one2" type="text" value="${signday}"/>&nbsp;
                    <img src="${themesPath}/oldimages/calendar.gif"  width="13" height="12" onClick="calendar(signday,'date');" style="cursor:pointer">
                </c:if>
                <c:if test='${step != 5}'>
                    ${signday}
                </c:if>
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
                    <c:if test='${step == 6}'>
                        <input type="hidden" name="allsignuserid" id="allsignuserid"/>
                        <input name="allsignusername" id="allsignusername" type="text" class="input_one" readonly />
                        <img src="${themesPath}/oldimages/ren.gif" width="16" height="16" style="cursor:pointer;" onclick="allsignuser()" >
                    </c:if>
                    <c:if test='${step != 6}'>
                        ${allsignuser.displayname}
                    </c:if>
            </td>
          </tr>
          <tr>
            <td height="50" align="right">
                <c:if test='${step == 6}'>
                    <input name="allsignday" id="allsignday" class="input_one2" type="text" value="${allsignday}"/>&nbsp;
                    <img src="${themesPath}/oldimages/calendar.gif"  width="13" height="12" onClick="calendar(allsignday,'date');" style="cursor:pointer">
                </c:if>
                <c:if test='${step != 6}'>
                    ${allsignday}
                </c:if>
            </td>
          </tr>
        </table></td>
        </tr>
      
      <tr>
        <td height="50" colspan="6" class="table_gw_td"><table width="98%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td width="10%" height="50">主送:</td>
              <td width="90%">
                  <c:if test='${step == 7}'>
                      <input type="hidden" name="senduserid" id="senduserid"/>
                      <input name="sendusername" id="sendusername" type="text" class="input_one" readonly />
                      <img src="${themesPath}/oldimages/ren.gif" width="16" height="16" style="cursor:pointer;" onclick="senduser()" >
                  </c:if>
                  <c:if test='${step != 7}'>
                      ${senduser.displayname}
                  </c:if>
              </td>
            </tr>
          </table></td>
        </tr>
      <tr>
        <td height="50" colspan="6" class="table_gw_td"><table width="98%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td width="10%" height="50">抄送：</td>
              <td width="90%">
                  <c:if test='${step == 7}'>
                      <input type="hidden" name="ccuserid" id="ccuserid"/>
                      <input name="ccusername" id="ccusername" type="text" class="input_one" readonly />
                      <img src="${themesPath}/oldimages/ren.gif" width="16" height="16" style="cursor:pointer;" onclick="ccuser()" >
                  </c:if>
                  <c:if test='${step != 7}'>
                      ${ccuser.displayname}
                  </c:if>
              </td>
            </tr>
          </table></td>
        </tr>
      <tr>
        <td height="50" colspan="6" class="table_gw_td"><table width="98%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td width="10%" height="50">抄报：</td>
              <td width="90%">
                  <c:if test='${step == 7}'>
                      <input type="hidden" name="ctuserid" id="ctuserid"/>
                      <input name="ctusername" id="ctusername" type="text" class="input_one" readonly />
                      <img src="${themesPath}/oldimages/ren.gif" width="16" height="16" style="cursor:pointer;" onclick="ctuser()" >
                  </c:if>
                  <c:if test='${step != 7}'>
                      ${ctuser.displayname}
                  </c:if>
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
                  <c:if test='${step == 1}'>
                      <input type="hidden" name="checkuserid" id="checkuserid"/>
                      <input name="checkusername" id="checkusername" type="text" class="input_one2" readonly />
                      <img src="${themesPath}/oldimages/ren.gif" width="16" height="16" style="cursor:pointer;" onclick="checkuser()" >
                  </c:if>
                  <c:if test='${step != 1}'>
                      ${checkuser.displayname}
                  </c:if>
                </td>
            </tr>
          </table></td>
        <td colspan="2"  class="table_gw_td"><table width="98%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td width="18%" height="50" nowrap="nowrap">修改：</td>
              <td width="82%" nowrap="nowrap">
                  <c:if test='${step == 2}'>
                      <input type="hidden" name="modifyuserid" id="modifyuserid"/>
                      <input name="modifyusername" id="modifyusername" type="text" class="input_one2" readonly />
                      <img src="${themesPath}/oldimages/ren.gif" width="16" height="16" style="cursor:pointer;" onclick="modifyuser()" >
                  </c:if>
                  <c:if test='${step != 2}'>
                      ${modifyuser.displayname}
                  </c:if>
                  </td>
            </tr>
          </table></td>
        </tr>
      <tr>
        <td height="50" colspan="2"  class="table_gw_td"><table width="98%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td width="41%" height="50" nowrap="nowrap">打字：</td>
              <td width="59%" nowrap="nowrap">
                   <c:if test='${step == 3}'>
                       <input type="hidden" name="typeuserid" id="typeuserid"/>
                       <input name="typeusername" id="typeusername" type="text" class="input_one2" readonly />
                       <img src="${themesPath}/oldimages/ren.gif" width="16" height="16" style="cursor:pointer;" onclick="typeuser()" >
                   </c:if>
                  <c:if test='${step != 3}'>
                      ${typeuser.displayname}
                  </c:if>
              </td>
            </tr>
          </table></td>
        <td  class="table_gw_td"><table width="98%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td width="18%" height="50" nowrap="nowrap">校对：</td>
              <td width="82%" nowrap="nowrap">
                  <c:if test='${step == 4}'>
                      <input type="hidden" name="collateuserid" id="collateuserid"/>
                      <input name="collateusername" id="collateusername" type="text" class="input_one2" readonly />
                      <img src="${themesPath}/oldimages/ren.gif" width="16" height="16" style="cursor:pointer;" onclick="collateuser()" >
                  </c:if>
                  <c:if test='${step != 4}'>
                      ${collateuser.displayname}
                  </c:if>
              </td>
            </tr>
          </table></td>
        <td  class="table_gw_td"><table width="98%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td width="18%" height="50" nowrap="nowrap">印刷：</td>
              <td width="82%" nowrap="nowrap">
                  <c:if test='${step == 7}'>
                      <input type="hidden" name="printuserid" id="printuserid"/>
                      <input name="printusername" id="printusername" type="text" class="input_one2" readonly />
                      <img src="${themesPath}/oldimages/ren.gif" width="16" height="16" style="cursor:pointer;" onclick="printuser()" >
                  </c:if>
                  <c:if test='${step != 7}'>
                      ${printuser.displayname}
                  </c:if>
              </td>
            </tr>
          </table></td>
        <td colspan="2"  class="table_gw_td"><table width="98%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td width="18%" height="50" nowrap="nowrap">份数：</td>
              <td width="82%">
                  <c:if test='${step == 7}'>
                      <input name="num" id="num" type="text" class="input_one2" value="${num}"/>
                  </c:if>
                  <c:if test='${step != 7}'>
                      ${num}
                  </c:if>
              </td>
            </tr>
          </table></td>
        </tr>
      <tr>
        <td height="50" colspan="6"  class="table_gw_td"><table width="98%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td width="10%" height="50">附件：</td>
              <td width="90%">
                  <s:iterator value ="attachs">
                      <a href='${ctx}/common/document/doc-attach!download?id=${id}' target='_blank'>
                          <img src='${themesPath}/oldimages/icons/doc.gif' border='0' style='cursor:pointer' alt='${filename}'></a>
                  </s:iterator>&nbsp;&nbsp;
                  <span class="textxing" style ="cursor:pointer;" onclick="docdocument();">附件</span><input type ="hidden" name="documentid" id="documentid" value="${docdocument.id}">
              </td>
            </tr>
          </table></td>
        </tr>
      <tr>
        <td height="50" colspan="6"  class="table_gw_td"><table width="98%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td width="10%" height="50">主题词：</td>
              <td width="90%">
                  <c:if test='${step == 1}'>
                      <input name="keyword" id="keyword" type="text" class="input_chang" value="${keyword}"/>
                  </c:if>
                  <c:if test='${step != 1}'>
                      ${keyword}
                  </c:if>
              </td>
            </tr>
          </table></td>
        </tr>
      <tr>
        <td height="50" colspan="6"  class="table_gw_td"><table width="98%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td width="10%" height="100">标题： </td>
              <td width="90%">
                  <c:if test='${step == 1}'>
                      <input name="title" id="title" type="text" class="input_chang" value="${title}"/>
                  </c:if>
                  <c:if test='${step != 1}'>
                      ${title}
                  </c:if>
              </td>
            </tr>
          </table></td>
        </tr>
      <td height="50" colspan="6"  class="table_gw_td"><table width="98%" border="0" cellpadding="0" cellspacing="0">
          <tr>
              <td width="10%" height="100">内容： </td>
              <td width="90%">
                  <c:if test='${step == 1}'>
                      <textarea name="content" id="content" class="input_three" >${content}</textarea>
                  </c:if>
                  <c:if test='${step != 1}'>
                      ${content}
                  </c:if>
              </td>
          </tr>
      </table></td>
      </tr>
      <tr>
          <td colspan="5" bgcolor="#eff6fe"><table width="100%" border="0" cellspacing="1" cellpadding="0">
              <tr valign="top">
                  <td width="45%"><div align="right">
                      <input type="submit" class="button_bc" name="input" value="保 存">
                  </div></td>
                  <td width="10%"><div align="center">
                      <input type="reset" class="button_cc" name="input" value="重 写">
                  </div></td>
                  <td width="45%"><input type="button" class="button_cc" name="input" value="返 回" onClick="history.back()"></td>
              </tr>
          </table></td>
      </tr>
    </table></td>
  </tr>
</form>
</table>
</body>
</html>
