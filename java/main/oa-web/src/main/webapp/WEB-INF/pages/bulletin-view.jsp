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

    <table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td colspan="2" bgcolor="#FFFFFF"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td height="50" valign="middle" align="center" class="gdmp_title">${name}</td>
                </tr>
                <tr>
                    <td valign="top" class="gdmp_text"><table width="100%" border="0" cellpadding="0" cellspacing="0" background="${themesPath}/images/gdmp_title1.png">
                        <tr>
                            <td height="5"></td>
                        </tr>
                    </table></td>
                </tr>
            </table></td>
        </tr>
        <tr>
            <td width="344" height="50" valign="top" bgcolor="#FFFFFF" class="gdmp_text"></td>
            <td width="290" valign="top" bgcolor="#FFFFFF" class="gdmp_text" align="right"></td>
        </tr>
        <tr>
            <td colspan="2" valign="top" bgcolor="#FFFFFF" class="gdmp_text">${description}</td>
        </tr>
        <tr>
            <td height="50" width="100%" colspan="3" align="center"><input type="button" class="button_cc" name="input" value="返 回" onClick="history.back();"></td>
        </tr>

    </table>

</td>
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
