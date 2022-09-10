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
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<title>join</title>
</head>
<jsp:useBean class="pms.projectDAO" id="projectDAO"></jsp:useBean>
<%
	String _pid = request.getParameter("pid");
	if(_pid == null){
		_pid = "-1";
	}

	String _id = request.getParameter("id");
	if (_id == null) {
		_id = (String) session.getAttribute("id");
		if(_id == null){
	_id = "-1";
		}
	}
	
	boolean idCheck = projectDAO.isUser(_id);
	boolean projectCheck = projectDAO.isProject(_pid);
	boolean inproject = projectDAO.inProject(_id, _pid);
	
%>
<body class="container">

	<!-- null id Modal -->
	<div class="modal fade" id="needLogin" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Project Manger</h5>
				</div>
				<div class="modal-body d-flex flex-column">
					<span>로그인이 필요하거나 잘못된 아이디 입니다.</span>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary"
						data-bs-dismiss="modal" onclick="location.href='login.jsp'">확인</button>

				</div>
			</div>
		</div>
	</div>

	<!-- null project or fail project Modal -->
	<div class="modal fade" id="modal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Project Manger</h5>
				</div>
				<div class="modal-body d-flex flex-column">
					<span id="msg">잘못된 프로젝트거나 없는 프로젝트 입니다.</span>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary"
						data-bs-dismiss="modal" onclick="location.href='project_list.jsp'">확인</button>

				</div>
			</div>
		</div>
	</div>
	
	
	<script>
		var msg = document.getElementById('msg');
		if (!<%= idCheck %>) {
			$("#needLogin").modal("show");
		}else{
			if (!<%=projectCheck%>) {
				$("#modal").modal("show");
			}else{
				if(!<%=inproject %>){
					location.href = 'project_entrance.jsp?pid=<%=_pid %>';
				}else{
					msg.innerText = "이미 참여한 프로젝트 입니다.";
					$("#modal").modal("show");
				}
			}
		}
	</script>

</body>
</html>