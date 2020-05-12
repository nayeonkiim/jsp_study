<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.board.BoardBean" %>
<jsp:useBean id="bMgr" class="com.board.BoardMgr"/>
<%
	/* 아래 num, nowPage, keyField, keyWord는 list.jsp로 부터 직접 넘어옴.  */
	request.setCharacterEncoding("utf-8");
	int num = Integer.parseInt(request.getParameter("num"));
	String nowPage = request.getParameter("nowPage");
	String keyField = request.getParameter("keyField");
	String keyWord = request.getParameter("keyWord");
	bMgr.upCount(num);  //조회수 증가
	
	/* 요청한 게시물을 빈즈 단위로 가져옴  */
	BoardBean bean = bMgr.getBoard(num);
	String name = bean.getName();
	String subject = bean.getSubject();
	String regdate = bean.getRegdate();
	String content = bean.getContent();
	String filename =bean.getFilename();
	int filesize = bean.getFilesize();
	String ip = bean.getIp();
	int count = bean.getCount();
	session.setAttribute("bean", bean);         //'bean'라는 키 값으로 빈즈 객체 저장
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>insert title here</title>
		<script type="text/javascript">
			function list(){
				document.listFrm.submit();
			}
			function down(fileName){
				document.downFrm.filename.value = fileName;
				document.downFrm.submit();
			}
		</script>
	</head>
	<body>
	<br/><br/>
	<table align="center" border="0">
		<tr>
			<td align="center">글읽기</td>
		</tr>
		<tr>
			<td colspan="2">
				<table border="0">
					<tr>
						<td align="center">이름</td>
						<td><%=name %></td>
						<td align="center">등록날짜</td>
						<td><%=regdate %></td>
					</tr>
					<tr>
						<td align="center">제목</td>
						<td colspan="3"><%=subject %></td>
					</tr>
					<tr>
						<td align="center">첨부파일</td>
						<td colspan="3">
						<%if(filename != null && !filename.equals("")) {%>
							<a href="javascript:down('<%=filename %>')"><%=filename %></a>
						&nbsp;&nbsp;<font color="blue">(<%=filesize %>KBytes)</font>
						<%}else{%>
							등록된 파일이 없습니다.<%}%>
						</td>
					</tr>
					<tr>
						<td colspan="4"><br/><pre><%=content %></pre><br/></td>
					</tr>
					<tr>
						<td colspan="4" align="right">
						<%=ip %>로 부터 글을 남기셨습니다./ 조회수 <%=count %>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td align="center" colspan="2">
			<hr/>
			[<a href="javascript:list()">리스트</a> |
			<a href="update.jsp?nowPage=<%=nowPage%>&num=<%=num%>" >수  정</a> |
			<a href="reply.jsp?nowPage=<%=nowPage%>" >답  변</a> |
			<a href="delete.jsp?nowPage=<%=nowPage%>&num=<%=num%>">삭  제</a> ]<br/>
			</td>
		</tr>	
	</table>
	
	<form name="downFrm" action="download.jsp" method="post">
		<input type="hidden" name="filename">
	</form>
	
	<form name="listFrm" method="post" action="list.jsp">
		<input type="hidden" name="nowPage" value="<%=nowPage %>">
		<%if(!(keyWord==null || keyWord.equals(""))){ %>   <!--키워드가 존재한다면 keyField와 keyWord 함께 넘겨줘 -->
		<input type="hidden" name="keyField" value="<%=keyField %>">
		<input type="hidden" name="keyWord" value="<%=keyWord %>">
		<%} %>
	</form>
	</body>
</html>