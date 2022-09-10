<%@page import="java.nio.file.Path"%>
<%@page import="java.nio.file.Paths"%>
<%@page import="java.nio.file.StandardCopyOption"%>
<%@page import="java.nio.file.Files"%>
<%@page import="java.io.File"%>
<%@page import="java.util.*"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<jsp:useBean class="pms.userDAO" id="user"></jsp:useBean>
<%
	String _id = (String) session.getAttribute("id");
	//String path = request.getRealPath("/uploadImg");
	String path = "C:/WebSoft/PMS_WS/12week/WebContent/uploadImg";

	int maxSize = 1024 * 1024 * 10; //10MB;

	MultipartRequest multi = null;
try{
	//multi, 파일저장경로, 인코딩 타입, 중복파일명 옵션
	
	//파일 업로드
	multi =new MultipartRequest(request,path,maxSize,"utf-8",new DefaultFileRenamePolicy());
	
	//파일 이름 변경
	Enumeration e =	multi.getFileNames();
	while(e.hasMoreElements()){
		String eleName = (String)e.nextElement();
		String fileName = multi.getFilesystemName(eleName);        //서버에 저장된 파일이름(확장자포함)
		String RealFileName = multi.getOriginalFileName(eleName);  //사용자가 업로드한 파일의 원본 이름(확장자포함)
		if(fileName != null){
			Path originFilePath = Paths.get(path+"/"+fileName);
			String ext = fileName.substring(fileName.lastIndexOf(".")).toLowerCase();
			String newFileName = _id+"_profileImg"+ext;
			Path newFiiePath = Paths.get(path+"/"+newFileName); 
			
			Files.move(originFilePath, newFiiePath, StandardCopyOption.REPLACE_EXISTING);
		}
	}

	String name = multi.getParameter("name");
	String pw = multi.getParameter("pw");
	String phone = multi.getParameter("phone");
	String email = multi.getParameter("email");
	String occupation = multi.getParameter("1");
	//String occupation = multi.getParameter("occupation");
	String department = multi.getParameter("department");

		if (user.updateUser(_id, pw, name, phone, email, occupation, department)) {
			response.sendRedirect("profile_modify_result.jsp?result=success");
		} else {
			response.sendRedirect("profile_modify_result.jsp?result=fail");
		}
	} catch (Exception e) {
		e.printStackTrace();
	}
%>
</body>
</html>