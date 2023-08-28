<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
session.removeAttribute("adminKey");
%>
<script>
alert("관리자 로그아웃 성공!");
location.href="../guest/guest_index.jsp";
</script>