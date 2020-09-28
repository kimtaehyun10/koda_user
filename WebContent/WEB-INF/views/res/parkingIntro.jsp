<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
<title>주차장소개 - 거주자우선주차</title>
</head>
<body>
<div id="Page" class="page res">
    <div class="ct_head">
        <div class="head">
            <div class="title">
                <h1>거주자우선주차</h1>
                <h2><i class="axi axi-keyboard-arrow-right"></i>주차장소개</h2>
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
                <li><a class="on" href="javascript:fn_MovePage('/res/parkingIntro.c');">주차장소개</a></li>
                <li><a href="javascript:fn_MovePage('/res/enforcementBasis.c');">시행근거</a></li>
                <li><a href="javascript:fn_MovePage('/res/regulateBasis.c');">단속근거</a></li>
                <li><a href="javascript:fn_MovePage('/res/parkingCondition.c');">주차장현황</a></li>
                <li><a href="javascript:fn_MovePage('/res/moduparkingIntro.c');">모두의주차장소개</a></li>
                <li><a href="javascript:fn_MovePage('/res/defaultChargeInfo.c');">요금납부안내</a></li>
                <li><a href="javascript:fn_MovePage('/res/residentRequest.c');">이용신청</a></li>
            </ul>
        </div>
        <div class="body">
            <div class="pkintro_top">
                <div class="pkintro_img"></div>
                <div class="pkintro_right">
                    <h1>PARKING</h1>
                    <h3>거주자우선주차</h3>
                    <h4>주택가 이면도로 주차난 해소와 주차질서<br>확립을 위해 <a>대방, 흑석, 상도, 사당,<br>노량진, 신대방동</a> 거주자 우선주차장을<br>관리하고 있습니다.</h4>
                </div>
            </div>
            <div class="pkintro_bottom">
                <div class="bd_title"><!-- 모든 컨텐츠 타이틀 공통 -->
                    <i class="axi axi-label"></i>
                    <p>거주자우선주차</p>
                    <a>이면도로의 주차질서를 확립하여 지역 주민에게 안정적인 주차공간과 편익을 제공하기 위해 만들어진 제도입니다.</a>
                </div>
                <div class="bd_title"><!-- 모든 컨텐츠 타이틀 공통 -->
                    <i class="axi axi-label"></i>
                    <p>거주자우선주차란?</p>
                    <a>주택가 이면도로의 원활한 교통소통 및 주택난을 해소하고, 이면도로의 주차질서를 확립해 지역 주민에게 안정적인<br>주차 공간과편익을 제공하기 위해,
                        주택가 이면도로 등에 주차구획을 설정한 뒤, 유료화하여 인근 주민에게<br>우선적으로 주차 이용권을 부여하는 제도입니다.</a>
                </div>
                <div class="bd_title"><!-- 모든 컨텐츠 타이틀 공통 -->
                    <i class="axi axi-label"></i>
                    <p>거주자우선주차 배정기준표</p>
                </div>
                <div class="table_box">
                    <table class="table">
                        <thead>
                            <tr>
                                <th colspan='4'>기준</th>
                                <th>점수<br>(100)</th>
                                <th>증빙서류</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr style="border:1px solid #54acd2">
                                <td style="border:1px solid #54acd2">지<br>정<br>주<br>차</td>
                                <td colspan='3' style="text-align:left;padding:20px 0 20px 45px;border:1px solid #54acd2">○대상: 대문 앞, 창문 앞, 점포 출입구, 주차장 앞 등 주차구획<br><br>
                                	- 신규 신청자 12개월 사용기간 의무화(미삭선대상)<br>
                                	- 폐차, 매각, 주차장 확보 등으로 구획선 삭제시 24개월간 재설치금지<br>
                                	(24개월이내 재설치 신청시 도색 및 삭선비 원인자부담)<br>
                                	- 지정주차 구획선 삭제자 일반구획 배정 제외<br>
                                	- 이웃주민 신청시 지정주차대상자 동의후 사용<br>
                                	(지정주차대상자 사용 요청시에는 우선하여 배정함)<br><br>
                                	※ 개인주택 담장의 거주자우선주차구획선의 경우 1면에 한해서 집 주인의 지정주차 허용
                                </td>
                                <td style="border:1px solid #54acd2">선배정</td>
                                <td>현장확인<br>우선배정</td>
                            </tr>
                            <tr style="border:1px solid #54acd2">
                                <td rowspan='12' style="border:1px solid #54acd2">일<br>반<br>주<br>차<br>(100)</td>
                                <td rowspan='5' style="border:1px solid #54acd2">구획과의<br>거리<br>(40)</td>
                                <td colspan='2'>주택/점포로부터 30M이내</td>
                                <td style="border:1px solid #54acd2">40</td>
                                <td rowspan='5' style="border:1px solid #54acd2">집/점포 주출입문<br>으로부터 직선거리</td>
                            </tr>
                            <tr style="border:1px solid #54acd2">
                                <td colspan='2'>주택/점포로부터 60M이내</td>
                                <td style="border:1px solid #54acd2">30</td>
                            </tr>
                            <tr style="border:1px solid #54acd2">
                                <td colspan='2'>주택/점포로부터 90M이내</td>
                                <td style="border:1px solid #54acd2">20</td>
                            </tr>
                            <tr style="border:1px solid #54acd2">
                                <td colspan='2'>주택/점포로부터 120M 이내</td>
                                <td style="border:1px solid #54acd2">10</td>
                            </tr>
                            <tr style="border:1px solid #54acd2">
                                <td colspan='2'>주택/점포로부터 120M 초과</td>
                                <td style="border:1px solid #54acd2">5</td>
                            </tr>
                            <tr style="border:1px solid #54acd2">
                                <td rowspan='5' style="border:1px solid #54acd2">신청후<br>대기기간<br>(40)</td>
                                <td colspan='2'>신청일~현재 대기3년 이상</td>
                                <td style="border:1px solid #54acd2">40</td>
                                <td rowspan='5' style="border:1px solid #54acd2">자체확인</td>
                            </tr>
                            <tr style="border:1px solid #54acd2">
                                <td colspan='2'>신청일~현재 대기2년 이상 3년 미만</td>
                                <td style="border:1px solid #54acd2">30</td>
                            </tr>
                            <tr style="border:1px solid #54acd2">
                                <td colspan='2'>신청일~현재 대기1년 이상 2년 미만</td>
                                <td style="border:1px solid #54acd2">20</td>
                            </tr>
                            <tr style="border:1px solid #54acd2">
                                <td colspan='2'>신청일~현재 대기6개월 이상 1년 미만</td>
                                <td style="border:1px solid #54acd2">10</td>
                            </tr>
                            <tr style="border:1px solid #54acd2">
                                <td colspan='2'>신청일~현재 대기6개월 미만</td>
                                <td style="border:1px solid #54acd2">5</td>
                            </tr>
                            <tr style="border:1px solid #54acd2">
                                <td style="border:1px solid #54acd2">주차공유<br>실적<br>(10)</td>
                                <td colspan='2'>
                                	1년 1,000시간 공유<br>
                                	※ 1시간당 0.01점 계산 (소숫점 첫째자리 반올림)<br>
                                	※ 수시배정자는 배정일로부터 연말까지의 실적을<br>
                                	1년치로 환산하여 계산<br>
                                </td>
                                <td style="border:1px solid #54acd2">10</td>
                                <td style="border:1px solid #54acd2">자체확인</td>
                            </tr>
                            <tr style="border:1px solid #54acd2">
                                <td style="border:1px solid #54acd2">관할 동 거주여부(10)</td>
                                <td colspan='2'>거주자</td>
                                <td style="border:1px solid #54acd2">10</td>
                                <td style="border:1px solid #54acd2">주민등록초본</td>
                            </tr>
                            
                        </tbody>
                     </table>
                
	                <div class="bd_title"><!-- 모든 컨텐츠 타이틀 공통 -->
	                    <p>※ 배정기준 합산 점수가 동일할 경우의 동점자 선정순위</p>
	                    <br>- ①국가유공상이자, 장애인, 고엽제후유증환자 차량  ②전일(全日)제 차량 ③승용차요일제 참여 차량(전자태그 부착)
	                </div>
	                
	                <div class="bd_title"><!-- 모든 컨텐츠 타이틀 공통 -->
	                    <p>※ 공통구비서류 : 자동차등록증 사본 1부, 본인신분증 사본 1부</p>
	                </div>
                </div>
                
                <div class="bd_title"><!-- 모든 컨텐츠 타이틀 공통 -->
                    <i class="axi axi-label"></i>
                    <p>거주자 주차요금표</p>
                    <a>*1분기(3, 4, 5월)&nbsp;&nbsp;*2분기(6, 7, 8월)&nbsp;&nbsp;*3분기(9, 10, 11월)&nbsp;&nbsp;*4분기(12, 1, 2월)</a>
                </div>
                <div class="table_box">
                    <table class="table">
                        <thead>
                            <tr>
                                <th colspan='3'>구분</th>
                                <th>월 금액</th>
                                <th>분기금액</th>
                                <th colspan='3'>구분</th>
                                <th>월 금액</th>
                                <th>분기금액</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr style="border:1px solid #54acd2">
                                <td rowspan='12' style="border:1px solid #54acd2;width:50px;">노<br><br>상</td>
                                <td rowspan='3' style="border:1px solid #54acd2">장애인차량, 국가유공자(상이자)<br>동작구 의사상자 및 가족<br>(일반요금 80% 할인)</td>
                                <td style="border:1px solid #54acd2">전일</td>
                                <td style="border:1px solid #54acd2">8,000</td>
                                <td style="border:1px solid #54acd2">24,000</td>
                                <td rowspan='12' style="border:1px solid #54acd2;width:50px;">노<br><br>외</td>
                                <td rowspan='3' style="border:1px solid #54acd2">장애인차량, 국가유공자(상이자)<br>동작구 의사상자 및 가족<br>(일반요금 80% 할인)</td>
                                <td style="border:1px solid #54acd2">전일</td>
                                <td style="border:1px solid #54acd2">13,000</td>
                                <td style="border:1px solid #54acd2">39,000</td>
                            </tr>
                            <tr style="border:1px solid #54acd2">
                                <td style="border:1px solid #54acd2">주간</td>
                                <td style="border:1px solid #54acd2">6,000</td>
                                <td style="border:1px solid #54acd2">18,000</td>
                                <td style="border:1px solid #54acd2">주간</td>
                                <td style="border:1px solid #54acd2">7,800</td>
                                <td style="border:1px solid #54acd2">23,400</td>
                            </tr>
                            <tr style="border:1px solid #54acd2">
                                <td style="border:1px solid #54acd2">야간</td>
                                <td style="border:1px solid #54acd2">4,000</td>
                                <td style="border:1px solid #54acd2">12,000</td>
                                <td style="border:1px solid #54acd2">야간</td>
                                <td style="border:1px solid #54acd2">5,200</td>
                                <td style="border:1px solid #54acd2">15,600</td>
                            </tr>
                            <tr style="border:1px solid #54acd2">
                                <td rowspan='3' style="border:1px solid #54acd2">경차, 저공해,<br>다둥이행복카드소지자 3자녀<br>(일반요금 50% 할인)</td>
                                <td style="border:1px solid #54acd2">전일</td>
                                <td style="border:1px solid #54acd2">20,000</td>
                                <td style="border:1px solid #54acd2">60,000</td>
                                <td rowspan='3' style="border:1px solid #54acd2">경차, 저공해,<br>다둥이행복카드소지자 3자녀<br>(일반요금 50% 할인)</td>
                                <td style="border:1px solid #54acd2">전일</td>
                                <td style="border:1px solid #54acd2">32,500</td>
                                <td style="border:1px solid #54acd2">97,500</td>
                            </tr>
                            <tr style="border:1px solid #54acd2">
                                <td style="border:1px solid #54acd2">주간</td>
                                <td style="border:1px solid #54acd2">15,000</td>
                                <td style="border:1px solid #54acd2">45,000</td>
                                <td style="border:1px solid #54acd2">주간</td>
                                <td style="border:1px solid #54acd2">19,500</td>
                                <td style="border:1px solid #54acd2">58,500</td>
                            </tr>
                            <tr style="border:1px solid #54acd2">
                                <td style="border:1px solid #54acd2">야간</td>
                                <td style="border:1px solid #54acd2">10,000</td>
                                <td style="border:1px solid #54acd2">30,000</td>
                                <td style="border:1px solid #54acd2">야간</td>
                                <td style="border:1px solid #54acd2">13,000</td>
                                <td style="border:1px solid #54acd2">39,000</td>
                            </tr>
                            <tr style="border:1px solid #54acd2">
                                <td rowspan='3' style="border:1px solid #54acd2">다둥이행복카드소지자 2자녀<br>동작구 병역명문가<br>(일반요금 30% 할인)</td>
                                <td style="border:1px solid #54acd2">전일</td>
                                <td style="border:1px solid #54acd2">28,000</td>
                                <td style="border:1px solid #54acd2">84,000</td>
                                <td rowspan='3' style="border:1px solid #54acd2">다둥이행복카드소지자 2자녀<br>동작구 병역명문가<br>(일반요금 30% 할인)</td>
                                <td style="border:1px solid #54acd2">전일</td>
                                <td style="border:1px solid #54acd2">45,500</td>
                                <td style="border:1px solid #54acd2">136,500</td>
                            </tr>
                            <tr style="border:1px solid #54acd2">
                                <td style="border:1px solid #54acd2">주간</td>
                                <td style="border:1px solid #54acd2">21,000</td>
                                <td style="border:1px solid #54acd2">63,000</td>
                                <td style="border:1px solid #54acd2">주간</td>
                                <td style="border:1px solid #54acd2">27,300</td>
                                <td style="border:1px solid #54acd2">81,900</td>
                            </tr>
                            <tr style="border:1px solid #54acd2">
                                <td style="border:1px solid #54acd2">야간</td>
                                <td style="border:1px solid #54acd2">14,000</td>
                                <td style="border:1px solid #54acd2">42,000</td>
                                <td style="border:1px solid #54acd2">야간</td>
                                <td style="border:1px solid #54acd2">18,200</td>
                                <td style="border:1px solid #54acd2">54,600</td>
                            </tr>
                            <tr style="border:1px solid #54acd2">
                                <td rowspan='3' style="border:1px solid #54acd2">일반</td>
                                <td style="border:1px solid #54acd2">전일</td>
                                <td style="border:1px solid #54acd2">40,000</td>
                                <td style="border:1px solid #54acd2">120,000</td>
                                <td rowspan='3' style="border:1px solid #54acd2">일반</td>
                                <td style="border:1px solid #54acd2">전일</td>
                                <td style="border:1px solid #54acd2">65,000</td>
                                <td style="border:1px solid #54acd2">195,000</td>
                            </tr>
                            <tr style="border:1px solid #54acd2">
                                <td style="border:1px solid #54acd2">주간</td>
                                <td style="border:1px solid #54acd2">30,000</td>
                                <td style="border:1px solid #54acd2">90,000</td>
                                <td style="border:1px solid #54acd2">주간</td>
                                <td style="border:1px solid #54acd2">39,000</td>
                                <td style="border:1px solid #54acd2">117,000</td>
                            </tr>
                            <tr style="border:1px solid #54acd2">
                                <td style="border:1px solid #54acd2">야간</td>
                                <td style="border:1px solid #54acd2">20,000</td>
                                <td style="border:1px solid #54acd2">60,000</td>
                                <td style="border:1px solid #54acd2">야간</td>
                                <td style="border:1px solid #54acd2">26,000</td>
                                <td style="border:1px solid #54acd2">78,000</td>
                            </tr>
                        </tbody>
                     </table>
                 </div>
            </div>
        </div>
    </div>
</div>
</body>