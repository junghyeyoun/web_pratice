package pack.product;

import lombok.Data;

@Data
public class ProductDto {
	private int no;
	private String name,price,detail,sdate,stock,image; 
}
