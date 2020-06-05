<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import ="board.BoardDao"%>
<%@page import="java.io.PrintWriter" %>
<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="bIns" class="board.Board"/>
<jsp:setProperty name="bIns" property="*" />

<%
	BoardDao dao = new BoardDao();
	int num = dao.maxNum();
	bIns.setNum(num);
	int result = dao.insertBoard(bIns);
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>게시판 등록 처리</title>
	</head>
	<body>
		<%
			if(result == 1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('게시글이 등록되었습니다.')");
				script.println("location.href='board.jsp'");
				script.println("</script>");
			}else{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('게시글 등록에 실패하였습니다. 다시 시도해주세요.)");
				script.println("history.back()");
				script.println("</script>");
			}
		%>
	</body>
</html>