<%@ page import="com.juyee.general.helpers.StringHelp"%>
<%@page contentType="text/html;charset=GBK" %>
<jsp:useBean id="userSession" scope="session" class="com.juyee.ipromis.jsp.UserSession"/>
<% request.setCharacterEncoding(response.getCharacterEncoding());%>
<%
    String username = "";
    if(userSession.getUserData() != null)
        username = userSession.getUserData().getLoginname();

    if(!StringHelp.isEmpty(username)){
        response.sendRedirect("http://mis.shcjsq.com:88/loginFromMis.asp?username="+username);
    }
%>

