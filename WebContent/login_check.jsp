
<%@page import="java.lang.ProcessBuilder.Redirect"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<jsp:useBean class="pms.projectDAO" id="projectDAO"></jsp:useBean>
	<%
		request.setCharacterEncoding("euc-kr");

		String _id = request.getParameter("id");
		String _password = request.getParameter("password");
		
		boolean result = projectDAO.login(_id, _password);

		if (result) {
			session.setAttribute("id", _id);
			/* 	session.setMaxInactiveInterval(600); */
			response.sendRedirect("project_list.jsp");
		} else {
			response.sendRedirect("login.jsp");
		}
	%>

</body>
</html>