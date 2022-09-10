<%@page import="pms.projectVO"%>
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
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>
<!-- css -->
<link href="css/styles.css" rel="stylesheet"/>
<title>Insert title here</title>
</head>
<script>
	$(function() {
		var dateFormat = "mm/dd/yy", from = $("#from").datepicker({
			defaultDate : "+1w",
			changeMonth : true,
			numberOfMonths : 1
		}).on("change", function() {
			to.datepicker("option", "minDate", getDate(this));
		}), to = $("#to").datepicker({
			defaultDate : "+1w",
			changeMonth : true,
			numberOfMonths : 1
		}).on("change", function() {
			from.datepicker("option", "maxDate", getDate(this));
		});

		function getDate(element) {
			var date;
			try {
				date = $.datepicker.parseDate(dateFormat, element.value);
			} catch (error) {
				date = null;
			}

			return date;
		}
	});
</script>
<!-- 데이트피커 삽입 끝 -->
<jsp:useBean class="pms.projectDAO" id="projectDAO"></jsp:useBean>
<body class="container-fluid">
	<%
		String _id = (String) session.getAttribute("id");
		String _pid = (String) session.getAttribute("pid");
		projectVO pVO = projectDAO.getProject(_pid);

		ArrayList<memberVO> members = projectDAO.getMembers(_pid);
	%>
	<div class="row">
		<!-- 사이드바 -->
		<div class="col-sm-2 sidebar">

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
				<li class="nav-item"><a href="project_main.jsp"
					class="nav-link  p-3 mb-2 sidebar-link">
						프로젝트</a>
				<li class="nav-item"><a href="project_notice.jsp"
					class="nav-link  p-3 mb-2 sidebar-link">공지사항</a>
				<li class="nav-item"><a href="project_timeline.jsp"
					class="nav-link  p-3 mb-2 sidebar-link">타임라인</a>
				<li class="nav-item"><a href="project_member_inquiry.jsp"
					class="nav-link  p-3 mb-2 sidebar-link">팀원별 조회</a>
				<li class="nav-item"><a href="my_task.jsp"
					class="nav-link  p-3 mb-2 sidebar-link">나의 Task</a>
				<%if(_id.equals(pVO.getLeader())){ %>
				<li class="nav-item"><a href="project_correction.jsp"
					class="nav-link  p-3 mb-2 sidebar-link">프로젝트 수정</a>
				<li class="nav-item"><a href="project_task_assignment.jsp"
					class="nav-link  p-3 mb-2 sidebar-link  current">Task
						관리</a>
				<%} %>
			</ul>

		</div>
		<!-- 사이드바 끝  -->

		<div class="col-sm-2"></div>
		<div class="col-sm-10 ml-auto py-4">
			<!-- 화면 -->
			<!-- 프로젝트 생성창 -->
			<h3 class="text-center">업무 추가</h3>
			<hr>
			<div class="center-block">
				<form action="addTask.jsp" method="post" class="form-horizontal">
					<div class="form-group row">
						<label class="col-md-2 control-label title">업무명</label>
						<div class="col-md-10">
							<input type="text" class="form-control title"
								name = "taskName" placeholder="새 업무 명...">
						</div>
					</div>
					<div class="form-group row">
						<label class="col-md-2 control-label title">업무 내용</label>
						<div class="col-md-10">
							<textarea class="form-control" rows="17"
								name = "taskContent" placeholder="담당자가 수행해야 할 업무의 내용을 적어주세요..."></textarea>
						</div>
					</div>
					<div class="form-group row">
						<label class="col-md-2 control-label title">담당자</label>
						<div class="col-md-10">
							<select name="worker" class="form-control title">
								<option value="option0">===담당자 설정===</option>
								<%
									for(int i = 0; i < members.size(); i++){
								%>
								<option value=<%=members.get(i).getUserId()%>><%=members.get(i).getUserId()%></option>
								<%} %>
							</select>
						</div>
					</div>

					<div class="form-group row">
						<label class="col-md-2 control-label title">기간 설정</label>
						<div class="col-md-10 row" style="display: flex; justify-content: center;">
							<div class="col-md-3">
								<input type="text" id="from" name="from" class="form-control"
									placeholder="MM/DD/YYYY">
							</div>
							<div class="col-md-2">
								<label> ~ </label>
							</div>
							<div class="col-md-3">
								<input type="text" id="to" name="to" class="form-control"
									placeholder="MM/DD/YYYY">
							</div>
						</div>
					</div>
					<div class="form-group form mt-4">
						<div class="form-group">
							<p class="text-center">
								<button type="submit" class="btn btn-lg">생성</button>
								<button type="reset" class="btn btn-lg">취소</button>
							</p>
						</div>
					</div>
				</form>
			</div>
			<!--  프로젝트 생성창 끝 -->
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