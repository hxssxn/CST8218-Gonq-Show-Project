<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="language" value="${not empty param.language ? param.language : not empty language ? language : pageContext.request.locale}" scope="session" />
<fmt:setLocale value="${language}" scope="session" />
<fmt:setBundle basename="Messages" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<link rel=stylesheet href="Resource/style.css" type="text/css">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Gonq Show Login</title>
</head>
<body>
<div class="frontContent">
	<br/>
	<form method="post" action="LoginServlet">
	    <table>
	       	<tr>
				<td rowspan="5" class="frontLeftSide"> <img src="Resource/logo.png" alt="GonQ Show" width=300 height=300> </td>
				<td colspan="2"><label for="Login"><fmt:message key="login.title" /></label></td>
			</tr>
	        <tr>
	            <td><label for="Email"><fmt:message key="login.emailLabel" /></label></td>
	            <td><input type="text" name="email" value="" /></td>
	        </tr>
	        <tr>
	            <td><label for="Password"><fmt:message key="login.passLabel" /></label></td>
	            <td><input type="password" name="password" value="" /></td>
	        </tr>
	        <tr>
	        	<td></td>
	            <td><input type="submit" value=<fmt:message key="login.loginButton" /> /></td>
	        </tr>
	        <tr>
	            <td colspan="2"><label for="Signup"><fmt:message key="login.regLabel" /></label> <a href="<c:url value='signup.jsp?langage=${language}'/>"><fmt:message key="login.regLink" /></a></td>
	        </tr>
	    </table>
	</form>
</div>
</body>
</html>