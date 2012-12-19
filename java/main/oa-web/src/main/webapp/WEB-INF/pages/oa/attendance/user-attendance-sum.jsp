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
    <style media=print type="text/css">
        .noprint{visibility:hidden}
    </style>
</head>
<body>
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0" class="table_line">
    <tr>
        <td colspan="13" class="line_td_title" align="center">考勤月报</td>
    </tr>
    <form action="user-attendance!sum" method="post">
        <tr class="noprint">
            <td colspan="13" class="line_td_search" align="center">
                <a href="user-attendance!sum?month=${beforemonth}&year=${beforeyear}">←${beforeyear}年&nbsp;第${beforemonth}月&nbsp;</a>
                日期：
                <input name="day" id="day" class="input_one2" type="text" value="${day}"/>&nbsp;
                <img src="${themesPath}/oldimages/calendar.gif"  width="13" height="12" onClick="calendar(day,'date');" style="cursor:pointer">
                <input type="button" name="search" id="search" value="搜索" class="search_but" onclick="changeday();"/>
                <a href="work-arrange!sum?month=${aftermonth}&year=${afteryear}">&nbsp;${afteryear}年&nbsp;第${aftermonth}月→</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="button" name="add" id="add" value="打印" onclick="window.print();" class="confirm_but"/>
            </td>
        </tr>
    <tr>
        <td class="line_td_head">部门</td>
        <td class="line_td_head">姓名</td>
        <td class="line_td_head">出勤</td>
        <td class="line_td_head">调休</td>
        <td class="line_td_head">事假</td>
        <td class="line_td_head">病假</td>
        <td class="line_td_head">产假</td>
        <td class="line_td_head">婚假</td>
        <td class="line_td_head">哺乳假</td>
        <td class="line_td_head">探亲假</td>
        <td class="line_td_head">旷工</td>
        <td class="line_td_head">公出</td>
        <td class="line_td_head">其他</td>
    </tr>
    <c:forEach items="${records}" var="attendance" varStatus="status">
        <tr>
            <td class="line_td_light" width="10%">&nbsp;&nbsp;&nbsp;&nbsp;${attendance.DEPTNAME}</td>
            <td class="line_td_light" width="10%">&nbsp;&nbsp;&nbsp;&nbsp;${attendance.USERNAME}</td>
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