<%@page import="pack.product.ProductDto"%>
<%@page import="pack.order.OrderBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 관리자가 고객이 구매신청한 상품 목록을 보기 --%>
<jsp:useBean id="orderMgr" class="pack.order.OrderManager"></jsp:useBean>
<jsp:useBean id="productMgr" class="pack.product.ProductManager"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문관리</title>
<link rel="stylesheet" type="text/css" href="../css/style.css">
<script type="text/javascript" src="../js/script.js"></script>
</head>
<body>
* 주문된 상품 정보 *
<%@ include file="admin_top.jsp" %>
<br>
<table style="width:90%">
	<tr>
		<th>주문번호</th><th>고객id</th><th>상품명</th><th>주문수량</th><th>주문일자</th><th>주문상태</th><th>보기</th>
	</tr>
	<%
	ArrayList<OrderBean> list = orderMgr.getOrderAll(); 
	if(list.size() == 0) {
	%>
	<tr><td colspan="7">주문내역이 없습니다.</td></tr>
	<% 
	} else {
		for(int i=0; i <list.size();i++) {
			OrderBean order = list.get(i);
			ProductDto product = productMgr.getProduct(order.getProduct_no()); // 해당 주문에 관련있는 상품 읽기
	%>
	<tr>
		<td><%= order.getNo() %></td>
		<td><%= order.getId() %></td>
		<td><%= product.getName() %></td>
		<td><%= order.getQuantity() %></td>
		<td><%= order.getSdate() %></td>
		<td>
		<%-- <%= order.getState()%> --%>
		<%
			switch(order.getState()){
			case "1" : out.println("접수");break;
			case "2" : out.println("입금확인");break;
			case "3" : out.println("배송준비");break;
			case "4" : out.println("배송중");break;
			case "5" : out.println("처리완료");break;
			default : out.println("접수중");
			}
		%>
		</td>
		<%-- 상세보기를 누르면 접수,입금확인 등을 바꿀 수 있음 --%>
		<td>
		<a href="javascript:orderDetail('<%= order.getNo() %>')">상세보기</a>
		</td> 
	</tr>
	<% 
		}
	}
	%>
</table>

<%@ include file="admin_bottom.jsp" %>

<form action="orderdetail.jsp" name="detailFrm" method="post">
	<input type="hidden" name="no"/>
</form>
</body>
</html>