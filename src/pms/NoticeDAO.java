package pms;
import java.util.*;
import java.util.Date;

import java.sql.*;

public class NoticeDAO {
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
	public boolean insert(String title, String content, String user, String pid) {
		boolean result = false;
		Date tempDate = new Date();
		int tempYear = tempDate.getYear() + 1900;
		int tempMonth = tempDate.getMonth() + 1;
		String date = tempYear + "-" + tempMonth + "-" + tempDate.getDate();
		String testUser = "test";
		
		connect();
		try {
			String sql = "insert into notice (noticename, noticecontent, noticedate, userid, projectid) values ('"+title+"', '"+content+"', '"+date+"', '"+testUser+"', "+pid+")";
			stmt.executeUpdate(sql);
			result = true;
		} catch (Exception e) {
			e.printStackTrace();
			result = false;
		}
		
		disconnect();
		return result;
	}
	
	public int getTotalRows(String pid) {
		int cnt = 0;
		connect();
		try {
			ResultSet rs = stmt.executeQuery("select count(noticeid) from notice where projectid =" + pid);
			
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
	
	public List select(String pid, int page) {
		// pid = 프로젝트 아이디, page = 페이지 넘버
		int startIndex = 0 + (page - 1) * 10;
		
		List noticeList = new ArrayList();
		connect();
		try {
			//start index부터 10개의 글 가져오기
			String sql = "select * from notice where projectid="+pid+" order by noticeid desc limit " + startIndex + ", 10";
			ResultSet rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				NoticeVO vo = new NoticeVO();
				
				int nid = rs.getInt("noticeid");
				String title = rs.getString("noticename");
				String content = rs.getString("noticecontent");
				String date = rs.getString("noticedate");
				String user = rs.getString("userid");
				
				vo.setNid(nid);
				vo.setTitle(title);
				vo.setContent(content);
				vo.setDate(date);
				vo.setUser(user);
				noticeList.add(vo);
			}
			rs.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		disconnect();
		return noticeList;
	}
	
	public List selectView(String pid, String noticeid) {
		// pid = 프로젝트 아이디, noticeid = 공지사항 id
		
		List noticeList = new ArrayList();
		connect();
		try {
			//start index부터 10개의 글 가져오기
			ResultSet rs = stmt.executeQuery("select * from notice where projectid="+pid+" and noticeid="+noticeid);
			
			while(rs.next()) {
				NoticeVO vo = new NoticeVO();
				
				int nid = rs.getInt("noticeid");
				String title = rs.getString("noticename");
				String content = rs.getString("noticecontent");
				String date = rs.getString("noticedate");
				String user = rs.getString("userid");
				
				vo.setNid(nid);
				vo.setTitle(title);
				vo.setContent(content);
				vo.setDate(date);
				vo.setUser(user);
				noticeList.add(vo);
			}
			rs.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		disconnect();
		return noticeList;
	}
	
	public List selectAll(int pid, int page) {
		List noticeList = new ArrayList();
		connect();
		try {
			ResultSet rs = stmt.executeQuery("select * from notice where projectid="+pid+" order by noticeid");
			
			while(rs.next()) {
				NoticeVO vo = new NoticeVO();
				
				int nid = rs.getInt("noticeid");
				String title = rs.getString("noticename");
				String content = rs.getString("noticecontent");
				String date = rs.getString("noticedate");
				String user = rs.getString("userid");
				
				vo.setNid(nid);
				vo.setTitle(title);
				vo.setContent(content);
				vo.setDate(date);
				vo.setUser(user);
				noticeList.add(vo);
			}
			rs.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		disconnect();
		return noticeList;
	}
	
	public ArrayList<String> noticeNameList(String pid){
		ArrayList<String> nName = new ArrayList<String>();
		connect();
		try {
			ResultSet rs = stmt.executeQuery("select noticename from notice where projectid='"+pid+"'");
			while(rs.next()) {
				nName.add(rs.getString("noticename"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		disconnect();
		return nName;
	}
}
