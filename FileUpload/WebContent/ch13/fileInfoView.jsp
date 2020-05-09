<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest,
				com.oreilly.servlet.multipart.DefaultFileRenamePolicy,
				java.util.*, 
				java.io.*"							
%>
<!--java.util.*은 Enumeration 사용위해,  java.io.*은 IOException으로 예외 받기 위해-->

<%
	String saveFolder = "C:/Users/rlask/git/jsp_study/FileUpload/WebContent/ch13/filestorage/";
	String encType = "UTF-8";
	int maxSize = 10*1024*1024;
	
	/*  getServletContext()를 이용하여 ServletContext 객체 얻어 saveFolder의 실제 경로 얻어옴 */
	ServletContext context = getServletContext();  
	ArrayList saveFiles = new ArrayList();
	ArrayList origFiles = new ArrayList();
	
	String user = "";
	String title = "";
	String content = "";
	
	try{
		MultipartRequest multi = new MultipartRequest(request, saveFolder, maxSize, encType,
				new DefaultFileRenamePolicy());   //request객체, 파일 저장할 위치, 최대 사이즈, 인코딩방법, 파일이름중복 발생시 처리 규정
		/* 앞 페이지의 input value값을 가져옴 */
		user = multi.getParameter("user"); 
		title = multi.getParameter("title");
		content = multi.getParameter("content");
		
		//input의 file타입의 이름을 가져옴
		Enumeration files = multi.getFileNames();
		while(files.hasMoreElements()){
			String name = (String)files.nextElement();
			saveFiles.add(multi.getFilesystemName(name));   //실제로 저장된 이름
			origFiles.add(multi.getOriginalFileName(name));  //사용자가 지정한 이름
		}
%>
<html>
	<head>
		<meta charset="UTF-8">
		<title>File Info Page</title>
	</head>
	<body>
		<div align="center">
			<table border="1">
				<tr>
					<th>user</th>
						<!-- onkeyup 이벤트는 키입력을 위한 키보드가 눌러졌다가 다시 올라오는 순간 이벤트가 발생 -->
					<td><%=user %></td>
					<th>title</th>
					<td><%=title %></td>
				</tr>
				<tr>
					<th>content</th>
					<td colspan="3"><%=content %></td>
				</tr>
				<tr>
					<td colspan="4">업로드된 파일들입니다.</td>
				</tr>
				<%for(int i=0;i<saveFiles.size();i++) {%>
				<tr>
					<td colspan="4">
						<a href="<%="./filestorage/"+saveFiles.get(i)%>">  <!-- 실제 저장된 파일 이름으로 get -->
						<%=origFiles.get(i) %>                             <!-- 사용자가 지정한 파일 이름으로 출력-->   
					</a></td>
				</tr>
				<%} %>
			</table>
		</div>
	</body>
</html>
<%
	}catch(IOException io){
		io.printStackTrace();
	}catch(Exception e){
		e.printStackTrace();
	}
%>