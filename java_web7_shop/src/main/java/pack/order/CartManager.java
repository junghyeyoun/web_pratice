package pack.order;

import java.util.Hashtable;

//장바구니 처리용
public class CartManager {
   private Hashtable<String, Object> hCart=new Hashtable<String,Object>();
   
   public void addCart(OrderBean obean) {
      String product_no = obean.getProduct_no();
      int quantity = Integer.parseInt(obean.getQuantity());
      if(quantity > 0) {
         // 동일 상품을 주문할 경우에는 주문 수량만 늘리기
         if(hCart.containsKey(product_no)) { 
            OrderBean imsi = (OrderBean)hCart.get(product_no);
            quantity += Integer.parseInt(imsi.getQuantity());   // 기존에 있던 주문 수량 누적
            imsi.setQuantity(Integer.toString(quantity));
            hCart.put(product_no, imsi);
         }else {
            hCart.put(product_no, obean);      // 새로운 상품 주문인 경우             
         }
      }
   }
   
   public Hashtable<String, Object> getCartList(){ //cart에 저장된 목록 반환
      return hCart;
   }
   
   public void updateCart(OrderBean obean) {
      String product_no = obean.getProduct_no();
      hCart.put(product_no, obean);
   }
   
   public void deleteCart(OrderBean obean) {
      String product_no = obean.getProduct_no();
      hCart.remove(product_no);
   }
}