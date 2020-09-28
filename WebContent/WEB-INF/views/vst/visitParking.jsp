<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/axisj/lib/AXGrid.js"></script>
    <title>방문주차소개 - 방문주차</title>

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
                            {key:"rnum",   label:"순번", width:40,    align:"center"},
                            {key:"sectionInfo", label:"구간/블럭/구획명", width:100, align:"left"},
                            {key:"", label:"위치보기", width:100, align:"center", formatter:function(){
                                var fnBtn = '<a class="btn green" onclick="openMap(\''+ this.item.manageZone +'\',\''+ this.item.parkSectionKey +'\',\''+ this.item.parkBlockKey +'\',\''+ this.item.parkDivisionKey +'\')" title="위치보기"><i class="axi axi-assignment-ind"></i></a>';
                                return fnBtn;
                            }}
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
                                    //selectRow(this.item);
                                //}
                            } 
                        },
                        page:{
                            paging:true,
                            pageSize:10
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
    
            //주차구역 검색 체인콤보구현
            $("#searchManageZone").change(function(){
    
                var searchManageZone = $(this).val();
    
                if(searchManageZone == ''){
                    $("#searchParkSectionKey").bindSelectSetValue("");
                    $("#searchParkBlockKey").bindSelectSetValue("");
                    $("#searchParkDivisionKey").bindSelectSetValue("");
                }else{
                    
                    $("#searchParkSectionKey").bindSelect({
    
                        ajaxUrl: "/com/searchVstSectionCombo.json", ajaxPars: "searchManageZone="+searchManageZone, ajaxAsync:false,
                        isspace: true, isspaceTitle: "전체",
                        //setValue: $("#todayQuarterSeq").val(),
                        alwaysOnChange: true,
                        onChange: function(){
                            
                            var searchParkSectionKey = $("#searchParkSectionKey").val();
                            
                            $("#searchParkBlockKey").bindSelect({
                                
                                ajaxUrl: "/com/searchVstBlockCombo.json", ajaxPars: "searchParkSectionKey="+searchParkSectionKey, ajaxAsync:false,
                                isspace: true, isspaceTitle: "전체",
                                setValue: this.optionValue,
                                alwaysOnChange: true,
                                onChange: function(){
                                    
                                    var searchParkBlockKey = $("#searchParkBlockKey").val();
                                    
                                    $("#searchParkDivisionKey").bindSelect({
                                        
                                        ajaxUrl: "/com/searchVstDivisionCombo.json", ajaxPars: "searchParkBlockKey="+searchParkBlockKey, ajaxAsync:false,
                                        isspace: true, isspaceTitle: "전체",
                                        setValue: this.optionValue,
                                        alwaysOnChange: true,
                                        onChange: function(){
                                            
                                        }
                                    });
                                }
                            });
                        }
                    });
                }
            });
            
        });
        
        //주차구역 검색
        function searchGrid(){
            
            if($("#searchManageZone").val() == ''){
                alert('주차구간검색을 선택하세요.');
                $("#searchManageZone").focus();
                return;
            }
            
            $('.before_mask').css('display', 'none');
            
            fnObj.pageStart();  
        }
        
        //맵조회
        function openMap(manageZone, parkSectionKey, parkBlockKey, parkDivisionKey) {
        	
        	var searchManageZone = manageZone;
        	var searchParkSectionKey = parkSectionKey;
        	var searchParkBlockKey = parkBlockKey;
        	var searchParkDivisionKey = parkDivisionKey;
            
            var popTitle = "Map" ;
            var sizeW = screen.width;
            var sizeH = screen.height;
            var nLeft = 0;
            var nTop  = 0;
            var opt = 'scrollbars=yes,status=yes,width=' + sizeW + ',height=' + sizeH + ',top='+nTop+',left='+nLeft;
            window.open("", popTitle, opt);
            
            $('<input/>').attr({type:'hidden',id:'openType',name:'openType',value:'RR'}).appendTo('#tempMapFrm');
            $('<input/>').attr({type:'hidden',id:'searchManageZone',name:'searchManageZone',value:searchManageZone}).appendTo('#tempMapFrm');
            $('<input/>').attr({type:'hidden',id:'searchParkSectionKey',name:'searchParkSectionKey',value:searchParkSectionKey}).appendTo('#tempMapFrm');
            $('<input/>').attr({type:'hidden',id:'searchParkBlockKey',name:'searchParkBlockKey',value:searchParkBlockKey}).appendTo('#tempMapFrm');
            $('<input/>').attr({type:'hidden',id:'searchParkDivisionKey',name:'searchParkDivisionKey',value:searchParkDivisionKey}).appendTo('#tempMapFrm');
            
            var tempMapFrmData = document.tempMapFrm ;
            tempMapFrmData.target = popTitle;
            tempMapFrmData.action = "/map/parkingMap.c";
            tempMapFrmData.submit();
            
            //히든값으로 만들었던 엘레멘트 비우기
            $("#tempMapFrm").empty();
            
        }
        
    </script>
