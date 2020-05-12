<!--답변 페이지  -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- read.jsp에서 세션에 저장한 게시물 객체를 세션에서 다시 가져옴. 저장한 id 값을 bean으로 선언 해야함. -->
<jsp:useBean id="bean" class="com.board.BoardBean" scope="session"/>  
<%
	/* read.jsp로 부터 nowPage가 넘어옴 */
	String nowPage = request.getParameter("nowPage");
	String subject = bean.getSubject();
	String content = bean.getContent();
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>JSPBoard</title>
	</head>
	<body>
		<div align="center">
			<h2>답변하기</h2>
			<br><br>
			<form action="boardReply" method="post">
			<table>
				<tr>
					<td>성명</td>
					<td><input name="name"></td>
				</tr>
				<tr>
					<td>제목</td>
					<td><input name="subject" value="답변: <%=subject %>"></td>
				</tr>
				<tr>
					<td>내용</td>
					<td>
					<textarea name="content" rows="10" cols="50"><%=content %>
					===========답변 글을 쓰세요.===========
					
					</textarea>
					</td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="pass"></td>
				</tr>
				<tr>
					<td colspan="2"><br/><br/><hr/></td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="답변 등록">
						<input type="reset" value="다시쓰기">
						<input type="button" value="뒤로" onClick="history.back()">
					</td>
				</tr>
			</table>
			<!--세션에 의해 bean.getXXX()이 가능  -->
			<input type="hidden" name="ip" value="<%=request.getRemoteAddr() %>">
			<input type="hidden" name="nowPage" value="<%=nowPage %>">
			<input type="hidden" name="ref" value="<%=bean.getRef() %>">
			<input type="hidden" name="pos" value="<%=bean.getPos() %>">
			<input type="hidden" name="depth" value="<%=bean.getDepth() %>">
			</form>
		</div>
	</body>
</html>