<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<%@ include file="/common/metaWait.jsp" %>

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
            window.location = "user-attendance!day?day=" + value;
        }

        function changetype() {
            var objs = document.getElementsByName("atttype");
            var memos = document.getElementsByName("memo");

//            alert(objs.length);
            for (var i = 0; i < objs.length; i++) {
                var select = objs[i];
                var option = select.options[select.selectedIndex];
//                alert(option.value);
                if (option.value == '0') {
                    memos[i].style.display = "block";
                }
                else {
                    memos[i].style.display = "none";
                }
            }
        }

    </script>
</head>
<body>
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0" class="table_line">
    <tr>
        <td colspan="3" class="line_td_title" align="center">个人考勤</td>
    </tr>
    <form action="user-attendance!save" method="post">
    <tr>
        <td colspan="3" class="line_td_search" align="center">
                <a href="user-attendance!day?day=${beforeday}">←${beforeday}</a>
            日期：
            <input name="day" id="day" class="input_one2" type="text" value="${day}"/>&nbsp;
            <img src="${themesPath}/oldimages/calendar.gif"  width="13" height="12" onClick="calendar(day,'date');" style="cursor:pointer">
            <input type="button" name="button" id="button" value="搜索" class="search_but" onclick="changeday();"/>
            <a href="user-attendance!day?day=${afterday}">${afterday}→</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="submit" name="submit" id="save" value="完成" class="confirm_but" onclick="return confirm('是否完成?');"/>
        </td>
    </tr>
    <tr>
        <td class="line_td_head">部门</td>
        <td class="line_td_head">姓名</td>
        <td class="line_td_head">考勤状态</td>
    </tr>
    <c:forEach items="${attendances}" var="attendance" varStatus="status">
        <tr>
            <input type="hidden" name="attid" value="${attendance.id}"/>
            <c:if test='${attendance.noon == false}'>
            <td rowspan="2" class="line_td_light" width="20%">&nbsp;&nbsp;&nbsp;&nbsp;${attendance.user.sysdept.name}</td>
            <td rowspan="2" class="line_td_light" width="20%">&nbsp;&nbsp;&nbsp;&nbsp;${attendance.user.displayname}</td>
            </c:if>
            <td class="line_td_light" width="60%" nowrap="nowrap">&nbsp;&nbsp;
                <c:if test='${attendance.noon == false}'>
                  上午
                </c:if>
                <c:if test='${attendance.noon == true}'>
                  下午
                </c:if>
                &nbsp;&nbsp;
                <select name="atttype" id="atttype" onchange="changetype();">
                    <option value="1" <c:if test='${attendance.type == 1}'>selected</c:if>>出勤</option>
                    <option value="2" <c:if test='${attendance.type == 2}'>selected</c:if>>调休</option>
                    <option value="3" <c:if test='${attendance.type == 3}'>selected</c:if>>事假</option>
                    <option value="4" <c:if test='${attendance.type == 4}'>selected</c:if>>病假</option>
                    <option value="5" <c:if test='${attendance.type == 5}'>selected</c:if>>产假</option>
                    <option value="6" <c:if test='${attendance.type == 6}'>selected</c:if>>婚假</option>
                    <option value="7" <c:if test='${attendance.type == 7}'>selected</c:if>>哺乳假</option>
                    <option value="8" <c:if test='${attendance.type == 8}'>selected</c:if>>探亲假</option>
                    <option value="9" <c:if test='${attendance.type == 9}'>selected</c:if>>旷工</option>
                    <option value="10" <c:if test='${attendance.type == 10}'>selected</c:if>>公出</option>
                    <option value="0" <c:if test='${attendance.type == 0}'>selected</c:if>>其他</option>
                </select>&nbsp;&nbsp;
                <input id="memo" name="memo" value="${attendance.memo}" class="input_one" type="text" style="display:none"/>&nbsp;&nbsp;
                    <c:if test='${empty attendance.type }'>
                        &nbsp;<font color="red">请选择</font>
                    </c:if>
            </td>
        </tr>
    </c:forEach>
    </form>
</table>
</body>
<script type="text/javascript">
    changetype();
</script>
</html>