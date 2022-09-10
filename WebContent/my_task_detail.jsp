<%@page import="pms.projectVO"%>
<%@page import="pms.TaskDetailVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="pms.taskVO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
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
	<jsp:useBean class="pms.projectDAO" id="projectDAO"></jsp:useBean>
	<jsp:useBean class="pms.taskDAO" id="taskDAO"></jsp:useBean>
	<jsp:useBean class="pms.TaskDetailDAO" id="taskDetailDAO"></jsp:useBean>
	<jsp:useBean class="pms.CommentDAO" id="commentDAO"></jsp:useBean>
	<%
		String taskId = request.getParameter("taskid");
		String _id = (String) session.getAttribute("id");
		String _pid = (String) session.getAttribute("pid");
		
		projectVO pVO = projectDAO.getProject(_pid);

		taskVO tVO = taskDAO.getTask(taskId);
		String taskname = tVO.getTaskName();
		String date = tVO.getStartDate() + " ~ " + tVO.getDeadline();
		String _progress = tVO.getProgress() + "";
		String worker = tVO.getWorker();
		String content = tVO.getTaskContent();
		String work = tVO.getWork();
		int approve = tVO.getApprove();
		if (work == null) {
			work = "";
		}
		
		ArrayList<TaskDetailVO> tdList = taskDetailDAO.getTaskDetailList(taskId);
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
				<p><a href="profile_inquiry.jsp" class="profile-text"><%=_id%></a>
				<p><a href="logout.jsp" class="btn logout" style ="font-size: 15px; border: none;">logout</a></p>
			</div>

				<!-- 아이템 목록 -->
			<ul class="navbar-nav flex-cloumn mt-4">
				<li class="nav-item"><a href="project_main.jsp"
					class="nav-link  p-3 mb-2 sidebar-link">
						프로젝트</a>
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

		<div class="col-sm-2"></div>
		<div class="col-sm-10 ml-auto py-auto ">
			<!-- 화면 -->
			<!-- 게시판 글 보기 양식 영역 시작 -->
			<div class="container my-5">
				<h3 class="text-center"><%=taskname%></h3>
				<hr>
					<table class="table table-condensed"
						style="text-align: center; border: 1px solid #dddddd">
						<thead>
							<tr>
								<td width="30%" style="background-color: #eeeeee;"></td>
								<th style="background-color: #eeeeee; text-align: center; vertical-align: middle;">업무 정보
								</th>
								<td width="30%" style="background-color: #eeeeee;">
									<div align="right">
										<!-- 조회 하는 사람이 프로젝트 리더 인 경우 -->
										<%
											if (_id.equals(projectDAO.getProject(_pid).getLeader())) {
										%>
										<a href="project_update_task.jsp?taskid=<%=taskId%>"
											class="btn mx-1">업무 정보 수정</a> <a
											href="my_task_delete.jsp?taskid=<%=taskId%>&progress=<%=_progress%>"
											class="btn mx-1">업무 삭제</a>
										<%
											}
										%>
									</div>
								</td>
								
							</tr>
						</thead>
						<tbody>
							<tr>
								<td style="width: 20%;">업무 제목</td>
								<td colspan="2"><%=taskname%></td>
							</tr>
							<tr>
								<td>기한</td>
								<td colspan="2"><%=date%></td>
							</tr>
							<tr>
								<td>진척도</td>
								<td colspan="2"><%=_progress%>%</td>
							</tr>
							<tr>
								<td>업무 정보</td>
								<td colspan="2" style="height: 100px; text-align: left;"><pre><%=content%></pre></td>
							</tr>
						</tbody>
					</table>
				<div class = "mt-3">
					<table class="table table-condensed"
						style="text-align: center; border: 1px solid #dddddd">
						<thead>
							<tr>
								<td width="20%" style="background-color: #eeeeee;"></td>
								<th style="background-color: #eeeeee; text-align: center; vertical-align: middle;">업무 보고 목록</th>
								<td width="20%" style="background-color: #eeeeee;">
								<%if(_id.equals(worker)){%>
									<div align="right">
									<a href="my_task_detail_write.jsp?taskid=<%=taskId %>&progress=<%=_progress %>" class="btn mx-1">보고 등록</a>
									</div>
								<%} %>
								</td>
						</thead>
						<tbody>
							<tr>
								<td class ="text-center">글번호</td>
								<td class ="project-name">보고 이름</td>
								<td class ="text-center"">작성일</td>
							</tr>
							
							<% for(int i=0; i<tdList.size();i++){ 
								TaskDetailVO tdVO = tdList.get(i);
							%>
							<tr> 
								<td><%=tdList.size()-i%></td>
								<td class ="project-name"><a href ="my_task_detail_view.jsp?tid=<%=taskId%>&tdid=<%=tdVO.getTaskDetailId()%>"><%=tdVO.getName()%></a></td>
								<td class ="text-cneter"><%=tdList.get(i).getDate()%></td>
							</tr>
							<%} %>
						</tbody>
					</table>
					<!-- 조회 하는 사람이 프로젝트 리더 인 경우 -->
					<%
						if (_id.equals(projectDAO.getProject(_pid).getLeader()) && tVO.getProgress() == 100 ) {
					%>
					<div align="right">
						<a href="task_approve.jsp?taskid=<%=taskId%>"
							class="btn mx-1">업무 승인</a>
					</div>	
					<%
						}
					%>


				</div>
				<!-- 게시판 글 보기 양식 영역 끝 -->
				<br>
			</div>
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