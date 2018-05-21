<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="ming.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	MultipartRequest mr = null;
	MemberDAO mdao = null;
	String uploadDir = config.getServletContext().getRealPath("/images/");
	String url="";
	try{
		mr= new MultipartRequest(request, uploadDir, 10*1024*1024, "UTF-8", new DefaultFileRenamePolicy());
	}catch(Exception e){
		e.printStackTrace();
	}
	String flag = request.getParameter("flag");
	String no = request.getParameter("no");
	int _no = 0;
	int _flag=0;
	String old_image=null, new_image=null;
	if(flag!=null){
		_flag = Integer.parseInt(flag);
		_no = Integer.parseInt(no);
		old_image= request.getParameter("old_image");
	}else{
		old_image= mr.getParameter("old_image");
		new_image= mr.getFilesystemName("image");
	}
	
	mdao = MemberDAO.getInstance();
	int result = mdao.updateMember(mr, _flag, _no);
	if(result>0){
		if((old_image!=null && new_image!=null) || _flag==1){
			File f = new File(config.getServletContext().getRealPath("/images/") + old_image);
			if(f.exists() && !old_image.equals("basic.jpg")){
				if(f.delete()){
					System.out.println("이미지 삭제 성공");
				}else{
					System.out.println("이미지 삭제 실패");
				}
			}
		}
		response.sendRedirect("mainPage.jsp");
	}
%>