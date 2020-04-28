<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mgr" class="com.signup.MemberMgr"/>
<%
	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("id");
	boolean result = mgr.IdCheck(id);
%>

<html>
<head>
	<title>id인증</title>
</head>
<body>
	<div align="center">
			<br/><b><%=id %></b>
			<%
				if(result){
					out.print("는 이미 존재하는 ID입니다.<p/>");
					
				}else{
					out.print("는 사용 가능 합니다.<p/>");
				}
			%>
			<a href="#" onClick="self.close()">닫기</a>  
			<!--  현재창 닫히게 하는 스크립트 함수 -->
		</div>
</body>
</html>

