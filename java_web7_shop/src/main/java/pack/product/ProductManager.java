package pack.product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;



public class ProductManager {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DataSource ds;
	public ProductManager() {
		try {
			Context context = new InitialContext();
			ds = (DataSource)context.lookup("java:comp/env/jdbc_maria");
		} catch (Exception e) {
			System.out.println("db 연결 실패" + e);
		}
	}
	
	public ArrayList<ProductDto> getProductAll() { // 한명의 자료 읽기
		 ArrayList<ProductDto> plist = new ArrayList<ProductDto>();
		try {
			String sql = "select * from shop_product order by no desc";
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ProductDto dto = new ProductDto();
				dto.setNo(rs.getInt("no"));
				dto.setName(rs.getString("name"));
				dto.setPrice(rs.getString("price"));
				dto.setDetail(rs.getString("detail"));
				dto.setSdate(rs.getString("sdate"));
				dto.setStock(rs.getString("stock"));
				dto.setImage(rs.getString("image"));
				
				
				plist.add(dto);
			}
		} catch (Exception e) {
			System.out.println("getProductAll err : "+e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
				
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		return plist;
	}
	 
	// 파일 업로드가 있는 insert : cos.jar 사용
	public boolean insertProduct(HttpServletRequest request) {
		// System.out.println(request.getParameter("name"));
		// System.out.println(request.getParameter("price"));
		boolean b = false;
		try {
			// 업로드할 폴더 경로는 절대경로
			String uploadDir = "C:/Users/acorn/git/web_pratice/java_web7_shop/src/main/webapp/upload";
			
			MultipartRequest multi = new MultipartRequest(request, uploadDir, 5*1024*1024, "utf-8", new DefaultFileRenamePolicy()); // 파일크기 5메가 이하
			// System.out.println(request.getParameter("name"));
			conn = ds.getConnection();
			String sql = "insert into shop_product (name,price,detail,sdate,stock,image) values (?,?,?,now(),?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, multi.getParameter("name"));
			pstmt.setString(2, multi.getParameter("price"));
			pstmt.setString(3, multi.getParameter("detail"));
			pstmt.setString(4, multi.getParameter("stock"));
			
			if(multi.getFilesystemName("image") == null) {
				pstmt.setString(5, "ready.gif");
			} else {
				pstmt.setString(5, multi.getFilesystemName("image"));
			}
			if(pstmt.executeUpdate() >0) b = true;
		} catch (Exception e) {
			System.out.println("insertProduct err : "+e);
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
	
	public ProductDto getProduct(String no) {
		ProductDto dto = null;
		try {
			String sql = "select * from shop_product where no=?";
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, no);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new ProductDto();
				dto.setNo(rs.getInt("no"));
				dto.setName(rs.getString("name"));
				dto.setPrice(rs.getString("price"));
				dto.setDetail(rs.getString("detail"));
				dto.setSdate(rs.getString("sdate"));
				dto.setStock(rs.getString("stock"));
				dto.setImage(rs.getString("image"));
			}
		} catch (Exception e) {
			// TODO: handle exception
		}  finally {
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
}
