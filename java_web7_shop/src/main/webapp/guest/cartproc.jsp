<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="cartMgr" class="pack.order.CartManager" scope="session" />
<%-- scope에 session 써야 session이 살아 있는 동안 누적됨 / 기본값은 page --%>
<jsp:useBean id="order" class="pack.order.OrderBean" />
<jsp:setProperty property="*" name="order"/>

<%
String flag = request.getParameter("flag");  // 구매목록 보기, 수정, 삭제, 판단용
String id = (String)session.getAttribute("idKey");
//out.print(order.getProduct_no() + " " + order.getQuantity());

if(id == null){
   response.sendRedirect("../member/login.jsp");  // 로그인을 안한 경우
}else{
   if(flag == null){
      // cart에 주문 상품 담기
      order.setId(id);
      cartMgr.addCart(order);  // 인수의 내용 : product_no, quantity, id
%>
    <script>
        alert("장바구니 담기 성공");
        location.href="cartlist.jsp";
    </script>
<%
   }else if(flag.equals("update")){
      //out.print("u");
      order.setId(id);    // 아이디 담아서 감 String id = (String)session.getAttribute("idKey");
      cartMgr.updateCart(order);
%>
    <script>
        alert("장바구니 수정 성공");
        location.href="cartlist.jsp";
    </script>
<%
   }else if(flag.equals("del")){
      //out.print("d");
      cartMgr.deleteCart(order);
%>
    <script>
        alert("해당 상품의 주문을 삭제했어요");
        location.href="cartlist.jsp";
    </script>
<%      
   }
}
%>
