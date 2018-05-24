<%@page import="ming.board.ReboardBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="ming.board.ReboardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
<%
	String bno = request.getParameter("bno");
	int no = (int)session.getAttribute("no");
	ReboardDAO bdao = ReboardDAO.getInstance();
	ArrayList<ReboardBean> lists = bdao.getReboardByBno(Integer.parseInt(bno));
	if(lists.size()!=0){
		for(ReboardBean reboard : lists){
%>
		<tr>
			<td align="center" width=15%><font size="2"><%=reboard.getName() %></font></td>
			<td width=65%>
				<font id="reb_con<%=reboard.getRno() %>" size="2"><%=reboard.getContents() %></font>
				<input type="text" id="reb_upcon<%=reboard.getRno() %>" value="<%=reboard.getContents() %>" style="display:none; width:100%">
			</td>
			<td align="center" width=20%>
<%
				if(no==reboard.getNo()){
%>
				<a id="reb_up_btn<%=reboard.getRno() %>" onClick="reb_upd(<%=reboard.getRno() %>);" role="button"><font size="2">수정</font></a>
				<a id="reb_del_btn<%=reboard.getRno() %>" onClick="reb_del(<%=reboard.getRno() %>, <%=reboard.getBno() %>);" role="button"><font size="2">삭제</font></a>
				<a id="reb_ok_btn<%=reboard.getRno() %>" onClick="reb_ok(<%=reboard.getRno() %>, <%=reboard.getBno() %>);" role="button" style="display:none;"><font size="2">확인</font></a>
<%
				}
%>
			</td>
		</tr>

<%			
		}
	}
%>