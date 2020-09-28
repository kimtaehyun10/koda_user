<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery.form.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/common.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/axisj/dist/AXJ.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/axisj/lib/AXUtil.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/axisj/lib/AXValidator.js"></script>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resource/axicon/axicon.min.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resource/axisj/ui/AXJ.min.css"/>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/main.css"/>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/sub.css"/>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/sub_nam.css"/>

<title><sitemesh:write property="title" /></title>
<script>

$.ajaxSettings.traditional = true;

function fn_main_headPageMove(menuNo, url){
	document.selectOne.menuNo.value=menuNo;
	document.selectOne.chkURL.value=url;
    document.selectOne.action = "<c:url value='/index.c'/>";
    document.selectOne.submit(); 
} 
var imgpath = "<c:url value='/images/egovframework/com/cmm/utl/'/>"; 
var path = "http://" + "${pageContext.request.serverName}" + ":" + "${pageContext.request.serverPort}"; 
function fn_MovePage(url, menuNo) {  
	//document.location.href = url+"?menuNo="+document.selectOne.menuNo.value+"&pageId="+menuNo; 
	document.location.href = url;
}

function poptastic(url)
{
	window.open("/map/emailPopup", "", 'toolbar=no, width=1000, height=600, status=yes, menubar=no, scrollbars=yes');	    	
}

initTimer = function() {
	
	var session = '<%=request.getSession().getId()%>';
	var max = parseInt('<%=request.getSession().getMaxInactiveInterval()%>');
    $.ajax({
        url : "/com/selectSession.json",
        type: "POST", 
        data: {session : session},
        dataType:"json", 
        success : function(data, textStatus, jqXHR) {
        	var seconds = data.pastSeconds;
        	 
        	if (seconds >= max) {
        		location.href = "/sessionError";
        	} else {
        		setTimeout("initTimer()", 120000); // 2분 간격으로 체크
        	}
        },
        error : function(jqXHR, textStatus, errorThrown){
            //Error시, 처리
        }
    });
}

$(function(){

	var authenticated = '<%=session.getAttribute("isLocallyAuthenticated")%>';
	var max = parseInt('<%=request.getSession().getMaxInactiveInterval()%>');
	
	if (authenticated == 'true' && max > 0) {
		initTimer();	
	}
});

</script>

<sitemesh:write property="head" />

</head>
<body>
<div class="wrap">

