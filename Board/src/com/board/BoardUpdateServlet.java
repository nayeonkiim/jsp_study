package com.board;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/boardUpdate")
public class BoardUpdateServlet extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8"); //넘어온 값에 대한
		response.setContentType("text/html; charset=UTF-8");  //넘어갈 값에 대한
		
		HttpSession session = request.getSession();   //session을 가져와
		PrintWriter out = response.getWriter();  //쓸수 있는 객체생성
		
		BoardMgr bMgr = new BoardMgr();    
		BoardBean bean = (BoardBean)session.getAttribute("bean");  //bean으로 바인딩 된 객체 리턴
		String nowPage = request.getParameter("nowPage");
		
		//update.jsp에서 수정된 내용을 받아옴
		BoardBean upBean = new BoardBean();
		upBean.setNum(Integer.parseInt(request.getParameter("num")));
		upBean.setName(request.getParameter("name"));
		upBean.setSubject(request.getParameter("subject"));
		upBean.setContent(request.getParameter("content"));
		upBean.setPass(request.getParameter("pass"));
		upBean.setIp(request.getParameter("ip"));
		
		String upPass = upBean.getPass();
		String inPass = bean.getPass();
		
		if(upPass.equals(inPass)) {
			bMgr.updateBoard(upBean);  //수정 완료
			String url = "read.jsp?nowPage="+nowPage+"&num="+upBean.getNum();
			response.sendRedirect(url);
		}else {
			out.println("<script>");
			out.println("alert('입력하신 비밀번호가 아닙니다.');");
			out.println("history.back();");
			out.println("</script>");
		}
	}
}
