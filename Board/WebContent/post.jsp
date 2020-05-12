<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>글쓰기</title>
		<script type="text/javascript">
			function warning(){
				var v = confirm( "현재 작성 중인 글은 저장되지 않습니다." );
				if(v == true){
					location.href="list.jsp";
				}
			}
		</script>
	</head>
	<body>
		<table align="center">
			<tr>
				<td colspan="2" align="center"> 글쓰기</td>
			</tr>	
		</table>
		
		<!-- 서블릿 BoardPostServlet의 매핑, 설정된 boardPost 호출  action을 boardPost로 설정했으므로 전체 작성된 값들이 넘어감-->
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
					<td colspan="2"><hr/>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="submit" value="등록">
						<input type="reset" value="다시쓰기">
						<input type="button" value="리스트" onClick="javascript:warning()">
 					</td>
				</tr>							
			</table>
			<input type="hidden" name="ip" value="<%=request.getRemoteAddr() %>">  <!-- 게시물을 등록한 사용자의 IP 주소 가져옴 -->
			
		</form>
	</body>
</html>