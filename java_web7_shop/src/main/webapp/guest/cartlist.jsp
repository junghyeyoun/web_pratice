<%@page import="pack.product.ProductDto"%>
<%@page import="pack.order.OrderBean"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Hashtable"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="cartMgr" class="pack.order.CartManager" scope="session" />
<jsp:useBean id="productMgr" class="pack.product.ProductManager" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 주문</title>
<link href="../css/style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../js/script.js"></script>
</head>
<body>
** 장바구니 목록 **
<%@include file="guest_top.jsp" %>
<br/>

<table style="width: 90%; text-align: center;">
    <tr style="background-color: pink;">
        <th>주문상품</th><th>가격(소계)</th><th>주문수량</th><th>수정/삭제</th><th>조회</th>
    </tr>
    <%
    int totalPrice = 0;
    Hashtable hCart = cartMgr.getCartList();
    if(hCart.size() == 0){
    %>
    <tr><td colspan="5">주문 건수가 없어요</td></tr>
    <%
    }else{
       // 컬렉션 값 읽기 Enumeration
       Enumeration enu = hCart.keys();
       while(enu.hasMoreElements()){
          OrderBean order = (OrderBean)hCart.get(enu.nextElement());
          ProductDto product = productMgr.getProduct(order.getProduct_no());  // 해당 상품번호의 상품을 가져옴
          int price = Integer.parseInt(product.getPrice());
          int quantity = Integer.parseInt(order.getQuantity());
          int subTotal = price * quantity;  // 소계
          totalPrice += subTotal;  // 총계
    %>
    <form action="cartproc.jsp" method="get">
        <input type="hidden" name="flag" />
        <input type="hidden" name="product_no" value="<%=product.getNo() %>"/>
        <tr>
            <td><%=product.getName() %></td>
            <td><%=subTotal %></td>
            <td>
                <input style="text-align: center;" type="text" name="quantity" size="5" value="<%=quantity %>"> 개
            </td>
            <td>
                <input style="background-color: aqua ;" type="button" value="수정" onclick="cartUpdate(this.form)"> /
                <input style="background-color: silver;" type="button" value="삭제" onclick="cartDelete(this.form)">
             </td>
            <td>
           		<a href="javascript:productDetailCart('<%= product.getNo()%>')">상세보기</a> 
            </td>
        </tr>
     </form>
    <%
       }
    %>
        <tr>
            <td colspan="5">
                <br/>
                <b>총 결제 금액 : <%=totalPrice %></b>
                <br/>
                <a href="orderproc.jsp">[주문 하기]</a> <%-- 장바구니에 담긴 상품 주문하기 --%>
            </td>
        </tr>
    <%
    }
    %>
</table>

<%@include file="guest_bottom.jsp" %>

<form action="productdetail_g.jsp" name="detailFrm">
	<input type="hidden" name="no">
</form>
</body>
</html>