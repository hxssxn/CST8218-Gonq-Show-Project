<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css" media="screen">
	td {
		padding-left: 40px;
		padding-right: 40px;
		padding-top: 10px;
		padding-bottom: 10px;
	}
</style>
</head>
<body>
	<center>
	<h1>List of Users</h1>
	<table>
		<tr>
			<td><button type="button" id= >My Content</button></td>
			<td><button type="button" id= >Profile</button></td>
			<td><button type="button" id= >Logout</button></td>
		</tr>
	</table>
	</center>
	<br />
	<br />
	<br />
		
	<% 
		/*if (session.getAttribute("firstName") == null || session.getAttribute("firstName") == "") {
			response.sendRedirect("login.jsp");
		}*/
		
		Class.forName("com.mysql.jdbc.Driver");
		String connectionURL = "jdbc:mysql://localhost:3306/gonqshowdb";      
		Connection connection = DriverManager.getConnection(connectionURL, "root", "root");	
		Statement statement = connection.createStatement();
		ResultSet resultset = statement.executeQuery("select first_name, last_name, program, about_me, email from user") ; 
	%>
	                           
    <center>
    <table>
		<% while(resultset.next()){ %>
		<tr>
		  <td> 
		  	<%= resultset.getString(1) + " " + resultset.getString(2) + " - " %> <i><%= resultset.getString(3) %></i>
		  </td>
		</tr>
		<tr>
		  <td> 
		  	<%= resultset.getString(4) %>
		  </td>
		</tr>
		<tr>
		  <td> 
		  	<button type="button" id=<%= resultset.getString(4) %> >Follow</button>
		  	<hr />
		  </td>
		</tr>
		<% } %>
    </table>
    </center>
</body>
</html>