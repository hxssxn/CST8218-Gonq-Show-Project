<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Find Users</title>
</head>
<body>
	<sql:setDataSource var="gonqshowdb" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/" user="gonqshow" password="gonqshow" dataSource="gonqshowdb"/>
		
	<sql:query dataSource="${gonqshowdb}" sql="SELECT first_name, last_name, program FROM users;" var="result" />
	<table>
		<tr>
			<th>First Name</th>
			<th>Last Name</th>
			<th>Program</th>
		</tr>
		<tr>
		<c:forEach var="row" items="${result.rows}" >
		<tr>
			<td><c:out value="${row.first_name}"/></td>
			<td><c:out value="${row.last_name}"/></td>
			<td><c:out value="${row.program}"/></td>
		</tr>
		</c:forEach>
	</table>
</body>
</html>