<form name="selectOne" method="post">
<input name="menuNo" type="hidden" value="${resultVO.tempInt}"/>
<input name="chkURL" type="hidden" value=""/> 
</form>
  
	<!-- #header_wrap : S -->
	<!-- #header : S -->
	<div class="header">
		<div class="header_in">
			<div class="logo">
				<a href="javascript:fn_MovePage('/main');">
					<img src="${pageContext.request.contextPath}/resource/images/hd_title.png" alt="중랑구시설관리공단" />
				</a>
			</div>

			<div class="nav">
				<ul>
					<li class="res">
						<a>거주자우선주차</a>
						<ul>
							<li><a href="javascript:fn_MovePage('/res/parkingIntro.c');">주차장소개</a></li>
							<li><a href="javascript:fn_MovePage('/res/enforcementBasis.c');">시행근거</a></li>
							<li><a href="javascript:fn_MovePage('/res/regulateBasis.c');">단속근거</a></li>
							<li><a href="javascript:fn_MovePage('/res/parkingCondition.c');">주차장현황</a></li>
							<li><a href="javascript:fn_MovePage('/res/moduparkingIntro.c');">모두의주차장소개</a></li>
							<li><a href="javascript:fn_MovePage('/res/defaultChargeInfo.c');">요금납부안내</a></li>
							<li><a href="javascript:fn_MovePage('/res/residentRequest.c');">이용신청</a></li>
						</ul>
					</li>
					<li class="vis">
						<a>방문주차</a>
						<ul>
							<li><a href="javascript:fn_MovePage('/vst/visitParking.c');">방문주차소개</a></li>
							<li><a href="javascript:fn_MovePage('/vst/visitRequest.c');">이용신청</a></li>
						</ul>
					</li>
					<li class="pub">
						<a>공영주차</a>
						<ul>
							<li><a href="javascript:fn_MovePage('/pub/parkingIntro.c');">주차장소개</a></li>
							<li><a href="javascript:fn_MovePage('/pub/parkingCondition.c');">주차장현황</a></li>
							<li><a href="javascript:fn_MovePage('/pub/defaultChargeInfo.c');">미납요금안내</a></li>
							<!--<li><a href="javascript:fn_MovePage('/pub/useInfo.c');">이용안내</a></li>-->
							<li><a href="javascript:fn_MovePage('/pub/publicRequest.c');">이용신청1</a></li>
						</ul>
					</li>
					<li class="reg">
						<a>견인보관소</a>
						<ul>
							<li><a href="javascript:fn_MovePage('/tow/towStorageInfo.c');">견인보관소안내</a></li>
						</ul>
					</li>
					<li class="inf">
						<a>나의 주차정보</a>
						<ul>
							<li><a href="javascript:fn_MovePage('/mypage/parkingContract.c');">주차요금결제</a></li>
							<li><a href="javascript:fn_MovePage('/mypage/parkingCharge.c');">거주자환불신청</a></li>
							<li><a href="javascript:fn_MovePage('/mypage/standbyStatus.c');">대기현황조회</a></li>
							<li><a href="javascript:fn_MovePage('/mypage/myInfoReconfirm.c');">정보수정</a></li>
							<li><a href="javascript:fn_MovePage('/mypage/outReconfirm.c');">회원탈퇴</a></li>
						</ul>
					</li>
					<li class="cus">
						<a>고객지원</a>
						<ul>
							<li><a href="javascript:fn_MovePage('/sup/notice.c');">공지사항</a></li>
							<li><a href="javascript:fn_MovePage('/sup/qna.c');">자주묻는질문</a></li>
							<li><a href="javascript:fn_MovePage('/sup/phoneInfo.c');">전화번호안내</a></li>
							<li><a href="javascript:fn_MovePage('/sup/visitMap.c');">찾아오시는길</a></li>
						</ul>
					</li>
				</ul>
			</div>
		</div>
	</div>

	<div id="Contents" class="contents">
		<sitemesh:write property="body" />

		<div id="footer">
			<div class="section">
				<div class="foot_left">
					<!-- 
					<img src="${pageContext.request.contextPath}/resource/images/footer_img.png" alt="중랑구 슬로건">
					 -->
					<address>주소 : 서울 중랑구 신내로 15길 197 중랑구립정보도서관(묵동) 중랑구시설관리공단111</address>

					<p>TEL : 02-3422-4831~4 / FAX : 02-3422-4848</p>

					<span>Copyright © 2020 All Right Reserved. Jungnang-Gu Facilities Management Corporation.</span>
				</div>
				<div class="foot_right">
					<div class="top">
						<ul>
							<li><a href="https://park.idongjak.or.kr/sup/phoneInfo.c" target="_blank">부서업무 / 직원안내</a></li>												
							<li><a href="http://www.idongjak.or.kr/html/etc/privacy.php" target="_blank">개인정보보호방침</a></li>
							<li><a href="javascript:poptastic('http://www.idongjak.or.kr/html/etc/e-mail.php');" target="_blank">이메일수집거부</a></li>
						</ul>
					</div>
					<div class="bot">
						<ul>
							<li><a href="javascript:fn_MovePage('/mem/memberJoinIpin.c');">회원가입</a></li>
							<li><a href="javascript:fn_MovePage('/mem/memberIpin.c');">아이디 / 비밀번호 찾기</a></li>
							<li><a href="javascript:fn_MovePage('/sup/visitMap.c');">찾아오시는 길</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>

</div>

<div id="spinnerMask"><i class="axi axi-ion-load-d axi-spin"></i></div>
</body> 
</html>
