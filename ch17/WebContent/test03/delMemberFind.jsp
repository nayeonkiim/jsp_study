<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="sec02.ex02.*" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
 
<%
	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("id");
	MemberDao memdao = new MemberDao();
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>insert title here</title>
	</head>
	<body>
		<form method=post action="${contextPath }/member/delMember.do?id=<%=id %>">
			아이디 : <%=id %><br>
			비밀번호 : <input type="password" name="pwd"><br>
			<!--<input type="hidden" value ="<%=id %>" name="Eid">-->
			<input type="submit" value="확인">
		</form>
	</body>
</html>