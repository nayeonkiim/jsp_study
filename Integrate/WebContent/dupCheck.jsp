<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDao" %>
<%
	request.setCharacterEncoding("utf-8");
	String userID = request.getParameter("userID");
	UserDao uDao = new UserDao();
	boolean result = uDao.dupIdCheck(userID);
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>아이디 중복 체크</title>
	</head>
	<body>
		<%
			if(result){
		%>
		<%=userID %>는 이미 존재하는 아이디 입니다.<br>
		 다른 아이디를 입력해주세요.<br>
		 <input type="button" value="확인" onClick="window.close()">
		<%}else{ %>
		<%=userID %>는 사용 가능한 아이디 입니다.<br>
		 <input type="button" value="사용하기" onClick="window.close()">
		<%} %>
	</body>
</html>