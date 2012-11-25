<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>机关党委</title>
    <link href="${themesPath}/dwimages/style.css" rel="stylesheet" type="text/css" />
</head>

<body>
<table width="980" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><img src="${themesPath}/dwimages/title1.jpg" width="980" height="96" /></td>
  </tr>
  <tr>
    <td height="35" background="${themesPath}/dwimages/title2.jpg"><table width="950" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td><table width="800" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="62" align="center"><a href="index" class="cd">首页</a></td>
            <td width="1" align="center"><img src="${themesPath}/dwimages/title3.png" width="1" height="11" /></td>

            <s:iterator value="dwTypes">
                <td nowrap="nowrap" align="center"><a href="type?tid=${id}" class="cd">&nbsp;${name}&nbsp;</a></td>
                <td width="1" align="center"><img src="${themesPath}/dwimages/title3.png" width="1" height="11" /></td>
            </s:iterator>

          </tr>
        </table></td>
        </tr>
    </table></td>
  </tr>
</table>
<table width="980" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="5"></td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_line">
      <tr>
        <td width="71" height="24" background="${themesPath}/dwimages/title4.jpg"><img src="${themesPath}/dwimages/title5.jpg" /></td>
        <td background="${themesPath}/dwimages/title4.jpg">121</td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="5"></td>
  </tr>
</table>
<table width="980" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="730"><table width="723" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td height="332"><img src="${themesPath}/dwimages/title6.jpg" width="723" height="332" /></td>
      </tr>
    </table></td>
    <td width="250" valign="top"><table width="250" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td><img src="${themesPath}/dwimages/title7.jpg" width="250" height="38" /></td>
      </tr>
      <tr>
        <td valign="top"  background="${themesPath}/dwimages/title8.jpg"><table width="250" border="0" cellpadding="0" cellspacing="0">
            <s:iterator value="dws1">
                <tr>
                    <td width="32" height="25" align="center"><img src="${themesPath}/dwimages/d2.jpg" width="13" height="13" /></td>
                    <td width="202"><a href="content?id=${id}" target="_blank">${name}</a></td>
                </tr>
                <tr>
                    <td height="1" colspan="2" background="${themesPath}/dwimages/d3.jpg"></td>
                </tr>
            </s:iterator>
        </table></td>
      </tr>
      <tr>
        <td><img src="${themesPath}/dwimages/title9.jpg" width="250" height="10" /></td>
      </tr>
    </table></td>
  </tr>
</table>
<table width="980" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="5"></td>
  </tr>
