<%@page import="ming.friends.FriendsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String no1 = request.getParameter("no1");
	String no2 = request.getParameter("no2");
	
	FriendsDAO fdao = FriendsDAO.getInstance();
	int result = fdao.insertFriend(no1, no2);
	if(result>0){
		out.print("YES");
	}
%>