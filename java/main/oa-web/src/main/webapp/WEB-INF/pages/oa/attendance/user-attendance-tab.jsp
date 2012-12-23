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
            var count = 6;
            for (var i = 1; i <= count; i++) {
                var button = document.getElementById('button' + i);
                button.className = 'tab';
            }
            input.className = 'tab_xz';
        }

    </script>
</head>
<body <c:if test='${isadmin}'>
        onload="openFunction('user-attendance!day', document.getElementById('button1'));"
</c:if>>
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
        <td>
            <c:if test='${isadmin}'>
                <input onclick="openFunction('user-attendance!day',this)" type="button" name="button1" id="button1" value="考勤管理" class="tab" />
            </c:if>
            <input onclick="openFunction('user-attendance!record', this)" type="button" name="button2" id="button2" value="日期查询" class="tab" />
            <input onclick="openFunction('sys-dept-main', this)" type="button" name="button3" id="button3" value="部门查询" class="tab" />
            <input onclick="openFunction('sys-user-main', this)" type="button" name="button4" id="button4" value="人员查询" class="tab" />
            <c:if test='${isadmin}'>
                <input onclick="openFunction('user-attendance!sum', this)" type="button" name="button5" id="button5" value="考勤月报" class="tab" />
                <input onclick="openFunction('user-attendance!year', this)" type="button" name="button6" id="button6" value="考勤年报" class="tab" />
            </c:if>
        </td>
    </tr>
</table>
</body>
</html>