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
	if (System.getProperty("RDS_HOSTNAME") != null) {
	      
  	  Class.forName("com.mysql.jdbc.Driver");
    String dbName ="godutch";
    String userName = System.getProperty("RDS_USERNAME");
    String passworddb = System.getProperty("RDS_PASSWORD");
    String hostname = System.getProperty("RDS_HOSTNAME");
    String port = System.getProperty("RDS_PORT");
    String jdbcUrl = "jdbc:mysql://" + hostname + ":" + port + "/" + dbName + "?user=" + userName + "&password=" + passworddb;
   // logger.trace("Getting remote connection with connection string from environment variables.");
    Connection con = DriverManager.getConnection(jdbcUrl);
String emai=request.getParameter("email");
String password=request.getParameter("psw");
String query="select * from users where email=? and password=?";
PreparedStatement pst=con.prepareStatement(query);
pst.setString(1,emai);
pst.setString(2,password);
ResultSet rs=pst.executeQuery();
if(rs.next()){
	usr.setUsername(emai);
	usr.setPassword(password);
	RequestDispatcher rd=request.getRequestDispatcher("dashboard.jsp");
	rd.forward(request,response);
}
else{
	response.sendRedirect("usernotfound.html");
}
	}
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