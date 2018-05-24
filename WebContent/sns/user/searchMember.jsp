<%@page import="ming.friends.FriendsBean"%>
<%@page import="ming.friends.FriendsDAO"%>
<%@page import="ming.member.MemberBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="ming.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>밍스타그램</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link href="mainPage.css" rel="stylesheet">
<script>
	function addFriend(n1, n2){
		$.ajax({
			url : "<%=request.getContextPath()%>/sns/friends/insertFriend.jsp",
			data : ({
				no1 : n1,
				no2 : n2
			}),
			success : function(data) {
				if (jQuery.trim(data) == "YES") {
					$("#btn_friend"+n2).addClass("disabled btn-success").removeClass("btn-default")
							.html("요청 중...");
				}
			}// success끝
		});// ajax 끝
	}
</script>
</head>
<body>
<%@ include file="top.jsp" %>
	<div class="container">
		<div class="row">
			<div class="col-sm-8 blog-main">
				<div class="blog-post">
					<hr>
<%
	request.setCharacterEncoding("UTF-8");
	String search = request.getParameter("search");
	String imagePath = request.getContextPath() + "/images/";
	int no = (int)session.getAttribute("no");

	FriendsDAO fdao = FriendsDAO.getInstance();
	ArrayList<FriendsBean> flists = fdao.getFriendByNo(no);
	MemberDAO mdao = MemberDAO.getInstance();
	ArrayList<MemberBean> lists = mdao.getMembersByName(search);
	if(lists.size()!=0){
		for(MemberBean member : lists){
			boolean flag=false;
			if(member.getNo()!=no){
%>
				<p class="blog-post-meta row">
					<span class="col-xs-10">
						<img src="<%=imagePath + member.getImage() %>" class="img-circle" width="100" height="100">
						&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="mainPage.jsp?fno=<%=member.getNo()%>"><%=member.getName() %></a>
					</span>
					<span class="col-xs-2">
<%
		if(flists.size()!=0){
			
			for(FriendsBean friend : flists){
				if(friend.getNo2()==member.getNo() && friend.getReq().equals("ADD")){
%>
						<button role="button" class="btn btn-success" disabled>요청 중...</button>
<%
					flag=true;
					break;
				}else if(friend.getNo1()==member.getNo() && friend.getNo2()==no && friend.getReq().equals("ADD")){
%>
						<a href="<%=request.getContextPath()%>/sns/friends/okFriend.jsp?no1=<%=member.getNo() %>&no2=<%=no %>&search=<%=search %>" role="button" id="btn_ok" role="button" class="btn btn-primary">수락</a>
						<a href="<%=request.getContextPath()%>/sns/friends/cancelFriend.jsp?no1=<%=member.getNo() %>&no2=<%=no %>&search=<%=search %>" id="btn_cancel" role="button" class="btn btn-warnning">취소</a>
					
<%
					flag=true;
					break;
				}else if((friend.getNo1()==no && friend.getNo2()==member.getNo()) || (friend.getNo1()==member.getNo() && friend.getNo2()==no) && friend.getReq().equals("FRIEND")){
%>
					<button role="button" class="btn btn-default" disabled>친구</button>
<%
					flag=true;
					break;
				}else {
					flag=false;
				}
			}
		}
		if(!flag){
%>
			<button id="btn_friend<%=member.getNo() %>" role="button" class="btn btn-default" onclick="addFriend('<%=no%>', '<%=member.getNo()%>')">친구추가</button>
<%
		}
%>
			</span>
				</p>
				<hr>
<%	
			}
		}
	}
%>
				</div>
			</div>
		</div>
	</div>
<%@ include file="bottom.jsp" %>
</body>
</html>