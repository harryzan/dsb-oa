<%--
  Created by IntelliJ IDEA.
  User: cxs
  Date: 2010-4-1
  Time: 14:19:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/metaGrid.jsp" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一周工作安排查看</title>

<link href="${themesPath}/oldcss/style.css" rel="stylesheet" type="text/css">

    <script type="text/javascript" src="${scriptsPath}/system/calendar.js"></script>
    <script type="text/javascript" src="${scriptsPath}/system/function.js"></script>

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
            <form action="work-arrange!save?id=${id}" method="post" onSubmit="javascript:return check_form(this)">
                <input type ="hidden" name="gridParam" value='${gridParam}'>
                <input type ="hidden" name="bulletinstatus" value="${bulletinstatus}"> 
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
                              <td colspan="2" align="center" class="text_title">工作安排</td>
                          </tr>
                          <tr >
                            <td align="right" class="textone1">日期：</td>
                            <td width="70%" class="textone1">&nbsp;${year}
                            <input id="year" name="year" type="hidden" class="input_one" value="${year}"></td>
                          </tr>
                          <tr>
                              <td width="30%" class="textone1"><div align="right">周数：</div></td>
                              <td width="70%" class="textone1">&nbsp;第${week}周
                                  <input id="week" name="week" type="hidden" class="input_one" value="${week}">
                                  星期${dow}</td>
                          </tr>
                          <tr>
                            <td class="textone1"><div align="right" >工作内容：</div></td>
                            <td height="60" colspan="2" class="textone1">&nbsp;${content}</td>
                          </tr>
                      </table></td>
                      <td width="4" background="${themesPath}/oldimages/bg/you.gif"><img src="${themesPath}/oldimages/bg/you.gif" width="4" height="4"></td>
                    </tr>
                    <tr>
                      <td width="4" height="4" background="${themesPath}/oldimages/bg/xia.gif"><div align="right"><img src="${themesPath}/oldimages/bg/3.gif" width="4" height="4"></div></td>
                      <td height="4" background="${themesPath}/oldimages/bg/xia.gif"></td>
                      <td width="4" align="right"><img src="${themesPath}/oldimages/bg/4.gif" width="4" height="4"></td>
                    </tr><tr>
                            <td colspan="3" bgcolor="#eff6fe"><table width="100%" border="0" cellspacing="1" cellpadding="0">
                                <tr valign="top" align="center">
                                  <td width="45%"><br>
                                  <input type="button" class="button_cc" name="input" value="返 回" onClick="history.back();" align="center"></td></tr>
                            </table></td>
                          </tr>
                  </table>
                  </td>
                </tr>

            </form>
</table>
<script type="text/javascript">
    function check_form(afrom){
        if(afrom.name.value == ""){
            Ext.MessageBox.alert("提示", "标题不能为空！");
            return false;
        }
        if(afrom.description.value == ""){
            Ext.MessageBox.alert("提示", "内容不能为空！");
            return false;
        }
        return true;
    }

    function jia(){
        var viewuserids = eval("document.all.viewuserids").value;
        var viewusernames = eval("document.all.viewusernames").value;
        viewusernames = encodeURI(viewusernames);
        if(viewuserids != null && "" != viewuserids){
            returnvalue = window.showModalDialog("${ctx}/common/tree/multi-sys-user-tree?viewuserids="+viewuserids+"&viewusernames="+viewusernames);
        }else{
            returnvalue = window.showModalDialog("${ctx}/common/tree/multi-sys-user-tree");
        }
        if(returnvalue != undefined){

            var id = returnvalue.substring(returnvalue.indexOf("<id>")+4,returnvalue.indexOf("</id>"));
            var name = returnvalue.substring(returnvalue.indexOf("<name>")+6,returnvalue.indexOf("</name>"));
            eval("document.all.viewusernames").value = name;
            eval("document.all.viewuserids").value = id;
        }
    }

    function jian(){
        eval("document.all.viewusernames").value = "";
        eval("document.all.viewuserids").value = "";
    }

</script>
</body>
</html>