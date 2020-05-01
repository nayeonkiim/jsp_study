<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!--paramName으로 지정된 부분에 입력값 보존위해  -->
<%!
	public String getParam(HttpServletRequest request, String paramName){
		if(request.getParameter(paramName) != null){
			return request.getParameter(paramName);
		}else{
			return "";
		}
	}
%>
<%	
	request.setCharacterEncoding("UTF-8");
	int filecounter = 0;
	if(request.getParameter("addcnt") != null){
		filecounter = Integer.parseInt(request.getParameter("addcnt"));  //추가할 파일의 갯수가 filecounter에 들어감
	}
%>
<html>
	<head>
		<meta charset="UTF-8">
		<title>File upload Page</title>
		<script type="text/javascript">

			/* frmName1의 요소 value값을 frmName2의 요소 value값에 넣어줌 */
			function inputValue(form1, param, form2, idx){
				var paramValue = form1.elements[idx].value;
				form2.elements[idx].value = paramValue;
				return;
			}
			
			/* 파일 갯수 입력란에 입력이 되지 않은 경우 경고, 입력이 된 경우 sumbit */
			function addFile(forName){
				if(forName.addcnt.value ==""){
					alert("입력할 파일 개수를 입력하고 확인버튼을 눌러주세요.");
					forName.addcnt.focus();
					return;
				}
				forName.submit();
			}
			
			/*파일 누락 체크 후 누락되지 않은경우 fileInfoView.jsp 페이지로 이동  */
			function elementCheck(formName){
				paramIndex = 1;
				for(idx=0; idx<formName.elements.length; idx++){
					if(formName.elements[idx].type == "file"){
						if(formName.elements[idx].value ==""){
							var message = paramIndex + " 번째 파일정보가 누락되었습니다.\n 업로드할 파일을 선택해 주세요";
							alert(message);
							formName.elements[idx].focus();
							return;
						}
						paramIndex++;
					}
				}
				formName.action = "fileInfoView.jsp";
				formName.submit();
			}
		</script>
	</head>
	<body>
		<div align="center">
			복수개의 파일의 업로드를 위하여 파일 갯수를 입력한 후<br/>
			 확인 버튼을 눌러주세요!!<br/> 
			입력이 완료되면 DONE 버튼을 눌러주세요<br/>
			<form name="frmName1" method="post">   <!--form에 action이 선언되어 있지 않으므로 현재 페이지 다시 호출 -->
				<table border="1">
					<tr>
						<th>user</th>
						<!-- onkeyup 이벤트는 키입력을 위한 키보드가 눌러졌다가 다시 올라오는 순간 이벤트가 발생 -->
						<td><input name="user" onkeyup="inputValue(this.form,user,frmName2,0)" 
						value="<%=getParam(request, "user")%>"></td>
						<th>title</th>
						<td><input name="title" onkeyup="inputValue(this.form,title,frmName2,1)"
						value="<%=getParam(request,"title") %>"></td>
					</tr>
					<tr>
						<th>content</th>
						<td colspan="3">
						<input name="content" onkeyup="inputValue(this.form,content,frmName2,2)"
						value="<%=getParam(request, "content")%>"></td>
					</tr>
					<tr>
						<td colspan="4"> 
						 추가할 파일 수 입력
						<input name="addcnt">
						<input type="button" value="확인" onClick="addFile(this.form)">
					</tr>	
				</table>
			</form>
			<form name="frmName2" method="post" enctype="multipart/form-data">
				<table border="1">
					<tr>
						<td>
							<!-- frmName1의 텍스트 필드에 입력된 값들이 담김. -->
							<input type="hidden" name="user" value="<%=getParam(request,"user") %>">
							<input type="hidden" name="title" value="<%=getParam(request,"title") %>">
							<input type="hidden" name="content" value="<%=getParam(request,"content") %>">
							
							<!-- filecounter만큼 file 추가란이 생성 -->
							<% for(int i=0;i<filecounter;i++){%>
								<input type="File" size="50" name="selectFile<%=i %>"><br/>
							<%} %>
						</td>
						<td><input type="button" value="DONE" onClick="elementCheck(this.form)"></td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>