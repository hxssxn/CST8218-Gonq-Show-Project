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
<title>Gonq Show Sign Up</title>
</head>
<body>
	<div class="signUpContent">
	<form method="post" action="SignupServlet">
	    <center>
	    <table width="30%" cellpadding="5">
			<thead>
				<tr>
				    <th colspan="2" align="left"><fmt:message key="reg.title" /></th>
				</tr>
			</thead>
	        <tbody>
	        	<tr>
	                <td colspan="2"><label for="Signup"><fmt:message key="reg.loginLabel" /> </label><a href="<c:url value='login.jsp?language=${language}' />"> <fmt:message key="reg.loginLink"/></a></td>
	            </tr>
	            <tr>
	                <td><label for="FName"><fmt:message key="reg.firstNameLabel" /></label></td>
	                <td><input type="text" name="firstName" value="" size="40%" /></td>
	            </tr>
	            <tr>
	                <td><label for="LName"><fmt:message key="reg.lastNameLabel" /></label></td>
	                <td><input type="text" name="lastName" value="" size="40%"/></td>
	            </tr>
	            <tr>
	                <td><label for="Email"><fmt:message key="reg.emailLabel" /></label></td>
	                <td><input type="text" name="email" value="" size="40%"/></td>
	            </tr>
	            <tr>
	            	<td><label for="accType"><fmt:message key="reg.accTypeLabel" /></label></td>
	            	<td>
	            		<input type="radio" name="sf" value="student"><fmt:message key="reg.accTypeStu" /><br />
						<input type="radio" name="sf" value="faculty"><fmt:message key="reg.accTypeFac" />
					</td>
	            </tr>
	           	<tr>
	            	<td><label for="department"><fmt:message key="reg.departmentLabel" /></label></td>
	            	<td>
		            	<select name="departmentDropDown">
						<option value="schoolOfAdvancedTechnology"><fmt:message key="reg.departmentOp1" /></option>
						</select>
					</td>
	            </tr>
	            <tr>
	            	<td><label for="program"><fmt:message key="reg.programLabel" /></label></td>
	            	<td>
		            	<select name="programDropDown" >
						<option value="computerEngineeringTechnology"><fmt:message key="reg.programOp1" /></option>
						<option value="computerProgramming"><fmt:message key="reg.programOp2" /></option>
						<option value="computerSystemsTechnician"><fmt:message key="reg.programOp3" /></option>
						</select>
					</td>
	            </tr>
	            <tr>
	            	<td colspan="2">
	            		<label for="aboutMe"><fmt:message key="reg.aboutLabel" /></label>
	            	</td> 
	            </tr>
	            <tr>
	            	<td colspan="2">
	            	<textarea name="aboutMe"cols="50" rows="4"></textarea>
	            	</td>
	            </tr>
	            <tr>
		            <td colspan="2">
		            	<hr>
		            </td>
	            </tr>
	            <tr>
	                <td><label for="password"><fmt:message key="reg.passLabel" /></label></td>
	                <td><input type="password" name="password1" value="" size="40%"/></td>
	            </tr>
	            <tr>
	                <td><label for="rePassword"><fmt:message key="reg.confirmPassLabel" /></label></td>
	                <td><input type="password" name="password2" value="" size="40%"/></td>
	            </tr>
	            <tr>
	            	<td></td>
	                <td><input type="submit" value=<fmt:message key="reg.submitButton" /> /></td>
	            </tr>
	        </tbody>
	    </table>
	    </center>
	</form>
	</div>
</body>
</html>