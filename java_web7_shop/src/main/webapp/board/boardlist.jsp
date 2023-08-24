<%@page import="pack.board.BoardDto"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="boardMgr" class="pack.board.BoardManager"></jsp:useBean>
<jsp:useBean id="dto" class="pack.board.BoardDto"></jsp:useBean>
<!DOCTYPE html>
<%
int pageSu, spage = 1; 
%>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<link rel="stylesheet" type="text/css" href="../css/board.css">
<script type="text/javascript">
window.onload = function() {
	document.querySelector("#btnSearch").onclick = function() {
		if(frm.sword.value === null){
			frm.sword.focus();
			frm.sword.placeholder = "검색어를 입력";
			return;
		}
		frm.submit();
	}
}
</script>
</head>
<body>
<table>
	<tr>
		<td>
		[<a href="../main.html">메인으로</a>]
		[<a href="boardlist.jsp?page=1">최근목록</a>]
		[<a href="boardwrite.jsp">새글작성</a>]
		[<a href="#" onclick="window.open('../admin/admin.jsp','','width=300, height=200, top=200, left=300')">관리자용</a>]
		<br><br>
		<table style="width=100%">
			<tr style="background-color: silver;">
			<th>번호</th><th>제목</th><th>작성자</th><th>작성일</th><th>조회수</th>
			</tr>
			
			<%
			request.setCharacterEncoding("utf-8");
			
			// 페이징 처리의 spage 값 열기 ------------------
			try{
			spage = Integer.parseInt(request.getParameter("page"));
			} catch(Exception e){
				spage = 1;
			}
			if(spage <= 0) spage = 1;
			// ---------------------------
			
			// 검색 관련
			String stype = request.getParameter("stype");
			String sword = request.getParameter("sword");
			// ----------------------
			
			boardMgr.totalList(); // 전체 레코드 수 계산
			pageSu = boardMgr.getPageSu(); // 전체 페이지수 얻기
			
			// ArrayList<BoardDto> list = boardMgr.getDataAll(); // 검색이 없는 경우
			ArrayList<BoardDto> list = boardMgr.getDataAll(stype, sword, spage); // 검색이 있는 경우  
			
			for(int i=0;i<list.size();i++){ // for(BoardDto dto:list)...
				dto = list.get(i);
			
			//  댓글 들여쓰기 준비 ---------------------
			int nst = dto.getNested();
			String blank = "";
			for(int b=0;b<nst;b++ ) {
				blank +="&nbsp;&nbsp;";
			}
			// -----------------------------------
			%>
			<tr>
				<td><%=dto.getNum() %></td>
				<td>
					<%= blank %><a href= "boardcontent.jsp?num=<%= dto.getNum() %>&page=<%= spage%>"><%=dto.getTitle() %> </a>
				</td>
				<td><%=dto.getName() %></td>
				<td><%=dto.getBdate() %></td>
				<td><%=dto.getReadcnt() %></td>
			</tr>
			<% 
			}
			%>
		</table>
		<br>
		<table style="width:100%">
			<tr>
				<td style="text-align:center;">
				<%
				for(int i=1;i<=pageSu;i++) {
					if( i == spage){
					out.print("<b style='font-size:12pt;color:red'>[" + i +"]</b>");	
					} else {
					out.print("<a href='boardlist.jsp?page=" + i +"'>[" + i +"]</a>");
					}
				}
				%>
				<br><br>
				<form action="boardlist.jsp" name="frm" method="get">
					<select name="stype">
						<option value="title" selected="selected">글제목</option>
						<option value="name">작성자</option>
					</select>
					<input type="text" name="sword">
					<input type="button" value="검색" id="btnSearch">
				</form>
				</td>
			</tr>
		</table>
		
		
	
</table>
</body>
</html>