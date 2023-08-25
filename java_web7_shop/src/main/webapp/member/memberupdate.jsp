<%@page import="pack.member.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 현재 로그인한 개인 회원 정보 수정용 --%>
<jsp:useBean id="memberMgr" class="pack.member.MemberManager" />
<%
// 로그인 한 경우만 회원수정이 가능
request.setCharacterEncoding("utf-8");
String id = (String)session.getAttribute("idKey");

MemberDto dto = memberMgr.getMember(id);

if(dto == null){
   response.sendRedirect("../guest/guest_index.jsp");
   return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원수정</title>
<link rel="stylesheet" type="text/css" href="../css/style.css">
<script type="text/javascript" src="../js/script.js"></script>
<script>
window.onload = function(){
    document.getElementById("btnUpdate").onclick = memberUpdate;
    document.getElementById("btnUpdateCancel").onclick = memberUpdateCancel;
    document.getElementById("btnDelete").onclick = memberDelete;
 }
</script>

</head>
<body>
   <table>
      <tr>
         <td align="center">
            <form name="upForm" method="post" action="memberupdateproc.jsp">
               <table border="1">
                  <tr align="center" style="background-color: #00f">
                     <td colspan="2">
                     <b style="color: #ffff00"><%=dto.getName() %> 회원 수정</b>
                     </td>
                  </tr>
                  <tr>
                     <td width="16%">아이디</td>
                     <td width="57%"><%=dto.getId() %>
                     </td>
                  </tr>
                  <tr>
                     <td>패스워드</td> 
                     <td><input type="password" name="passwd" size="15" value="<%=dto.getPasswd()%>"></td>
                  </tr>
               
                  <tr>
                     <td>이름</td>
                     <td><input type="text" name="name" size="15" value="<%=dto.getName()%>"></td>
                  </tr>
                  <tr>
                     <td>이메일</td>
                     <td><input type="text" name="email" size="27" value="<%=dto.getEmail()%>"></td>
                  </tr>
                  <tr>
                     <td>전화번호</td>
                     <td><input type="text" name="phone" size="20" value="<%=dto.getPhone()%>"></td>
                  </tr>
                  <tr>
                     <td>우편번호</td>
                     <td>
                        <input type="text" name="zipcode" size="7"  value="<%=dto.getZipcode()%>"> 
                     </td>
                  </tr>
                  <tr>
                     <td>주소</td>
                     <td><input type="text" name="address" size="60"  value="<%=dto.getAddress()%>"></td>
                  </tr>
                  <tr>
                     <td>직업</td>
                     <td>
                        <select name="job">
                           <option value="<%=dto.getJob()%>"><%=dto.getJob()%>
                           <option value="회사원">회사원
                           <option value="학생">학생
                           <option value="자영업">자영업
                           <option value="기타">기타
                        </select>
                     </td>
                  </tr>
                  <tr>
                     <td colspan="2" style="text-align: center;">
                        <input type="button" value="수정완료" id="btnUpdate">&nbsp;&nbsp;
                        <input type="button" value="수정취소" id="btnUpdateCancel">&nbsp;&nbsp;
                        <input type="reset" value="회원탈퇴" id="btnDelete">
                     </td>
                  </tr>
               </table>
            </form>
         </td>
      </tr>
      </table>
</body>
</html>