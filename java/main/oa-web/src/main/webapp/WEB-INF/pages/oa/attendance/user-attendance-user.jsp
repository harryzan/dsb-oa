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
            window.location = "user-attendance!week?userid=${userid}&deptid=${deptid}&day=" + value;
        }
    </script>
</head>
<body>
<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0" class="table_line">
    <tr>
        <td colspan="2" class="line_td_title" align="center">人员考勤查询（一周）</td>
    </tr>
    <form action="user-attendance!save" method="post">
    <tr>
        <td colspan="2" class="line_td_search" align="center">
                <a href="user-attendance!record?userid=${userid}&deptid=${deptid}&week=${beforeweek}&year=${beforeyear}">←${beforeyear}年&nbsp;第${beforeweek}周&nbsp;</a>
            日期：
            <input name="day" id="day" class="input_one2" type="text" value="${day}"/>&nbsp;
            <img src="${themesPath}/oldimages/calendar.gif"  width="13" height="12" onClick="calendar(day,'date');" style="cursor:pointer">
            <input type="button" name="search" id="search" value="搜索" class="search_but" onclick="changeday();"/>
            <a href="user-attendance!record?userid=${userid}&deptid=${deptid}&week=${afterweek}&year=${afteryear}">&nbsp;${afteryear}年&nbsp;第${afterweek}周→</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <%--<input type="submit" name="add" id="add" value="完成" class="confirm_but"/>--%>
        </td>
    </tr>
        <tr>
            <td class="line_td_headk">日期</td>
            <td class="line_td_headk">上午&nbsp;&nbsp;下午</td>
        </tr>
        <c:set var="lasttype" value=""/>
        <c:set var="lastmemo" value=""/>
        <c:forEach items="${attendances}" var="attendance" varStatus="status">
            <c:if test='${attendance.noon == false}'>
                <c:set var="lasttype" value="${attendance.type}"/>
                <c:set var="lastmemo" value="${attendance.memo}"/>
            </c:if>
            <c:if test='${attendance.noon == true}'>
            <tr>
                <td class="line_td_light" width="10%" align="right" valign="top" nowrap="nowrap">&nbsp;&nbsp;&nbsp;&nbsp;${attendance.checkdate}</td>
                <td class="line_td_light" width="40%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <c:if test='${lasttype == 1}'>出勤</c:if>
                    <c:if test='${lasttype == 2}'>调休</c:if>
                    <c:if test='${lasttype == 3}'>事假</c:if>
                    <c:if test='${lasttype == 4}'>病假</c:if>
                    <c:if test='${lasttype == 5}'>产假</c:if>
                    <c:if test='${lasttype == 6}'>婚假</c:if>
                    <c:if test='${lasttype == 7}'>哺乳假</c:if>
                    <c:if test='${lasttype == 8}'>探亲假</c:if>
                    <c:if test='${lasttype == 9}'>旷工</c:if>
                    <c:if test='${lasttype == 10}'>公出</c:if>
                    <c:if test='${lasttype == 0}'>其他: ${lastmemo}</c:if>
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
                </td>
            </tr>
            </c:if>
        </c:forEach>
    </form>
</table>
</body>
</html>