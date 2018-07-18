<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Date"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	//사용자의 입력데이터의 한글처리
	request.setCharacterEncoding("utf-8");
%>

<jsp:useBean id="memberInfo" class="member.model.MemberInfo" />
<jsp:setProperty name="memberInfo" property="*" />

<%
	//1. 사용자 데이터 받기

	//응답결과를 구분하기 위한 변수
	int insertCnt = 0;
	//2. db연결
	//jsbc드라이버로딩
	Connection conn = null;
	PreparedStatement pstmt = null;

	String jdbcDriver = "jdbc:apache:commons:dbcp:pooltest";

	String dbUser = "test";
	String dbPass = "1234";
	String sql_update = "insert into member values (?,?,?,?,?,?,?)";

	try {
		conn = DriverManager.getConnection(jdbcDriver);

		pstmt = conn.prepareStatement(sql_update);
		pstmt.setString(1, memberInfo.getUserid());
		pstmt.setString(2, memberInfo.getPassword());
		pstmt.setString(3, memberInfo.getName());
		pstmt.setDate(4, Date.valueOf(memberInfo.getBirthday()));
		pstmt.setBoolean(5, memberInfo.isGender());
		pstmt.setString(6, memberInfo.getEmail());
		pstmt.setString(7, memberInfo.getPhone());

		insertCnt = pstmt.executeUpdate();
	} catch (Exception e) {
		out.println(e.getMessage());
		e.printStackTrace();

	} finally {
		// 6. 사용한 Statement 종료
		if (pstmt != null)
			try {
				pstmt.close();
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

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	성공여부 테스트 :
	<%=insertCnt%><br>
	<%
		if (insertCnt > 0) {
	%>

	<script>
		function login_fail() {
			alert("가입성공.");
			location.href = "/naver";
		}
	</script>

	<%
		} else {
	%>

	가입실패

	<%
		}
	%>

	<a href="/naver">메인으로</a>
</body>
</html>