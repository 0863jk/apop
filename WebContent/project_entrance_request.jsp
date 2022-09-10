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
<!-- ��Ʈ ��ũ -->
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
<title>Main</title>
</head>
<jsp:useBean class="pms.projectDAO" id="proDAO"></jsp:useBean>
<%
	String _id = (String) session.getAttribute("id");
	String _pid = request.getParameter("pid");
	
	boolean result = proDAO.insertEntranceRequest(_pid, _id);
%>
<body class="container-fluid">
	<div class="row">
		<!-- ���̵�� -->
		<div class="col-2 sidebar">

			<!-- Ÿ��Ʋ  -->
			<a href="project_list.jsp"
				class="navbar-brand d-block mx-auto py-3 mb-4 bottom-border"> <img
				src="img\logowhite.png" width="100%" height="150px"></a>

			<!-- ������  -->
			<div class="bottom-border text-center">
				 <img src="uploadImg\<%=_id%>_profileImg.png?" onerror="this.src='img/profile.png'" width="60px" height=60px; class="rounded-circle mr-3">  
				<p><a href="profile_inquiry.jsp" class="profile-text"><%=_id%></a>
				<p><a href="logout.jsp" class="btn logout" style ="font-size: 15px; border: none;">logout</a></p>
			</div>

			<!-- ������ ��� -->
			<ul class="navbar-nav flex-cloumn mt-4">
				<li class="nav-item"><a href="project_list.jsp"
					class="nav-link text-white p-3 mb-2 sidebar-link">������Ʈ ���</a>
				<li class="nav-item"><a href="past_project_list.jsp"
					class="nav-link text-white p-3 mb-2 sidebar-link">���� ������Ʈ</a>
				<li class="nav-item"><a href="#"
					class="nav-link text-white p-3 mb-2 sidebar-link current">��
						������Ʈ</a>
			</ul>


		</div>
		<!-- ���̵�� ��  -->

		<div class="col-2"></div>
		<div class="col-10 pl-auto mx-auto" style="height: 100vh;">
			<!-- ��� �׺���̼�-->
			<div class="row top-nav text-white" style="height: 8vh;">
				<div class="col-7">
					<h4>DASHBORAD</h4>
				</div>
				<div class="col-3 project-info">
					<div class="row-1">���� �̸�</div>
					<div class="row-1">���� ��</div>
				</div>
				<div class="col-2 logout">
					<a href="logout.jsp"><img src="img\logout.svg" width="30px"
						height="30px"></a>
				</div>
			</div>

			<!-- ȭ�� -->
<%
if(result) {
%>
			<div style="padding:30px;">
				<p class="text-center">���� ��û�� �Ϸ�Ǿ����ϴ�.</p>
				<div style="display: flex; justify-content: center;">
					<button onclick="location='project_list.jsp'">�������� �̵�</button>
				</div>
			</div>
<%
} else {
%>
			<div style="padding:30px;">
				<p class="text-center">���� ��û�� �����߽��ϴ�.</p>
				<div style="display: flex; justify-content: center;">
					<button onclick="location='project_list.jsp'">�������� �̵�</button>
				</div>
			</div>
<%	
}
%>
	<!-- body �� -->

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