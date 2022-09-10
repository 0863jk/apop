<%@page import="com.sun.javafx.css.CalculatedValue"%>
<%@page import="java.sql.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.util.NavigableSet"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.TreeSet"%>
<%@page import="pms.timelineVO"%>
<%@page import="java.util.List"%>
<%@page import="pms.NoticeVO"%>
<%@page import="pms.taskVO"%>
<%@page import="sun.reflect.ReflectionFactory.GetReflectionFactoryAction"%>
<%@page import="pms.memberVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="pms.projectVO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<!-- Required meta tags -->
<meta charset="utf-8">
<!-- <meta name="viewport" content="width=device-width, initial-scale=1"> -->

<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">

<!-- ��Ʈ ��ũ -->
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
<title>Main</title>
	<!-- css -->
<link href="css/styles.css" rel="stylesheet"/>
<link href="css/timeline.css" rel="stylesheet"/>
</head>

<style>
</style>
<jsp:useBean class="pms.projectDAO" id="projectDAO"></jsp:useBean>
<jsp:useBean class="pms.taskDAO" id="taskDAO"></jsp:useBean>
<jsp:useBean class="pms.memberDAO" id="memberDAO"></jsp:useBean>
<jsp:useBean class="pms.NoticeDAO" id="noticeDAO"></jsp:useBean>
<jsp:useBean class="pms.timelineDAO" id="timelineDAO"></jsp:useBean>
<%
	int pgPer = 0;
	String _id = (String) session.getAttribute("id");
	String _pid = (String) request.getParameter("pid");
	if(_pid==null){
		_pid = (String) session.getAttribute("pid");
	}
	
	LocalDate now = LocalDate.now();

	projectVO pVO = projectDAO.getProject(_pid);
	String leader = pVO.getLeader();
	pgPer = Integer.parseInt(pVO.getProgress());
	
	session.setAttribute("pid", _pid);
	
	ArrayList<taskVO> myTaskVO = taskDAO.getTaskList(_pid,_id);
	ArrayList<taskVO> allTaskVO = taskDAO.getTaskList(_pid);
	
	String from = request.getParameter("from");  //yyyy-MM-dd
	String to = request.getParameter("to");		 //yyyy-MM-dd
	
	if(to == null || to.isEmpty()){
		to = now.toString();
	}
	
	if(from == null || from.isEmpty()){
		Date ldate = java.sql.Date.valueOf(now);
		Calendar cal = Calendar.getInstance();
		cal.setTime(ldate);
		from = cal.get(Calendar.YEAR) +"-0" + cal.get(Calendar.MONTH)+"-"+cal.get(Calendar.DATE);
	}
	
	ArrayList<timelineVO> timelineVO = timelineDAO.getTimelineList(_pid,from,to);
	
%>

