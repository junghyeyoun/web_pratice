<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쇼핑몰</title>
<link rel="stylesheet" type="text/css" href="../css/style.css">
<script type="text/javascript" src="../js/script.js"></script>
</head>
<body >
   <table style="width:90%;">
      <tr>
         <td style="font-size:20px;">전문 쇼핑몰</td>
      </tr>
   </table>
   
   <%@include file="guest_top.jsp" %>
   
   <table style="width:90%; text-align: center">
   <% if(memid != null){ %>
      <tr>
         <td style="font-size: 22px">
            <%=memid %>님~ 방문을 환영합니다!
            <img src="../images/pic2.gif"> 
         </td>
      </tr>
   <%}else{ %>
      <tr>
         <td style="text-align:left; font-size:22px; background-image:url(../images/pic.jpg); background-size:100%;">
            <br><br><br><br>
            고객님 어서오세요<br><br>
            로그인 후 이용바랍니다.
            <br><br><br><br>
         </td>
      </tr>
   <%} %>
   </table>
   
   <%@include file="guest_bottom.jsp" %>
</body>
</html>