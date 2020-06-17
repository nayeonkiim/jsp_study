<!--게시판 메인 화면( 페이징,   -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.board.BoardBean" %>
<%@page import="java.util.Vector" %>
<jsp:useBean id="bMgr" class="com.board.BoardMgr" />
<%
	request.setCharacterEncoding("utf-8");

	int totalRecord=0; //전체 레코드 수
	int numPerPage = 10;  //페이지 당 레코드 수
	int pagePerBlock = 15;  //블럭 당 페이지 수
	
	int totalPage = 0; //전체 페이지 수
	int totalBlock =0;  //전페 블럭 수
	
	int nowPage = 1; //현재 페이지
	int nowBlock = 1;  //현재 블럭
	
	int start=0; //tblBoard 테이블의 select 시작 번호
	int end=10; //시작번호로 부터 가져올 select 개수 
	
	int listSize = 0; //현재 읽어온 게시물의 수
	
	String keyWord = "", keyField = "";
	Vector<BoardBean> vlist = null;
	if(request.getParameter("keyWord") != null){
		keyWord = request.getParameter("keyWord");
		keyField = request.getParameter("keyField");
	}
	if(request.getParameter("reload") != null){
		if(request.getParameter("reload").equals("true")){
			keyWord="";
			keyField="";
		}
	}
	if(request.getParameter("nowPage") != null){
		nowPage = Integer.parseInt(request.getParameter("nowPage"));  
	}
	start = (nowPage * numPerPage)-numPerPage;
	end = numPerPage; 
	 
	totalRecord = bMgr.getTotalCount(keyField, keyWord);
	totalPage = (int)Math.ceil((double)totalRecord/numPerPage);
	nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock);
	totalBlock = (int)Math.ceil((double)totalPage/pagePerBlock);
%>

<html>
	<head>
		<meta charset="UTF-8">
		<title>insert title here</title>
		<script type="text/javascript">
			function read(num){
				document.readFrm.num.value=num;
				document.readFrm.action="read.jsp";
				document.readFrm.submit();
			}
			function block(num){
				document.readFrm.nowPage.value=<%=pagePerBlock%>*(num-1)+1;
				document.readFrm.submit();
			}
			function paging(page){
				document.readFrm.nowPage.value=page;
				document.readFrm.submit();
			}
			function check(){
				if(document.searchFrm.keyWord.value == ""){
					alert("검색어를 입력하세요.");
					document.searchFrm.keyWord.focus();
					return;
				}
				document.searchFrm.submit();
				
			}
			function list()
			{
				document.listFrm.action="list.jsp";
				document.listFrm.submit();
			}		
			
		</script>
	</head>
	<body>
		<div align="center">
		<h2>JSPBoard</h2>
		<table align="center" border="0" >
			<tr>
				<td>Total : <%=totalRecord %>Articles
				(<%=nowPage %>/<%=totalPage %>Pages)</td>
		</table>
		<table align="center" border="0">
			<tr>
				<td align="center" colspan="2">
				<% 	
					vlist = bMgr.getBoardList(keyField, keyWord, start, end);
					listSize = vlist.size(); /* 브라우저 화면에 나타날 게시물 개수  */
					if(vlist.isEmpty()){
						out.println("등록된 게시물이 없습니다.");
					}else{ 
				%>
			<table border="0">
				<tr align="center"> 
					<td>번   호</td>
					<td>제   목</td>
					<td>이   름</td>
					<td>날   짜</td>
					<td>조회수</td>
				</tr>
			<%
			//블럭 하나하나를 누를때마다 이 for문이 실행되어 만약 22개의 게시물이 있어서 블럭 3을 눌럿다면
			// listSize는 2가 된다.
				for(int i=0;i<numPerPage; i++){
					if(i == listSize) break;
					
					BoardBean bean = vlist.get(i);
					int num = bean.getNum();
					String name = bean.getName();
					String subject = bean.getSubject();
					String regdate = bean.getRegdate();
					int depth = bean.getDepth();   //답변
					int count = bean.getCount();   //조회수
			%>
				<tr>
					<td align="center">
						<%=totalRecord-((nowPage-1)*numPerPage)-i %> <!--게시번호  -->
					</td>
					<td>
					<%
						if(depth>0){  //답변이 하나라도 있으면
							for(int j=0;j<depth;j++){
								out.println("&nbsp;&nbsp");  //들여쓰기
							}
						}
					%>
					<!--제목의 링크를 read.jsp로 걸어줌 -->
					<a href="javascript:read('<%=num%>')"><%=subject %></a>
					</td>
					<td align="center"><%=name %></td>
					<td align="center"><%=regdate %></td>
					<td align="center"><%=count %></td>
				</tr>
					<%} //for%>
			</table><%
			} //if
			%>
				</td>
			</tr>
			<tr>
				<td colspan="2"><br/><br/></td>			
			</tr>
			
			<!-- 페이징 및 블럭 처리 Start -->	
			<tr>
				<td>
				<%
					int pageStart = (nowBlock-1)*pagePerBlock + 1;
					int pageEnd = ((pageStart + pagePerBlock) < totalPage) ? (pageStart + pagePerBlock) : totalPage+1;
					
					if(totalPage != 0){
						if(nowBlock > 1) {%>
							<a href="javascript:block('<%=nowBlock-1 %>')">prev...</a><%} %>&nbsp;
					<%-- 		<a href="javascript:read('<%=num%>')"><%=subject %></a> --%>
					<% for( ;pageStart < pageEnd; pageStart++){ %>
							<a href="javascript:paging('<%=pageStart %>')">
							<% if(pageStart == nowPage) { %> 
								<font color="blue"> <%} %>
								[<%=pageStart %>] 
								<%if(pageStart==nowPage) {%>
									</font><%} %>
							</a>
					<%} %>&nbsp;
										
							<%if (totalPage >= pageEnd) {%>
								<a href="javascript:block('<%=nowBlock+1%>')">.....next</a>
							<%} %>&nbsp;
				<%} %>
					</td>
					<td align="right">
						<a href="post.jsp">[글쓰기]</a>
						<a href="javascript:list()">[처음으로]</a>
					</td>
				</tr>					
		</table>
		<hr>
			<form name="searchFrm" method="post" action="list.jsp">
				<table border="0" align="center">
					<tr>
						<td align="center">
							<select name="keyField">
								<option value="name">이  름</option>
								<option value="subject">제  목</option>
								<option value="content">내  용</option>
							</select>
							<input name="keyWord">
							<input type="button" value="찾기" onClick="javascript:check()">
							<input type="hidden" name="nowPage" value="1">
						</td>
					</tr>
				</table>
			</form>
			<!-- 처음으로 눌렀을 때 list.jsp로 listFrm 폼이 보내져  -->
			<form name="listFrm" method="post">
				<input type="hidden" name="reload" value="true">
				<input type="hidden" name="nowPage" value="1">
			</form>
			<form name="readFrm">
				<input type="hidden" name="num">
				<input type="hidden" name="nowPage" value="<%=nowPage%>">
				<input type="hidden" name="keyField" value="<%=keyField%>">
				<input type="hidden" name="keyWord" value="<%=keyWord%>">
			</form>
		</div>
	</body>
</html>