<%@page import="pack.product.ProductDto"%>
<%@page import="pack.order.OrderBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="orderMgr" class="pack.order.OrderManager"></jsp:useBean>
<jsp:useBean id="productMgr" class="pack.product.ProductManager"></jsp:useBean>
<%
OrderBean order = orderMgr.getOrderDetail(request.getParameter("no")); 
ProductDto product = productMgr.getProduct(order.getProduct_no());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문관리</title>
<link rel="stylesheet" type="text/css" href="../css/style.css">
<script type="text/javascript" src="../js/script.js"></script>
</head>
<body>
** 주문정보 상세보기 **<p/>
<%@ include file="admin_top.jsp"%>
<br>
<form action="orderproc_admin.jsp" name="detailFrm" method="post">
<table style="width:90%">
	<tr>
		<td>고객id : <%= order.getId() %></td>
		<td>주문번호 : <%= order.getNo() %></td>
		<td>상품번호 : <%= product.getNo() %></td>
		<td>상품명 : <%= product.getName() %></td>
	</tr>
	<tr>
		<td>상품가격 : <%= product.getPrice() %></td>
		<td>주문수량 : <%= order.getQuantity() %></td>
		<td>재고량 : <%= product.getStock() %></td>
		<td>주문일 : <%= product.getSdate() %></td>
	</tr>
	<tr>
		<td colspan="4">결제 총액 : <%=Integer.parseInt(product.getPrice()) * Integer.parseInt(order.getQuantity()) %></td>
	</tr>
	<tr>
		<td colspan="4" style="text-align: center;">
		주문 상태 :
		<select name="state">
			<option value="1">접수</option>
			<option value="2">입금확인</option>
			<option value="3">배송준비</option>
			<option value="4">배송중</option>
			<option value="5">처리완료</option>
		</select>
		<script type="text/javascript">
		documemt.detailFrm.state.value=<%=order.getState()%>
		</script>
		</td>
	</tr>
	<tr>
		<td colspan="4" style="text-align: center;">
			<input type="button" value="수정" onclick="orderUpdate(this.form)">
			<input type="button" value="삭제" onclick="orderDelete(this.form)">  
			<input type="hidden" name="no" value="<%=order.getNo() %>">
			<input type="hidden" name="flag">
		</td>
	</tr>
</table>
</form>
<%@ include file="admin_bottom.jsp"%>
</body>
</html>