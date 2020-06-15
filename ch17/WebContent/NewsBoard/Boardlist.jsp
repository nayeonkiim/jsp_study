<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" import="java.util.*, sec02.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<%
	request.setCharacterEncoding("utf-8");

	List<BoardVO> boardList = null;
	int vlist = 0;
	
	int totalRecord = 0;
	int numPerPage = 10;
	int pagePerBlock = 15;
	
	int totalPage = 0;
	int totalBlock = 0;
	
	int nowPage=1;
	int nowBlock=1;
	
	int start = 0;
	int end = 10;
	
	/*[1][2] 여기 누를때마다 들어옹는 값 받는 코드 써주기*/
	
	String keyWord="", keyField="";
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
	
	start = (nowPage * numPerPage) - numPerPage;
	end = numPerPage;
	
	totalRecord = (int)request.getAttribute("boardCount");
	totalPage = (int)Math.ceil((double)totalRecord/numPerPage);
	totalBlock = (int)Math.ceil((double)totalPage/pagePerBlock);
	nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock);
%>

<c:set var="totalRecord" value="<%=totalRecord %>"/>
<c:set var="nowPage" value="<%=nowPage %>"/>
<c:set var="numPerPage" value="<%=numPerPage %>"/>
			

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
			function paging(page){
				document.readFrm.nowPage.value = page;
				document.readFrm.submit();
			}
			function check(){
				frm = document.searchFrm;
				if(frm.keyWord.value == ""){
					alert("키워드를 입력해주세요.");
				}
				frm.submit();
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
						<td>Total :${totalRecord } Articles
							(${nowPage }/<%=totalPage %> Pages)</td>
						
					</tr>
				</table>
				<table>
					<tr>
						<td>
						<table >
							<tr align="center">
								<td class="b1"><div style="margin-left:10px">번  호</div></td>
								<td class="b1"><div style="margin-left:10px">제  목</div></td>
								<td class="b1"><div style="margin-left:10px">아이디</div></td>
								<td class="b1"><div style="margin-left:10px">등록날짜</div></td>
								<td class="b1"><div style="margin-left:10px">조회수</div></td>
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
										boardList = (List<BoardVO>)request.getAttribute("boardList");
										vlist = boardList.size();
									%>
									<c:forEach var="board" items="${boardList}" varStatus="i">
										<c:if test="${ i.index} == <%=vlist %>">
											break;
										</c:if>
										<tr align="center">
											<td> ${totalRecord - ((nowPage-1)*numPerPage) - i.index }</td>
											<td>
												<div style="margin-left:5px">
												<c:if test="${board.depth }> 0" >
													<c:forEach var="i" begin="0" end="${board.depth }" step="1">
														&nbsp;&nbsp;
													</c:forEach>
												</c:if>
													<a href="${contextPath }/board/ReadBoard.do?num=${board.num}">${board.subject }</a>
												</div>
											</td>
											<td><div style="margin-left:5px">${board.id }</div></td>
											<td><div style="margin-left:5px">${board.regdate }</div></td>
											<td><div style="margin-left:5px">${board.count }</div></td>
										</tr>
									</c:forEach>
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
						int startPage = (nowBlock-1)*pagePerBlock + 1;
						int endPage = (startPage + pagePerBlock) < totalPage ? startPage + pagePerBlock : totalPage+1;
						
						if(totalPage > 0){
							if(nowBlock > 1){ %>
								<a href="javascript:block('<%=nowBlock - 1%>')">prev...</a> 
							<%} %>&nbsp;
				
							<%for(;startPage < endPage; startPage++) {%>
								<a href="javascript:paging('<%=startPage %>')">
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
			<form name="searchFrm" method="post" action="${contextPath}/board/Newslist.do">
				<table align="center">
					<tr>
						<td align="center">
							<select name="keyField">
								<option value="id">아이디</option>
								<option value="subject">제  목</option>
								<option value="content">내  용 </option>
							</select>
							<input name="keyWord">
							<input type="button" value="찾기" onClick="javascript:check()">
							
						</td>
					</tr>
				</table>
			</form>
			<form name="readFrm">
				<input type="hidden" name="nowPage" value="<%=nowPage %>">
				<input type="hidden" name="keyField" value="<%=keyField %>">
				<input type="hidden" name="keyWord" value="<%=keyWord%>">
			</form>
		</div>	
	</section>
		
		
	</body>
</html>