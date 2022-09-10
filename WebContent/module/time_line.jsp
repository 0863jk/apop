<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<style>
.timeline-wrapper {
	width: max-content;
	position: relative;
	margin: auto;
	padding-left: 90px;
	padding-top: 15px;
	padding-bottom: 15px;
	height: 100%;
	overflow-y: hidden;
	display: flex;
}
.timeline-wrapper::-webkit-scrollbar {
	display: none;
}
.timeline-wrapper .middle-line {
	position: absolute;
	width: 100%;
	height: 5px;
	top: 50%;
	transform: translateY(-50%);
	background: #d9d9d9;
	height: 5px;
}

.box {
	width: 150px;
	position: relative;
	min-height: 300px;
	margin-right: 10px;
	float: left;
	flex: 0 0 auto;
	display: inline-block;
}

.box .date {
	position: absolute;
	top: 50%;
	left: 0px;
	transform: translateY(-50%);
	width: 50px;
	height: 50px;
	border-radius: 100%;
	background: #fff;
	border: 2px solid #d9d9d9;
}

.date p {
	text-align: center;
	margin-top: 0px;
	margin-bottom: 0px;
}

.box .box-content {
	border-radius: 5px;
	background-color: #5e6874;
	width: 180px;
	position: absolute;
	left: -77px;
	padding: 15px;
}

.box-content p {
	margin: 0;
	color: white;
}

.box-bottom .box-content {
	top: 65%;
}

.box-content::before {
	content: " ";
	position: absolute;
	left: 50%;
	transform: translateX(-50%);
	border: 10px solid transparent;
}

.box-bottom .box-content::before {
	border-bottom-color: #5e6874;
	top: -20px;
}

.box-top .box-content::before {
	border-top-color: #5e6874;
	bottom: -20px;
}
</style>
<body>
	<section class="timeline-wrapper">
		<div class="middle-line"></div>
			<div class="box box-top box-start">
				<div class="date">
					<p>02</p>
					<p>march</p>
				</div>
				<div class="box-content">
					<p>캡스톤디자인 1주차 : 아이디어 도출 및 개략제안서 작성</p>
				</div>
			</div>

			<div class="box box-bottom">
				<div class="date">
					<p>09</p>
					<p>march</p>
				</div>
				<div class="box-content">
					<p>캡스톤디자인 2주차 : 개략제안서 피드백 및 상세제안서 작성</p>
				</div>
			</div>

			<div class="box box-top">
				<div class="date">
					<p>02</p>
					<p>march</p>
				</div>
				<div class="box-content">
					<p>캡스톤디자인 1주차 : 아이디어 도출 및 개략제안서 작성</p>
				</div>
			</div>

			<div class="box box-bottom">
				<div class="date">
					<p>09</p>
					<p>march</p>
				</div>
				<div class="box-content">
					<p>캡스톤디자인 2주차 : 개략제안서 피드백 및 상세제안서 작성</p>
				</div>
			</div>
			<div class="box box-top">
				<div class="date">
					<p>02</p>
					<p>march</p>
				</div>
				<div class="box-content">
					<p>캡스톤디자인 1주차 : 아이디어 도출 및 개략제안서 작성</p>
				</div>
			</div>

			<div class="box box-bottom">
				<div class="date">
					<p>09</p>
					<p>march</p>
				</div>
				<div class="box-content">
					<p>캡스톤디자인 2주차 : 개략제안서 피드백 및 상세제안서 작성</p>
				</div>
			</div>

			<div class="box box-top">
				<div class="date">
					<p>02</p>
					<p>march</p>
				</div>
				<div class="box-content">
					<p>캡스톤디자인 1주차 : 아이디어 도출 및 개략제안서 작성</p>
				</div>
			</div>

			<div class="box box-bottom">
				<div class="date">
					<p>09</p>
					<p>march</p>
				</div>
				<div class="box-content">
					<p>캡스톤디자인 2주차 : 개략제안서 피드백 및 상세제안서 작성</p>
				</div>
			</div>

			<div class="box box-top">
				<div class="date">
					<p>02</p>
					<p>march</p>
				</div>
				<div class="box-content">
					<p>캡스톤디자인 1주차 : 아이디어 도출 및 개략제안서 작성</p>
				</div>
			</div>

			<div class="box box-bottom">
				<div class="date">
					<p>09</p>
					<p>march</p>
				</div>
				<div class="box-content">
					<p>캡스톤디자인 2주차 : 개략제안서 피드백 및 상세제안서 작성</p>
				</div>
			</div>
			<div class="box box-top">
				<div class="date">
					<p>02</p>
					<p>march</p>
				</div>
				<div class="box-content">
					<p>캡스톤디자인 1주차 : 아이디어 도출 및 개략제안서 작성</p>
				</div>
			</div>

			<div class="box box-bottom">
				<div class="date">
					<p>09</p>
					<p>march</p>
				</div>
				<div class="box-content">
					<p>캡스톤디자인 2주차 : 개략제안서 피드백 및 상세제안서 작성</p>
				</div>
			</div>
	</section>
</body>
</html>