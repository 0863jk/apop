package pms;

import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Date;

public class memberDAO {
	private Connection conn = null;
	private Statement stmt = null;

	// DB연결 (MySQL)
	private void connect() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost/pms", "root", "1234");
			stmt = conn.createStatement();
		} catch (Exception e) {
			System.out.println("�����ͺ��̽� ���� ����");
			e.printStackTrace();
		}
	}

	// DB 연결해제 
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

	// 등록된 사용자인지 확인
	public boolean isUser(String id) {
		boolean result = false;
		connect();
		String sql = "select id from user where id ='" + id + "'";
		try {
			ResultSet rs = stmt.executeQuery(sql);
			if (rs.next()) {
				result = true;
			} else {
				result = false;
			}
		} catch (SQLException e) {
			result = false;
			e.printStackTrace();
		}
		disconnect();
		return result;
	}

	// 프로젝트 멤버 조회
	public ArrayList<memberVO> getMembers(String projectId) {
		ArrayList<memberVO> list = new ArrayList<memberVO>();
		connect();
		String sql = "select userId, role from projectMember where projectId = " + projectId + "";
		try {
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				memberVO mVO = new memberVO();
				mVO.setUserId(rs.getString("userId"));
				mVO.setRole(rs.getString("role"));

				list.add(mVO);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;

	}
}
