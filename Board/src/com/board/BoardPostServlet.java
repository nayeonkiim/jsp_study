package com.board;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// 게시물 쓰기 처리 서블릿
@WebServlet("/boardPost")
public class BoardPostServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BoardMgr bmgr = new BoardMgr();
		bmgr.insertBoard(request);
		response.sendRedirect("list.jsp");
	}
}
