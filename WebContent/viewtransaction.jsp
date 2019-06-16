<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
<jsp:useBean id="usr" class="beans.User" scope="session"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Transactions</title>
</head>
<body>
<%! 
ResultSet rs; String nm,desc,op,user; int bal; Date dt;
%>
<%
if(usr.getUsername()==null){
	response.sendRedirect("index.html");
}
try
{String query;PreparedStatement pst;
	user=request.getParameter("q");
Class.forName("com.mysql.jdbc.Driver");
Connection con=DriverManager.getConnection("jdbc:mysql://localhost/godutch","admin","password");
if(user.equals("*")){
	query="select * from transac";
	pst=con.prepareStatement(query);
}
else{
	query="select * from transac where debit=?";
	pst=con.prepareStatement(query);
	pst.setString(1,user);
}
rs=pst.executeQuery();
}catch(ClassNotFoundException ce)
{
	ce.printStackTrace();
}
catch(SQLException ce)
{
	ce.printStackTrace();
}
%>
<center>
<br><br>
<h1>Transactions</h1>
<table border="1">
<tr>
<th>--------Date--------</th>
<th>----Description----</th>
<th>*-----From-----*</th>
<th>----To----</th>
<th>-----Amount-----</th>
</tr>
<% 
while(rs.next()){
	desc=rs.getString(1);
	dt=rs.getDate(2);
	nm=rs.getString(3);
	op=rs.getString(4);
	bal=rs.getInt(5);
	%>
<tr>
<td><%=desc %></td>
<td><%=dt%></td>
<td><%=nm %></td>
<td><%=op%></td>
<td><%=bal%></td>
</tr>
<%} %>
</table>
<br><br>
<a role="button" href="http://localhost:8080/Godutch/dashboard.jsp">View your dashboard</a>
<a role="button" href="http://localhost:8080/Godutch/viewtransaction.jsp?q=*">View trip transactions</a>
<h6><a href="index.html">Login</a></h6>
<h6><a href="logout.jsp">Logout</a></h6>
</center>
</body>
</html>