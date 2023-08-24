package pack.member;

import lombok.Data;

@Data
public class MemberBean {
	private String id, passwd, name, email, phone, zipcode, address, job;
}
