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
            <input onclick="openFunction('demand-use!input', this)" type="button" name="button1" id="button1" value="${demandType.name}申请" class="tab" />
            <%--<c:if test='${isadmin}'>--%>
            <%--<input onclick="openFunction('demand-check-grid', this)" type="button" name="button3" id="button3" value="${demandType.name}审核" class="tab" />--%>
            <%--<input onclick="openFunction('demand-app-grid', this)" type="button" name="button4" id="button4" value="${demandType.name}安排" class="tab" />--%>
            <%--</c:if>--%>
            <input onclick="openFunction('demand-complete-grid', this)" type="button" name="button2" id="button2" value="${demandType.name}信息" class="tab_xz" />
        </td>
    </tr>
</table>
</body>
</html>