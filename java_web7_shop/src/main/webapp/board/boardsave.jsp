<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="bean" class="pack.board.BoardBean"></jsp:useBean>
<jsp:setProperty property="*" name="bean"/>
<jsp:useBean id="boardMgr" class="pack.board.BoardManager"></jsp:useBean>

<%
int maxNum = boardMgr.currentGetMaxNum() +1; // 새 글 번호
bean.setNum(maxNum);
bean.setGnum(maxNum);
bean.setBip(request.getRemoteAddr()); // 사용자 컴 주소 반환
bean.setBdate();
boardMgr.saveData(bean);

response.sendRedirect("boardlist.jsp?page=1");
%>