<%@page import="ming.board.ReboardDAO"%>
<%@page import="ming.board.ReboardBean"%>
<%@page import="ming.member.MemberBean"%>
<%@page import="ming.member.MemberDAO"%>
<%@page import="ming.board.BoardBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="ming.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	request.setCharacterEncoding("UTF-8");
	BoardDAO bdao = BoardDAO.getInstance();
	MemberDAO mdao = MemberDAO.getInstance();
	MemberBean member=null;
	ArrayList<BoardBean> lists=null;
	String imagePath = request.getContextPath() + "/images/";
	
	int no = (int)session.getAttribute("no");
	if(no==0){
		response.sendRedirect(request.getContextPath()+"/main.jsp");
	}
	
	String fno = null;
	fno = request.getParameter("fno");	// 사용자가 다른사람의 아이디로 들어왔을때
	int _fno = 0;
	if(fno!=null){
		_fno = Integer.parseInt(fno);
		member = mdao.getMemberByNo(_fno); 
		lists = bdao.getBoardByNo(_fno);
	}else{
		member = mdao.getMemberByNo(no); 
		lists = bdao.getBoardMeAndFriends(no);
	}
	System.out.println(no + "," + _fno);
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>밍스타그램</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="../../js/jquery.js"></script>
<script src="mainPage.js"></script>
<link href="mainPage.css" rel="stylesheet">
</head>
<body>
<!-- 네비게이션바 -->
<%@ include file="top.jsp" %>

<div class="container">
	<!-- <div class="blog-header"></div> -->
	<div class="row">
		<div class="col-sm-8 blog-main">
<% 
			if(no==_fno || _fno==0){
%>
			<form action="<%=request.getContextPath() %>/sns/board/insertBoard.jsp" method="post" enctype="multipart/form-data" onsubmit="return SaveWrite()">
				<div class="ming-write form-group">
					<textarea class="form-control" name="contents" style="resize:none; margin-bottom:10px"></textarea>
					<div class="btn-group col-sm-offset-9">
						<label class="btn btn-default btn-file btn-sm">
						    이미지 <input type="file" name="bimage" style="display: none;">
						</label>
						<input class="btn btn-default btn-sm" type="submit" value="글쓰기">
					</div><!-- 이미지/글쓰기 버튼그룹 -->
				</div>
			</form>	<!-- 글쓰기 폼 -->
<%
			}
%>
			<div class="blog-post">
				<hr>
