<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
	request.setCharacterEncoding("utf-8");
	boolean result = false;

	if(session == null || session.getAttribute("id") == null){
		out.println("<script>");
		out.println("alert('로그인 먼저 해주세요!');");
		out.println("history.back(-1)");
		out.println("</script>");
	}	
	if(!session.getAttribute("id").equals(request.getAttribute("id"))){
		out.println("<script>");
		out.println("alert('수정권한이 없습니다.');");
		out.println("history.back(-1)");
		out.println("</script>"); 
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<c:choose>
			<c:when test='${msg=="matchFail"}'>
				<script>
					alert("아이디와 비밀번호가 일치하지 않습니다.");
				</script>
			</c:when>
		</c:choose>
		<meta charset="UTF-8">
		<title>마이페이지</title>
		<link rel="stylesheet" href="${contextPath }/css/mainStyle.css">
		<link rel="stylesheet" href="${contextPath }/css/myPage.css">
		<script type="text/javascript">
			function check(){
				var frm = document.findFrm;
				if(frm.pwd.value == ""){
					alert("비밀번호를 입력해주세요.");
					frm.pwd.focus();
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
		<section class="inner secDesign">
			<div class="modDesign">
				<%if(session.getAttribute("id").equals(request.getAttribute("id"))){%>
					<form action="${contextPath }/board/boardFix.do" method=post name="findFrm">
						아이디: <%=session.getAttribute("id")%> <br>
						비밀번호: <input type="password" name="pwd" class="Pwd"><br>
						<input type="hidden" value="<%=session.getAttribute("id")%>" name="id" >					
						<input type="hidden" value="<%=request.getAttribute("num")%>" name="num">
						<input type="button" value="확인" class="ok" onClick="check()">
					</form>
				<%} %>
				</div>
		</section>
	</body>
</html>