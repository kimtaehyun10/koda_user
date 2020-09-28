<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<title>대기현황조회 - 나의 주차정보</title>

    <script id="jscode">

        //등록차량 그리드
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
                            //{key:"rnum",   label:"순번", width:50,    align:"center"},
                            {key:"parkingProductName",   label:"상품구분", width:100,    align:"center"},
                            {key:"requestDateStr",   label:"신청일", width:80,    align:"center"},
                            {key:"carNumber",   label:"차량번호", width:60,    align:"center"},
                            {key:"mberNm",   label:"성명", width:80,    align:"center"},
                            {key:"parkSectionName",   label:"희망구역(주차장)", width:120,    align:"center"},
                            {key:"hopeTimeName",   label:"희망시간", width:60,    align:"center"},
                            //{key:"",   label:"상태", width:10,    align:"center"},
                            //{key:"",   label:"대기현황", width:10,    align:"center"},
                            {key:"",   label:"계약취소", width:80,    align:"center", formatter:function(){
                                var cancelBtn = '<a class="btn red" title="계약취소" onclick="cancelRequest(\''+ this.index +'\')">계약취소</a>';
                                return cancelBtn;
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
                                selectRow(this.item);
                                //}
                            }
                        },
                        page:{
                            paging:false,
                             pageSize:10
                        }
                    });
                    myGrid.setList({
                        ajaxUrl: "/mypage/selectStandbyStatusList.json",
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

            //대기현황 그리드 조회
            fnObj.pageStart();

            // AXGrid.js 내부 코드 대체용
            $('.isTrLastChild').css('background','');

        });

        //대기현황 그리드에서 선택한 오브텍트 전역변수
        var selectContractObj;

        //리스트클릭
        function selectRow(item){

        	selectContractObj = item;
        }
        
        //계약취소
        function cancelRequest(index){
        	
        	fnObj.clickRow(index);
        	
        	var contractInfoKey = selectContractObj.contractInfoKey;
        	var hopeRequestSectionKey = selectContractObj.hopeRequestSectionKey;
        	
        	if (confirm("계약취소후 복구할 수 없습니다. 취소하시겠습니까?") == true){
        		
                $.ajax({
                    url : "/mypage/cancelRequest.json",
                    type: "POST",
                    data: {
                    	contractInfoKey : contractInfoKey,
                    	hopeRequestSectionKey : hopeRequestSectionKey
                    },
                    dataType:"json",
                    success : function(data, textStatus, jqXHR) {
                        if (data.result == "OK") {
                            axf.alert("계약취소를 성공했습니다.");
                            fnObj.pageStart();
                        } else {
                            axf.alert("계약취소를 실패했습니다. 관리자에게 문의해주세요.");
                        }
                    },
                    error : function(jqXHR, textStatus, errorThrown){
                        axf.alert("code:"+jqXHR.status+"\nmessage:"+textStatus+"\nerror:"+errorThrown);
                    }
                });
            }
        }

    </script>

</head>
<body>
<div id="Page" class="page mypage">
    <div class="ct_head">
        <div class="head">
            <div class="title">
                <h1>나의 주차정보</h1>
                <h2><i class="axi axi-keyboard-arrow-right"></i>대기현황조회</h2>
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
        <div class="sub_nav">
            <ul>
                <li><a href="javascript:fn_MovePage('/mypage/parkingContract.c');">주차요금결제</a></li>
                <li><a href="javascript:fn_MovePage('/mypage/parkingCharge.c');">거주자환불신청</a></li>
                <li><a class="on" href="javascript:fn_MovePage('/mypage/standbyStatus.c');">대기현황조회</a></li>
                <li><a href="javascript:fn_MovePage('/mypage/myInfoReconfirm.c');">정보수정</a></li>
                <li><a href="javascript:fn_MovePage('/mypage/outReconfirm.c');">회원탈퇴</a></li>
            </ul>
        </div>

        <div class="body">
            <div class="caption">
                <p>사용자가 요청한 계약의 대기현황을 볼 수 있습니다.</p>
                <p>결제 이전에 대기중인 계약은 계약취소 버튼을 통해 취소할 수 있습니다.</p>
            </div>

            <div class="block">
                <div class="bd_title"><!-- 모든 컨텐츠 타이틀 공통 -->
                    <i class="axi axi-label"></i>
                    <p>대기현황</p>
                </div>
                <div class="table_box">
                    <div id="grid1" style="height: 300px;"></div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>