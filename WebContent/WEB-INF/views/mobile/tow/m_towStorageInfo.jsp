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
    <title>견인보관소 - 견인보관소안내</title>

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
                    position: new daum.maps.LatLng(<spring:eval expression="@appConfig['tow.lat']"/>, <spring:eval expression="@appConfig['tow.lng']"/>),
                    text: '견인보관소' // text 옵션을 설정하면 마커 위에 텍스트를 함께 표시할 수 있습니다
                }
            ];

            staticMapContainer  = document.getElementById('staticMap'), // 이미지 지도를 표시할 div
                    staticMapOption = {
                        center: new daum.maps.LatLng(<spring:eval expression="@appConfig['tow.lat']"/>, <spring:eval expression="@appConfig['tow.lng']"/>), // 이미지 지도의 중심좌표
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
        <div class="page tow">
            <div class="ct_head">
                <div class="head">
                    <div class="title">
                        <h1>견인보관소</h1>
                        <h2><i class="axi axi-keyboard-arrow-right"></i>견인보관소안내</h2>
                    </div>
                </div>
            </div>
            <div class="ct_body">
                <div class="body">
                    <div class="title_img">
                        <img src="${pageContext.request.contextPath}/resource/images/tow_img.png" alt="동작구시설관리공단 조감도" />
                    </div>
                    <div class="caption">
                        <p>- 불법 주, 정차 및 거주자우선주차제 부정주차로 견인된 차량 보관</p>
                        <p>- 피 견인차량의 견인료, 보관료 수납 및 반환업무</p>
                        <p>- 장기보관차량 매각 및 폐차 등 강제처리 집행</p>
                    </div>
                    <div class="towintro">
                        <div class="bd_title"><!-- 모든 컨텐츠 타이틀 공통 -->
                            <i class="axi axi-label"></i>
                            <p>현황</p>
                            <a>- 명 칭 : 관악ㆍ동작 견인차량보관소<br>
                               - 위 치 : 서울시 관악구 신림8동 1677-5<br>
                               - 면 적 : 3,032㎡<br>
                               - 면 수 : 82면<br>
                               - 업무시간 : 연중무휴 24시간
                            </a>
                        </div>
                        <div class="bd_title"><!-- 모든 컨텐츠 타이틀 공통 -->
                            <i class="axi axi-label"></i>
                            <p>관련법규</p>
                            <h4>[ 불법 주정차 ]</h4>
                            <a>- 도로교통법 제32조 (정차 및 주차의 금지)<br>
                               - 도로교통법 제33조 (주차금지의 장소)<br>
                               - 도로교통법 제35조 (주차위반에 대한 조치)<br>
                            </a>
                            <h4>[ 부정 주정차(거주자우선주차제 위반) ]</h4>
                            <a>- 주차장법 제8조의 2항 (노상주차장에서의 주차행위 제한 등)</a>
                        </div>
                        <div class="bd_title"><!-- 모든 컨텐츠 타이틀 공통 -->
                            <i class="axi axi-label"></i>
                            <p>단속 및 견인</p>
                            <h4>[ 단속 ]</h4>
                            <a>- 불법주정차 : 단속공무원(동작구청, 관악구청)<br>- 부정주정차(거주자우선주차제) : 단속직원(동작,관악 시설관리공단)</a>
                            <h4>[ 견인 : 동작구청, 관악구청 견인대행지정업체 ]</h4>
                            <a style="color: #da4a4a;">- 불법/부정주차 위반차량은 사전 예고 없이 즉시 단속 및 견인될 수 있습니다.</a>
                        </div>
                        <div class="bd_title"><!-- 모든 컨텐츠 타이틀 공통 -->
                            <i class="axi axi-label"></i>
                            <p>견인된 차량 반환절차</p>
                            <a>차량 사용자 또는 소유주께서 신분증을 소지하시고 견인차량보관소를 방문하시어 견인료와 보관료를 납부하시면 차량을 인수해<br>가실 수 있습니다.</a>
                        </div>
                        <div class="bd_title"><!-- 모든 컨텐츠 타이틀 공통 -->
                            <i class="axi axi-label"></i>
                            <p>견인료 및 보관료</p>
                        </div>
                        <div class="table_box">
                            <table class="table">
                                <caption>차량 구분 별 견인료 및 보관료</caption>
                                <thead>
                                    <tr>
                                        <th>구분</th>
                                        <th>견인료</th>
                                        <th>보관료</th>
                                        <th>비고</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>2.5톤 미만</td>
                                        <td>40,000원</td>
                                        <td>30분당 700원</td>
                                        <td>단, 1회 보관료 최고한도 500,000원</td>
                                    </tr>
                                    <tr>
                                        <td>2.5톤 이상 ~ 6.5톤 미만</td>
                                        <td>46,000원</td>
                                        <td>30분당 700원</td>
                                        <td>단, 1회 보관료 최고한도 500,000원</td>
                                    </tr>
                                    <tr>
                                        <td>6.5톤 이상 ~ 10 톤 미만</td>
                                        <td>66,000원</td>
                                        <td>30분당 1,200원</td>
                                        <td>단, 1회 보관료 최고한도 500,000원</td>
                                    </tr>
                                    <tr>
                                        <td>10톤 이상</td>
                                        <td>115,000원</td>
                                        <td>30분당 1,200원</td>
                                        <td>단, 1회 보관료 최고한도 500,000원</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <p>※ 현금, 무통장, 신용카드로 납부가 가능합니다.</p>

                        <div class="bd_title"><!-- 모든 컨텐츠 타이틀 공통 -->
                            <i class="axi axi-label"></i>
                            <p>미반환 차량의 처리</p>
                            <a>차량반환에 필요한 조치 또는 공고를 하였음에도 보관일로부터 1개월 이내에 반환을 요구하지 않을 경우, 도로교통법과<br>자동차관리
                                법에 의거 강제매각 또는 폐차될 수 있고, 1년 이하의 징역 또는 300만원 이하의 벌금이 부과됩니다.</a>
                        </div>
                        <div class="bd_title"><!-- 모든 컨텐츠 타이틀 공통 -->
                            <i class="axi axi-label"></i>
                            <p>부정주차(거주자우선주차제) 이의신청 안내</p>
                            <a>부정주차(거주자) 위반으로 견인된 차량의 소유자(또는 사용자)는 견인차량보관소에 견인료 및 보관료를 납부하신 후 영수증을<br>
                                첨부하여 해당지역 공단(동작, 관악)에 이의신청서를 작성하여 제출하시면 심의 후 처리결과를 본인에게 통보해 드립니다.<br>
                            </a>
                            <h4>[ 이의 신청서 제출 방법 ]</h4>
                            <a>- 동작구 부정주차(거주자)로 단속된 차량 : 견인차량보관소(02-855-8611) 차량반환 시 제출<br>
                               - 관악구 부정주차(거주자)로 단속된 차량 : 관악구시설관리공단 주차사업팀(02-2081-2600)에 제출
                            </a>
                        </div>
                        <div class="bd_title"><!-- 모든 컨텐츠 타이틀 공통 -->
                            <i class="axi axi-label"></i>
                            <p>불법주정차 이의신청 안내</p>
                            <a>불법주정차 위반으로 견인된 차량의 소유자(또는 사용자)는 견인차량보관소에 견인료 및 보관료를 납부하신 후 영수증을<br>
                               첨부하여 해당지역 구청(동작, 관악)에 이의신청서를 작성하여 제출하시면 심의 후 처리결과를 본인에게 통보해 드립니다.<br>
                            </a>
                            <h4>[ 이의 신청서 제출 방법 ]</h4>
                            <a>- 동작구 불법주정차로 단속된 차량 : 동작구청 교통지도과(02-820-1558)에 제출<br>
                               - 관악구 불법주정차로 단속된 차량 : 관악구청 교통지도과(02-879-6000)에 제출
                            </a>
                        </div>
                        <div class="bd_title"><!-- 모든 컨텐츠 타이틀 공통 -->
                            <i class="axi axi-label"></i>
                            <p>찾아오시는 길</p>
                        </div>
                        <div class="block">
                            <div class="map_view">
                                <div id="staticMap" style="width:100%;height:250px;"></div>
                            </div>
                            <p>- 주      소 : 서울시 관악구 신림8동 1677-5<br>
                                - 전화번호 : 02-855-8611~2
                            </p>
                        </div>
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
                        <li><a href="javascript:fn_MovePage('/m/res/defaultChargeInfo.m');">요금납부안내</a></li>
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
                <li class="tow active">
                    <a><i class="axi axi-warning"></i>견인보관소</a>
                    <ul>
                        <li class="on"><a href="javascript:fn_MovePage('/m/tow/towStorageInfo.m');">견인보관소안내</a></li>
                    </ul>
                </li>
                <li class="mypage">
                    <a><i class="axi axi-person"></i>나의 주차정보</a>
                    <ul>
                        <li><a href="javascript:fn_MovePage('/m/mypage/parkingContract.m');">주차장계약</a></li>
                        <li><a href="javascript:fn_MovePage('/m/mypage/standbyStatus.m');">대기현황조회</a></li>
                    </ul>
                </li>
                <li class="sup">
                    <a><i class="axi axi-explore"></i>고객지원</a>
                    <ul>
                        <li><a href="javascript:fn_MovePage('/m/sup/notice.m');">공지사항</a></li>
                        <li><a href="javascript:fn_MovePage('/m/sup/qna.m');">자주묻는질문</a></li>
                        <li><a href="javascript:fn_MovePage('/m/sup/phoneInfo.m');">전화번호안내</a></li>
                        <li><a href="javascript:fn_MovePage('/m/sup/visitMap.m');">찾아오시는길</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</div>
</body>
</html>