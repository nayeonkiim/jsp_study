package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;



public class UserDao {
	
	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDao() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/mydb?serverTimezone=UTC";
			String dbID = "root";
			String dbPassword = "1234";
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//로그인을 시도
	public int login(String userID, String userPassword) {
		String sql = "select userPassword from user where userID =?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1;  //로그인 성공
				}
				else {
					return 0; //비밀번호 불일치
				}
			}
			return -1;  //아이디가 없음
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2;  //데이터 베이스 오류
	}
	
	//아이디 중복체크
	public boolean dupIdCheck(String userID) {
		Boolean result=false;
		String sql="select * from user as result where userID=?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			result = rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	//회원가입 정보 저장
	public int InsertMem(User user) {
		int result=0;
		String sql = "insert into user (userID, userPassword, userName, userGender, userEmail) value (?,?,?,?,?)";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
}
