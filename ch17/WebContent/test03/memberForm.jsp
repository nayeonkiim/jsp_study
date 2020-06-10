<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>회원 가입창</title>
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script type="text/javascript">
			var idck = 0;
			function fn_process(){
				var oEle1 = document.getElementById('id') ;
				idck = 0;
				var _id = $("#id").val();
				if(_id == ''){
					alert("아이디를 입력하세요.");
					return;
				}
				$.ajax({
					type: "post",
					async: false,
					url: "http://localhost:8080/ch17/idCheckServlt",
					dataType: "text",
					data: { id : _id },
					success: function(data, textStatus){
						if(data == "usable"){
							alert("사용가능한 아이디 입니다.");
							idck = 1;
							oEle1.readOnly = true;
						}else{
							alert("이미 존재하는 아이디 입니다.");
						}
					},
					 error : function(error) {
			             alert("error : " + error);
			        }
				});
			};
			
			function checkInput(){
				if($("#id").val() == ''){
					alert("아이디를 입력해주세요.");
					return;
				}
				if($("#pwd").val() == ''){
					alert("비밀번호를 입력해주세요.");
					return;
				}
				if($("#name").val() == ''){
					alert("이름을 입력해주세요.");
					return;
				}
				if($("#email").val() == ''){
					alert("이메일을 입력해주세요.");
					return;
				}
				if(idck != 1){
					alert("아이디 중복체크를 해주세요.");
					return;
				}
				document.frm.submit();
			}
		</script>
	<body>
		<form method="post" action="${contextPath }/member/addMember.do" name="frm">
			<h1>회원가입</h1>
			<table>
				<tr>
					<td>
						<p>아이디</p>
					</td>
					<td>
						<input type="text" name="id" id="id">
						<input type="button" value="중복확인" id="btn" onClick="fn_process()">
						
					</td>
				</tr>
				<tr>
					<td>
						<p>비밀번호</p>
					</td>
					<td>
						<input type="text" name="pwd" id="pwd">
					</td>
				</tr>
				<tr>
					<td>
						<p>이름</p>
					</td>
					<td>
						<input type="text" name="name" id="name">
					</td>
				</tr>
				<tr>
					<td>
						<p>이메일</p>
					</td>
					<td>
						<input type="text" name="email"  id="email">
					</td>
				</tr>
				<tr>
					<td>
						<p>&nbsp;</p>
					</td>
					<td>
						<input type="button" value="가입하기" onClick="checkInput()">
						<input type="reset" value="다시입력">
						<input type="button" value="리스트" onClick="location.href='${contextPath}/member/listMembers.do'">
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>