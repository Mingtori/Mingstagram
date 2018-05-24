<%@page import="ming.board.ReboardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String rno = request.getParameter("rno");
	String contents = request.getParameter("contents");
	
	ReboardDAO rdao = ReboardDAO.getInstance();
	int result = rdao.updateReboard(rno, contents);
%>