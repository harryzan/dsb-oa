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
            var count = 3;
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
            <input onclick="openFunction('item-use!input', this)" type="button" name="button2" id="button2" value="领用申请" class="tab" />
            <c:if test='${isadmin}'>
            <input onclick="openFunction('item-complete-grid', this)" type="button" name="button3" id="button3" value="领用管理" class="tab_xz" />
                <input onclick="openFunction('item-grid', this)" type="button" name="button1" id="button1" value="日常用品管理" class="tab" />
                <%--<input onclick="openFunction('item-complete-grid', this)" type="button" name="button4" id="button4" value="历史审核" class="tab" />--%>
            </c:if>
        </td>
    </tr>
</table>
</body>
</html>