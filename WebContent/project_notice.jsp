<%@page import="pms.NoticeVO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"
	import="java.sql.*"
	import="java.util.*,pms.*"%>
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
<jsp:useBean class="pms.NoticeDAO" id="notice"></jsp:useBean>
<jsp:useBean class="pms.projectDAO" id="projectDAO"></jsp:useBean>
<%
String _id = (String) session.getAttribute("id");
String _pid = (String) session.getAttribute("pid");

projectVO pVO = projectDAO.getProject(_pid);

//페이지네이션
String strTempPage = request.getParameter("page"); // 페이지네이션을 위한 페이지 받아오기

//tempPage int형으로 저장
int iTempPage;
if(strTempPage == null || strTempPage.length() == 0) {
	iTempPage = 1;
}
try {
	iTempPage = Integer.parseInt(strTempPage);
} catch(NumberFormatException e) {
	iTempPage = 1;
}

// 전체 글 수
int totalRows = notice.getTotalRows(_pid);
// 전체 페이지 수
int totalPage = 0;
if(totalRows%10==0) {
	totalPage = totalRows / 10;
} else {
	totalPage = totalRows / 10 + 1;
}
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
					class="nav-link  p-3 mb-2 sidebar-link">프로젝트</a>
				<li class="nav-item"><a href="project_notice.jsp"
					class="nav-link  p-3 mb-2 sidebar-link current">공지사항</a>
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
					class="nav-link  p-3 mb-2 sidebar-link">Task
						관리</a>
				<%} %>
			</ul>

		</div>
		<!-- 사이드바 끝  -->

		<div class="col-sm-2">	</div>
			<div class="col-sm-10 ml-auto py-4">
				<!-- 화면 -->
				<!--  게시판 영역 -->
				<div>
				<h3 class="text-center">공지사항</h3><hr>
				<!-- 총 공지사항 수, 총 페이지 수 정보 -->
				<div class="row">
					<div class="col-md-6" style="display: flex; justify-content: left;">
						<label class="text-left">총 공지사항 수: <%=totalRows %></label>
					</div>
					<div class="col-md-6" style="display: flex; justify-content: right;">
						<label class="text-right">총 페이지 수: <%= iTempPage%>/<%=totalPage %></label>
					</div>
				</div>
					<div class="container">
						<div class="row">
							<table class="table table-hover" style="text-align: center; border: 1px solid #dddddd">
								<thead>
									<tr>
										<th style="background-color: #eeeeee; text-align: center;">#</th>
										<th style="background-color: #eeeeee; text-align: center;">글제목</th>
										<th style="background-color: #eeeeee; text-align: center;">작성일</th>
										<th style="background-color: #eeeeee; text-align: center;">작성자</th>
									</tr>
								</thead>
								<tbody>
<%
List noticeList = notice.select(_pid, iTempPage);

for(int i = 0; i < noticeList.size(); i ++) {
	NoticeVO vo = (NoticeVO)noticeList.get(i);
	out.println("<tr>");
	out.println("<td>"+vo.getNid()+"</td>");
	out.println("<td><a class=\"notice-name\" href='project_notice_view.jsp?noticeid="+vo.getNid()+"'>"+vo.getTitle()+"</td>");
	out.println("<td>"+vo.getDate()+"</td>");
	out.println("<td>"+vo.getUser()+"</td>");
	out.println("</tr>");
}
out.println("</table>");
%>
<div style="display: flex; justify-content: center;">

<label class="text-center">
<%
if(iTempPage > 1) {
	int prePage = iTempPage - 1;
	out.println("<a class='btn btn-default' href='project_notice.jsp?page="+prePage+"' role='button'>Previous</a>");
}
for(int i = 0; i < totalPage; i++) {
	int pageNum = i + 1;
	out.println("<a class='btn btn-default' href='project_notice.jsp?page="+pageNum+"' role='button'>"+pageNum+"</a>");
}
if(iTempPage < totalPage) {
	int nextPage = iTempPage + 1;
	out.println("<a class='btn btn-default' href='project_notice.jsp?page="+nextPage+"' role='button'>Next</a>");
}
%>
</label>
				</div>
<%
if(_id.equals(pVO.getLeader())) {
%>

								<a href="project_notice_write.jsp" class="pull-right btn col-md-1">글쓰기</a>
<%
}
%>
						</div>
					</div>
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