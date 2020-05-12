<!-- 게시물 수정 페이지  -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.board.BoardBean" %>
<%	
	/*nowPage와 num이 list.jsp로 부터 넘어옴  */
	int num = Integer.parseInt(request.getParameter("num"));
	String nowPage = request.getParameter("nowPage");
	BoardBean bean = (BoardBean)session.getAttribute("bean");  //list.jsp에서 세션 설정해둔거 가져오기
	String subject = bean.getSubject();
	String name = bean.getName();
	String content = bean.getContent();
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Jsp update</title>
		<script type="text/javascript">
			function check(){
				if(document.updateFrm.pass.value == ""){
					alert("비밀번호를 입력해주세요.");
					document.updateFrm.pass.focus();
					return;
				}
				document.updateFrm.submit();
			}
		</script>
	</head>
	<body>
		<div align="center">
			<h2>수정하기</h2>
			<form name="updateFrm" action="boardUpdate" method="post">
			<table>
				<tr>
					<td>성명</td>
					<td><input name="name" value="<%=name %>"></td>
				</tr>
				<tr>
					<td>제목</td>
					<td><input name="subject" value="<%=subject %>"></td>
				</tr>
				<tr>
					<td>내용</td>
					<td><textarea name="content" rows="10" cols="50"><%=content %></textarea></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="pass">
					수정 시에는 비밀번호가 필요합니다.</td>
				</tr>
				<tr>
					<td colspan="2"><hr/></td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="button" value="수정완료" onClick="check()">
						<input type="reset" value="다시수정">
						<input type="button" value="뒤로" onClick="history.go(-1)">
					</td>
				</tr>
			</table>
			<input type="hidden" name="nowPage" value="<%=nowPage %>">
			<input type="hidden" name="num" value="<%=num %>">
			</form>
		</div>
	</body>
</html>