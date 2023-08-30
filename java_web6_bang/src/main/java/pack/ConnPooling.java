package pack;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ConnPooling {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DataSource ds;
	
	public ConnPooling() {
		try {
			Context context = new InitialContext();
			ds = (DataSource)context.lookup("java:comp/env/jdbc_maria");
		} catch (Exception e) {
			System.out.println("db 연결 실패" + e);
		}
	}
	public ArrayList<Dto> getDataAll() {
		ArrayList<Dto> list = new ArrayList<Dto>();
		try {
			conn = ds.getConnection();
			pstmt = conn.prepareStatement("select * from miniguest");
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Dto dto = new Dto();
				dto.setCode(rs.getString("code"));
				dto.setName(rs.getString("name"));
				dto.setSubject(rs.getString("subject"));
				dto.setContents(rs.getString("contents"));
				list.add(dto);
			}
		} catch (Exception e) {
			System.out.println("getDataAll err : " +e);
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
	
	public boolean insertData(BangBean bean) {
		boolean b = false;
		try {
			String sql = "select max(code) as max from miniguest";
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			int maxCode = 0;
			if(rs.next()) {
				maxCode = rs.getInt("max");
			}
			maxCode++;
			System.out.println("신상 코드 : "+maxCode);
			pstmt.close();
			
			sql = "insert into miniguest values(?,?,?,?)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, maxCode);
			pstmt.setString(2, bean.getName());
			pstmt.setString(3, bean.getSubject());
			pstmt.setString(4, bean.getContents());
			int re = pstmt.executeUpdate();
			if(re == 1) b=true; 
		} catch (Exception e) {
			// TODO: handle exception
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
}
