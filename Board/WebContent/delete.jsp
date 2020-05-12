<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.board.BoardBean" %>
<jsp:useBean id="bMgr" class="com.board.BoardMgr" />
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Jsp Board delete</title>
		<%
			/* read.jsp로 부터 nowPage, num이 넘어옴 */
			request.setCharacterEncoding("utf-8");
			String nowPage = request.getParameter("nowPage");
			int num = Integer.parseInt(request.getParameter("num"));
			if(request.getParameter("pass") != null){
				String inPass = request.getParameter("pass");  //delete.jsp에서 입력한 pass 값
				BoardBean bean = (BoardBean)session.getAttribute("bean");  //read.jsp에서 세션에 저장한 게시물 가져옴
				String dbPass = bean.getPass();  //session에 저장한 게시물의 pass값을 반환함
				if(inPass.equals(dbPass)){
					bMgr.deleteBoard(num); //게시물 삭제
					String url = "list.jsp?nowPage="+nowPage;
					response.sendRedirect(url);
				}else{
		%>
	<script type="text/javascript">
		alert("입력하신 비밀번호가 아닙니다.");
		history.back();
	</script>
						<%}
			}else{	
	%>
	<script type="text/javascript">
		function check(){
			if(document.delFrm.pass.value==""){
				alert("패스워드를 입력하세요.");
				document.delFrm.pass.focus();
				return false;
			}
			document.delFrm.submit();
		}
		<%} %>
	</script>
	</head>
	<body>
		<div align="center">
			<br/><br/>
			<table>
				<tr>
					<td align="center">
						사용자의 비밀번호를 입력해주세요.
					</td>
				</tr>
			</table>
			<form name="delFrm" action="delete.jsp">
				<table>
					<tr>
						<td align="center">
						<input type="password" name="pass">
						</td>
					</tr>
					<tr>
						<td><hr/></td>
					</tr>
					<tr>
						<td align="center">
						<input type="button" value="삭제완료" onClick="check()">
						<input type="reset" value="다시쓰기">
						<input type="button" value="뒤로" onClick="history.go(-1)">
						</td>
					</tr>	
				</table>
				<!-- [삭제 완료]버튼을 클릭하면 입력한 비밀번호와 현재 페이지 값과 게시번호 값을 자기 자신의 페이지로 호출 해야함.-->
				<input type="hidden" name="nowPage" value="<%=nowPage %>">
				<input type="hidden" name="num" value="<%=num %>">
			</form>
		</div>

	</body>
</html>