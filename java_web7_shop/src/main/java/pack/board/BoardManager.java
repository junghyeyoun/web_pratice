package pack.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;


import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardManager {

   private Connection conn;
   private PreparedStatement pstmt;
   private ResultSet rs;
   private DataSource ds;

   // paging 처리용
   private int recTot; // 전체 레코드 수
   private int pList = 8; // 페이지 당 출력 행 갯수
   private int pageSu; // 전체 페이지 수

   public BoardManager() {
      try {
         Context context = new InitialContext();
         ds = (DataSource) context.lookup("java:comp/env/jdbc_maria");
      } catch (Exception e) {
         System.out.println("db 연결 실패 : " + e.getMessage());
      }
   }

   public int currentGetMaxNum() { // 새 글 번호 입력용
      int cnt = 0;
      try {
         String sql = "select max(num) from board";
         conn = ds.getConnection();
         pstmt = conn.prepareStatement(sql);
         rs = pstmt.executeQuery();
         if (rs.next())
            cnt = rs.getInt(1);
      } catch (Exception e) {
         System.out.println("currentGetMaxNum err :" + e);
      } finally {
         try {
            if (rs != null)
               rs.close();
            if (pstmt != null)
               pstmt.close();
            if (conn != null)
               conn.close();
         } catch (Exception e2) {
            // TODO: handle exception
         }
      }
      return cnt;

   }

   public void saveData(BoardBean bean) {
      // System.out.println(bean.getTitle()+ " " + bean.getName());
      try {
         String sql = "insert into board values(?,?,?,?,?,?,?,?,?,?,?,?)";
         conn = ds.getConnection();
         pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1, bean.getNum());
         pstmt.setString(2, bean.getName());
         pstmt.setString(3, bean.getPass());
         pstmt.setString(4, bean.getMail());
         pstmt.setString(5, bean.getTitle());
         pstmt.setString(6, bean.getCont());
         pstmt.setString(7, bean.getBip());
         pstmt.setString(8, bean.getBdate());
         pstmt.setInt(9, 0); // readcnt
         pstmt.setInt(10, bean.getGnum());
         pstmt.setInt(11, 0);
         pstmt.setInt(12, 0);

         rs = pstmt.executeQuery();

      } catch (Exception e) {
         System.out.println("saveData err :" + e);
      } finally {
         try {
            if (rs != null)
               rs.close();
            if (pstmt != null)
               pstmt.close();
            if (conn != null)
               conn.close();
         } catch (Exception e2) {
            // TODO: handle exception
         }
      }
   }

   // public ArrayList<BoardDto> getDataAll(){
   public ArrayList<BoardDto> getDataAll(String stype, String sword, int page) { // 검색 결과도 반환 가능
      // System.out.println(stype + " " + sword);

      ArrayList<BoardDto> list = new ArrayList<BoardDto>();
      try {
         // String sql = "select * from board order by gnum desc";
         String sql = "select * from board";
         conn = ds.getConnection();
         if (sword == null) {
            sql += " order by gnum desc, onum asc";
            pstmt = conn.prepareStatement(sql);
         } else {
            sql += " where " + stype + " like ?";
            sql += " order by gnum desc, onum asc";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "%" + sword + "%");
         }
         System.out.println(sql);

         rs = pstmt.executeQuery();

         for (int i = 0; i < (page - 1) * pList; i++) {
            rs.next(); // 레코드 포인터 위치
            // 1 page: 0
            // 2 page: 4
            // 3 page: 9

         }
         int k = 0;
         while (rs.next() && k < pList) {
            BoardDto dto = new BoardDto();
            dto.setNum(rs.getInt("num"));
            dto.setName(rs.getString("name"));
            dto.setTitle(rs.getString("title"));
            dto.setBdate(rs.getString("bdate"));
            dto.setReadcnt(rs.getInt("readcnt"));
            dto.setNested(rs.getInt("nested"));
            list.add(dto);
            k++;
         }
      } catch (Exception e) {
         System.out.println("getDataAll err :" + e);
      } finally {
         try {
            if (rs != null)
               rs.close();
            if (pstmt != null)
               pstmt.close();
            if (conn != null)
               conn.close();
         } catch (Exception e2) {
            // TODO: handle exception
         }
      }

      return list;
   }

   public void totalList() { // 레코드 전체 갯수 구하기
      try {
         String sql = "select count(*) from board";
         conn = ds.getConnection();
         pstmt = conn.prepareStatement(sql);
         rs = pstmt.executeQuery();
         rs.next();
         recTot = rs.getInt(1);
         System.out.println("전체 건수 :" + recTot);
      } catch (Exception e) {
         System.out.println("totalList err :" + e);
      } finally {
         try {
            if (rs != null)
               rs.close();
            if (pstmt != null)
               pstmt.close();
            if (conn != null)
               conn.close();
         } catch (Exception e2) {
            // TODO: handle exception
         }
      }
   }

   public int getPageSu() { // 총 페이지 수 반환
      pageSu = recTot / pList;
      if (recTot % pList > 0)
         pageSu++; // 자투리 계산
      return pageSu;
   }

   public void updateReadcnt(String num) { // 글 상세보기 전 조회수 증가
      try {
         String sql = "update board set readcnt = readcnt + 1 where num=?";
         conn = ds.getConnection();
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, num);
         pstmt.executeUpdate();

      } catch (Exception e) {
         System.out.println("updateReadcnt err :" + e);
      } finally {
         try {
            if (rs != null)
               rs.close();
            if (pstmt != null)
               pstmt.close();
            if (conn != null)
               conn.close();
         } catch (Exception e2) {
            // TODO: handle exception
         }
      }
   }

   public BoardDto getData(String num) {
      BoardDto dto = null;
      try {
         String sql = "select * from board where num=?";
         conn = ds.getConnection();
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, num);
         rs = pstmt.executeQuery();
         if (rs.next()) {
            dto = new BoardDto();
            dto.setNum(rs.getInt("num"));
            dto.setName(rs.getString("name"));
            dto.setPass(rs.getString("pass"));
            dto.setMail(rs.getString("mail"));
            dto.setTitle(rs.getString("title"));
            dto.setCont(rs.getString("cont"));
            dto.setBip(rs.getString("bip"));
            dto.setBdate(rs.getString("bdate"));
            dto.setReadcnt(rs.getInt("readcnt"));
         }
      } catch (Exception e) {
         System.out.println("getData err :" + e);
      } finally {
         try {
            if (rs != null)
               rs.close();
            if (pstmt != null)
               pstmt.close();
            if (conn != null)
               conn.close();
         } catch (Exception e2) {
            // TODO: handle exception
         }
      }

      return dto;
   }

   public BoardDto getReplyData(String num) { // 댓글용 원글 읽기
      BoardDto dto = null;
      // System.out.println(num);
      try {
         String sql = "select * from board where num=?";
         conn = ds.getConnection();
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, num);
         rs = pstmt.executeQuery();
         if (rs.next()) {
            dto = new BoardDto();
            dto.setTitle(rs.getString("title"));
            dto.setGnum(rs.getInt("gnum"));
            dto.setOnum(rs.getInt("onum"));
            dto.setNested(rs.getInt("nested"));
         }
         // System.out.println(dto.getTitle());
      } catch (Exception e) {
         System.out.println("getReplyData err :" + e.getMessage());
      } finally {
         try {
            if (rs != null)
               rs.close();
            if (pstmt != null)
               pstmt.close();
            if (conn != null)
               conn.close();
         } catch (Exception e2) {
            // TODO: handle exception
         }
      }
      return dto;
   }
   
   public void updateOnum(int gnum, int onum) {   // 댓글용 - onum 
      try {
         String sql = "update board set onum = onum+1 where onum >= ? and gnum=?";
         conn = ds.getConnection();
         pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1, onum);
         pstmt.setInt(2, gnum);
         pstmt.executeUpdate();
      } catch (Exception e) {
         System.out.println("updateOnum err :" + e.getMessage());
      } finally {
         try {
            if (rs != null)
               rs.close();
            if (pstmt != null)
               pstmt.close();
            if (conn != null)
               conn.close();
         } catch (Exception e2) {
            // TODO: handle exception
         }
      }
   }
   
   public void saveReplyData(BoardBean bean) {   // 댓글 저장
      try {
         String sql = "insert into board values(?,?,?,?,?,?,?,?,?,?,?,?)";
         conn = ds.getConnection();
         pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1, bean.getNum());
         pstmt.setString(2, bean.getName());
         pstmt.setString(3, bean.getPass());
         pstmt.setString(4, bean.getMail());
         pstmt.setString(5, bean.getTitle());
         pstmt.setString(6, bean.getCont());
         pstmt.setString(7, bean.getBip());
         pstmt.setString(8, bean.getBdate());
         pstmt.setInt(9, 0); // readcnt
         pstmt.setInt(10, bean.getGnum());
         pstmt.setInt(11, bean.getOnum());
         pstmt.setInt(12, bean.getNested());
         pstmt.executeUpdate();
         
      } catch (Exception e) {
         System.out.println("saveReplyData err :" + e.getMessage());
      } finally {
         try {
            if (rs != null)
               rs.close();
            if (pstmt != null)
               pstmt.close();
            if (conn != null)
               conn.close();
         } catch (Exception e2) {
            // TODO: handle exception
         }
      }
   }
   
   public boolean checkPass(int num, String new_pass) {
      boolean b = false;
      try {
         String sql = "select pass from board where num=?";
         conn = ds.getConnection();
         pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1, num);
         rs = pstmt.executeQuery();
         if(rs.next()) {
            if(new_pass.equals(rs.getString("pass"))){
               b = true;
            }
         }
      } catch (Exception e) {
         System.out.println("checkPass err :" + e.getMessage());
      } finally {
         try {
            if (rs != null)
               rs.close();
            if (pstmt != null)
               pstmt.close();
            if (conn != null)
               conn.close();
         } catch (Exception e2) {
            // TODO: handle exception
         }
      }
      return b;
   }
   
   public void updateData(BoardBean bean) {
      try {
         String sql = "update board set name=?, mail=?, title=?, cont=? where num=?" ;
         
         conn = ds.getConnection();
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, bean.getName());
         pstmt.setString(2, bean.getMail());
         pstmt.setString(3, bean.getTitle());
         pstmt.setString(4, bean.getCont());
         pstmt.setInt(5, bean.getNum());
         pstmt.executeUpdate();
         
      } catch (Exception e) {
         System.out.println("updateData err :" + e.getMessage());
      } finally {
         try {
            if (rs != null)
               rs.close();
            if (pstmt != null)
               pstmt.close();
            if (conn != null)
               conn.close();
         } catch (Exception e2) {
            // TODO: handle exception
         }
      }
   }
   
   public void delData(String num) {
      try {
         String sql = "delete from board where num=?";
         conn = ds.getConnection();
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, num);
         pstmt.executeUpdate();
      } catch (Exception e) {
         System.out.println("delData err :" + e.getMessage());
      } finally {
         try {
            if (rs != null)
               rs.close();
            if (pstmt != null)
               pstmt.close();
            if (conn != null)
               conn.close();
         } catch (Exception e2) {
            // TODO: handle exception
         }
      }
   }
}