<%@page import="java.util.List"%>
<%@page import="pms.NoticeVO"%>
<%@page import="pms.taskVO"%>
<%@page import="pms.memberVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="pms.projectVO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<!-- Required meta tags -->
<meta charset="utf-8">
<!-- <meta name="viewport" content="width=device-width, initial-scale=1"> -->

<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">

<!-- 차트 링크 -->
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
<!-- css -->
<link href="css/styles.css" rel="stylesheet"/>
<link href="css/trello.css" rel="stylesheet"/>

<title>Main</title>
</head>

<jsp:useBean class="pms.projectDAO" id="projectDAO"></jsp:useBean>
<jsp:useBean class="pms.taskDAO" id="taskDAO"></jsp:useBean>
<jsp:useBean class="pms.memberDAO" id="memberDAO"></jsp:useBean>
<jsp:useBean class="pms.NoticeDAO" id="noticeDAO"></jsp:useBean>
<%
	int pgPer = 0;
	String _id = (String) session.getAttribute("id");
	String _pid = (String) request.getParameter("pid");
	if(_pid==null){
		_pid = (String) session.getAttribute("pid");
	}

	projectVO pVO = projectDAO.getProject(_pid);
	pgPer = Integer.parseInt(pVO.getProgress());
	
	session.setAttribute("pid", _pid);
	
	ArrayList<taskVO> myTaskVO = taskDAO.getTaskList(_pid,_id);
	ArrayList<taskVO> allTaskVO = taskDAO.getTaskList(_pid);
	
	List<NoticeVO> nVO = noticeDAO.selectAll(Integer.parseInt(_pid), 0);
	
	String entranceURL = request.getRequestURL().toString().replace("project_main", "check_before_entrance");
%>

