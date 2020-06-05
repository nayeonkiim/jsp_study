package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BoardDao {
	Connection con;
	ResultSet rs;
	
	public BoardDao() {
		String url ="jdbc:mysql://localhost:3306/mydb?serverTimezone=UTC";
		String id ="root";
		String password = "1234";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection(url,id,password);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//현재 시간
	public String getDate() {
		PreparedStatement pstmt;
		String sql = "select now()";
		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	public int maxNum() {
		int num = 0;
		PreparedStatement pstmt;
		String sql = "select max(num) from board";
		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			num = rs.getInt(1);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return num+1;
	}
	
	//해당 게시물 db에 삽입
	public int insertBoard(Board board) {
		int result = 0;
		PreparedStatement pstmt;
		String sql = "insert into board (num,title,userID,date,content,available) value (?,?,?,?,?,?)";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, board.getNum());
			pstmt.setString(2, board.getTitle());
			pstmt.setString(3, board.getUserID());
			pstmt.setString(4, getDate());
			pstmt.setString(5, board.getContent());
			pstmt.setInt(6, board.getAvailable());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	//게시물 정보 전부 담아서 리턴
	public List<Board> listToBoard(int pageNumber) {
		List bList = new ArrayList();
		PreparedStatement pstmt;
		String sql = "select * from board where num < ? and available=1 order by num asc limit 10";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, maxNum() - (pageNumber-1)*10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Board board = new Board();
				board.setNum(rs.getInt("num"));
				board.setTitle(rs.getString("title"));
				board.setUserID(rs.getString("userID"));
				board.setDate(rs.getString("date"));
				board.setContent(rs.getString("content"));
				board.setAvailable(rs.getInt("available"));
				bList.add(board);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return bList;
	}
		
	//게시글 읽기
	public Board listOneBoard (int num) {
		PreparedStatement pstmt;
		Board board = new Board();
		String sql = "select * from board where num = ?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				board.setNum(rs.getInt("num"));
				board.setTitle(rs.getString("title"));
				board.setUserID(rs.getString("userID"));
				board.setDate(rs.getString("date"));
				board.setContent(rs.getString("content"));
				board.setAvailable(rs.getInt("available"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return board;
	}
	
	//수정한 내용 반영
	public int editArticle(String title, String content, int num) {
		int result = 0;
		PreparedStatement pstmt;
		String sql = "update board set title=?, content=? where num=?";
		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, content);
			pstmt.setInt(3, num);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
}
