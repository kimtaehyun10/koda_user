<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="Referrer" content="origin">

    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <title>미납요금안내 - 주차장소개</title>

    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resource/axicon/axicon.min.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resource/axisj/ui/AXJ.min.css"/>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/mobile/m_main.css"/>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/mobile/m_sub.css"/>

    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/axisj/dist/AXJ.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/axisj/lib/AXUtil.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/axisj/lib/AXValidator.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/mobile/m_common.js"></script>
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
        <div class="page pub">
            <div class="ct_head">
                <div class="head">
                    <div class="title">
                        <h1>공영주차</h1>
                        <h2><i class="axi axi-keyboard-arrow-right"></i>미납요금안내</h2>
                    </div>
                </div>
            </div>
            <div class="ct_body">
                <div class="body">
                    <div class="pub_default">
                        <div class="bd_title"><!-- 모든 컨텐츠 타이틀 공통 -->
                            <i class="axi axi-label"></i>
                            <p>미납주차요금 납부방법</p>
                        </div>
                        <div class="table_box">
                            <table class="table">
                                <caption></caption>
                                <thead>
                                <tr>
                                    <th width="25%">납부종류</th>
                                    <th width="50%">납부방법</th>
                                    <th width="25%">비고</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td>현장납부</td>
                                    <td>노상주차장 현장근무자에게 납부 (모든 주차장에서 납부가능)</td>
                                    <td>미납금 발생일로부터 2개월이내</td>
                                </tr>
                                <tr>
                                    <td>고지서납부</td>
                                    <td>OCR(지로)고지서에 의한 납부</td>
                                    <td>고지서에 지정된 납부일</td>
                                </tr>
                                <tr>
                                    <td>계좌이체</td>
                                    <td>거래은행 : 국민은행 /
                                        계좌번호 : 597737-01-003052 /
                                        예금주 : 동작구도시시설관리공단</td>
                                    <td>차량번호 4자리 반드시 기재</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="bd_title"><!-- 모든 컨텐츠 타이틀 공통 -->
                            <i class="axi axi-label"></i>
                            <p>주차요금 미납자에 대한 조치</p>
                        </div>

                        <div class="block" style="text-align: center;">
                            <div class="caption">주차요금 미납</div>
                            <i class="axi axi-ion-chevron-down"></i>
                            <div class="caption">1차 납부 고지서 발급 (주차요금 원금)</div>
                            <i class="axi axi-ion-chevron-down"></i>
                            <div class="caption">2차 납부 고시서 발급 (4배 가산금 포함)</div>
                            <i class="axi axi-ion-chevron-down"></i>
                            <div class="caption">차량압류</div>

                            <p>기타 미납주차요금 관련 문의는 동작구시설관리공단 주차사업팀(02-832-2445~6)으로 연락주시면 성실하게 답변해 드리겠습니다.</p>
                        </div>

                        <div class="bd_title"><!-- 모든 컨텐츠 타이틀 공통 -->
                            <i class="axi axi-label"></i>
                            <p>당일 주차요금을 납부하지 못하신 경우</p>
                        </div>
                        <div class="block">
                            <p>1. 당일 주차장 운영시간까지 출차하지 못하신 경우</p>
                            <p>2. 노상주차장에서 담당 직원이 부재중인 경우</p>
                            <p>- 차량 앞 위도우 브러쉬에 부착된 주차장을 참조하여 전화문의 후 현장 방문 납부 및 가까운 은행에서 송금하여 주시기 바랍니다.</p>
                            <p>- 입금 시 반드시 차량 뒷자리 4자리를 기재해주시기 바랍니다.</p>
                        </div>
                        <div class="bd_title">
                            <i class="axi axi-label"></i>
                            <p>주차요금 미납차량에 대한 조치</p>
                        </div>
                        <div class="block">
                            <p>1. 주차요금을 납부하지 않을 시 미납 주차요금 납부 안내장이 차적조회상 주소지로 발송됩니다.(1차 일반우편 발송) 주차요금을 납부하지 않을 시에는 동작구주차장설치및관리조례 제26조2항에 의거 4배의 가산금이 부과됩니다.</p>
                            <p>2. 관련법령에 의거 해당분을 1차고지(원금)를 하고 지정 납기일내 납부하지 않을 시에는 동작구주차장설치및관리조례 제26조2항에 의거 4배의가산금이 부과되어 2차 안내장을 발송합니다.(2차 등기우편 발송)</p>
                            <p>3. 2차 안내장 발송 후 일정기간 내에 주차요금을 납부하지 않을 경우에는 부득이 소유 차량을 가압류 조치하게 되오니 미납요금 납부에 적극 협조하여 주시기 바랍니다. 기타 미납주차요금 관련 문의는 동작구시설관리공단 주차사업팀(02-832-2445)으로 연락 주시면 성실하게 답변해 드리겠습니다.</p>
                        </div>
                        <div class="bd_title">
                            <i class="axi axi-label"></i>
                            <p>주차요금 관련 법령 안내</p>
                        </div>
                        <div class="block">
                            <a>1. 서울특별시 동작구주차장설치및관리조례 제6조2항(주차요금 및 가산금)</a>
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
                <li class="pub active">
                    <a><i class="axi axi-local-parking"></i>공영주차</a>
                    <ul>
                        <li><a href="javascript:fn_MovePage('/m/pub/parkingIntro.m');">주차장소개</a></li>
<!--                         <li><a href="javascript:fn_MovePage('/m/pub/parkingCondition.m');">주차장현황</a></li> -->
                        <li class="on"><a href="javascript:fn_MovePage('/m/pub/defaultChargeInfo.m');">미납요금안내</a></li>
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