</table>
<table width="981" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="730" valign="top"><table width="723" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td width="363"><table width="360" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td height="27" background="${themesPath}/dwimages/main_1.jpg"><table width="350" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td width="135" class="title_text">支部生活</td>
                <td width="215" align="right"><img src="${themesPath}/dwimages/more.png" width="36" height="13" /></td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td height="27" background="${themesPath}/dwimages/main_2.jpg"><table width="350" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td height="3"></td>
              </tr>
              <tr>
                  <td><table width="100%" border="0" cellpadding="0" cellspacing="0">
                      <s:iterator value="dws2">

                          <tr>
                              <td width="29" height="25" align="center"><img src="${themesPath}/dwimages/d1.jpg" /></td>
                              <td width="313"><a href="content?id=${id}">${name}</a></td>
                          </tr>
                          <tr>
                              <td height="1" colspan="2" background="${themesPath}/dwimages/d3.jpg"></td>
                          </tr>
                      </s:iterator>

                  </table></td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td background="${themesPath}/dwimages/main_2.jpg"><img src="${themesPath}/dwimages/main_3.jpg" width="360" height="6" /></td>
          </tr>
        </table></td>
        <td width="360"><table width="360" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td height="27" background="${themesPath}/dwimages/main_1.jpg"><table width="350" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td width="135" class="title_text">学习型党组织建设</td>
                <td width="215" align="right"><img src="${themesPath}/dwimages/more.png" width="36" height="13" /></td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td height="27" background="${themesPath}/dwimages/main_2.jpg"><table width="350" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td height="3"></td>
              </tr>
              <tr>
                <td><table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <s:iterator value="dws3">

                        <tr>
                            <td width="29" height="25" align="center"><img src="${themesPath}/dwimages/d1.jpg" /></td>
                            <td width="313"><a href="content?id=${id}">${name}</a></td>
                        </tr>
                        <tr>
                            <td height="1" colspan="2" background="${themesPath}/dwimages/d3.jpg"></td>
                        </tr>
                    </s:iterator>

                </table></td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td background="${themesPath}/dwimages/main_2.jpg"><img src="${themesPath}/dwimages/main_3.jpg" width="360" height="6" /></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td><table width="360" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td height="27" background="${themesPath}/dwimages/main_1.jpg"><table width="350" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td width="135" class="title_text">创先争优</td>
                <td width="215" align="right"><img src="${themesPath}/dwimages/more.png" width="36" height="13" /></td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td height="27" background="${themesPath}/dwimages/main_2.jpg"><table width="350" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td height="3"></td>
              </tr>
              <tr>
                <td><table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <s:iterator value="dws4">

                        <tr>
                            <td width="29" height="25" align="center"><img src="${themesPath}/dwimages/d1.jpg" /></td>
                            <td width="313"><a href="content?id=${id}">${name}</a></td>
                        </tr>
                        <tr>
                            <td height="1" colspan="2" background="${themesPath}/dwimages/d3.jpg"></td>
                        </tr>
                    </s:iterator>
                </table></td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td background="${themesPath}/dwimages/main_2.jpg"><img src="${themesPath}/dwimages/main_3.jpg" width="360" height="6" /></td>
          </tr>
        </table></td>
        <td><table width="360" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td height="27" background="${themesPath}/dwimages/main_1.jpg"><table width="350" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td width="135" class="title_text">文件下载</td>
                <td width="215" align="right"><img src="${themesPath}/dwimages/more.png" width="36" height="13" /></td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td height="27" background="${themesPath}/dwimages/main_2.jpg"><table width="350" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td height="3"></td>
              </tr>
              <tr>
                <td><table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <s:iterator value="dws5">

                        <tr>
                            <td width="29" height="25" align="center"><img src="${themesPath}/dwimages/d1.jpg" /></td>
                            <td width="313"><a href="content?id=${id}">${name}</a></td>
                        </tr>
                        <tr>
                            <td height="1" colspan="2" background="${themesPath}/dwimages/d3.jpg"></td>
                        </tr>
                    </s:iterator>
                </table></td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td background="${themesPath}/dwimages/main_2.jpg"><img src="${themesPath}/dwimages/main_3.jpg" width="360" height="6" /></td>
          </tr>
        </table></td>
      </tr>
    </table></td>
    <td width="250" rowspan="4" valign="top"><table width="250" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td><img src="${themesPath}/dwimages/title10.jpg" width="250" height="36" /></td>
      </tr>
      <tr>
        <td height="5"></td>
      </tr>
      <tr>
        <td><img src="${themesPath}/dwimages/title11.jpg" width="250" height="61" /></td>
      </tr>
      <tr>
        <td height="5"></td>
      </tr>
      <tr>
        <td><img src="${themesPath}/dwimages/title12.jpg" width="250" height="61" /></td>
      </tr>
      <tr>
        <td height="5"></td>
      </tr>
      <tr>
        <td><img src="${themesPath}/dwimages/title13.jpg" width="250" height="81" /></td>
      </tr>
      <tr>
          <td valign="top" background="${themesPath}/dwimages/title14.jpg"><table width="230" border="0" align="center" cellpadding="0" cellspacing="0">
              <s:iterator value="dws6">

                  <tr>
                      <td width="10" height="25"><img src="${themesPath}/dwimages/d4.jpg" width="3" height="3" /></td>
                      <td width="204"><a href="content?id=${id}">${name}</a></td>
                  </tr>
              </s:iterator>

          </table></td>
      </tr>
      <tr>
        <td><img src="${themesPath}/dwimages/title15.jpg" width="250" height="9" /></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="5"></td>
  </tr>
  <tr>
    <td width="723" height="21"  ><table width="723" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td height="28" background="${themesPath}/dwimages/jgwh_1.jpg"><table width="716" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="122" class="title_text">机关文化</td>
            <td width="585" align="right"><img src="${themesPath}/dwimages/more.png" width="36" height="13" /></td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td valign="top"><table width="723" border="0" cellpadding="0" cellspacing="0" class="table_line">
      <tr>
        <td valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
            <s:iterator value="dws7">

                <tr>
                    <td width="32" height="25" align="center"><img src="${themesPath}/dwimages/d1.jpg" /></td>
                    <td width="689"><a href="content?id=${id}">${name}</a></td>
                </tr>
                <tr>
                    <td height="1" colspan="2" background="${themesPath}/dwimages/d3.jpg"></td>
                </tr>
            </s:iterator>

        </table></td>
      </tr>
    </table></td>
  </tr>
</table>
<table width="980" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><br /></td>
  </tr>
  <tr>
    <td height="3" bgcolor="#ba1801"></td>
  </tr>
  <tr>
    <td bgcolor="#f5f4fa"><br />
      <table width="800" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td width="62" align="center"><a href="#" >首页</a></td>
          <td width="1" align="center"><img src="${themesPath}/dwimages/title3.png" width="1" height="11" /></td>
          <td width="77" align="center"><a href="#" >近期动态</a></td>
          <td width="1" align="center"><img src="${themesPath}/dwimages/title3.png" width="1" height="11" /></td>
          <td width="77" align="center"><a href="#">支部生活</a></td>
          <td width="1" align="center"><img src="${themesPath}/dwimages/title3.png" width="1" height="11" /></td>
          <td width="130" align="center" nowrap="nowrap"><a href="#">学习型党组织建设</a></td>
          <td align="center"><img src="${themesPath}/dwimages/title3.png" width="1" height="11" /></td>
          <td width="87" align="center"><a href="#" >党务公开</a></td>
          <td width="1" align="center"><img src="${themesPath}/dwimages/title3.png" width="1" height="11" /></td>
          <td width="87" align="center"><a href="#">创先争优</a></td>
          <td width="1" align="center"><img src="${themesPath}/dwimages/title3.png" width="1" height="11" /></td>
          <td width="87" align="center"><a href="#">机关文化</a></td>
          <td width="1" align="center"><img src="${themesPath}/dwimages/title3.png" width="1" height="11" /></td>
          <td width="87" align="center"><a href="#">组织架构</a></td>
          <td width="1" align="center"><img src="${themesPath}/dwimages/title3.png" width="1" height="11" /></td>
          <td width="87" align="center"><a href="#">文件下载</a></td>
          <td width="1" align="center"><img src="${themesPath}/dwimages/title3.png" width="1" height="11" /></td>
        </tr>
    </table>
    <br /></td>
  </tr>
</table>
</body>
</html>
