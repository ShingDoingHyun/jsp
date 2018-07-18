<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:useBean id="memberInfo" class="member.model.MemberInfo" />
	<jsp:setProperty name="memberInfo" property="*" />
	
	<%
    	//1. 구키객체 생성
    	Cookie c = new Cookie("userid",memberInfo.getUserid());
		
    	//2. response 객체에 쿠키를 담는다.
    	response.addCookie(c);
    	
    	if(memberInfo.getSave_id()!=null){
    		Cookie s = new Cookie("save_id",memberInfo.getUserid());
    		
        	//2. response 객체에 쿠키를 담는다.
        	response.addCookie(s);
    	}else{
			Cookie s = new Cookie("save_id",memberInfo.getUserid());
    		s.setMaxAge(0);
        	//2. response 객체에 쿠키를 담는다.
        	response.addCookie(s);
    	}
    	response.sendRedirect("index.jsp");
    	
    %>
</body>
</html>