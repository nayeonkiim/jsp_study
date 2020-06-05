<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="user.UserDao" %>
<!-- javascript 작성위해 -->
<%@ page import="java.io.PrintWriter" %>

<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPassword"/>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>로그인 확인</title>
	</head>
	<body>

		<%
		/* 	String userID = request.getParameter("userID");
			String userPassword = request.getParameter("userPassword");  */
			UserDao uDao = new UserDao();
			int result = uDao.login(user.getUserID(), user.getUserPassword());
			if(result == 1){
				session.setAttribute("userID", user.getUserID());
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('로그인에 성공하였습니다.')");
				script.println("location.href='main.jsp'");
				script.println("</script>");
			}
			else if(result == 0){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('비밀번호가 틀립니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('존재하지 않는 아이디 입니다.')");
				script.println("history.back()");
				script.println("</script>");
			}else if(result == -2){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('데이터 베이스 오류가 발생하였습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
		%>
	</body>
</html>