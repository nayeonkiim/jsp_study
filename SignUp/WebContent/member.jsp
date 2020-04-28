<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<script type="text/javascript" src="script.js"></script>
		<script type="text/javascript">
			function idCheck(id){
				frm = document.memFrm;
				if(id==""){
					alert("아이디를 입력해 주세요.");
					frm.id.focus();
					return;
				}
				url="idCheck.jsp?id="+id;
				window.
				open(url,"idCheck","width=300, height=150");
			}
		
		</script>
		<title>회원가입</title>
	</head>
	<body >
		<form name="memFrm" action="memberProc.jsp" method="post">
			<table align="center" border="1">
				<tr>
					<th colspan="3">회원가입</th>
				</tr>
				<tr>
					<td>아이디</td>
					<td><input name="id" >
						<input type="button" value="ID중복" onClick="idCheck(this.form.id.value)">
					</td>
					<td> 아이디를 입력하세요.</td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="pwd" >
					</td>
					<td> 비밀번호를 입력하세요.</td>
				</tr>
				<tr>
					<td>비밀번호 확인</td>
					<td><input type="password" name="repwd" >
					</td>
					<td> 비밀번호를 한번 더입력하세요.</td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input name="name" >
					</td>
					<td> 이름을 입력하세요.</td>
				</tr>
				<tr>
					<td>성별</td>
					<td>
						<input type="radio" value="1" name="gender" checked="checked">남자
						<input type="radio" value="2" name="gender">여자
					</td>
					<td> 성별을 선택하세요.</td>
				</tr>
				<tr>
					<td>생년월일</td>
					<td>
						<input name="birth" >
						ex) 980622
					</td>
					<td> 생년월일을 입력하세요.</td>
				</tr>
				<tr>
					<td>Email</td>
					<td><input name="email" >
					</td>
					<td> 이메일을 입력하세요.</td>
				</tr>
				<tr>
					<td>주소</td>
					<td><input name="addr" >
					</td>
					<td> 주소를 입력하세요.</td>
				</tr>
				<tr>
					<td>취미</td>
					<td>
						<input type="checkbox" name="hobby" value="코딩" >코딩
						<input type="checkbox" name="hobby" value="운동" >운동
						<input type="checkbox" name="hobby" value="악기연주" >악기연주
						<input type="checkbox" name="hobby" value="독서" >독서			
					</td>
					<td> 취미를 입력하세요.</td>
				</tr>
				<tr>
					<td> 직업</td>
					<td>
						<select name="job">
							<option value="0" selected>선택하세요</option>
							<option value="회사원">회사원</option>
							<option value="디자이너">디자이너</option>
							<option value="프로그래머">프로그래머</option>
							<option value="건축가">건축가</option>
							<option value="바리스타">바리스타</option>
						</select>
					</td>
					<td>직업을 선택하세요.</td>
				</tr> 
				<tr> 
					<td colspan="3" align="center">
						<input type="button" value="회원가입" onClick="inputCheck()">
						<input type="reset" value="다시작성">
						<input type="button" value="로그인 " 
						onClick="javascript:location.href='login.jsp'">
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>