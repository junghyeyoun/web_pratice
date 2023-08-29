<%@page import="pack.product.ProductDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="productMgr" class="pack.product.ProductManager"></jsp:useBean>
<%
ProductDto dto = productMgr.getProduct(request.getParameter("no"));
// out.print(dto.getName());

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 수정</title>
<link rel="stylesheet" type="text/css" href="../css/style.css">
<script type="text/javascript" src="../js/script.js"></script>
</head>
<body>
<%@ include file="admin_top.jsp" %>
<br>
<form action="productproc.jsp?flag=update" enctype="multipart/form-data" method="post"> <%-- 이미지 안바꿀거면 enctype 안써도 됨 --%>
<table style="width:90%">
	<tr><th colspan="2">* 상품 수정 *</th></tr>
	<tr>
		<td>상품명</td>
		<td><input type="text" name="name" value="<%= dto.getName() %>"></td>
	</tr>
	<tr>
		<td>가격</td>
		<td><input type="text" name="price" value="<%= dto.getPrice() %>"></td>
	</tr>
	<tr>
		<td>설명</td>
		<td><textarea rows="5" style="width:100%" name="detail"><%=dto.getDetail() %></textarea> </td>
	</tr>
	<tr>
		<td>재고량</td>
		<td><input type="text" name="stock" value="<%= dto.getStock() %>"></td>
	</tr>
	<tr>
		<td>이미지</td>
		<td>
		<img src="../upload/<%=dto.getImage()%>" width="150">
		<input type="file" name="image">
		</td>
	</tr>
	<tr>
		<td colspan="2" style="text-align: center;">
		<br>
			<input type="hidden" name="no" value="<%=dto.getNo()%>">
			<input type="submit" value="상품 수정">
			<input type="submit" value="수정 취소" onclick="history.back()">
		</td>
 	</tr>
</table>
</form>
<%@ include file="admin_bottom.jsp" %>
</body>
</html>