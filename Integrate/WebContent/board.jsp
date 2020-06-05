<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.List" %>
<%@ page import="board.*" %>
<%
	if(session.getAttribute("userID") == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 먼저 해주세요!')");
		script.println("location.href='main.jsp'");
		script.println("</script>");
	}
%>
<%
	request.setCharacterEncoding("utf-8");
	
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<link rel="stylesheet" href="css/style.css">
		<link rel="stylesheet" href="css/boardStyle.css">
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
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일자</th>
					</tr>
					<%	
						BoardDao dao = new BoardDao();
						List<Board> mList = dao.listToBoard(1);
						for(int i=0;i<mList.size();i++){
							Board item = mList.get(i);
					%>
					<tr align="center">
						<td class="in"><%=item.getNum() %></td>
						<td class="in"><a href="read.jsp?num=<%=item.getNum() %>"><%=item.getTitle() %></a></td>
						<td class="in"><%=item.getUserID() %></td>
						<td class="in"><%=item.getDate() %></td>
					</tr>
					<%} %>
				</table>
			</div>
			<input type="button" value="글쓰기" onClick="location.href='write.jsp'" class="writeBtn">
		</nav>
	</body>
</html>