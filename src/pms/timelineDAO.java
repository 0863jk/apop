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

public class timelineDAO {
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
	/* 
	 * 0 : 프로젝트 생성
	 * 1 : 프로젝트 삭제 ?
	 * 2 : 프로젝트 참가
	 * 3 : 프로젝트 탈퇴 ?
	 * 4 : 업무 생성
	 * 5 : 업무 삭제 ?
	 * 6 : 업무 승인
	 * 7 : 보고 등록
	*/
	
	public boolean addHistoryCreateProject(String id, String pid) {
		boolean result = false;
		connect();
		
		LocalDate localdate = LocalDate.now();
		Date ldate = java.sql.Date.valueOf(localdate);
		
		String sql = "insert into history(type, id, pid, date) values('CreateProject','"+id+"','"+pid+"','"+ldate+"')";
		try {
			stmt.executeUpdate(sql);
			System.out.println("프로젝트 생성 기록");
			result = true;
		} catch (SQLException e) {
			System.out.println("프로젝트 생성  기록 실패");
			e.printStackTrace();
		}
		disconnect();
		return result;
	}
	
	
	public boolean addHistoryEnterProject(String id, String pid) {
		boolean result = false;
		connect();
		
		LocalDate localdate = LocalDate.now();
		Date ldate = java.sql.Date.valueOf(localdate);
		
		String sql = "insert into history(type, id, pid, date) values('EnterProject','"+id+"','"+pid+"','"+ldate+"')";
		try {
			stmt.executeUpdate(sql);
			System.out.println("프로젝트 참가 로그 기록");
			result = true;
		} catch (SQLException e) {
			System.out.println("프로젝트 참가 기록 실패");
			e.printStackTrace();
		}
		disconnect();
		return result;
	}
	
	public boolean addHistoryAddTask(String id, String pid, String tid) {
		boolean result = false;
		connect();
		
		LocalDate localdate = LocalDate.now();
		Date ldate = java.sql.Date.valueOf(localdate);
		
		String sql = "insert into history(type, id, pid, tid, date) values('AddTask','"+id+"','"+pid+"','"+tid+"','"+ldate+"')";
		try {
			stmt.executeUpdate(sql);
			System.out.println("태스크 추가 기록완료");
			result = true;
		} catch (SQLException e) {
			System.out.println("태스크 추가  기록 실패");
			e.printStackTrace();
		}
		disconnect();
		return result;
	}
	
	public boolean addHistoryApproveTask(String id, String pid, String tid) {
		boolean result = false;
		connect();

		LocalDate localdate = LocalDate.now();
		Date ldate = java.sql.Date.valueOf(localdate);
		
		String sql = "insert into history(type, id, pid, tid, date) values('ApproveTask','"+id+"','"+pid+"','"+tid+"','"+ldate+"')";
		try {
			stmt.executeUpdate(sql);
			System.out.println("태스크 승인 기록완료");
			result = true;
		} catch (SQLException e) {
			System.out.println("태스크 승인 기록 실패");
			e.printStackTrace();
		}
		disconnect();
		return result;
	}
	
	public boolean addHistoryAddTaskDetail(String id, String pid, String tid) {
		boolean result = false;
		connect();

		LocalDate localdate = LocalDate.now();
		Date ldate = java.sql.Date.valueOf(localdate);
		
		String sql = "insert into history(type, id, pid, tid, date) values('AddTaskDetail','"+id+"','"+pid+"','"+tid+"','"+ldate+"')";
		try {
			stmt.executeUpdate(sql);
			System.out.println("태스크 승인 기록완료");
			result = true;
		} catch (SQLException e) {
			System.out.println("태스크 승인 기록 실패");
			e.printStackTrace();
		}
		disconnect();
		return result;
	}
	
	public ArrayList<timelineVO> getTimelineList(String pid){
		ArrayList<timelineVO> tlList = new ArrayList<timelineVO>();
		connect();
		String sql = "select * from history where pid ='"+pid+"' order by date desc";
		try {
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()) {
				timelineVO tlVO = new timelineVO();
				tlVO.setHistoryId(rs.getString("historyId"));
				tlVO.setType(rs.getString("type"));
				tlVO.setUserId(rs.getString("id"));
				tlVO.setProjectId(rs.getString("pid"));
				tlVO.setTaskId(rs.getString("tid"));
				tlVO.setDate(rs.getString("date"));
				
				tlList.add(tlVO);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		disconnect();
		return tlList;
	}
	
	public ArrayList<timelineVO> getTimelineList(String pid, String from, String to){
		ArrayList<timelineVO> tlList = new ArrayList<timelineVO>();
		connect();
		String sql = "select * from history where pid ='"+pid+"' and date between '"+from+"' and '"+to+"';";
		try {
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()) {
				timelineVO tlVO = new timelineVO();
				tlVO.setHistoryId(rs.getString("historyId"));
				tlVO.setType(rs.getString("type"));
				tlVO.setUserId(rs.getString("id"));
				tlVO.setProjectId(rs.getString("pid"));
				tlVO.setTaskId(rs.getString("tid"));
				tlVO.setDate(rs.getString("date"));
				
				tlList.add(tlVO);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		disconnect();
		return tlList;
	}
	
}