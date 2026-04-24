<%@ page %>

<%
session.invalidate();
response.sendRedirect("login.jsp");
%>