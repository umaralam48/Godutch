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
ResultSet rs; String nm,em,user; int bal,spent,mybalance,status,count=0;
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
spent=rs.getInt(4);
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
<a type="button" href="http://localhost:8080/Godutch/dashboard.jsp">Refresh</a>
<br><br>
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
<h3>Total amount spent on trip: '<%=spent%>'</h3>
<a role="button" href="http://localhost:8080/Godutch/viewtransaction.jsp?q=<%=user%>">View your transactions</a>
<a role="button" href="http://localhost:8080/Godutch/viewtransaction.jsp?q=*">View trip transactions</a>
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
<% 
count=0;
while(rs.next()){
	++count;
	nm=rs.getString(2);
	if(rs.getString(1).equals(user)){
		mybalance=rs.getInt(4);
		continue;}
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
<h3>Amount spent by you: '<%=mybalance*-1%>'</h3>
<h3>Status : '<%=usr.status(mybalance,spent,count)%>'</h3>
<br>
<h6><a href="index.html">Login</a></h6>
<h6><a href="logout.jsp">Logout</a></h6>
</center>
</body>
</html>