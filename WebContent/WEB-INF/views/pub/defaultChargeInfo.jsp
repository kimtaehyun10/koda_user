<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
    <title>미납요금안내 - 주차장소개</title>
</head>
<body>
<div id="Page" class="page pub">
    <div class="ct_head">
        <div class="head">
            <div class="title">
                <h1>공영주차</h1>
                <h2><i class="axi axi-keyboard-arrow-right"></i>미납요금안내</h2>
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
                <li><a href="javascript:fn_MovePage('/pub/parkingIntro.c');">주차장소개</a></li>
                <li><a href="javascript:fn_MovePage('/pub/parkingCondition.c');">주차장현황</a></li>
                <li><a class="on" href="javascript:fn_MovePage('/pub/defaultChargeInfo.c');">미납요금안내</a></li>
                <!--<li><a href="javascript:fn_MovePage('/pub/useInfo.c');">이용안내</a></li>-->
                <li><a href="javascript:fn_MovePage('/pub/publicRequest.c');">이용신청</a></li>
            </ul>
        </div>
        <div class="body">
            <div class="pub_default">
                <div class="bd_title"><!-- 모든 컨텐츠 타이틀 공통 -->
                    <i class="axi axi-label"></i>
                    <p>미납주차요금 납부방법</p>
                    <div class="big_box">
                        <table>
                            <caption></caption>
                            <thead>
                            <tr>
                                <th>납부종류</th>
                                <th>납부방법</th>
                                <th>비고</th>
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
                </div>
                <div class="bd_title"><!-- 모든 컨텐츠 타이틀 공통 -->
                    <i class="axi axi-label"></i>
                    <p>주차요금 미납자에 대한 조치</p>
                    <div class="pub_default_won">
                        <div class="small_box">주차요금 미납</div><i class="axi axi-ion-chevron-right"></i>
                        <div class="small_box">1차 납부<br>고지서 발급<br>(주차요금 원금)</div><i class="axi axi-ion-chevron-right"></i>
                        <div class="small_box">2차 납부<br>고시서 발급<br>(4배 가산금 포함)</div><i class="axi axi-ion-chevron-right"></i>
                        <div class="small_box">차량압류</div>
                    </div>
                    <a>기타 미납주차요금 관련 문의는 동작구시설관리공단 주차사업팀(02-832-2445~6)으로 연락주시면 성실하게 답변해 드리겠습니다.</a>
                </div>
                <div class="bd_title"><!-- 모든 컨텐츠 타이틀 공통 -->
                    <i class="axi axi-label"></i>
                    <p>당일 주차요금을 납부하지 못하신 경우</p>
                    <a>1. 당일 주차장 운영시간까지 출차하지 못하신 경우<br>
                        2. 노상주차장에서 담당 직원이 부재중인 경우<br>
                        <div class="mil">- 차량 앞 위도우 브러쉬에 부착된 주차장을 참조하여 전화문의 후 현장 방문 납부 및 가까운 은행에서 송금하여 주시기 바랍니다.</div>
                        <div class="mil">- 입금 시 반드시 차량 뒷자리 4자리를 기재해주시기 바랍니다.</div>
                    </a>
                    <i class="axi axi-label"></i>
                    <p>주차요금 미납차량에 대한 조치</p>
                    <a>1. 주차요금을 납부하지 않을 시 미납 주차요금 납부 안내장이 차적조회상 주소지로 발송됩니다.(1차 일반우편 발송)<br>
                        <div class="mil">주차요금을 납부하지 않을 시에는 동작구주차장설치및관리조례 제26조2항에 의거 4배의 가산금이 부과됩니다.</div>
                        2. 관련법령에 의거 해당분을 1차고지(원금)를 하고 지정 납기일내 납부하지 않을 시에는 동작구주차장설치및관리조례
                        <div class="mil">제26조2항에 의거 4배의가산금이 부과되어 2차 안내장을 발송합니다.(2차 등기우편 발송)</div>
                        3. 2차 안내장 발송 후 일정기간 내에 주차요금을 납부하지 않을 경우에는 부득이 소유 차량을 가압류 조치하게 되오니
                        <div class="mil">미납요금 납부에 적극 협조하여 주시기 바랍니다. 기타 미납주차요금 관련 문의는 동작구시설관리공단</div>
                        <div class="mil">주차사업팀(02-832-2445)으로 연락 주시면 성실하게 답변해 드리겠습니다.</div>
                    </a>
                    <i class="axi axi-label"></i>
                    <p>주차요금 관련 법령 안내</p>
                    <a>1. 서울특별시 동작구주차장설치및관리조례 제6조2항(주차요금 및 가산금)</a>
                </div>
            </div>
        </div>
    </div>
</div>
</body>