<body class="container-fluid">
	<div class="row">
		<!-- ���̵�� -->
		<div class="col-2 sidebar">

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
					class="nav-link  p-3 mb-2 sidebar-link">������Ʈ</a>
				<li class="nav-item"><a href="project_notice.jsp"
					class="nav-link  p-3 mb-2 sidebar-link">��������</a>
				<li class="nav-item"><a href="project_timeline.jsp"
					class="nav-link  p-3 mb-2 sidebar-link  current">Ÿ�Ӷ���</a>
				<li class="nav-item"><a href="project_member_inquiry.jsp"
					class="nav-link  p-3 mb-2 sidebar-link">������ ��ȸ</a>
				<li class="nav-item"><a href="my_task.jsp"
					class="nav-link  p-3 mb-2 sidebar-link">���� Task</a>
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

		<div class="col-2"></div>
		<div class="col-10 pl-auto mx-auto mt-2"">
			<div class="row mb-3" style="height: 50px;">
				<label class="table-project-name text-center my-2"><%= pVO.getName() %></label>
			</div>
			<hr>
			<!-- ȭ�� -->
			<!-- Ÿ�Ӷ��� -->
			<div class="col-12 timeline">
			
			
			<!-- �˻�â? ��¥���� or user? -->			
			<div class ="col-12 search-bar">
				<div class ="input-box">
					<form action="project_timeline.jsp" method="get">
						<input type ="text" name="from" value="<%=from%>">~
						<input type ="text" name="to" value="<%=to%>">
						<input type ="submit" value="�˻�">
					</form>
				</div>
			</div>
			
				<div class="row">
					<%
						if(timelineVO.size()>0){
							TreeSet<String> set = new TreeSet<String>();
							for(int i=0; i<timelineVO.size(); i++){
								set.add(timelineVO.get(i).getDate());
							}
							
							for(Iterator i = set.descendingIterator(); i.hasNext();){
								String date = (String)i.next();
					%>
					<div class="d-flex timeline-row">
						<div class="col-2 timline-date">
							<p><%=date%></p>
						</div>
						<div class="col-10 timeline-content">
						<%for(int j =0; j<timelineVO.size();j++){
							if(timelineVO.get(j).getDate().equals(date)){	
						
						
						/*
							������Ʈ ���� : CreateProject
							������Ʈ ���� : EnterProject
							���� �߰� : AddTask
							���� ���� : ApproveTask
							���� ���� : AddTaskDetail
						
						*/
						String type = timelineVO.get(j).getType();
						String who = timelineVO.get(j).getUserId();
						String what = timelineVO.get(j).getTaskId();
						if(type.equals("CreateProject")){
						%>	
							<div class="timeline-item">
								<img src="uploadImg\<%=who%>_profileImg.png" onerror="this.src='img/profile.png'" width="45"
									class="rounded-circle mr-3">
								<div class="timeline-text">
									<h4>������Ʈ ����</h4>
									<p><%=who%>���� ������Ʈ�� �����߽��ϴ�.</p>
								</div>
							</div>
						<%
							}else if(type.equals("EnterProject")){
						%>
							<div class="timeline-item">
								<img src="uploadImg\<%=who%>_profileImg.png" onerror="this.src='img/profile.png'" width="45"
									class="rounded-circle mr-3">
								<div class="timeline-text">
									<h4>��� ����</h4>
									<p><%=who%>���� ������Ʈ�� �����߽��ϴ�.</p>
								</div>
							</div>
						<%
							}else if(type.equals("AddTask")){
						%>
							<div class="timeline-item">
								<img src="uploadImg\<%=who%>_profileImg.png" onerror="this.src='img/profile.png'" width="45"
									class="rounded-circle mr-3">
								<div class="timeline-text">
									<h4>���� �߰�</h4>
									<p><%=who%>�Կ��� <%=taskDAO.getTask(what).getTaskName()%> ������ �߰��Ǿ����ϴ�.</p>
								</div>
							</div>
						<%
							}else if(type.equals("ApproveTask")){
						%>
							<div class="timeline-item">
								<img src="uploadImg\<%=who%>_profileImg.png" onerror="this.src='img/profile.png'" width="45"
									class="rounded-circle mr-3">
								<div class="timeline-text">
									<h4>���� ����</h4>
									<p><%=who%>�Կ��� <%=taskDAO.getTask(what).getTaskName()%> ������ ���εǾ����ϴ�.</p>
								</div>
							</div>
						<%
							}else if(type.equals("AddTaskDetail")){
						%>
							<div class="timeline-item">
								<img src="uploadImg\<%=who%>_profileImg.png"onerror="this.src='img/profile.png'" width="45"
									class="rounded-circle mr-3">
								<div class="timeline-text">
									<h4>���� ����</h4>
									<p><%=who%>���� <%=taskDAO.getTask(what).getTaskName()%> ������ ���� ����߽��ϴ�.</p>
								</div>
							</div>
							
						<%}}}%>
						</div>
					</div>
					<%}}%>
				</div>
			</div>
		</div>
	</div>
	<!-- Option 2: Separate Popper and Bootstrap JS -->
	<!--
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script>
    -->




</body>
</html>