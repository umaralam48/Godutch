<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import='java.sql.*' %>
<jsp:useBean id="usr" class="beans.User" scope="session"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
try
{
Class.forName("com.mysql.jdbc.Driver");
Connection con=DriverManager.getConnection("jdbc:mysql://localhost/godutch","admin","password");
String nm=request.getParameter("name");
String emai=request.getParameter("email");
String password=request.getParameter("psw");
String query="insert into users (email,name,password) values (?,?,?)";
PreparedStatement pst=con.prepareStatement(query);
pst.setString(1,emai);
pst.setString(2,nm);
pst.setString(3,password);
pst.executeUpdate();
usr.setUsername(emai);
usr.setPassword(password);
RequestDispatcher rd=request.getRequestDispatcher("dashboard.jsp");
rd.forward(request,response);
}catch(ClassNotFoundException ce)
{
	ce.printStackTrace();
}
catch(SQLException ce)
{
	ce.printStackTrace();
}
%>
</body>
</html>