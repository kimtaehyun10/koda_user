<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>방문주차 서비스 종료 안내</title>

<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery.cookie.js"></script>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resource/axicon/axicon.min.css" />
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/main.css" />

<script language="JavaScript">
	$(document).ready(function() {

		// 팝업 창 닫으며 쿠키저장 : 하루동안 팝업 노출 막기
		$("label[for='chkPopup']").click(function() {

			$("#chkPopup").prop("checked", true);

			$.cookie('image_popup2', 'close', {
				expires : 1,
				path : '/'
			});

			if ($("#chkPopup").is(":checked") == true) {
				window.close();
			}
		});
	});
</script>
</head>
<body>
	<div align="center">
		<img src="${pageContext.request.contextPath}/resource/images/20200301_notice.jpg" width="631" height="183"  style="relative: width:100%; left:0px;">
	</div>
	<div>
    	<input type="checkbox" id="chkPopup" />
        <label for="chkPopup"><span></span>오늘 하루 그만보기</label>
	</div>
</body>
</html>
