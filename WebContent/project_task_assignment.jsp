<%@page import="java.io.Console"%>
<%@page import="sun.misc.Signal"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.util.ArrayList"%>
<%@page import="pms.taskDAO"%>
<%@page import="pms.taskVO"%>
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
<!-- ��Ʈ ��ũ -->
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
<title>Insert title here</title>
	<!-- css -->
<link href="css/styles.css" rel="stylesheet"/>
</head>

<body class="container-fluid">
	<jsp:useBean class="pms.taskDAO" id="taskDAO"></jsp:useBean>
	<jsp:useBean class="pms.projectDAO" id="projectDAO"></jsp:useBean>
	<%
		String _id = (String) session.getAttribute("id");
		String _pid = (String) session.getAttribute("pid");
		request.setCharacterEncoding("euc-kr");		
		String _url = request.getQueryString();
		String _signal = "all";
		
		if(_url == null){
			_signal = "all";
		}else{
			_signal = request.getParameter("signal");
		}
		
		projectVO pVO = projectDAO.getProject(_pid);
		int pgPer = Integer.parseInt(pVO.getProgress());

		LocalDate today = LocalDate.now();
		
		//���������̼�
		String strTempPage = request.getParameter("page"); // ���������̼��� ���� ������ �޾ƿ���

		//tempPage int������ ����
		int iTempPage;
		if(strTempPage == null || strTempPage.length() == 0) {
			iTempPage = 1;
		}
		try {
			iTempPage = Integer.parseInt(strTempPage);
		} catch(NumberFormatException e) {
			iTempPage = 1;
		}

		// ��ü �� ��
		int totalRows = taskDAO.getTotalRows(_pid);
		
		// ��ü ������ ��
		int totalPage = 0;
		if(totalRows%10==0) {
			totalPage = totalRows / 10;
		} else {
			totalPage = totalRows / 10 + 1;
		}
		String _keyword = request.getParameter("keyword");
		
		ArrayList<taskVO> taskList;
		if(_keyword == null || _keyword.equals("")) {
			_keyword="";
			taskList = taskDAO.getTaskList(_pid, iTempPage);
		} else {
			taskList = taskDAO.searchTask(_pid, _keyword, iTempPage);
		}
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
				 <img src="uploadImg\<%=_id%>_profileImg.png?" onerror="this.src='img/profile.png'" width="60px" height=60px; class="rounded-circle mr-3">  
				<p>
					<a href="#" class=""><%=_id%></a>
					<p><a href="logout.jsp" class="btn logout" style ="font-size: 15px; border: none;">logout</a>
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
					class="nav-link  p-3 mb-2 sidebar-link">������Ʈ ����</a>
				<li class="nav-item"><a href="project_task_assignment.jsp"
					class="nav-link  p-3 mb-2 sidebar-link  current">Task
						����</a>
				<%} %>
			</ul>

		</div>
		<!-- ���̵�� ��  -->

		<div class="col-sm-2"></div>
		<div class="col-sm-10 ml-auto py-auto my-5">
			<!-- ȭ�� -->
			<!--  �Խ��� ���� -->
			<div class="active">
				<h3 class="text-center">TASK ���� </h3>
				<hr>
				<div class="container">
					<div class="row">
					
						<!-- ��Ʈ -->
						<div class="col-3">
							<div class="card">
								<div class="card-header" style="text-align: center;">
									<a href="project_task_assignment.jsp?signal=green">�������� ����</a>
								</div>
								<div class="card-body">
									<canvas id="dount_chart0" height="250px"></canvas>
								</div>
							</div>
						</div>

						<div class="col-3">
							<div class="card">
								<div class="card-header" style="text-align: center;">
									<a href="project_task_assignment.jsp?signal=blue">�Ϸ�� ����</a>
								</div>
								<div class="card-body">
									<canvas id="dount_chart1" height="250px"></canvas>
								</div>
							</div>
						</div>
						
						<div class="col-3">
							<div class="card">
								<div class="card-header" style="text-align: center;">
									<a href="project_task_assignment.jsp?signal=yellow">�� ������ ����</a>
								</div>
								<div class="card-body">
									<canvas id="dount_chart2" height="250px"></canvas>
								</div>
							</div>
						</div>
						
						<div class="col-3">
							<div class="card">
								<div class="card-header" style="text-align: center;">
									<a href="project_task_assignment.jsp?signal=red">������ ���� ����</a>
								</div>
								<div class="card-body">
									<canvas id="dount_chart3" height="250px"></canvas>
								</div>
							</div>
						</div>
					</div>

					</div>
					<hr>
					<div class="row px-4">
						<div style="display: flex; justify-content: right; padding-bottom: 10px">
							<form action="project_task_assignment.jsp" method="post">
								<input type="text" name="keyword" placeholder="�˻��� �Է�" value="<%=_keyword%>">
								<input type="submit" value="�˻�">
							</form>
						</div>
						<table class="table table-hover"
							style="text-align: center; border: 1px solid #dddddd">
							<thead>
								<tr>
									<th style="background-color: #eeeeee; text-align: center;"
										width="2%"></th>
									<th style="background-color: #eeeeee; text-align: center;"
										width="35%">���� �̸�</th>
									<th style="background-color: #eeeeee; text-align: center;"
										width="35%">����</th>
									<th style="background-color: #eeeeee; text-align: center;"
										width="15%">�����</th>
									<th style="background-color: #eeeeee; text-align: center;"
										width="10%">��ô��</th>
									<th style="background-color: #eeeeee; text-align: center;"
										width="3%"><a href="project_add_task.jsp"><button
												type="button" id="img_btn" style="">+</button></a></th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<%
										for (int i = 0; i < taskList.size(); i++) {
											if(_signal.equals("all")){
											
									%>
									<td width="1%"><img
										src="img/<%=taskList.get(i).getColor()%>signal.png"
										class="rounded-circle" style="width: 15px"></td>
									<td class="project-name">
										<ul class="list-unstyled">
											<a
												href="my_task_detail.jsp?taskid=<%=taskList.get(i).getTaskId()%>&progress=<%=taskList.get(i).getProgress()%>"><li
												class="text-left"><%=taskList.get(i).getTaskName()%></li></a>
											<ul>
												<li><div
														style="height: 45px; overflow: hidden; text-overflow: ellipsis;"><%=taskList.get(i).getTaskContent()%></div></li>
											</ul>
										</ul>
									</td>
									<td><%=taskList.get(i).getStartDate()%> ~ <%=taskList.get(i).getDeadline()%></td>
									<td><%=taskList.get(i).getWorker()%></td>
									<td><b><%=taskList.get(i).getProgress()%>%</b></td>
									<td><a
										href="project_edit_task?tid=<%=taskList.get(i).getTaskId()%>.jsp"><button
												type="button" id="img_btn" style="height: 20px; width: 20px">
												<img src="img/edit.png" width="10px" style="border: none;">
											</button></a></td>
								</tr>
								<%
									}else{
										if(taskList.get(i).getColor().equals(_signal)){
								%>
								<td width="1%"><img
										src="img/<%=taskList.get(i).getColor()%>signal.png"
										class="rounded-circle" style="width: 15px"></td>
									<td class="project-name">
										<ul class="list-unstyled">
											<a
												href="my_task_detail.jsp?taskid=<%=taskList.get(i).getTaskId()%>&progress=<%=taskList.get(i).getProgress()%>"><li
												class="text-left"><%=taskList.get(i).getTaskName()%></li></a>
											<ul>
												<li><div
														style="height: 45px; overflow: hidden; text-overflow: ellipsis;"><%=taskList.get(i).getTaskContent()%></div></li>
											</ul>
										</ul>
									</td>
									<td><%=taskList.get(i).getStartDate()%> ~ <%=taskList.get(i).getDeadline()%></td>
									<td><%=taskList.get(i).getWorker()%></td>
									<td><b><%=taskList.get(i).getProgress()%>%</b></td>
									<td><a
										href="project_edit_task?tid=<%=taskList.get(i).getTaskId()%>.jsp"><button
												type="button" id="img_btn" style="height: 20px; width: 20px">
												<img src="img/edit.png" width="10px" style="border: none;">
											</button></a></td>
								</tr>
								
								<%
										}
									}
								}
								%>

							</tbody>
						</table>
				</div>
			</div>
			<!--  �Խ��� ���� �� -->
			<div style="display: flex; justify-content: center;">

				<label class="text-center">
