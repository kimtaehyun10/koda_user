<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="Referrer" content="origin">

    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <title>찾아오시는길 - 고객지원</title>

    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resource/axicon/axicon.min.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resource/axisj/ui/AXJ.min.css"/>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/mobile/m_main.css"/>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/mobile/m_sub.css"/>

    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/axisj/dist/AXJ.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/axisj/lib/AXUtil.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/axisj/lib/AXValidator.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/mobile/m_common.js"></script>

    <!-- Daum지도 API키 Import-->
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=<spring:eval expression="@appConfig['daum.api.key']"/>"></script>

    <script id="jscode">
    
	    $(document.body).ready(function(){
	    	var markers = [
	            {
	                position: new daum.maps.LatLng(<spring:eval expression="@appConfig['dojakgu.lat']"/>, <spring:eval expression="@appConfig['dojakgu.lng']"/>), 
	                text: '동작구시설관리공단' // text 옵션을 설정하면 마커 위에 텍스트를 함께 표시할 수 있습니다     
	            }
	        ];
	
	        staticMapContainer  = document.getElementById('staticMap'), // 이미지 지도를 표시할 div
	        staticMapOption = {
	            center: new daum.maps.LatLng(<spring:eval expression="@appConfig['dojakgu.lat']"/>, <spring:eval expression="@appConfig['dojakgu.lng']"/>), // 이미지 지도의 중심좌표
	            level: 3, // 이미지 지도의 확대 레벨
	            marker: markers // 이미지 지도에 표시할 마커
	        };
	
		    // 이미지 지도를 생성합니다
	        var staticMap = new daum.maps.StaticMap(staticMapContainer, staticMapOption);
	    });
        
    </script>
