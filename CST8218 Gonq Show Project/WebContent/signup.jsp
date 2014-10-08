<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Gonq Show Sign Up</title>
</head>
<body class="frontBody">
	<div class="frontContent">
	<form method="post" action="SignupServlet">
	    <center>
	    <table width="30%" cellpadding="5">
			<thead>
				<tr>
				    <th colspan="2" align="left">Enter Information Here</th>
				</tr>
			</thead>
	        <tbody>
	        	<tr>
	                <td colspan="2">Already A Member? <a href="index.jsp">Login Here</a></td>
	            </tr>
	            <tr>
	                <td>First Name</td>
	                <td><input type="text" name="firstName" value="" size="40%" /></td>
	            </tr>
	            <tr>
	                <td>Last Name</td>
	                <td><input type="text" name="lastName" value="" size="40%"/></td>
	            </tr>
	            <tr>
	                <td>Email</td>
	                <td><input type="text" name="email" value="" size="40%"/></td>
	            </tr>
	            <tr>
	            	<td>Student of Faculty</td>
	            	<td><input type="radio" name="sf" value="student">Student <br />
					<input type="radio" name="sf" value="faculty">Faculty
					</td>
	            </tr>
	           	<tr>
	            	<td>Department</td>
	            	<td>
		            	<select name="departmentDropDown">
						<option value="schoolOfAdvancedTechnology">School of Advanced Technology</option>
						</select>
					</td>
	            </tr>
	            <tr>
	            	<td>Program</td>
	            	<td>
		            	<select name="programDropDown" >
						<option value="computerEngineeringTechnology">Computer Engineering Technology</option>
						<option value="computerProgramming">Computer Programming</option>
						<option value="computerSystemsTechnician">Computer Systems Technician</option>
						</select>
					</td>
	            </tr>
	            <tr>
	            	<td colspan="2">
	            		About Me
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
	                <td>Password</td>
	                <td><input type="password" name="password1" value="" size="40%"/></td>
	            </tr>
	            <tr>
	                <td>Re-enter Password</td>
	                <td><input type="password" name="password2" value="" size="40%"/></td>
	            </tr>
	            <tr>
	                <td><input type="submit" value="Submit" /></td>
	            </tr>
	        </tbody>
	    </table>
	    </center>
	</form>
	</div>
</body>
</html>