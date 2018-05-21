<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="ming.member.*"%>

<%
   request.setCharacterEncoding("UTF-8");
   String id = request.getParameter("id");
   String password = request.getParameter("password");
   System.out.println(id + "," + password);
   
   String contextPath = request.getContextPath();
   
   MemberDAO mdao = MemberDAO.getInstance();
   MemberBean member = mdao.getMemberInfo(id,password);
   
   String viewPage = null;
   
   if(member != null){
      int no = member.getNo();
      String _id = member.getId();
      if(_id.equals("admin")){
         viewPage = contextPath + "/sns/admin/mainPage.jsp";
      }else{
         viewPage = contextPath + "/sns/user/mainPage.jsp";
      }
      System.out.println(no + "," + _id);
      
      session.setAttribute("no", no);
      session.setAttribute("id", _id);
      
   } else{
      viewPage = contextPath+"/main.jsp"; 
%>
<script type="text/javascript">
   alert("가입하지 않은 회원입니다.");
</script>
<%
   }
%>

<script>
	location.href = "<%=viewPage%>";
</script>