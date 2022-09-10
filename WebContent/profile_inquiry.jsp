<%@page import="pms.projectVO"%>
<%@page import="pms.projectListVO"%>
<%@page import="java.util.List"%>
<%@page import="pms.userVO"%>
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
<title>Insert title here</title>
<!-- css -->
<link href="css/styles.css" rel="stylesheet"/>
</head>
<%
	String _id = (String) session.getAttribute("id");
%>


<body class="container-fluid">
<jsp:useBean class="pms.userDAO" id="user"></jsp:useBean>

<%
List profileList = user.viewProfile(_id);
userVO vo = (userVO)profileList.get(0);

String name = vo.getName();
String pw = vo.getPassword();
String phone = vo.getPhone();
String email = vo.getEmail();
String occupation = "1";
//String occupation = vo.getJob();
String department = vo.getBelong();

profileList.clear();

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
				 <img src="uploadImg\<%=_id%>_profileImg.png?id=<%=_id%>" onerror="this.src='img/profile.png'" width="60px" height=60px; class="rounded-circle mr-3">  
				<p><a href="profile_inquiry.jsp" class="profile-text"><%=_id%></a>
				<p><a href="logout.jsp" class="btn logout" style ="font-size: 15px; border: none;">logout</a></p>
			</div>

			<!-- 아이템 목록 -->
			<ul class="navbar-nav flex-cloumn mt-4">
				<li class="nav-item"><a href="project_list.jsp"
					class="nav-link  p-3 mb-2 sidebar-link">프로젝트 목록</a>
				<li class="nav-item"><a href="#"
					class="nav-link  p-3 mb-2 sidebar-link">지난
						프로젝트</a>
				<li class="nav-item"><a href="new_project.jsp"
					class="nav-link  p-3 mb-2 sidebar-link">새 프로젝트</a>
			</ul>

		</div>
		<!-- 사이드바 끝  -->

		<div class="col-sm-2"></div>
		<div class="col-sm-10 ml-auto py-2">
			<!-- 화면 -->
			<br>
			<h3 class="text-center">프로필 <a href="profile_modify.jsp"><img src="img/edit.png" width="15px" height="15px"></a></h3>
			<hr>
			
			<!-- 프로필 -->
			<div>
				<div style="display: flex; justify-content: center;">
					<a href=""><img src="uploadImg\<%=_id%>_profileImg.png?id=<%=_id%>" onerror="this.src='img/profile.png'" class="rounded-circle" style="width:350px; height:350px; padding:20px"></a>
				</div>
				<br>
				<div style="display: flex; justify-content: center;">
					<label class="text-center">NAME</label>
				</div>
				<div style="display: flex; justify-content: center;">
					<div class="form-inline" style="width:300px;"><input type="text" class="form-control" disabled value=<%=name %>></div>
				</div>
				<br>
				<div style="display: flex; justify-content: center;">
					<label class="text-center">PASSWORD</label>
				</div>
				<div style="display: flex; justify-content: center;">
					<div class="form-inline" style="width:300px;"><input type="password" class="form-control" disabled></div>
				</div>
				<br>
				<div style="display: flex; justify-content: center;">
					<label class="text-center">PHONE</label>
				</div>
				<div style="display: flex; justify-content: center;">
					<div class="form-inline" style="width:300px;"><input type="text" class="form-control" value=<%=phone %> disabled></div>
				</div>
				<br>
				<div style="display: flex; justify-content: center;">
					<label class="text-center">E-MAIL</label>
				</div>
				<div style="display: flex; justify-content: center;">
					<div class="form-inline" style="width:300px;"><input type="text" class="form-control" value=<%=email %> disabled></div>
				</div>
				<br>
				<div style="display: flex; justify-content: center;">
					<label class="text-center">JOB</label>
				</div>
				<div style="display: flex; justify-content: center;">
					<div class="form-inline" style="width:300px;">
						<select class="form-control" disabled>
<%
int iOccupation = 0;
iOccupation = Integer.parseInt(occupation);

if(iOccupation == 0) {
	out.println("<option selected>미선택</option>");
	out.println("<option>개발자</option>");
	out.println("<option>웹 디자이너</option>");
	out.println("<option>학생</option>");
	out.println("<option>기타</option>");
} else if(iOccupation == 1) {
	out.println("<option>미선택</option>");
	out.println("<option selected>개발자</option>");
	out.println("<option>웹 디자이너</option>");
	out.println("<option>학생</option>");
	out.println("<option>기타</option>");
} else if(iOccupation == 1) {
	out.println("<option>미선택</option>");
	out.println("<option>개발자</option>");
	out.println("<option selected>웹 디자이너</option>");
	out.println("<option>학생</option>");
	out.println("<option>기타</option>");
} else if(iOccupation == 1) {
	out.println("<option>미선택</option>");
	out.println("<option>개발자</option>");
	out.println("<option>웹 디자이너</option>");
	out.println("<option selected>학생</option>");
	out.println("<option>기타</option>");
} else if(iOccupation == 1) {
	out.println("<option>미선택</option>");
	out.println("<option>개발자</option>");
	out.println("<option>웹 디자이너</option>");
	out.println("<option>학생</option>");
	out.println("<option selected>기타</option>");
}
%>

						</select>
					</div>
				</div>
				<br>
				<div style="display: flex; justify-content: center;">
					<label class="text-center">DEPARTMENT</label>
				</div>
				<div style="display: flex; justify-content: center;">
					<div class="form-inline" style="width:300px;"><input type="text" class="form-control" value=<%=department %> disabled></div>
				</div>
			</div>
			<br>			
			<br>			
			<br>					
			<br>					
			<br>					
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