<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>글쓰기</title>
	</head>
	<body>
		<table align="center">
			<tr>
				<td colspan="2" align="center"> 글쓰기</td>
			</tr>	
		</table>
		
		<!-- 서블릿 BoardPostServlet의 매핑, 설정된 boardPost 호출 -->
		<form action="boardPost" name="postFrm" method="post" enctype="multipart/form-data">
			<table align="center">
				<tr>
					<td colspan="2" align="center"><hr/> </td>
				</tr>
				<tr>
					<td>성명</td>
					<td>
					<input name="name"></td>
				</tr>
				<tr>
					<td>제목</td>
					<td><input name="subject"></td>
				</tr>
				<tr>
					<td>내용</td>
					<td><textarea name="content" rows="10" cols="50"></textarea></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="pass"></td>
				</tr>
				<tr>
					<td>파일 찾기</td>
					<td><input type="file" name="filename"></td>
				</tr>
				<tr>
					<td>내용타입</td>
					<td>HTML<input type="radio" name="contentType" value="HTTP">&nbsp;&nbsp;&nbsp;
					TEXT<input type="radio" name="contentType" value="TEXT" checked>
					</td>
				</tr>
				<tr>
					<td colspan="2"><hr/></td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="submit" value="등록">
						<input type="reset" value="다시쓰기">
						<input type="button" value="리스트" onClick="javascript:location.href='list.jsp'">
					</td>
				</tr>							
			</table>
			<input type="hidden" name="ip" value="<%=request.getRemoteAddr() %>">  <!-- 게시물을 등록한 사용자의 IP 주소 가져옴 -->
		</form>
	</body>
</html>