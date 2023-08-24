<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="bean" class="pack.board.BoardBean"></jsp:useBean>
<jsp:setProperty property="*" name="bean"/>
<jsp:useBean id="boardMgr" class="pack.board.BoardManager"></jsp:useBean>
<%
String spage = request.getParameter("page");
int num = bean.getNum();
int gnum = bean.getGnum();
int onum = bean.getOnum() +1; // 댓글이므로 1 증가
int nested = bean.getNested() +1; // 들여쓰기 1 증가

// 같은 그룹 내에서 새로운 댓글의 onum 보다 크거나 같은 값을 댓글 입력 전에 먼저 수정하기
// 작으면 수정 안함
boardMgr.updateOnum(gnum, onum); // onum 갱신 

// 댓글 자료 저장
bean.setOnum(onum);
bean.setNested(nested);
bean.setBip(request.getRemoteAddr());
bean.setBdate();
bean.setNum(boardMgr.currentGetMaxNum()+1); // 댓(새)글의 num

boardMgr.saveReplyData(bean);
response.sendRedirect("boardlist.jsp?page="+spage); // 댓글 작성 후 글 목록보기로 이동
%>