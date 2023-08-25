<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8");%>
<jsp:useBean id="mBean" class="pack.member.MemberBean"></jsp:useBean>
<jsp:setProperty property="*" name="mBean"/>
<jsp:useBean id="memberMgr" class="pack.member.MemberManager"></jsp:useBean>

<% 
 boolean b = memberMgr.memberInsert(mBean);

if(b) {
	// out.println("회원가입을 축하합니다.");
	response.sendRedirect("../guest/guest_index.jsp");
} else {
	// out.println("회원가입을 실패하셨습니다.");
	response.sendRedirect("insertfail.html");
}
%>