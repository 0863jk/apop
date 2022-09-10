<%@page import="java.time.LocalTime"%>
<%@page import="java.nio.file.attribute.FileTime"%>
<%@page import="pms.projectListVO"%>
<%@page import="java.util.ArrayList"%>
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
<!-- css -->
<link href="css/styles.css?var=0.02" rel="stylesheet" />
<link href="css/card.css?var=0.01" rel="stylesheet" />
<title>Insert title here</title>
</head>

<jsp:useBean class="pms.projectDAO" id="proejctDAO"></jsp:useBean>
<jsp:useBean class="pms.NoticeDAO" id="noticeDAO"></jsp:useBean>

<%
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", -1);

	String _id = (String) session.getAttribute("id");
	LocalTime now = LocalTime.now();
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
				<img src="uploadImg\<%=_id%>_profileImg.png?time=<%=now%>" onerror="this.src='img/profile.png'" width="60px" height=60px; class="rounded-circle mr-3">
				<p>
					<a href="profile_inquiry.jsp" class="profile-text"><%=_id%></a>
				<p>
					<a href="logout.jsp" class="btn logout"
						style="font-size: 15px; border: none;">logout</a>
				</p>
			</div>

			<!-- 아이템 목록 -->
			<ul class="navbar-nav flex-cloumn mt-4">
				<li class="nav-item"><a href="project_list.jsp"
					class="nav-link p-3 mb-2 sidebar-link current">프로젝트 목록</a>
				<li class="nav-item"><a href="past_project_list.jsp"
					class="nav-link p-3 mb-2 sidebar-link">지난 프로젝트</a>
				<li class="nav-item"><a href="new_project.jsp"
					class="nav-link p-3 mb-2 sidebar-link">새 프로젝트</a>
				<li class="nav-item"><a href="project_search.jsp"
					class="nav-link p-3 mb-2 sidebar-link">프로젝트 참여</a>
			</ul>

		</div>

		<!-- 사이드바 끝  -->

		<div class="col-sm-2"></div>

		<div class="col-sm-10 ml-auto py-auto">
			<!-- 화면 -->
			<div class="row row-cols-1 row-cols-md-3 g-4 my-3" id="screen">
				<%
					ArrayList<projectListVO> list = proejctDAO.projectList(_id);
					for (int i = 0; i < list.size(); i++) {
				%>
				<div class="col" id="content">
					<div class="card">
						<div class="thumnail-box" id="project_name">
							<img class="thumnail" src="uploadImg/<%=list.get(i).getProjectId()%>_thumnail.png?time=<%=now%>" onerror="this.src='img/none-image.png'">
						</div>
						<div class="content-box">
							<div class="table-project-name">
								<h3><%=list.get(i).getProjectName() %></h3>
							</div>

							<div class="project-summary">
								<p><%= list.get(i).getProjectSummary()%>
							</div>
						</div>
						<div class="footer-box">
							<div class="leaderIcon-div">
								<img class="leaderIcon" src="img/person-fill.svg"><%=list.get(i).getProjectLeader()%>
							</div>
						</div>
						<a href="project_main.jsp?pid=<%=list.get(i).getProjectId()%>"
								class="stretched-link"></a>
					</div>
				</div>
				<%
					}
				%>
				<!-- 리스트 마지막 -->
				<div class="col">
					<div class="card ">
						<div class="card-body">
							<img class="project-creation"
								src="img\project_creation_button.svg" width="150px"
								height="150px">
						</div>
						<a href="new_project.jsp" class="stretched-link"></a>
					</div>
				</div>

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