<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>로그인</title>
		<link rel="stylesheet" href="${contextPath }/css/mainStyle.css">
		<link rel="stylesheet" href="${contextPath }/css/loginStyle.css">
		<script type="text/javascript">
			function isFull(){
				var frm = document.loginFrm;
				if(frm.id.value == ''){
					alert("아이디를 입력하세요.");
					return;
				}
				if(frm.pwd.value == ''){
					alert("비밀번호를 입력하세요.");
					return;
				}
				frm.submit();
			}
		</script>
	</head>
	<body>
		<header class="inner header">
			<div class="hdDesign">
			
				<div class="uDesign">
					<h2><a href="${contextPath }/main.jsp">YeonCom</a></h2>
					<div class="input">
						<input type="text" name="inputFrm" class="inputFrm">
						<a href="#" >
							<i class="fas fa-search-plus"></i>
						</a>
					</div>
					<div class="btngrp">
						<a href="${contextPath }/member/loginForm.do" class="login">로그인</a>
						<a href="${contextPath }/member/memberForm.do" class="join">회원가입</a>
					</div>
				</div>
			</div>
		</header>
		<section class="inner sec_login">
			<div class="loginForm">
				<form method="post" name="loginFrm" action="${contextPath }/member/loginMember.do">
					<h1>LogIn</h1>
					<input type="text" name="id" placeholder="아이디" class="logId"><br>
					<input type="password" name="pwd" placeholder="비밀번호" class="logPwd"><br><br>
					<input type="button" value="로그인" class="btnLog" onClick="isFull()">
					<input type="button" value="회원가입" onClick="location.href='${contextPath }/member/memberForm.do'" class="btnLog">
				</form>			
			</div>
		</section>		
	</body>
</html>