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
<table width="980" border="0" align="center">
  <tr>
    <td height="5"></td>
  </tr>
</table>
<table width="980" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td valign="top"><table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td height="33" background="${themesPath}/dwimages/line.jpg"><table width="99%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td align="right" class="title_text1">${dw.dwType.name}</td>
            </tr>
          </table></td>
        </tr>
    </table>
      <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0" class="table_line">
        <tr>
          <td valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td height="25" align="center"><table width="98%" border="0" align="center">
                <tr>
                  <td>&nbsp;</td>
                </tr>
                <tr>
                  <td class="tcy_title">${dw.name}</td>
                </tr>
                <tr>
                  <td align="center"><p>${dw.starttime}</p></td>
                </tr>
                <tr>
                  <td class="tcy_text">

                  ${dw.description}
                  </td>
                </tr>
              </table></td>
              </tr>
            <tr>
              <td height="1" background="${themesPath}/dwimages/d3.jpg"></td>
              </tr>
            <tr>
              <td height="1" background="${themesPath}/dwimages/d3.jpg"></td>
            </tr>
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