<% 
				if(lists.size()!=0 && _fno!=0){
					for(BoardBean board : lists){
%>
						<p class="blog-post-meta row">
							<span class="col-xs-10">
								<img src="<%=imagePath + member.getImage() %>" class="img-circle" width="30" height="30">
								<a href="#"><%=member.getName() %></a>&nbsp;&nbsp;
								<small><%=board.getTime() %></small>
							</span>
<%
							if(no==board.getNo()){
%>
							<span class="btn-group btn-group-xs col-xs-2" role="group"">
								<a href="#" data-toggle="modal" data-target="#myModal" role="button" class="btn btn-default" onclick="modal_view('<%=board.getBno()%>', '<%=board.getBimage()%>', '<%=board.getContents()%>');">수정</a>
								<a href="<%=request.getContextPath() %>/board/deleteBoard.jsp?bno=<%=board.getBno() %>&bimage=<%=board.getBimage() %>" class="btn btn-default" role="button">삭제</a>
							</span>
<% 
							}
%>
						</p>
<%
					if(board.getBimage()!=null){
%>
					<img src="<%=imagePath + board.getBimage()%>" class="ming-images">
<%
					}
%>
						<p>
							<%=board.getContents() %>
						</p>
						<p>
							<a role="button" onclick="comentToggle(<%=board.getBno()%>)"><font size="2">덧글쓰기</font></a>
						</p>
						<div class="ming-write" id="coment<%=board.getBno()%>" style="display:none;">
							<form class="form-horizontal">
								<div class="input-group">
									<input id="reboard_con<%=board.getBno() %>" type="text" class="form-control">
									<input id="reboard_bno<%=board.getBno() %>" type="hidden" class="form-control" value="<%=board.getBno()%>">
									<a onclick="reb_btn(<%=board.getBno() %>)" role="button" class="btn input-group-addon">글쓰기</a>
								</div>
							</form>
								<div class="form-group">
									<table class="table" id="tb<%=board.getBno()%>">
									<!-- 덧글이 들어갈거야 -->
									</table>
								</div>
						</div>
						<hr>
<%						
					}
				}else if(lists.size()!=0){
					for(BoardBean board : lists){
						MemberBean friend=mdao.getMemberByNo(board.getNo());
%>
						<p class="blog-post-meta row">
							<span class="col-xs-10">
								<img src="<%=imagePath + friend.getImage() %>" class="img-circle" width="30" height="30">
								<a href="mainPage.jsp?no=<%=no%>&fno=<%=friend.getNo()%>"><%=friend.getName() %></a>&nbsp;&nbsp;
								<small><%=board.getTime() %></small>
							</span>
<%
							if(no==board.getNo()){
%>
							<span class="btn-group btn-group-xs col-xs-2" role="group"">
								<a href="#" data-toggle="modal" data-target="#myModal" role="button" class="btn btn-default" onclick="modal_view('<%=board.getBno()%>', '<%=board.getBimage()%>', '<%=board.getContents()%>');">수정</a>
								<a href="<%=request.getContextPath() %>/sns/board/deleteBoard.jsp?bno=<%=board.getBno() %>&bimage=<%=board.getBimage() %>" class="btn btn-default" role="button">삭제</a>
							</span>
<% 
							}
%>
						</p>
<%
					if(board.getBimage()!=null){
%>
					<img src="<%=imagePath + board.getBimage()%>" class="ming-images">
<%
					}
%>
						<p>
							<%=board.getContents() %>
						</p>
						<p>
							<a role="button" onclick="comentToggle(<%=board.getBno()%>)"><font size="2">덧글쓰기</font></a>
						</p>
						<div class="ming-write" id="coment<%=board.getBno()%>" style="display:none;">
							<form class="form-horizontal">
								<div class="input-group">
									<input id="reboard_con<%=board.getBno() %>" type="text" class="form-control">
									<input id="reboard_bno<%=board.getBno() %>" type="hidden" class="form-control" value="<%=board.getBno()%>">
									<a onclick="reb_btn(<%=board.getBno() %>)" role="button" class="btn input-group-addon">글쓰기</a>
								</div>
							</form>
								<div class="form-group">
									<table class="table" id="tb<%=board.getBno()%>">
									<!-- 덧글 -->
									</table>
								</div>
						</div>
						<hr>
<%						
									
					}
				}else{
%>
					<p align="center">작성한 글이 없습니다.</p>
<%
				}
%>
			</div><!-- blogpost --> 
		</div>
<%
		if(fno!=null){
%>
		<!-- 사이드바(프로필, 친구목록) -->
		<jsp:include page="side.jsp" flush="false">
			<jsp:param name="image" value="<%=member.getImage()%>" />
			<jsp:param name="name" value="<%=member.getName()%>"/>
			<jsp:param name="intro" value="<%=member.getIntro()%>"/>
			<jsp:param name="fno" value="<%=fno%>"/>
		</jsp:include>
<%
		}else{
%>
		<jsp:include page="side.jsp" flush="false">
			<jsp:param name="image" value="<%=member.getImage()%>" />
			<jsp:param name="name" value="<%=member.getName()%>"/>
			<jsp:param name="intro" value="<%=member.getIntro()%>"/>
		</jsp:include>
<%
		}
%>
	</div><!-- div class row -->
	
	<!-- 글 수정 Modal -->
	<%@ include file="updateModal.jsp" %>
</div>

<%@ include file="bottom.jsp" %>
</body>
</html>