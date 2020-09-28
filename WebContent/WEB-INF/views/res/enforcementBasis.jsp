<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
    <title>시행근거 - 거주자우선주차</title>
</head>
<body>
<div id="Page" class="page res">
    <div class="ct_head">
        <div class="head">
            <div class="title">
                <h1>거주자우선주차</h1>
                <h2><i class="axi axi-keyboard-arrow-right"></i>시행근거</h2>
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
                <li><a class="on" href="javascript:fn_MovePage('/res/enforcementBasis.c');">시행근거</a></li>
                <li><a href="javascript:fn_MovePage('/res/regulateBasis.c');">단속근거</a></li>
                <li><a href="javascript:fn_MovePage('/res/parkingCondition.c');">주차장현황</a></li>
                <li><a href="javascript:fn_MovePage('/res/moduparkingIntro.c');">모두의주차장소개</a></li>
                <li><a href="javascript:fn_MovePage('/res/defaultChargeInfo.c');">요금납부안내</a></li>
                <li><a href="javascript:fn_MovePage('/res/residentRequest.c');">이용신청</a></li>
            </ul>
        </div>
        <div class="body">
            <div class="regulateBasis_top">
                <div class="enforcementBasis_img"></div>
                <div class="regulateBasis_right">
                    <h2>주차장법 제7조 (노상주차장의 설치 및 폐지)</h2>
                    <i class="axi axi-minus"></i>
                    <a>노상주차장은 특별시장, 광역시장, 시장, 군수 또는<br>구청장이 이를 설치 함</a>
                    <p>
                    <h3>주차장법 시행규칙 제6조의2 (노상주차장의 전용구획 설치)</h3>
                    <i class="axi axi-minus"></i>
                    <a>노상주차장의 일부에 대하여 전용주차구획을<br>설치할 수 있는 경우</a>
                    <i class="axi axi-minus"></i>
                    <a>주거지역에 설치된 노상주차장으로서 인근주민의<br>자동차를 위한 경우</a>
                    <i class="axi axi-minus"></i>
                    <a>기타 당해 지방자치단체 조례가 정하는 자동차를 위한 경우</a>
                    <i class="axi axi-minus"></i>
                    <a>전용구획 설치, 운영에 관하여 필요한 사항은 당해 지방자치단체의 조례로 정함</a>
                </div>
            </div>
        </div>
    </div>
</div>
</body>