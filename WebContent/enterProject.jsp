
<%@page import="java.lang.ProcessBuilder.Redirect"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title>Insert title here</title>
</head>
<body>
	<jsp:useBean class="pms.projectDAO" id="projectDAO"></jsp:useBean>
	<jsp:useBean class="pms.timelineDAO" id="timelineDAO"></jsp:useBean>
	<%
		request.setCharacterEncoding("euc-kr");

		String _id = request.getParameter("id");
		if (_id == null) {
			_id = (String) session.getAttribute("id");
		}
		String _pid = request.getParameter("pid");
		String _password = request.getParameter("password");
		
		boolean result = false;
		if(projectDAO.enterProject(_id, _pid, _password)){
			if(timelineDAO.addHistoryEnterProject(_id, _pid)){
				result = true;
			}
		}
		
	%>

	<!-- null id Modal -->
	<div class="modal fade" id="modal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Project Manger</h5>
				</div>
				<div class="modal-body d-flex flex-column">
					<span id="msg">비밀번호가 틀립니다.</span>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary"
						data-bs-dismiss="modal" onclick="location.href='login.jsp'">확인</button>
				</div>
			</div>
		</div>
	</div>

</body>

<script>
	if (<%=result%>) {
		location.href = 'project_main.jsp?pid=<%=_pid%>';
	} else {
		$("#modal").modal("show");
	}
</script>
</html>