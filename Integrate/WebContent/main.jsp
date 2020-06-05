<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" session="true"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<link rel="stylesheet" href="css/style.css">
		<title>main</title>
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
		
		<nav class="inner">
			<div class="menu-bottom">
				<ul class="bottom_position">
					<li><a href="#">커뮤니티</a></li>
					<li><a href="#">유머/정보</a></li>
					<li><a href="#">스포츠</a></li>
					<li><a href="#">쇼핑</a></li>
					<li><a href="#">갤러리</a></li>
					<li><a href="#">게임</a></li>
					<li><a href="#">기타</a></li>
				</ul>
			</div>
		</nav>
		
	</body>
</html>