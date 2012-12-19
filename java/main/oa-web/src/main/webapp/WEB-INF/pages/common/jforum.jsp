<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <script type="text/javascript" src="${scriptsPath}/yui/yahoo/yahoo-min.js"></script>
        <script type="text/javascript" src="${scriptsPath}/yui/dom/dom-min.js"></script>
        <script type="text/javascript" src="${scriptsPath}/yui/event/event-min.js"></script>
        <script type="text/javascript" src="${scriptsPath}/yui/connection/connection-min.js"></script>

        <script type="text/javascript">
        function login() {
            var username = '${user.loginname}';
            var password = '';
            if (username == 'admin') {
                password = 'admin';
            }

            var paramData = "username=" + username + "&password=" + password + "&action=validateLogin&module=user";
            var url = "/jforum/jforum.page";

            var callback = {
                success: 	function(o) {
                    if(o.responseText !== undefined){
                            // login is successful go on.
                            location.href = "/jforum/forums/list.page";
                    }
                },
                argument: []
            }
            var request = YAHOO.util.Connect.asyncRequest('POST', url, callback, paramData);
        }

        login();
        </script>
    </head>
</html>
