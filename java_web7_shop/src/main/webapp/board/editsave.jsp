<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="bean" class="pack.board.BoardBean"></jsp:useBean>
<jsp:setProperty property="*" name="bean"/>
<jsp:useBean id="boardMgr" class="pack.board.BoardManager"></jsp:useBean>

<%
String spage = request.getParameter("page");

boolean b = boardMgr.checkPass(bean.getNum(), bean.getPass());

if(b) {
	// out.print("맞네");
	boardMgr.updateData(bean);
	response.sendRedirect("boardlist.jsp?page="+spage);
} else {
	// out.print("아니네");
%>
	<script>
	alert("비밀번호 불일치");
	history.back();
	</script>
<%
}
%>  