<body class="container-fluid">
	<div class="row">
		<!-- 사이드바 -->
		<div class="col-2 sidebar">

			<!-- 타이틀  -->
			<a href="project_list.jsp"
				class="navbar-brand d-block mx-auto py-3 mb-4 bottom-border"> <img
				src="img\logowhite.png" width="100%" height="150px"></a>

			<!-- 프로필  -->
			<div class="bottom-border text-center">
				 <img src="uploadImg\<%=_id%>_profileImg.png?" onerror="this.src='img/profile.png'" width="60px" height=60px; class="rounded-circle mr-3">  
				<p><a href="profile_inquiry.jsp" class="profile-text"><%=_id%></a>
				<p><a href="logout.jsp" class="btn logout" style ="font-size: 15px; border: none;">logout</a></p>
			</div>

			<!-- 아이템 목록 -->
			<ul class="navbar-nav flex-cloumn mt-4">
				<li class="nav-item"><a href="project_main.jsp"
					class="nav-link  p-3 mb-2 sidebar-link  current">프로젝트</a>
				<li class="nav-item"><a href="project_notice.jsp"
					class="nav-link  p-3 mb-2 sidebar-link">공지사항</a>
				<li class="nav-item"><a href="project_timeline.jsp"
					class="nav-link  p-3 mb-2 sidebar-link">타임라인</a>
				<li class="nav-item"><a href="project_member_inquiry.jsp"
					class="nav-link  p-3 mb-2 sidebar-link">팀원별 조회</a>
				<li class="nav-item"><a href="my_task.jsp"
					class="nav-link  p-3 mb-2 sidebar-link">나의 Task</a>
					
				<%if(_id.equals(pVO.getLeader())){ %>
				<li class="nav-item"><a href="project_correction.jsp"
					class="nav-link  p-3 mb-2 sidebar-link">프로젝트 수정</a>
				<li class="nav-item"><a href="project_task_assignment.jsp"
					class="nav-link  p-3 mb-2 sidebar-link">Task
						관리</a>
				<%} %>
			</ul>

		</div>
		<!-- 사이드바 끝  -->

		<div class="col-2"></div>
		<div class="col-10 pl-auto mx-auto mt-2" style="height: 100vh;">
			<div class ="row mb-3" style= "height: 50px;">
				<label class="project-title text-center my-2"><%= pVO.getName() %></label>
			</div>
			<hr>
		<!-- 화면 -->
			<div class ="d-flex justify-content-center align-items-start" style ="flex-wrap: nowrap; flex-shrink: 0;">
			
			
				<div class ="board d-relative my-2 mx-3">
					<div class="board-header"><label style ="vertical-align: center;">Notice</label></div>
					<div class="board-body">
					<ul class="navbar-nav align-items-center">
						<% 
							for(int i = 0; i<nVO.size();i++){
								int nId = nVO.get(i).getNid();
								String nName = nVO.get(i).getTitle();
						%>
							
						<li class="board-item mt-3">
							<a href="project_notice_view.jsp?noticeid=<%=nId%>"><%=nName%></a><br>
							<img src="img\justify-left.svg" width="20px" height="20px" class="py-0">
						</li>
						
						<%
							}
						%>
					</ul>
					<div class ="my-3 mx-3"><a href="project_notice.jsp">+Another view...</a></div>
					</div>
				</div>
				
				<div class ="board d-relative my-2 mx-3">
					<div class="board-header"><label style ="vertical-align: center;">To Do</label></div>
					<div class="board-body">
					<ul class="navbar-nav align-items-center">
						<% for(int i =0; i<myTaskVO.size();i++){
							String tId = myTaskVO.get(i).getTaskId();
							String tName = myTaskVO.get(i).getTaskName();
						%>
							
						<li class="board-item mt-3">
							<a href="my_task_detail.jsp?taskid=<%=tId%>"><%= tName%></a><br>
							<img src="img\justify-left.svg" width="20px" height="20px" class="py-0">
						</li>
						
						<%} %>
					</ul>
					<div class ="my-3 mx-3"><a href="my_task.jsp">+Another view...</a></div>
					</div>
				</div>
				
				<div class ="board d-relative my-2 mx-3">
					<div class="board-header"><label style ="vertical-align: center;">In Progress</label></div>
					<div class="board-body">
					<ul class="navbar-nav align-items-center">
						<%for(int i=0; i<allTaskVO.size(); i++){
							String tId = allTaskVO.get(i).getTaskId();
							String tName = allTaskVO.get(i).getTaskName();
							if(!(allTaskVO.get(i).getColor().equals("blue")) && !allTaskVO.get(i).getWorker().equals(_id)){
						%>
							<li class="board-item mt-3">
								<a href="my_task_detail.jsp?taskid=<%=tId%>"><%=tName%></a>
								<br>
								<img src="img\justify-left.svg" width="20px" height="20px" class="py-0">
							</li>

						<%
							}
						}
						%>
						
					</ul>
					<div class ="my-3 mx-3"><a href="#">+Another view...</a></div>
					</div>
				</div>
				
				<div class ="board d-relative my-2 mx-3">
					<div class="board-header"><label style ="vertical-align: center;">Completed</label></div>
					<div class="board-body">
					<ul class="navbar-nav align-items-center">
						<%for(int i=0; i<allTaskVO.size(); i++){
							String tId = allTaskVO.get(i).getTaskId();
							String tName = allTaskVO.get(i).getTaskName();
							if((allTaskVO.get(i).getColor().equals("blue"))){
						%>
							<li class="board-item mt-3">
								<a href="my_task_detail.jsp?taskid=<%=tId%>"><%=tName%></a>
								<br>
								<img src="img\justify-left.svg" width="20px" height="20px" class="py-0">
							</li>

						<%
							}
						}
						%>
					</ul>
					<div class ="my-3 mx-3"><a href="#">+Another view...</a></div>
					</div>
				</div>
			</div>
		</div>
	</div>
<%	
	if(_id.equals(pVO.getLeader())) {
		boolean chkEntReq = projectDAO.checkEntranceRequest(_pid);
		if(chkEntReq) {
%>
<script type="text/javascript">
	var confirm = confirm("참가 요청이 있습니다.\n참가 요청이 있는 창으로 이동하겠습니까?");
	if(confirm == true) {
		location.replace('entrance_request_list.jsp');
	}
</script>
<%
		}
	}
%>
	<!-- Option 2: Separate Popper and Bootstrap JS -->
	<!--
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script>
    -->




</body>
</html>