<%@page import="ming.board.ReboardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	String bno = request.getParameter("bno");
	String contents = request.getParameter("contents");
	int no = (int)session.getAttribute("no");
	
	ReboardDAO rdao = ReboardDAO.getInstance();
	int result = rdao.insertReboard(bno, no, contents);
	if(result>0){
		response.sendRedirect(request.getContextPath()+"/sns/user/mainPage.jsp");
	}
%>