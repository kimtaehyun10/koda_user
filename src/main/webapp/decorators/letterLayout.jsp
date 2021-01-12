<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<meta name="viewport"
	content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">

<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;400;500;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/assets/plugins/slick/slick.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/assets/plugins/jquery-ui-1.12.1/jquery-ui.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/assets/css/main.css">

<script	src="${pageContext.request.contextPath}/resource/assets/plugins/jquery/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/axisj/dist/AXJ.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/axisj/lib/AXUtil.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/axisj/lib/AXValidator.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resource/axisj/ui/AXJ.min.css"/>

<title>한국장기조직기증원 사랑나눔우체툥</title>

<script>

//$.ajaxSettings.traditional = true;

//function fn_main_headPageMove(menuNo, url){
//	document.selectOne.menuNo.value=menuNo;
//	document.selectOne.chkURL.value=url;
//    document.selectOne.action = "<c:url value='/index.c'/>";
//    document.selectOne.submit(); 
//} 
//var imgpath = "<c:url value='/images/egovframework/com/cmm/utl/'/>"; 
//var path = "http://" + "${pageContext.request.serverName}" + ":" + "${pageContext.request.serverPort}"; 

function fn_MovePage(url, menuNo) {  
	//document.location.href = url+"?menuNo="+document.selectOne.menuNo.value+"&pageId="+menuNo; 
	document.location.href = url;
}

function poptastic(url)
{
	window.open("/map/emailPopup", "", 'toolbar=no, width=1000, height=600, status=yes, menubar=no, scrollbars=yes');	    	
}

</script>

<sitemesh:write property="head" />

</head>
<body>

	<form id="logout-form" action="<c:url value='/logout'/>" method="POST">
		<input name="${_csrf.parameterName}" type="hidden"
			value="${_csrf.token}" />
	</form>
	<div class="wrapper isMailbox">
		<header class="mheader">
			<div class="left">
				<a href="javascript:fn_MovePage('/')"> <span>한국장기조직기증원</span></a>
				<a href="javascript:fn_MovePage('/let/letterMain.l')"> <img	src="${pageContext.request.contextPath}/resource/assets/images/email-logo.png" alt=""></a>
				<button onclick="$('#noticemodal').css('display', 'flex');">메일
					작성시 유의사항</button>
			</div>

			<div class="right">

				<sec:authorize access="isAnonymous()">
					<a href="/mem/memLogin.l">로그인</a>
				</sec:authorize>
				<sec:authorize access="isAuthenticated()">
					<a href="javascript:fn_MovePage('/let/secMyInfo.l')" >내정보</a>
					<a href="#" onclick="document.getElementById('logout-form').submit();">로그아웃</a>
					<a href="#" onclick="javascript:fn_MovePage('/let/extMyInfo.l');">회원탈퇴</a>
				</sec:authorize>

				<a href="" class="issns"> <img
					src="${pageContext.request.contextPath}/resource/assets/images/main-sns-insta.png" alt="">
				</a> <a href="" class="issns"> <img
					src="${pageContext.request.contextPath}/resource/assets/images/main-sns-facebook.png" alt="">
				</a> <a href="" class="issns"> <img
					src="${pageContext.request.contextPath}/resource/assets/images/main-sns-blog.png" alt="">
				</a> <a href="" class="issns"> <img
					src="${pageContext.request.contextPath}/resource/assets/images/main-sns-youtube-white.png" alt="">
				</a>

				<button class="m-menu" onclick="$('.mobile-emenu').show();">
					메뉴</button>
			</div>
		</header>
		<sec:authorize access="isAuthenticated()">
		    <sec:authentication property="principal.mberNm" var="username" />
			<div class="mobile-emenu" style="display: none">
				<div class="mobile-emenu-content">
					<button class="close" onclick="$('.mobile-emenu').hide();"></button>
					<div class="top">
						<div class="flex mb-4 items-center">
							<img
								src="${pageContext.request.contextPath}/resource/assets/images/i-user.png"
								alt=""> <strong class="ml-2">${username}</strong> 님
						</div>
						<div>
							<a href="javascript:fn_MovePage('/let/secMyInfo.l')">내 정보</a>
							<a href="#" onclick="document.getElementById('logout-form').submit();">로그아웃</a>
						</div>
					</div>
					<div class="links">
						<a href="javascript:fn_MovePage('/let/letterWrite.l');  "> 편지쓰기 <strong>
						<a href="javascript:toLetterBox('R'); $('.mobile-emenu').hide();" class="active">받은편지함 <strong>
								<label id="m_noReadTot"></label>
						</strong></a> <a href="javascript:toLetterBox('N'); $('.mobile-emenu').hide();">안읽은 편지함</a>
						<a href="javascript:toLetterBox('S'); $('.mobile-emenu').hide();">보낸편지함</a> <a
							href="javascript:toLetterBox('T'); $('.mobile-emenu').hide();">임시보관함</a>
					</div>
				</div>
			</div>
		</sec:authorize>
		<div class="modal" id="noticemodal">
			<div class="modal__content">
				<h2>메일 작성 시 유의사항</h2>
				<button type="button" class="close" onclick="$('#noticemodal').hide();"></button>
				<div class="video">
					<iframe src="https://www.youtube.com/embed/MpFDwKI1FmE"
						frameborder="0"
						allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
						allowfullscreen></iframe>
				</div>
			</div>
		</div>
		<div class="container">
			<sitemesh:write property="body" />
		</div>
	</div>

	<div id="loader">
		<span class="loader-overlay"> <span class="loader-inner"></span>
		</span>
	</div>

	<script src="${pageContext.request.contextPath}/resource/assets/plugins/jquery-ui-1.12.1/jquery-ui.js"></script>
	<script src="${pageContext.request.contextPath}/resource/assets/plugins/slick/slick.js"></script>
	<script	src="${pageContext.request.contextPath}/resource/assets/js/ui.js"></script>


</body>
</html>
