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
<title>Edit Your Profile</title>
	<%
	String driver = "com.mysql.jdbc.Driver";  
    try {
		Class.forName(driver).newInstance();
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
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
<a href="users.jsp"><fmt:message key="home.userPageLink"/></a>
<%-- Search Bar linking to users page which displays search results. --%>
<hr>
<div id="ProfileInfo">
	<form action="EditProfileServlet" id="PictureForm" method="post"  enctype="multipart/form-data">
	<table>
		<tr>
			<td>
			<% if( session.getAttribute("picture") == null ) { %><img src="Resource/profileDefault.jpg" alt="Profile Picture" style="width:175px;height:200px"> <% }
			else { %><img src="Content/<%=session.getAttribute("email").toString() + "/" + session.getAttribute("picture").toString()%>" /><% } %></td>
			<td><table>
			<tr>
				<td><b><label for="Name"><fmt:message key="home.nameLabel" /></label> </b></td>
				<td><input name="fName" type="text" value="<%=session.getAttribute("first") %>" /></td>
				<td><input name="lName" type="text" value="<%=session.getAttribute("last") %>" /></td>
			</tr>
			<tr>
				<td><b><label for="Position"><fmt:message key="home.positionLabel" /></label></b></td>
				<td><%=session.getAttribute("stud") %></td>
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
				<td colspan="3"><%if (session.getAttribute("about") != null ) { %><input name="about" type="text" value="<%=session.getAttribute("about") %>" size="100" /> <% } %>
				<% if (session.getAttribute("about") == null ) { %><input name="about" type="text" size="100" /> <% } %></td>
				<td></td>
			</tr>
		</table></td>
	</tr>
	<tr><td>
		<input type="file" name="profilePicture" size="50" /><br />
	</td></tr>
	</table>
	<br/>
	<br/>
	<table width="100%">
		<tr>
			<td align="center">
				<input type="submit" value=<fmt:message key="home.uploadButton" /> />
			</td>
		</tr>
	</table>
	</form>
</div>
<hr>

</body>
</html>
