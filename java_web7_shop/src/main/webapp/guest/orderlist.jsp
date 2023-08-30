<%@page import="pack.product.ProductDto"%>
<%@page import="pack.order.OrderBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="orderMgr" class="pack.order.OrderManager"></jsp:useBean>
<jsp:useBean id="productMgr" class="pack.product.ProductManager"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 정보</title>
<link rel="stylesheet" type="text/css" href="../css/style.css">
<script type="text/javascript" src="../js/script.js"></script>
</head>
<body>
** 주문 상품 정보 **<p/>
<%@include file="guest_top.jsp" %>
<br>
<table style="width:90%; text-align: center">
	<tr style="background-color: silver">
	<th>주문번호</th><th>상품명</th><th>주문수량</th><th>주문일자</th><th>주문상태</th>
	</tr>
	<%
	String id = (String)session.getAttribute("idKey");
	ArrayList<OrderBean> list = orderMgr.getOrder(id); 
	if(list.size()==0) {
	%>
	<tr><td colspan="5">주문한 상품이 없습니다.</td></tr>
	<% 
	} else {
		for(OrderBean ord:list) {
			ProductDto product = productMgr.getProduct(ord.getProduct_no());
	%>
	<tr>
		<td><%=ord.getNo() %></td>
		<td><%=product.getName() %></td>  
		<td><%=ord.getQuantity() %></td>
		<td><%=ord.getSdate() %></td>
		<td>
			<%-- <%=ord.getState()%> --%>  
		<%
			switch(ord.getState()){
			case "1" : out.println("접수");break;
			case "2" : out.println("입금확인");break;
			case "3" : out.println("배송준비");break;
			case "4" : out.println("배송중");break;
			case "5" : out.println("처리완료");break;
			default : out.println("접수중");
			}
		%>
		</td>
	</tr>
	<%
		}
	}
	%>
</table>
<%@include file="guest_bottom.jsp" %>
</body>
</html>