<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="Referrer" content="origin">

    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <title>방문주차소개 - 방문주차</title>

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

        //주차구역검색 그리드
        var fnObj = {
            pageStart: function(){
                fnObj.grid.bind();
            },
            grid: {
                target : new AXGrid() ,
                bind: function(){
                    window.myGrid = fnObj.grid.target;
                    myGrid.setConfig({
                        targetID: "grid1",
                        sort        : true, //정렬을 원하지 않을 경우 (tip
                        colHeadTool : false, // column tool use
                        fitToWidth  : true, // 너비에 자동 맞춤
                        colHeadAlign: "center", // 헤드의 기본 정렬 값. colHeadAlign 을 지정하면 colGroup 에서 정의한 정렬이 무시되고 colHeadAlign : false 이거나 없으면 colGroup 에서 정의한 속성이 적용됩니다.
                        colGroup: [
                            {key:"rnum",   label:"순번", width:20,    align:"center"},
                            {key:"sectionInfo", label:"구간/블럭/구획명", width:100, align:"left"}/*,
                            {key:"", label:"위치보기", width:100, align:"center", formatter:function(){
                                var fnBtn = '<a class="btn green" onclick="openMap(\''+ this.item.manageZone +'\',\''+ this.item.parkSectionKey +'\',\''+ this.item.parkBlockKey +'\',\''+ this.item.parkDivisionKey +'\')" title="위치보기"><i class="axi axi-assignment-ind"></i></a>';
                                return fnBtn;
                            }}*/
                        ]
                        ,
                        colHead    : {
                            onclick: function() {
                                myGrid.click(0);
                            }
                        },
                        body : {
                            onclick: function(){
                                //if( this.c != 6 ){
                                selectRow(this.item);
                                //}
                            }
                        },
                        page:{
                            paging:false/*,
                            pageSize:10*/
                        }
                    });
                    myGrid.setList({
                        ajaxUrl: "/vst/selectDivisionList.json",
                        ajaxPars: $('#searchFrm').serialize(),
                        onLoad:function(){
                            //fnObj.clickRow(0);
                        }
                    });
                }
            },
            clickRow : function(seq){
                myGrid.click(seq);
            },
            reloadList: function(){
                myGrid.reloadList();
            }
        }

        $(document.body).ready(function(){
        	
        	//관리지구 콤보
        	$.ajax({
                url: "/com/searchVstManageZoneCombo.json",
                type: "POST",
                data: {},
                dataType: "json",
                success: function (data, textStatus, jqXHR) {
                	
                	$("#searchManageZone").append("<option value=''>동선택</option>");
                    
                    for(var i=0; i<data.options.length; i++){
                    	$("#searchManageZone").append("<option value='"+data.options[i].optionValue+"'>"+data.options[i].optionText+"</option>");
                    }
                },
                complete: function (data) {
                	$("#searchParkSectionKey").empty();
                    $("#searchParkSectionKey").append("<option value=''>구간전체</option>");
                    $("#searchParkBlockKey").empty();
                    $("#searchParkBlockKey").append("<option value=''>블럭전체</option>");
                    $("#searchParkDivisionKey").empty();
                    $("#searchParkDivisionKey").append("<option value=''>구획전체</option>");
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    //Error시, 처리
                }
            });
        	
        	$("#searchManageZone").change(function(){

                var searchManageZone = $(this).val();

                if(searchManageZone == ''){
                    $("#searchParkSectionKey").empty();
                    $("#searchParkSectionKey").append("<option value=''>구간전체</option>");
                    $("#searchParkBlockKey").empty();
                    $("#searchParkBlockKey").append("<option value=''>블럭전체</option>");
                    $("#searchParkDivisionKey").empty();
                    $("#searchParkDivisionKey").append("<option value=''>구획전체</option>");
                }else{
                	
                	$("#searchParkSectionKey").empty();
                    $("#searchParkBlockKey").empty();
                    $("#searchParkDivisionKey").empty();
                	
                	//구간콤보
                	$.ajax({
                        url: "/com/searchVstSectionCombo.json",
                        type: "POST",
                        data: {
                        	searchManageZone : searchManageZone
                        },
                        dataType: "json",
                        success: function (data, textStatus, jqXHR) {
                        	
                        	$("#searchParkSectionKey").append("<option value=''>구간전체</option>");
                            
                            for(var i=0; i<data.options.length; i++){
                            	$("#searchParkSectionKey").append("<option value='"+data.options[i].optionValue+"'>"+data.options[i].optionText+"</option>");
                            }
                        },
                        complete: function (data) {
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            //Error시, 처리
                        }
                    });
                	
                }
            });
        	
        	$("#searchParkSectionKey").change(function(){

                var searchParkSectionKey = $(this).val();

                if(searchParkSectionKey == ''){
                	$("#searchParkBlockKey").empty();
                    $("#searchParkBlockKey").append("<option value=''>블럭전체</option>");
                    $("#searchParkDivisionKey").empty();
                    $("#searchParkDivisionKey").append("<option value=''>구획전체</option>");
                }else{
                	
                    $("#searchParkBlockKey").empty();
                    $("#searchParkDivisionKey").empty();
                	
                	//블럭콤보
                	$.ajax({
                        url: "/com/searchVstBlockCombo.json",
                        type: "POST",
                        data: {
                        	searchParkSectionKey : searchParkSectionKey
                        },
                        dataType: "json",
                        success: function (data, textStatus, jqXHR) {
                        	
                        	$("#searchParkBlockKey").append("<option value=''>블럭전체</option>");
                            
                            for(var i=0; i<data.options.length; i++){
                            	$("#searchParkBlockKey").append("<option value='"+data.options[i].optionValue+"'>"+data.options[i].optionText+"</option>");
                            }
                        },
                        complete: function (data) {
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            //Error시, 처리
                        }
                    });
                	
                }
            });
        	
        	$("#searchParkBlockKey").change(function(){

                var searchParkBlockKey = $(this).val();

                if(searchParkBlockKey == ''){
                	$("#searchParkDivisionKey").empty();
                    $("#searchParkDivisionKey").append("<option value=''>구획전체</option>");
                }else{
                	
                    $("#searchParkDivisionKey").empty();
                	
                	//구획콤보
                	$.ajax({
                        url: "/com/searchVstDivisionCombo.json",
                        type: "POST",
                        data: {
                        	searchParkBlockKey : searchParkBlockKey
                        },
                        dataType: "json",
                        success: function (data, textStatus, jqXHR) {
                        	
                        	$("#searchParkDivisionKey").append("<option value=''>구획전체</option>");
                            
                            for(var i=0; i<data.options.length; i++){
                            	$("#searchParkDivisionKey").append("<option value='"+data.options[i].optionValue+"'>"+data.options[i].optionText+"</option>");
                            }
                        },
                        complete: function (data) {
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            //Error시, 처리
                        }
                    });
                	
                }
            });
			
        });

        //주차구역 검색
        function searchGrid(){

            if($("#searchManageZone").val() == ''){
                alert('동검색을 선택하세요.');
                $("#searchManageZone").focus();
                return;
            }

            $('.before_mask').css('display', 'none');

            fnObj.pageStart();

            // AXGrid.js 내부 코드 대체용
            $('.isTrLastChild').css('background','');

        }

        function selectRow(item) {
        	
        	$("#detailSectionInfo").text(item.sectionInfo);
        	$("#detailVisitParkYn").text(item.visitParkYn);
        	$("#detailVisitParkChargeComma").text(item.visitParkChargeComma);
        	$("#detailSectionClassifyName").text(item.sectionClassifyName);
        	$("#detailSectionTraitName").text(item.sectionTraitName);
        	$("#detailAssignUnitName").text(item.assignUnitName);
        	
        	//지도세팅
        	if(item.divisionLon != null || item.divisionLon != ''){
        		openMap(item.divisionName, item.divisionLon, item.divisionLat);
        	}

            // 마스크 덮기
            $('#bgMask').css('display', 'block');
            // 상세내용 호출
            $('#modalPopup').addClass('active');
        }
        
        //맵조회
        function openMap(divisionName, divisionLon, divisionLat) {
        	
        	$('#staticMap').empty();
        	
        	var markers = [
	            {
	                position: new daum.maps.LatLng(divisionLat, divisionLon), 
	                text: divisionName
	            }
			];
			
			staticMapContainer  = document.getElementById('staticMap'), // 이미지 지도를 표시할 div
			staticMapOption = {
			    center: new daum.maps.LatLng(divisionLat, divisionLon), // 이미지 지도의 중심좌표
			    level: 3, // 이미지 지도의 확대 레벨
			    marker: markers // 이미지 지도에 표시할 마커
			};
			
			// 이미지 지도를 생성합니다
			var staticMap = new daum.maps.StaticMap(staticMapContainer, staticMapOption);

        }

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
        <div class="page vst">
            <div class="ct_head">
                <div class="head">
                    <div class="title">
                        <h1>방문주차</h1>
                        <h2><i class="axi axi-keyboard-arrow-right"></i>방문주차소개</h2>
                    </div>
                </div>
            </div>

            <div class="ct_body">
                <!-- 각 페이지 컨텐츠 -->
                <div class="body">
                    <div class="visitintro">
                        <div class="bd_title"><!-- 모든 컨텐츠 타이틀 공통 -->
                            <i class="axi axi-label"></i>
                            <p>방문주차제란?</p>
                            <h4>배정받지 못한 차량이나 타지역에서 방문한 차량이 출근 등 기타사유로 여유로운 주간시간대<a>(09:00~18:00)에<br>'거주자우선주차장'의 주차구획을 이용할 수 있도록 하는 제도</a>입니다.</h4>
                        </div>
                        <div class="bd_title"><!-- 모든 컨텐츠 타이틀 공통 -->
                            <i class="axi axi-label"></i>
                            <p>방문주차제 이용방법</p>
                            <h2>- 온라인 (인터넷) 접수</h2>
                            <div class="visitintro_box_a">
                                <div class="small_box">인터넷 접속</div><i class="axi axi-ion-chevron-down"></i>
                                <div class="small_box">방문주차 신청하기</div><i class="axi axi-ion-chevron-down"></i>
                                <div class="small_box">요금납부</div><i class="axi axi-ion-chevron-down"></i>
                                <div class="small_box">방문주차권 출력</div><i class="axi axi-ion-chevron-down"></i>
                                <div class="small_box">주차권부착후 신청구간이용</div>
                            </div>
                            <h2>- 팩스 (02-832-2963), 유선접수 (02-832-2445~6)</h2>
                            <div class="visitintro_box_a">
                                <div class="small_box">전화신청 접수</div><i class="axi axi-ion-chevron-down"></i>
                                <div class="small_box">계좌번호 안내</div><i class="axi axi-ion-chevron-down"></i>
                                <div class="small_box">계좌이체 확인</div><i class="axi axi-ion-chevron-down"></i>
                                <div class="small_box">방문주차권 출력</div><i class="axi axi-ion-chevron-down"></i>
                                <div class="small_box">주차권부착후 신청구간이용</div>
                            </div>
                            <a class="bank">※ 입금계좌 : 국민은행 597737-01-003221 (예금주 : 서울특별시동작구도시시설관리공단) ※</a>
                        </div>
                        <div class="bd_title"><!-- 모든 컨텐츠 타이틀 공통 -->
                            <i class="axi axi-label"></i>
                            <p>방문주차 요금 안내</p>
                        </div>
                        <div class="table_box">
                            <table class="table">
                                <caption></caption>
                                <thead>
                                    <tr>
                                        <th width="20%">구분</th>
                                        <th width="50%">주차시설 이용 요금</th>
                                        <th width="30%">금액</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- 테이블 바디 1개 객체 -->
                                    <tr>
                                        <td>이용시간</td>
                                        <td>09:00 ~ 18:00 월~금요일 (토,일요일 및 공휴일 제외)</td>
                                        <td>월정기 1달 30,000원</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div class="bd_title"><!-- 모든 컨텐츠 타이틀 공통 -->
                        <i class="axi axi-label"></i>
                        <p>방문주차구역 검색</p>
                    </div>

                    <form id="tempMapFrm" name="tempMapFrm" action="" method="post"></form>

                    <!-- 검색 박스 -->
                    <form name="searchFrm" id="searchFrm">
                    <input type="hidden" id="mobileYn" name="mobileYn" value="Y" />

                    <div class="search_box">
                        <div class="select_box">
                            <select id="searchManageZone" name="searchManageZone"></select>
                        </div>
                        <div class="select_box">
                            <select id="searchParkSectionKey" name="searchParkSectionKey"></select>
                        </div>
                        <div class="select_box">
                            <select id="searchParkBlockKey" name="searchParkBlockKey"></select>
                        </div>
                        <div class="select_box">
                            <select id="searchParkDivisionKey" name="searchParkDivisionKey"></select>
                        </div>
                        <a class="btn blue submit" onclick="searchGrid();">검색</a>
                    </div>
                    </form>
                    <!-- 검색 박스 : END -->

                    <div class="bd_title"><!-- 모든 컨텐츠 타이틀 공통 -->
                        <i class="axi axi-label"></i>
                        <p>검색결과</p>
                    </div>

                    <!-- 테이블 박스 -->
                    <div class="table_box">
                        <div id="grid1" style="height: 462px;"></div><!-- 그리드 10개의 열 일때 높이 값 -->
                        <!-- 그리드 부르기 전 마스크 처리 -->
                        <div class="before_mask" style="height: 462px; line-height: 462px;">검색항목을 선택한 후 검색 버튼을 눌러주세요.</div>
                    </div>
                    <!-- 테이블 박스 : END -->
                </div>
                <!-- 각 페이지 컨텐츠 : END -->
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

