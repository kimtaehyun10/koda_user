<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>찾아오시는길 - 고객지원</title>
    
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
<div id="Page" class="page sup">
    <div class="ct_head">
        <div class="head">
            <div class="title">
                <h1>고객지원</h1>
                <h2><i class="axi axi-keyboard-arrow-right"></i>찾아오시는길</h2>
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
                        <sec:authentication var="user" property="principal"/>
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
                <li><a href="javascript:fn_MovePage('/sup/notice.c');">공지사항</a></li>
                <li><a href="javascript:fn_MovePage('/sup/qna.c');">자주묻는질문</a></li>
                <li><a href="javascript:fn_MovePage('/sup/phoneInfo.c');">전화번호안내</a></li>
                <li><a class="on" href="javascript:fn_MovePage('/sup/visitMap.c');">찾아오시는길</a></li>
            </ul>
        </div>
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
                    <div id="staticMap" style="width:900px;height:400px;"></div>
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
</body>
</html>