<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<link rel="stylesheet" href="css/style.css">
		<link rel="stylesheet" href="css/joinStyle.css">
		<script type="text/javascript">
			function joinCheck(){
				var frm = document.joinFrm;
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
				if(frm.userRePassword.value != frm.userPassword.value){
					alert("비밀번호가 동일하지 않습니다. 다시 입력하세요!");
					frm.userRePassword.focus();
					return;
				}
				if(frm.userRePassword.value == ''){
					alert("비밀번호를 다시 입력하세요!");
					frm.userRePassword.focus();
					return;
				}
				if(frm.userEmail.value == ''){
					alert("이메일을 입력하세요!");
					frm.userEmail.focus();
					return;
				}
				frm.submit();
			}
			
			function duplicate(userID){  //중복 체크
				frm = document.joinFrm;
				if(userID==""){
					alert("아이디를 입력해주세요!");
					frm.userID.focus();
					return;
				}
				url = "dupCheck.jsp?userID="+userID;
				 window.open(url, "idcheck", "width=400,height=400");
			}
		</script>
		<title>회원가입</title>
	</head>
	<body>
		<header>
			<div class="inner head_feature">
				<h1><a href="main.jsp">나연 커뮤니티</a></h1>
				<div class="menu_top">
					<ul class="header_position">
						<li><a href="board.jsp">글쓰기</a></li>
						<%
							if(session.getAttribute("userID") != null){
						%>
								<li><a href="logOut.jsp">로그아웃</a></li>
						<%}else{ %>
								<li><a href="login.jsp">로그인</a></li>
						<%} %>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</div>
			</div>
		</header>
		<nav>
			<div class="inner join-position">
				<h1>회원가입</h1>
				<form name="joinFrm" action="joinAction.jsp" action=post>
					<table class="indent" border="1">
						<tr>
							<td>아이디 </td>
							<td><input type="text" name="userID">
								<input type="button" value="중복체크" onClick="duplicate(this.form.userID.value)"> 
							</td>
						</tr>
						<tr>
							<td>비밀번호 </td>
							<td><input type="password" name="userPassword"></td>
						</tr>
						<tr>
							<td>비밀번호 확인 </td>
							<td><input type="password" name="userRePassword"></td>
						</tr>
						<tr>
							<td>이름 </td>
							<td><input type="text" name="userName" ></td>
						</tr>
						<tr>
							<td>성별 </td> 
							<td><input type="radio" value="girl" name="userGender" checked>여자
								<input type="radio" value="boy" name="userGender">남자
							</td>
						</tr>
						<tr>
							<td>이메일 </td>
							<td><input type="email" name="userEmail"></td>
						</tr>
					</table>
					<div class="button">
						<input type="button" value="가입하기" class="next" onClick="joinCheck()">
						<input type="reset" value="다시쓰기">
					</div>
				</form>
			</div>
		</nav>	
	</body>
</html>