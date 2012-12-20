<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <%--<script type="text/javascript" src="${scriptsPath}/yui/yahoo/yahoo-min.js"></script>--%>
        <%--<script type="text/javascript" src="${scriptsPath}/yui/dom/dom-min.js"></script>--%>
        <%--<script type="text/javascript" src="${scriptsPath}/yui/event/event-min.js"></script>--%>
        <%--<script type="text/javascript" src="${scriptsPath}/yui/connection/connection-min.js"></script>--%>

        <script type="text/javascript">
        function act() {
            window.location = '${ctx}${description}';
        }

        act();
        </script>
    </head>
</html>
