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
        function openFunction(url, input) {
            window.parent.frames.main_frame.location = url;
            var count = 2;
            for (var i = 1; i <= count; i++) {
                var button = document.getElementById('button' + i);
                button.className = 'tab';
            }
            input.className = 'tab_xz';
        }
    </script>
</head>
<body>
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
        <td>
            <input onclick="openFunction('instrument-grid?status=false')" type="button" name="button1" id="button1" value="办文管理" class="tab_xz" />
            <input onclick="openFunction('instrument-grid?status=true')" type="button" name="button2" id="button2" value="历史办文" class="tab" />
        </td>
    </tr>
</table>
</body>
</html>