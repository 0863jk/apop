<%@page import="pms.projectVO"%>
<%@page import="pms.userVO"%>
<%@page import="pms.taskVO"%>
<%@page import="pms.memberVO"%>
<%@page import="java.util.ArrayList"%>
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
<link href="css/memberCard.css" rel="stylesheet"/>
<title>Insert title here</title>
</head>

<jsp:useBean class="pms.projectDAO" id="projectDAO"></jsp:useBean>
<jsp:useBean class="pms.taskDAO" id="taskDAO"></jsp:useBean>
<jsp:useBean class="pms.memberDAO" id="memberDAO"></jsp:useBean>
<jsp:useBean class="pms.userDAO" id="userDAO"></jsp:useBean>
<%
	String _id = (String) session.getAttribute("id");
	String _pid = (String) session.getAttribute("pid");
	
	projectVO pVO = projectDAO.getProject(_pid);
	ArrayList<memberVO> mList = memberDAO.getMembers(_pid);
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
					class="nav-link  p-3 mb-2 sidebar-link">������Ʈ</a>
				<li class="nav-item"><a href="project_notice.jsp"
					class="nav-link  p-3 mb-2 sidebar-link">��������</a>
				<li class="nav-item"><a href="project_timeline.jsp"
					class="nav-link  p-3 mb-2 sidebar-link">Ÿ�Ӷ���</a>
				<li class="nav-item"><a href="project_member_inquiry.jsp"
					class="nav-link  p-3 mb-2 sidebar-link current">������ ��ȸ</a>
				<li class="nav-item"><a href="my_task.jsp"
					class="nav-link  p-3 mb-2 sidebar-link">���� Task</a>
				<%if(_id.equals(pVO.getLeader())){ %>
				<li class="nav-item"><a href="project_correction.jsp"
					class="nav-link  p-3 mb-2 sidebar-link">������Ʈ ����</a>
				<li class="nav-item"><a href="project_task_assignment.jsp"
					class="nav-link  p-3 mb-2 sidebar-link">Task
						����</a>
				<%} %>
			</ul>

		</div>
		<!-- ���̵�� ��  -->

		<div class="col-sm-2"></div>
		<div class="col-sm-10 ml-auto py-auto" style="padding:30px">

			<!-- ȭ�� -->
			<h3 class="text-center">������Ʈ ���</h3><hr>
<%
if(_id.equals(pVO.getLeader())) {
%>
			<div  style="display: flex; justify-content: right;">
				<button type="button" class="btn btn-primary" onclick="location.href='project_member_list.jsp'">����</button>
			</div>
<%
}
%>
			<div class="row row-cols-1 row-cols-md-3 py-4 g-4">
			<%
				for(int i = 0 ; i<mList.size(); i++){
					String mId = mList.get(i).getUserId();
					
					userVO uVO = userDAO.searchUser(mId);
					
					String mName = uVO.getName();
					String mEmail = uVO.getEmail();
					
					ArrayList<taskVO> mTasklist = taskDAO.getTaskList(_pid, mId);
					
			%>
				<div class="col">
					<div class="card">
						<div class="card-body">
							<div
								class="profile-img d-flex justify-content-center align-items-center mb-3 ">
								<img src="img\profile.png" height="100px" width="100px">
							</div>
							<div
								class="profile-info d-flex flex-column justify-content-center align-items-center">
								<span class="name">@<%=mId%></span>
								<span class="email mt-1"><%=mName%></span>
								<span class="email mt-1"><%=mEmail%></span>
							</div>
							<div class="task mt-4 d-flex flex-column">
								<%
									for(int j = 0; j < mTasklist.size() && j<4;j++){ 
								%>
								<p class="task-item"><%= mTasklist.get(j).getTaskName() %></p>
								<%	
									}
								%>
							</div>
						</div>
						<a href="project_member_detail.jsp?mId=<%= mId%>"
							class="stretched-link"></a>
					</div>
				</div>
				<%}%>
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