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
<%
	String _id = (String) session.getAttribute("id");
%>


<body class="container-fluid">
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
					<a href="#" class="text-white"><%=_id%></a>
			</div>

			<!-- 아이템 목록 -->
			<ul class="navbar-nav flex-cloumn mt-4">
				<li class="nav-item"><a href="project_main.jsp"
					class="nav-link text-white p-3 mb-2 sidebar-link">프로젝트</a>
				<li class="nav-item"><a href="#"
					class="nav-link text-white p-3 mb-2 sidebar-link">프로젝트 조회</a>
				<li class="nav-item"><a href="project_notice.jsp"
					class="nav-link text-white p-3 mb-2 sidebar-link">공지사항</a>
				<li class="nav-item"><a href="project_summary_inquiry.jsp"
					class="nav-link text-white p-3 mb-2 sidebar-link current">요약 조회</a>
				<li class="nav-item"><a href="project_member_inquiry.jsp"
					class="nav-link text-white p-3 mb-2 sidebar-link">팀원별 조회</a>
				<li class="nav-item"><a href="my_task.jsp"
					class="nav-link text-white p-3 mb-2 sidebar-link">나의 Task</a>
				<li class="nav-item"><a href="#"
					class="nav-link text-white p-3 mb-2 sidebar-link">프로젝트 관리</a>
				<li class="nav-item"><a href="project_correction.jsp"
					class="nav-link text-white p-3 mb-2 sidebar-link">프로젝트 수정</a>
				<li class="nav-item"><a href="project_task_assignment.jsp"
					class="nav-link text-white p-3 mb-2 sidebar-link">Task 관리</a>
			</ul>

		</div>
		<!-- 사이드바 끝  -->

		<div class="col-sm-2"></div>
		<div class="col-sm-10 ml-auto py-auto">

			<!-- 상단 네비게이션-->
			<div class="row top-nav align-items-center text-white"
				style="height: 8vh;">
				<div class="col-7">
					<h4>DASHBORAD</h4>
				</div>
				<div class="col-3 project-info">
					<div class="row-1">팀장 이름</div>
					<div class="row-1">마감 일</div>
				</div>
				<div class="col-2 d-flex justify-content-end align-items-center">
					<div class="items mx-1">
						<button type="button" data-bs-toggle="modal"
							data-bs-target="#exampleModal"
							style="background: none; border: 0; outline: 0;">
							<img src="img\person-plus-fill.svg" width="37px" height="37px">
						</button>
					</div>
					<div class="items mx-1">
						<a href="logout.jsp"><img src="img\logout.svg" width="30px"
							height="30px"></a>
					</div>

				</div>
			</div>

			<!-- 화면 -->
			<div class="row timeline bottom-border-black" style="width: 100%; overflow-x: scroll;" >
				<div style="width: max-content;">
					<jsp:include page="module\time_line.jsp" flush="false" />
				</div>
			</div>

			<div class="row">
				<jsp:include page="module\task_list.jsp" flush="false" />
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