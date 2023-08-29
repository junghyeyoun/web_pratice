<%@page import="pack.product.ProductDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="productMgr" class="pack.product.ProductManager"></jsp:useBean>
<%
String no = request.getParameter("no");
// System.out.println("guest no : "+no);
ProductDto dto = productMgr.getProduct(no);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품보기</title>
<link rel="stylesheet" type="text/css" href="../css/style.css">
<script type="text/javascript" src="../js/script.js"></script>
</head>
<body>
** 상품 상세보기 **<p/>
<%@include file="guest_top.jsp" %>
<form action="cartproc.jsp">
 <table style="width:90%">
      <tr>
         <td style="width:20%;">
            <img src="../upload/<%=dto.getImage()%>">
         </td>
         <td style="width:50%; vertical-align:top">
            <table style="width:100%;">
               <tr>
                  <td>번호 : </td><td><%=dto.getNo() %></td>
               </tr>
               <tr>
                  <td>상품명 : </td>
                  <td><%=dto.getName() %></td>
               </tr>
               <tr>
                  <td>가격 : </td>
                  <td><%=dto.getPrice() %></td>
               </tr>
               <tr>
                  <td>등록일 : </td>
                  <td><%=dto.getSdate() %></td>
               </tr>
               <tr>
                  <td>재고량 : </td>
                  <td><%=dto.getStock() %></td>
               </tr>
               <tr>
               	 <td>주문 수량 : </td>
               	 <td>
               	 	<input type="number" min="1" value="1" name="quantity" style="text-align: center; width=2cm;">
               	 	<input type="hidden" name="product_no" value="<%= dto.getNo()%>">
               	 </td>
               </tr>
            </table>
         </td>
         <td style="width:30%; vertical-align:top">
            <b>** 상품 설명 **</b><br>
            <%=dto.getDetail() %>
         </td>
      </tr>
      <tr>
         <td colspan="3" style="text-align:center;">
         	<input type="submit" value="장바구니에 담기">
         	<input type="button" value="이전 페이지로" onclick="history.back()">
         </td>
      </tr>
   </table>
</form>
<%@include file="guest_bottom.jsp" %>
</body>
</html>