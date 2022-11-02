<%@page import="ekart.entity.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	User user= (User)session.getAttribute("currentuser");
	if(user == null) {
		session.setAttribute("msg", "You are not logged in");
		response.sendRedirect("login.jsp");
		return;
		
	}else{
		
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title><%=user.getUserName()%></title>
</head>
<body>
	<%
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	%>
	<%@include file="component/navbar.jsp" %>

</body>
</html>