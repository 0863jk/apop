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
	<jsp:useBean class="pms.timelineDAO" id="timelineDAO"></jsp:useBean>
	<%
		request.setCharacterEncoding("euc-kr");
		String _id = (String) session.getAttribute("id");
	
		String _name = request.getParameter("pname");
		String _classification = request.getParameter("classification");
		String _summary = request.getParameter("summary");
		String _from = request.getParameter("from");
		String _password = request.getParameter("password");
		String _member = request.getParameter("member");
		String _to = request.getParameter("to");
		
		int result = projectDAO.createProject(_id, _name, _classification, _summary, _password, _from, _to);
		if (result > 0) {
			out.print("success");
			session.setAttribute("pid", result+"");
			if(_member == null || _member.equals("null") || _member.equals("")) {
				response.sendRedirect("create_project_result.jsp?result=success&member=");
			} else {
				int succ = projectDAO.insertMembers(result + "", _member);
				if(timelineDAO.addHistoryCreateProject(_id, result+""));
				response.sendRedirect("create_project_result.jsp?result=success&member=" + succ);
			}
			
		} else {
			out.print("fail");
			response.sendRedirect("create_project_result.jsp?result=fail&member=none");
		}
	%>

</body>
</html>