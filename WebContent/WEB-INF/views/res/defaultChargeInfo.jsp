<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- commit 테스트 -->
<head>
    <title>요금납부안내 - 거주자우선주차</title>
</head>
<body>
<div id="Page" class="page res">
    <div class="ct_head">
        <div class="head">
            <div class="title">
                <h1>거주자우선주차</h1>
                <h2><i class="axi axi-keyboard-arrow-right"></i>요금납부안내</h2>
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
                <li><a href="javascript:fn_MovePage('/res/moduparkingIntro.c');">모두의주차장소개</a></li>
                <li><a class="on" href="javascript:fn_MovePage('/res/defaultChargeInfo.c');">요금납부안내</a></li>
                <li><a href="javascript:fn_MovePage('/res/residentRequest.c');">이용신청</a></li>
            </ul>
        </div>
        <div class="body">
            <div class="defaultChargeInfo">
                <div class="bd_title">
                    <i class="axi axi-label"></i>
                    <p>요금납부방법</p>
                    <a>
                        - 방문납부방법 : 공단에 직접 방문 후 납부<br>
                        - 지로납부 : 개별 발송된 자료를 이용하여 납부<br>
                        - 홈페이지 결제 : 홈페이지를 통한 카드 결제 가능<br>
                        - 지정계좌 납부 : 인터넷 뱅킹, 텔레뱅킹, 무통장 입금을 통한 납부
                    </a>
                    <h4>- 은행명 : 국민은행<br>
                        - 계좌번호 : 597737-01-003221<br>
                        - 예금주명 : 서울특별시동작구도시관리공단<br>
                        - 계좌입금시 전체 차량번호나 차량번호 끝 4자리와 소유주로 입금하여 주시기 바랍니다.<br>
                          <p>(예시 : 서울 7가 7777혹은 7777홍길동)</p><br>
                        - 입금자와 차주명이 상이하면 수납처리가 불가하오니 반드시 입금 후 연락하여 주시기 바랍니다.<br>
                    </h4>
                    <a>
                        - 지정(배정)기간은 분기(3개월)단위이며, 주차요금은 선납하여야 하며 납부기한 내 미납자는 별도 통보없이<br><p>사용승인을 취소할 수 있습니다.</p><br>
                        - 주차요금 납부 후 "지로영수증(주차증)"을 반드시 운전석 좌측 앞유리창 하단에 부착해야 하고 주차증 미부착으로<br><p>인한 불이익에 대한 책임은 사용자에게 있습니다.</p><br>
                        - 주차증은 타인에게 양도 할 수 없고 주차증 분실 및 차량(번호)변경 시 반드시 우리 공단에서 교체 및 재발급 받아야 합니다.<br>
                        - 배정된 구획 안에 배정차량이 지정시간 및 기간내에만 주차할 수 있으며 이를 위반 시에는 주차장법제8조의 2규정에<br><p>의하여 단속 및 견인 조치됩니다.</p><br>
                        - 주차구획을 배정받은 자는 배정시간, 기간, 구간 외에는 주차할 수 없으며 배정된 구획 내에 불필요한 장애물 설치,<br><p>쓰레기 무단 투기 등이 적발되었을 경우 배정을 취소할 수 있습니다.</p><br>
                        - 주차장법 제10조의2제2항에 의거 차량 훼손 및 도난 등의 사고 발생에 대하여 우리 공단에서는 책임을 지지 않습니다.<br>
                        - 주차구간(구획)이 공사 등으로 삭선되거나 이용불가 사유발생 시에는 대체하지 못할 수 있습니다.<br>
                        - 기존 배정자에 대한 이월 배정이 원칙이므로 해당 사용분기 이후에 별도 사용취소 의사를 밝히지 않으면 주차요금이<br><p>부과되오니 반드시 우리 공단에 사용취소를 통보해야 합니다.</p><br>
                        - 사용기간 중 취소사유(전출, 차량매각 등) 발생 시 환불 신청이 가능합니다.<br>
                        - 신청서 및 신청관련 제출서류의 허위임이 밝혀질 경우 신청 및 배정 취소할 수 있습니다.<br>
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
</body>