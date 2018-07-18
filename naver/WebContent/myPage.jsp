<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Date"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:useBean id="memberInfo" class="member.model.MemberInfo" />

<%
	//1. 쿠키 정보 가져오기
	Cookie[] cookies = request.getCookies();
	String cValue = "";
	if (cookies != null && cookies.length > 0) {
		for (int i = 0; i < cookies.length; i++) {
			if (cookies[i].getName().equals("userid")) {
				cValue = cookies[i].getValue();
				break;
			}
		}
	}
	if (cValue.equals("")) {
		response.sendRedirect("index.jsp");
	}
	//1. 사용자 데이터 받기

	//응답결과를 구분하기 위한 변수
	int loginCheck = 0;
	String pw = "";
	//2. db연결
	//jsbc드라이버로딩
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	String jdbcDriver = "jdbc:apache:commons:dbcp:pooltest";

	String dbUser = "test";
	String dbPass = "1234";
	String sql_update = "select userid, name,email from member where userid like ?";

	try {
		conn = DriverManager.getConnection(jdbcDriver);

		pstmt = conn.prepareStatement(sql_update);
		pstmt.setString(1, cValue);

		rs = pstmt.executeQuery();

		if (rs.next()) {
			memberInfo.setName(rs.getString("name"));
			memberInfo.setEmail(rs.getString("email"));
		}
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
		if (rs != null)
			try {
				rs.close();
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
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link href="https://fonts.googleapis.com/css?family=Archivo+Black"
	rel="stylesheet">
<link rel="stylesheet" type="text/css" href="css/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>

<title>가입동의</title>
</head>
<body>


	<%@include file="header.jsp"%>
		<div class="memberInfo">

			아이디 :<%=cValue%>
			<br> 이름 : ${memberInfo.name }<br> EMAIL :
			${memberInfo.email }<br>
		</div>
	<p>이용약관 | 개인정보처리방침 | 책임의 한계와 법적고지 | 회원정보 고객센터</p>
	<p>
		<span class="font-logo-small">NAVER</span> Copyright NAVER Corp. All
		Rights Reserved.
	</p>


</body>
</html>


<script>
	$(function() {
		/*포커스가 잡히면 테두리에 효과를준다.*/
		$('input').focusin(function() {
			$(this).parent().css('border', '1px solid #00BB40');
		});
		/*포커스를 잃으면 테두리에 효과를 제거한다.*/
		$('input').focusout(function() {
			$(this).parent().css('border', '1px solid #D9D9D9');
		});
	});
</script>
