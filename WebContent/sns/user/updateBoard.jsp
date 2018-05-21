<%@page import="java.io.File"%>
<%@page import="ming.board.BoardDAO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String uploadDir = config.getServletContext().getRealPath("/images/");
	String url="";
	MultipartRequest mr = null;
	try{
		mr= new MultipartRequest(request, uploadDir, 10*1024*1024, "UTF-8", new DefaultFileRenamePolicy());
	}catch(Exception e){
		e.printStackTrace();
	}
	String flag = request.getParameter("flag");
	String bno = request.getParameter("bno");
	int _bno = 0;
	int _flag=0;
	String old_bimage=null, new_image=null;
	if(flag!=null){
		_flag = Integer.parseInt(flag);
		_bno = Integer.parseInt(bno);
		old_bimage= request.getParameter("old_bimage");
	}else{
		old_bimage= mr.getParameter("old_bimage");
		new_image= mr.getFilesystemName("bimage");
	}
	BoardDAO bdao = BoardDAO.getInstance();
	int result = bdao.updateBoard(mr, _flag, _bno);
	if(result>0){
		System.out.println("수정성공");
		if((old_bimage!=null && new_image!=null) || _flag==1){
			File f = new File(config.getServletContext().getRealPath("/images/") + old_bimage);
			if(f.exists()){
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
