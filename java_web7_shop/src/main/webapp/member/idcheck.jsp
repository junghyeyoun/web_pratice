<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 신규 회원으로 입력된 id 중복 여부 판단 --%>
<jsp:useBean id="memberMgr" class="pack.member.MemberManager"></jsp:useBean>
<%
request.setCharacterEncoding("utf-8");
String id = request.getParameter("id");
boolean b = memberMgr.checkId(id); // 아이디 있는지 확인    
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원관리</title>
<link href="../css/style.css" rel="stylesheet" type="text/css">
<script src="../js/script.js"></script>
</head>
<body style="text-align:center; margin-top:30px">
<b><%= id %></b>
<%
if(b) {
%>
	: 이미 사용 중인 id 입니다.<p/>
	<a href="#" onclick="opener.document.regForm.id.focus();window.close()">닫기</a>
<%}else {%>

	: 사용 가능한 id 입니다.
	<p/>
	<a href="#" onclick="opener.document.regForm.passwd.focus();window.close()">닫기</a>
<%
}
%>
</body>
</html>