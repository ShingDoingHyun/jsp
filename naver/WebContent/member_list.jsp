<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원 테이블 직원 리스트 출력</title>
<style>
td {
	text-align: right;
	padding: 10px 20px;;
	border-bottom: 1px solid gray;
}
</style>
</head>
<body>
	<%@include file="header.jsp"%>
	<div class="wrap">
		<h2>회원 테이블 직원 목록</h2>
		<table border="1" width="1000px">
			<tr>
				<td>ID</td>
				<td>비밀번호</td>
				<td>이름</td>
				<td>생일</td>
				<td>성별</td>
				<td>이메일</td>
				<td>전화번호</td>
				<td>관리</td>


			</tr>

			<%
				// 1. JDBC 드라이버 로딩
				//Class.forName("oracle.jdbc.driver.OracleDriver");

				Connection conn = null;
				Statement stmt = null;
				ResultSet rs = null;

				try {
					//String jdbcDriver = "jdbc:oracle:thin:@localhost:1521:xe";
					String jdbcDriver = "jdbc:apache:commons:dbcp:pooltest";
					String dbUser = "test";
					String dbPass = "1234";

					String query = "select * from member order by name ";
					// 2. 데이터베이스 커넥션 생성
					//conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
					conn = DriverManager.getConnection(jdbcDriver);
					// 3. Statement 생성
					stmt = conn.createStatement();
					// 4. 쿼리 실행
					rs = stmt.executeQuery(query);
					// 5. 쿼리 실행 결과 출력
					while (rs.next()) {
			%>


			<tr>
				<td><%=rs.getString(1)%></td>
				<td><%=rs.getString(2)%></td>
				<td><%=rs.getString(3)%></td>
				<td><%=rs.getDate(4)%></td>
				<td><%= rs.getBoolean(5)==true? "남" : "여" %></td>
				<td><%=rs.getString(6)%></td>
				<td><%=rs.getString(7)%></td>
				<td>
					<a href="member_edit_form.jsp?userid=<%=rs.getString(1)%>">수정</a>
					<a href="member_delete.jsp?userid=<%=rs.getString(1)%>">삭제</a>
				</td>

			</tr>
			<%
				}
				} catch (SQLException ex) {
					out.println(ex.getMessage());
					ex.printStackTrace();
				} finally {
					// 6. 사용한 Statement 종료
					if (rs != null)
						try {
							rs.close();
						} catch (SQLException ex) {
						}
					if (stmt != null)
						try {
							stmt.close();
						} catch (SQLException ex) {
						}
					// 7. 커넥션 종료
					if (conn != null)
						try {
							conn.close();
						} catch (SQLException ex) {
						}
				}
			%>

		</table>
	</div>
</body>
</html>