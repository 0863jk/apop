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

public class taskDAO {
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

	public int addTask(String taskName, String taskContent, String worker, String projectId, int progress,
			String startDate, String deadline) {
		int result = -1;

		SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");
		Date jstartDate = null;
		Date jdeadLine = null;
		try {
			jstartDate = formatter.parse(startDate);
			jdeadLine = formatter.parse(deadline);
		} catch (ParseException e) {
			result = -1;
		}

		java.sql.Date sqlStartDate = new java.sql.Date(jstartDate.getTime());
		java.sql.Date sqldeadLine = new java.sql.Date(jdeadLine.getTime());

		connect();
		String sql = "insert into task(taskname, taskcontent, worker, projectId, progress, startDate, deadline)"
				+ "values('" + taskName + "','" + taskContent + "','" + worker + "','" + projectId + "','" + progress
				+ "','" + sqlStartDate + "','" + sqldeadLine + "')";
		try {
			stmt.executeUpdate(sql, Statement.RETURN_GENERATED_KEYS);
			ResultSet rs = stmt.getGeneratedKeys();
			if(rs.next()) {
				result = rs.getInt(1);
			}else {
				result = -1;
			}
		} catch (SQLException e) {
			result = -1;
			System.out.println("태스크 추가 오류");
			e.printStackTrace();
		}
		disconnect();
		return result;
	}

	public boolean updateTaskInfo(String taskId, String taskName, String taskContent, String worker, String startDate,
			String deadline) {
		boolean result = false;

		SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");
		Date jstartDate = null;
		Date jdeadLine = null;
		try {
			jstartDate = formatter.parse(startDate);
			jdeadLine = formatter.parse(deadline);
		} catch (ParseException e) {
			result = false;
		}

		java.sql.Date sqlStartDate = new java.sql.Date(jstartDate.getTime());
		java.sql.Date sqldeadLine = new java.sql.Date(jdeadLine.getTime());

		connect();
		String sql = "update task set taskName = '" + taskName + "', taskContent='" + taskContent + "', worker = '"
				+ worker + "', startdate ='" + sqlStartDate + "', deadline='" + sqldeadLine + "' where taskId = "
				+ taskId + "";
		try {
			stmt.executeUpdate(sql);
			result = true;
		} catch (SQLException e) {
			result = false;
			System.out.println("태스크 수정 오류");
			e.printStackTrace();
		}
		disconnect();
		return result;
	}

