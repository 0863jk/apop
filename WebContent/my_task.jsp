<%@page import="java.util.List"%>
<%@page import="pms.taskVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.time.LocalDate"%>
<%@page import="pms.projectVO"%>
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
<!-- 차트 링크 -->
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>

<!-- css -->
<link href="css/styles.css" rel="stylesheet"/>
<title>Insert title here</title>
</head>
<body class="container-fluid">
	<jsp:useBean class="pms.taskDAO" id="taskDAO"></jsp:useBean>
	<jsp:useBean class="pms.projectDAO" id="projectDAO"></jsp:useBean>
	<%
		String _id = (String) session.getAttribute("id");
		String _pid = (String) session.getAttribute("pid");
		request.setCharacterEncoding("euc-kr");
		projectVO pVO = projectDAO.getProject(_pid);
		int pgPer = Integer.parseInt(pVO.getProgress());

		LocalDate today = LocalDate.now();
		
		//페이지네이션
		String strTempPage = request.getParameter("page"); // 페이지네이션을 위한 페이지 받아오기

		//tempPage int형으로 저장
		int iTempPage;
		if(strTempPage == null || strTempPage.length() == 0) {
			iTempPage = 1;
		}
		try {
			iTempPage = Integer.parseInt(strTempPage);
		} catch(NumberFormatException e) {
			iTempPage = 1;
		}

		// 전체 글 수
		int totalRows = taskDAO.getTotalRows(_pid, _id);
		
		// 전체 페이지 수
		int totalPage = 0;
		if(totalRows%10==0) {
			totalPage = totalRows / 10;
		} else {
			totalPage = totalRows / 10 + 1;
		}
		request.setCharacterEncoding("euc-kr");
		String _keyword = request.getParameter("keyword");
		
		ArrayList<taskVO> taskList;
		if(_keyword == null || _keyword.equals("")) {
			_keyword = "";
			taskList = taskDAO.getTaskList(_pid, _id, iTempPage);
		} else {
			taskList = taskDAO.searchTask(_pid, _keyword, _id, iTempPage);
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
					class="nav-link  p-3 mb-2 sidebar-link current">나의 Task</a>
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
		<div class="col-sm-10 ml-auto py-3">
			<!-- 화면 -->
			<br>
			<!--  게시판 영역 -->
			<div class="active">
				<div class="container">
					<div class="row">
						<div>
							<h3>나의 TASK</h3>
						</div>
					</div>
					<hr>
					<div class="row">
						<div style="display: flex; justify-content: right; padding-bottom: 10px">
							<form action="my_task.jsp" method="post">
								<input type="text" name="keyword" placeholder="검색어 입력" value="<%=_keyword%>">
								<input type="submit" value="검색">
							</form>
						</div>
						<table class="table table-hover"
							style="text-align: center; border: 1px solid #dddddd">
							<thead>
								<tr>
									<th style="background-color: #eeeeee; text-align: center;"
										width="2%"></th>
									<th style="background-color: #eeeeee; text-align: center;"
										width="50%">업무 이름</th>
									<th style="background-color: #eeeeee; text-align: center;"
										width="40%">기한</th>
									<th style="background-color: #eeeeee; text-align: center;"
										width="8%">진척도</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<%
										for (int i = 0; i < taskList.size(); i++) {
											taskVO vo = (taskVO)taskList.get(i);
									%>
									<td width="1%"><img src="img/<%=vo.getColor()%>signal.png"
										class="rounded-circle" style="width: 15px"></td>
									<td class="project-name">
										<ul class="list-unstyled">
											<a href="my_task_detail.jsp?taskid=<%=vo.getTaskId()%>&progress=<%=vo.getProgress()%>"><li
												class="text-left"><%=vo.getTaskName()%></li></a>
											<ul>
												<li><div
														style="height: 45px; overflow: hidden; text-overflow: ellipsis;"><%=vo.getTaskContent()%></div></li>
											</ul>
										</ul>
									</td>
									<td><%=vo.getStartDate()%> ~ <%=vo.getDeadline()%></td>
									<td><b><%=vo.getProgress()%>%</b></td>
								</tr>
								<%
									}
								%>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<!--  게시판 영역 끝 -->
			<div style="display: flex; justify-content: center;">

				<label class="text-center">
<%
if(iTempPage > 1) {
	int prePage = iTempPage - 1;
	out.println("<a class='btn btn-default' href='my_task.jsp?page="+prePage+"' role='button'>Previous</a>");
}
for(int i = 0; i < totalPage; i++) {
	int pageNum = i + 1;
	out.println("<a class='btn btn-default' href='my_task.jsp?page="+pageNum+"' role='button'>"+pageNum+"</a>");
}
if(iTempPage < totalPage) {
	int nextPage = iTempPage + 1;
	out.println("<a class='btn btn-default' href='my_task.jsp?page="+nextPage+"' role='button'>Next</a>");
}
%>
				</label>
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


	<script>
		data = {
			datasets : [ {
				backgroundColor : [ 'black', 'gray', ],
				data : [
	<%=pgPer%>
		,
	<%=100 - pgPer%>
		]
			} ],
		};
		var ctx1 = document.getElementById("progress_pie_chart");
		var myPieChart = new Chart(ctx1, {
			type : 'pie',
			data : data,
			options : {
				responsive : false
			}
		});
	</script>

	<!-- Option 2: Separate Popper and Bootstrap JS -->
	<!--
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script>
    -->
</body>
</html>