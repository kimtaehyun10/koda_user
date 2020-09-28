<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
    <title>모두의주차장소개 - 거주자우선주차</title>
</head>
<body>
<div id="Page" class="page res">
    <div class="ct_head">
        <div class="head">
            <div class="title">
                <h1>거주자우선주차</h1>
                <h2><i class="axi axi-keyboard-arrow-right"></i>모두의주차장소개</h2>
            </div>
            <div class="log in">

                <!-- 로그인 이전 -->
                <sec:authorize access="isAnonymous()">
                    <div class="in">
                        <a class="join" href="javascript:fn_MovePage('<c:url value='/mem/memberJoinIpin.c'/>');">회원가입</a>
                    </div>
                </sec:authorize>

                <!-- 로그인 이후 -->
                <sec:authorize access="isAuthenticated()">
                    <div class="out">
                        <sec:authentication var="user" property="principal" />
                        <p><span>${user.mberNm}</span>님 환영합니다!</p>
                        <a class="btn red" href="<c:url value='/logout'/>">로그아웃</a>
                    </div>
                </sec:authorize>

            </div>
        </div>
    </div>
    <div class="ct_body">
        <div class="sub_nav">
            <ul>
                <li><a href="javascript:fn_MovePage('/res/parkingIntro.c');">주차장소개</a></li>
                <li><a href="javascript:fn_MovePage('/res/enforcementBasis.c');">시행근거</a></li>
                <li><a href="javascript:fn_MovePage('/res/regulateBasis.c');">단속근거</a></li>
                <li><a href="javascript:fn_MovePage('/res/parkingCondition.c');">주차장현황</a></li>
                <li><a class="on" href="javascript:fn_MovePage('/res/moduparkingIntro.c');">모두의주차장소개</a></li>
                <li><a href="javascript:fn_MovePage('/res/defaultChargeInfo.c');">요금납부안내</a></li>
                <li><a href="javascript:fn_MovePage('/res/residentRequest.c');">이용신청</a></li>
            </ul>
        </div>
        <div class="body">
            <div class="modupkintro_a">
                <div class="modupkintro_img"></div>
            </div>
            <div class="modupkintro_b">
                <div class="bd_title"><!-- 모든 컨텐츠 타이틀 공통 -->
                    <i class="axi axi-label"></i>
                    <p>주차장 공유사업이란?</p>
                    <a>한정된 주차공간을 여러 사람이 나누어 쓸 수 있도록 만들어 지역내 주차공간 부족 문제를 완화하고 주차공간 배정자와 운전자<br>모두에게 경제적 이득을 돌려주는 사업입니다.</a>
                </div>
            </div>
            <div class="modupkintro_c">
                <div class="modupkintro_img2">
                    <p>거주자우선주차 배정자</p>
                    <a>주차권을 쓰지 않는 시간대에 다른 운전자와 서로 공유해가며<br> 사용하실 수 있습니다.</a>
                </div>
                <div class="modupkintro_img3">
                    <p>일반 운전자</p>
                    <a>가까운 위치의 저렴한 주차공간을 스마트폰 앱을 통하여<br>손쉽게 찾아 주차 단속에 대한 걱정없이 합리적인 비용으로<br>주차할 수 있습니다.</a>
                </div>
            </div>
            <div class="modupkintro_d">
                <div class="bd_title">
                    <i class="axi axi-label"></i>
                    <p>어떻게 이용하는 건가요?</p>
                    <div class="modupkintro_video">
                        <iframe width="100%" height="100%" src="https://www.youtube.com/embed/4n1s3n2yp1Y" frameborder="0" allowfullscreen></iframe>
                    </div>
                    <a>
                       주차면 배정자는 앱을 다운로드 받고 난 뒤 회원가입을 한 후 자신이 소유한 주차공간을 등록을 하고 나서 시간을 설정하여 주차면<br>
                       공유가 가능합니다.<br>
                       운전자 역시 앱을 다운로드 받은 후 주차장을 검색하여 해당 주차장 정보를 확인을 할 수 있으며,<br>
                       공유된 주차장을 이용할 수 없습니다.
                    </a>
                </div>
            </div>
            <div class="modupkintro_e">
                <div class="bd_title">
                    <i class="axi axi-label"></i>
                    <p>어떤 기능들이 있나요?</p>
                    <div class="modu_won">
                        <div class="modupkintro_contents5">
                            <div class="contents5_img"></div>
                    </div>
                </div>
            </div>
            <div class="modupkintro_f">
                <div class="bd_title">
                    <i class="axi axi-label"></i>
                    <p>관련 문의 연락처</p>
                    <a>
                        - 사업전반관련 : 동작구시설관리공단 (02-832-2445 내선 1)<br>
                        - 서비스이용관련 : 모두의주차장 (1899-8242)
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
</body>