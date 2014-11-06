<%@ page import="java.util.*" language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="language" value="${not empty param.language ? param.language : not empty language ? language : pageContext.request.locale}" scope="session" />
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="Messages" />
<!-- Checks if the session variable has been set indicating a previously failed login attempt
	 if the variable is set then display the invalid login message and remove the variable from the session
	 This variable will be reset if an invalid login attempt is made. -->
<%
	if(session.getAttribute("invalidLogin") != null && (boolean)session.getAttribute("invalidLogin") == true)
	{
		if(request.getParameter("language").equals("fr"))
		{
			out.print("<p style=\"color:red\">Désolé, Nom d'utilisateur ou Mot de Passe était invalide</p>");
			session.removeAttribute("invalidLogin");
		}
		else if(request.getParameter("language").equals("es"))
		{
			out.print("<p style=\"color:red\">Lo Sentimos Nombre de Usuario o Contraseña de Error</p>");
			session.removeAttribute("invalidLogin");
		}
		else
		{
			out.print("<p style=\"color:red\">Sorry username or password error</p>");
			session.removeAttribute("invalidLogin");
		}
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="${language}">
<link rel=stylesheet href="Resource/style.css" type="text/css">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Gonq Show</title>
</head>
<body>
<div class="frontContent">
	<table>
	<tr>
		<td rowspan="5" class="frontLeftSide"> <br/> <img src="Resource/logo.png" alt="GonQ Show" width=300 height=300> </td>
		<td colspan="2"> <p class="frontP"><label for="Register"><fmt:message key="main.title" /></label></p></td>
	</tr>
	<tr>
		<td><label for="login"><fmt:message key="main.loginLabel" /></label> <a href="<c:url value='login.jsp?language=${language}'/>"><fmt:message key="main.loginLink" /></a></td>
    </tr>
    <tr>
	    <td><label for="Register"><fmt:message key="main.regLabel" /></label> <a href="<c:url value='signup.jsp?language=${language}'/>"><fmt:message key="main.regLink" /></a></td>
    </tr>
    <tr>
    	<td>
    	<form>
    		<select id="language" name="language" onChange="this.form.submit()" selected="selected">
    			<option value="en" ${language == 'en' ? 'selected' : ''}><fmt:message key="main.langEN" /></option>
    			<option value="fr" ${language == 'fr' ? 'selected' : ''}><fmt:message key="main.langFR" /></option>
    			<option value="es" ${language == 'es' ? 'selected' : ''}><fmt:message key="main.langES" /></option>
    		</select>
    	</form>
    	</td>
    </tr>
	</table>
</div>
</body>
</html>