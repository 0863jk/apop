package pms;

import java.io.Console;
import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.*;
import java.util.Date;

import org.apache.naming.java.javaURLContextFactory;

import sun.security.jca.GetInstance.Instance;

public class CommentDAO {
	private Connection conn = null;
	private Statement stmt = null;

	// DB연결 (MySQL)
	private void connect() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost/pms", "root", "1234");
			stmt = conn.createStatement();
		} catch (Exception e) {
			System.out.println("DB연결 실패");
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

	
	public boolean addComment(String taskDetailId, String commentContent, String userId) {
		boolean result = false;
		
		LocalDate localdate = LocalDate.now();
		Date ldate = java.sql.Date.valueOf(localdate);
		
		connect();
		String sql = "insert into comment(taskDetailId, commentContent, commentDate, userId) values('"+taskDetailId+"','"+commentContent+"','"+ldate+"','"+userId+"')";
		try {
			stmt.execute(sql);
			System.out.println("코멘트 생성 완료");
			result = true;
		} catch (SQLException e) {
			e.printStackTrace();
			result = false;
		}
		disconnect();
		return result;
	}
	
	public ArrayList<CommentVO> getCommentList(String taskDetailId){
		ArrayList<CommentVO> cmVOlist = new ArrayList<CommentVO>();
		connect();
		String sql = "select * from comment where taskDetailId='"+taskDetailId+"'";
		try {
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()) {
				CommentVO cmVO = new CommentVO();
				cmVO.setCommentId(rs.getString("commentId"));
				cmVO.setTaskDetailId(rs.getString("taskDetailId"));
				cmVO.setCommentContent(rs.getString("commentContent"));
				cmVO.setCommentDate(rs.getString("commentDate"));
				cmVO.setUserId(rs.getString("userId"));
				cmVOlist.add(cmVO);
			}
			System.out.println("코멘트 불러오기 성공");
		} catch (SQLException e) {
			System.out.println("코멘트 불러오기 실패");
			e.printStackTrace();
		}
		disconnect();
		return cmVOlist;
	}
	
	public boolean deleteComment(String commentId) {
		boolean result = false;
		connect();
		String sql = "delete from comment where commentId = '"+commentId+"'";
		try {
			stmt.executeUpdate(sql);
			result = true;
		} catch (SQLException e) {
			System.out.println("코멘트 삭제 실패");
			result = false;
			e.printStackTrace();
		}
		return result;
	}
}
