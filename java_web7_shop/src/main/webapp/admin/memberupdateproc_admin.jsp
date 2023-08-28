<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8");%>
<jsp:useBean id="mBean" class="pack.member.MemberBean"></jsp:useBean>
<jsp:setProperty property="*" name="mBean"/>
<jsp:useBean id="memberMgr" class="pack.member.MemberManager"></jsp:useBean>

<% 
boolean b = memberMgr.memberUpdate(mBean,mBean.getId());   
 

if(b) {
%>
	<script>
	alert("수정 성공");
	location.href="membermanager.jsp"
	</script>
<% } else {%>
	<script>
	alert("수정 실패\n 관리자에게 문의 바람");
	histroy.back();
	</script>
<%
}
%>