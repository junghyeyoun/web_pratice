<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="bean" class="pack.BangBean"></jsp:useBean>
<jsp:setProperty property="*" name="bean"/>

<jsp:useBean id="test" class="pack.ConnPooling"></jsp:useBean>
<%
boolean b = test.insertData(bean);
	
if(b){
	response.sendRedirect("show.jsp");
} else {
	response.sendRedirect("error.jsp");
}
%>