package sec02.ex02;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDao {
	private DataSource dataFactory;
	private Connection con;
	private PreparedStatement pstmt;
	
	public MemberDao(){
		try {
			Context ctx = new InitialContext();
			Context envContext = (Context)ctx.lookup("java:/comp/env");
			dataFactory = (DataSource)envContext.lookup("jdbc/mysql");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	public List<MemberVO> listMember() {
		List<MemberVO> mlist = new ArrayList<MemberVO>();
		String sql = "select * from t_member order by id desc";
		try {
			con = dataFactory.getConnection();
			pstmt = con.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				String id = rs.getString("id");
				String pwd = rs.getString("pwd");
				String name = rs.getString("name");
				String email = rs.getString("email");
				Date joinDate = rs.getDate("joinDate");
				MemberVO vo = new MemberVO(id,pwd,name,email,joinDate);
				mlist.add(vo);
			}
			rs.close();
			pstmt.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mlist;
	}
	
	public void addMember(MemberVO vo) {
		try {
			con = dataFactory.getConnection();
			String id = vo.getId();
			String pwd = vo.getPwd();
			String name = vo.getName();
			String email = vo.getEmail();
			String sql = "insert into t_member (id,pwd,name,email) value (?,?,?,?)"; 
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			pstmt.setString(3, name);
			pstmt.setString(4, email);
			pstmt.executeUpdate();
			pstmt.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 아이디 회원정보 조회
	public MemberVO findMember(String id) {
		MemberVO memvo = null;
		String sql = "select * from t_member where id=?";
		try {
			con = dataFactory.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				String pwd = rs.getString("pwd");
				String name = rs.getString("name");
				String email = rs.getString("email");
				Date joinDate = rs.getDate("joinDate");
				memvo = new MemberVO(id,pwd,name,email,joinDate);
				pstmt.close();
				rs.close();
				con.close();
			}
			else {
				return null;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return memvo;
	}
	
	// 회원 수정을 db에 반영
	public void modMember(MemberVO vo) {
		
		String sql = "update t_member set pwd=?, name=?, email=? where id=?";
		try {
			con = dataFactory.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, vo.getPwd());
			pstmt.setString(2, vo.getName());
			pstmt.setString(3, vo.getEmail());
			pstmt.setString(4, vo.getId());
			pstmt.executeUpdate();
			pstmt.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//해당 아이디 존재하는지 확인
	public boolean checkID(String id) {
		boolean result = false;
		String sql = "select if(count(*)=1,'true','false') as result from t_member where id=?";
		try {
			con = dataFactory.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			result = Boolean.parseBoolean(rs.getString("result"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	/*
	 * // 회원 수정을 db에 반영 public boolean delMember(String id, String pwd) {
	 * 
	 * }
	 */
}	



