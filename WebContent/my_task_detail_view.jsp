<%@page import="pms.projectVO"%>
<%@page import="pms.TaskDetailVO"%>
<%@page import="pms.taskVO"%>
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
<body class="container-fluid">
	<jsp:useBean class="pms.projectDAO" id="projectDAO"></jsp:useBean>
	<jsp:useBean class="pms.taskDAO" id="taskDAO"></jsp:useBean>
	<jsp:useBean class="pms.TaskDetailDAO" id="taskDetailDAO"></jsp:useBean>
	<jsp:useBean class="pms.CommentDAO" id="commentDAO"></jsp:useBean>

	<%
		String taskId = request.getParameter("tid");
		String taskDetailId = request.getParameter("tdid");
		String _id = (String) session.getAttribute("id");
		String _pid = (String) session.getAttribute("pid");
		
		projectVO pVO = projectDAO.getProject(_pid);
		
		taskVO tVO = taskDAO.getTask(taskId);
		TaskDetailVO tdVO = taskDetailDAO.getTaskDetail(taskDetailId);
		
		String worker = tVO.getWorker();
		int _progress = tVO.getProgress();
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
					class="nav-link  p-3 mb-2 sidebar-link">
						������Ʈ</a>
				<li class="nav-item"><a href="project_notice.jsp"
					class="nav-link  p-3 mb-2 sidebar-link">��������</a>
				<li class="nav-item"><a href="project_timeline.jsp"
					class="nav-link  p-3 mb-2 sidebar-link">Ÿ�Ӷ���</a>
				<li class="nav-item"><a href="project_member_inquiry.jsp"
					class="nav-link  p-3 mb-2 sidebar-link">������ ��ȸ</a>
				<li class="nav-item"><a href="my_task.jsp"
					class="nav-link  p-3 mb-2 sidebar-link current">���� Task</a>
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
		<div class="col-sm-10 ml-auto py-auto py-5">
			<!-- ȭ�� -->
			<!-- �Խ��� �� ���� ��� ���� ���� -->
			<div class="container">
				<h3 class="text-center"><%=tdVO.getName()%></h3>
				<hr>
				<div class="row">
					<table class="table table-condensed"
						style="text-align: center; border: 1px solid #dddddd">
						<thead>
							<tr>
								<th colspan="3"
									style="background-color: #eeeeee; text-align: center;">
									<div align="right">
									<!-- ��ȸ �ϴ� ����� �ش� �½�ũ�� ������� ���-->
									<%
 										if (_id.equals(worker)) {
 									%> 
 									<a href="my_task_detail_update.jsp?tid=<%=taskId%>&tdid=<%=taskDetailId%>&progress=<%=_progress%>"
									class="btn  mx-1">���� ����</a> 
									<a href="my_task_delete.jsp?taskid=<%=taskId%>&progress=<%=_progress%>"
									class="btn  mx-1">���� ����</a> 
									<%
 										}
									 %>
									 </div>
								</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td width="20%">���� ����</td>
								<td colspan="2"><%=tdVO.getName()%></td>
							</tr>
							<tr>
								<td>�ۼ���</td>
								<td colspan="2"><%=tdVO.getDate()%></td>
							</tr>
							<tr>
								<td>����</td>
								<td colspan="2" style="height: 200px; text-align: left;"><%=tdVO.getContent().replace("\r\n","<br>")%></td>
							</tr>
						</tbody>

					</table>
				</div>
			</div>
			<!-- �Խ��� �� ���� ��� ���� �� -->
			<br>
			<!-- �ǵ�� ���� -->
			<%
				if (_id.equals(projectDAO.getProject(_pid).getLeader()) || _id.equals(worker)) {
			%>
			<hr>
			<table class="table table-condensed">
				<th colspan="5" style="background-color: #eeeeee; text-align:;">�ǵ��</th>
				<tbody>
					<tr>
						<td colsapn="1" class="text-center" width="150px">�۾���</td>
						<td colspan="2" class="text-center">����</td>
						<td colsapn="1">
						<td>
					</tr>

					<%
						for (int i = 0; i < commentDAO.getCommentList(taskDetailId).size(); i++) {
					%>
					<tr>
						<td colsapn="1" class="text-center" width="150px"><%=commentDAO.getCommentList(taskDetailId).get(i).getUserId()%></td>
						<td colspan="3"><%=commentDAO.getCommentList(taskDetailId).get(i).getCommentContent()%></td>
						<td colsapn="1" class=text-center " width="50px"
							style="text-align: right; vertical-align: middle;">
							<%if(_id.equals(projectDAO.getProject(_pid).getLeader())){ %>
							<a href="deleteComment.jsp?tid=<%=taskId%>&tdid=<%=taskDetailId%>&leader=<%=_id%>&cid=<%=commentDAO.getCommentList(taskDetailId).get(i).getCommentId()%>">����</a></td>
							<%} %>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
			<hr>
				<%if(_id.equals(projectDAO.getProject(_pid).getLeader())){ %>
			<div>
				<form
					action="addComment2.jsp?tid=<%=taskId%>&tdid=<%=taskDetailId%>&leader=<%=projectDAO.getProject(_pid).getLeader()%>"
					method="post">
					<div class="form-group">
						<textarea class="form-control" rows="3" name="commentContent"
							placeholder="���� �ۼ�..."></textarea>
						<div class="row pt-4 mr-3">
							<div class="d-flex justify-content-end">
								<input type="submit" class="btn btn-lg">
							</div>
						</div>
					</div>
				</form>
			</div>
			<%
				}
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