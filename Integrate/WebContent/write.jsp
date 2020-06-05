<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<link rel="stylesheet" href="css/style.css" />
		<link rel="stylesheet" href="css/insertStyle.css" />
		<script type="text/javascript">
			function writeCheck(){
				frm = document.writeFrm;
				if(frm.title.value == ''){
					alert("제목을 입력하세요!");
					frm.title.focus();
					return;
				}
				if(frm.userID.value == ''){
					alert("아이디를 입력하세요!");
					frm.userID.focus();
					return;
				}
				if(frm.content.value == ''){
					alert("내용을 입력하세요!");
					frm.content.focus();
					return;
				}
				frm.submit();
			}
		</script>
		<title>글쓰기</title>
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
		
		<nav class="inner write_feature">
			<form name="writeFrm" action="boardAction.jsp" method=post>
				<table class="table">
					<tr>
						<th colspan="2" class="titleSize">글쓰기</th>
					</tr>
					<tr>
						<th>제목</th>
						<td><input type="text" name="title"></td>
					</tr>
					<tr>
						<th>아이디</th>
						<td><input type="text" name="userID"></td>
					</tr>
					<tr>
						<th>내용</th>
						<td><textarea cols="50" rows="8" name="content"></textarea></td>
					</tr>
				</table>
					<input type="hidden" name="available" value="1">
				<div class="btn-group">
					<input type="button" value="등록" onClick="writeCheck()">
					<input type="button" value="취소" onClick="location.href='board.jsp'">
				</div>
			</form>
		</nav>
	</body>
</html>