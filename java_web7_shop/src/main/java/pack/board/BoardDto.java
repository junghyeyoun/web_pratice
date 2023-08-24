package pack.board;

import lombok.Data;

@Data // 생성자, getter, setter
public class BoardDto {
	private String name, pass, mail, title, cont, bip, bdate;
	private int num, readcnt, gnum, onum, nested;
	
}
