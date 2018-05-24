<%@page import="java.sql.Timestamp"%>
<%@page import="ming.board.BoardBean"%>
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
	
	int no = (int)session.getAttribute("no");
	
	BoardDAO bdao = BoardDAO.getInstance();
	int result = bdao.insertBoard(no, mr);
	if(result > 0){
		System.out.println("게시글 성공");
	}else{
		System.out.println("게시글 실패");
	}
%>
<script>
	location.href="<%=request.getContextPath()%>/sns/user/mainPage.jsp";
</script>