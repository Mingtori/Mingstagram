<%@page import="ming.member.MemberBean"%>
<%@page import="ming.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>밍스타그램</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link href="mainPage.css" rel="stylesheet">
<%
	int no = (int)session.getAttribute("no");
	MemberDAO mdao = MemberDAO.getInstance();
	MemberBean member = mdao.getMemberByNo(no);
	System.out.println(member.getImage());
%>
<script>
	function image_del(){
		location.href="updateMemberPro.jsp?flag=1&no=" +<%=no%> + "&old_image=" + $("input[name='old_image']").val();
		alert(no + "," + flag + "," + member.getImage());
	}
	function goodbye(no){
		var result = confirm("회원탈퇴 하시겠습니까?");
		if(result){
			location.href="deleteMember.jsp?no="+no;
		}else{
			history.back();
		}
	}
</script>
</head>
<body>
<%@ include file="top.jsp" %>
	<div class="container">
		<div class="blog-header">
			<h2>정보 수정</h2>
		</div>
		<div class="row">
			<div class="col-sm-8 blog-main">
				<div class="blog-post">
					<form class="form-signin" action="updateMemberPro.jsp" method="post" enctype="multipart/form-data">
						<input type="hidden" name="old_image" value="<%=member.getImage()%>">
						<input type="hidden" name="no" value="<%=no%>">
					    <label for="id">아이디</label>
					    <input type="text" class="form-control" id="id" name="id" value="<%=member.getId()%>" disabled>
					    <label for="name" >이름</label>
					    <input type="text" class="form-control" id="name" name="name" value="<%=member.getName()%>">
					    <label for="email" >이메일</label>
					    <input type="email" class="form-control" id="email" name="email" value="<%=member.getEmail()%>" disabled>
					    <label for="password">비밀번호</label>
					    <input type="text" class="form-control" id="password" name="password" value="<%=member.getPassword()%>">
					    <label for="intro">자기소개</label>
					    <textarea class="form-control" rows="3" id="intro" name="intro" style="resize:none"><%=member.getIntro().replace("<br>", "\r\n")%></textarea>
					    <div align="center" style="padding-top:10px">
						    <div class="btn-group btn-group-ms" role="group" align="center">
								<label class="btn btn-default btn-file">
								    이미지선택 <input type="file" name="image" style="display: none;">
								</label>
								<input class="btn btn-default" value="삭제" onClick="image_del();">
							</div><!-- 이미지/글쓰기 버튼그룹 -->
								<input class="btn btn-primary btn-ms" type="submit" value="수정하기">
						</div>
					</form>
					<p align="right"><a role="button" onClick="goodbye(<%=no%>);">회원탈퇴</a></p>
				</div>
			</div>
		</div>
	</div>
<%@ include file="bottom.jsp" %>
</body>
</html>