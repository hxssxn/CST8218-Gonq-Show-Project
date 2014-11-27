<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Users</title>
<link rel=stylesheet href="Resource/style.css" type="text/css">
</head>
<%@include file="menu.jsp" %>
<body>
	<% 
		/*if (session.getAttribute("firstName") == null || session.getAttribute("firstName") == "") {
			response.sendRedirect("login.jsp");
		}*/
		
		Class.forName("com.mysql.jdbc.Driver");
		String connectionURL = "jdbc:mysql://localhost:3306/gonqshowdb";      
		Connection connect = DriverManager.getConnection(connectionURL, "gonqshow", "gonqshow");	
		Statement statement = connect.createStatement();
		ResultSet resultset = statement.executeQuery("select first_name, last_name, program, about_me, email, profilePic from user order by first_name") ; 
		String email = request.getSession().getAttribute("emailLogin").toString();
	%>
	<div id="wrap">                           
    <table>
		<% while(resultset.next()){ %>
		<tr>
			<td align="center">
				<% if(resultset.getString(6) != null) { %>
				<img class=profilePic src="Content/<%=resultset.getString(5) + "/" + resultset.getString(6)%>" />
				<% } else { %>
				<img src="Resource/profileDefault.jpg" alt="Profile Picture" style="width:175px;height:200px">
				<% } %>
			</td>
			<td>
			<table>
				<tr>
				  <td> 
				  	<%= resultset.getString(1) + " " + resultset.getString(2) + " - " %> <i><%= resultset.getString(3) %></i>
				  </td>
				</tr>
				
				<% if (resultset.getString(4) != null) {%>
				<tr>
				  <td> 
				  	<%= resultset.getString(4) %>
				  </td>
				</tr>
				<% } %>
				<tr>
				  <td align="center"> 
				  	<a href="ViewProfile.jsp?<%=resultset.getString(5)%>"><button>View Profile</button></a>
				  </td>
				</tr>	
			</table>
			</td>
		</tr>
		<tr><td colspan="2"><hr/></td></tr>
		<% } %>
    </table>
    </div>
</body>
</html>