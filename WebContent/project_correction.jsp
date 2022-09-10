<%@page import="pms.projectVO"%>
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
		var dateFormat = "yy-mm-dd", from = $("#from").datepicker({
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
<!-- ����Ʈ��Ŀ ���� �� -->
<%
	String _id = (String) session.getAttribute("id");
	String _pid = (String) session.getAttribute("pid");
%>
<body class="container-fluid">
<jsp:useBean class="pms.projectDAO" id="proejctDAO"></jsp:useBean>
<%
	projectVO pVO = proejctDAO.getProject(_pid);
	
	String _name = pVO.getName();
	String _summary = pVO.getSummary();
	String _pw = pVO.getPw();
	String _class = pVO.getClassification();
	String _from = pVO.getCreatDate();
	_from = _from.substring(5,7) + "/" +_from.substring(8,10) + "/"+_from.substring(0,4);
	String _to = pVO.getDeadline();
	_to = _to.substring(5,7) + "/" +_to.substring(8,10) + "/"+_to.substring(0,4);
%>
	<div class="row">
		<!-- ���̵�� -->
		<div class="col-sm-2 sidebar">

			<!-- Ÿ��Ʋ  -->
			<a href="project_list.jsp"
				class="navbar-brand d-block mx-auto py-3 mb-4 bottom-border"> <img
				src="img\logowhite.png" width="100%" height="150px"></a>

			<!-- ������  -->
			<div class="bottom-border text-center">
				<img src="uploadImg\<%=_id%>_profileImg.png?id=<%=_id%>" onerror="this.src='img/profile.png'" width="60px" height=60px; class="rounded-circle mr-3">
				<p><a href="profile_inquiry.jsp" class="profile-text"><%=_id%></a>
				<p><a href="logout.jsp" class="btn logout" style ="font-size: 15px; border: none;">logout</a></p>
			</div>

			<!-- ������ ��� -->
			<ul class="navbar-nav flex-cloumn mt-4">
				<li class="nav-item"><a href="project_main.jsp"
					class="nav-link  p-3 mb-2 sidebar-link">
						������Ʈ</a>
				<li class="nav-item"><a href="project_notice.jsp"
					class="nav-link  p-3 mb-2 sidebar-link">��������</a>
				<li class="nav-item"><a href="project_timeline.jsp"
					class="nav-link  p-3 mb-2 sidebar-link">Ÿ�Ӷ���</a>
				<li class="nav-item"><a href="project_member_inquiry.jsp"
					class="nav-link  p-3 mb-2 sidebar-link">������ ��ȸ</a>
				<li class="nav-item"><a href="my_task.jsp"
					class="nav-link  p-3 mb-2 sidebar-link">���� Task</a>
				<%if(_id.equals(pVO.getLeader())){ %>
				<li class="nav-item"><a href="project_correction.jsp"
					class="nav-link  p-3 mb-2 sidebar-link  current">������Ʈ ����</a>
				<li class="nav-item"><a href="project_task_assignment.jsp"
					class="nav-link  p-3 mb-2 sidebar-link">Task
						����</a>
				<%} %>
			</ul>

		</div>
		<!-- ���̵�� ��  -->

		<div class="col-sm-2">	</div>
			<div class="col-sm-10 ml-auto py-4">
			<!-- ȭ�� -->
			<!-- ������Ʈ ����â -->
			<h3 class="text-center">������Ʈ ����</h3>
			<hr>
			<div class="center-block">
				<form action="modifyProject.jsp" method="post" class="form-horizontal" enctype="multipart/form-data">
					<div class="form-group row">
						<div style="display: flex; justify-content: center; margin-bottom: 20px;">
						<input type="file" id="upload" name="upload" accept="image/*" onchange="previewImg(this)" style ="display: none;">
						<button type="button" class="imgBtn" id="imgBtn" style="border:none; background: none;"><img src="uploadImg/<%=_pid%>_thumnail.png?>" onerror="this.src='img/none-image.png'" id="thumnail" style="width: 400px; height: 200px"></button>
						</div>
					</div>
					<div class="form-group row">
						<div style="display: flex; justify-content: center;">
							<label class="text-center">������Ʈ �̸�</label>
						</div>
						<div style="display: flex; justify-content: center;">
							<div class="form-inline" style="width:800px;"><input type="text" name="pname" class="form-control" placeholder="�� ������Ʈ��..." value="<%= _name%>"></div>
						</div>
					</div>
					<br>
					<div class="form-group row">
						<div style="display: flex; justify-content: center;">
							<label class="text-center">������Ʈ �з�</label>
						</div>
						<div style="display: flex; justify-content: center;">
							<div class="form-inline" style="width:800px;">
<%
String select = null;
if(_class.equals("�̺з�")) {
	
%>
								<select class="form-control title" name ="classification">
								<option value="�̺з�" selected="selected">�̺з�</option>
								<option value="�� ������Ʈ">�� ������Ʈ</option>
								<option value="�븶�� ������Ʈ">�븶�� ������Ʈ</option>
								<option value="��ŸƮ�� ������Ʈ">��ŸƮ�� ������Ʈ</option>
							</select>
<%} else if(_class.equals("�� ������Ʈ")) { %>
								<select class="form-control title" name ="classification">
								<option value="�̺з�">�̺з�</option>
								<option value="�� ������Ʈ" selected="selected">�� ������Ʈ</option>
								<option value="�븶�� ������Ʈ">�븶�� ������Ʈ</option>
								<option value="��ŸƮ�� ������Ʈ">��ŸƮ�� ������Ʈ</option>
							</select>
<%} else if(_class.equals("�븶�� ������Ʈ")) {%>
								<select class="form-control title" name ="classification">
								<option value="�̺з�">�̺з�</option>
								<option value="�� ������Ʈ">�� ������Ʈ</option>
								<option value="�븶�� ������Ʈ" selected="selected">�븶�� ������Ʈ</option>
								<option value="��ŸƮ�� ������Ʈ">��ŸƮ�� ������Ʈ</option>
							</select>
<%} else if(_class.equals("��ŸƮ�� ������Ʈ")) {%>
								<select class="form-control title" name ="classification">
								<option value="�̺з�">�̺з�</option>
								<option value="�� ������Ʈ">�� ������Ʈ</option>
								<option value="�븶�� ������Ʈ">�븶�� ������Ʈ</option>
								<option value="��ŸƮ�� ������Ʈ" selected="selected">��ŸƮ�� ������Ʈ</option>
							</select>
<%}%>
							</div>
						</div>
					</div>
					<br>
					<div class="form-group row">
						<div style="display: flex; justify-content: center;">
							<label class="text-center">����</label>
						</div>
						<div style="display: flex; justify-content: center;">
							<div class="form-inline" style="width:800px;"><textarea class="form-control" name="summary" rows="5" placeholder="���� �ۼ�..."><%=_summary %></textarea></div>
						</div>
					</div>
					<br>
					<div class="form-group row">
						<div style="display: flex; justify-content: center;">
								<label class="text-center">��й�ȣ</label>
							</div>
							<div style="display: flex; justify-content: center;">
								<div class="form-inline" style="width:300px;"><input type="text" name = "password" class="form-control" placeholder="��й�ȣ" value="<%= _pw%>"></div>
							</div>
					</div>
					<br>
					<div class="form-group row">
						<div style="display: flex; justify-content: center;">
							<label class="text-center">�Ⱓ ����</label>
						</div>
						<div style="display: flex; justify-content: center;">
							<div class="form-inline row" style="width:415px;">
								<table>
									<tr>
									<td><div style="width:200px;"><input type="text" id="from" name="from" class="form-control" placeholder="MM/DD/YYYY" value="<%= _from%>"></div></td>
									<td><div style="width:15px;"><label> ~ </label></div></td>
									<td><div style="width:200px;"><input type="text" id="to" name="to" class="form-control" placeholder="MM/DD/YYYY" value="<%= _to%>"></div></td>
									</tr>
								</table>
							</div>
						</div>
					</div>
					<br>
					<br>
					<div class="form-group form">
						<div class="form-group">
							<p class="text-center">
								<button type="submit" class="btn btn-primary btn-lg submit">����</button>
								<button type="reset" class="btn btn-primary btn-lg">���</button>
								<a href="project_delete_ui.jsp" class="btn btn-primary btn-lg">����</a>
							</p>
						</div>
					</div>
				</form>
			</div>
		<!--  ������Ʈ ����â �� -->

			</div>
		</div>
		
<script>
function previewImg(input){
	if(input.files && input.files[0]){
		var reader = new FileReader();
		reader.onload = function(e){
			document.getElementById("thumnail").src = e.target.result;
		};
		reader.readAsDataURL(input.files[0]);
	}
}


const upload = document.getElementById("upload");
const imgBtn = document.getElementById("imgBtn");

imgBtn.addEventListener('click', () => upload.click());
</script>
	<!-- body �� -->

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