<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="usr" class="beans.User" scope="session"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Verify</title>
</head>
<body>
<%! String emailr,emailb;
	String passwordr,passwordb;
%>
<%
//emailr=request.getParameter("email");
//passwordr=request.getParameter("psw");
emailb=usr.getUsername();
passwordb=usr.getPassword();
%>
<h1><%= emailb%></h1>
<h1><%= passwordb%></h1>
</body>
</html>