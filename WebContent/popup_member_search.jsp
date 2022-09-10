<%@page import="pms.projectDAO"%>
<%@page import="pms.userVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<title>Insert title here</title>
</head>
<body>
<jsp:useBean class="pms.userDAO" id="userDAO"></jsp:useBean>
<%
String _id = (String) session.getAttribute("id");
String _pid = (String) session.getAttribute("pid");
request.setCharacterEncoding("euc-kr");
String _mode = request.getParameter("mode");
String _value = request.getParameter("value");

String idSelected = "";
String nameSelected = "";
String belongSelected = "";
if(_mode == null) {
	_mode = "";
}
if(_value == null) {
	_value = "";
} else {
	if(_mode.equals("id")) {
		idSelected = "selected";
	} else if(_mode.equals("name")) {
		nameSelected = "selected";
	} else if(_mode.equals("belong")) {
		belongSelected = "selected";
	}
}

%>
<div style="padding:20px">
	<form action="popup_member_search.jsp" method="post">
		<p class="text-center">
			<select name="mode">
				<option value="id" <%=idSelected %>>아이디</option>
				<option value="name" <%=nameSelected %>>이름</option>
				<option value="belong"<%=belongSelected %>>소속</option>
			</select>
			<input type="text" name="value" value="<%=_value%>">
			<input type="submit" value="검색">
		</p>
	</form>
	<hr>
	<!--  게시판 영역 -->
	<%
	if((_mode.equals("") || _mode.equals("null")) && (_value.equals("") || _value.equals("null"))) {
	%>
	<div class="active">
	<br>
	<p class="text-center">여기에 검색 결과가 표시됩니다.</p>
	</div>
	<%	
	} else {
		List list = userDAO.searchUser(_mode, _value);
		if(list.size() < 1) {
	%>
	<div class="active">
	<br>
	<p class="text-center">검색 결과가 없습니다.</p>
	</div>
	<%		
		} else {
	%>
	<div class="active">
		<div class="container">
			<div class="row">
				<table class="table table-hover" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th style="background-color: #eeeeee; text-align: center;">ID</th>
							<th style="background-color: #eeeeee; text-align: center;">이름</th>
							<th style="background-color: #eeeeee; text-align: center;">직업</th>
							<th style="background-color: #eeeeee; text-align: center;">소속</th>
							<th style="background-color: #eeeeee; text-align: center;"></th>
						</tr>
					</thead>
					<tbody>
<%
	for(int i = 0; i < list.size(); i ++) {
		userVO vo = (userVO) list.get(i);
%>
						<tr>
							<td><%=vo.getId() %></td>
							<td><%=vo.getName() %></td>
							<td><%=vo.getJob() %></td>
							<td><%=vo.getBelong() %></td>
							<td><button onclick="location.href='insert_member_quiry.jsp?pid=<%=_pid%>&inid=<%=vo.getId()%>'">추가하기</button></td>
						</tr>
	<%
			}
	%>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<%
		}
	}
	%>
	<div>
		<p class="text-center">
			<button onclick="moveClose()">닫기</button>
		</p>
	</div>
</div>
<script type="text/javascript">
function moveClose() {
  opener.location.href="project_member_list2.jsp";
  self.close();
}
</script>
</body>
</html>