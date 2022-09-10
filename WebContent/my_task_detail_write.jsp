<%@page import="pms.projectVO"%>
<%@page import="pms.taskVO"%>
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
	
<!-- css -->
<link href="css/styles.css" rel="stylesheet"/>
<title>Insert title here</title>
</head>


<body class="container-fluid">
<jsp:useBean class="pms.projectDAO" id="projectDAO"></jsp:useBean>
<jsp:useBean class="pms.taskDAO" id="taskDAO"></jsp:useBean>
<%
String _id = (String) session.getAttribute("id");
String _pid = (String)session.getAttribute("pid");
String taskId = request.getParameter("taskid");


projectVO pVO = projectDAO.getProject(_pid);
taskVO tVO = taskDAO.getTask(taskId);
int _progress = tVO.getProgress();
String work = null;
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
					class="nav-link  p-3 mb-2 sidebar-link current">���� Task</a>
				<%if(_id.equals(pVO.getLeader())){ %>
				<li class="nav-item"><a href="project_correction.jsp"
					class="nav-link  p-3 mb-2 sidebar-link">������Ʈ ����</a>
				<li class="nav-item"><a href="project_task_assignment.jsp"
					class="nav-link  p-3 mb-2 sidebar-link">Task
						����</a>
				<%} %>
			</ul>

		</div>
		<!-- ���̵�� ��  -->

		<div class="col-sm-2">	</div>
			<div class="col-sm-10 ml-auto py-auto pl-2">

				<!-- ȭ�� -->
	<!-- �������� �ۼ�â -->
	<div>
	<br>
	<h3 class="text-center">���� ���� �ۼ�</h3><hr>
	<!-- �۾���â -->
	<div class="active">
		<form action="task_detail_write.jsp?tid=<%=taskId%>" method="post">
			<div class="form-group">
				<input type="text" class="form-control" id="title" name ="title" placeholder="����">
			</div>
			<div class="form-group">
				<input type="text" class="form-control" id="progress" name = "progress" placeholder="��ô�� �ۼ�" value="<%=_progress %>">
			</div>
			<div class="form-group">
				<textarea class="form-control content" id="content" rows="17" name ="work" placeholder="���� �ۼ�..."></textarea>
			</div>
			<div class="form-group mt-3">
				<p class="text-center">
					<button type="submit" onclick="submitContents(this);" class="btn btn-default">����</button>
					<button type="reset" class="btn btn-default">���</button>
				</p>
			</div>
		</form>
	</div>
</div>
<!-- �������� �ۼ�â �� -->

			</div>
		</div>
	<!-- body �� -->
	
	<!-- Smart Editor -->
<script type="text/javascript" src="se2/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="se2/photo_uploader/plugin/hp_SE2M_AttachQuickPhoto.js" charset="utf-8"></script>

<script type="text/javascript">
  var oEditors = [];
  nhn.husky.EZCreator.createInIFrame({
  oAppRef: oEditors,
  elPlaceHolder: "content",
  sSkinURI: "se2/SmartEditor2Skin.html",
  fCreator: "createSEditor2",
  htParams: { fOnBeforeUnload : function(){}}
  });

  //�����塯 ��ư�� ������ �� ������ ���� �׼��� ���� �� submitContents�� ȣ��ȴٰ� �����Ѵ�.
  function submitContents(elClickedObj) {
  // �������� ������ textarea�� ����ȴ�.
  oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", [ ]);
  document.getElementById("form").submit();
  // �������� ���뿡 ���� �� ������ �̰�����
  // document.getElementById("textAreaContent").value�� �̿��ؼ� ó���Ѵ�.

  try {
  elClickedObj.form.submit();
  } catch(e) {

  }
  }

  // textArea�� �̹��� ÷��
  function pasteHTML(filepath){
  var sHTML = '<img src="<%=request.getContextPath()%>/uploadFolder/'+filepath+'">';
  oEditors.getById["content"].exec("PASTE_HTML", [sHTML]);
  }
</script>

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