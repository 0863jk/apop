<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.nio.file.Files"%>
<%@page import="java.nio.file.StandardCopyOption"%>
<%@page import="java.nio.file.Paths"%>
<%@page import="java.nio.file.Path"%>
<%@page import="java.util.Enumeration"%>
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
<jsp:useBean class="pms.projectDAO" id="projectDAO"></jsp:useBean>
<%
		request.setCharacterEncoding("euc-kr");
		String _id = (String) session.getAttribute("id");
		String _pid = (String) session.getAttribute("pid");
	
		
		
		String path = "C:/WebSoft/PMS_WS/12week/WebContent/uploadImg";

		int maxSize = 1024 * 1024 * 10; //10MB;

		MultipartRequest multi = null;
	try{
		//multi, 파일저장경로, 인코딩 타입, 중복파일명 옵션
		
		//파일 업로드
		multi =new MultipartRequest(request,path,maxSize,"euc-kr",new DefaultFileRenamePolicy());
		
		String _name = multi.getParameter("pname");
		String _class = multi.getParameter("classification");
		String _summary = multi.getParameter("summary");
		String _roleGroup = multi.getParameter("roleGroup");
		String _from = multi.getParameter("from");		
		String _password = multi.getParameter("password");
		String _to = multi.getParameter("to");
		
		boolean result = projectDAO.updateProject(_id, _pid, _name, _class, _summary, _password, _from, _to);
		
		if (result) {
			out.print("success");
			
			//파일 이름 변경
			Enumeration e =	multi.getFileNames();
			while(e.hasMoreElements()){
				String eleName = (String)e.nextElement();
				String fileName = multi.getFilesystemName(eleName);        //서버에 저장된 파일이름(확장자포함)
				String RealFileName = multi.getOriginalFileName(eleName);  //사용자가 업로드한 파일의 원본 이름(확장자포함)
				if(fileName != null){
					Path originFilePath = Paths.get(path+"/"+fileName);
					String ext = fileName.substring(fileName.lastIndexOf(".")).toLowerCase();
					String newFileName = _pid+"_thumnail"+ext;
					Path newFiiePath = Paths.get(path+"/"+newFileName); 
					
					Files.move(originFilePath, newFiiePath, StandardCopyOption.REPLACE_EXISTING);
				}
			}
			
			response.sendRedirect("project_correction_result.jsp?result=success");
		} else {
			out.print("fail");
			response.sendRedirect("project_correction_result.jsp?result=fail");
		}
	}catch (Exception e){
		e.printStackTrace();
		response.sendRedirect("project_correction_result.jsp?result=fail");
	}
	%>

</body>
</html>