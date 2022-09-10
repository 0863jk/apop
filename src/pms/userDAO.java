package pms;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class userDAO {
	private Connection conn = null;
	private Statement stmt = null;

	
	public void connect() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost/pms", "root", "1234");
			stmt = conn.createStatement();
		} catch (Exception e) {
			System.out.println("DB 연결 완료");
			e.printStackTrace();
		}
	}
	
	private void disconnect() {
		if (stmt != null) {
			try {
				stmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public List viewProfile(String userID) {
		List list = new ArrayList();
		connect();
		
		String sql = "select * from user where id = '" + userID + "'";
		System.out.println(sql);
		try {
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()) {
				userVO vo = new userVO();
				
				vo.setName(rs.getString("name"));
				vo.setPassword(rs.getString("password"));
				vo.setPhone(rs.getString("phone"));
				vo.setEmail(rs.getString("email"));
				vo.setJob(rs.getString("job"));
				vo.setBelong(rs.getString("belong"));
				
				list.add(vo);
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		disconnect();
		
		return list;
	}
	
	public boolean updateUser(String id, String pw, String name, String phone, String email, String job, String belong) {
		connect();
		
		String sql;
		if(pw.equals("") || pw.equals("null")) {
			sql = "update user set name='"+name+"', phone='"+phone+"', email='"+email+"', job='"+job+"', belong='"+belong+"' where id='"+id+"'";
		} else {
			sql = "update user set name='"+name+"', password ='"+pw+"', phone='"+phone+"', email='"+email+"', job='"+job+"', belong='"+belong+"' where id='"+id+"'";
		}
		System.out.println(sql);
		try {
			stmt.executeUpdate(sql);
			disconnect();
			
			return true;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			disconnect();
			
			return false;
		}
	}
	
	public userVO searchUser(String user) {
		userVO uVO = new userVO();
		connect();
		String sql = "select id, name, phone, email, job, belong from user where id = '"+user+"'";
		try {
			ResultSet rs = stmt.executeQuery(sql);
			if(rs.next()) {
				uVO.setId(rs.getString("id"));
				uVO.setName(rs.getString("name"));
				uVO.setPhone(rs.getString("phone"));
				uVO.setEmail(rs.getString("email"));
				uVO.setJob(rs.getString("job"));
				uVO.setBelong(rs.getString("belong"));
			}
		} catch (SQLException e) {
			System.out.println("유저 정보 조회 실패");
			e.printStackTrace();
		}
		disconnect();
		return uVO;
	}
	
	public List searchUser(String where, String value) {
		List list = new ArrayList();
		connect();
		String sql = "select id, name, phone, email, job, belong from user where "+where+" = '"+value+"'";
		System.out.println(sql);
		try {
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()) {
				userVO uVO = new userVO();
				
				uVO.setId(rs.getString("id"));
				uVO.setName(rs.getString("name"));
				uVO.setPhone(rs.getString("phone"));
				uVO.setEmail(rs.getString("email"));
				uVO.setJob(rs.getString("job"));
				uVO.setBelong(rs.getString("belong"));
				
				list.add(uVO);
			}
		} catch (SQLException e) {
			System.out.println("유저 정보 조회 실패");
			e.printStackTrace();
		}
		disconnect();
		return list;
	}
	
	public List getAllUser() {
		List list = new ArrayList();
		connect();
		
		String sql = "select * from user";
		System.out.println(sql);
		try {
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()) {
				userVO vo = new userVO();
				
				vo.setId(rs.getString("id"));
				vo.setName(rs.getString("name"));
				vo.setPassword(rs.getString("password"));
				vo.setPhone(rs.getString("phone"));
				vo.setEmail(rs.getString("email"));
				vo.setJob(rs.getString("job"));
				vo.setBelong(rs.getString("belong"));
				
				list.add(vo);
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		disconnect();
		
		return list;
	}

}
