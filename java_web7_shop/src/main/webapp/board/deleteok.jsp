<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="boardMgr" class="pack.board.BoardManager"></jsp:useBean>
<%
String spage = request.getParameter("page");
String num = request.getParameter("num");
String pass = request.getParameter("pass");

boolean b = boardMgr.checkPass(Integer.parseInt(num),pass);

if(b) {
	// out.print("맞네");
	boardMgr.delData(num); 
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