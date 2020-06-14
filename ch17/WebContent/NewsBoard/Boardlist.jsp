<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" import="java.util.*, sec02.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
   
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<%
	List<BoardVO> boardList = (List<BoardVO>)request.getAttribute("boardList");
	int vlist = boardList.size();
	
	int totalRecord = 0;
	int numPerPage = 10;
	int pagePerBlock = 15;
	
	int totalPage = 0;
	int totalBlock = 0;
	
	int nowPage = 1;
	int nowBlock =1;
	
	int start = 0;
	int end = 10;
	
	/*[1][2] 여기 누를때마다 들어옹는 값 받는 코드 써주기*/
	
	start = (nowPage * numPerPage) - numPerPage;
	end = numPerPage;
	
	totalRecord = (Integer)request.getAttribute("boardCount");
	totalPage = (int)Math.ceil((double)totalRecord/numPerPage);
	totalBlock = (int)Math.ceil((double)totalPage/pagePerBlock);
	nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock);
	
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>news</title>
		<link rel="stylesheet" href="${contextPath }/css/mainStyle.css">
		<link rel="stylesheet" href="${contextPath }/css_B/boardStyle.css">
		<script type="text/javascript">
			function idCheck(){
				alert("로그인 먼저 해주세요!");
				location.href="${contextPath}/members/loginForm.jsp";
			}
		</script>
	</head>
	<body>
		<header class="inner header">
			<div class="hdDesign">
				<div class="uDesign">
					<h2><a href="${contextPath }/main.jsp">YeonCom</a></h2>
					<div class="input">
						<input type="text" name="inputFrm" class="inputFrm">
					</div>
					<div class="btngrp">
					<% if(session.getAttribute("id") == null){%>
						<a href="${contextPath }/member/loginForm.do" class="login">로그인</a>
						<a href="${contextPath }/member/memberForm.do" class="join">회원가입</a>
					<%}else{ %>
						<a href="${contextPath }/member/loginOut.do" class="login">로그아웃</a>
						<%if(session.getAttribute("id").equals("master")) {%>
							<a href="${contextPath }/member/listMembers.do?" class="join">관리자 페이지</a>
						<%}else {%>
							<a href="${contextPath }/member/myPage.do?id=<%=session.getAttribute("id") %>" class="join">마이 페이지</a>
						<%}
					}%>
					</div>
				</div>
			</div>
		</header>
		<section class="inner secNews1">
			<div class="newsStyle">
				<h2>News Board</h2>
				<table>
					<tr>
						<td>Total :<%=totalRecord %> Articles
							(<%=nowPage %>/<%=totalPage %>Pages)</td>
						
					</tr>
				</table>
				<table>
					<tr>
						<td>
						<table>
							<tr>
								<td class="b1">번  호</td>
								<td class="b1">제  목</td>
								<td class="b1">아이디</td>
								<td class="b1">날  짜</td>
								<td class="b1">조회수</td>
							</tr>
							<c:choose>
								<c:when test="${empty boardList}">
									<tr>
										<td colspan=5>
											<b>등록된 게시물이 없습니다.</b>
										</td>
									</tr>
								</c:when>
								<c:when test="${!empty boardList }">
									<%
										for(int i=0; i<numPerPage; i++){
											if(i == vlist) break;
										
									%>
										<c:forEach var="board" items="${boardList }">
											<tr>
												<td><%=totalRecord-((nowPage-1)*numPerPage)-i %></td>
												<td>
													<c:if test="${board.depth} > 0" >
														<c:forEach var="i" begin="0" end="${board.depth }" step="1">
															&nbsp;&nbsp;
														</c:forEach>
													</c:if>
													<a href="${contextPath }/board/ReadBoard.do">${board.subject }</a>
												</td>
												<td>${board.id }</td>
												<td>${board.regdate }</td>
												<td>${board.count }</td>
											</tr>
										</c:forEach>
									<%} %>
								</c:when>			
							</c:choose>
						</table>
					</td>
				</tr>
				<tr>
					<td colspan="2"><br/><br/></td>
				</tr>
				<tr>
					<td>
					<%
						int startPage = (nowPage-1)*pagePerBlock + 1;
						int endPage = (startPage + pagePerBlock) > totalPage ? startPage + pagePerBlock : totalPage+1;
						
						if(totalPage > 0){
							if(nowBlock > 1){%>
								<a href="javascript:block('<%=nowBlock - 1%>')">prev...</a> 
							<%} %>&nbsp;
				
							<%for(;startPage < endPage; startPage++) {%>
								<a href="paging('<%=startPage %>')">
									<%if(startPage == nowPage){ %>
										<font color="blue"> <%} %>
											[<%=startPage %>]
									<%if(startPage == nowPage){  %>
										</font> 
									<%} %>
								</a>
								<%} %>&nbsp;
								
							<%if (totalPage >= endPage) {%>
								<a href="block('<%=nowBlock+1 %>')">
									...next  </a>
							<%} %>&nbsp;
						<%} %>
					</td>
					<td>
						<%if(session.getAttribute("id") == null) {%>
							<a href="javascript:idCheck();">[글쓰기]</a>
						<%}else{ %>
							<a href="${contextPath }/board/boardWrite.do?id=<%=session.getAttribute("id")%>">[글쓰기]</a>
						<%} %>
						<a href="${contextPath }/board/Newslist.do">[처음으로]</a>
					</td>
				</tr>
			</table>
			
			
		</div>	
	</section>
		
		
	</body>
</html>