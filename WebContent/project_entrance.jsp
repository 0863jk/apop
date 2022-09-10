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
<link href="css/styles.css" rel="stylesheet"/>
<!-- 차트 링크 -->
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
<title>Main</title>
</head>

<jsp:useBean class="pms.projectDAO" id="proejctDAO"></jsp:useBean>
<%
	String _id = (String) session.getAttribute("id");
	String _pid = request.getParameter("pid");
	
	String projectName = proejctDAO.getProject(_pid).getName();
	String summary = proejctDAO.getProject(_pid).getSummary();
	String leader = proejctDAO.getProject(_pid).getLeader();
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
				<li class="nav-item"><a href="project_list.jsp"
					class="nav-link  p-3 mb-2 sidebar-link">프로젝트 목록</a>
				<li class="nav-item"><a href="past_project_list.jsp"
					class="nav-link  p-3 mb-2 sidebar-link">지난 프로젝트</a>
				<li class="nav-item"><a href="#"
					class="nav-link  p-3 mb-2 sidebar-link">새
						프로젝트</a>
				<li class="nav-item"><a href="#"
					class="nav-link  p-3 mb-2 sidebar-link current">프로젝트 참여</a>
			</ul>


		</div>
		<!-- 사이드바 끝  -->

		<div class="col-2"></div>
		<div class="col-10 pl-auto mx-auto" style="height: 100vh;">

			<!-- 화면 -->
			<div class="row ml-auto"
				style="">
				<!-- 비밀번호 입력 -->
				<div class="col-12" style="padding:30px">
					<div style="padding-bottom:30px">
						<h1 class="text-center"><%=projectName %></h1>
						<h5><strong>리더</strong> <%=leader %></h5>
						<h5><strong>개요</strong> <%=summary %></h5>
					</div>
					<hr>
					<div style="padding:30px">
						<h5 class="text-center"><%=projectName %> 프로젝트에 참가하기 위해선 비밀번호가 필요합니다.</h5>
						<div style="padding:10px">
							<form action="enterProject.jsp" method="post">
								<input type="hidden" name = "pid" value = <%=_pid%>>
								<div style="display: flex; justify-content: center;  padding-bottom:10px;">
									<input type="text" name ="password" class="form-control" style="width:300px;" placeholder="비밀번호 입력...">
								</div>
								<div style="display: flex; justify-content: center;">
									<input type="submit" class="btn btn-primary" value="참가하기">
								</div>
							</form>
						</div>
					</div>
					<div>
						<p class="text-center">비밀번호를 모르신다면... <a href="project_entrance_request.jsp?pid=<%=_pid%>">참가 요청하기</a></p>
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