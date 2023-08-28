<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
session.removeAttribute("idKey");
// session.invalidate(); 
// 차이점 : invalidate() 메소드는 세션의 모든 속성 값을 제거하기 떄문에 removeAttribute()메소드를 사용할 때 처럼 각 속성 값들을 하나씩 제거할 필요가 없다.
%>
<script>
alert("로그아웃 성공");
location.href="../guest/guest_index.jsp"
</script>