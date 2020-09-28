<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/axisj/lib/AXGrid.js"></script>

    <title>이용신청 - 방문주차</title>

    <script id="jscode">
    
        var myValidator = new AXValidator();
        
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
                            {key:"sectionInfo", label:"구간/블럭", width:100, align:"left"},
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
                                if( this.c != 2 ){ 
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
                        ajaxUrl: "/vst/selectCarList.json",
                        ajaxPars: {searchParkingProduct : '02'},
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
            
            //이용개월 변경시
            $("#useMonth").change(function(){
                
                var useMonth = $(this).val();
                
                if(useMonth != ''){
                    calcUseDate();
                }
            });
            
            //이용일(시작일만) 바인딩
            $("#useBeginDate").bindDate({
                align:"right",
                valign:"top",
                onChange:function(){
                    calcUseDate();
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
        
        //주차구역검색 그리드에서 선택한 오브텍트 전역변수
        var selectDivisionObj;

        //리스트클릭
        function selectRow(item){ 
            
            selectDivisionObj = item;
            
            $("#sectionInfo").val(item.sectionInfo);
            $("#parkSectionKey").val(item.parkSectionKey);
            $("#parkBlockKey").val(item.parkBlockKey);
            $("#parkDivisionKey").val(item.parkDivisionKey);
        }
        
        //이용일 자동계산
        function calcUseDate(){
            
            var useMonth = $("#useMonth").val();
            
            if(useMonth == ''){
                alert('이용개월을 선택하세요.');
                return;
            }
            
            //오늘날짜 str형태로 set
            var dateObj = new Date();
            var todayYear = dateObj.getFullYear();
            var todayMonth = dateObj.getMonth()+1;
            var todayDay = dateObj.getDate();
            
            if (("" + todayMonth).length == 1) {todayMonth = "0" + todayMonth;}
            if (("" + todayDay).length == 1) {todayDay = "0" + todayDay;}
            
            var today = todayYear + "-" + todayMonth + "-" + todayDay;
            
            //이용개월에 따른 +월 set
            var calcMonth = '';
            
            if(useMonth == '01'){
                calcMonth = '0';
            }else if(useMonth == '02'){
                calcMonth = '1';
            }else if(useMonth == '03'){
                calcMonth = '2';
            }
            
            //이용시작일에 날짜가 없으면 오늘날짜 set
            if($("#useBeginDate").val() == ''){
                $("#useBeginDate").val(today);
            }
            
            //이용시작일
            var useBeginDate = $("#useBeginDate").val();
            
            //이용시작일 split
            var useBeginDateArr = useBeginDate.split('-');
            
            //이용시작일을 date포맷으로 set
            var useBeginDateFomat = new Date(useBeginDateArr[0], useBeginDateArr[1], useBeginDateArr[2]);
            
            //date포맷으로 변경된 이용시작일에 +월 계산
            useBeginDateFomat.setMonth(useBeginDateFomat.getMonth() + parseInt(calcMonth));
            
            //계산된 date포맷에 -1일 계산
            useBeginDateFomat.setDate(useBeginDateFomat.getDate() - 1);
            
            //윤년체크후 1월30일과 1월31일에 대한 처리
            if(parseInt(useBeginDateArr[0])%4 == 0 && parseInt(useBeginDateArr[0])%100 != 0 || parseInt(useBeginDateArr[0])%400 == 0){
                
                if((useBeginDateArr[1] == '01' && useBeginDateArr[2] == '30') || (useBeginDateArr[1] == '01' && useBeginDateArr[2] == '31')){
                    if(calcMonth == '1'){
                        useBeginDateFomat.setDate(useBeginDateFomat.getDate() - 2);
                    }
                    if(calcMonth == '2'){
                        useBeginDateFomat.setDate(useBeginDateFomat.getDate() - 1);
                    }

                }
                
            }else{
                
                if((useBeginDateArr[1] == '01' && useBeginDateArr[2] == '30') || (useBeginDateArr[1] == '01' && useBeginDateArr[2] == '31')){
                    if(calcMonth == '1'){
                        useBeginDateFomat.setDate(useBeginDateFomat.getDate() - 3);
                    }
                    if(calcMonth == '2'){
                        useBeginDateFomat.setDate(useBeginDateFomat.getDate() - 2);
                    }

                }
            }
            
            //계산된 날짜를 이용종료일에 반영
            var useEndDateYear = useBeginDateFomat.getFullYear();
            var useEndDateMonth = useBeginDateFomat.getMonth()+1;
            var useEndDateDay = useBeginDateFomat.getDate();
            
            if (("" + useEndDateMonth).length == 1) {useEndDateMonth = "0" + useEndDateMonth;}
            if (("" + useEndDateDay).length == 1) {useEndDateDay = "0" + useEndDateDay;}
            
            var useEndDate = useEndDateYear + "-" + useEndDateMonth + "-" + useEndDateDay;
            
            $("#useEndDate").val(useEndDate);
        }
        
        //등록차량 그리드에서 선택한 오브텍트 전역변수
        var selectCarObj;
        
        //등록차량 리스트클릭
        function selectCarRow(item){ 
            
            selectCarObj = item;
            
            $("#carKey").val(item.carKey);
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
            
            //[20191216 lsh]2020-03-01 부로 사업 종료
            if($('#useEndDate').val() >= "2020-03-01") {
                alert('방문주차 서비스 종료로 2020년3월1일 이전까지만 신청할 수 있습니다.');
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
                    url : "/vst/saveRequest.json",
                    type: "POST", 
                    data: $('#frm').serialize(),
                    dataType:"json", 
                    success : function(data, textStatus, jqXHR) {
                        if (data.result == "OK") {
                            axf.alert("방문주차 신청에 성공했습니다. 계약/결제페이지에서 카드결제 해주세요.");
                            $('#contractMenu').submit();
                        } else {
                            axf.alert("방문주차 신청에 실패했습니다. 관리자에게 문의해주세요.");
                        }
                    },
                    error : function(jqXHR, textStatus, errorThrown){
                        axf.alert("code:"+jqXHR.status+"\nmessage:"+textStatus+"\nerror:"+errorThrown);
                    }
                });
            }
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
                <li><a href="javascript:fn_MovePage('/vst/visitParking.c');">방문주차소개</a></li>
                <li><a class="on" href="javascript:fn_MovePage('/vst/visitRequest.c');">이용신청</a></li>
            </ul>
        </div>
        <!-- 내부 메뉴 : END -->

        <!-- 각 페이지 컨텐츠 -->
        <div class="body">
            <div class="caption">
                <p>거주자우선주차 구역 중 희망주차 구역을 선택한 후 검색을 실행합니다.</p>
                <p>검색결과 내에서 원하는 주차장을 선택하고, 주차할 등록 차량을 선택합니다.</p>
                <p>대기자 신청 버튼을 눌러 신청합니다.</p>
            </div>
            <div class="bd_title"><!-- 모든 컨텐츠 타이틀 공통 -->
                <i class="axi axi-label"></i>
                <p>주차구역 검색</p>
            </div>
            
            <form name="contractMenu" id="contractMenu" action="${pageContext.request.contextPath}/mypage/parkingContract.c"></form>
            
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
                
                <!-- 
                <div class="axi_box">    
                    <select id="searchParkDivisionKey" name="searchParkDivisionKey" class="AXSelect" tabindex="4"></select>
                </div>
                 -->
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
            <input type="hidden" name="esntlId" id="esntlId" value="" />
            <input type="hidden" name="mberFlag" id="mberFlag" value="" />

            <div class="bd_title"><!-- 모든 컨텐츠 타이틀 공통 -->
                <i class="axi axi-label"></i>
                <p>주차장 선택</p>
            </div>
            <div class="block">
                <div class="caption">
                    <div class="line_box">
                        <label>이용시간</label>
                        <span>평일 오전9시 부터 오후 6시 까지 <font color="red">(주말이용 불가)</font></span>
                    </div>

                    <div class="line_box">
                        <label>신청일자</label>
                        <span id="requestDate"></span>
                    </div>
                </div>

                <div class="line">

                    <input type="text" name="sectionInfo" id="sectionInfo" class="wid300 AXInput av-required" placeholder="검색결과에서 주차장을 선택하십시오." readonly />
                    <input type="hidden" name="parkSectionKey" id="parkSectionKey" value="" class="AXInput av-required" title="주차장 선택" />
                    <input type="hidden" name="parkBlockKey" id="parkBlockKey" value="" class="AXInput av-required" title="주차장 선택" />
                    <!-- 
                    <input type="hidden" name="parkDivisionKey" id="parkDivisionKey" value="" class="AXInput av-required" title="주차장 선택" />
                     -->

                    <select id="useMonth" name="useMonth" isspace="true" isspaceTitle="이용개월선택" class="AXSelect av-required" url="${pageContext.request.contextPath}/mis/tax/codeMaster.json" param="codeId=DFM029"></select>

                    <div class="axi_box">
                        <input style="width:100px" id="useBeginDate" name="useBeginDate" type="text" class="AXInput av-required" placeholder="이용시작일" label="이용시작일" readonly="readonly" > ~
                        <input style="width:100px" id="useEndDate" name="useEndDate" type="text" class="AXInput av-required" placeholder="이용종료일" label="이용종료일" readonly="readonly">
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

            <div class="page_btn">
                <a class="btn green" onclick="saveRequest();">대기자 신청</a>
            </div>
        </div>
        <!-- 각 페이지 컨텐츠 : END -->
    </div>
</div>
</body>
</html>