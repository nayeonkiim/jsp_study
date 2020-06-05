<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDao" %>
<%@ page import="java.io.PrintWriter" %>
<%request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="mJoin" class="user.User" />
<jsp:setProperty name="mJoin" property="*" />

<%
	UserDao uDao = new UserDao();
	int result = uDao.InsertMem(mJoin);
	if(result == 1){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('회원가입에 성공하셨습니다.')");
		script.println("location.href='login.jsp'");
		script.println("</script>");
	}else{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('회원가입에 실패하셨습니다.')");
		script.println("location.href='join.jsp'");
		script.println("</script>");
	}
%>
