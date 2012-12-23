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
            var count = 4;
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
            <input onclick="openFunction('car-use!input', this)" type="button" name="button2" id="button2" value="用车申请" class="tab_xz" />
            <c:if test='${isadmin}'>
                <input onclick="openFunction('car-grid', this)" type="button" name="button1" id="button1" value="车辆管理" class="tab" />
                <input onclick="openFunction('driver-grid', this)" type="button" name="button3" id="button3" value="驾驶员管理" class="tab" />
                <%--<input onclick="openFunction('car-check-grid', this)" type="button" name="button4" id="button4" value="申请审核" class="tab" />--%>
                <%--<input onclick="openFunction('car-drive-grid', this)" type="button" name="button5" id="button5" value="派车安排" class="tab" />--%>
            </c:if>
            <input onclick="openFunction('car-complete-grid', this)" type="button" name="button4" id="button4" value="用车信息" class="tab" />
        </td>
    </tr>
</table>
</body>
</html>