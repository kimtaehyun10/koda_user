<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/axisj/lib/AXGrid.js"></script>

    <title>공지사항 - 고객지원</title>
    
    <script id="jscode">
    
        //공지사항 그리드
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
                            {key:"title", label:"제목", width:200, align:"left"},
                            {key:"creationDateDecodeStr",   label:"등록일", width:80,    align:"center"}
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
                            paging:true,
                            pageSize:10
                        }
                    });
                    myGrid.setList({
                        ajaxUrl: "/sup/selectNoticeList.json",
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
            
            //공지사항 조회
        	fnObj.pageStart();
            
        });

        //등록차량 그리드에서 선택한 오브텍트 전역변수
        var selectNoticeObj;

        //주차장 상세보기 팝업
        function selectRow(item) {

        	selectNoticeObj = item;

            var url = "/sup/popup/noticePopup.p";
            openPopLayer( url, "param=1", "", 880, 755 ,null ,null );
        }
        
    </script>
</head>
<body>
<div id="Page" class="page sup">
    <div class="ct_head">
        <div class="head">
            <div class="title">
                <h1>고객지원</h1>
                <h2><i class="axi axi-keyboard-arrow-right"></i>공지사항</h2>
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
                <li><a class="on" href="javascript:fn_MovePage('/sup/notice.c');">공지사항</a></li>
                <li><a href="javascript:fn_MovePage('/sup/qna.c');">자주묻는질문</a></li>
                <li><a href="javascript:fn_MovePage('/sup/phoneInfo.c');">전화번호안내</a></li>
                <li><a href="javascript:fn_MovePage('/sup/visitMap.c');">찾아오시는길</a></li>
            </ul>
        </div>
        <div class="body">
            <div class="caption">
                <p>동작구 시설관리공단 주차장 시스템 공지사항입니다.</p>
            </div>

            <div class="bd_title">
                <i class="axi axi-label"></i>
                <p>공지사항</p>
            </div>
            <div class="table_box">
                <div id="grid1" style="height: 462px;"></div><!-- 그리드 10개의 열 일때 높이 값 -->
            </div>
        </div>
    </div>
</div>
</body>
</html>