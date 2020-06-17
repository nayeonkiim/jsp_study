<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
   
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<%
	request.setCharacterEncoding("utf-8");
	int num = Integer.parseInt(request.getParameter("num"));
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>게시글 읽기</title>
		<link rel="stylesheet" href="${contextPath }/css/mainStyle.css" />
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
		<section class="inner">
			<div>	
				<table>
					<tr>
						<td width="20%">이름</td>
						<td> ${bVo.name }</td>
					</tr>
					<tr>
						<td width="20%">아이디</td>
						<td> ${bVo.id }</td>
					</tr>
					<tr>
						<td width="20%">제목</td>
						<td><b>${bVo.subject }</b></td>
					</tr>
					<tr>
						<td width="20%">내용</td>
						<td> ${bVo.content }</td>
					</tr>
					<tr>
						<td width="20%">파일</td>
						<td> ${bVo.filename }</td>
					</tr>	
				</table>
				<div class="buttonSize">
					<input type="button" value="수정하기" onClick="location.href='${contextPath}/board/idCheck.do?id=${bVo.id }&num=${bVo.num }'">
					<input type="button" value="뒤로" onClick="history.back(-1)">
				</div>
			</div>
		</section>
	</body>
</html>