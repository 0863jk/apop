<%--성명 : 최현준, 학번 : 202045042 --%>
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
		String _name = request.getParameter("name");
		String _phone = request.getParameter("phone");
		String _email = request.getParameter("email");
		String _occupation = request.getParameter("occupation");
		String _department = request.getParameter("department");
		
		boolean result = projectDAO.resister(_id, _password, _name, _phone, _email, _occupation, _department);
		
		if (result) {
			session.setAttribute("id", _id);
			response.sendRedirect("project_list.jsp");
		} else {
			response.sendRedirect("resister.jsp");
		}
	%>

</body>
</html>