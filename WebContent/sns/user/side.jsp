<%@page import="ming.friends.FriendsBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="ming.friends.FriendsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	String imagePath = request.getContextPath() + "/images/";
	int no = (int)session.getAttribute("no");
	String image = request.getParameter("image");
	String name = request.getParameter("name");
	String intro = request.getParameter("intro");
	String fno = request.getParameter("fno");
	int _fno = no;
	if(fno!=null){
		_fno=Integer.parseInt(fno);
	}
%>

<div class="col-sm-3 col-sm-offset-1 blog-sidebar">
	<div class="sidebar-module sidebar-module-inset">
  		<h4>프로필
<%
			if(fno==null || no==Integer.parseInt(fno)){
%>
  			<a href="updateMember.jsp" role="button" class="glyphicon glyphicon-pencil" style="float:right;"></a>
<%
			}
%>
  		</h4>
  		<div align="center">
  			<img src="<%=imagePath + image%>" class="img-circle" width="150" height="150">
			<p><font size="4"><a href="mainPage.jsp?no=<%=no%>&fno=<%=_fno%>"><%=name %></a></font></p>
  		</div>
  		<br>
		<p>
			<%=intro %>
		</p>
        	</div>
	<div class="sidebar-module sidebar-module-inset">
		<h4>친구</h4>
		<ol class="list-unstyled">
<%
	FriendsDAO fdao = FriendsDAO.getInstance();
	ArrayList<FriendsBean> lists = null;
	if(_fno!=no){
		 lists = fdao.getFriendsName(_fno);
	}else{
		 lists = fdao.getFriendsName(no);
	}
	if(lists.size()!=0){
		for(FriendsBean friend : lists){
%>
			<li><a href="mainPage.jsp?no=<%=no%>&fno=<%=friend.getNo1()%>"><%=friend.getNo1_name() %></a></li> 
<%
		}
	}
%> 
		</ol>
	</div>
</div>