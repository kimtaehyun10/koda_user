<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>공영주차 - 주차장소개</title>
    
    <script>
        
	    //공영주차장 그리드
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
	                        {key:"parkSectionName", label:"주차장명", width:80, align:"center"},
	                        {key:"sectionClassifyName", label:"구분", width:60, align:"center"},
	                        {key:"operationTime", label:"운영시간", width:100, align:"center", formatter:function()
                                {
                                    var operationTime = '';
                                    if(this.item.publicComment == null){
                                        if(this.item.operationStartTime == '0000' && this.item.operationEndTime == '2359'){
                                            operationTime = '24시간(연중무휴)';
                                        }else{
                                            operationTime = this.item.operationStartTimeStr +'~'+ this.item.operationEndTimeStr;
                                        }
                                    }else{
                                        operationTime = this.item.publicComment;
                                    }
                                    return operationTime;
                                },
                                // 두줄보기 활성화
                                addClass : function ()
                                {
                                    return "wrap_normal";
                                }
                            },
	                        {key:"timeParkInfo", label:"시간제(분단위)", width:80, align:"center", formatter:function(){
	                        	var timeParkCharge = '';
	                        	if(this.item.timeParkYn == 'Y'){
	                        		timeParkCharge = '('+ this.item.timeParkInterval +'분당)'+ this.item.timeParkChargeComma +'원';
	                        	}
                                return timeParkCharge;
                            }},
	                        {key:"charge", label:"전일/주간/야간", width:110, align:"center", formatter:function(){
	                        	var charge = '';
	                        	var allDayChargeComma = this.item.allDayChargeComma;
	                        	if(this.item.allDayChargeComma == '0' || this.item.allDayChargeComma == null){
	                        		allDayChargeComma = '없음';
	                        	}
	                        	var dayTimeChargeComma = this.item.dayTimeChargeComma;
	                        	if(this.item.dayTimeChargeComma == '0' || this.item.dayTimeChargeComma == null){
	                        		dayTimeChargeComma = '없음';
	                        	}
	                        	var nightTimeChargeComma = this.item.nightTimeChargeComma;
	                        	if(this.item.nightTimeChargeComma == '0' || this.item.nightTimeChargeComma == null){
	                        		nightTimeChargeComma = '없음';
	                        	}
	                        	
	                        	charge = allDayChargeComma +'/'+ dayTimeChargeComma +'/'+ nightTimeChargeComma;
                                return charge;
                            }},
	                        {key:"", label:"위치확인", width:60, align:"center", formatter:function(){
	                        	var detailBtn = '<a class="btn green" onclick="openSectionInfoPopup(\''+ this.index +'\')">위치</a>';
                                return detailBtn;
                            }},
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
	                        paging:false,
	                        display:false
	                    }
	                });
	                myGrid.setList({
	                    ajaxUrl: "/pub/selectParkingIntroList.json",
	                    ajaxPars: {},
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
	        
            //공영주차장 조회
            fnObj.pageStart();

			// AXGrid.js 내부 코드 대체용
			$('.isTrLastChild').css('background','');
            
        });
	    
	    //주차구역검색 그리드에서 선택한 오브텍트 전역변수
        var selectSectionObj;

        //리스트클릭
        function selectRow(item){ 
            
        	selectSectionObj = item;
        }
        
        //주차장 상세보기 팝업
        function openSectionInfoPopup(index) {
        	
        	fnObj.clickRow(index);
        	
        	if(selectSectionObj.sectionLon == null || selectSectionObj.sectionLat == null){
        		alert('상세보기를 준비중입니다.');
        		return;
        	}
        	
            var url = "/pub/popup/sectionInfoPopup.p";
            openPopLayer( url, "param=1", "", 880, 755 ,null ,null );
        }
    </script>
</head>
<body>
<div id="Page" class="page pub">
    <div class="ct_head">
        <div class="head">
            <div class="title">
                <h1>공영주차</h1>
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
                <li><a class="on" href="javascript:fn_MovePage('/pub/parkingIntro.c');">주차장소개</a></li>
                <li><a href="javascript:fn_MovePage('/pub/parkingCondition.c');">주차장현황</a></li>
                <li><a href="javascript:fn_MovePage('/pub/defaultChargeInfo.c');">미납요금안내</a></li>
                <!--<li><a href="javascript:fn_MovePage('/pub/useInfo.c');">이용안내</a></li>-->
                <li><a href="javascript:fn_MovePage('/pub/publicRequest.c');">이용신청</a></li>
            </ul>
        </div>
        <div class="body">
            <div class="pubintro_top">
                <div class="pubintro_img"></div>
                <div class="pubintro_right">
                    <h1>공영주차장</h1>
                    <h3>안전하고 쾌적한 주차환경</h3>
                    <p>동작구시설관리공단은 12개(노상 2개소, 노외 10개소)주차장을 관리운영하며 관내 원활한 교통소통과 주차질서 확립에 항상 노력하고 있습니다.</p>
                </div>
            </div>
            <div class="bd_title"><!-- 모든 컨텐츠 타이틀 공통 -->
                <i class="axi axi-label"></i>
                <p>주차장 소개</p>
            </div>
            <div class="block">
                <div class="caption">
                    <p>* 보라매 병원 앞은 일,공휴일 운영시간 및 요금 징수(10:00~20:00)</p>
                </div>
            </div>
            <div class="table_box">
                <div id="grid1" style="height: 532px;"></div><!-- 그리드 10개의 열 일때 높이 값 -->

            </div>
            <div class="block">
                <p>* 장애인 차량(복지카드 소지자) 및 국가유공상이자(유공자 수첩 소지자) 및 고엽제후유중의 환자, 의사상자 및 가족: 80%</p>
                <p>* 경형자동차(1000cc미만) 및 저공해차량, 전기자동차, 다둥이 카드(세자녀이상) : 50%</p>
                <p>* 승용차요일제 차량, 다둥이 카드(두자녀) : 30%(해당요일 운행차량)</p>
                <p>* 병역명문가 : 30%</p>
                <p>* 모범납세자(시장 또는 국세청장 인증) : 1년간 면제</p>
                <p>* 보라매 병원 앞은 일,공휴일 운영시간 및 요금 징수(10:00~20:00)</p>
                <p>* 대형차량은 별도문의</p>
                <p>* 구본청부설주차장 주간 월정기권 이용은 동작구청에서 근무하는 장애인 분에게만 적용됩니다.</p>
            </div>

            <div class="bd_title"><!-- 모든 컨텐츠 타이틀 공통 -->
                <i class="axi axi-label"></i>
                <p>환불신청안내</p>
            </div>
            <div class="block">
                <div class="info">
                    <p>* 신청방법 : 주차장 또는 공단에 방문하신 후 신청서와 구비서류 등 제출</p>
                    <p>* 구비서류</p>
                    <p class="in">월정기 환불 : 환불신청서, 월정기권(태그), 통장사본(본인명의) 각 1부</p>
                    <p class="in">할인관련 환불 : 환불신청서, 통장사본(본인명의), 감면대상 증빙서류 사본 각 1부</p>
                    <p class="in2 ">(장애인증, 국가유공자증, 요일제 태그 등)</p>
                    <p class="in">기타 환불 : 환불신청서, 통장사본(본인명의), 환불요청관련 증빙서류 각 1부</p>
                    <p class="in2">※ 환불신청서는 주차장과 공단에 비치되어 있습니다.</p>
                    <p>* 환불금액 : 공정거래위원회고시 제10016호 주차장이용표준약관에 따름</p>
                    <p>* 환불시기 : 신청 후 최대 14일</p>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>