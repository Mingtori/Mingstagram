<%@page import="java.io.File"%>
<%@page import="ming.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	BoardDAO bdao = BoardDAO.getInstance();	
	String bno = request.getParameter("bno");
	String bimage = request.getParameter("bimage");
	System.out.println(bimage);
	int result = bdao.deleteBoard(bno);
	if(result>0){
		if(bimage!=null){
			File f = new File(config.getServletContext().getRealPath("/images/") + bimage);
			if(f.exists()){
				if(f.delete()){
					System.out.println("이미지 삭제 성공");
				}else{
					System.out.println("이미지 삭제 실패");
				}
			}
		}
		response.sendRedirect(request.getContextPath()+"/sns/user/mainPage.jsp");
	}
%>