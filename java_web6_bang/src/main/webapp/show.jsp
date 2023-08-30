<%@page import="pack.Dto"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="test" class="pack.ConnPooling"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
* 방명록 보기 *
<hr/>
<br>
<table border="1">
<tr><th>코드</th><th>이름</th><th>제목</th><th>내용</th></tr>
<%
ArrayList<Dto> list = test.getDataAll();
for(Dto s: list) {
%>
<tr>
	<td><%= s.getCode() %></td>
	<td><%= s.getName() %></td>
	<td><%= s.getSubject() %></td>
	<td><%= s.getContents() %></td> 
</tr>
<% 	  
}
%>
</table>
<a href="insert.html"> ☞ 글쓰기</a> 
</body>
</html>