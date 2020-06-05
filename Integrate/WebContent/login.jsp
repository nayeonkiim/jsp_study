<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<link rel="stylesheet" href="css/loginStyle.css">
		<link rel="stylesheet" href="css/style.css">
		<title>로그인 페이지</title>
		<script type="text/javascript">
			function loginCheck(){
				frm = document.loginFrm;
				if(frm.userID.value == ''){
					alert("아이디를 입력하세요!");
					frm.userID.focus();
					return;
				}
				if(frm.userPassword.value == ''){
					alert("비밀번호를 입력하세요!");
					frm.userPassword.focus();
					return;
				}
				frm.submit();
			}
		</script>
	</head>
	<body>
		<header>
				<div class="inner head_feature">
					<h1><a href="main.jsp">나연 커뮤니티</a></h1>
					<div class="menu_top">
						<ul class="header_position">
							<li><a href="board.jsp">글쓰기</a></li>
							<li><a href="login.jsp">로그인</a></li>
							<li><a href="join.jsp">회원가입</a></li>
						</ul>
					</div>
				</div>
			</header>	
		<div class="inner login_form">
			<h1>로그인</h1>
			<form method=post action="loginAction.jsp" name="loginFrm">
				<table class="table" border="1">
					<tr>
						<td>아이디</td>
						<td> <input type="text" name="userID"></td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td><input type="password" name="userPassword"></td>
					</tr>
				</table>
				<div class="button">
					<input type="button" value="로그인" onClick="loginCheck()">
					<input type="reset" value="다시 작성">
				</div>

			</form>
		</div>
	</body>
</html>