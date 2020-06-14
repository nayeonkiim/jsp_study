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
	private Connection con;
	private PreparedStatement pstmt;
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
		try {
			con = dataSource.getConnection();
			if(keyWord == null) {
				String sql = "select * from t_board order by ref desc limit ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
			}else {
				String sql = "select * from t_board where "+keyField+" like ? order by ref desc limit ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, '%'+keyWord+'%');
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
			}
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				BoardVO vo =new BoardVO();
				vo.setNum(rs.getInt("num"));
				vo.setId(rs.getString("id"));
				vo.setName(rs.getString("name"));
				vo.setSubject(rs.getString("subject"));
				vo.setContent(rs.getString("content"));
				vo.setPos(rs.getInt("pos"));
				vo.setDepth(rs.getInt("depth"));
				vo.setRef(rs.getInt("ref"));
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
		try {
			con = dataSource.getConnection();
			if(keyWord == "") {
				String sql = "select count(*) from t_board";
				pstmt = con.prepareStatement(sql);
			}else {
				String sql = "select count(*) from t_board where "+keyField+" like ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, '%'+keyWord+'%');
			}	
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}

	public void insertBoard(HttpServletRequest request) {
		ResultSet rs = null;
		int result = 0;
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
			result = pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		
	}
}
