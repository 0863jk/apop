<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">

<title>Insert title here</title>
</head>
<style>
* {
	margin: 0;
	padding: 0;
}

.card {
	width: 400px;
	height: 450px;
	padding-top: 10px;
	border: 2px solid black;
	display: flex;
	justify-content: center;
}

.profile-img img {
	border-radius: 50%;
}

.name {
	font-size: 22px;
}
</style>
<body>
<%
	String _id = request.getParameter("memberid");

%>
	<div class="card">
		<div class="card-body">
			<div
				class="profile-img d-flex justify-content-center align-items-center mb-3 ">
				<img src="img\profile.png" height="100px" width="100px">
			</div>
			<div
				class="profile-info d-flex flex-column justify-content-center align-items-center">
				<span class="name">테스트 이름</span> <span class="email mt-1">@<%= _id %></span> <span class="email mt-1">테스트 이메일 @ email.com </span>
			</div>
			<div class="task mt-4 d-flex flex-column">
				<p class="task-item">task1
				<p class="task-item">task2
				<p class="task-item">task3
				<p class="task-item">taks4
			</div>
		</div>
		<a href="project_member_detail.jsp?id=<%= _id%>" class="stretched-link"></a>
	</div>

</body>
</html>