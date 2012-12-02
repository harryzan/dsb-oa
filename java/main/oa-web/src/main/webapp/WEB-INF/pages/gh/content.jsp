<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>机关工会</title>
    <link href="${themesPath}/ghimages/style.css" rel="stylesheet" type="text/css"/>
    <style type="text/css">
        <!--
        .STYLE2 {
            color: #FFFFFF
        }

        -->
    </style>
</head>

<body>
<table width="1000" border="0" align="center">
    <tr>
        <td colspan="2"><img src="${themesPath}/ghimages/home.png" width="28" height="18" align="right"/></td>
    </tr>
    <tr>
        <td width="224"><img src="${themesPath}/ghimages/title.jpg" width="176" height="100"/></td>
        <td width="776">
            <table width="776" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td height="100" align="right" valign="top" background="${themesPath}/ghimages/title1.jpg">
                        <table width="680" border="0" align="left">
                            <tr>
                                <td width="20">&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                                <s:iterator value="ghTypes">
                                    <td width="100" height="30"><a href="index?tid=${id}" class="title">${name}</a></td>
                                </s:iterator>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<table width="1000" border="0" align="center" cellpadding="0" cellspacing="0" class="table_line">
    <tr>
        <td height="400">
            <table width="990" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                    <td height="390"><img src="${themesPath}/ghimages/huandeng1.jpg" width="990" height="390"/></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<table width="1000" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
        <td><img src="${themesPath}/ghimages/huandeng_bg.jpg" width="1000" height="20"/></td>
    </tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
<td valign="top" background="${themesPath}/ghimages/huandeng_bg1.jpg" style="background-repeat:repeat-x">
<table width="1000" border="0" align="center" cellpadding="0" cellspacing="0">
<tr>
    <td height="10" colspan="2"></td>
</tr>
<tr>
<td width="728" valign="top" background="${themesPath}/ghimages/huandeng_bg3.jpg" style="background-repeat:repeat-y">
    <table width="728" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td height="71" colspan="2" valign="top" background="${themesPath}/ghimages/huandeng_bg2.jpg"
                style="background-repeat:no-repeat">
                <table width="650" border="0" align="right" cellpadding="0" cellspacing="0">
                    <tr>
                        <td colspan="2">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="2" class="main_title">${gh.name}</td>
                    </tr>
                    <tr>
                        <td colspan="2" class="right_main_text"><span style=" color:#999999">栏目：</span>${gh.ghType.name}
                            ，<span style=" color:#999999">由 ${gh.createuser.displayname} 编辑 ${gh.starttime} </span></td>
                    </tr>
                    <tr>
                        <td width="626" height="1" background="${themesPath}/ghimages/right_line.jpg" bgcolor="#d8dbe2">
                            <img src="${themesPath}/ghimages/right_line.jpg" width="2" height="2"/></td>
                        <td width="14"></td>
                    </tr>
                    <tr>
                        <td colspan="2">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="2" class="main_text">
                            ${gh.description}
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td width="52" height="71" valign="top" style="background-repeat:no-repeat">&nbsp;</td>
            <td width="676" valign="top" style="background-repeat:no-repeat">
                <table width="650" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td colspan="2">&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="main_title_pinglun">评论：</td>
                        <td class="main_title_pinglun" align="right"><a href="#"></a></td>
                    </tr>
                    <tr>

                    </tr>
                </table>

                <s:iterator value="comments">
                    <table width="650" border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>

                            <td height="50" class="main_text">${createuser.displayname}</td>
                            <td height="50" align="right" class="main_text">
                                <table width="20%" border="0">
                                    <tr>
                                        <td nowrap="nowrap">${starttime}</td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="276"></td>
                        </tr>
                        <tr>
                            <td colspan="2" class="main_text">
                                    ${description}
                            </td>
                        </tr>
                        <tr>

                            <td colspan="2" width="374" height="1" background="${themesPath}/ghimages/right_line.jpg"
                                bgcolor="#d8dbe2"><img src="${themesPath}/ghimages/right_line.jpg" width="2"
                                                       height="2"/></td>
                        </tr>
                        <tr>
                            <td colspan="2" class="main_text">&nbsp;</td>

                        </tr>
                    </table>
                </s:iterator>

                <table width="650" border="0" align="center" cellpadding="0" cellspacing="0">

                    <tr>
                        <td class="main_title_pinglun">发表评论：</td>
                        <td class="main_title_pinglun" align="right"><a href="#"></a></td>
                    </tr>
                </table>
                <form action="content!save" method="post">
                    <input type="hidden" id="id" name="id" value="${gh.id}"/>
                <table width="650" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td height="50" colspan="2" class="main_text" align="center"><textarea name="content"
                                                                                               id="content" rows="10"
                                                                                               class="textarea"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td width="374"></td>
                    </tr>
                    <tr>
                        <td colspan="2" width="374" height="1" background="${themesPath}/ghimages/right_line.jpg"
                            bgcolor="#d8dbe2"><img src="${themesPath}/ghimages/right_line.jpg" width="2" height="2"/>
                        </td>
                    </tr>
                    <tr>
                        <td height="50" colspan="2" align="center" class="main_text"><input type="submit" name="button2"
                                                                                            id="button2" value="发表评论"/>
                        </td>
                    </tr>
                </table>
                </form>
            </td>
        </tr>
        <tr>
            <td height="71" colspan="2" valign="top" style="background-repeat:no-repeat">&nbsp;</td>
        </tr>
    </table>
