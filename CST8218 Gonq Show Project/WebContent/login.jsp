<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Gonq Show Login</title>
</head>
<body>
	<form method="post" action="login.jsp">
	    <center>
	    <table width="30%" cellpadding="3">
	        <thead>
	            <tr>
	                <th colspan="2" align="left">Login Here</th>
	            </tr>
	        </thead>
	        <tbody>
	            <tr>
	                <td>User Name</td>
	                <td><input type="text" name="uname" value="" /></td>
	            </tr>
	            <tr>
	                <td>Password</td>
	                <td><input type="password" name="pass" value="" /></td>
	            </tr>
	            <tr>
	                <td><input type="submit" value="Login" /></td>
	            </tr>
	            <tr>
	                <td colspan="2"> Not A Member!! <a href="signup.jsp">Sign Up Now!!</a></td>
	            </tr>
	        </tbody>
	    </table>
	    </center>
	</form>
</body>
</html>