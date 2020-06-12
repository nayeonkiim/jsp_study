<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	isELIgnored="false" 
%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"  />  
<%
	request.setCharacterEncoding("UTF-8");
%>    
<html>	
	<head>
		<c:choose>
		   	<c:when test='${msg=="deleted" }'>
		      <script>
		         window.onload=function(){
		            alert("삭제되었습니다.");
		         }
		      </script>
		   </c:when>
		</c:choose>
	   	<meta  charset="UTF-8">
   		<title>회원 정보 출력창</title>
   		<link rel="stylesheet" href="${contextPath }/css/mainStyle.css">
   		<link rel="stylesheet" href="${contextPath }/css/listStyle.css">  
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
		<section class="inner secList">
		 	<p class="cls1">회원정보</p>
		    <div class="tablePos">
			   <table border="1" >
			      <tr align="center">
			         <td><b>아이디</b></td>
			         <td><b>비밀번호</b></td>
			         <td><b>이름</b></td>
			         <td><b>이메일</b></td>
			         <td><b>가입일</b></td>
			         <td><b>수정</b></td>
					 <td><b>삭제</b></td>
			 	  </tr>
				<c:choose>
			    	<c:when test="${empty memberList}" >
			      		<tr>
			        		<td colspan=5>
			          			<b>등록된 회원이 없습니다.</b>
			       			</td>  
			      		</tr>
			   		</c:when>  
			   		<c:when test="${!empty memberList}" >
			      		<c:forEach  var="mem" items="${memberList }" >
			        		<tr>
			          			<td>${mem.id }</td>
			      			    <td>${mem.pwd }</td>
			          			<td>${mem.name}</td>     
			          			<td>${mem.email }</td>     
			          			<td>${mem.joinDate}</td>
			          			<td><a href="${contextPath}/member/directMod.do?id=${mem.id }">수정</a></td>
					 			<td><a href="${contextPath}/member/delMember.do?id=${mem.id }">삭제</a></td>
			      			 </tr>
			   	  		</c:forEach>
					</c:when>
				</c:choose>
			</table>
		</div>
	</section>
	
	</body>
</html>