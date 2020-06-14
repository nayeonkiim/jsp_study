<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>회원정보 검색</title>
		<link rel="stylesheet" href="${contextPath }/css/mainStyle.css">
		<link rel="stylesheet" href="${contextPath }/css/modStyle.css">

	</head>
	<body>
		<header class="inner header">
			<div class="hdDesign">
				<div class="uDesign">
					<h2><a href="${contextPath }/main.jsp">YeonCom</a></h2>
					<div class="input">
						<input type="text" name="inputFrm" class="inputFrm">
					</div>
					<div class="btngrp">
					<% if(session.getAttribute("id") == null){%>
						<a href="${contextPath }/member/loginForm.do" class="login">로그인</a>
						<a href="${contextPath }/member/memberForm.do" class="join">회원가입</a>
					<%}else{ %>
						<a href="${contextPath }/member/loginOut.do" class="login">로그아웃</a>
						<%if(session.getAttribute("id").equals("master")) {%>
							<a href="${contextPath }/member/listMembers.do?" class="join">관리자 페이지</a>
						<%}else {%>
							<a href="${contextPath }/member/myPage.do?id=<%=session.getAttribute("id") %>" class="join">마이 페이지</a>
						<%}
					}%>
					</div>
				</div>
			</div>
		</header>
		<section class="inner secDesign">
			<div class="modDesign">
				<form method=post action="${contextPath}/member/modMember.do?id=${memInfo.id}" >
					<h2>Modify</h2>
					<table>
						<tr align="center">
							<td><b>아이디</b></td>
							<td>${memInfo.id }</td>
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
						<input type="hidden" name="id" value="${memInfo.id }">
					</table>
				</form>
			</div>
		</section>
	</body>
</html>