<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<select id="sel">



	</select>

	<h1>역 주변 시설</h1>
	<div id="selVal"></div>

</body>
</html>
<script>

$(function() {
	
	var arr1 = ['','0151', '0152','0153','0154'];
	var arr2 = ['선택하세요','시청', '종로','종로3가','종로5가'];
	$.each(arr1, function(index) {
	$('#sel').append("<option value=" + arr1[index] + ">" + arr2[index] + "</option>");
	});
	
	$('#sel').change(function() {
		$('#selVal').html('');
		if($(this).val()!==''){
			$('#selVal').append('<table>');
			$('#selVal').append('<tr><td>출구번호 </td><td>역세권 </td><td>위치[X,Y]</td></tr>');
			
			$.ajax({
			    url : 'http://openapi.seoul.go.kr:8088/6359436d417364683730654a507a67/xml/SearchFacilityByIDService/1/300/'+$(this).val()+'/',
			    success : function(data) {
			        $(data).find('row').each(function() {
			            var AREA_NM = $(this).find('AREA_NM').text();
			            var EXIT_NO = $(this).find('EXIT_NO').text();
			            var POINT_X = $(this).find('POINT_X').text();
			            var POINT_Y = $(this).find('POINT_Y').text();
			         
			       
			            $('#selVal').append('<tr><td>'+EXIT_NO+'</td><td>'+AREA_NM+'</td><td>'+POINT_X +','+POINT_Y+'</td></tr>');
			         
			        });
			    }
			}); 
		 	$('#selVal').append('</table>');
		}
	
	});
});




</script>