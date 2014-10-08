<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<link rel=stylesheet href="Resource/style.css" type="text/css">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Gonq Show Login</title>
</head>
<body>
<div class="frontContent">
	<form method="post" action="LoginServlet">
	    <table>
	       	<tr>
				<td rowspan="5" class="frontLeftSide"> <img src="${pageContext.request.contextPath}/Resource/logo.png" alt="GonQ Show" width=300 height=300> </td>
				<td colspan="2"> Login Here </td>
			</tr>
	        <tr>
	            <td>Email</td>
	            <td><input type="text" name="email" value="" /></td>
	        </tr>
	        <tr>
	            <td>Password</td>
	            <td><input type="password" name="password" value="" /></td>
	        </tr>
	        <tr>
	            <td align="center"><input type="submit" value="Login" /></td>
	        </tr>
	        <tr>
	            <td colspan="2"> Not A Member? <a href="signup.jsp">Sign Up Now!</a></td>
	        </tr>
	    </table>
	</form>
</div>
</body>
</html>