<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel=stylesheet href="Resource/style.css" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Comment on Post</title>
</head>
<%@include file="menu.jsp" %>
<body id="wrap">
	<%
		Connection connect = DriverManager.getConnection("jdbc:mysql://localhost:3306/gonqshowdb", "gonqshow", "gonqshow");
		int postID = 0;
		
		try
		{
			postID = Integer.parseInt(request.getQueryString());
			session.setAttribute("postID", postID);
		}
		catch (Exception e)
		{
			response.sendRedirect("homepage.jsp");
		}
		
		PreparedStatement statement = connect.prepareStatement("SELECT * FROM content WHERE content_id=?");
		statement.setInt(1, postID);
		
		ResultSet results = statement.executeQuery();
			
		if(!results.next())
		{
			response.sendRedirect("homepage.jsp");
		}
		else
		{%>
			<form action="CommentServlet" method="post" enctype="multipart/form-data">
			<table class=contentTable>
			<tr><td>
			<%
			if(results.getString(2).toLowerCase().matches("image") || results.getString(2).toLowerCase().matches("document") ) { %>
			<a class=imgLink href="Content/<%=session.getAttribute("email").toString() + "/" + results.getString(4) %>"><img src="Resource/<%= results.getString(2).toLowerCase() %>Icon.png" /></a>
			<%} %>
			<% if(results.getString(2).toLowerCase().matches("post")){ %>
			<%=results.getString(4)	//Content
			%><% } %></td></tr>
			<tr><td>
			<%=results.getString(5)
			%></td></tr>
			<tr><td><a href="ViewPost.jsp?<%=results.getString(1)%>" class=imgLink><img src="Resource/commentIcon.png" /></a></td></tr>
			<tr><td colspan="2"><hr class="commentDivide"></td></tr>
			<% statement = connect.prepareStatement("SELECT * FROM content WHERE on_id = (?) ORDER BY date_time ASC");
			statement.setString(1, results.getString(1));
			
			ResultSet commentResults = statement.executeQuery();
			
			while(commentResults.next())
			{
				%>
				<tr>
					<td class=darkBack><%=commentResults.getString(3) %></td>
				</tr>
				<tr>
					<td class=lightBack><%=commentResults.getString(4) %></td>
				</tr>
				<tr>
					<td class=darkBack><%=commentResults.getString(5) %></td>
				</tr>
				<%
			}
			%>
			<tr>
				<td>
					<textarea name="newComment" rows="4" cols="50"></textarea>
				</td>
			</tr>
			<tr>
				<td>
					<input type="submit" value=<fmt:message key="home.uploadButton"/> />
				</td>
			</tr>
			<tr><td colspan="2"><hr id=contentBreak></td></tr>
			<%
		}%>
	</table>
	</form>
</body>
</html>