</td>
<td valign="top">
    <table width="260" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td height="192" valign="top" background="${themesPath}/ghimages/right_3.jpg">
                <table width="260" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td height="10" colspan="3" bgcolor="#f5f5f7"></td>
                    </tr>
                    <tr>
                        <td colspan="3"><img src="${themesPath}/ghimages/right_1.jpg" width="259"
                                             height="31"/></td>
                    </tr>
                    <tr>
                        <td width="9"><img src="${themesPath}/ghimages/right_4.jpg" width="9"
                                           height="766"/></td>
                        <td width="242" valign="top"
                            background="${themesPath}/ghimages/right_6.jpg">
                            <table width="235" border="0" align="center" cellpadding="0"
                                   cellspacing="0">
                                <tr>
                                    <td><input type="text" name="textfield" id="textfield"
                                               class="input_1"/></td>
                                    <td><input type="submit" name="button" id="button" value=" "
                                               class="search_but"/></td>
                                </tr>
                                <tr>
                                    <td colspan="2"><br/>
                                        <table width="220" border="0" align="center" cellpadding="0"
                                               cellspacing="0">
                                            <tr>
                                                <td width="110" class="right_title_text"
                                                    align="center">分类栏目
                                                </td>
                                                <td width="1" rowspan="2" bgcolor="#d8dbe2"></td>
                                                <td width="109" class="right_title_text"
                                                    align="center">文章索引模板
                                                </td>
                                            </tr>
                                            <tr>
                                                <td valign="top">
                                                    <table width="100" border="0" align="center" valign="top">
                                                        <tr valign="top">
                                                            <td class="right_main_text" valign="top">
                                                                <s:iterator value="types">
                                                                <a href="index?typeid=${id}">
                                                                    &gt;${name} </a><a href="#"></a><br/>
                                                                </s:iterator>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td class="right_main_text">
                                                    <table width="100" border="0" align="center">
                                                        <tr>
                                                            <td class="right_main_text">
                                                                &gt; 2012年十二月<br/>
                                                                &gt; 2012年十一月<br/>
                                                                &gt; 2012年十月<br/>
                                                                &gt; 2012年九月<br/>
                                                                &gt; 2012年八月<br/>
                                                                &gt; 2012年七月<br/>
                                                                &gt; 2012年六月<br/>
                                                                &gt; 2012年五月<br/>
                                                                &gt; 2012年四月
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            <table width="235" border="0" align="center" cellpadding="0"
                                   cellspacing="0">
                                <tr>
                                    <td>&nbsp;</td>
                                </tr>
                                <tr>
                                    <td height="2"
                                        background="${themesPath}/ghimages/right_line.jpg"></td>
                                </tr>
                                <tr>
                                    <td height="2">&nbsp;</td>
                                </tr>
                            </table>
                            <table width="235" border="0" align="center" cellpadding="0"
                                   cellspacing="0">

                                <tr>
                                    <td>
                                        <table width="220" border="0" align="center" cellpadding="0"
                                               cellspacing="0">
                                            <tr>
                                                <td align="left" class="right_title_text">最近文章</td>
                                            </tr>
                                            <s:iterator value="ghs2">
                                                <tr>
                                                    <td class="right_main_text"><a href="#">
                                                        &gt; ${name}</a><br/>
                                                    </td>
                                                </tr>
                                            </s:iterator>

                                        </table>
                                        <table width="235" border="0" align="center" cellpadding="0"
                                               cellspacing="0">
                                            <tr>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td height="2"
                                                    background="${themesPath}/ghimages/right_line.jpg"></td>
                                            </tr>
                                            <tr>
                                                <td height="2">&nbsp;</td>
                                            </tr>
                                        </table>
                                        <table width="220" border="0" align="center" cellpadding="0"
                                               cellspacing="0">
                                            <tr>
                                                <td align="left" class="right_title_text">最近评论</td>
                                            </tr>
                                            <s:iterator value="ghComments">

                                                <tr>
                                                    <td class="right_main_text"><a href="content?id=${gh.id}">
                                                        &gt; ${fn:substring(description, 0, 20)}</a><br/>
                                                    </td>
                                                </tr>
                                            </s:iterator>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td width="9"><img src="${themesPath}/ghimages/right_5.jpg" width="9"
                                           height="766"/></td>
                    </tr>
                    <tr>
                        <td colspan="3">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="3">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="3">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="3"><img src="${themesPath}/ghimages/right_2.jpg" width="259"
                                             height="31"/></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</td>
</tr>
</table>
<table width="1000" border="0" align="center" cellpadding="0" cellspacing="0">

    <tr>
        <td width="728" valign="top">
            <table width="728" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td background="${themesPath}/ghimages/huandeng_bg3.jpg" style="background-repeat:repeat-y">
                        <table width="728" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td height="71" valign="top" background="${themesPath}/ghimages/huandeng_bg4.jpg">
                                    &nbsp;</td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td valign="top" bgcolor="#f5f6f8"><img src="${themesPath}/ghimages/foot_1.jpg" width="424" height="151"/></td>
        <td valign="bottom"><img src="${themesPath}/ghimages/foot_2.jpg" width="154" height="66"/></td>
    </tr>
</table>
</td>
</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td height="88" background="${themesPath}/ghimages/foot_3.jpg">
            <table width="1000" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                    <td>
                        <div align="center"><a href="#" class="cd">首页</a><span class="STYLE2"> | <a href="#" class="cd">本站说明</a> | <a
                                href="#" class="cd">工会概况</a> | <a href="#" class="cd">机构设置 </a>| <a href="#" class="cd">法律法规</a> | <a
                                href="#">相册</a></span></div>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
</body>
</html>
