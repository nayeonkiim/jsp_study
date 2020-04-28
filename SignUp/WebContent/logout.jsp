<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	session.invalidate();
%>

<html>
	<head>
		<meta charset="UTF-8">
		<title>로그아웃</title>
	</head>
	<body>
		<div align="center">
			<h2>로그아웃 되었습니다.</h2></br></br>
			<input type="button" value="닫기" onClick="location.href='login.jsp'">
		</div>
	</body>
</html>