<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
<jsp:useBean id="usr" class="beans.User" scope="session"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dashboard</title>
</head>
<body>
<%! 
ResultSet rs; String nm,em,user; int bal;
%>
<%
if(usr.getUsername()==null){
	response.sendRedirect("index.html");
}
try
{
	user=usr.getUsername();
Class.forName("com.mysql.jdbc.Driver");
Connection con=DriverManager.getConnection("jdbc:mysql://localhost/godutch","admin","password");
String query="select * from users";
PreparedStatement pst=con.prepareStatement(query);
rs=pst.executeQuery();
rs.next();
bal=rs.getInt(4);
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
<br><br><br><br>
<form name="spen" method="post" action="transaction.jsp">
<fieldset>
<legend>Spent</legend>
<table border="0">
<tr>
<td><input type="number" name="am" placeholder="Enter amount"></td>
<td>Spent on </td>
<td><input type="text" name="desc" placeholder="Enter description"></td>
<td><input type="submit" value="Submit"></td>
</tr>
</table>
</fieldset>
<input name="op" value="spent" type="hidden" >
</form>
<br><br>
<h3>Total amount spent : '<%=bal%>'</h3>
<br><br>
<form name="paid" method="post" action="transaction.jsp">
<fieldset>
<legend>Paid To </legend>
<table>
<tr>
<th>----Select----</th>
<th>*-----Name-----*</th>
<th>----Balance----</th>
</tr>
<% while(rs.next()){
	nm=rs.getString(2);
	if(nm.equals(user)){continue;}
	em=rs.getString(1);
	bal=rs.getInt(4);
	%>
<tr>
<td><input name="op" value="<%=em%>" type="radio"></td>
<td><%=nm %></td>
<td><%=bal %></td>
</tr>
<%} %>
</table>
<table>
<tr>
<td><input type="text" name="desc" placeholder="Enter description"></td>
<td><input name="am" type="number" placeholder="enter amount"></td>
<td><input type="submit" value="Submit"></td>
</tr>
</table>
</fieldset>
</form>
<br>
<h6><a href="index.html">Login</a></h6>
<br>
<h6><a href="logout.jsp">Logout</a></h6>
</center>
</body>
</html>