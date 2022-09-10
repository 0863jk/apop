package pms;

import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Date;

import com.mysql.fabric.Response;

public class projectDAO {
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

	// 로그인
	public boolean login(String id, String password) {
		boolean result = false;
		connect();
		String sql = "select id, password from user where id= '" + id + "' and password = '" + password + "'";

		try {
			ResultSet rs = stmt.executeQuery(sql);
			if (rs.next()) {
				result = true;
			} else {
				result = false;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		disconnect();
		return result;
	}

	// 회원가입
	public boolean resister(String id, String password, String name, String phone, String email, String occupation,
			String department) {
		boolean result = false;

		if (id.isEmpty() || password.isEmpty() || name.isEmpty()) {
			result = false;
		} else {
			try {
				if (isUser(id)) { // id�� �ߺ��Ǵ� ���
					result = false;
				} else {
					connect();
					String sql = "insert into user values('" + id + "','" + password + "','" + name + "','" + phone
							+ "','" + email + "','" + occupation + "','" + department + "')";
					stmt.executeUpdate(sql);
					result = true;
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		disconnect();
		return result;
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

	//?
	public ArrayList<String> getProjectId(String userId) {
		ArrayList<String> list = new ArrayList<String>();
		connect();
		String sql = "select projectid from project where userid ='" + userId + "'";

		try {
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				list.add("projectid");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		disconnect();
		return list;
	}

	// 프로젝트 생성
	public int createProject(String userId, String name, String classfication, String summary, String password, String startDate, String deadline) {
		boolean result = false;
		int iResult = 0;
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
			String sql = "insert into project(projectname, projectpw, projectSummary,classification, createDate, deadline, leader, progress) values('"
					+ name + "','" + password + "','" + summary + "','" + classfication + "','" + sqlStartDate + "','"
					+ sqldeadLine + "','" + userId + "', 0)";
			System.out.println(sql);
			try {
				stmt.executeUpdate(sql, Statement.RETURN_GENERATED_KEYS);
				ResultSet rs = stmt.getGeneratedKeys();
				
				if (rs.next()) {
					String pid = rs.getInt(1) + "";
					if (enterProject(userId, pid, password)) {
						result = true;
						iResult = Integer.parseInt(pid);
					} else {
						result = false;
						iResult = -1;
					}
				}
			} catch (SQLException e) {
				e.printStackTrace();
				result = false;
				iResult=-1;
			}
			disconnect();
			return iResult;
		}
		
		// 프로젝트 수정
	public boolean updateProject(String userId, String pid, String name, String classfication, String summary, String password, String startDate, String deadline) {
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
		String sql = "update project set projectname= '"+name+"', projectpw = '"+password+"', classification = '"+classfication+"', projectSummary='"+summary+"', createDate = '"+sqlStartDate+"', deadline ='"+sqldeadLine+"' where projectid = " + pid;
		System.out.println(sql);
			
		try {
			stmt.executeUpdate(sql);
			String check = "select * from project where projectname= '"+name+"' and projectpw = '"+password+"' and projectSummary='"+summary+"' and classification = '"+classfication+"' and createDate='"+sqlStartDate+"' and deadline = '"+sqldeadLine+"'";
			ResultSet rs = stmt.executeQuery(check);
				
			if (rs.next()) {
				result = true;
			} else {
				result = false;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			result = false;
		}
		disconnect();
		return result;
	}

	// 프로젝트가 존재하는지 확인
	public boolean isProject(String projectId) {
		boolean result = false;
		connect();
		String sql = "select projectId from project where projectId = '" + projectId + "'";
		ResultSet rs;
		try {
			rs = stmt.executeQuery(sql);
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

	// 프로젝트 참가
	public boolean enterProject(String userId, String pid, String password) {
		boolean result = false;
		if(!inProject(userId, pid)) {
			connect();
			String sql = "select projectPw from project where projectId = '" + pid + "'";
			try {
				ResultSet rs = stmt.executeQuery(sql);
				if (rs.next()) {
					if (rs.getString("projectPw").equals(password)) {
						sql = "insert into projectMember values('" + userId + "'," + pid + ",0)";
						stmt.executeUpdate(sql);
						result = true;
					} else {
						result = false; // �н����尡 Ʋ�� ���
					}
				} else {
					result = false; // ������Ʈ ID�� ���� ���
				}
			} catch (SQLException e1) {
				result = false; // SQL����
				e1.printStackTrace();
			}			
		}else {
			result = false; //������ ������Ʈ�� �̹� ������ ���
		}

		disconnect();
		return result;
	}

	// 유저가 프로젝트에 참여했는지 확인
	public boolean inProject(String id, String projectId) {
		boolean result = false;
		connect();
		String sql = "select userId from projectMember where userId ='" + id + "' and projectId ='" + projectId + "'";
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

	// 프로젝트 목록조회
	public ArrayList<projectListVO> projectList(String userId) {
		ArrayList<projectListVO> list = new ArrayList<projectListVO>();
		connect();
		String sql = "select p.projectId, projectName, projectSummary, leader from project p, projectmember pm where p.projectId = pm.projectId and pm.userid = '"
				+ userId + "'";
		try {
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				projectListVO plVO = new projectListVO();

				plVO.setProjectId(rs.getString("projectId"));

				plVO.setProjectName(rs.getString("projectName"));

				plVO.setProjectSummary(rs.getString("projectSummary"));
				
				plVO.setProjectLeader(rs.getString("leader"));

				list.add(plVO);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		disconnect();
		return list;
	}
	
	// 프로젝트 목록조회, 검색
	public List searchProject(String keyword, String classification) {
		List list = new ArrayList();
		connect();
		String sql = "";
		
		if(classification.equals("") || classification.equals("null")) {
			sql = "select * from project where projectName like '%"+keyword+"%'";
		} else {
			sql = "select * from project where classification = '"+classification+"' and projectName like '%"+keyword+"%'";
		}
		System.out.println(sql);
		
		try {
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				projectListVO plVO = new projectListVO();

				plVO.setProjectId(rs.getString("projectId"));

				plVO.setProjectName(rs.getString("projectName"));
				
				plVO.setProjectLeader(rs.getString("leader"));

				plVO.setProjectSummary(rs.getString("projectSummary"));

				list.add(plVO);
			}
			
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		disconnect();
		return list;
	}

	// 프로젝트 조회
	public projectVO getProject(String projectId) {
		projectVO pVO = new projectVO();
		connect();
		String sql = "select * from project where projectId = " + projectId + "";
		try {
			ResultSet rs = stmt.executeQuery(sql);
			if (rs.next()) {
				pVO.setName(rs.getString("projectName"));
				pVO.setPw(rs.getString("projectPw"));
				pVO.setSummary(rs.getString("projectSummary"));
				pVO.setCreatDate(rs.getString("createDate"));
				pVO.setDeadline(rs.getString("deadline"));
				pVO.setLeader(rs.getString("leader"));
				pVO.setProgress(rs.getString("progress"));
				pVO.setClassification(rs.getString("classification"));
				pVO.setRoleGroup(rs.getString("roleGroup"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		disconnect();
		return pVO;
	}
	
	// 프로젝트 삭제
	public boolean deleteProject(String pid) {
		boolean result = false;
		connect();

		String sql = "delete from project where projectid = '"+pid+"'";
		try {
			stmt.executeUpdate(sql);
			result = true;
		} catch (SQLException e) {
			System.out.println("프로젝트 삭제 실패");
			result = false;
			e.printStackTrace();
		}
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
	
	// 멤버 리스트 조회
	public List getMemberList(String pid) {
		List list = new ArrayList();
		connect();
		
		String sql = "select * from projectmember = pm, user = u where projectid = "+pid+" and pm.userid = u.id";
		System.out.println(sql);
		
		try {
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				memberVO mVO = new memberVO();
				mVO.setProjectid(rs.getString("projectid"));
				mVO.setUserId(rs.getString("userId"));
				mVO.setRole(rs.getString("role"));
				mVO.setName(rs.getString("name"));
				mVO.setPhone(rs.getString("phone"));
				mVO.setEmail(rs.getString("email"));
				mVO.setJob(rs.getString("job"));
				mVO.setBelong(rs.getString("belong"));

				list.add(mVO);
			}
				
		rs.close();
		
		} catch (SQLException e) {
			e.printStackTrace();
		}
		disconnect();
		return list;
	}
	
	// 프로젝트 생성 때 멤버를 여러 명 추가하는 코드
	public int insertMembers(String pid, String memberList) {
		connect();
		int cnt = 0;
		String[] arrMemberList = memberList.split(",");
		timelineDAO tldao = new timelineDAO();
		
		for(int i = 0; i < arrMemberList.length; i ++) {
			String sql = "insert into projectmember values('"+arrMemberList[i]+"', "+pid+", 0)";
			try {
				stmt.executeUpdate(sql);
				tldao.addHistoryEnterProject(arrMemberList[i], pid);
				cnt += 1;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				cnt = cnt;
			}
		}
		disconnect();
		return cnt;
	}
	
	// 참가 요청 수락시 사용
	// 멤버를 한 명 추가하는 코드
	public boolean insertMember(String pid, String id) {
		connect();
		boolean result = false;
		String sql = "insert into projectmember values('"+id+"', "+pid+", 0)";
		System.out.println(sql);
		
		try {
			stmt.executeUpdate(sql);
			result = true;
		} catch(Exception e) {
			e.printStackTrace();
			result = false;
		}
		
		return result;
	}
	
	// 참가 요청이 있는지 확인하는 함수
	public boolean checkEntranceRequest(String pid) {
		connect();
		boolean result = false;
		
		String sql = "select * from entrancerequest where projectid ="+pid+" and state = 'requested'";
		System.out.println(sql);
		
		try {
			ResultSet rs = stmt.executeQuery(sql);
			if(rs.next()) {
				result = true;
			} else {
				result = false;
			}
		} catch(Exception e) {
			e.printStackTrace();
			result = false;
		}
		disconnect();
		return result;
	}
	
	// 참가 요청을 추가
	public boolean insertEntranceRequest(String pid, String userid) {
		connect();
		boolean result = false;
		
		String sql = "insert into entrancerequest values("+pid+", '"+userid+"', 'requested')";
		System.out.println(sql);
		
		try {
			stmt.executeUpdate(sql);
			result = true;
		} catch(Exception e) {
			e.printStackTrace();
			result = false;
		}
		disconnect();
		return result;
	}
	
	// 참가요청 상태를 업데이트
	public boolean updateEntRequest(String pid, String userid, String update) {
		connect();
		boolean result = false;
		
		String sql = "update entrancerequest set state = '"+update+"' where userid = '"+userid+"';";
		System.out.println(sql);
		
		try {
			stmt.executeUpdate(sql);
			
			String chk = "select * from entrancerequest where projectid = "+pid+" and userid = '"+userid+"' and state = '"+update+"'";
			ResultSet rs = stmt.executeQuery(chk);
			
			if(rs.next()) {
				result = true;
			} else {
				result = false;
			}
		} catch(Exception e) {
			e.printStackTrace();
			result = false;
		}
		
		disconnect();
		return result;
	}
	
	// 있는 모든 참가 요청을 불러오는 코드
	public List getEntranceRequests(String pid) {
		connect();
		List list = new ArrayList();
		
		String sql = "select * from entrancerequest = er, user = u where er.userid = u.id and er.projectid="+pid+" order by state desc";
		System.out.println(sql);
		
		try {
			ResultSet rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				entreVO vo = new entreVO();
				vo.setUser(rs.getString("userid"));
				vo.setPid(rs.getString("projectid"));
				vo.setState(rs.getString("state"));
				vo.setName(rs.getString("name"));
				vo.setEmail(rs.getString("email"));
				vo.setJob(rs.getString("job"));
				vo.setBelong(rs.getString("belong"));
				
				list.add(vo);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		disconnect();
		return list;
	}
}
