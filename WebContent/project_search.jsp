<%@page import="pms.projectListVO"%>
<%@page import="java.util.*"%>
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

<body class="container-fluid">
<jsp:useBean class="pms.projectDAO" id="proDAO"></jsp:useBean>
<%
	String _id = (String) session.getAttribute("id");
	request.setCharacterEncoding("euc-kr");
	String keyword = request.getParameter("keyword");
	String classification = request.getParameter("classification");
	
	if(keyword == null) {
		keyword = "";
	}
	if(classification == null) {
		classification = "";
	}
%>
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
				<li class="nav-item"><a href="project_list.jsp"
					class="nav-link  p-3 mb-2 sidebar-link">������Ʈ ���</a>
				<li class="nav-item"><a href="past_project_list.jsp"
					class="nav-link  p-3 mb-2 sidebar-link">����
						������Ʈ</a>
				<li class="nav-item"><a href="new_project.jsp"
					class="nav-link  p-3 mb-2 sidebar-link">�� ������Ʈ</a>
				<li class="nav-item"><a href="project_search.jsp"
					class="nav-link  p-3 mb-2 sidebar-link current">������Ʈ ����</a>
			</ul>

		</div>
		<!-- ���̵�� ��  -->

		<div class="col-sm-2"></div>

		<div class="col-sm-10 ml-auto py-auto">
			<!-- ȭ�� -->
			<br>
			<h3 class="text-center">������Ʈ ����</h3>
			<hr>
			<!-- �˻�â -->
			<div>
				
			</div>
			<form action="project_search.jsp" method="post">
				<div class="row" style="margin:10px;">
					<table style="padding:10px;">
						<tr>
							<select class="form-control title" name ="classification">
								<option value="null" selected>������Ʈ �з� ����</option>
								<option value="�̺з�">�̺з�</option>
								<option value="�� ������Ʈ">�� ������Ʈ</option>
								<option value="�븶�� ������Ʈ">�븶�� ������Ʈ</option>
								<option value="��ŸƮ�� ������Ʈ">��ŸƮ�� ������Ʈ</option>
							</select>				
						</tr>
						<tr>
							<td width="90%" style="padding:10px">
								<input type="text" name="keyword" class="form-control" placeholder="�˻��� �Է�" value="<%=keyword%>">
							</td>
							<td width="10%" style="padding:10px">
								<input type="submit" class="btn btn-primary" style="width:100%;" value="�˻�">
							</td>
						</tr>
					</table>
				</div>
			</form>	
			<hr>
			<!--  �Խ��� ���� -->
<%
if((classification.equals("") || classification.equals("null")) && (keyword.equals("") || keyword.equals("null"))) {
%>
			<div class="active">
				<br>
				<p class="text-center">���⿡ �˻� ����� ǥ�õ˴ϴ�.</p>
			</div>
<%
} else {
	List projectList = proDAO.searchProject(keyword, classification);
	if(projectList.size() < 1) {
		%>
		<div class="active">
			<br>
			<p class="text-center">�˻� ����� �����ϴ�.</p>
		</div>
<%		
	} else {
%>
		<div class="active">
						<div class="container">
							<div class="row">
								<table class="table table-hover"
									style="text-align: center; border: 1px solid #dddddd">
									<thead>
										<tr>
											<th style="background-color: #eeeeee; text-align: center;">������Ʈ
												�̸�</th>
											<th style="background-color: #eeeeee; text-align: center;">����</th>
										</tr>
									</thead>
									<tbody>
										
<%
		for(int i = 0; i < projectList.size(); i ++) {
			projectListVO vo = (projectListVO)projectList.get(i);
%>
										<tr>
										<td class="project-name">
											<ul class="list-unstyled">
												<a href="check_before_entrance.jsp?pid=<%=vo.getProjectId()%>"><li class="text-left"><h4><%=vo.getProjectName()%></h4></li></a>
												<ul>
													<li class=""><%=vo.getProjectSummary() %></li>
												</ul>
											</ul>
										</td>
										<td>
											<ul class="list-unstyled">
												<li><h4><%=vo.getProjectLeader() %></h4></li>
											</ul>
										</td>
									</tr>
<%
		}
	}

%>
							</tbody>
						</table>
					</div>
				</div>
			</div>
<%
}
%>

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