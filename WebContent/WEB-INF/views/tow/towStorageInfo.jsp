<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<head>
    <title>견인보관소 - 견인보관소안내</title>

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
<div id="Page" class="page tow">
    <div class="ct_head">
        <div class="head">
            <div class="title">
                <h1>견인보관소</h1>
                <h2><i class="axi axi-keyboard-arrow-right"></i>견인보관소안내</h2>
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
                <li><a class="on" href="javascript:fn_MovePage('/tow/towStorageInfo.c');">견인보관소안내</a></li>
            </ul>
        </div>
        <div class="body">
            <div class="towintro_top">
                <div class="towintro_img"></div>
                <div class="towintro_right">
                    <h1>PARKING</h1>
                    <h3>견인보관소</h3>
                    <a>- 불법 주, 정차 및 거주자우선주차제 부정주차로 견인된 차량 보관<br>
                       - 피 견인차량의 견인료, 보관료 수납 및 반환업무<br>
                       - 장기보관차량 매각 및 폐차 등 강제처리 집행
                    </a>
                </div>
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
                    <a>차량 사용자 또는 소유주께서 신분증을 소지하시고 견인차량보관소를 방문하시어 견인료와 보관료를 납부하시면 차량을 인수해 가실 수 있습니다.</a>
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
                                <th colspan='2'>구분</th>
                                <th>견인료</th>
                                <th>보관료</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td rowspan='4'>승용자동차</td>
                                <td>경형</td>
                                <td>40,000원</td>
                                <td rowspan="11">30분당 700원<br>(승합자동차중 중형<br>과 대형은 1,200원),<br> 단, 1회 보관료는<br> 50만원을 한도로 한다.</td>
                            </tr>
                            <tr>
                                <td>소형</td>
                                <td>45,000원</td>
                            </tr>
                            <tr>
                                <td>중형</td>
                                <td>50,000원</td>
                            </tr>
                            <tr>
                                <td>대형</td>
                                <td>60,000원</td>
                            </tr>
                            <tr>
                                <td rowspan='4'>승합자동차</td>
                                <td>경형</td>
                                <td>40,000원</td>
                            </tr>
                            <tr>
                                <td>소형</td>
                                <td>60,000원</td>
                            </tr>
                            <tr>
                                <td>중형</td>
                                <td>80,000원</td>
                            </tr>
                            <tr>
                                <td>대형</td>
                                <td>140,000원</td>
                            </tr>
                            <tr>
                                <td colspan="2">이륜자동차</td>
                                <td>40,000원</td>
                            </tr>
                            <tr>
                            	<td rowspan="4">화물자동차<br> 특수자동차</td>
                                <td>2.5톤 미만</td>
                                <td>40,000원</td>
                            </tr>
                            <tr>
                                <td>2.5톤 이상<br> 6.5톤 미만</td>
                                <td>60,000원</td>
                            </tr>
                            <tr>
                                <td>6.5톤 이상<br> 10톤 미만</td>
                                <td>80,000원</td>
                                <td rowspan="2">30분당 1,200원 <br> 단, 1회 보관료는 50만원<br>을 한도로 한다.</td>
                            </tr>
                            <tr>
                                <td>10톤 이상</td>
                                <td>140,000원</td>
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
                    <a>부정주차(거주자) 위반으로 견인된 차량의 소유자(또는 사용자)는 견인차량보관소에 견인료 및 보관료를 납부하신 후 영수증을
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
                        <div id="staticMap" style="width:900px;height:250px;"></div>
                    </div>
                    <p>- 주      소 : 서울시 관악구 신림8동 1677-5<br>
                        - 전화번호 : 02-855-8611~2
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>
</body>