<!-- 그리드 상세내용 모달 팝업 -->
<div id="modalPopup" class="modal">
    <div class="head">
        <a class="close_container" title="닫기"></a>
        <h1>상세내용</h1>
    </div>
    <div class="body">
        <!-- 지도 부분 -->
        <div class="map_view">
        	<div id="staticMap" style="width:100%;height:300px;"></div>
        </div>
        <!-- 테이블 부분 -->
        <div class="pop_up">
        	<table class="table">
                <caption>선택한 주차장 정보</caption>
                <thead>
                <tr>
                    <th colspan="3">구간/블럭/구획명</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td id="detailSectionInfo" colspan="3"></td>
                </tr>
                </tbody>
                <thead>
                <tr>
                    <th>방문주차여부</th>
                    <th>방문주차요금</th>
                    <th></th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td id="detailVisitParkYn"></td>
                    <td id="detailVisitParkChargeComma"></td>
                    <td id=""></td>
                </tr>
                </tbody>
                <thead>
                <tr>
                    <th>구간구분</th>
                    <th>구간특성</th>
                    <th>구간속성</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td id="detailSectionClassifyName"></td>
                    <td id="detailSectionTraitName"></td>
                    <td id="detailAssignUnitName"></td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

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
                        <li><a href="javascript:fn_MovePage('/m/res/defaultChargeInfo.m');">미납요금안내</a></li>
                    </ul>
                </li>
                <li class="vst active">
                    <a><i class="axi axi-accessibility"></i>방문주차</a>
                    <ul>
                        <li class="on"><a href="javascript:fn_MovePage('/m/vst/visitParking.m');">방문주차소개</a></li>
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