	public ArrayList<taskVO> getTaskList(String projectId) {
		ArrayList<taskVO> list = new ArrayList<taskVO>();
		connect();
		String sql = "select taskid, taskname, taskcontent, worker, progress, startDate, deadline, approve from task where projectId="
				+ projectId + " order by deadline";
		try {
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				taskVO tVO = new taskVO();
				tVO.setTaskId(rs.getString("taskid"));
				tVO.setTaskName(rs.getString("taskname"));
				tVO.setTaskContent(rs.getString("taskcontent"));
				tVO.setWorker(rs.getString("worker"));
				tVO.setProgress(Integer.parseInt(rs.getString("progress")));
				tVO.setStartDate(rs.getString("startDate"));
				tVO.setDeadline(rs.getString("deadline"));
				tVO.setApprove(rs.getInt("approve"));
				tVO.setColor(this.setColor(tVO));
				tVO.setColor(setColor(tVO));
				list.add(tVO);
			}
		} catch (SQLException e) {
			System.out.println("태스크 리스트 불러오기 실패");
			e.printStackTrace();
		}
		disconnect();
		return list;
	}
	
	public ArrayList<taskVO> getTaskList(String projectId, String userId) {
		ArrayList<taskVO> list = new ArrayList<taskVO>();
		connect();
		String sql = "select taskid, taskname, taskcontent, worker, progress, startDate, deadline, approve from task where projectId="
				+ projectId + " and worker = '" + userId + "' order by deadline";
		try {
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				taskVO tVO = new taskVO();
				tVO.setTaskId(rs.getString("taskid"));
				tVO.setTaskName(rs.getString("taskname"));
				tVO.setTaskContent(rs.getString("taskcontent"));
				tVO.setWorker(rs.getString("worker"));
				tVO.setProgress(Integer.parseInt(rs.getString("progress")));
				tVO.setStartDate(rs.getString("startDate"));
				tVO.setDeadline(rs.getString("deadline"));
				tVO.setApprove(rs.getInt("approve"));
				tVO.setColor(this.setColor(tVO));
				list.add(tVO);
			}
		} catch (SQLException e) {
			System.out.println("태스크 리스트 불러오기 실패");
			e.printStackTrace();
		}
		disconnect();
		return list;
	}

	public ArrayList<taskVO> getTaskList(String projectId, int page) {
		ArrayList<taskVO> list = new ArrayList<taskVO>();
		connect();
		int startIndex = 0 + (page - 1) * 10;
		String sql = "select taskid, taskname, taskcontent, worker, progress, startDate, deadline, approve from task where projectId="
				+ projectId + " order by deadline limit " + startIndex + ", 10";
		try {
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				taskVO tVO = new taskVO();
				tVO.setTaskId(rs.getString("taskid"));
				tVO.setTaskName(rs.getString("taskname"));
				tVO.setTaskContent(rs.getString("taskcontent"));
				tVO.setWorker(rs.getString("worker"));
				tVO.setProgress(Integer.parseInt(rs.getString("progress")));
				tVO.setStartDate(rs.getString("startDate"));
				tVO.setDeadline(rs.getString("deadline"));
				tVO.setApprove(rs.getInt("approve"));
				tVO.setColor(this.setColor(tVO));
				tVO.setColor(setColor(tVO));
				list.add(tVO);
			}
		} catch (SQLException e) {
			System.out.println("태스크 리스트 불러오기 실패");
			e.printStackTrace();
		}
		disconnect();
		return list;
	}

	public ArrayList<taskVO> getTaskList(String projectId, String userId, int page) {
		ArrayList<taskVO> list = new ArrayList<taskVO>();
		connect();
		int startIndex = 0 + (page - 1) * 10;
		String sql = "select taskid, taskname, taskcontent, worker, progress, startDate, deadline, approve from task where projectId="
				+ projectId + " and worker = '" + userId + "' order by deadline limit " + startIndex + ", 10";
		try {
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				taskVO tVO = new taskVO();
				tVO.setTaskId(rs.getString("taskid"));
				tVO.setTaskName(rs.getString("taskname"));
				tVO.setTaskContent(rs.getString("taskcontent"));
				tVO.setWorker(rs.getString("worker"));
				tVO.setProgress(Integer.parseInt(rs.getString("progress")));
				tVO.setStartDate(rs.getString("startDate"));
				tVO.setDeadline(rs.getString("deadline"));
				tVO.setApprove(rs.getInt("approve"));
				tVO.setColor(this.setColor(tVO));
				list.add(tVO);
			}
		} catch (SQLException e) {
			System.out.println("태스크 리스트 불러오기 실패");
			e.printStackTrace();
		}
		disconnect();
		return list;
	}
	
	public ArrayList<taskVO> searchTask(String projectId, String keyword, int page) {
		ArrayList<taskVO> list = new ArrayList<taskVO>();
		connect();
		int startIndex = 0 + (page - 1) * 10;
		String sql = "select taskid, taskname, taskcontent, worker, progress, startDate, deadline, approve from task where projectid = "+projectId+" and taskname like '%"+keyword+"%' order by deadline limit "+startIndex+", 10";
		System.out.println(sql);
		try {
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				taskVO tVO = new taskVO();
				tVO.setTaskId(rs.getString("taskid"));
				tVO.setTaskName(rs.getString("taskname"));
				tVO.setTaskContent(rs.getString("taskcontent"));
				tVO.setWorker(rs.getString("worker"));
				tVO.setProgress(Integer.parseInt(rs.getString("progress")));
				tVO.setStartDate(rs.getString("startDate"));
				tVO.setDeadline(rs.getString("deadline"));
				tVO.setApprove(rs.getInt("approve"));
				tVO.setColor(this.setColor(tVO));
				tVO.setColor(setColor(tVO));
				list.add(tVO);
			}
		} catch (SQLException e) {
			System.out.println("태스크 리스트 불러오기 실패");
			e.printStackTrace();
		}
		disconnect();
		return list;
	}
	
	public ArrayList<taskVO> searchTask(String projectId, String keyword, String userId, int page) {
		ArrayList<taskVO> list = new ArrayList<taskVO>();
		connect();
		int startIndex = 0 + (page - 1) * 10;
		String sql = "select taskid, taskname, taskcontent, worker, progress, startDate, deadline, approve from task where projectid = "+projectId+" and worker = '"+userId+"' and taskname like '%"+keyword+"%' order by deadline limit "+startIndex+", 10";
		System.out.println(sql);
		try {
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				taskVO tVO = new taskVO();
				tVO.setTaskId(rs.getString("taskid"));
				tVO.setTaskName(rs.getString("taskname"));
				tVO.setTaskContent(rs.getString("taskcontent"));
				tVO.setWorker(rs.getString("worker"));
				tVO.setProgress(Integer.parseInt(rs.getString("progress")));
				tVO.setStartDate(rs.getString("startDate"));
				tVO.setDeadline(rs.getString("deadline"));
				tVO.setApprove(rs.getInt("approve"));
				tVO.setColor(this.setColor(tVO));
				list.add(tVO);
			}
		} catch (SQLException e) {
			System.out.println("태스크 리스트 불러오기 실패");
			e.printStackTrace();
		}
		disconnect();
		return list;
	}

	public taskVO getTask(String taskId) {
		taskVO tVO = new taskVO();
		connect();
		String sql = "select * from task where taskId = " + taskId + "";
		try {
			ResultSet rs = stmt.executeQuery(sql);
			if (rs.next()) {
				System.out.println("태스크 있음");
				tVO.setTaskId(rs.getString("taskid"));
				tVO.setTaskName(rs.getString("taskname"));
				tVO.setTaskContent(rs.getString("taskcontent"));
				tVO.setWork(rs.getString("work"));
				tVO.setWorker(rs.getString("worker"));
				tVO.setProgress(Integer.parseInt(rs.getString("progress")));
				tVO.setStartDate(rs.getString("startDate"));
				tVO.setDeadline(rs.getString("deadline"));
				tVO.setApprove(rs.getInt("approve"));
				System.out.println(rs.getString("worker"));
				System.out.println("태스크 불러오기 성공");
			} else {
				System.out.println("태스크 없음");
			}
		} catch (SQLException e) {
			System.out.println("테스트 불러오기 실패");
			e.printStackTrace();
		}
		disconnect();
		return tVO;
	}

	public boolean updateTask(String taskId, String progress, String work) {
		boolean result = false;
		connect();
		String sql = "update task set progress = " + progress + ", work = '" + work + "' where taskid = '" + taskId
				+ "'";
		try {
			stmt.executeUpdate(sql);
			System.out.println("태스크 업데이트 성공");
			result = true;
		} catch (SQLException e) {
			System.out.println("태스크 업데이트 실패");
			result = false;
			e.printStackTrace();
		}
		disconnect();
		return result;
	}

	public boolean updateProgress(String taskId, String progress) {
		boolean result = false;
		connect();
		String sql = "update task set progress =" + progress + " where taskId = '" + taskId + "'";
		try {
			stmt.executeUpdate(sql);
			System.out.println("진척도 변경 완료");
			result = true;
		} catch (SQLException e) {
			System.out.println("진척도 변경 실패");
			e.printStackTrace();
		}
		return result;
	}

	public boolean updateApprove(String taskId, int value) {
		boolean result = false;
		connect();
		String sql = "update task set approve = " + value + " where taskId = '" + taskId + "'";
		try {
			stmt.executeUpdate(sql);
			System.out.println("업무승인 완료");
			result = true;
		} catch (SQLException e) {
			System.out.println("업무승인 실패");
			e.printStackTrace();
		}
		return result;
	}

	private String setColor(taskVO tVO) {
		String color = null;
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

		LocalDate localdate = LocalDate.now();
		Date ldate = java.sql.Date.valueOf(localdate);
		try {
			Date sdate = formatter.parse(tVO.getStartDate());
			Date ddate = formatter.parse(tVO.getDeadline());
			if (tVO.getApprove() == 1) {
				color = "blue";
			}else {
				if (ldate.before(sdate)) {
					color = "gray";
				} else if (ldate.after(ddate)) {
					color = "red";
				} else {
					Calendar cal = Calendar.getInstance();
					cal.setTime(ddate);
					cal.add(Calendar.DATE, -7);
					if (ldate.after(cal.getTime())) {
						color = "yellow";
					} else {
						color = "green";
					}
				}
			}
		} catch (ParseException e) {
			System.out.println("컬러 오류");
			e.printStackTrace();
		}
		return color;
	}

	public int colorCount(String projectId, String color) {
		int cnt = 0;
		ArrayList<taskVO> tVOlist = getTaskList(projectId);
		if (tVOlist == null) {
			cnt = -1;
		} else {
			for (int i = 0; i < tVOlist.size(); i++) {
				if (color.equals(tVOlist.get(i).getColor())) {
					cnt++;
				}
			}
		}
		return cnt;
	}
	
	public int getTotalRows(String pid) {
		int cnt = 0;
		connect();
		try {
			ResultSet rs = stmt.executeQuery("select count(taskid) from task where projectid =" + pid);
			
			int index = 0;
			if(rs.next()) {
				cnt = rs.getInt(++index);
			}
			rs.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		disconnect();
		return cnt;
	}
	
	public int getTotalRows(String pid, String userid) {
		int cnt = 0;
		connect();
		try {
			ResultSet rs = stmt.executeQuery("select count(taskid) from task where projectid =" + pid + " and worker = '"+userid+"'");
			
			int index = 0;
			if(rs.next()) {
				cnt = rs.getInt(++index);
			}
			rs.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		disconnect();
		return cnt;
	}
	
}
