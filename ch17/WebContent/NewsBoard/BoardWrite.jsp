<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<% String id = request.getParameter("id"); %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>게시물 쓰기</title>
		<link rel="stylesheet" href="${contextPath }/css/mainStyle.css">
		<link rel="stylesheet" href="${contextPath }/css_B/writeStyle.css">
		<script type="text/javascript">
			function formCheck(){
				frm = document.postFrm;
				if(frm.name.value == ""){
					alert("이름을 입력하세요");
					return;
				}
				if(frm.subject.value == ""){
					alert("제목을 입력하세요");
					return;
				}
				if(frm.content.value == ""){
					alert("내용을 입력하세요");
					return;
				}
				if(frm.pass.value == ""){
					alert("비밀번호를 입력하세요");
					return;
				}
				if(frm.pass.value == ""){
					alert("비밀번호를 입력하세요");
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
						<td colspan="2" align="center"><h2>글쓰기</h2></td>
					</tr>
				</table>
				<form action="${contextPath }/board/DoWrite.do" name="postFrm" method=post enctype="multipart/form-data">
					<table>
						<tr>
							<td colspan="2"><hr/></td>
						</tr>
						<tr>
							<td>성명</td>
							<td><input name="name"></td>
						</tr>
						<tr>
							<td>아이디</td>
							<td><%=id %></td>
						</tr>
						<tr>
							<td>제목</td>
							<td><input name="subject"></td>
						</tr>
						<tr>
							<td>내용</td>
							<td><textarea name="content" rows="10" cols="50"></textarea></td>
						</tr>
						<tr>
							<td>비밀번호</td>
							<td><input type="password" name="pass"></td>
						</tr>
						<tr>
							<td>파일 찾기</td>
							<td><input type="file" name="filename"></td>
						</tr>
						<tr>
							<td>내용타입</td>
							<td>HTML<input type="radio" name="contentType" value="HTTP">&nbsp;&nbsp;&nbsp;
							TEXT<input type="radio" name="contentType" value="TEXT" checked>
							</td>
						</tr>
						<tr>
							<td colspan="2"><hr/>
							<input type="hidden" name="id" value="<%=id %>">
							</td>
						</tr>
						<tr>
							<td colspan="2" align="center">
								<input type="button" value="등록" onClick="formCheck()">
								<input type="reset" value="다시쓰기">
								<input type="button" value="리스트" onClick="location.href='${contextPath}/board/Newslist.do?start=0'">
							</td>
						</tr>
					</table>
				</form>
			</div>
		</section>
	</body>
</html>