<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>회원 가입창</title>
		<link rel="stylesheet" href="${contextPath }/css/mainStyle.css">
		<link rel="stylesheet" href="${contextPath }/css/memStyle.css">
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script type="text/javascript">
			var idck = 0;
			function fn_process(){
				var oEle1 = document.getElementById('id') ;
				idck = 0;
				var _id = $("#id").val();
				if(_id == ''){
					alert("아이디를 입력하세요.");
					return;
				}
				$.ajax({
					type: "post",
					async: false,
					url: "http://localhost:8080/ch17/idCheckServlt",
					dataType: "text",
					data: { id : _id },
					success: function(data, textStatus){
						if(data == "usable"){
							alert("사용가능한 아이디 입니다.");
							idck = 1;
							oEle1.readOnly = true;
						}else{
							alert("이미 존재하는 아이디 입니다.");
						}
					},
					 error : function(error) {
			             alert("error : " + error);
			        }
				});
			};
			
			function checkInput(){
				if($("#id").val() == ''){
					alert("아이디를 입력해주세요.");
					return;
				}
				if($("#pwd").val() == ''){
					alert("비밀번호를 입력해주세요.");
					return;
				}
				if($("#name").val() == ''){
					alert("이름을 입력해주세요.");
					return;
				}
				if($("#email").val() == ''){
					alert("이메일을 입력해주세요.");
					return;
				}
				if(idck != 1){
					alert("아이디 중복체크를 해주세요.");
					return;
				}
				document.frm.submit();
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
		<section class="inner secMem">
			<div class="secPo">
				<form method="post" action="${contextPath }/member/addMember.do" name="frm">
					<h1>Join Us</h1>
						<table>
							<tr>
								<td>
									<p>아이디</p>
								</td>
								<td>
									<input type="text" name="id" id="id">
									<input type="button" value="중복확인" id="btn" onClick="fn_process()">
									
								</td>
							</tr>
							<tr>
								<td>
									<p>비밀번호</p>
								</td>
								<td>
									<input type="text" name="pwd" id="pwd">
								</td>
							</tr>
							<tr>
								<td>
									<p>이름</p>
								</td>
								<td>
									<input type="text" name="name" id="name">
								</td>
							</tr>
							<tr>
								<td>
									<p>이메일</p>
								</td>
								<td>
									<input type="text" name="email"  id="email">
								</td>
							</tr>
							<tr>
								<td>
									<p>&nbsp;</p>
								</td>
								<td>
									<input type="button" value="가입하기" onClick="checkInput()" class="btnMem"><br>
								</td>
							</tr>
						</table>
					</form>
				</div>
		</section>
	</body>
</html>