<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="boardMgr" class="pack.board.BoardManager"></jsp:useBean>
<jsp:useBean id="dto" class="pack.board.BoardDto"></jsp:useBean>

<%
String num = request.getParameter("num");
String spage = request.getParameter("page");
// out.print(num + " " +page);

boardMgr.updateReadcnt(num); // 조회수 증가
dto = boardMgr.getData(num); // 해당자료 읽기

String apass = "*****";
String adminOk = (String)session.getAttribute("adminOk");
if(adminOk != null){
   if(adminOk.equals("admin")) apass = dto.getPass();
      
}
%>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<link rel="stylesheet" type="text/css" href="../css/board.css">
</head>
<body>
글 내용 상세 보기
<br>
<table>
	<tr>
		<td><b>비밀번호 : <%=apass %> </b></td>
		<td colspan="2" style="text-align: right;">
			<a href="reply.jsp?num=<%=dto.getNum()%>&page=<%=spage %>">
			<img src="../images/reply.gif"/>
			</a>
			
			<a href="edit.jsp?num=<%=dto.getNum()%>&page=<%=spage %>">
			<img src="../images/edit.gif"/>
			</a>
			
			<a href="delete.jsp?num=<%=dto.getNum()%>&page=<%=spage %>">
			<img src="../images/del.gif"/>
			</a>
			
			<a href="boardlist.jsp?page=<%=spage%>">
			<img src="../images/list.gif"/>
			</a>
			
		</td>
	</tr>
	<tr>
		<td>작성자 : <a href="mailto:<%=dto.getMail() %>"><%=dto.getName() %>(ip:<%=dto.getBip() %>)</a> </td>
		<td>작성일 : <%=dto.getBdate() %></td>
		<td>조회수 : <%=dto.getReadcnt() %></td>
	</tr>
	<tr>
	 	<td colspan="3">
	 	제목 : <%=dto.getTitle() %>
	 	</td>
	</tr>
	<tr>
	 	<td colspan="3">
	 	<textarea rows="10" style="width:99%" readonly="readonly"><%=dto.getCont() %></textarea>
	 	</td>
	</tr>
</table>
</body>
</html>