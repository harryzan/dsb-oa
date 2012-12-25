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
    <tr>
        <td class="line_td_headk" width="15%">部门</td>
        <td class="line_td_headk" width="15%">姓名</td>
        <td class="line_td_headk" width="60%">考勤状态(上午 下午)</td>
    </tr>
        <c:set var="name" value=""/>
        <c:set var="lasttype" value=""/>
        <c:set var="lastmemo" value=""/>
        <c:forEach items="${attendances}" var="attendance" varStatus="status">
            <c:if test='${attendance.noon == false}'>
                <c:set var="lasttype" value="${attendance.type}"/>
                <c:set var="lastmemo" value="${attendance.memo}"/>
            </c:if>
            <c:if test='${attendance.noon == true}'>
                <tr>
                    <input type="hidden" name="attid" value="${attendance.id}"/>
                    <c:if test="${attendance.user.sysdept.name != name}">
                        <td class="line_td_light4" width="15%" nowrap="nowrap">
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <font color="purple">${attendance.user.sysdept.name}</font>
                        </td>
                    </c:if>
                    <c:if test="${attendance.user.sysdept.name == name}">
                        <c:choose>
                            <c:when test="${status.last}">
                                <td class="line_td_light5" width="15%" nowrap="nowrap">
                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                        <%--<font color="purple">${attendance.user.sysdept.name}</font>--%>
                                </td>
                            </c:when>
                            <c:otherwise>
                                <td class="line_td_light3" width="15%" nowrap="nowrap">
                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                        <%--<font color="purple">${attendance.user.sysdept.name}</font>--%>
                                </td>
                            </c:otherwise>
                        </c:choose>
                    </c:if>
                    <c:set var="name" value="${attendance.user.sysdept.name}"/>
                    <td class="line_td_light" width="15%" nowrap="nowrap">
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="blue">${attendance.user.displayname}</font>
                    </td>
                    <td class="line_td_light">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <c:if test='${lasttype == 1}'>出勤</c:if><c:if test='${lasttype == 2}'>调休</c:if><c:if test='${lasttype == 3}'>事假</c:if><c:if test='${lasttype == 4}'>病假</c:if><c:if test='${lasttype == 5}'>产假</c:if><c:if test='${lasttype == 6}'>婚假</c:if><c:if test='${lasttype == 7}'>哺乳假</c:if><c:if test='${lasttype == 8}'>探亲假</c:if><c:if test='${lasttype == 9}'>旷工</c:if><c:if test='${lasttype == 10}'>公出</c:if><c:if test='${lasttype == 0}'>其他: ${lastmemo}</c:if>
                        &nbsp;&nbsp;&nbsp;&nbsp;
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
                            <%--</c:if>--%>
                    </td>
                </tr>
            </c:if>
        </c:forEach>
    </form>
</table>
</body>
</html>