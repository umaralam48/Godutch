<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<jsp:useBean id="usr" class="beans.User" scope="session"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Transaction...</title>
</head>
<body>
<%! 
ResultSet rs; String nm,op,desc; int amount;
%>
<%
if(usr.getUsername()==null){
	response.sendRedirect("index.html");
}
try
{
	nm=usr.getUsername();
	op=request.getParameter("op");
	System.out.println(op);
	amount=Integer.parseInt(request.getParameter("am"));
	desc=request.getParameter("desc");
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
String query="select * from users where email=?";
PreparedStatement pst=con.prepareStatement(query);
pst.setString(1,nm);
System.out.println(pst);
rs=pst.executeQuery();
rs.next();
int balance=rs.getInt(4);
balance=balance-amount;
query="UPDATE users SET balance=? WHERE email =?";
pst=con.prepareStatement(query);
pst.setInt(1,balance);
pst.setString(2,nm);
System.out.println(pst);
pst.executeUpdate();
query="insert into transac (description,debit,credit,amount) values(?,?,?,?)";
pst=con.prepareStatement(query);
	pst.setString(1,desc);
	pst.setString(2,nm);
	pst.setString(3,op);
	pst.setInt(4,amount);
	pst.executeUpdate();
	query="select balance from users where email=?";
	pst=con.prepareStatement(query);
	pst.setString(1,op);
	rs=pst.executeQuery();
	rs.next();
	balance=rs.getInt(1);
	balance=balance+amount;
	query="UPDATE users SET balance =? WHERE email =?";
	pst=con.prepareStatement(query);
	pst.setInt(1,balance);
	pst.setString(2,op);
	pst.executeUpdate();
out.println("<h1>Transaction successful</h1>");
RequestDispatcher rd=request.getRequestDispatcher("dashboard.jsp");
rd.include(request,response);
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