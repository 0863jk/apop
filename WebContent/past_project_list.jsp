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
		<!-- ���̵�� -->
		<div class="col-sm-2 sidebar">

			<!-- Ÿ��Ʋ  -->
			<a href="project_list.jsp"
				class="navbar-brand d-block mx-auto py-3 mb-4 bottom-border"> <img
				src="img\logowhite.png" width="100%" height="150px"></a>

			<!-- ������  -->
			<div class="bottom-border text-center">
				 <img src="uploadImg\<%=_id%>_profileImg.png?" onerror="this.src='img/profile.png'" width="60px" height=60px; class="rounded-circle mr-3">  
				<p>
					<a href="#" class="text-black"><%=_id%></a>
					<p><a href="logout.jsp" class="btn logout" style ="font-size: 15px; border: none;">logout</a>
			</div>

			<!-- ������ ��� -->
			<ul class="navbar-nav flex-cloumn mt-4">
				<li class="nav-item"><a href="project_list.jsp"
					class="nav-link p-3 mb-2 sidebar-link">������Ʈ
						���</a>
				<li class="nav-item"><a href="past_project_list.jsp"
					class="nav-link p-3 mb-2 sidebar-link current">���� ������Ʈ</a>
				<li class="nav-item"><a href="new_project.jsp"
					class="nav-link p-3 mb-2 sidebar-link">�� ������Ʈ</a>
				<li class="nav-item"><a href="project_search.jsp"
					class="nav-link p-3 mb-2 sidebar-link">������Ʈ ����</a>
			</ul>

		</div>
		<!-- ���̵�� ��  -->

		<div class="col-sm-2"></div>

		<div class="col-sm-10 ml-auto py-auto my-4">
			<!-- ȭ�� -->
			<br>
			<h3 class="text-center">���� ������Ʈ</h3>
			<hr>
			<!--  �Խ��� ���� -->
			<div class="active">
				<div class="container">
					<div class="row">
						<table class="table table-hover"
							style="text-align: center; border: 1px solid #dddddd">
							<thead>
								<tr>
									<th style="background-color: orange; text-align: center;">������Ʈ
										�̸�</th>
									<th style="background-color: orange; text-align: center;">����</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="project-name">
										<ul class="list-unstyled">
											<a href="#"><li class="text-left"><h4>���� ������Ʈ 1</h4></li></a>
											<ul>
												<li class="">���� ������Ʈ�� ����</li>
											</ul>
										</ul>
									</td>
									<td>
										<ul class="list-unstyled">
											<li><h4>���缮</h4></li>
											<li>2022. 03. 00.</li>
										</ul>
									</td>
								</tr>
								<tr>
									<td class="project-name">
										<ul class="list-unstyled">
											<a href="#"><li><h4>���� ������Ʈ 2</h4></li></a>
											<ul>
												<li>���� ������Ʈ�� ����</li>
											</ul>
										</ul>
									</td>
									<td>
										<ul class="list-unstyled">
											<li><h4>������</h4></li>
											<li>2022. 02. 00.</li>
										</ul>
									</td>
								</tr>
								<tr>
									<td class="project-name">
										<ul class="list-unstyled">
											<a href="#"><li><h4>���� ������Ʈ 3</h4></li></a>
											<ul>
												<li>���� ������Ʈ�� ����</li>
											</ul>
										</ul>
									</td>
									<td>
										<ul class="list-unstyled">
											<li><h4>������</h4></li>
											<li>2022. 01. 00.</li>
										</ul>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>

		</div>
	</div>
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