<%
if(iTempPage > 1) {
	int prePage = iTempPage - 1;
	out.println("<a class='btn btn-default' href='project_task_assignment.jsp?page="+prePage+"&signal="+_signal+"' role='button'>Previous</a>");
}
for(int i = 0; i < totalPage; i++) {
	int pageNum = i + 1;
	out.println("<a class='btn btn-default' href='project_task_assignment.jsp?page="+pageNum+"&signal="+_signal+"' role='button'>"+pageNum+"</a>");
}
if(iTempPage < totalPage) {
	int nextPage = iTempPage + 1;
	out.println("<a class='btn btn-default' href='project_task_assignment.jsp?page="+nextPage+"&signal="+_signal+"' role'=button'>Next</a>");
}
%>
				</label>
			</div>
		</div>
	</div>
	<!-- body �� -->

	<!-- Optional JavaScript; choose one of the two! -->

	<!-- Option 1: Bootstrap Bundle with Popper -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous"></script>
	
	<%
		int cnt = taskList.size();
		int blueCnt = taskDAO.colorCount(_pid, "blue");
		int yellowCnt = taskDAO.colorCount(_pid, "yellow");
		int redCnt = taskDAO.colorCount(_pid, "red");
		int greenCnt = taskDAO.colorCount(_pid, "green");
	%>

	<script>
		var donutOptions = { cutoutPercentage: 45, //���ӵβ� : ���� Ŭ���� ����� 
				legend: {
					position:'bottom', 
					padding:5, 
					labels: {pointStyle:'circle', usePointStyle:true}} 
		};
		
		//��Ʈ 0(�������� ����)
		var dountChartData0 = { labels: ['progressing', 'All'], 
							datasets: [ 
								{ backgroundColor: ['green'],
								  borderWidth: 0, 
								  data: [<%=greenCnt%>, <%=cnt%>] 
								} 
							] 
		};
		var dount_chart0 = document.getElementById("dount_chart0"); 
			if (dount_chart0) { 
				new Chart(dount_chart0, { type: 'pie', data: dountChartData0, options: donutOptions }); 
			}
			
		
		//��Ʈ 1(�Ϸ�� ����)
		var dountChartData1 = { labels: ['Completed', 'All'], 
							datasets: [ 
								{ backgroundColor: ['#00A2E8'],
								  borderWidth: 0, 
								  data: [<%=blueCnt%>, <%=cnt%>] 
								} 
							] 
		};
		var dount_chart1 = document.getElementById("dount_chart1"); 
			if (dount_chart1) { 
				new Chart(dount_chart1, { type: 'pie', data: dountChartData1, options: donutOptions }); 
			}
		
		//��Ʈ2(�Ⱓ�� �󸶳��� ����)
		var dountChartData2 = { labels: ['Not long', 'All'], 
					datasets: [ 
						{ backgroundColor: ['orange'],
						  borderWidth: 0, 
						  data: [<%=yellowCnt%>, <%=cnt%>] 
						} 
					] 
		};
		var dount_chart2 = document.getElementById("dount_chart2"); 
		if (dount_chart2) { 
			new Chart(dount_chart2, { type: 'pie', data: dountChartData2, options: donutOptions }); 
	}
		
		//��Ʈ3(�Ⱓ�� ����)
		var dount_chart2 = document.getElementById("dount_chart3"); 
			if (dount_chart3) { 
				new Chart(dount_chart2, { type: 'pie', data: dountChartData2, options: donutOptions }); 
			}
			
			var dountChartData3 = { labels: ['Time over', 'All'], 
					datasets: [ 
						{ backgroundColor: ['red'],
						  borderWidth: 0, 
						  data: [<%=redCnt%>, <%=cnt%>] 
						} 
					] 
		};
		var dount_chart3 = document.getElementById("dount_chart3"); 
			if (dount_chart3) { 
				new Chart(dount_chart3, { type: 'pie', data: dountChartData3, options: donutOptions }); 
		}



	</script>

	<!-- Option 2: Separate Popper and Bootstrap JS -->
	<!--
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script>
    -->
</body>
</html>