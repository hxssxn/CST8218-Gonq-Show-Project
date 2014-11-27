<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="language" value="${not empty param.language ? param.language : not empty language ? language : pageContext.request.locale}" scope="session" />
<fmt:setLocale value="${language}" scope="session" />
<fmt:setBundle basename="Messages" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title></title>
		<%Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/gonqshowdb", "gonqshow", "gonqshow");
		
		PreparedStatement userState = connection.prepareStatement("SELECT * FROM user ORDER BY first_name"); 
        ResultSet userResults = userState.executeQuery();

        final String refer = request.getRequestURL().toString().replaceAll("^(.*?)gonqshow", "");
        HttpSession s = request.getSession();
        
        s.setAttribute("refer", refer);
        
        if(request.getAttribute("searchError") == null)
        	request.setAttribute("searchError", "");
		%>
</head>
<body>
	<div id="main_menu">
		<div id="dropDownMenu">
			<table width="100%">
				<tr>
					<td>
						<img class="miniProfilePic" src="Resource/logo.png">
					</td>
					<td>
						<a class="imgLink" href="homepage.jsp"><img class="miniProfilePic" src="Resource/homeIcon.png"></a>
					</td>
					<td>
						<a class="imgLink" href="users.jsp"><img class="miniProfilePic" src="Resource/userIcon.png"></a>
					</td>
					<td>
						<a class="imgLink" href="LogoutServlet"><img class="miniProfilePic" src="Resource/logoutIcon.png"></a>
					</td>
				</tr>
			</table>
		</div>
		<div id="MenuUsers">
			<table>
			<% while( userResults.next() ) { %>
				<tr>
					<td>
						<a class="imgLink" href="ViewProfile.jsp?<%=userResults.getString(2)%>"><% if(userResults.getString(10) != null) { %>
				<img class=miniProfilePic src="Content/<%=userResults.getString(2) + "/" + userResults.getString(10)%>" />
				<% } else { %>
				<img class=miniProfilePic src="Resource/profileDefault.jpg" alt="Profile Picture" style="width:175px;height:200px">
				<% } %></a>
					</td>
					<td>
						<a class="imgLink" href="ViewProfile.jsp?<%=userResults.getString(2)%>"><%=userResults.getString(4) + " " + userResults.getString(5) %></a>
					</td>
				</tr>
			<% } %>
			</table>
		</div>
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
</body>
</html>