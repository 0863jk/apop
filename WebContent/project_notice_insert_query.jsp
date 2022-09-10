<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	import="java.sql.*"
	import="java.util.*,pms.*"%>
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
<body class="container-fluid">
<jsp:useBean class="pms.projectDAO" id="projectDAO"></jsp:useBean>

<jsp:useBean class="pms.NoticeDAO" id="notice"></jsp:useBean>
<%
String _id = (String) session.getAttribute("id");
String _pid = (String) session.getAttribute("pid");

projectVO pVO = projectDAO.getProject(_pid);

//int pid = (int) session.getAttribute("pid");
/*
String title = request.getParameter("title");
String content = request.getParameter("content");

notice.insert(title, content, _id, pid);*/
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
					<a href="#" class="">프로토타입</a>
			</div>

			<!-- 아이템 목록 -->
			<ul class="navbar-nav flex-cloumn mt-4">
				<li class="nav-item"><a href="project_main.jsp"
					class="nav-link  p-3 mb-2 sidebar-link">
						프로젝트</a>
				<li class="nav-item"><a href="project_notice.jsp"
					class="nav-link  p-3 mb-2 sidebar-link  current">공지사항</a>
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

		<div class="col-sm-2">	</div>
			<div class="col-sm-10 ml-auto py-4">
				<!-- 화면 -->
	<div>
	<h3 class="text-center">공지사항 작성</h3><hr>
	<div class="active">
	<div style="display: flex; justify-content: center;">
<%
request.setCharacterEncoding("utf-8");
String title = request.getParameter("title");
String content = request.getParameter("content");

if(title.equals("") || content.equals("")) {
	out.println("<label class='d-flex align-items-center justify-content-center' style ='min-height: 100vh;'>공지사항 작성에 실패했습니다.</label><br><br>");
	out.println("</div>");
	out.println("<div style='display: flex; justify-content: center;'>");
	out.println("<a href='project_notice.jsp' class='btn btn-primary'>목록으로 가기</a>");
} else {
	out.println("<label class='text-center control-label'>"+title+"</label><br><br>");
	out.println("<label class='text-center control-label'>"+content+"</label><br><br>");
	out.println("<label class='text-center control-label'>공지사항이 작성되었습니다.</label><br><br>");
	out.println("</div>");
	out.println("<div style='display: flex; justify-content: center;'>");
	out.println("<a href='project_notice.jsp' class='btn btn-primary'>목록으로 가기</a>");
	notice.insert(title, content, _id, _pid);
}
%>
		
<!--			<label class="text-center control-label">공지사항이 작성되었습니다.</label><br><br>
			<div style="display: flex; justify-content: center;">
			<a href="project_notice.jsp" class="btn btn-primary">목록으로 가기</a> -->
		</div>
	</div>
</div>
<!-- 공지사항 작성창 끝 -->

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