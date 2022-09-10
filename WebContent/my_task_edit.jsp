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
<link href="css/styles.css" rel="stylesheet"/>
<title>Insert title here</title>
</head>
<%
String _id = (String)session.getAttribute("id");
String _pid = (String)session.getAttribute("pid");
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
				<p><a href="profile_inquiry.jsp" class="profile-text"><%=_id%></a>
				<p><a href="logout.jsp" class="btn logout" style ="font-size: 15px; border: none;">logout</a></p>
			</div>

			<!-- ������ ��� -->
			<ul class="navbar-nav flex-cloumn mt-4">
				<li class="nav-item"><a href="project_main.jsp"
					class="nav-link  p-3 mb-2 sidebar-link">
						������Ʈ</a>
				<li class="nav-item"><a href="#"
					class="nav-link  p-3 mb-2 sidebar-link">������Ʈ ��ȸ</a>
				<li class="nav-item"><a href="project_notice.jsp"
					class="nav-link  p-3 mb-2 sidebar-link">��������</a>
				<li class="nav-item"><a href="project_summary_inquiry.jsp"
					class="nav-link  p-3 mb-2 sidebar-link">��� ��ȸ</a>
				<li class="nav-item"><a href="project_member_inquiry.jsp"
					class="nav-link  p-3 mb-2 sidebar-link">������ ��ȸ</a>
				<li class="nav-item"><a href="my_task.jsp"
					class="nav-link  p-3 mb-2 sidebar-link current">���� Task</a>
				<li class="nav-item"><a href="#"
					class="nav-link  p-3 mb-2 sidebar-link">������Ʈ ����</a>
				<li class="nav-item"><a href="project_correction.jsp"
					class="nav-link  p-3 mb-2 sidebar-link">������Ʈ ����</a>
				<li class="nav-item"><a href="project_task_assignment.jsp"
					class="nav-link  p-3 mb-2 sidebar-link">Task ����</a>
			</ul>

		</div>
		<!-- ���̵�� ��  -->

		<div class="col-sm-2">	</div>
			<div class="col-sm-10 ml-auto py-auto">

				<!-- ��� �׺���̼�-->
				<div class="row top-nav ">
					<div class="col-md-7">
						<h4>DASHBORAD</h4>
					</div>
					<div class="col-md-3 project-info">
						<div class="row-md-1">���� �̸�</div>
						<div class="row-md-1">���� ��</div>
					</div>
					<div class="col-md-2 logout">��ư</div>
				</div>

				<!-- ȭ�� -->
				<br>				
				<!--  �Խ��� ���� -->
				<div class="active">
					<div class="container">
						<div class="row">
							<div class="col-md-8">
								<h3>���� TASK</h3>
							</div>
							<div class="row col-md-2 pull-right">
								<div class="inline-block">
									<select name="job">
									<option value="option1" selected>����</option>
									<option value="option2">������</option>
									<option value="option3">������</option>
									<option value="option4">��ȹ</option>
									<option value="option4">������</option>
									</select>									
									<a href="my_task.jsp"><button type="button" id="img_btn" style="height:20px">����</button></a>
								</div>
							</div>
						</div>
						<hr>					
						<div class="row">
							<table class="table table-hover"
								style="text-align: center; border: 1px solid #dddddd">
								<thead>
									<tr>
										<th style="background-color: #eeeeee; text-align: center;" width="2%"></th>
										<th style="background-color: #eeeeee; text-align: center;" width="50%">���� �̸�</th>
										<th style="background-color: #eeeeee; text-align: center;" width="40%">����</th>
										<th style="background-color: #eeeeee; text-align: center;" width="8%">��ô��</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td width="1%"><img src="img/redsignal.png" class="rounded-circle" style="width:15px"></td>
										<td class="project-name">
											<ul class="list-unstyled">
												<li class="text-left">�̰��ϱ�</li>
												<ul>
													<li class="">Lorem Ipsum is simply dummy text of the printing and typesetting industry.</li>
												</ul>
											</ul>
										</td>
										<td>2022. 03. 01. ~ 2022. 04. 03.</td>
										<td><b>90%</b></td>
									</tr>
									<tr>
										<td width="1%"><img src="img/greensignal.png" class="rounded-circle" style="width:15px"></td>
										<td class="project-name">
											<ul class="list-unstyled">
												<li class="text-left">�����ϱ�</li>
												<ul>
													<li class="">Lorem Ipsum is simply dummy text of the printing and typesetting industry.</li>
												</ul>
											</ul>
										</td>
										<td>2022. 03. 01. ~ 2022. 04. 09.</td>
										<td><b>90%</b></td>
									</tr>
									<tr>
										<td width="1%"><img src="img/yellowsignal.png" class="rounded-circle" style="width:15px"></td>
										<td class="project-name">
											<ul class="list-unstyled">
												<li class="text-left">�����ϱ�</li>
												<ul>
													<li class="">Lorem Ipsum is simply dummy text of the printing and typesetting industry.</li>
												</ul>
											</ul>
										</td>
										<td>2022. 03. 01. ~ 2022. 04. 30.</td>
										<td><b>50%</b></td>
									</tr>
									<tr>
										<td width="1%"><img src="img/graysignal.png" class="rounded-circle" style="width:15px"></td>
										<td class="project-name">
											<ul class="list-unstyled">
												<li class="text-left">�߰����� �ۼ�</li>
												<ul>
													<li class="">Lorem Ipsum is simply dummy text of the printing and typesetting industry.</li>
												</ul>
											</ul>
										</td>
										<td>2022. 04. 11. ~ 2022. 04. 28.</td>
										<td><b>����</b></td>
									</tr>									
									<tr>
										<td width="1%"><img src="img/graysignal.png" class="rounded-circle" style="width:15px"></td>
										<td class="project-name">
											<ul class="list-unstyled">
												<li class="text-left">�������� �ۼ�</li>
												<ul>
													<li class="">Lorem Ipsum is simply dummy text of the printing and typesetting industry.</li>
												</ul>
											</ul>
										</td>
										<td>2022. 06. 01. ~ 2022. 06. 30.</td>
										<td><b>����</b></td>
									</tr>
									<tr>
										<td width="1%"><img src="img/bluesignal.png" class="rounded-circle" style="width:15px"></td>
										<td class="project-name">
											<ul class="list-unstyled">
												<li class="text-left">��Ա�</li>
												<ul>
													<li class="">Lorem Ipsum is simply dummy text of the printing and typesetting industry.</li>
												</ul>
											</ul>
										</td>
										<td>2022. 03. 01. ~ 2022. 04. 03.</td>
										<td><b>100%</b></td>
									</tr>									
								</tbody>
							</table>
						</div>
					</div>
				</div>
		<!--  �Խ��� ���� �� -->

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