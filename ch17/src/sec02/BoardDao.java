package sec02;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class BoardDao {
	private DataSource dataSource;
	private String SAVEFOLDER ="C:/Users/rlask/git/jsp_study/ch17/WebContent/fileStore";
	private String ENCTYPE = "utf-8";
	private int MAXSIZE = 5*1024*1024;
	
	public BoardDao() {
		try {
			Context context = new InitialContext();
			dataSource = (DataSource)context.lookup("java:comp/env/jdbc/mysql");
		} catch (Exception e) {
			System.out.println(e);
		}
	}
	
	public List<BoardVO> selectBoardList(String keyField, String keyWord, int start, int end){
		List<BoardVO> blist = new ArrayList<BoardVO>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		try {
			con = dataSource.getConnection();
			if(keyWord == null || keyWord.equals("")) {
				String sql = "select * from t_board order by ref desc limit ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
			}else {
				String sql = "select * from t_board where "+keyField+" like ? order by ref desc, pos limit ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, '%'+keyWord+'%');
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BoardVO vo = new BoardVO();
				vo.setNum(rs.getInt("num"));
				vo.setId(rs.getString("id"));
				vo.setName(rs.getString("name"));
				vo.setSubject(rs.getString("subject"));
				vo.setContent(rs.getString("content"));
				vo.setPos(rs.getInt("pos"));
				vo.setDepth(rs.getInt("depth"));
				vo.setRef(rs.getInt("ref"));
				vo.setRegdate(rs.getDate("regdate"));
				vo.setPass(rs.getString("pass"));
				vo.setCount(rs.getInt("count"));
				vo.setFilename(rs.getString("filename"));
				vo.setFilesize(rs.getInt("filesize"));
				blist.add(vo);
			}
			rs.close();
			pstmt.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return blist;
	}
	
	//총 게시글 수 리턴
	public int totalCount(String keyField, String keyWord) {
		int count = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		try {
			con = dataSource.getConnection();
			if(keyWord == null || keyWord.equals("")) {
				String sql = "select count(num) from t_board";
				pstmt = con.prepareStatement(sql);
			}else {
				String sql = "select count(num) from t_board where " + keyField + " like ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, '%'+keyWord+'%');
			}	
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
			rs.close();
			pstmt.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}

	public void insertBoard(HttpServletRequest request) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MultipartRequest multi = null;
		int filesize = 0;
		String filename = null;
		try {
			con = dataSource.getConnection();
			String sql = "select max(num) from t_board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			int ref=1;
			if(rs.next()) {
				ref = rs.getInt(1)+1;
			}
			
			File file = new File(SAVEFOLDER);
			if(!file.exists()) {
				file.mkdir();
			}
			multi = new MultipartRequest(request, SAVEFOLDER, MAXSIZE, ENCTYPE,
					new DefaultFileRenamePolicy());
			
			if(multi.getFilesystemName("filename") != null) {
				filename = multi.getFilesystemName("filename");
				filesize = (int)multi.getFilesystemName("filename").length();
			}
			String content = multi.getParameter("content");
			if(multi.getParameter("contentType").equalsIgnoreCase("TEXT")) {
				content = UtilMgr.replace(content, "<", "&lt;");
			}
			
			sql = "insert into t_board (name, content, subject,ref, pos,depth, regdate,pass,count, filename,filesize, id)";
			sql += "values (?,?,?,?,0,0,now(),?,0,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, multi.getParameter("name"));
			pstmt.setString(2, content);
			pstmt.setString(3, multi.getParameter("subject"));
			pstmt.setInt(4, ref);
			pstmt.setString(5, multi.getParameter("pass"));
			pstmt.setString(6, filename);
			pstmt.setInt(7, filesize);
			pstmt.setString(8, multi.getParameter("id"));
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		
	}
	
	//기존 글 읽어오기
	public BoardVO readDetails(int num) {
		BoardVO bVo = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = dataSource.getConnection();
			String sql = "select * from t_board where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bVo = new BoardVO();
				bVo.setNum(rs.getInt("num"));
				bVo.setId(rs.getString("id"));
				bVo.setName(rs.getString("name"));
				bVo.setSubject(rs.getString("subject"));
				bVo.setContent(rs.getString("content"));
				bVo.setPos(rs.getInt("pos"));
				bVo.setDepth(rs.getInt("depth"));
				bVo.setRef(rs.getInt("ref"));
				bVo.setRegdate(rs.getDate("regdate"));
				bVo.setPass(rs.getString("pass"));
				bVo.setCount(rs.getInt("count"));
				bVo.setFilename(rs.getString("filename"));
				bVo.setFilesize(rs.getInt("filesize"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return bVo;
	}
	public boolean equalMember(String id, String pwd) {
		Connection con = null;
		PreparedStatement pstmt = null;
		boolean result = false;
		String sql = "select if(count(*)=1, 'true','false') as result from t_member where id=? and pwd=?";
		try {
			con = dataSource.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			result = Boolean.parseBoolean(rs.getString("result"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
}
