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
            window.location = "user-attendance!year?day=" + value;
        }
    </script>
    <style media=print type="text/css">
        .noprint{visibility:hidden}
    </style>
</head>
<body>
<table width="90%" border="0" align="center" cellpadding="0" cellspacing="0" class="table_line">
    <tr>
        <td colspan="13" class="line_td_title" align="center">${year}年&nbsp;考勤年报</td>
    </tr>
    <form action="user-attendance!sum" method="post">
        <tr class="noprint">
            <td colspan="13" class="line_td_search" align="center">
                <a href="user-attendance!year?year=${beforeyear}">←&nbsp;${beforeyear}年&nbsp;</a>
                日期：
                <input name="day" id="day" class="input_one2" type="text" value="${day}"/>&nbsp;
                <img src="${themesPath}/oldimages/calendar.gif"  width="13" height="12" onClick="calendar(day,'date');" style="cursor:pointer">
                <input type="button" name="search" id="search" value="搜索" class="search_but" onclick="changeday();"/>
                <a href="user-attendance!year?year=${afteryear}">&nbsp;${afteryear}年&nbsp;→</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="button" name="add" id="add" value="打印" onclick="window.print();" class="confirm_but"/>
            </td>
        </tr>
    <tr>
        <td class="line_td_headk">部门</td>
        <td class="line_td_headk">姓名</td>
        <td class="line_td_headk" nowrap="nowrap">出勤合计</td>
        <td class="line_td_headk">调休</td>
        <td class="line_td_headk">事假</td>
        <td class="line_td_headk">病假</td>
        <td class="line_td_headk">产假</td>
        <td class="line_td_headk">婚假</td>
        <td class="line_td_headk">哺乳假</td>
        <td class="line_td_headk">探亲假</td>
        <td class="line_td_headk">旷工</td>
        <td class="line_td_headk">公出</td>
        <td class="line_td_headk">其他</td>
    </tr>
        <c:set var="name" value=""/>
        <c:forEach items="${records}" var="attendance" varStatus="status">
        <tr>
            <c:if test="${attendance.DEPTNAME != name}">
                <td class="line_td_light4" width="15%" nowrap="nowrap">
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <font color="purple">${attendance.DEPTNAME}</font>
                </td>
            </c:if>
            <c:if test="${attendance.DEPTNAME == name}">
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
            <c:set var="name" value="${attendance.DEPTNAME}"/>
            <td class="line_td_light" width="10%" nowrap="nowrap">
                <font color="blue">${attendance.USERNAME}</font>
            </td>
            <td class="line_td_light" width="6%" align="center">
                <%--<c:if test='${attendance.noon == false}'>--%>
                    <%--上午--%>
                <%--</c:if>--%>
                <%--<c:if test='${attendance.noon == true}'>--%>
                    <%--下午--%>
                <%--</c:if>--%>
                ${attendance.TYPE1}
            </td>
            <td class="line_td_light" width="6%" align="center">${attendance.TYPE2}</td>
            <td class="line_td_light" width="6%" align="center">${attendance.TYPE3}</td>
            <td class="line_td_light" width="6%" align="center">${attendance.TYPE4}</td>
            <td class="line_td_light" width="6%" align="center">${attendance.TYPE5}</td>
            <td class="line_td_light" width="6%" align="center">${attendance.TYPE6}</td>
            <td class="line_td_light" width="6%" align="center">${attendance.TYPE7}</td>
            <td class="line_td_light" width="6%" align="center">${attendance.TYPE8}</td>
            <td class="line_td_light" width="6%" align="center">${attendance.TYPE9}</td>
            <td class="line_td_light" width="6%" align="center">${attendance.TYPE10}</td>
            <td class="line_td_light" width="6%" align="center">${attendance.TYPE0}</td>
        </tr>
    </c:forEach>
    </form>
</table>
</body>
</html>