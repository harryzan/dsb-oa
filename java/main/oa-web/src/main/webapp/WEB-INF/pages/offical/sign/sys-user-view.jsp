<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2009-5-19
  Time: 10:18:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户信息查看</title>
<link href="${themesPath}/oldcss/style.css" rel="stylesheet" type="text/css">
</head>
    <script language="javascript">
        if (parent.tree_frame != null)
            parent.tree_frame.updateParent(parent.tree_frame.lastSelectedNode);
    </script>

<script type="text/javascript">
    window.addEvent('domready',function(){
        var total = 0;
        <s:iterator value="attachs" status="status">total = ${status.index + 1};</s:iterator>
        var arr = new Array(0);
        for(var i = 0; i < total; i++){
            arr[i] = i;
        }
        //SAMPLE 2 (transition: Bounce.easeOut)
        var nS2 = new noobSlide({
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
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<%--<table width="100%"  border="0" cellpadding="0" cellspacing="0">--%>
      <%--<tr>--%>
        <%--<td width="10" height="27" nowrap background="${themesPath}/oldimages/bgzuo.gif">&nbsp;</td>--%>
        <%--<td background="${themesPath}/oldimages/bgz.gif"><table width="100%" height="10"  border="0" align="right" cellpadding="0" cellspacing="2">--%>
            <%--<tr>--%>
              <%--<td width="20" class="textone">&nbsp;</td>--%>
              <%--<td height="23" valign="bottom" class="textone" align="center"><strong>维护用户信息</strong></td>--%>
              <%--<td width="20">&nbsp;</td>--%>
            <%--</tr>--%>
        <%--</table></td>--%>
        <%--<td width="10" height="27" nowrap background="${themesPath}/oldimages/bgyou.gif">&nbsp;</td>--%>
      <%--</tr>--%>
      <%--<tr>--%>
        <%--<td background="${themesPath}/oldimages/bgtua.gif">&nbsp;</td>--%>
        <%--<td valign="top" bgcolor="#eff6fe">--%>
        <table width="100%" height="100%" border="0" align="center" cellpadding="0" cellspacing="1">
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
                          <tr class="textone1">
                            <td width="32%"><div align="right">用户名：</div></td>
                            <td width="68%">&nbsp;${loginname}</td>
                          </tr>
                          <tr class="textone12">
                            <td><div align="right">显示名：</div></td>
                            <td>&nbsp;${displayname}</td>
                          </tr>
                          <tr class="textone1">
                              <td><div align="right">电子签名：</div></td>
                              <td height="60"><div class="mask2">
                                  <div id="box2">
                                      <s:iterator value="attachs">
                                          <span><img src="${ctx}/common/document/doc-attach!displayPic?id=${id}" alt="${filename}" height="150px" width="200px" ></span>
                                      </s:iterator>
                                      <span></span>
                                  </div>
                              </div>
                                  <p class="buttons">
                                      <span id="prev1">&lt;&lt; 上一张</span>
                                      <span id="play1">幻灯片 &gt;</span>
                                      <span id="stop1">停止</span>
                                      <span id="next1">下一张 &gt;&gt;</span>
                                  </p></td>
                          </tr>
                          <%--<tr class="textone1">--%>
                            <%--<td><div align="right">电话：</div></td>--%>
                            <%--<td>&nbsp;${phonenumber}</td>--%>
                          <%--</tr>--%>
                          <%--<tr class="textone12">--%>
                            <%--<td><div align="right">邮箱：</div></td>--%>
                            <%--<td>&nbsp;${email}</td>--%>
                          <%--</tr>--%>
                          <%--<tr class="textone1">--%>
                            <%--<td><div align="right">状态：</div></td>--%>
                            <%--<td>&nbsp;${status ? "激活" : "禁用"}</td>--%>
                          <%--</tr>--%>
                        </table></td>
                      <td width="4" background="${themesPath}/oldimages/bg/you.gif"><img src="${themesPath}/oldimages/bg/you.gif" width="4" height="4"></td>
                    </tr>
                    <tr>
                      <td width="4" height="4" background="${themesPath}/oldimages/bg/xia.gif"><div align="right"><img src="${themesPath}/oldimages/bg/3.gif" width="4" height="4"></div></td>
                      <td height="4" background="${themesPath}/oldimages/bg/xia.gif"></td>
                      <td width="4" align="right"><img src="${themesPath}/oldimages/bg/4.gif" width="4" height="4"></td>
                    </tr>
                  </table>
                  </td>
                </tr>
              <tr>
                <td>&nbsp;</td>
              </tr>
        </table>
        <%--</td><td background="${themesPath}/oldimages/bgtub.gif">&nbsp;</td>--%>
      <%--</tr>--%>
      <%--<tr>--%>
        <%--<td valign="top"><img src="${themesPath}/oldimages/bgtuc.gif" width="10" height="11"></td>--%>
        <%--<td height="11" background="${themesPath}/oldimages/bgxia.gif"></td>--%>
        <%--<td valign="top"><img src="${themesPath}/oldimages/bgtud.gif" width="10" height="11"></td>--%>
      <%--</tr>--%>
    <%--</table>--%>
</body>
</html>
