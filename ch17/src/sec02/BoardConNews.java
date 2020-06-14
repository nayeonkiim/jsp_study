package sec02;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(name="BoardConNews", urlPatterns = { "/board/*" })
public class BoardConNews extends HttpServlet {
	BoardDao dao;
	
	public void init() throws ServletException{
		dao = new BoardDao();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request,response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request,response);
	}
	
	protected void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String nextPage = null;
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		String action = request.getPathInfo();
		System.out.println("action:" + action);
		
		// 게시판 목록 출력
		if(action.equals("/Newslist.do")) {
			String keyField = request.getParameter("keyField");
			String keyWord = request.getParameter("keyWord");
			int start = Integer.parseInt(request.getParameter("start"));
			/* int end = Integer.parseInt(request.getParameter("end")); */
			List<BoardVO> boardList = dao.selectBoardList(keyField,keyWord,start,10);
			request.setAttribute("boardList", boardList);
			int boardCount = dao.totalCount(keyField, keyWord);
			request.setAttribute("boardCount", boardCount);
			nextPage = "/NewsBoard/Boardlist.jsp";
		}else if(action.equals("/ReadBoard.do")) {
			
		}else if(action.equals("/boardWrite.do")){
			nextPage = "/NewsBoard/BoardWrite.jsp";
		}else if(action.equals("/DoWrite.do")){
			dao.insertBoard(request);
			nextPage = "/board/Newslist.do?start=0";
		}else {
			nextPage = "/main.jsp";
		}
		
		RequestDispatcher dispatch = request.getRequestDispatcher(nextPage);
		dispatch.forward(request, response);
	}
}
