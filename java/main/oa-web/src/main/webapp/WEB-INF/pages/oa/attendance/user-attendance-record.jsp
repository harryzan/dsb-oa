<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="${themesPath}/css/style.css" rel="stylesheet" type="text/css" />
    <link href="${themesPath}/oldcss/style.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="${scriptsPath}/system/calendar.js"></script>
    <script type="text/javascript" src="${scriptsPath}/system/function.js"></script>
    <script type="text/javascript">
        function changeday() {
            var value = document.getElementById("day").value;
            window.location = "user-attendance!record?day=" + value;
        }
    </script>
</head>
<body>
<table width="90%" border="0" align="center" cellpadding="0" cellspacing="0" class="table_line">
    <tr>
        <td colspan="3" class="line_td_title" align="center">${day}&nbsp;考勤查询</td>
    </tr>
    <form action="user-attendance!save" method="post">
    <tr>
        <td colspan="3" class="line_td_search" align="center">
                <a href="user-attendance!record?day=${beforeday}">←${beforeday}</a>
            日期：
            <input name="day" id="day" class="input_one2" type="text" value="${day}"/>&nbsp;
            <img src="${themesPath}/oldimages/calendar.gif"  width="13" height="12" onClick="calendar(day,'date');" style="cursor:pointer">
            <input type="button" name="button" id="button" value="搜索" class="search_but" onclick="changeday();"/>
            <a href="user-attendance!record?day=${afterday}">${afterday}→</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <%--<input type="submit" name="submit" id="save" value="完成" class="confirm_but" onclick="return confirm('是否完成?');"/>--%>
        </td>
    </tr>
    <%--<tr>--%>
        <%--<td class="line_td_head">部门</td>--%>
        <%--<td class="line_td_head">姓名</td>--%>
        <%--<td class="line_td_head">考勤状态</td>--%>
    <%--</tr>--%>
        <c:set var="name" value=""/>
        <c:forEach items="${attendances}" var="attendance" varStatus="status">
        <tr>
            <input type="hidden" name="attid" value="${attendance.id}"/>
            <c:if test='${attendance.noon == false}'>
            <td rowspan="2" class="line_td_light" width="10%" nowrap="nowrap">
                <c:if test="${attendance.user.sysdept.name != name}">
                    <font color="purple">${attendance.user.sysdept.name}</font>
                </c:if>
                <c:set var="name" value="${attendance.user.sysdept.name}"/>
            </td>
            <td rowspan="2" class="line_td_light" width="10%" nowrap="nowrap">
                <font color="blue">${attendance.user.displayname}</font>
            </td>
            </c:if>
            <td class="line_td_light" width="40%">&nbsp;&nbsp;
                <c:if test='${attendance.noon == false}'>
                    上午
                </c:if>
                <c:if test='${attendance.noon == true}'>
                    下午
                </c:if>
                &nbsp;&nbsp;

                <c:if test='${attendance.type == 1}'>出勤</c:if>
                <c:if test='${attendance.type == 2}'>调休</c:if>
                <c:if test='${attendance.type == 3}'>事假</c:if>
                <c:if test='${attendance.type == 4}'>病假</c:if>
                <c:if test='${attendance.type == 5}'>产假</c:if>
                <c:if test='${attendance.type == 6}'>婚假</c:if>
                <c:if test='${attendance.type == 7}'>哺乳假</c:if>
                <c:if test='${attendance.type == 8}'>探亲假</c:if>
                <c:if test='${attendance.type == 9}'>旷工</c:if>
                <c:if test='${attendance.type == 10}'>公出</c:if>
                <c:if test='${attendance.type == 0}'>其他: ${attendance.memo}</c:if>
            </td>
        </tr>
    </c:forEach>
    </form>
</table>
</body>
</html>