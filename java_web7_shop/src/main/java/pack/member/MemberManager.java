package pack.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberManager {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DataSource ds;
	
	public MemberManager() {
		try {
			Context context = new InitialContext();
			ds = (DataSource)context.lookup("java:comp/env/jdbc_maria");
		} catch (Exception e) {
			System.out.println("db 연결 실패" + e);
		}
	}
	
	// 우편번호 검색
	public ArrayList<ZipcodeDto> zipcodeRead(String dongName) {
		// System.out.println(dongName);
		ArrayList<ZipcodeDto> list = new ArrayList<ZipcodeDto>();
		try {
			String sql = "select * from ziptab where area3 like ?";
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dongName +"%");
			rs = pstmt.executeQuery();
			while(rs.next()) {
				// System.out.println(rs.getString("area3"));
				ZipcodeDto dto = new ZipcodeDto();
				dto.setZipcode(rs.getString("zipcode"));
				dto.setArea1(rs.getString("area1"));
				dto.setArea2(rs.getString("area2"));
				dto.setArea3(rs.getString("area3"));
				dto.setArea4(rs.getString("area4"));
				list.add(dto);
			}
		} catch (Exception e) {
			System.out.println("zipcodeRead err : "+e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		return list;
	}
	
	public boolean checkId(String id) {
		boolean b = false;
		try {
			String sql = "select id from member where id=?";
			// String sql = "select count(id) from member where id=?"; // 위와 같음. 건수로 id 있는지 없는지 판별
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			b = rs.next();
		} catch (Exception e) {
			System.out.println("checkId err : "+e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
			
		return b;
	}
	
	public boolean memberInsert(MemberBean bean) {
		boolean b = false;
		try {
			String sql = "insert into member values(?,?,?,?,?,?,?,?)";
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bean.getId());
			pstmt.setString(2, bean.getPasswd());
			pstmt.setString(3, bean.getName());
			pstmt.setString(4, bean.getEmail());
			pstmt.setString(5, bean.getPhone());
			pstmt.setString(6, bean.getZipcode());
			pstmt.setString(7, bean.getAddress());
			pstmt.setString(8, bean.getJob());
			if(pstmt.executeUpdate() >0) b = true;
		} catch (Exception e) {
			System.out.println("memberInsert err : "+e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		return b;
	}
	 
	public boolean loginCheck(String id, String passwd) { // 로그인 할 수 있냐 없냐
		boolean b = false;
		try {
			String sql = "select id,passwd from member where id=? and passwd=?";
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, passwd);
			rs = pstmt.executeQuery();
			b = rs.next();
		} catch (Exception e) {
			System.out.println("loginCheck err : "+e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		
		return b;
	}
	 
	public MemberDto getMember(String id) { // 한명의 자료 읽기
		MemberDto dto = null;
		try {
			String sql = "select * from member where id=?";
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new MemberDto();
				dto.setId(rs.getString("id"));
				dto.setPasswd(rs.getString("passwd"));
				dto.setName(rs.getString("name"));
				dto.setEmail(rs.getString("email"));
				dto.setPhone(rs.getString("phone"));
				dto.setZipcode(rs.getString("zipcode"));
				dto.setAddress(rs.getString("address"));
				dto.setJob(rs.getString("job"));
			}
		} catch (Exception e) {
			System.out.println("getMember err : "+e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		return dto;
	}
	
	public boolean memberUpdate(MemberBean bean, String id) { // 회원정보 수정
		boolean b = false; 
		try {
			String sql = "update member set passwd=?,name=?,email=?,phone=?,zipcode=?,address=?,job=? where id=?";
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,bean.getPasswd());
			pstmt.setString(2,bean.getName());
			pstmt.setString(3,bean.getEmail());
			pstmt.setString(4,bean.getPhone());
			pstmt.setString(5,bean.getZipcode());
			pstmt.setString(6,bean.getAddress());
			pstmt.setString(7,bean.getJob());
			pstmt.setString(8,id);
			if(pstmt.executeUpdate() >0) b = true;
			
		} catch (Exception e) {
			System.out.println("memberUpdate err : "+e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		
		return b;
	}
	
	// 관리자 로그인 처리용 
	public boolean adminLoginCheck(String adminid, String adminpasswd) {
		System.out.println(adminid+" "+adminpasswd);
		boolean b = false;
		try {
			String sql = "select * from admin where admin_id=? and admin_passwd=? ";
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, adminid);
			pstmt.setString(2, adminpasswd);
			rs = pstmt.executeQuery();
			b = rs.next();
		} catch (Exception e) {
			System.out.println("adminLoginCheck err : "+e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		return b;
	}
	
	public ArrayList<MemberDto> getMemberAll() { // 전체 자료 읽기
		 ArrayList<MemberDto> mlist = new ArrayList<MemberDto>();
		try {
			String sql = "select * from member order by id asc";
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				MemberDto dto = new MemberDto();
				dto = new MemberDto();
				dto.setId(rs.getString("id"));
				dto.setPasswd(rs.getString("passwd"));
				dto.setName(rs.getString("name"));
				dto.setEmail(rs.getString("email"));
				dto.setPhone(rs.getString("phone"));
				dto.setZipcode(rs.getString("zipcode"));
				dto.setAddress(rs.getString("address"));
				dto.setJob(rs.getString("job"));
				mlist.add(dto);
			}
		} catch (Exception e) {
			System.out.println("getMemberAll err : "+e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		return mlist;
	}

}



























