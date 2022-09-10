<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width-device-width, initial-scale=1">
<title>공지사항</title>
<!-- 루트 폴더에 부트스트랩을 참조하는 링크 -->
<link rel="stylesheet" href="css/bootstrap.css">

</head>
<body>
<h4><a href ="my_task.jsp">업무목록</a></h4><hr>
	<!--  게시판 영역 -->
	<div class="active">
		<div class="container">
			<div class="row">
				<table class="table table-hover" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th style="background-color: #eeeeee; text-align: center;">업무</th>
							<th style="background-color: #eeeeee; text-align: center;">시작일</th>
							<th style="background-color: #eeeeee; text-align: center;">마감일</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><a href="Notice_View.jsp">레이아웃 작성</a></td>
							<td>2022-03-00</td>
							<td>2022-04-00</td>
						</tr>
						<tr>
							<td><a href="Notice_View.jsp">타임라인 작성</a></td>
							<td>2022-03-00</td>
							<td>2022-04-00</td>
						</tr>
						<tr>
							<td><a href="Notice_View.jsp">업무목록 작성</a></td>
							<td>2022-03-00</td>
							<td>2022-04-00</td>
						</tr>
						<tr>
							<td><a href="Notice_View.jsp">로그인 구현</a></td>
							<td>2022-03-00</td>
							<td>2022-04-00</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<!-- 부트스트랩 참조 영역 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>