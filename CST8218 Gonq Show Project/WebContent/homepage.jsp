<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel=stylesheet href="Resource/style.css" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Gonq Show Welcome Page</title>
	<%
		Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/gonqshowdb", "gonqshow", "gonqshow");
		
		String seshEmail = request.getParameter("email");
		
		if (seshEmail == null)
		{
			seshEmail = request.getSession().getAttribute("email").toString();
		}
		
		PreparedStatement statement = connect.prepareStatement("SELECT * FROM user WHERE email=?"); 
        statement.setString(1, seshEmail); 
		
        ResultSet results = statement.executeQuery();
		
		if(!results.next())
		{
			session.setAttribute("first", "apple");
		}
		else
		{
			// Sets session variables to user's information for quick access
			session.setAttribute("email", results.getString(2));
			session.setAttribute("first", results.getString(4));
			session.setAttribute("last", results.getString(5));
			session.setAttribute("about", results.getString(6));
			session.setAttribute("dep", results.getString(7));
			session.setAttribute("prog", results.getString(8));
			
			if ( results.getString(9).equals("0") )	
				session.setAttribute("stud", "Student");
			else
				session.setAttribute("stud", "Faculty");
		}
	%>
</head>
<div id="main_menu">
		<a id="logout_button" href="LogoutServlet">Logout</a>
				<div id="search_bar" align="left">
					<form method="post" action=SearchServlet>
						<table border="0">
							<tr>
								<td>
									<input id="search_bar_field" type="text" name="Query" value="" size="40%"/>
								</td>
								<td>
									<input type="submit" Value="Search">
								</td>
							</tr>
						</table>
					</form>
				</div>
</div>


<body id=wrap>
<%-- Welcome message and link to user page --%>
<b>Welcome <%=session.getAttribute("first") %></b>
<br />
<a href="users.jsp">User Page</a>
<%-- Search Bar linking to users page which displays search results. --%>
<hr>
<div id="ProfileInfo">
	<table>
		<tr>
			<td><b>Name: </b></td>
			<td><%=session.getAttribute("first") + " " + session.getAttribute("last") %></td>
		</tr>
		<tr>
			<td><b>Position: </b></td>
			<td><%=session.getAttribute("stud") %>
		</tr>
		<tr>
			<td><b>Department: </b></td>
			<td><%=session.getAttribute("dep") %></td>
		</tr>
		<tr>
			<td><b>Program: </b></td>
			<td><%=session.getAttribute("prog") %></td>
		</tr>
		<tr>
			<td><b>About: </b></td>
			<td><%=session.getAttribute("about") %></td>
		</tr>
	</table>
</div>
<hr>
<div id="Content">
	<!-- 			PreparedStatement testState = connect.prepareStatement("SELECT * FROM content WHERE user_email=(?)");
			testState.setString(1, userEmail);
			
			ResultSet results = testState.executeQuery();
			
			while( results.next() )
			{
				System.out.println(results.getString(2));
			} -->
	<% if(request.getSession().getAttribute("message") != null ){ request.getSession().getAttribute("message"); } %>
	<form action="UploadServlet" method="post" enctype="multipart/form-data">
		<input type="file" name="file" size="50" /><br />
		<input type="submit" value="Upload File" />
	</form>
	<table>
		<%
		//Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/gonqshowdb", "gonqshow", "gonqshow");
		
		PreparedStatement testState = connect.prepareStatement("SELECT * FROM content WHERE user_email=(?)");
		testState.setString(1, session.getAttribute("email").toString());
		
		results = testState.executeQuery();
		
		while( results.next() )
		{
			%><tr><td>
			<%=results.getString(2)	//Type
			%></td></tr>
			<tr><td>
			<%=results.getString(4)	//Content
			%></td></tr>
			<tr><td>
			<%=results.getString(5)
			%></td></tr>
			<%
		}%>
	</table>
</div> 

</body>
</html>
