<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String num = request.getParameter("num");
String spage = request.getParameter("page");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../css/board.css">
<script type="text/javascript">
window.onload = function(){
   document.querySelector("#btnDel").onclick=funcCheck;
   document.querySelector("#btnBack").onclick=funcBack;
}

function funcCheck(){
   //alert("a");
   if(frm.pass.value == ""){
      alert("비밀번호 입력");
      return;
   }
   if(confirm("정말 삭제할까요?")){
      frm.submit();
   }
}

function funcBack(){
   //alert("b");
   location.href="boardlist.jsp?page=<%=spage%>";
   //history.back();
}
</script>
</head>
<body>
<h2>* 글 삭제 *</h2>
<form action="deleteok.jsp" name="frm" method="post">
	<input type="hidden" name="num" value="<%=num %>">
	<input type="hidden" name="page" value="<%=spage %>">
	비밀번호 입력 : 
	<input type="password" name="pass">
	<input type="button" id="btnDel" value="삭제확인">
	<input type="button" id="btnBack" value="목록보기">
</form>
</body>
</html>