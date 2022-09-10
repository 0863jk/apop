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

public class TaskDetailDAO {
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
	
	public ArrayList<TaskDetailVO> getTaskDetailList(String taskId){
		ArrayList<TaskDetailVO> tdVOlist = new ArrayList<TaskDetailVO>();
		connect();
		String sql = "select * from taskDetail where taskId = '"+taskId+"' order by taskDetailId desc";
		try {
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()) {
				TaskDetailVO tdVO = new TaskDetailVO();
				tdVO.setTaskDetailId(rs.getString("taskDetailId"));
				tdVO.setName(rs.getString("name"));
				tdVO.setContent(rs.getString("content"));
				tdVO.setDate(rs.getString("date"));
				tdVO.setTaskId(rs.getString("taskId"));
				tdVOlist.add(tdVO);
			}
		} catch (SQLException e) {
			System.out.println("보고목록 쿼리 오류");
			e.printStackTrace();
		}
		disconnect();
		return tdVOlist;
	}
	
	public TaskDetailVO getTaskDetail(String taskDetailId){
		TaskDetailVO tdVO = new TaskDetailVO();
		connect();
		String sql = "select * from taskDetail where taskDetailId = '"+taskDetailId+"'";
		try {
			ResultSet rs = stmt.executeQuery(sql);
			if(rs.next()) {
				tdVO.setTaskDetailId(rs.getString("taskDetailId"));
				tdVO.setName(rs.getString("name"));
				tdVO.setContent(rs.getString("content"));
				tdVO.setDate(rs.getString("date"));
				tdVO.setTaskId(rs.getString("taskId"));
			}
		} catch (SQLException e) {
			System.out.println("보고 쿼리 오류");
			e.printStackTrace();
		}
		disconnect();
		return tdVO;
	}
	
	public boolean addTaskDetail(String name, String content, String taskId) {
		boolean result = false;
		
		LocalDate localdate = LocalDate.now();
		Date ldate = java.sql.Date.valueOf(localdate);
		
		connect();
		String sql = "insert into taskDetail(name, content, date, taskid) values ('"+name+"', '"+content+"','"+ldate+"', "+taskId+")";
		try {
			stmt.executeUpdate(sql);
			System.out.println("보고 등록 완료");
			result = true;
		} catch (SQLException e) {
			System.out.println("보고 등록 실패");
			result = false;
			e.printStackTrace();
		}
		disconnect();
		return result;
	}
	
	public boolean updateTaskDetail(String taskDetailId, String name, String content) {
		boolean result = false;
		
		connect();
		String sql = "update taskDetail set name ='"+name+"', content = '"+content+"' where taskDetailId = "+taskDetailId+"";
		try {
			stmt.executeUpdate(sql);
			System.out.println("보고 수정 완료");
			result = true;
		} catch (SQLException e) {
			System.out.println("보고 수정실패");
			result = false;
			e.printStackTrace();
		}
		disconnect();
		return result;
	}
	
	public boolean deleteTaskDetail(String taskDetailId) {
		boolean result = false;
		connect();
		String sql = "delete from taskDeatail where taskDetailId = "+taskDetailId+"";
		try {
			stmt.executeUpdate(sql);
			System.out.println("보고 삭제 완료");
			result = true;
		} catch (SQLException e) {
			System.out.println("보고 수정실패");
			result = false;
			e.printStackTrace();
		}
		return result;
		
	}
}
