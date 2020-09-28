<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
    <title>단속근거 - 거주자우선주차</title>
</head>
<body>
<div id="Page" class="page res">
    <div class="ct_head">
        <div class="head">
            <div class="title">
                <h1>거주자우선주차</h1>
                <h2><i class="axi axi-keyboard-arrow-right"></i>단속근거</h2>
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
                <li><a class="on" href="javascript:fn_MovePage('/res/regulateBasis.c');">단속근거</a></li>
                <li><a href="javascript:fn_MovePage('/res/parkingCondition.c');">주차장현황</a></li>
                <li><a href="javascript:fn_MovePage('/res/moduparkingIntro.c');">모두의주차장소개</a></li>
                <li><a href="javascript:fn_MovePage('/res/defaultChargeInfo.c');">요금납부안내</a></li>
                <li><a href="javascript:fn_MovePage('/res/residentRequest.c');">이용신청</a></li>
            </ul>
        </div>
        <div class="body">
            <div class="regulateBasis_top">
                <div class="regulateBasis_img"></div>
                <div class="regulateBasis_right">
                    <h2>주차장법 제8조의 2 (노상주차장에서의 주차행위 제한 등)</h2>
                    <i class="axi axi-minus"></i>
                    <a>다음 각호의 1에 해당하는 경우에 당해 자동차의 운전자<br>또는 관리책임이 있는 자에 대하여 주차방법을 변경하거나<br>이동할 것을 멸할 수 있음.</a>
                    <i class="axi axi-minus"></i>
                    <a>정당한 사유없이 주차요금을 납부하지 않고 주차하는 경우</a>
                    <i class="axi axi-minus"></i>
                    <a>주차장 안의 지정된 주차구획 외의 곳에 주차하는 경우</a>
                    <p>
                    <h3>동작구 주차장 설치 및 관리 조례 제6조 2항 및 주차장법<br>제9조 의거 거주자우선주차 부정주차요금 부과</h3>
                    <i class="axi axi-minus"></i>
                    <a>거주자우선주차장 내에서 부정주차 차량에 대해서는<br>주차요금 부과</a>
                </div>
            </div>
        </div>
    </div>
</div>
</body>