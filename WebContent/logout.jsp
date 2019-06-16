<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!-- For not creating new session -->

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 <%
     // for checking the session is available or not, if not available it will throw exception, "Session already invalidated."
      if (session!=null) {
        session.invalidate();
        response.sendRedirect("index.html");
      }
     %>
</body>
</html>