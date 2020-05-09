package com.board;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class BoardMgr {
	
	private DBConnectionMgr pool;
	private static final String SAVEFOLDER ="C:/Users/rlask/eclipse-workspace/Board/WebContent/fiilestorage";
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
				sql = "SELECT * FROM tblboard ORDER BY ref desc, pos limit ?, ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
			}else{  //keyWord가 존재하면
				sql = "SELECT * FROM tblboard where"+ keyField + "like ?";
				sql+="order by ref desc, pos limit ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord + "%"); //keyword가 들어간 게시글 찾기
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
	
	public int getTotalCount(String keyField, String keyWord) {
		Connection con=null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			con = pool.getConnection();
			if(keyWord.equals("")) {
				sql = "SELECT count(num) FROM tblboard";
				pstmt = con.prepareStatement(sql);
			}else {
				sql = "SELECT count(num) FROM tblboard WHERE "+keyField+" LIKE ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+keyWord+"%");
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
			sql = "SELECT max(num) FROM tblboard";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			int ref = 1;
			if(rs.next()) {
				ref = rs.getInt(1)+1;  
			}
			
			File file = new File(SAVEFOLDER);
			if(!file.exists())   //파일이 존재하지 않으면
				file.mkdir();    //SAVEFOLDER라는 새로운 디렉토리를 생성
			multi = new MultipartRequest(req, SAVEFOLDER, MAXSIZE, ENCTYPE,        
					new DefaultFileRenamePolicy());
			
			if(multi.getFilesystemName("filename") != null) {
				filename = multi.getFilesystemName("filename");
				filesize = (int)multi.getFile("filename").length();
			}
			
			String content = multi.getParameter("content");
			if(multi.getParameter("contentType").equalsIgnoreCase("TEXT")) {
				content = UtilMgr.replace(content, "<", "&lt;");
			}
			
			sql = "INSERT INTO tblBoard (name,content,subject,ref,pos,depth,regdate,pass,count,ip,filename,filesize)";
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


}
