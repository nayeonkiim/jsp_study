<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
   
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>insert title here</title>
		<link rel="stylesheet" href="${contextPath }/css/mainStyle.css">
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
							<a href="${contextPath }/member/listMembers.do" class="join">관리자 페이지</a>
						<%}else {%>
							<a href="${contextPath }/member/myPage.do" class="join">마이 페이지</a>
						<%}
					}%>
					</div>
				</div>
			</div>
		</header>
		<section>
			<div class="inner">	
				<form method="post" name="fixFrm" action="${contextPath }/board/updateBoard.do">
					<table>
						<tr>
							<td width="20%">이름</td>
							<td> <input type="text" value="${bVo2.name }" name="name"></td>
						</tr>
						<tr>
							<td width="20%">아이디</td>
							<td>${bVo2.id}</td>
						</tr>
						<tr>
							<td width="20%">제목</td>
							<td><b><input type="text" value="${bVo2.subject }" name="subject"></b></td>
						</tr>
						<tr>
							<td width="20%">내용</td>
							<td> <textarea name="content" rows="10" cols="50">${bVo2.content }</textarea></td>
						</tr>
						<tr>
							<td width="20%">파일</td>
							<td><input type="file" value="${bVo2.filename }" name="filename"></td>
						</tr>
						<tr>
							<td><input type="submit" value="수정하기"></td>
							<td><input type="hidden" value="${bVo2.num }" name="num"></td>
						</tr>
					</table>
				</form>
			</div>
		</section>
	</body>
</html>