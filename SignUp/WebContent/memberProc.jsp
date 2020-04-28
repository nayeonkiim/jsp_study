<!-- 회원가입이 된 정상적으로 이루어지도록 insert를 진행. -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
%> 
<jsp:useBean id="mgr" class="com.signup.MemberMgr" /> 
<jsp:useBean id="bean" class="com.signup.MemberBean" />
<jsp:setProperty name="bean" property="*" />

<%	
	
	String msg = "회원가입에 실패하였습니다.";
	String location = "member.jsp";
	boolean result = mgr.InsertMember(bean);
	
	if(result){
		msg = "회원가입이 되었습니다.";
		location = "login.jsp";
	}
%>

<script>
	alert("<%=msg%>");
	location.href = "<%=location %>";
	/*다른 페이지로 redirect 시키기 */
</script>>