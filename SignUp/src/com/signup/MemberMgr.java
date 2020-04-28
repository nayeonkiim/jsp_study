package com.signup;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class MemberMgr {
	
	private DBConnectionMgr pool = null;
	public MemberMgr() {
		try {
			pool= DBConnectionMgr.getInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public boolean IdCheck(String id) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag=false;
		
		try {
			conn = pool.getConnection();
			sql = "SELECT id FROM tblmember where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			flag = rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(conn,pstmt,rs);
		}
		return flag;
	}
	
	public boolean InsertMember(MemberBean bean) {
	
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		int i = 0;
		
		try {
			conn = pool.getConnection();
			sql = "INSERT INTO tblmember VALUES (?,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,bean.getId());
			pstmt.setString(2,bean.getPwd());
			pstmt.setString(3,bean.getName());
			pstmt.setString(4,bean.getGender());
			pstmt.setString(5,bean.getBirth());
			pstmt.setString(6,bean.getEmail());
			pstmt.setString(7,bean.getAddr());
			
			String[] hobby = bean.getHobby();
			char[] hb = {'0','0','0','0'};
			String[] lists = {"코딩","운동","악기연주","독서"};
			for(int k=0;k<hobby.length;k++) {
				for(int j=0;j<lists.length;j++){
					if(hobby[k].equals(lists[j])) {
						hb[j] = '1';
					}
				}
			}
 			pstmt.setString(8, new String(hb));
			pstmt.setString(9,bean.getJob());
			i = pstmt.executeUpdate();
			if(i == 1) {
				flag = true;
			}else
				flag = false;
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(conn,pstmt);
		}
		return flag;
	}
	
	public boolean IdPwCorrect(String id, String pwd) {
		
		Connection conn= null;
		PreparedStatement pstmt= null;
		String sql = null;
		ResultSet rs = null;
		boolean flag = false;
		
		try {
			conn = pool.getConnection();
			sql = "SELECT id FROM tblmember WHERE id=? and pwd=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			rs = pstmt.executeQuery();
			flag = rs.next();
	
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(conn,pstmt,rs);
		}
		return flag;
	}

}
