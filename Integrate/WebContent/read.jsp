<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.*" %>
<%
	request.setCharacterEncoding("utf-8");
	int num = Integer.parseInt(request.getParameter("num"));
	BoardDao dao = new BoardDao();
	Board board = dao.listOneBoard(num);
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<link rel="stylesheet" href="css/style.css">
		<link rel="stylesheet" href="css/readStyle.css">
		<title>게시판</title>
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
		<nav class="inner po">
			<div class="fix">
				<table class="table">
					<tr>
						<th width="200px" height="30px">제목</th>
						<td><%=board.getTitle() %></td>
					</tr>
					<tr>
						<th width="200px" height="30px">작성자</th>
						<td><%=board.getUserID() %></td>
					</tr>
					<tr>
						<th width="200px" height="30px">작성일자</th>
						<td><%=board.getDate() %></td>
					</tr>
					<tr>
						<th width="200px" height="30px">내용<th>
						<td colspan="2"><%=board.getContent() %></td>
					</tr>
				</table>
				<div class="btnReposition">
					<input type="button" value="목록으로" onClick="location.href='board.jsp'">
					<input type="button" value="수정하기" onClick="location.href='edit.jsp?num=<%=num%>'">
				</div>	
			</div>
		</nav>
	</body>
</html>