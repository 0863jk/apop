<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<jsp:useBean class="pms.CommentDAO" id="commentDAO"></jsp:useBean>
	<%
		request.setCharacterEncoding("euc-kr");
		String _taskId = request.getParameter("tid");
		String _taskDetailId = request.getParameter("tdid");
		String _leader = request.getParameter("leader");
		String _commentId = request.getParameter("cid");
		
		boolean result = commentDAO.deleteComment(_commentId);
		
		if(result){
			response.sendRedirect("my_task_detail_view.jsp?tid="+_taskId+"&tdid="+_taskDetailId);
		}
	%>

</body>
</html>