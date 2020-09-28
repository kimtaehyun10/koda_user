<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/axisj/lib/AXGrid.js"></script>

    <script id="jscode">
    
        var myValidator = new AXValidator();
        var listCount = 0;
        
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
                            {key:"sectionInfo", label:"주차장명", width:100, align:"left"},
                            {key:"", label:"상세보기", width:100, align:"center", formatter:function(){
                                var detailBtn = '<a class="btn green" onclick="openSectionInfoPopup(\''+ this.index +'\')">상세보기</a>';
                                return detailBtn;
                            }},
                            {key:"totalDivision", label:"총주차구획", width:100, align:"center"},
                            {key:"", label:"대기자정보", width:100, align:"center", formatter:function(){
                                var standbyBtn = '<a class="btn green" onclick="openStandbyInfoPopup(\''+ this.index +'\',\''+ this.item.standbyCount +'\')">대기자정보</a>';
                                return standbyBtn;
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
                                if( this.c != 2 && this.c != 4){ 
                                    selectRow(this.item);
                                }
                            } 
                        },
                        page:{
                            paging:true,
                            pageSize:10
                        }
                    });
                    myGrid.setList({
                        ajaxUrl: "/pub/selectSectionList.json",
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
        
        //등록차량 그리드
        var carObj = {
            pageStart: function(){
                carObj.grid.bind();
            },  
            grid: { 
                target : new AXGrid() ,
                bind: function(){
                    window.carGrid = carObj.grid.target;
                    carGrid.setConfig({
                        targetID: "grid2",
                        sort        : true, //정렬을 원하지 않을 경우 (tip
                        colHeadTool : false, // column tool use
                        fitToWidth  : true, // 너비에 자동 맞춤  
                        colHeadAlign: "center", // 헤드의 기본 정렬 값. colHeadAlign 을 지정하면 colGroup 에서 정의한 정렬이 무시되고 colHeadAlign : false 이거나 없으면 colGroup 에서 정의한 속성이 적용됩니다.
                        colGroup: [
                            {key:"chk",   label:"선택", width:30,    align:"center" , 
                                formatter:function(){
                                    var radioInput = '<input type="radio" name="chk" value="'+this.item.carKey+'">';
                                    return radioInput;
                                }
                            },
                            {key:"carNumber",   label:"차량번호", width:100,    align:"center"},
                            {key:"carName",   label:"차량모델", width:100,    align:"center"},
                            {key:"lentCarYn",   label:"임대차량여부", width:60,    align:"center"}
                        ]
                        ,
                        colHead    : {
                            onclick: function() { 
                                carGrid.click(0); 
                            }
                        }, 
                        body : {
                            onclick: function(){
                                //if( this.c != 6 ){ 
                                    selectCarRow(this.item);
                                    //alert(this.item.contractCount);
                                //}
                            } 
                        },
                        page:{
                            paging:false/*,
                            pageSize:10*/
                        }
                    });
                    carGrid.setList({
                        ajaxUrl: "/com/selectCarList.json",
                        ajaxPars: {searchParkingProduct : '03'},
                        onLoad:function(){
                            //carObj.clickRow(0);
                        }  
                    });
                }  
            },
            clickRow : function(seq){
                carGrid.click(seq);
            },
            reloadList: function(){
                carGrid.reloadList();
            }
        }
        
        $(function(){ 
            myValidator.setConfig({
                targetFormName : "frm"
            });
        });
    
        $(document.body).ready(function(){
    
            //주차구역 검색 체인콤보구현
            $("#searchManageZone").change(function(){
    
                var searchManageZone = $(this).val();
    
                if(searchManageZone == ''){
                    $("#searchParkSectionKey").bindSelectSetValue("");
                }else{
                    
                    $("#searchParkSectionKey").bindSelect({
    
                        ajaxUrl: "/com/searchPubSectionCombo.json", ajaxPars: "searchManageZone="+searchManageZone, ajaxAsync:false,
                        isspace: true, isspaceTitle: "전체",
                        //setValue: $("#todayQuarterSeq").val(),
                        alwaysOnChange: true,
                        onChange: function(){
                        	
                        }
                    });
                }
            });
            
            //오늘날짜 구해서 신청일자에 넣어주기
            var nowDate = new Date();
            year = nowDate.getFullYear();
            month = nowDate.getMonth() + 1;
            day = nowDate.getDate();
    
            if (month < 10)
                month = "0" + month;
            if (day < 10)
                day = "0" + day;
            
            var requestDate = year+'년 '+month+'월 '+day+'일';
            $("#requestDate").text(requestDate);
            
            //차량정보그리드 조회
            carObj.pageStart();
            
	        //대기자 신청정보 조회
            $.ajax({
                url : "/pub/selectStandbyMyList.json",
                type: "POST", 
                data: {},
                dataType:"json", 
                success : function(data, textStatus, jqXHR) {
                	listCount = data.count;
                },
                error : function(jqXHR, textStatus, errorThrown){
                    axf.alert("code:"+jqXHR.status+"\nmessage:"+textStatus+"\nerror:"+errorThrown);
                }
            });
        });
        
        //주차구역 검색
        function searchGrid(){
            
            if($("#searchManageZone").val() == ''){
                alert('주차구역(동)을 선택하세요.');
                $("#searchManageZone").focus();
                return;
            }
            
            $('.before_mask').css('display', 'none');
            
            fnObj.pageStart();  
        }
        
        //주차구역검색 그리드에서 선택한 오브텍트 전역변수
        var selectSectionObj;

        //리스트클릭
        function selectRow(item){ 
            
        	selectSectionObj = item;
            
            $("#sectionInfo").val(item.sectionInfo);
            $("#parkSectionKey").val(item.parkSectionKey);
            
            if(item.allDayCharge == '0'){
            	$('#hopeTime').bindSelectRemoveOptions([{optionValue:01, optionText:'전일'}]);
            }else if(item.dayTimeCharge == '0'){
            	$('#hopeTime').bindSelectRemoveOptions([{optionValue:02, optionText:'주간'}]);
            }else if(item.nightTimeCharge == '0'){
                $('#hopeTime').bindSelectRemoveOptions([{optionValue:03, optionText:'야간'}]);
            }
        }
        
        //등록차량 그리드에서 선택한 오브텍트 전역변수
        var selectCarObj;
        
        //등록차량 리스트클릭
        function selectCarRow(item){ 
            
            selectCarObj = item;
            
            $("#carKey").val(item.carKey);
            $("#contractCount").val(item.contractCount);
            $("#esntlId").val(item.esntlId);
            $("#mberFlag").val(item.mberFlag);
        }
        
        //대기자신청
        function saveRequest(){
            
            var radioCheck = $('input:radio[name=chk]').is(':checked');
            
            if(!radioCheck){
                alert('등록차량을 선택하세요.');
                return;
            }
            
            if($("#contractCount").val() == '03'){
                alert('선택하신 차량은 공영주차 신청(배정)상태이며, 현재 공영주차는 신청할 수 없습니다.');
                return;
            }
            
            if(listCount > 0) {
            	alert('현재 공영주차 이용신청중입니다.\r\n재신청을 하시려면 나의 주차정보-대기현황조회에서 신청계약을 취소한 뒤 진행하시기 바랍니다.');
            	return;
            }
            
            $("#carKey").val($('input:radio[name=chk]:checked').val());
            
            var validateResult = myValidator.validate();
            
            if(!validateResult) {
                var msg = myValidator.getErrorMessage();
                AXUtil.alert(msg);
                myValidator.getErrorElement().focus();
                return false;
            }else{
                
                $.ajaxSettings.traditional = true;
                $.ajax({
                    url : "/pub/saveRequest.json",
                    type: "POST", 
                    data: $('#frm').serialize(),
                    dataType:"json", 
                    success : function(data, textStatus, jqXHR) {
                        if (data.result == "OK") {
                            axf.alert("공영주차 신청에 성공했습니다.");
                            $('#mainMenu').submit();
                        } else {
                            axf.alert("공영주차 신청에 실패했습니다. 관리자에게 문의해주세요.");
                        }
                    },
                    error : function(jqXHR, textStatus, errorThrown){
                        axf.alert("code:"+jqXHR.status+"\nmessage:"+textStatus+"\nerror:"+errorThrown);
                    }
                });
            }
        }
        
        //주차장 상세보기 팝업
        function openSectionInfoPopup(index) {
        	
        	fnObj.clickRow(index);
        	
            var url = "/pub/popup/sectionInfoPopup.p";
            openPopLayer( url, "param=1", "", 880, 755 ,null ,null );
        }
        
        //대기자정보 팝업
        function openStandbyInfoPopup(index, standbyCount) {
        	
        	if(standbyCount == '0'){
        		alert('해당주차장은 대기자가 존재하지 않습니다.');
        		return;
        	}
        	
        	fnObj.clickRow(index);
        	
            var url = "/pub/popup/standbyInfoPopup.p";
            openPopLayer( url, "param=1", "", 300, 200 ,null ,null );
        }
        
        
    </script>

<title>이용신청 - 공영주차</title>
</head>
<body>
<div class="page pub">
    <div class="ct_head">
        <div class="head">
            <div class="title">
                <h1>공영주차</h1>
                <h2><i class="axi axi-keyboard-arrow-right"></i>이용신청</h2>
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
                <li><a href="javascript:fn_MovePage('/pub/parkingIntro.c');">주차장소개</a></li>
                <li><a href="javascript:fn_MovePage('/pub/parkingCondition.c');">주차장현황</a></li>
                <li><a href="javascript:fn_MovePage('/pub/defaultChargeInfo.c');">미납요금안내</a></li>
                <!--<li><a href="javascript:fn_MovePage('/pub/useInfo.c');">이용안내</a></li>-->
                <li><a class="on" href="javascript:fn_MovePage('/pub/publicRequest.c');">이용신청</a></li>
            </ul>
        </div>
        <!-- 내부 메뉴 : END -->

        <!-- 각 페이지 컨텐츠 -->
        <div class="body">
            <div class="caption">
                <p>공영주차 구역 중 희망주차 구역을 선택한 후 검색을 실행합니다.</p>
                <p>검색결과 내에서 원하는 주차장을 선택하고, 주차할 등록 차량을 선택합니다.</p>
                <p>대기자 신청 버튼을 눌러 신청합니다.</p>
            </div>
            <div class="bd_title"><!-- 모든 컨텐츠 타이틀 공통 -->
                <i class="axi axi-label"></i>
                <p>주차구역 검색</p>
            </div>
            
            <form name="mainMenu" id="mainMenu" action="${pageContext.request.contextPath}/main"></form>

            <!-- 검색 박스 -->
            <form name="searchFrm" id="searchFrm">
            <div class="search_box">
                <div class="axi_box">
                    <select id="searchManageZone" name="searchManageZone" isspace="true" isspaceTitle="선택" class="AXSelect" url="${pageContext.request.contextPath}/com/searchPubManageZoneCombo.json" param="code=1"></select>
                </div>
                <div class="axi_box">
                    <select id="searchParkSectionKey" name="searchParkSectionKey" class="AXSelect" tabindex="2"></select>
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
            
            <form name="frm" id="frm">
            <input type="hidden" name="carKey" id="carKey" value="" />
            <input type="hidden" name="contractCount" id="contractCount" value="" />
            <input type="hidden" name="esntlId" id="esntlId" value="" />
            <input type="hidden" name="mberFlag" id="mberFlag" value="" />

            <div class="bd_title"><!-- 모든 컨텐츠 타이틀 공통 -->
                <i class="axi axi-label"></i>
                <p>주차장 선택</p>
            </div>
            <div class="block">
                <div class="caption">
                    <div class="line_box">
                        <label>신청일자</label>
                        <span id="requestDate"></span>
                    </div>
                </div>

                <div class="line">
                    <input type="text" name="sectionInfo" id="sectionInfo" class="wid300 AXInput av-required" placeholder="검색결과에서 주차장을 선택하십시오." readonly />
                    <input type="hidden" name="parkSectionKey" id="parkSectionKey" value="" />

                    <div class="axi_box">
                        <select id="hopeTime" name="hopeTime" isspace="true" isspaceTitle="이용시간선택" class="AXSelect av-required" url="${pageContext.request.contextPath}/mis/tax/codeMaster.json" param="codeId=DFM012"></select>
                    </div>
                    <input type="hidden" name="hopeRank" id="hopeRank" value="1" />

                    <div class="axi_box">
                        <select id="hopeMonth" name="hopeMonth" isspace="true" isspaceTitle="이용개월선택" class="AXSelect av-required" url="${pageContext.request.contextPath}/mis/tax/codeMaster.json" param="codeId=DFM029"></select>
                    </div>
                </div>
            </div>

            <div class="bd_title"><!-- 모든 컨텐츠 타이틀 공통 -->
                <i class="axi axi-label"></i>
                <p>등록차량 선택</p>
            </div>
            <div class="table_box">
                <div id="grid2" style="height: 122px;"></div>
            </div>
            </form>
            
            <div class="btn_group">
                <a class="btn green" onclick="saveRequest();">대기자 신청</a>
            </div>
        </div>
        <!-- 각 페이지 컨텐츠 : END -->
    </div>
</div>
</body>
</html>