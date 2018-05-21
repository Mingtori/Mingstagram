<%@page import="ming.board.ReboardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String rno = request.getParameter("rno");
	ReboardDAO rdao = ReboardDAO.getInstance();
	int result = rdao.reboardDelete(rno);
	if(result>0){
		response.sendRedirect("mainPage.jsp");
	}
%>