</head>
<body>
<div class="wrap">
    <div class="header">
        <sec:authorize access="isAnonymous()">
            <a class="add_login" title="로그인화면 호출"></a>
        </sec:authorize>
        <sec:authorize access="isAuthenticated()">
            <a class="add_login on" title="로그인화면 호출"></a>
        </sec:authorize>

        <a class="add_menu" title="메뉴화면 호출"></a>
        <div class="logo" onclick="fn_MovePage('/m/main');">
            <img src="${pageContext.request.contextPath}/resource/images/mobile/m_logo.png" alt="동작구시설관리공단 주차시설 로고" />
        </div>
    </div>

    <div class="contents">
        <div class="page sup">
            <div class="ct_head">
                <div class="head">
                    <div class="title">
                        <h1>고객지원</h1>
                        <h2><i class="axi axi-keyboard-arrow-right"></i>찾아오시는길</h2>
                    </div>
                </div>
            </div>
            <div class="ct_body">
                <div class="body">
                    <div class="caption">
                        <p>동작구 시설관리공단의 위치입니다.</p>
                    </div>

                    <div class="bd_title">
                        <i class="axi axi-label"></i>
                        <p>오시는 길</p>
                    </div>
                    <div class="block">
                        <div class="map_view">
                            <div id="staticMap" style="width:100%;height:300px;"></div>
                        </div>
                        <p>주소 : 서울특별시 동작구 보라매로 5길 28 (신대방동)</p>
                        <p>전화 : 02 - 832 - 2445~6</p>
                        <p>팩스 : 02 - 832 - 2963</p>
                    </div>

                    <div class="bd_title">
                        <i class="axi axi-label"></i>
                        <p>교통편</p>
                    </div>
                    <div class="table_box">
                        <table class="table non_head">
                            <caption>동작구시설관리공단을 찾아오는 교통편입니다.</caption>
                            <thead>
                                <tr>
                                    <th width="10%"></th>
                                    <th width="90%"></th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <th>지하철</th>
                                    <td class="left">
                                        <p>- 2호선 신대방역 4번 출구에서 문창초등학교 방향 1,300m 남문 이용</p>
                                        <p>- 2호선 신림역 6번 출구에서 보라매공원 방향 1,300m 남문 이용</p>
                                        <p>- 7호선 보라매역 2번 출구에서 보라매공원 방향 1,100m 정문 이용</p>
                                        <p>- 7호선 신대방삼거리역 2번 출구에서 보라매공원 방향 1,200m 이용</p>
                                    </td>
                                </tr>
                                <tr>
                                    <th>버스</th>
                                    <td class="left">
                                        <p>- 시립보라매병원 정류장 하차 : 153, 5516, 5525, 5612</p>
                                        <p>- 롯데관악점 정류장 하차 : 153, 5516, 5524, 5525, 5526, 5535, 5612, 6511, 5522B, 6033</p>
                                        <p>- 롯데백화점 관악점 정류장 하차 : 152, 153, 461, 504, 5516, 5525, 5612, 6513, 6514, 6515</p>
                                        <p>- 마을버스 : 동작05</p>
                                    </td>
                                </tr>
                                <tr>
                                    <th>승용차</th>
                                    <td class="left">
                                        <p>- 보라매병원 주차장 입구(게이트) 옆에 위치한 '구민회관' 주차장 이용</p>
                                        <p>※ 네비게이션 이용시 '(서울특별시) 보라매병원'을 찍고 찾아오시길 권장합니다. (주소로 검색시 보라매공원 정문이 안내됨)</p>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="footer">
        <div class="ft_img">
            <img src="${pageContext.request.contextPath}/resource/images/mobile/m_footer_img.png" alt="자동자 아이콘 이미지" />
        </div>
        <div class="ft_box">
            <div class="logo">
                <img src="${pageContext.request.contextPath}/resource/images/mobile/m_logo_footer.png" alt="동작구시설관리공단 주차시설 흑백 로고" />
            </div>
            <address>서울시 동작구 보라매 5길 28 (신대방2동 395번지) 공단본부</address>
                <span>TEL)
                    <a href="tel:+8228322445" title="동작구시설관리공단 공단본부 전화번호">02-832-2445</a>
                </span>
            <span>FAX) 02-832-2963</span>

            <p>COPYRIGHT ⓒ 2016 동작구시설관리공단 ALL RIGHTS RESERVED</p>
        </div>
    </div>
</div>

<!-- 이곳 부터 숨겨져있는 화면 -->
<div id="bgMask" class="mask" style="display:none;"></div>

<!-- 호출되는 로그인 화면 -->
<div id="loginContainer" class="login">
    <div class="head">
        <a class="close_container" title="닫기"></a>
        <h1>로그인</h1>
    </div>
    <div class="body">
        <!-- 로그인 이전 -->
        <sec:authorize access="isAnonymous()">
            <form id="loginForm" name="loginForm" action="<c:url value='/loginProc'/>" method="post">
                <div class="login_box">
                    <input id="user_id" name="user_id" class="text" type="text" placeholder="아이디" />
                    <input id="user_pw" name="user_pw" class="text" type="password" placeholder="비밀번호" />
                    <a class="btn in green submit" onclick="javascript:loginProc();">로그인</a>

                    <p>모바일버전은 읽기전용 사이트 입니다.</p>
                    <p>회원가입 및 각 이용신청은 PC버전을 통해서만 가능합니다.</p>
                </div>
            </form>
        </sec:authorize>

        <!-- 로그인 이후 -->
        <sec:authorize access="isAuthenticated()">
            <div class="login_box">
                <sec:authentication var="user" property="principal" />
                <p><span>${user.mberNm}</span>님 환영합니다.</p>
                <a class="btn in red submit" href="<c:url value='/logout'/>">로그아웃</a>

                <p>모바일버전은 읽기전용 사이트 입니다.</p>
                <p>주차장 이용신청은 PC버전을 통해서만 가능합니다.</p>
            </div>
        </sec:authorize>

        <hr>
        <div class="link_box">
            <ul>
                <li><a href="http://www.idongjak.or.kr/page/about/people" target="_blank">부서업무 / 직원안내</a></li>
                <li><a href="http://www.idongjak.or.kr/page/community/minwon" target="_blank">고객담당자안내</a></li>
                <li><a href="http://www.idongjak.or.kr/page/community/minwon" target="_blank">주요시설위치안내</a></li>
                <li><a href="http://www.idongjak.or.kr/popup/main/privacy.php" target="_blank">개인정보보호방침</a></li>
                <li><a href="http://idongjak.or.kr/popup/main/e-mail.gif" target="_blank">이메일수집거부</a></li>
            </ul>
        </div>
    </div>
