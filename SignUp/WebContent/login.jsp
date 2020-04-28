<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
	String id = (String)session.getAttribute("key");
%>

<html>
	<head>
		<meta charset="UTF-8">
		<title>login</title>
		<script>
			function checkForm(){
				frm = document.login_form;
				if(frm.login_id.value==""){
					alert("아이디를 입력하세요.");
					frm.login_id.focus();
					return;
				}
				if(frm.login_pwd.value == ""){
					alert("비밀번호를 입력하세요.");
					frm.login_pwd.focus();
					return;
				}
				frm.submit();
			}
		</script>
	</head>
	<body>
		<div align="center">
		<%if(id != null) {%>
			<%=id%>님 환영합니다.<br/><br/>
			제한된 기능을 사용할 수 있습니다.<br/><br/>
			<a href="logout.jsp">로그아웃</a>
		<%} else{%>
			<h2>로그인</h2>
			<div>
				<form name="login_form" action="loginPro.jsp" method="post">
					아이디 <input name="login_id"><br/><br/>
					비밀번호 <input type="password" name="login_pwd"><br/><br/>
					<input type="button" value="로그인" onClick="checkForm()">
				</form>
			</div>
			<%} %>
		</div>
	</body>
</html>
