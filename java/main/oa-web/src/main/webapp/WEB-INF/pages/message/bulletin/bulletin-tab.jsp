<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="${themesPath}/css/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        function openFunction(url) {
            window.parent.frames.main_frame.location = url;
        }
    </script>
</head>
<body>
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
        <td>
            <input onclick="openFunction('bulletin-grid?bulletinstatus=false')" type="button" name="button1" id="button1" value="通知公告管理" class="tab_xz" />
            <input onclick="openFunction('bulletin-grid?bulletinstatus=true')" type="button" name="button2" id="button2" value="已过期通知公告" class="tab" />
        </td>
    </tr>
</table>
</body>
</html>