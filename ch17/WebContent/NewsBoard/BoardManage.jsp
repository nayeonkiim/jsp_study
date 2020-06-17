<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>insert title here</title>
		<script type="text/javascript">
			window.location.replace("${contextPath }/board/Newslist.do");
		</script>
	</head>
</html>