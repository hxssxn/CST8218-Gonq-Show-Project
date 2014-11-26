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
		Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/gonqshowdb", "gonqshow", "gonqshow");
		
		String seshEmail = request.getParameter("emailLogin");
		
		if (seshEmail == null)
		{
			seshEmail = request.getSession().getAttribute("emailLogin").toString();
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
			
			session.setAttribute("picture", results.getString(10));
		}
		
		boolean visible = false;
	%>
</head>
<%@include file="menu.jsp" %>

<body id=wrap>
<%-- Welcome message and link to user page --%>
<b><label for="Welcome"><fmt:message key="home.title" /></label> <%=session.getAttribute("first") %></b>
<br />
<%-- Search Bar linking to users page which displays search results. --%>
<hr>
<div id="ProfileInfo">
	<table>
		<tr>
			<td>
			<% if( session.getAttribute("picture") == null ) { %><img src="Resource/profileDefault.jpg" alt="Profile Picture" style="width:175px;height:200px"> <% }
			else { %><img class=profilePic src="Content/<%=session.getAttribute("email").toString() + "/" + session.getAttribute("picture").toString()%>" /><% } %></td>
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
			<% if (session.getAttribute("about") != null && session.getAttribute("about") != "\0") { %>
			<tr>
				<td><b><label for="About"><fmt:message key="home.aboutLabel" /></label></b></td>		
				<td><%=session.getAttribute("about") %></td>
			</tr>
			<% } %>
		</table></td>
	</tr>
	<tr><td><a class=imgLink href="EditProfile.jsp"><img src="Resource/editIcon.png" /></a>
	</table>
</div>
<hr>
<div id="Content">
	<% if(session.getAttribute("message") != null ){%><%=session.getAttribute("message")%><% } %>
	<form action="UploadServlet" method="post" enctype="multipart/form-data">
		<table>
			<tr>
				<td>
					<img src="Resource/postIcon.png" />
				</td>
				<td>
					<textarea name="newComment" rows="4" cols="50"></textarea>
				</td>
				<td width=30%></td>
				<td>
					<img src="Resource/imageIcon.png" />
				</td>
				<td>
					<input type="file" name="file" size="50"/>
				</td>
			</tr>
			<tr>
				<td width=100% colspan="5" align="center">
					<input type="submit" value=<fmt:message key="home.uploadButton"/> />
				</td>
			</tr>
		</table>
	</form>
	<table class=contentTable>
		<%
		//Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/gonqshowdb", "root", "root");
		
		PreparedStatement testState = connect.prepareStatement("SELECT * FROM content WHERE user_email=(?) AND type<>(?) ORDER BY date_time DESC");
		testState.setString(1, session.getAttribute("email").toString());
		testState.setString(2, "comment");

		results = testState.executeQuery();
		
		//TODO: Content will be fileName, navigate to Content/ userEmail / + fileName to open file/photo
		while( results.next() )
		{
			%><tr><td><% if(results.getString(2).toLowerCase().matches("image") || results.getString(2).toLowerCase().matches("document") ) { %>
			<a class=imgLink href="Content/<%=session.getAttribute("email").toString() + "/" + results.getString(4) %>"><img src="Resource/<%= results.getString(2).toLowerCase() %>Icon.png" /></a>
			<%} %>
			<% if(results.getString(2).toLowerCase().matches("post")){ %>
			<%=results.getString(4)	//Content
			%><% } %></td>
			<td align="right"><a class=imgLink href="DeletePostServlet.java?<%=results.getString(1)%>"><img src="Resource/deleteIcon.png" /></a></td></tr>
			<tr><td>
			<%=results.getString(5)
			%></td></tr>
			<tr><td><a href="ViewPost.jsp?<%=results.getString(1)%>" class=imgLink><img src="Resource/commentIcon.png" /></a></td></tr>
			<tr><td colspan="2"><hr class="commentDivide"></td></tr>
			<% testState = connect.prepareStatement("SELECT * FROM content WHERE on_id = (?) ORDER BY date_time ASC");
			testState.setString(1, results.getString(1));
			
			ResultSet commentResults = testState.executeQuery();
			
			while(commentResults.next())
			{
				%>
				<tr>
					<td class=darkBack colspan="2"><%=commentResults.getString(3) %></td>
				</tr>
				<tr>
					<td class=lightBack colspan="2"><%=commentResults.getString(4) %></td>
				</tr>
				<tr>
					<td class=darkBack colspan="2"><%=commentResults.getString(5) %></td>
				</tr>
				<%
			}
			%>
			<tr><td colspan="2"><hr id=contentBreak></td></tr>
			<%
		}%>
	</table>
</div> 

</body>
</html>