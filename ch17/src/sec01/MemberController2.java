package sec01;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "MemberController2", urlPatterns = { "/member/*" })
// getPathInfo() 메서드를 이용해 두 단계로 이루어진 요청을 가져옴. action 값에 따라 if문을 분기해서 요청한 작업을 수행
public class MemberController2 extends HttpServlet {
	
	
	MemberDao memberDao;
	
	public void init() throws ServletException{
		memberDao = new MemberDao();
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}
	
	protected void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String nextPage = null;
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		HttpSession session;
		String action = request.getPathInfo();
		System.out.println("action:" + action);
	
		//listMembers.do 들어오면 listMembers.jsp로 이동
		if (action == null || action.equals("/listMembers.do")) {
			List<MemberVO> memberList = memberDao.listMember();
			request.setAttribute("memberList", memberList);
			nextPage = "/members/listMembers.jsp";
		// addMember.do 들어오면 member 더하기 해주고 listMembers.jsp로 이동
		} else if (action.equals("/addMember.do")) {
			String id = request.getParameter("id");
			String pwd = request.getParameter("pwd");
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			MemberVO memberVO = new MemberVO(id, pwd, name, email);
			memberDao.addMember(memberVO);
			request.setAttribute("msg", "addMember");
			nextPage = "/main.jsp";
		// 회원가입 누르면 회원가입 폼으로 이동
		} else if (action.equals("/memberForm.do")) {
			nextPage = "/members/memberForm.jsp";
		//마이페이지 버튼 클릭시	
	    }else if(action.equals("/myPage.do")) {
	    	nextPage = "/members/myPage.jsp";
	    //비밀번호 입력해서 해당 비밀번호면 	그 아이디에 해당하는 정보들 가져옴
		}else if(action.equals("/modMemberForm.do")){
		     String id=request.getParameter("id");
		     String pwd = request.getParameter("pwd");
			if(memberDao.equalMember(id,pwd)) {
		    	 MemberVO memInfo = memberDao.findMember(id);
		    	 request.setAttribute("memInfo", memInfo);
			     nextPage="/members/modMemberForm.jsp";
			}else {
				 request.setAttribute("msg", "matchFail");
			     nextPage="/members/myPage.jsp";
			}
		//관리자의 경우 수정
		}else if(action.equals("/directMod.do")) {
			String id = request.getParameter("id");
			MemberVO memInfo = memberDao.findMember(id);
	    	request.setAttribute("memInfo", memInfo);
		    nextPage="/members/modMemberForm.jsp";
		//수정된 것들 db에 저장
		}else if(action.equals("/modMember.do")){
		     String id=request.getParameter("id");
		     String pwd=request.getParameter("pwd");
		     String name= request.getParameter("name");
	         String email= request.getParameter("email");
		     MemberVO memberVO = new MemberVO(id, pwd, name, email);
		     memberDao.modMember(memberVO);
		     request.setAttribute("msg", "modified");
		     nextPage = "/main.jsp";
		     
		 }else if(action.equals("/delMember.do")) {
			 String id = request.getParameter("id");
		 	 memberDao.delMember(id);
			 request.setAttribute("msg", "deleted");
			 nextPage="/member/listMembers.do";
		//로그인 버튼 누르면 로그인 창으로 이동
	    }else if(action.equals("/loginForm.do")){
	    	nextPage = "/members/loginForm.jsp";
	    // 로그인 위해 sql에서 아이디 비번 비교 실행
	    }else if(action.equals("/loginMember.do")) {
	    	String id = request.getParameter("id");
	    	String pwd = request.getParameter("pwd");
	    	boolean result = memberDao.equalMember(id,pwd);
	    	if(result == true) {
	    		request.setAttribute("msg", "logSuccess");
	    		session = request.getSession();
	    		session.setAttribute("id", id);
	    		nextPage = "/main.jsp";
	    	}else {
	    		request.setAttribute("msg", "logFail");
	    		nextPage = "/member/loginForm.do";
	    	}
	    	
	    }else if(action.equals("/loginOut.do")) {
	    	session = request.getSession(false);
	    	session.invalidate();
	    	request.setAttribute("msg", "logOut");
	    	nextPage = "/main.jsp";
	    	
		}else {
			nextPage = "/main.jsp";
		}
		
		RequestDispatcher dispatch = request.getRequestDispatcher(nextPage);
		dispatch.forward(request, response);
	}
}
