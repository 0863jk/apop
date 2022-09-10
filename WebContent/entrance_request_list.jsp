<%@page import="pms.projectVO"%>
<%@page import="pms.entreVO"%>
<%@page import="pms.memberVO"%>
<%@page import="java.util.List"%>
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
<jsp:useBean class="pms.projectDAO" id="projectDAO"></jsp:useBean>
<%
	String _id = (String) session.getAttribute("id");
	String _pid = (String) session.getAttribute("pid");
	List entreList = projectDAO.getEntranceRequests(_pid);
	projectVO pVO = projectDAO.getProject(_pid);
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

		<div class="col-sm-2">	</div>
			<div class="col-sm-10 ml-auto py-auto">

				<!-- ȭ�� -->
				<!--  �Խ��� ���� -->
				<div style="padding: 30px">
				<h3 class="text-center">���� ��û ���</h3><hr>
					<div class="container">
					<div class="row">
					</div>
						<br>
						<div class="row">
							<table class="table table-hover" style="text-align: center; border: 1px solid #dddddd">
								<thead>
									<tr>
										<th style="background-color: #eeeeee; text-align: center;" width="10%">���̵�</th>
										<th style="background-color: #eeeeee; text-align: center;" width="10%">�̸�</th>
										<th style="background-color: #eeeeee; text-align: center;" width="20%">�̸���</th>
										<th style="background-color: #eeeeee; text-align: center;" width="15%">����</th>
										<th style="background-color: #eeeeee; text-align: center;" width="15%">�Ҽ�</th>
										<th style="background-color: #eeeeee; text-align: center;" width="15%">����</th>
										<th style="background-color: #eeeeee; text-align: center;" width="10%"></th>
									</tr>
								</thead>
								<tbody>
<%
for(int i = 0; i < entreList.size(); i++) {
	entreVO vo = (entreVO) entreList.get(i);
	String state = "";
	if(vo.getState().equals("requested")) {
		state = "��� ��";
	} else if(vo.getState().equals("refused")) {
		state = "������";
	} else if(vo.getState().equals("accepted")){
		state = "������";
	} else {
		state = "����";
	}
%>
									<tr>
										<td><%= vo.getUser() %></td>
										<td><%= vo.getName() %></td>
										<td><%= vo.getEmail() %></td>
										<td><%= vo.getJob() %></td>
										<td><%= vo.getBelong() %></td>
										<td><%= state %></td>
<%
	if(vo.getState().equals("requested")) {
%>
										<td>
											<button onclick="accept()" class="btn btn-link" style="font-size:10px">����</button>
											<button onclick="refuse()" class="btn btn-link" style="font-size:10px">����</button>
										</td>
<script type="text/javascript">
function accept() {
	if(confirm("<%= vo.getUser()%>���� ������Ʈ�� �߰��մϴ�.")) {
		location.replace('entrance_request_query.jsp?userid=<%=vo.getUser()%>&update=accepted');
	}
}
function refuse() {
	if(confirm("<%= vo.getUser()%>���� ������Ʈ�� �߰����� �ʽ��ϴ�..")) {
		location.replace('entrance_request_query.jsp?userid=<%=vo.getUser()%>&update=refused');
	}
}
</script>
<!--										<td><a href="entrance_request_query.jsp?userid=<%=vo.getUser()%>&update=accepted">����</a> <a href="entrance_request_query.jsp?userid=<%=vo.getUser()%>&update=refused">����</a></td>   -->
<%		
	} else {
%>
										<td>
											<button onclick="accept()" class="btn btn-link" style="font-size:10px" disabled="disabled">����</button>
											<button onclick="refuse()" class="btn btn-link" style="font-size:10px" disabled="disabled">����</button>
										</td>
<%
	}
%>
									</tr>
<%} %>
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