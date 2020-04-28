<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mgr" class="com.signup.MemberMgr"/>

<%
	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("login_id");
	String pwd = request.getParameter("login_pwd");

	String msg = "아이디와 비밀번호가 일치하지 않습니다.";
	String location = "login.jsp";
	boolean flag = mgr.IdPwCorrect(id, pwd);

	if(flag){
		session.setAttribute("key",id);
		msg = "로그인에 성공하셨습니다.";
	}
%>

<script>
	alert("<%=msg%>");
	location.href = "<%=location%>";
</script>