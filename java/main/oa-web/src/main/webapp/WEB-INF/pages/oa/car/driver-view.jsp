<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2009-5-15
  Time: 12:21:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ include file="/common/metaMocha.jsp" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>驾驶员信息查看</title>
<link href="${themesPath}/css/style.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="${scriptsPath}/mootools/noobSlide/web.css" type="text/css" media="screen" />
	<link rel="stylesheet" href="${scriptsPath}/mootools/noobSlide/style.css" type="text/css" media="screen" />
	<script type="text/javascript" src="${scriptsPath}/mootools/mootools-core.js"></script>
	<script type="text/javascript" src="${scriptsPath}/mootools/noobSlide/noobSlide_packed.js"></script>
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
<%--<td height="23" valign="bottom" class="textone" align="center"><strong>查看型号信息</strong></td>--%>
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

                <tr>
                  <td valign="top">
                      <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td width="4" height="4" background="${themesPath}/oldimages/bg/shang.gif"><div align="right"><img src="${themesPath}/oldimages/bg/1.gif" width="4" height="4"></div></td>
                      <td height="4" background="${themesPath}/oldimages/bg/shang.gif"></td>
                      <td width="4" height="4" align="right"><img src="${themesPath}/oldimages/bg/2.gif" width="4" height="4"></td>
                    </tr>
                    <tr>
                      <td width="4" background="${themesPath}/oldimages/bg/zuo.gif"><img src="${themesPath}/oldimages/bg/zuo.gif" width="4" height="4"></td>
                      <td valign="top" bgcolor="#FFFFFF">
                      <table width="100%" border="0" cellpadding="0" cellspacing="0">
                          <tr class="textone1">
                              <td colspan="2" class="text_title"><div align="center">驾驶员信息</div></td>
                          </tr>
                          <tr class="textone1">
                            <td align="right" class="textone1">姓名：</td>
                            <td width="70%" class="textone1">&nbsp;${name}</td>
                          </tr>
                          <tr class="textone12">
                              <td width="30%"class="textone1"><div align="right">性别：</div></td>
                              <td width="70%" class="textone1">&nbsp;${sex}</td>
                                  <%--<input name="name" type="text" class="input_one" value="${name}">--%>
                          </tr>
                          <tr class="textone1">
                              <td width="30%" class="textone1"><div align="right">出生日期：</div></td>
                              <td width="70%" class="textone1">&nbsp;${birthday}</td>
                          </tr>
                          <tr class="textone12">
                              <td width="30%" class="textone1"><div align="right">驾龄：</div></td>
                              <td width="70%" class="textone1">&nbsp;${years}"年</td>
                          </tr>
                          <tr class="textone1">
                              <td width="30%" class="textone1"><div align="right">驾驶证号：</div></td>
                              <td width="70%" class="textone1">&nbsp;${license}</td>
                          </tr>
                          <tr class="textone12">
                              <td width="30%" class="textone1"><div align="right">驾照期限：</div></td>
                              <td width="70%" class="textone1">&nbsp;${licenselimit}</td>
                          </tr>
                          <tr class="textone1">
                              <td width="30%" class="textone1"><div align="right">驾照等级：</div></td>
                              <td width="70%" class="textone1">&nbsp;${licenselevel}</td>
                          </tr>
                          <tr class="textone12">
                              <td width="30%" class="textone1"><div align="right">手机：</div></td>
                              <td width="70%" class="textone1">&nbsp;${cellphone}</td>
                          </tr>
                          <tr class="textone1">
                              <td width="30%" class="textone1"><div align="right">电话：</div></td>
                              <td width="70%" class="textone1">&nbsp;${phone}</td>
                          </tr>
                          <tr class="textone12">
                              <td class="textone1"><div align="right">备注：</div></td>
                              <td height="70" class="textone1">&nbsp;${memo}</td>
                          </tr>
                        </table>
                      </td>
                      <td width="4" background="${themesPath}/oldimages/bg/you.gif"><img src="${themesPath}/oldimages/bg/you.gif" width="4" height="4"></td>
                    </tr>
                    <tr>
                      <td width="4" height="4" background="${themesPath}/oldimages/bg/xia.gif"><div align="right"><img src="${themesPath}/oldimages/bg/3.gif" width="4" height="4"></div></td>
                      <td height="4" background="${themesPath}/oldimages/bg/xia.gif"></td>
                      <td width="4" align="right"><img src="${themesPath}/oldimages/bg/4.gif" width="4" height="4"></td>
                    </tr><tr>
                <td colspan="3"><table width="100%" border="0" cellspacing="1" cellpadding="0">
                    <tr>
                      <td width="45%"><div align="right">
                      </div></td>
                      <td width="10%"><div align="center">
                          <input type="button" class="button_cc" name="input" value="返 回" onClick="window.back();">
                      </div></td>
                      <td width="45%"></td>
                    </tr>
                </table></td>
              </tr>
                  </table>
                  </td>
                </tr>

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
	window.addEvent('domready',function(){
        var total = 0;
        <s:iterator value="attachs" status="status">total = ${status.index + 1};</s:iterator>
        var arr = new Array();
        for(var i = 0; i < total; i++){
            arr[i] = i;
        }
		//SAMPLE 2 (transition: Bounce.easeOut)
		new noobSlide({
			box: $('box2'),
			items: arr,
			interval: 3000,
			fxOptions: {
				duration: 1000,
				transition: Fx.Transitions.Bounce.easeOut,
				wait: false
			},
			addButtons: {
				previous: $('prev1'),
				play: $('play1'),
				stop: $('stop1'),
				next: $('next1')
			}
		});
	});
</script>

</body>
</html>
