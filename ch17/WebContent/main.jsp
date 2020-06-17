<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<!DOCTYPE html>
<html>
	<head>
		<c:choose>
		   	<c:when test='${msg=="addMember" }'>
		      <script>
		         window.onload=function(){
		            alert("회원을 등록했습니다.");
		         }
		      </script>
		   </c:when>
			 <c:when test='${msg=="not_match" }'>
			      <script>
			         window.onload=function(){
			            alert("아이디와 비밀번호가 일치하지 않습니다.");
			         }
			      </script>
			  </c:when>
			  <c:when test='${msg=="logSuccess" }'>
			      <script>
			         window.onload=function(){
			            alert("로그인에 성공하였습니다.");
			         }
			      </script>
			  </c:when>
			  <c:when test='${msg=="logFail" }'>
			      <script>
			         window.onload=function(){
			            alert("아이디와 비밀번호가 일치하지 않습니다.");
			         }
			      </script>
			  </c:when>
			  <c:when test='${msg=="logOut" }'>
			      <script>
			         window.onload=function(){
			            alert("로그아웃 되었습니다.");
			         }
			      </script>
			  </c:when>
			  			<c:when test='${msg=="modified" }'>
		      <script>
		        window.onload=function(){
		          alert("회원 정보가 수정되었습니다.");
		        }
		      </script>
		     </c:when>
		</c:choose>
		<meta charset="UTF-8">
		<title>항상 Yeon~ 커뮤니티 입니다!</title>
		<link rel="stylesheet" href="${contextPath }/css/mainStyle.css">
	    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
		<script type="text/javascript">
			$("#sesCheck").click(function(e){
				e.preventDefault();
				alert("e.preventDefault()");
			});
		
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
							<a href="${contextPath }/member/listMembers.do?" class="join">관리자 페이지</a>
						<%}else {%>
							<a href="${contextPath }/member/myPage.do?id=<%=session.getAttribute("id") %>" class="join">마이 페이지</a>
						<%}
						
					}%>
					
					</div>
				</div>
			</div>
			<div class="main-menu">
				<ul>
					<li><a id="sesCheck" href="${contextPath }/board/Newslist.do">뉴스</a></li>
					<li><a href="#">영화</a></li>
					<li><a href="#">책</a></li>
					<li><a href="#">웹툰</a></li>
					<li><a href="#">쇼핑몰</a></li>
					<li><a href="#">음식</a></li>
					<li><a href="#">연애/결혼</a></li>
					<li><a href="#">여행</a></li>
				</ul>
			</div>
		</header>
	</body>
</html>