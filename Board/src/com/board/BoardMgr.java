                          package com.board;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class BoardMgr {
	
	private DBConnectionMgr pool;
	private static final String SAVEFOLDER ="C:/Users/rlask/git/jsp_study/Board/WebContent/fiilestorage";
	private static final String ENCTYPE = "utf-8";
	private static final int MAXSIZE = 5*1024*1024;
	
//	생성자에서 DBConnectionMgr의 객체 선언
	public BoardMgr() {  
		try {
			pool = DBConnectionMgr.getInstance();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//게시판 리스트 - 매개변수로 keyField(이름,제목,내용 중 하나),keyWord(input 창) 
	public Vector<BoardBean> getBoardList(String keyField, String keyWord, int start, int end){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<BoardBean> vlist = new Vector<BoardBean>();
		
		try {
			con = pool.getConnection();
			if(keyWord.equals("")) { //input 창에 들어온게 없으면
				sql = "SELECT * FROM tblboard ORDER BY ref desc limit ?, ?";   //ref는 insertBoard에서 처리
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
			}else{  //keyWord가 존재하면
				sql = "SELECT * FROM tblboard where "+ keyField + " like ? ";
				sql+="order by ref desc, pos limit ? , ?";   //ref와 pos를 내림차순으로  start+1부터 end개 까지
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, '%'+keyWord+'%'); //keyword가 들어간 게시글 찾기
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BoardBean bean = new BoardBean();
				bean.setNum(rs.getInt("num"));
				bean.setName(rs.getString("name"));
				bean.setSubject(rs.getString("subject"));
				bean.setContent(rs.getString("content"));
				bean.setPos(rs.getInt("pos"));
				bean.setDepth(rs.getInt("depth"));
				bean.setRef(rs.getInt("ref"));
				bean.setRegdate(rs.getString("regdate"));
				bean.setPass(rs.getString("pass"));
				bean.setIp(rs.getString("ip"));
				bean.setCount(rs.getInt("count"));
				bean.setFilename(rs.getString("filename"));
				bean.setFilesize(rs.getInt("filesize"));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con,pstmt,rs);
		}
		return vlist;
	}
	
	//keyField, keyWord가 있는경우 해당하는 총 레코드 수, 없을 경우 전체 레코드 수 리턴
	public int getTotalCount(String keyField, String keyWord) {
		Connection con=null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			con = pool.getConnection();
			if(keyWord.equals("")) {     //keyWord가 없는 경우 
				sql = "SELECT count(num) FROM tblboard";   //sql의 레코드 갯수 반환 - count
				pstmt = con.prepareStatement(sql);
			}else {                      //keyWord가 존재하는 경우
				sql = "SELECT count(num) FROM tblboard WHERE "+ keyField +" LIKE ?";      //sql의 레코드 갯수 반환 - count, keyField가 keyWord일 경우의 갯수
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, '%'+keyWord+'%');  //keyWord가 포함된 것 찾아
			}
			rs = pstmt.executeQuery();
			if(rs.next()) {
				totalCount = rs.getInt(1);  //count를 가져와라
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con,pstmt,rs);
		}
		return totalCount;
	}
	
	//게시글 삽입
	public void insertBoard(HttpServletRequest req) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;
		String sql = null;
		MultipartRequest multi = null;
		int filesize = 0;
		String filename = null;
		try {
			con = pool.getConnection();
			sql = "SELECT max(num) FROM tblboard";   //제일 큰 num을 찾아, 게시글 삽입이므로 제일큰 num보다 하나 더 크게 ref을 부여
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			int ref = 1;
			if(rs.next()) {
				ref = rs.getInt(1)+1;  //제일 큰 num값 가져와라, +1해서 ref에 할당
			}
			
			File file = new File(SAVEFOLDER);
			if(!file.exists())   //파일이 존재하지 않으면
				file.mkdir();    //SAVEFOLDER라는 새로운 디렉토리를 생성
			multi = new MultipartRequest(req, SAVEFOLDER, MAXSIZE, ENCTYPE,        
					new DefaultFileRenamePolicy());
			
			if(multi.getFilesystemName("filename") != null) {
				// 파일의 이름 받아올때
				filename = multi.getFilesystemName("filename");
				filesize = (int)multi.getFile("filename").length();
			}
			
			String content = multi.getParameter("content");
			// 글 저장시 html 태그 적용 안되고 text형태로 저장하고 싶은 경우
			if(multi.getParameter("contentType").equalsIgnoreCase("TEXT")) {
				content = UtilMgr.replace(content, "<", "&lt;");
			}
			
			sql = "INSERT INTO tblBoard (name,content,subject,ref,pos,depth,regdate,pass,count,ip,filename,filesize,id)";
			sql += "VALUES(?,?,?,?,0,0,now(),?,0,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, multi.getParameter("name"));
			pstmt.setString(2, content);
			pstmt.setString(3, multi.getParameter("subject"));
			pstmt.setInt(4, ref);
			pstmt.setString(5, multi.getParameter("pass"));
			pstmt.setString(6, multi.getParameter("ip"));
			pstmt.setString(7, filename);
			pstmt.setInt(8, filesize);
			result = pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con,pstmt,rs);
		}
		
	}
	
	//조회수 증가
	public void upCount(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "UPDATE tblboard SET count=count+1 WHERE num=?";   //read.jsp페이지로 넘어가면서 조회수가 1 증가
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//num에 해당하는 게시물 리턴 - read.jsp에서/ bean에 저장후 read.jsp에서 불러와서 출력함.
	public BoardBean getBoard(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null; 
		BoardBean bean = new BoardBean();  //sql문의 결과를 저장하기 위해
		try {
			con = pool.getConnection();
			sql = "SELECT * FROM tblboard WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			//게시물은 하나 임으로 Vector는 필요 없음
			if(rs.next()) {
				bean.setNum(rs.getInt("num"));
				bean.setName(rs.getString("name"));
				bean.setSubject(rs.getString("subject"));
				bean.setContent(rs.getString("content"));
				bean.setPos(rs.getInt("pos"));
				bean.setRef(rs.getInt("ref"));
				bean.setDepth(rs.getInt("depth"));
				bean.setRegdate(rs.getString("regdate"));
				bean.setPass(rs.getString("pass"));
				bean.setCount(rs.getInt("count"));
				bean.setFilename(rs.getString("filename"));
				bean.setFilesize(rs.getInt("filesize"));
				bean.setIp(rs.getString("ip"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con,pstmt,rs);
		}
		return bean;
	}
	
	//다운로드 
	public void downLoad(HttpServletRequest req, HttpServletResponse res, 
			JspWriter out, PageContext pageContext) {
		try {
			String filename = req.getParameter("filename");
			// File.separator는 플랫폼이 윈도우일 경우 '\', 유닉스일 경우 '/' 경로 구분자 삽입하는 메소드			
			File file = new File(UtilMgr.con(SAVEFOLDER + File.separator + filename));
			// 응답 객체 res 헤더 필드 Accept-Ranges에 bytes 단위로 설정
			byte b[] = new byte[(int) file.length()];
			//요청 객체인 req에서 클라이언트의 User-Agent 정보를 리턴 받는다.
			res.setHeader("Accept-Ranges", "bytes");
			//브라우저의 버전과 정보를 구분해서 각각 res 헤더필드와 contentType을 설정함.
			String strClient = req.getHeader("User-Agent");
			if(strClient.indexOf("MSIE6.0") != -1) {
				res.setContentType("application/smnet;charset=euc-kr");
				res.setHeader("Content-Disposition", "filename=" + filename + ";");
			}else {
				res.setContentType("application/smnet;charset=euc-kr");
				res.setHeader("Content-Disposition", "attachment;filename=" + filename + ";");
			}
			out.clear();
			out = pageContext.pushBody();
			if(file.isFile()) {
				BufferedInputStream fin = new BufferedInputStream(
						new FileInputStream(file));
				BufferedOutputStream outs = new BufferedOutputStream(
						res.getOutputStream());
				int read = 0;
				while((read = fin.read(b)) != -1) {
					outs.write(b,0,read);
				}
				outs.close();
				fin.close();
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void deleteBoard(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		try {
			//1. 파일부터 파일저장소에서 지워주기
			con = pool.getConnection();
			sql = "SELECT filename FROM tblboard WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next() && rs.getString(1) != null) {
				if(!rs.getString(1).equals("")) {
					File file = new File(SAVEFOLDER+"/"+rs.getString(1));
					if(file.exists()) {
						UtilMgr.delete(SAVEFOLDER+"/"+rs.getString(1));
					}
				}
			}
			//2. mysql에서 해당 레코드 지워주기
			sql = "DELETE FROM tblboard WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con,pstmt,rs);
		}
	}
	
	public void updateBoard(BoardBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "UPDATE tblboard SET name=?, subject=?, content=? WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getName());
			pstmt.setString(2, bean.getSubject());
			pstmt.setString(3, bean.getContent());
			pstmt.setInt(4, bean.getNum());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con,pstmt);
		}
	}
	
	//답변에 위치값 증가 - ref는 동일하고 pos만 값이 0이 아니면 답변
	public void replyUpBoard(int ref, int pos) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "UPDATE tblboard SET pos= pos+1 WHERE ref=? and pos > ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, ref);
			pstmt.setInt(2, pos);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con,pstmt);
		}	
	}
	
	//게시물 답변
	public void replyBoard(BoardBean bean) {
		Connection con= null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql="INSERT tblboard (name,content,subject,ref,pos,depth,regdate,pass,count,ip)";
			sql+= "VALUES(?,?,?,?,?,?,now(),?,0,?)";
			int depth = bean.getDepth() + 1;
			int pos = bean.getPos()+1;
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getName());
			pstmt.setString(2, bean.getContent());
			pstmt.setString(3, bean.getSubject());
			pstmt.setInt(4, bean.getRef());
			pstmt.setInt(5, pos);
			pstmt.setInt(6, depth);
			pstmt.setString(7, bean.getPass());
			pstmt.setString(8, bean.getIp());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con,pstmt);
		}
	}
	
}
