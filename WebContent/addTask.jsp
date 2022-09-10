<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" import="java.sql.*" import="java.util.*,pms.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
		<!-- css -->
<link href="css/styles.css" rel="stylesheet"/>
<title>Insert title here</title>
</head>

<body class="container-fluid">
	<jsp:useBean class="pms.taskDAO" id="taskDAO"></jsp:useBean>
	<jsp:useBean class="pms.projectDAO" id="projectDAO"></jsp:useBean>
	<jsp:useBean class="pms.timelineDAO" id="timelineDAO"></jsp:useBean>
	<%
		String _id = (String) session.getAttribute("id");

		request.setCharacterEncoding("euc-kr");
		String _taskName = request.getParameter("taskName");
		String _taskContent = request.getParameter("taskContent");
		String _worker = request.getParameter("worker");
		String _pid = (String) session.getAttribute("pid");
		int progress = 0;
		String _startDate = request.getParameter("from");
		String _deadline = request.getParameter("to");

		projectVO pVO = projectDAO.getProject(_pid);

		boolean result = false;
		int _tid = taskDAO.addTask(_taskName, _taskContent, _worker, _pid, progress, _startDate, _deadline);
		if(_tid != -1){
			if(timelineDAO.addHistoryAddTask(_worker, _pid, _tid+"")){
				result = true;
			}
		}
	%>

	<div class="row">
		<!-- 사이드바 -->
		<div class="col-sm-2 sidebar">

			<!-- 타이틀  -->
			<a href="project_list.jsp"
				class="navbar-brand d-block mx-auto py-3 mb-4 bottom-border"> <img
				src="img\logowhite.png" width="100%" height="150px"></a>

			<!-- 프로필  -->
			<div class="bottom-border text-center">
				<img src="uploadImg\<%=_id%>_profileImg.png?" onerror="this.src='img/profile.png'" width="60px" height=60px; class="rounded-circle mr-3">  
				<p>
					<a href="profile_inquiry.jsp" class="profile-text"><%=_id%></a>
				<p>
					<a href="logout.jsp" class="btn logout"
						style="font-size: 15px; border: none;">logout</a>
				</p>
			</div>

			<!-- 아이템 목록 -->
			<ul class="navbar-nav flex-cloumn mt-4">
				<li class="nav-item"><a href="project_main.jsp"
					class="nav-link  p-3 mb-2 sidebar-link">PMS 프로젝트</a>
				<li class="nav-item"><a href="project_notice.jsp"
					class="nav-link  p-3 mb-2 sidebar-link">공지사항</a>
				<li class="nav-item"><a href="project_summary_inquiry.jsp"
					class="nav-link  p-3 mb-2 sidebar-link">요약 조회</a>
				<li class="nav-item"><a href="project_member_inquiry.jsp"
					class="nav-link  p-3 mb-2 sidebar-link">팀원별 조회</a>
				<li class="nav-item"><a href="my_task.jsp"
					class="nav-link  p-3 mb-2 sidebar-link">나의 Task</a> <%
 	if (_id.equals(pVO.getLeader())) {
 %>
				<li class="nav-item"><a href="project_correction.jsp"
					class="nav-link  p-3 mb-2 sidebar-link">프로젝트 수정</a>
				<li class="nav-item"><a href="project_task_assignment.jsp"
					class="nav-link  p-3 mb-2 sidebar-link  current">Task 관리</a> <%
 	}
 %>
			</ul>

		</div>
		<!-- 사이드바 끝  -->

		<div class="col-sm-2"></div>
		<div class="col-sm-10 ml-auto py-4">
			<!-- 화면 -->
			<div class="d-flex align-items-center justify-content-center"
				style="min-height: 100vh;">
				<%
					if (result) {
						
				%>
				<div class="text-center">
					<label class='text-center control-label'>태스크가 성공적으로 추가
						되었습니다.</label><br> <br> <a href='project_task_assignment.jsp'
						class='btn btn-primary'>확인</a>
				</div>
				<%
					} else {
				%>
				<div class="text-center">
					<label class='text-center control-label'>오류가 발생 했습니다. <%=_worker%></label><br>
					<br> <a href='project_task_assignment.jsp'
						class='btn btn-primary'>확인</a>
				</div>
				<%
					}
				%>

			</div>
		</div>
		<!-- body 끝 -->

		<!-- Optional JavaScript; choose one of the two! -->

		<!-- Option 1: Bootstrap Bundle with Popper -->
		<script
			src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
			integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
			crossorigin="anonymous"></script>

		<!-- Option 2: Separate Popper and Bootstrap JS -->
		<!--
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script>
    -->
</body>
</html>