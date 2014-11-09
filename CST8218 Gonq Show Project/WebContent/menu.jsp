<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="language" value="${not empty param.language ? param.language : not empty language ? language : pageContext.request.locale}" scope="session" />
<fmt:setLocale value="${language}" scope="session" />
<fmt:setBundle basename="Messages" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title></title>
</head>
<body>
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
</body>
</html>