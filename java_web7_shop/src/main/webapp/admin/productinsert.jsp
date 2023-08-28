<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 추가</title>
<link rel="stylesheet" type="text/css" href="../css/style.css">
<script type="text/javascript" src="../js/script.js"></script>
</head>
<body>
<%@ include file="admin_top.jsp" %>
<br>
<%--  enctype="multipart/form-data" : 주로 대량의 데이터나 파일 전달시 사용 --%>
<form action="productproc.jsp?flag=insert" method="post" enctype="multipart/form-data">
<table style="width:90%">
	<tr><th colspan="2">* 상품 등록 *</th></tr>
	<tr>
		<th>상품명</th>
		<td><input type="text" name="name"></td>
	</tr>
	<tr>
		<th>가격</th>
		<td><input type="text" name="price"></td>
	</tr>
	<tr>
		<th>설명</th>
		<td>
		<textarea rows="5" style="width:98%" name="detail"></textarea>
		</td>
	</tr>
	<tr>
		<th>재고량</th>
		<td><input type="text" name="stock">개</td>
	</tr>
	<tr>
		<th>이미지</th>
		<td><input type="file" name="image" size="30"></td>
	</tr>
	<tr>
		<td colspan="2" style="text-align:center;">
			<br>
			<input type="submit" value="상품 등록">
			<input type="reset" value="새로 입력">
		</td>
	</tr>
</table>
</form>
<%@ include file="admin_bottom.jsp" %>
</body>
</html>