<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8");%>
<jsp:useBean id="mBean" class="pack.member.MemberBean"></jsp:useBean>
<jsp:setProperty property="*" name="mBean"/>
<jsp:useBean id="memberMgr" class="pack.member.MemberManager"></jsp:useBean>

<% 
String id = (String)session.getAttribute("idKey"); // session에 id를 가지고 있어서 괜찮음
boolean b = memberMgr.memberUpdate(mBean,id);   
 

if(b) {
%>
	<script>
	alert("수정 성공");
	location.href="../guest/guest_index.jsp"
	</script>
<% } else {%>
	<script>
	alert("수정 실패\n 관리자에게 문의 바람");
	histroy.back();
	</script>
<%
}
%>