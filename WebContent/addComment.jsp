<%@page import="pms.projectVO"%>
<%@page import="pms.TaskDetailVO"%>
<%@page import="pms.taskVO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<!-- Required meta tags -->
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:useBean class="pms.CommentDAO" id="commentDAO"></jsp:useBean>
	<%
		request.setCharacterEncoding("euc-kr");
		String _taskId = request.getParameter("tid");
		String _taskDetailId = request.getParameter("tdid");
		String _commentContent = request.getParameter("commentContent");
		String _leader = request.getParameter("leader");
		
		if(_commentContent.isEmpty()){
			response.sendRedirect("my_task_detail_view.jsp?tid="+_taskId+"&tdid="+_taskDetailId);
		}else{
			commentDAO.addComment(_taskDetailId, _commentContent, _leader);
			response.sendRedirect("my_task_detail_view.jsp?tid="+_taskId+"&tdid="+_taskDetailId);
		}

	%>

</body>
</html>