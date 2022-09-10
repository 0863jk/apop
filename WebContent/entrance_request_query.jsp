<%@page import="org.apache.catalina.ha.backend.Sender"%>
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
	String _user = request.getParameter("userid");
	String _update = request.getParameter("update");
	
	boolean insert = projectDAO.insertMember(_pid, _user);
	if(insert) {
		boolean result = projectDAO.updateEntRequest(_pid, _user, _update);
		if(result) {
			response.sendRedirect("entrance_request_list.jsp");
		} else {
%>
<script type="text/javascript">
alert("업데이트에 실패했습니다.");
</script>
<%	
			response.sendRedirect("entrance_request_list.jsp");
		}
	} else {
%>
<script type="text/javascript">
alert("업데이트에 실패했습니다.");
</script>
<%
		response.sendRedirect("entrance_request_list.jsp");
	}
%>

</body>
</html>