<%@page import="ming.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String no = request.getParameter("no");
	MemberDAO mdao = MemberDAO.getInstance();
	int result = mdao.deleteMember(no);
	if(result>0){
		session.invalidate();
		response.sendRedirect(request.getContextPath()+"/main.jsp");
	}
%>