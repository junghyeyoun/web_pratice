<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자</title>
<link rel="stylesheet" type="text/css" href="../css/style.css">
<script type="text/javascript" src="../js/script.js"></script>
<script type="text/javascript">
window.onload = function() {
	document.querySelector("#btnAdiminLogin").onclick = funcAdminLogin;
	document.querySelector("#btnAdiminHome").onclick = funcAdminHome;
}

function funcAdminLogin() {
	// alert("a");
	if(adminloginFrom.adminid.value === ""){
		alert("관리자 id를 입력하시오");
		adminloginFrom.adminid.focus();
		return;
	}
	
	if(adminloginFrom.adminpasswd.value === ""){
		alert("관리자 passwd를 입력하시오");
		adminloginFrom.adminpasswd.focus();
		return;
	}
	
	adminloginFrom.submit();
}

function funcAdminHome() {
	// alert("b");
	location.href = "../guest/guest_index.jsp";
}
</script>
</head>
<body>
<form action="adminloginproc.jsp" name="adminloginFrom" method="post">
<table style="width: 300">
	<tr>
		<td colspan="2" style="text-align: center;" >* 관리자 로그인 *</td>
	</tr>
	<tr>
		<td>id : </td>
		<td><input type="text" name="adminid"></td>
	</tr>
	<tr>
		<td>pwd : </td>
		<td><input type="text" name="adminpasswd"></td>
	</tr>
	<tr>
		<td colspan="2" style="text-align: center;" >
			<input type="button" value="관리자 로그인" id="btnAdiminLogin">
			<input type="button" value="메인 페이지" id="btnAdiminHome">
		</td>
	</tr>
</table>
</form>
</body>
</html>