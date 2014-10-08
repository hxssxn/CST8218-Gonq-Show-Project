<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel=stylesheet href="Resources/style.css" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Gonq Show Welcome Page</title>
	<%
		Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/gonqshowdb", "gonqshow", "gonqshow");
		
		Statement statement = connect.createStatement();
		
		String seshEmail = request.getParameter("name");
		
		ResultSet results = statement.executeQuery("select * from user where email = '" + session.getAttribute("name") + "'");
		
		if(!results.next())
		{
			session.setAttribute("first", "apple");
		}
		else
		{
			// Sets the session variable first to the logged in users first name
			session.setAttribute("first", results.getString(4));
		}
	%>
</head>
<div id="main_menu"> <a id="profile_button" href="homepage.jsp"><%= session.getAttribute("first") %></a>
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
<%-- Welcome message and logout button --%>
<b>Welcome <%=session.getAttribute("first") %></b>
<br />
<a href="users.jsp">User Page</a>
<%-- Search Bar linking to users page which displays search results. --%>

</body>
</html>
