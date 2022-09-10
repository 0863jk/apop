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
<jsp:useBean class="pms.projectDAO" id="projectDAO"></jsp:useBean>
<jsp:useBean class="pms.NoticeDAO" id="notice"></jsp:useBean>
<%
String _id = (String) session.getAttribute("id"); // id 받아오기
String _pid = (String) session.getAttribute("pid");

projectVO pVO = projectDAO.getProject(_pid);

// notice id 받아오기
String noticeId = request.getParameter("noticeid");
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
					class="nav-link  p-3 mb-2 sidebar-link  current">공지사항</a>
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
				<!-- 게시판 글 보기 양식 영역 시작 -->
				<div class="container">
				<h3 class="text-center">공지사항</h3><hr>
					<div class="row">
						<table class="table table-condensed" style="text-align: center; border: 1px solid #dddddd">
							<thead>
								<tr>
									<th colspan="2" style="background-color: #eeeeee; text-align: center;">게시판 글 보기</th>
								</tr>
							</thead>
							<tbody>
<%
List noticeList = notice.selectView(_pid, noticeId);

for(int i = 0; i < noticeList.size(); i ++) {
	NoticeVO vo = (NoticeVO)noticeList.get(i);
	out.println("<tr>");
	out.println("<td style='width: 20%;'>글 제목</td>");
	out.println("<td colspan='2'>"+vo.getTitle()+"</td>");
	out.println("</tr>");
	out.println("<tr>");
	out.println("<td>작성자</td>");
	out.println("<td colspan='2'>"+vo.getUser()+"</td>");
	out.println("</tr>");
	out.println("<tr>");
	out.println("<td>작성일자</td>");
	out.println("<td colspan='2'>"+vo.getDate()+"</td>");
	out.println("</tr>");
	out.println("</tr>");
	out.println("<tr>");
	out.println("<td>내용</td>");
	out.println("<td style='height: 200px; text-align: left;'>"+vo.getContent().replace("\r\n","<br>")+"</td>");
	out.println("</tr>");
}
%>

							</tbody>
						</table>
						<div class="row">
							<a href="project_notice.jsp" class="btn btn-primary col-md-1">목록</a>
<%
if(_id.equals(pVO.getLeader())) {
%>
							<a href="project_notice_edit.jsp?noticeid=<%=noticeId %>" class="btn btn-primary col-md-1">수정</a>
<%
}
%>
							</div>
						
			
						<!-- 해당 글의 작성자가 본인이라면 수정과 삭제가 가능하도록 코드 추가 -->
				 		<%--<%
								if(userID != null && userID.equals(bbs.getUserID())){
							%>
									<a href="update.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">수정</a>
									<a href="deleteAction.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">삭제</a>
							<%
								}
							%> --%>
						</div>
				</div>
				<!-- 게시판 글 보기 양식 영역 끝 -->
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