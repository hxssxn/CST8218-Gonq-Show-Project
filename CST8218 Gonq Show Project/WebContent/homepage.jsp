<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="language" value="${not empty param.language ? param.language : not empty language ? language : pageContext.request.locale}" scope="session" />
<fmt:setLocale value="${language}" scope="session" />
<fmt:setBundle basename="Messages" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel=stylesheet href="Resource/style.css" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Gonq Show Welcome Page</title>
	<%
		Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/gonqshowdb", "root", "root");
		
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
		<a id="logout_button" href="LogoutServlet"><fmt:message key="home.logoutButton" /></a>
				<div id="search_bar" align="left">
					<form method="post" action=SearchServlet>
						<table border="0">
							<tr>
								<td>
									<input id="search_bar_field" type="text" name="Query" value="" size="40%"/>
								</td>
								<td>
									<input type="submit" Value=<fmt:message key="home.searchButton"/> >
								</td>
							</tr>
						</table>
					</form>
				</div>
</div>


<body id=wrap>
<%-- Welcome message and link to user page --%>
<b><label for="Welcome"><fmt:message key="home.title" /></label> <%=session.getAttribute("first") %></b>
<br />
<a href="users.jsp"><fmt:message key="home.userPageLink"/></a>
<%-- Search Bar linking to users page which displays search results. --%>
<hr>
<div id="ProfileInfo">
	<table>
		<tr>
			<td><img src="Resource/profileDefault.jpg" alt="Profile Picture" style="width:175px;height:200px"></td>
			<td><table>
			<tr>
				<td><b><label for="Name"><fmt:message key="home.nameLabel" /></label> </b></td>
				<td><%=session.getAttribute("first") + " " + session.getAttribute("last") %></td>
			</tr>
			<tr>
				<td><b><label for="Position"><fmt:message key="home.positionLabel" /></label></b></td>
				<td><%=session.getAttribute("stud") %>
			</tr>
			<tr>
				<td><b><label for="Department"><fmt:message key="home.departmentLabel" /></label></b></td>
				<td><%=session.getAttribute("dep") %></td>
			</tr>
			<tr>
				<td><b><label for="Program"><fmt:message key="home.programLabel" /></label></b></td>
				<td><%=session.getAttribute("prog") %></td>
			</tr>
			<tr>
				<td><b><label for="About"><fmt:message key="home.aboutLabel" /></label></b></td>
				<td><%=session.getAttribute("about") %></td>
			</tr>
		</table></td>
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
	<% if(session.getAttribute("message") != null ){%><%=session.getAttribute("message")%><% } %>
	<form action="UploadServlet" method="post" enctype="multipart/form-data">
		<input type="file" name="file" size="50"/><br />
		<input type="submit" value=<fmt:message key="home.uploadButton"/> />
	</form>
	<table>
		<%
		//Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/gonqshowdb", "root", "root");
		
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
