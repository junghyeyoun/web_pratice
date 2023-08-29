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

import pack.order.OrderBean;



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
	
	public ArrayList<ProductDto> getProductAll() { //  전체 상품의 자료 읽기
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
	
	public ProductDto getProduct(String no) { // no가 ?인 하나의 상품 자료 읽기
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
			System.out.println("getProduct err : "+e);
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
	
	// 상품 수정
	public boolean updateProduct(HttpServletRequest request) {
		boolean b = false;
		try {
			// 업로드할 폴더 경로는 절대 경로
			String uploadDir = "C:/Users/acorn/git/web_pratice/java_web7_shop/src/main/webapp/upload";
			
			MultipartRequest multi = new MultipartRequest(request, uploadDir, 5*1024*1024, "utf-8", new DefaultFileRenamePolicy()); // 파일크기 5메가 이하
			// System.out.println( multi.getParameter("name") + multi.getParameter("no"));
			conn = ds.getConnection();
			if(multi.getFilesystemName("image")== null) {
				
				String sql = "update shop_product set name = ?, price=?, detail=?, stock=? where no=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, multi.getParameter("name"));
				pstmt.setString(2, multi.getParameter("price"));
				pstmt.setString(3, multi.getParameter("detail"));
				pstmt.setString(4, multi.getParameter("stock"));
				pstmt.setString(5, multi.getParameter("no"));
			} else {
				String sql = "update shop_product set name = ?, price=?, detail=?, stock=?, image=? where no=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, multi.getParameter("name"));
				pstmt.setString(2, multi.getParameter("price"));
				pstmt.setString(3, multi.getParameter("detail"));
				pstmt.setString(4, multi.getParameter("stock"));
				pstmt.setString(5, multi.getFilesystemName("image"));
				pstmt.setString(6, multi.getParameter("no"));
			}
			if(pstmt.executeUpdate() > 0) b = true;
		} catch (Exception e) {
			System.out.println("updateProduct err : "+e);
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
	
	// 상품 삭제
	public boolean deleteProduct(String no) {
		boolean b = false;
		// System.out.println(no);
		try {
			conn = ds.getConnection();
			String sql = "delete from shop_product where no = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, no);
			if(pstmt.executeUpdate() > 0) b = true;
		} catch (Exception e) {
			System.out.println("deleteProduct err : "+e);
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
	
	// 고객이 상품 주문을 할 경우에 주문 수 만큼 재고에서 빼기
	public void reduceProduct(OrderBean orderBean) {
		try {
			String sql = "update shop_product set stock=(stock -?) where no=?";
			conn = ds.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, orderBean.getQuantity());
			pstmt.setString(2, orderBean.getProduct_no());
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("reduceProduct err : "+e);
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
				
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
	}
}
