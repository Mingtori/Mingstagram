<%@page import="ming.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	MemberDAO mdao = MemberDAO.getInstance();
%>
<jsp:useBean id="member" class="ming.member.MemberBean"/>
<jsp:setProperty property="*" name="member"/>
<%
	String id = request.getParameter("id");
	System.out.println(id);
	
	String str = "";
	
	boolean isCheck = mdao.searchID(id);
	 
	if(isCheck){	// 아이디 중복되었을때.
%>
	<script>
		alert("아이디 중복");
		history.back();
	</script>
<%		
		return;
	}
	
	int result = mdao.insertMember(member); 
	if(result>0){	
		%>
		<script>
			alert("회원이 되신걸 환영합니다.\n로그인 해주세요.");
			location.href="main.jsp";
		</script>
	<%			
	}
%>
