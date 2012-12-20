<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" autoFlush="true" %>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>无标题文档</title>
    <link href="${themesPath}/css/style.css" rel="stylesheet" type="text/css" />
    <link href="${themesPath}/oldcss/style.css" rel="stylesheet" type="text/css">
    <style type="text/css">
        <!--
        .STYLE1 {color: #FF0000}
        -->
    </style>

    <script type="text/javascript" src="${scriptsPath}/system/jquery.min.js"></script>

    <script src="${scriptsPath}/highcharts/highcharts.js"></script>
    <script src="${scriptsPath}/highcharts/highcharts-more.js"></script>
    <script src="${scriptsPath}/highcharts/clock.js"></script>
    <script type="text/javascript" src="${scriptsPath}/system/calendar.js"></script>
    <script type="text/javascript" src="${scriptsPath}/system/function.js"></script>

    <script type="text/javascript">
        function changeday() {
            var value = document.getElementById("day").value;
            window.location = "main?day=" + value;
        }

        var url = "${url}";
        if(url.trim() != ""){
            location.replace(url);
        }
    </script>
</head>

<body bgcolor="#FFFFFF" style="overflow:hidden; height:100%" >
<table width="98%" height="100%" border="0" align="center">
<tr>
<td width="82%" valign="top">
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td width="10%" background="${themesPath}/images/sy_5.jpg"><img src="${themesPath}/images/sy_2.jpg" width="150" height="33" /></td>
            <td width="90%" background="${themesPath}/images/sy_5.jpg" align="left">&nbsp;&nbsp;
                <c:if test="${pageno > 1}">
                <a href="main?pageno=${pageno-1}">上一页</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                </c:if>
                <c:if test="${pageno < totalpages}">
                <a href="main?pageno=${pageno+1}">下一页</a>&nbsp;&nbsp;&nbsp;&nbsp;
                </c:if>
                <a href="${ctx}/message/bulletin/bulletin-grid-record">查看全部</a>
            </td>
        </tr>
        <tr>
            <td colspan="2"><div class="sy_line">
                <table width="100%" border="0">
                    <tr>
                        <td valign="top"><table width="90%" border="0" align="center">
                            <s:iterator value="bulletins">
                                <tr>
                                        <%--<td width="20%">${starttime}</td>--%>
                                    <td width="98%" align="left">&nbsp;<a href="bulletin!view?id=${id}">${name}</a></td>
                                </tr>
                            </s:iterator>
                        </table></td>
                    </tr>
                </table>
            </div>
                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td background="${themesPath}/images/sy_jiao2.jpg"><img src="${themesPath}/images/sy_jiao1.jpg" width="7" height="7" /></td>
                        <td background="${themesPath}/images/sy_jiao2.jpg"></td>
                        <td background="${themesPath}/images/sy_jiao2.jpg" align="right"><img src="${themesPath}/images/sy_jiao3.jpg" width="7" height="7" /></td>
                    </tr>
                </table></td>
        </tr>
    </table>
    <br />
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
        <td width="10%" background="${themesPath}/images/sy_4.jpg">
            <img src="${themesPath}/images/sy_1.jpg" width="150" height="33" />

        </td>
        <td width="90%" background="${themesPath}/images/sy_4.jpg">&nbsp;
            <a href="main?nweek=${beforeweek}&nyear=${beforeyear}">←&nbsp;上周&nbsp;</a>
            日期：
            <input name="day" id="day" class="input_one2" type="text" value="${day}"/>&nbsp;
            <img src="${themesPath}/oldimages/calendar.gif"  width="13" height="12" onClick="calendar(day,'date');" style="cursor:pointer">
            <input type="button" name="search" id="search" value="转到" class="search_but" onclick="changeday();"/>
            <a href="main?nweek=${afterweek}&nyear=${afteryear}">&nbsp;下周&nbsp;→</a>&nbsp;&nbsp;&nbsp;&nbsp;
            <a href="${ctx}/message/workarrange/work-arrange!record">查看全部</a>
        </td>
    </tr>
    <tr>
        <td colspan="2"><div class="sy_line">
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td width="14%" align="center" class="sy_text_1">星期一</td>
                    <td width="86%"><table width="99%" border="0" align="center" cellpadding="0" cellspacing="0">
                        <c:forEach items="${monarranges}" var="arrange" varStatus="status">
                            <tr>
                                <td title="${arrange.content}"><a href="${ctx}/message/workarrange/work-arrange!view?id=${arrange.id}" target="_blank">${fn:substring(arrange.content, 0, 40)}...</a></td>
                            </tr>
                        </c:forEach>
                    </table></td>
                </tr>
                <tr>
                    <td height="1" colspan="2" bgcolor="#dce6ef"></td>
                </tr>
                <tr>
                    <td align="center" class="sy_text_1">星期二</td>
                    <td><table width="99%" border="0" align="center" cellpadding="0" cellspacing="0">
                        <c:forEach items="${tusarranges}" var="arrange" varStatus="status">
                            <tr>
                                <td title="${arrange.content}"><a href="${ctx}/message/workarrange/work-arrange!view?id=${arrange.id}" target="_blank">${fn:substring(arrange.content, 0, 40)}...</a></td>
                            </tr>
                        </c:forEach>
                    </table></td>
                </tr>
                <tr>
                    <td height="1" colspan="2" bgcolor="#dce6ef"></td>
                </tr>
                <tr>
                    <td align="center" class="sy_text_1">星期三</td>
                    <td><table width="99%" border="0" align="center" cellpadding="0" cellspacing="0">
                        <c:forEach items="${wedarranges}" var="arrange" varStatus="status">
                            <tr>
                                <td title="${arrange.content}"><a href="${ctx}/message/workarrange/work-arrange!view?id=${arrange.id}" target="_blank">${fn:substring(arrange.content, 0, 40)}...</a></td>
                            </tr>
                        </c:forEach>
                    </table></td>
                </tr>
                <tr>
                    <td height="1" colspan="2" bgcolor="#dce6ef"></td>
                </tr>
                <tr>
                    <td align="center" class="sy_text_1">星期四</td>
                    <td><table width="99%" border="0" align="center" cellpadding="0" cellspacing="0">
                        <c:forEach items="${thearranges}" var="arrange" varStatus="status">
                            <tr>
                                <td title="${arrange.content}"><a href="${ctx}/message/workarrange/work-arrange!view?id=${arrange.id}" target="_blank">${fn:substring(arrange.content, 0, 40)}...</a></td>
                            </tr>
                        </c:forEach>
                    </table></td>
                </tr>
                <tr>
                    <td height="1" colspan="2" bgcolor="#dce6ef"></td>
                </tr>
                <tr>
                    <td align="center" class="sy_text_1">星期五</td>
                    <td><table width="99%" border="0" align="center" cellpadding="0" cellspacing="0">
                        <c:forEach items="${friarranges}" var="arrange" varStatus="status">
                            <tr>
                                <td title="${arrange.content}"><a href="${ctx}/message/workarrange/work-arrange!view?id=${arrange.id}" target="_blank">${fn:substring(arrange.content, 0, 40)}...</a></td>
                            </tr>
                        </c:forEach>
                    </table></td>
                </tr>
                <tr>
                    <td height="1" colspan="2" bgcolor="#dce6ef"></td>
                </tr>
                <tr>
                    <td align="center" class="sy_text_1">星期六</td>
                    <td><table width="99%" border="0" align="center" cellpadding="0" cellspacing="0">
                        <c:forEach items="${satarranges}" var="arrange" varStatus="status">
                            <tr>
                                <td title="${arrange.content}"><a href="${ctx}/message/workarrange/work-arrange!view?id=${arrange.id}" target="_blank">${fn:substring(arrange.content, 0, 40)}...</a></td>
                            </tr>
                        </c:forEach>
                    </table></td>
                </tr>
                <tr>
                    <td height="1" colspan="2"  bgcolor="#dce6ef"></td>
                </tr>
                <tr>
                    <td align="center" class="sy_text_1">星期日</td>
                    <td><table width="99%" border="0" align="center" cellpadding="0" cellspacing="0">
                        <c:forEach items="${sunarranges}" var="arrange" varStatus="status">
                            <tr>
                                <td title="${arrange.content}"><a href="${ctx}/message/workarrange/work-arrange!view?id=${arrange.id}" target="_blank">${fn:substring(arrange.content, 0, 40)}...</a></td>
                            </tr>
                        </c:forEach>
                    </table></td>
                </tr>
            </table>
        </div>
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td background="${themesPath}/images/sy_jiao2.jpg"><img src="${themesPath}/images/sy_jiao1.jpg" width="7" height="7" /></td>
                    <td background="${themesPath}/images/sy_jiao2.jpg"></td>
                    <td background="${themesPath}/images/sy_jiao2.jpg" align="right"><img src="${themesPath}/images/sy_jiao3.jpg" width="7" height="7" /></td>
                </tr>
            </table></td>
    </tr>
</table>
    <br />
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td width="10%" background="${themesPath}/images/sy_6.jpg"><img src="${themesPath}/images/sy_3.jpg" width="150" height="33" /></td>
            <td width="100%" background="${themesPath}/images/sy_6.jpg">&nbsp;</td>
        </tr>
        <tr>
            <td colspan="2"><div class="sy_line">
                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                        <td height="30"><table width="80%" border="0" align="center">
                            <tr>
                                <td><table width="50%" border="0">
                                    <tr>
                                        <td><img src="${themesPath}/images/sy_icon_1.jpg" width="23" height="25" /></td>
                                        <td nowrap="nowrap"><a href="${ctx}/message/message/message-grid?messagestatus=false&type=发文管理">发文管理<span class="STYLE1">（${count1}）</span></a></td>
                                    </tr>
                                </table></td>
                                <td><table width="50%" border="0">
                                    <tr>
                                        <td><img src="${themesPath}/images/sy_icon_2.jpg" width="41" height="22" /><a href="#"></a></td>
                                        <td nowrap="nowrap"><a href="${ctx}/message/message/message!act?id=${message2.id}" alt="${message2.name}">用车申请<span class="STYLE1">（${count2}）</span></a></td>
                                    </tr>
                                </table></td>
                                <td><table width="50%" border="0">
                                    <tr>
                                        <td><img src="${themesPath}/images/sy_icon_3.jpg" width="31" height="24" /><a href="#"></a></td>
                                        <td nowrap="nowrap"><a href="${ctx}/message/message/message!act?id=${message3.id}" alt="${message3.name}">需求申请<span class="STYLE1">（${count3}）</span></a></td>
                                    </tr>
                                </table></td>
                                <%--<td><table width="50%" border="0">--%>
                                    <%--<tr>--%>
                                        <%--<td><img src="${themesPath}/images/sy_icon_4.jpg" width="27" height="28" /><a href="#"></a></td>--%>
                                        <%--<td nowrap="nowrap"><a href="${ctx}/message/message/message-grid?messagestatus=false&flag=一周工作安排">工作安排<span class="STYLE1">（${count4}）</span></a></td>--%>
                                    <%--</tr>--%>
                                <%--</table></td>--%>
                            </tr>
                        </table></td>
                    </tr>
                </table>
            </div>
                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td background="${themesPath}/images/sy_jiao2.jpg"><img src="${themesPath}/images/sy_jiao1.jpg" width="7" height="7" /></td>
                        <td background="${themesPath}/images/sy_jiao2.jpg"></td>
                        <td background="${themesPath}/images/sy_jiao2.jpg" align="right"><img src="${themesPath}/images/sy_jiao3.jpg" width="7" height="7" /></td>
                    </tr>
                </table></td>
        </tr>
    </table></td>
<td width="280" valign="top" class="sy_right_bg"><table width="280" border="0" cellpadding="0" cellspacing="0">
<tr>
<td><table align="center" cellpadding="0" cellspacing="0"  id="1">
    <tr>
        <td><style>
            body,td,.p1,.p2,.i{font-family:arial}
            body{margin:6px 0 0 0;background-color:transparent;color:#000;}
            table{border:0}
            #cal{width:260px;border:1px solid #c3d9ff;font-size:12px;margin:0px 0 0 0px}
            #cal #top{height:29px;line-height:29px;background:transparent; background-image:url(${themesPath}/images/bg.jpg); background-repeat:repeat-x;color:#ffffff;padding-left:5px}
            #cal #top select{font-size:12px}
            #cal #top input{padding:0}
            #cal ul#wk{margin:0;padding:0;height:25px}
            #cal ul#wk li{float:left;width:36px;text-align:center;line-height:25px;list-style:none}
            #cal ul#wk li b{font-weight:normal;color:#c60b02}
            #cal #cm{clear:left;border-top:1px solid #ddd;border-bottom:1px dotted #ddd;position:relative}
            #cal #cm .cell{position:absolute;width:30px;height:36px;text-align:center;margin:0 0 0 9px}
            #cal #cm .cell .so{font:bold 12px arial;}
            #cal #bm{text-align:right;height:24px;line-height:24px;padding:0 13px 0 0}
            #cal #bm a{color:7977ce}
            #cal #fd{display:none;position:absolute;border:1px solid #dddddf;background:#feffcd;padding:10px;line-height:21px; z-index:10000; width:150px}
            #cal #fd b{font-weight:normal;color:#c60a00}
        </style>
            <!--[if IE]>
            <style>
                #cal #top{padding-top:4px}
                #cal #top input{width:65px}
                #cal #fd{width:170px}
            </style>
            <![endif]-->
            <div id="cal">
                <div id="top">公元
                    <select>
                    </select>
                    年
                    <select>
                    </select>
                    月  农历<span></span>年 [ <span></span>年 ]
                    <input type="button" value="回到今天" title="点击后跳转回今天" style="padding:0px">
                </div>
                <ul id="wk">
                    <li>一</li>
                    <li>二</li>
                    <li>三</li>
                    <li>四</li>
                    <li>五</li>
                    <li><b>六</b></li>
                    <li><b>日</b></li>
                </ul>
                <div id="cm"></div>
                <div id="bm"></div>
            </div></td>
    </tr>
</table>
    <script type="text/javascript" src="${scriptsPath}/system/main.js"></script>
</td>
</tr>
     <tr>
       <td>
           <div id="container" style="width: 260px; height: 260px; margin: 0 auto"></div>
       </td>
     </tr>
</table></td>
</tr>
</table>
</body>
</html>
