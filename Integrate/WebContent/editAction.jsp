<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.*" %>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("utf-8");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	int num = Integer.parseInt(request.getParameter("num"));
	BoardDao dao = new BoardDao();	
	int result = dao.editArticle(title, content, num);
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>수정한 내용 저장</title>
	</head>
	<body>
		<%
			if(result == 1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('수정이 완료되었습니다.')");
				script.println("location.href='board.jsp'");
				script.println("</script>");
			}else{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('수정되지 않았습니다. 다시 시도해주세요.')");
				script.println("history.back()");
				script.println("</script>");
			}
		%>
	</body>
</html>