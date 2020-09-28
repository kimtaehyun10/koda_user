<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="Referrer" content="origin">

    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <title>주차장계약 - 나의 주차정보</title>

    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resource/axicon/axicon.min.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resource/axisj/ui/AXJ.min.css"/>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/mobile/m_main.css"/>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/mobile/m_sub.css"/>

    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/axisj/dist/AXJ.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/axisj/lib/AXUtil.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/axisj/lib/AXValidator.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/mobile/m_common.js"></script>

    <script id="jscode">
    
        //주차장 계약정보 그리드
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
                            {key:"carNumber", label:"차량번호", width:"60", align:"center"},
                            {key:"parkingProductName", label:"상품", width:"80", align:"center"}
                            /*{key:"mberNm", label:"성명", width:"10", align:"center"},
                            {key:"sectionInfo", label:"주차장", width:"30", align:"left", formatter:function(){
                            	if(this.item.parkingProduct == '03'){
                            		return this.item.parkSectionName;
                            	}else{
                            		return this.item.parkSectionName+'/'+this.item.parkBlockName+'/'+this.item.divisionName;
                            	}
                            }},
                            {key:"useDate", label:"이용기간", width:"40", align:"center", formatter:function(){
                                return this.item.useBeginDateStr+'~'+this.item.useEndDateStr;
                            }},
                            {key:"useTime", label:"이용시간", width:"20", align:"left", formatter:function(){
                            	if(this.item.parkingProduct == '02'){
                                    return this.item.useMonthName;
                                }else{
                                    return this.item.useTimeName;
                                }
                            }},
                            {key:"costComma", label:"이용요금", width:"15", align:"right"},
                            {key:"useStatus", label:"상태", width:"10", align:"center", formatter:function(){
                                if(this.item.statusCd == '02'){
                                    return this.item.statusCdName;
                                }else{
                                    return this.item.useStatus;
                                }
                            }},
                            {key:"parkingProductName", label:"비고", width:"10", align:"center"}*/
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
                        ajaxUrl: "/mypage/selectContractList.json",
                        ajaxPars: {mobileYn : "Y"},
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
            
        	//주차장 계약정보 조회
            fnObj.pageStart();

            // AXGrid.js 내부 코드 대체용
            $('.isTrLastChild').css('background','');
            
        });
        
        //리스트클릭
        function selectRow(item){ 
            
        	$('#carNumber').text(item.carNumber);
        	$('#parkingProductName').text(item.parkingProductName);
        	
        	if(item.parkingProduct == '03'){
        		$('#sectionInfo').text(item.parkSectionName);
        	}else{
        		$('#sectionInfo').text(item.parkSectionName+'/'+item.parkBlockName+'/'+item.divisionName);
        	}
        	
        	$('#useDate').text(item.useBeginDateStr+'~'+item.useEndDateStr);
        	
        	if(item.parkingProduct == '02'){
        		$('#useTime').text(item.useMonthName);
            }else{
            	$('#useTime').text(item.useTimeName);
            }
        	
        	$('#costComma').text(item.costComma);
        	
        	if(item.statusCd == '02'){
        		$('#useStatus').text(item.statusCdName);
            }else{
            	$('#useStatus').text(item.useStatus);
            }
        	
        	// 마스크 덮기
            $('#bgMask').css('display', 'block');
            // 상세내용 호출
            $('#modalPopup').addClass('active');
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
        <div class="page mypage">
            <div class="ct_head">
                <div class="head">
                    <div class="title">
                        <h1>나의 주차정보</h1>
                        <h2><i class="axi axi-keyboard-arrow-right"></i>주차장계약</h2>
                    </div>
                </div>
            </div>
            <div class="ct_body">
                <div class="body">
                    <div class="caption">
                        <p>계약정보를 확인하여 결제하실 정보가 있을 시 납기마감일이 지나기 전에 결제해야 합니다.</p>
                        <p>납기마감일이 경과되었을 경우 계약된 모든 배정 정보는 취소됩니다.</p>
                    </div>
                    
                    <div class="bd_title">
                        <i class="axi axi-label"></i>
                        <p>주차장 계약정보</p>
                    </div>
                    <div class="table_box">
                        <div id="grid1" style="height: 462px;"></div><!-- 그리드 10개의 열 일때 높이 값 -->
                    </div>
                </div>
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
        <h1>계약상세내용</h1>
    </div>
    <div class="body">
        <div class="pop_up">
            <table class="table">
                <caption>계약상세내용</caption>
                <thead>
                <tr>
                    <th>차량번호</th>
                    <th>상품</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td id="carNumber"></td>
                    <td id="parkingProductName"></td>
                </tr>
                </tbody>
                <thead>
                <tr>
                    <th colspan="2">주차장</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td colspan="2" id="sectionInfo"></td>
                </tr>
                </tbody>
                <thead>
                <tr>
                    <th colspan="2">이용기간</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td colspan="2" id="useDate"></td>
                </tr>
                </tbody>
                <thead>
                <tr>
                    <th>이용시간</th>
                    <th>이용요금</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td id="useTime"></td>
                    <td id="costComma"></td>
                </tr>
                </tbody>
                <thead>
                <tr>
                    <th>상태</th>
                    <th></th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td id="useStatus"></td>
                    <td id=""></td>
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
                <li class="vst">
                    <a><i class="axi axi-accessibility"></i>방문주차</a>
                    <ul>
                        <li><a href="javascript:fn_MovePage('/m/vst/visitParking.m');">방문주차소개</a></li>
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
                <li class="mypage active">
                    <a><i class="axi axi-person"></i>나의 주차정보</a>
                    <ul>
                        <li class="on"><a href="javascript:fn_MovePage('/m/mypage/parkingContract.m');">주차장계약</a></li>
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