</head>
<body>
<div class="page vst">
    <div class="ct_head">
        <div class="head">
            <div class="title">
                <h1>방문주차</h1>
                <h2><i class="axi axi-keyboard-arrow-right"></i>방문주차소개</h2>
            </div>
            <div class="log out">
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
        <!-- 내부 메뉴 -->
        <div class="sub_nav">
            <ul>
                <li><a class="on" href="javascript:fn_MovePage('/vst/visitParking.c');">방문주차소개</a></li>
                <li><a href="javascript:fn_MovePage('/vst/visitRequest.c');">이용신청</a></li>
            </ul>
        </div>
        <!-- 내부 메뉴 : END -->

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
                        <div class="small_box">인터넷 접속</div><i><i class="axi axi-ion-chevron-right"></i></i>
                        <div class="small_box">방문주차 신청하기</div><i><i class="axi axi-ion-chevron-right"></i></i>
                        <div class="small_box">요금납부</div><i><i class="axi axi-ion-chevron-right"></i></i>
                        <div class="small_box">방문주차권 출력</div><i><i class="axi axi-ion-chevron-right"></i></i>
                        <div class="small_box">주차권부착후<br>신청구간이용</div>
                    </div>
                    <h2>- 팩스 (02-832-2963), 유선접수 (02-832-2445~6)</h2>
                    <div class="visitintro_box_a">
                        <div class="small_box">전화신청 접수</div><i><i class="axi axi-ion-chevron-right"></i></i>
                        <div class="small_box">계좌번호 안내</div><i><i class="axi axi-ion-chevron-right"></i></i>
                        <div class="small_box">계좌이체 확인</div><i><i class="axi axi-ion-chevron-right"></i></i>
                        <div class="small_box">방문주차권 출력</div><i><i class="axi axi-ion-chevron-right"></i></i>
                        <div class="small_box">주차권부착후<br>신청구간이용</div>
                    </div>
                    <a class="bank">※ 입금계좌 : 국민은행 597737-01-003221 (예금주 : 서울특별시동작구도시시설관리공단) ※</a>
                </div>
                <div class="bd_title"><!-- 모든 컨텐츠 타이틀 공통 -->
                    <i class="axi axi-label"></i>
                    <p>방문주차 요금 안내</p>
                    <div class="big_box">
                        <table>
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
	            <div class="search_box">
	                <div class="axi_box">
	                    <select id="searchManageZone" name="searchManageZone" isspace="true" isspaceTitle="선택" class="AXSelect" url="${pageContext.request.contextPath}/com/searchVstManageZoneCombo.json" param="codeId=1"></select>
	                </div>
	                <div class="axi_box">
	                    <select id="searchParkSectionKey" name="searchParkSectionKey" class="AXSelect" tabindex="2"></select>
	                </div>
	                <div class="axi_box">
	                    <select id="searchParkBlockKey" name="searchParkBlockKey" class="AXSelect" tabindex="3"></select>
	                </div>
	                <div class="axi_box">    
	                    <select id="searchParkDivisionKey" name="searchParkDivisionKey" class="AXSelect" tabindex="4"></select>
	                </div>
	                <a class="btn dblue" onclick="searchGrid();">검색</a>
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
	            
	            <!-- 
                <div class="bd_title">
                    <i class="axi axi-label"></i>
                    <p>방문주차 사용  구간</p>
                    <div class="big_box">
                        <table>
                            <caption></caption>
                            <thead>
                                <tr>
                                    <th width="50%">주차구간</th>
                                    <th width="20%">위치</th>
                                    <th width="30%">구간번호</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>신대방 1동 도림천일대</td>
                                    <td><a class="btn green">보기</a></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>신신대방 2동 기상청앞</td>
                                    <td><a class="btn green">보기</a></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>대방동 서울공고</td>
                                    <td><a class="btn green">보기</a></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>노량진 1동 우성아파트일대</td>
                                    <td><a class="btn green">보기</a></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>노량진 2동 가블럭일대</td>
                                    <td><a class="btn green">보기</a></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>상동 1동 약수로길</td>
                                    <td><a class="btn green">보기</a></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>사당 5동 LG아파트일대</td>
                                    <td><a class="btn green">보기</a></td>
                                     <td></td>
                                </tr>
                                <tr>
                                    <td>신대방 1동 도림천일대</td>
                                    <td><a class="btn green">보기</a></td>
                                    <td></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                 -->
                
            </div>
            <!-- 각 페이지 컨텐츠 : END -->
        </div>
    </div>
</div>
</body>
</html>