</div>

<!-- 호출되는 메뉴 화면 -->
<div id="menuContainer" class="menu">
    <div class="head">
        <a class="close_container" title="닫기"></a>
        <h1>전체메뉴</h1>
    </div>
    <div class="body">
        <div class="menu_box">
            <ul class="nav">
                <li class="res">
                    <a><i class="axi axi-home"></i>거주자우선주차</a>
                    <ul>
                        <li><a href="javascript:fn_MovePage('/m/res/parkingIntro.m');">주차장소개</a></li>
                        <li><a href="javascript:fn_MovePage('/m/res/enforcementBasis.m');">시행근거</a></li>
                        <li><a href="javascript:fn_MovePage('/m/res/regulateBasis.m');">단속근거</a></li>
                        <li><a href="javascript:fn_MovePage('/m/res/parkingCondition.m');">주차장현황</a></li>
                        <li><a href="javascript:fn_MovePage('/m/res/moduparkingIntro.m');">모두의주차장소개</a></li>
                        <li><a href="javascript:fn_MovePage('/m/res/defaultChargeInfo.m');">미납요금안내</a></li>
                    </ul>
                </li>
                <li class="vst">
                    <a><i class="axi axi-accessibility"></i>방문주차</a>
                    <ul>
                        <li><a href="javascript:fn_MovePage('/m/vst/visitParking.m');">방문주차소개</a></li>
                    </ul>
                </li>
                <li class="pub">
                    <a><i class="axi axi-local-parking"></i>공영주차</a>
                    <ul>
                        <li><a href="javascript:fn_MovePage('/m/pub/parkingIntro.m');">주차장소개</a></li>
<!--                         <li><a href="javascript:fn_MovePage('/m/pub/parkingCondition.m');">주차장현황</a></li> -->
                        <li><a href="javascript:fn_MovePage('/m/pub/defaultChargeInfo.m');">미납요금안내</a></li>
                    </ul>
                </li>
                <li class="tow">
                    <a><i class="axi axi-warning"></i>견인보관소</a>
                    <ul>
                        <li><a href="javascript:fn_MovePage('/m/tow/towStorageInfo.m');">견인보관소안내</a></li>
                    </ul>
                </li>
                <li class="mypage">
                    <a><i class="axi axi-person"></i>나의 주차정보</a>
                    <ul>
                        <li><a href="javascript:fn_MovePage('/m/mypage/parkingContract.m');">주차장계약</a></li>
                        <li><a href="javascript:fn_MovePage('/m/mypage/standbyStatus.m');">대기현황조회</a></li>
                    </ul>
                </li>
                <li class="sup active">
                    <a><i class="axi axi-explore"></i>고객지원</a>
                    <ul>
                        <li><a href="javascript:fn_MovePage('/m/sup/notice.m');">공지사항</a></li>
                        <li><a href="javascript:fn_MovePage('/m/sup/qna.m');">자주묻는질문</a></li>
                        <li><a href="javascript:fn_MovePage('/m/sup/phoneInfo.m');">전화번호안내</a></li>
                        <li class="on"><a href="javascript:fn_MovePage('/m/sup/visitMap.m');">찾아오시는길</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</div>
</body>
</html>