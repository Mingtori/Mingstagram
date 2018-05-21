<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Mings</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="main.css" rel="stylesheet">
<script src="js/jquery.js"></script>
<script>
	function SaveWrite_reg(){
		if($("#id").val()==""){
			alert("아이디를 입력해주세요.");
			$("#id").focus();
			return false;
		}
		if($("#name").val()==""){
			alert("이름을 입력해주세요.");
			$("#name").focus();
			return false;
		}
		if($("#email").val()==""){
			alert("이메일을 입력해주세요.");
			$("#email").focus();
			return false;
		}
		if($("#password").val()==""){
			alert("비밀번호를 입력해주세요.");
			$("#password").focus();
			return false;
		}
		
	}
	function SaveWrite_log(){
		if($("#login_id").val()==""){
			alert("아이디 입력해주세요.");
			$("#login_id").focus();
			return false;
		}
		if($("#login_password").val()==""){
			alert("비밀번호 입력해주세요.");
			$("#login_password").focus();
			return false;
		}
	}
	$(function(){
		$("#login").click(function(){
			$("#login_f").toggle();
		});
	});
</script>
<style>
.bg {
	 background: url('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqqUKnPknqYR5i_VsEY2AIEBIjaWnMfbM-tg0bjWT6BmDAkPdK') no-repeat center center fixed;
	  background-size: cover; 
	  min-height:100%
}
</style>
</head>
<body class="bg">
<%
	try{
		int no = (int)session.getAttribute("no");
		response.sendRedirect("sns/user/mainPage.jsp");
	}catch(NullPointerException e){
		
	}
%>
	<div class="container">
		<h1 align="center">Mingstagram</h1>
		<form class="form-signin" action="registerPro.jsp" method="post" onsubmit="return SaveWrite_reg()">
			<h2>회원가입</h2>
		    <label for="id" class="sr-only">아이디</label>
		    <input type="text" class="form-control" id="id" name="id" placeholder="ID">
		    <label for="name" class="sr-only">이름</label>
		    <input type="text" class="form-control" id="name" name="name" placeholder="Name">
		    <label for="email" class="sr-only">이메일</label>
		    <input type="email" class="form-control" id="email" name="email" placeholder="Email">
		    <label for="password" class="sr-only">비밀번호</label>
		    <input type="password" class="form-control" id="password" name="password" placeholder="Password">
		    <button type="submit" class="btn btn-lg btn-primary btn-block">회원가입</button>
		</form>
		<div class="form-signin" align="center">
			아이디가 있으십니까? <a id="login" role="button">로그인</a>	
		</div>
	</div>
	
	<div id="login_f" class="container" style="display:none;">
		<form  class="form-signin" action="loginPro.jsp" method="post" onsubmit="return SaveWrite_log()" >
			<h2 class="form-signin-heading">로그인</h2>
			<label for="login_id" class="sr-only">아이디</label>
			<input type="text" class="form-control" id="login_id" name="id" placeholder="ID">
			<label for="login_password" class="sr-only">비밀번호</label>
			<input type="password" class="form-control" id="login_password" name="password" placeholder="Password">
			<button type="submit" class="btn btn-lg btn-primary btn-block">로그인</button>
		</form>
	</div>
</body>
</html>