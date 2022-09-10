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

<title>Project Manager</title>
</head>
<style>
* {
	margin: 0;
	padiing: 0;
}

.logo {
	background: rgb(71,71,71);
	background: linear-gradient(270deg, rgba(71,71,71,1) 0%, rgba(19,17,17,1) 100%);
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
}

.login-container {
	background: white;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
}

.login-form {
	width: 400px;
	padding-top: 30px;
	padding-bottom: 30px;
	padding-left: 10px;
	padding-right: 10px;
}

.btn {
	background: #5e6874;
}
</style>

<body class="container-fluid">
	<div class="row">
		<!-- 좌측화면(로고) -->
		<div class="col-md-5 logo text-center">
			<img src="img\logowhite.png" width="400px" height="300px">
		</div>



		<!-- 우측화면(로그인폼) -->
		<div class="col-md-7 login-container text-center">
			<div class="login-form">
				<form action="login_check.jsp" method="post">
					<div class="form-group">
						<label><h1>ID</h1></label> <input type="text" name="id"
							class="form-control" placeholder="id">
					</div>
					<div class="form-group">
						<label><h1>Password</h1></label> <input type="password" name="password"
							class="form-control" placeholder="Password">
					</div>

					<input type="submit" class="btn btn-lg mt-3 mb-4" value="Login">
					<p>Project Manager가 처음이신가요?
					<p>
						<a href="resister.jsp" class="btn btn-lg">Resister</a>
				</form>
			</div>
		</div>

	</div>







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