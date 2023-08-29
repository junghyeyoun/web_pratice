<%@page import="pack.order.OrderBean"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Hashtable"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="cartMgr" class="pack.order.CartManager" scope="session" />
<jsp:useBean id="productMgr" class="pack.product.ProductManager" />
<jsp:useBean id="orderMgr" class="pack.order.OrderManager"></jsp:useBean>

<%--장바구니에 담긴 상품 주문하기 --%> 
<%
Hashtable hCart = cartMgr.getCartList();

Enumeration enu = hCart.keys();
if(hCart.size()==0) {
%>
 	<script>
 	alert("주문 내용이 없어요");
 	location.href = "orderlist.jsp";
 	</script>
<%
} else {
	// System.out.println("카트 크기 : "+hCart.size());
	
	while(enu.hasMoreElements()) {
		OrderBean orderBean = (OrderBean)hCart.get(enu.nextElement());
		orderMgr.insertOrder(orderBean);  // 카트에 내용을 주문 테이블에 저장
		productMgr.reduceProduct(orderBean); // 주문 수량 만큼 상품 재고량에서 줄이기
		cartMgr.deleteCart(orderBean);
	} 
%>
	<script>
	alert("주문 처리가 완료 되었습니다.\n 고객님 사랑합니다♡");
	location.href="orderlist.jsp";
	</script>
<%
}
%>