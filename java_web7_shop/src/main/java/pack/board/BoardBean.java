package pack.board;

import java.time.LocalDate;

import lombok.Data;



@Data


// Window -> ShowView -> Outline에서 getter, setter 만들어진거 볼 수 있음
public class BoardBean {
	private String name, pass, mail, title, cont, bip, bdate;
	private int num, readcnt, gnum, onum, nested;
	
	public void setBdate() {
		// setBdata() argument 없는 걸로 overloading
		// 등록일(작성일)을 위해 오버로딩
		LocalDate now = LocalDate.now();
		int year = now.getYear();
		int month = now.getMonthValue();
		int day = now.getDayOfMonth();
		this.bdate = year + "-" +month+"-"+day;

	}
}
