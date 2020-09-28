<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>주차장소개 - 공영주차장</title>
    
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
							{key:"sectionClassifyName", label:"구분", width:40, align:"center"},
							{key:"sectionTraitName", label:"특성", width:40, align:"center"},
	                        {key:"parkSectionName", label:"주차장명", width:80, align:"center"},
	                        {key:"totalDivision", label:"주차면수", width:40, align:"center"},
	                        {key:"publicPhoneNumber", label:"전화번호", width:80, align:"center", formatter:function(){
	                        	var publicPhoneNumber = '';
	                        	if(this.item.publicPhoneNumber == null){
	                        		publicPhoneNumber = '-';
	                        	}else{
	                        		publicPhoneNumber = this.item.publicPhoneNumber;
	                        	}
                                return publicPhoneNumber;
                            }},
	                        {key:"operationTime", label:"비고", width:90, align:"center", formatter:function()
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
                                addClass: function ()
                                {
                                    return "wrap_normal"
                                }
                            },
	                        {key:"", label:"위치확인", width:50, align:"center", formatter:function(){
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
                <h2><i class="axi axi-keyboard-arrow-right"></i>주차장현황</h2>
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
                <li><a class="on" href="javascript:fn_MovePage('/pub/parkingCondition.c');">주차장현황</a></li>
                <li><a href="javascript:fn_MovePage('/pub/defaultChargeInfo.c');">미납요금안내</a></li>
                <!--<li><a href="javascript:fn_MovePage('/pub/useInfo.c');">이용안내</a></li>-->
                <li><a href="javascript:fn_MovePage('/pub/publicRequest.c');">이용신청</a></li>
            </ul>
        </div>
        <div class="body">
            <div class="caption">
                <p>공영주차장 운영현황 소개 페이지입니다.</p>
            </div>

            <div class="bd_title"><!-- 모든 컨텐츠 타이틀 공통 -->
                <i class="axi axi-label"></i>
                <p>운영현황</p>
            </div>
            <div class="table_box">
            	<div id="grid1" style="height: 532px;"></div><!-- 그리드 10개의 열 일때 높이 값 -->
            </div>
        </div>
    </div>
</div>
</body>
</html>