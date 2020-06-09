<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>회원정보 검색</title>
	</head>
	<body>
	<form method=post action="${contextPath}/member/modMember.do?id=${memInfo.id}" >
		<table>
			<tr align="center">
				<td><b>아이디</b></td>
				<td><input type="text" name="pwd" value="${memInfo.id }"></td>
			</tr>
			<tr>
				<td><b>비밀번호</b></td>
				<td><input type="password" name="pwd" value="${memInfo.pwd }"></td>
			</tr>
			<tr>
				<td><b>이름</b></td>
				<td><input type="text" name="name" value="${memInfo.name }"></td>
			</tr>
			<tr>
				<td><b>이메일</b></td>
				<td><input  type="email" name="email" value="${memInfo.email }"></td>
			</tr>
			<tr>
				<td><b>등록날짜</b></td>
				<td><input type="text" name="joinDate" value="${memInfo.joinDate }"></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>
					<input type="submit" value="수정하기">
				</td>
			</tr>
		</table>
		</form>
	</body>
</html>