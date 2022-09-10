<%@page import="java.util.List"%>
<%@page import="pms.projectVO"%>
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
String _id = (String) session.getAttribute("id");
String _pid = (String) session.getAttribute("pid");
List memberList = projectDAO.getMemberList(_pid);
projectVO pVO = projectDAO.getProject(_pid);
String _inid = request.getParameter("inid");

projectDAO.insertMember(_pid, _inid);

response.sendRedirect("popup_member_search.jsp");
%>

</body>
</html>