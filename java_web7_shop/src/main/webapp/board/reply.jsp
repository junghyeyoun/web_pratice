<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="boardMgr" class="pack.board.BoardManager"></jsp:useBean>
<jsp:useBean id="dto" class="pack.board.BoardDto"></jsp:useBean>
<%
String num = request.getParameter("num");
String spage = request.getParameter("page");
dto = boardMgr.getReplyData(num);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<link rel="stylesheet" type="text/css" href="../css/board.css">
<script>
function check(){
	if(frm.name.value==""){
		alert("이름을 입력하세요");
		frm.name.focus();
	}else if(frm.pass.value ==""){
		alert("비밀번호를 입력하세요");
		frm.pass.focus();
	}else if(frm.mail.value ==""){
		alert("이메일을 입력하세요");
		frm.mail.focus();
	}else if(frm.title.value ==""){
		alert("제목을 입력하세요");
		frm.title.focus();
	}else if(frm.cont.value ==""){
		alert("내용을 입력하세요");
		frm.cont.focus();
	}else
		frm.submit();
}
</script>
<script type="text/javascript"></script>
</head>
<body>
<h2>** 댓글 쓰기 **</h2>
<form action="replysave.jsp" name="frm" method="post">
<input type="hidden" name="num" value="<%=num %>">
<input type="hidden" name="page" value="<%=spage %>">
<input type="hidden" name="gnum" value="<%=dto.getGnum() %>">
<input type="hidden" name="onum" value="<%=dto.getOnum() %>">
<input type="hidden" name="nested" value="<%=dto.getNested() %>">
<table border="1">
	<tr>
		<td>작성자</td>
		<td><input type="text" name="name" style="width:98%"></td>
	</tr>
	<tr>
		<td>비밀번호</td>
		<td><input type="password" name="pass" style="width:98%"></td>
	</tr>
	<tr>
		<td>이메일</td>
		<td><input type="email" name="mail" style="width:98%"></td>
	</tr>
	<tr>
		<td>제 목</td>
		<td><input type="text" name="title" style="width:98%" value="[Re:<%=dto.getTitle()%>]"></td>
	</tr>
	<tr>
		<td>내 용</td>
		<td><textarea rows="10" style="width:98%" name="cont"></textarea></td>
	</tr>
	<tr>
		<td colspan="2" style="text-align: center;">
			<input type="button" value="작성" onclick="check()">
			<input type="button" value="글목록" onclick="location.href ='boardlist.jsp?page=<%= spage %>'"/> 
		</td>
	</tr>
</table>
</form>
</body>
</html>