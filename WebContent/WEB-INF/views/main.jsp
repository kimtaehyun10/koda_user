<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>한국장기조직기증원</title>

<link type="text/css" rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/axicon/axicon.min.css" />
<link type="text/css" rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/css/parallax_style.css" />

<script type="text/javascript"
	src="${pageContext.request.contextPath}/resource/js/jquery.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resource/js/jquery.cookie.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resource/js/jquery.parallax-1.1.3.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resource/js/jquery.localscroll-1.2.7-min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resource/js/jquery.scrollTo-1.4.2-min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resource/js/common.js"></script>


<script type="text/javascript">
    
        $(document).ready(function () {

            $('#scrollSpy').localScroll(800);
            $('#intro').parallax("50%", 0.1);
            $('#sectionFirst').parallax("50%", 0.1);
            $('#sectionSecond').parallax("50%", 0.1);
            $('#sectionThird').parallax("50%", 0.1);
            $('#sectionFourth').parallax("50%", 0.1);
            $('.obj_1').parallax("50%", 0.4);
            $('.obj_2').parallax("50%", 0.4);
            $('.obj_3').parallax("50%", 0.4);
            $('.obj_4').parallax("50%", 0.4);
            $('#footer').parallax("50%", 0.3);

            $('#user_pw').keypress(function(event){
                if(event.keyCode == 13) {
                    loginProc();
                }
            });
            
            $('#searchCarNumber').keypress(function(event){
                if(event.keyCode == 13) {
                	carNumProc();
                }
            });
            
            $('.quick').click(function () {
                if($('#quickMenu').hasClass('on') == false){
                    $('#quickMenu').addClass('on');
                } else {
                    $('#quickMenu').removeClass('on');
                }
            });

        });
    
	    function fn_MovePage(url) {
	    	document.location.href = url; 
	    }
	    
	    function poptastic(url)
	    {
	    	window.open("/map/emailPopup", "", 'toolbar=no, width=1000, height=600, status=yes, menubar=no, scrollbars=yes');	    	
	    }
	    

        /*
        function saveid() {
            var expdate = new Date();
            // 기본적으로 30일동안 기억하게 함. 일수를 조절하려면 * 30에서 숫자를 조절하면 됨
            if ($('#checkId').is(":checked"))
                expdate.setTime(expdate.getTime() + 1000 * 3600 * 24 * 30); // 30일
            else
                expdate.setTime(expdate.getTime() - 1); // 쿠키 삭제조건
            setCookie("saveid", $('#user_id').val(), expdate);
        }
        */

        function loginProc() {
            if ($("#user_id").val() == "") {
                alert("ID를 입력하세요");
                $("#user_id").focus();
                return;
            }

            if ($("#user_pw").val() == "") {
                alert("비밀번호를 입력하세요");
                $("#user_pw").focus();
                return;
            }

            $("#loginForm").submit();
        }

        var errorCode = "${loginError}";
        if (errorCode == '01') {
        	var count = parseInt('<%=session.getAttribute("failCount")%>') + 1;
            if (count > 0) {
            	alert("로그인 실패했습니다.\r\n5회이상 실패할 경우 30분간 계정이 잠깁니다.\r\n현재 실패횟수 : " + count);
            } else {
            	alert("로그인이 실패했습니다.");            	
            }
        } else if (errorCode == '02') {
            alert("로그인 후 이용하실수 있습니다. 로그인해주세요.");
        } else if (errorCode == '03') {
            alert("로그인 실패 횟수(5회)를 초과했습니다. 30분후 다시 로그인해 주세요");
        }
        
        initTimer = function() {
        	var session = '<%=request.getSession().getId()%>';
        	var max = parseInt('<%=request.getSession().getMaxInactiveInterval()%>');
        	
            $.ajax({
                url : "/com/selectSession.json",
                type: "POST", 
                data: {session : session},
                dataType:"json", 
                success : function(data, textStatus, jqXHR) {
                	var seconds = data.pastSeconds;
                	 
                	if (seconds >= max) {
                		location.href = "/sessionError";
                	} else {
                		setTimeout("initTimer()", 120000); // 2분 간격으로 체크
                	}
                },
                error : function(jqXHR, textStatus, errorThrown){
                    //Error시, 처리
                }
            });
        }

        //맵조회
        function openMap() {
            
            var popTitle = "Map" ;
            var sizeW = screen.width;
            var sizeH = screen.height;
            var nLeft = 0;
            var nTop  = 0;
            var opt = 'scrollbars=yes,status=yes,width=' + sizeW + ',height=' + sizeH + ',top='+nTop+',left='+nLeft;
            window.open("", popTitle, opt);
            
            $('<input/>').attr({type:'hidden',id:'openType',name:'openType',value:'M'}).appendTo('#tempMapFrm');
            $('<input/>').attr({type:'hidden',id:'searchManageZone',name:'searchManageZone',value:''}).appendTo('#tempMapFrm');
            $('<input/>').attr({type:'hidden',id:'searchParkSectionKey',name:'searchParkSectionKey',value:''}).appendTo('#tempMapFrm');
            $('<input/>').attr({type:'hidden',id:'searchParkBlockKey',name:'searchParkBlockKey',value:''}).appendTo('#tempMapFrm');
            $('<input/>').attr({type:'hidden',id:'searchParkDivisionKey',name:'searchParkDivisionKey',value:''}).appendTo('#tempMapFrm');
            
            var tempMapFrmData = document.tempMapFrm ;
            tempMapFrmData.target = popTitle;
            tempMapFrmData.action = "/map/parkingMap.c";
            tempMapFrmData.submit();
            
            //히든값으로 만들었던 엘레멘트 비우기
            $("#tempMapFrm").empty();
            
        }

        $(document).ready(function(){

            // 팝업 창 활성화 : 쿠키 없을 경우만
            //2019-03-24 비활성
            /*
            var cookie = $.cookie('the_cookie');
            if (cookie == null){
                window.open("/map/dailyPopup", "", 'toolbar=no, width=700, height=330, status=yes, menubar=no, scrollbars=no');
            }
            */
            
            /*
            //2019-01-29 설현휴 주차안내
            var cookie2 = $.cookie('image_popup');
            if (cookie2 == null){
            	window.open("/map/imagePopup", "", 'toolbar=no, width=1000, height=800, status=yes, menubar=no, scrollbars=yes');
            }
            */
            
            
            //2019-12-16 방문주차 사업 종료 안내
            /*
            var cookie2 = $.cookie('image_popup2');
            if (cookie2 == null){
            	window.open("/map/imagePopup", "", 'toolbar=no, width=631, height=203, status=yes, menubar=no, scrollbars=no, location=no');
            }
            */

            /*
            // 아이디 저장 checkbox 활성 / 비활성
            $('label[for="checkId"]').click(function () {
                if ($('#checkId').is(':checked') == false){
                    $('#checkId').prop('checked', true);
                } else {
                    $('#checkId').prop('checked', false);
                }
            });

            // 아이디 저장 : jquery cookie 사용
            var saveId = $.cookie('user_id');

            if (saveId != undefined){
                $('#saveId').val(saveId);
            }

            $('#btnLogin').click(function () {

                if ($('#checkId').prop('checked')){
                    $.cookie('user_id', $('#saveId').val());
                } else {
                    $.removeCookie('user_id');
                }

            });
            */
            
            
            $.ajax({
                url : "/sup/selectNoticeList.json",
                type: "POST", 
                data: {pageSize : 5},
                dataType:"json", 
                success : function(data, textStatus, jqXHR) {
                	console.log(data);
                	//$('#noticeTbody').submit();
                	
                	var htmlSum = "";

                    for(var i=0; i<data.list.length; i++) {

                        var html = "";
                        
                        html = html + '<tr onclick="fn_MovePage(\'/sup/notice.c\');"><td class="left"><div>';
                        html = html + data.list[i].title;
                        html = html + '</div></td><td><div>';
                        html = html + data.list[i].creationDateDecodeStr;
                        html = html + '</div></td></tr>';
                        
                        htmlSum = htmlSum + html;
                    }
                    
                    if(data.list.length != 5){
                    	for(var i=0; i<5-data.list.length; i++) {

                            var nullHtml = "";
                            
                            nullHtml = nullHtml + '<tr><td class="left"><div>';
                            nullHtml = nullHtml + '</div></td><td><div>';
                            nullHtml = nullHtml + '</div></td></tr>';
                            
                            htmlSum = htmlSum + nullHtml;
                        }
                    }
                    

                    $("#noticeTbody").html(htmlSum);
                },
                error : function(jqXHR, textStatus, errorThrown){
                    axf.alert("code:"+jqXHR.status+"\nmessage:"+textStatus+"\nerror:"+errorThrown);
                }
            });

        });

        $(function(){

        	var authenticated = '<%=session.getAttribute("isLocallyAuthenticated")%>';
        	var max = parseInt('<%=request.getSession().getMaxInactiveInterval()%>');
		if (authenticated == 'true' && max > 0) {
			initTimer();

			var passwordDt = document.getElementById("passwordDt");
			var lastPassword = passwordDt.value;

			var lastDate = new Date(lastPassword.substr(0, 10));
			var current = new Date();
			var chkCurrent = new Date();
			chkCurrent.setMonth(current.getMonth() - 3);

			if (lastDate < chkCurrent) {
				alert('비밀번호를 변경한지 3개월이 경과했습니다.\r\n개인정보 보호를 위해 비밀번호를 변경하시기 바랍니다.\r\n이 메시지는 비밀번호가 변경될때까지 매번 로그인 마다 표시됩니다.');
			}
		}
	});
</script>

</head>

<body>
	<div class="wrap">
		<div class="header">
			<div class="header_in">
				<div class="logo">
					<%-- <img
						src="${pageContext.request.contextPath}/resource/images/hd_title.png"
						alt="중랑구시설관리공단" /> --%>
				</div>

				<div class="nav">
					<ul>
						<li class="res"><a>공단소개</a>
							<ul>
								<li><a
									href="javascript:fn_MovePage('/res/parkingIntro.c');">주차장소개</a></li>
								<li><a
									href="javascript:fn_MovePage('/res/enforcementBasis.c');">시행근거</a></li>
								<li><a
									href="javascript:fn_MovePage('/res/regulateBasis.c');">단속근거</a></li>
								<li><a
									href="javascript:fn_MovePage('/res/parkingCondition.c');">주차장현황</a></li>
								<li><a
									href="javascript:fn_MovePage('/res/moduparkingIntro.c');">모두의주차장소개</a></li>
								<li><a
									href="javascript:fn_MovePage('/res/defaultChargeInfo.c');">요금납부안내</a></li>
								<li><a
									href="javascript:fn_MovePage('/res/residentRequest.c');">이용신청</a></li>
							</ul></li>
						<li class="vis"><a>고객광장</a>
							<ul>
								<li><a
									href="javascript:fn_MovePage('/vst/visitParking.c');">방문주차소개</a></li>
								<li><a
									href="javascript:fn_MovePage('/vst/visitRequest.c');">이용신청</a></li>
							</ul></li>
						<li class="pub"><a>체육시설</a>
							<ul>
								<li><a
									href="javascript:fn_MovePage('/pub/parkingIntro.c');">주차장소개</a></li>
								<li><a
									href="javascript:fn_MovePage('/pub/parkingCondition.c');">주차장현황</a></li>
								<li><a
									href="javascript:fn_MovePage('/pub/defaultChargeInfo.c');">미납요금안내</a></li>
								<!--<li><a href="javascript:fn_MovePage('/pub/useInfo.c');">이용안내</a></li>-->
								<li><a
									href="javascript:fn_MovePage('/pub/publicRequest.c');">이용신청</a></li>
							</ul></li>
						<li class="reg"><a>도서관시설</a>
							<ul>
								<li><a
									href="javascript:fn_MovePage('/tow/towStorageInfo.c');">견인보관소안내</a></li>
							</ul></li>
						<li class="inf"><a>주차시설</a>
							<ul>
								<li><a
									href="javascript:fn_MovePage('/mypage/parkingContract.c');">주차요금결제</a></li>
								<li><a
									href="javascript:fn_MovePage('/mypage/parkingCharge.c');">거주자환불신청</a></li>
								<li><a
									href="javascript:fn_MovePage('/mypage/standbyStatus.c');">대기현황조회</a></li>
								<li><a
									href="javascript:fn_MovePage('/mypage/myInfoReconfirm.c');">정보수정</a></li>
								<li><a
									href="javascript:fn_MovePage('/mypage/outReconfirm.c');">회원탈퇴</a></li>
							</ul></li>
						<li class="cus"><a>시설운영</a>
							<ul>
								<li><a href="javascript:fn_MovePage('/sup/notice.c');">공지사항</a></li>
								<li><a href="javascript:fn_MovePage('/sup/qna.c');">자주묻는질문</a></li>
								<li><a href="javascript:fn_MovePage('/sup/phoneInfo.c');">전화번호안내</a></li>
								<li><a href="javascript:fn_MovePage('/sup/visitMap.c');">찾아오시는길</a></li>
							</ul></li>
					</ul>
				</div>
			</div>
		</div>

		<div id="quickMenu" class="on">
			<div class="quickmenu">
				<div class="title">Quick Menu</div>
				<ul>
					<li><a
						href="javascript:fn_MovePage('/res/residentRequest.c');"><i
							class="axi axi-assignment"></i>aaaa<br>aaaa</a></li>
					<li><a href="javascript:fn_MovePage('/vst/visitRequest.c');"><i
							class="axi axi-assignment"></i>bbbb<br>bbbb</a></li>
					<li><a href="javascript:fn_MovePage('/pub/publicRequest.c');"><i
							class="axi axi-assignment"></i>cccc<br>cccc</a></li>
					<li><a href="javascript:fn_MovePage('/sup/phoneInfo.c');"><i
							class="axi axi-perm-phone-msg"></i>dddd<br>dddd</a></li>
					<li><a
						href="javascript:fn_MovePage('/mypage/parkingContract.c');"><i
							class="axi axi-assignment-late"></i>eeee<br>eeee</a></li>
					<li><a onclick="openMap();"><i class="axi axi-location-on"></i>ffff<br>ffff</a></li>
				</ul>
			</div>
			<a class="quick"><i class="axi axi-add"></i></a>
		</div>

		<ul id="scrollSpy">
			<li><a class="spy_1" href="#intro"><div>
						<p>0</p>
					</div>
					<i class="axi axi-vertical-align-top"></i></a></li>
			<li><a class="spy_2" href="#sectionFirst"><div>
						<p>1</p>
					</div>
					<i class="axi axi-home"></i></a></li>
			<li><a class="spy_3" href="#sectionSecond"><div>
						<p>2</p>
					</div>
					<i class="axi axi-accessibility"></i></a></li>
			<li><a class="spy_4" href="#sectionThird"><div>
						<p>3</p>
					</div>
					<i class="axi axi-local-parking"></i></a></li>
			<li><a class="spy_5" href="#sectionFourth"><div>
						<p>4</p>
					</div>
					<i class="axi axi-warning"></i></a></li>
			<li><a class="spy_6" href="#footer"><div>
						<p>5</p>
					</div>
					<i class="axi axi-vertical-align-bottom"></i></a></li>
		</ul>

		<div id="intro">
			<div class="sc_box">
				<div class="sc_text">
					<p> <!-- 
						동작 구민이 인정하는 우량 공기업<span>&nbsp;동작구시설관리공단</span>
						 -->
					</p>
					<h1>
						<span>JNANG</span>
					</h1>
				</div>
				<div class="sc_notice">
					<div class="title">
						<i class="axi axi-label"></i>공지사항
					</div>
					<table class="table">
						<caption>공지사항을 메인페이지에서 최신순으로 보여줍니다</caption>
						<thead>
							<tr>
								<th width="70%">제목</th>
								<th width="30%">작성일</th>
							</tr>
						</thead>
						<tbody id="noticeTbody"></tbody>
					</table>
				</div>

				<form id="tempMapFrm" name="tempMapFrm" action="" method="post">
				</form>

				<!-- 로그인 이전 -->
				<sec:authorize access="isAnonymous()">
					<form id="loginForm" name="loginForm"
						action="<c:url value='/loginProc'/>" method="post">
						<div class="login">
							<input id="user_id" name="user_id" class="text" type="text"	placeholder="아이디" /> 
							<input id="user_pw" name="user_pw" class="text" type="password" placeholder="비밀번호" />
							<a id="btnLogin" class="btn dblue" onclick="javascript:loginProc();">로그인</a>
							<a class="text"	href="javascript:fn_MovePage('/mem/memberIpin.c');">아이디/비밀번호 찾기</a> 
							<a class="text join" href="javascript:fn_MovePage('/mem/memberJoinIpin.c');">회원가입</a>
						</div>
					</form>
				</sec:authorize>

				<!-- 로그인 이후 -->
				<sec:authorize access="isAuthenticated()">
					<div class="login after">
						<sec:authentication var="user" property="principal" />
						<p>
							<span>${user.mberNm}</span>님 환영합니다.
						</p>

						<input type="hidden" id="passwordDt" name="passwordDt"
							value="<c:out value='${user.passwordDt}'/>" /> <a
							href="javascript:fn_MovePage('/mypage/myInfoReconfirm.c');">회원정보
							확인 및 수정 페이지로 이동</a> <a class="btn red"
							href="<c:url value='/logout'/>">로그아웃</a>
					</div>
				</sec:authorize>

<!-- 
				<div class=park_info>
					<p>
						<span>주차단속조회</span>
					</p>
					<p>(비회원 가능. 로그인 필요없음)</p>
					<input id="searchCarNumber" name="searchCarNumber" class="text"
						type="text" placeholder="차량번호" /> <a id="btnCarNumber"
						class="btn green" onclick="javascript:carNumProc();">검색</a>
				</div>
 -->

				<div class="drag">
					<p>마우스 스크롤을 내려보세요</p>
					<i class="axi axi-mouse"></i> <span></span>
				</div>
			</div>
		</div>

		<div id="sectionFirst">
			<div class="section">
				<div class="obj_1"></div>
				<div class="right">
					<h2>거주자우선주차</h2>
					<p>
						이면도로의 주차질서를 확립해 지역 주민에게<br> 안정적인 주차 공간과 편익을 제공하기 위해 만들어진
						제도입니다.
					</p>
				</div>
				<div class="link right">
					<div class="top">
						<span></span> <a
							href="javascript:fn_MovePage('/res/moduparkingIntro.c');">모두의<br>주차장
						</a>
					</div>
					<div class="bot">
						<a href="javascript:fn_MovePage('/res/parkingCondition.c');">주차장<br>현황
						</a> <a class="one"
							href="javascript:fn_MovePage('/res/regulateBasis.c');">단속근거</a> <a
							class="one"
							href="javascript:fn_MovePage('/res/enforcementBasis.c');">시행근거</a>
						<a href="javascript:fn_MovePage('/res/parkingIntro.c');">주차장<br>소개
						</a>
					</div>
				</div>
			</div>
		</div>

		<div id="sectionSecond">
			<div class="section">
				<div class="obj_2"></div>
				<div class="left">
					<h2>방문주차</h2>
					<p>
						배정받지 못한 차량이나 타지역에서 방문한 차량이 출근 등 기타사유로<br> 여유로운
						주간시간대(09:00~18:00)에 '거주자우선주차장'의 주차구획을 이용할 수 있도록 하는 제도입니다.
					</p>
				</div>
				<div class="link left">
					<div class="top"></div>
					<div class="bot">
						<a href="javascript:fn_MovePage('/vst/visitParking.c');">방문주차<br>소개
						</a> <a class="one"
							href="javascript:fn_MovePage('/vst/visitRequest.c');">이용신청</a>
					</div>
				</div>
			</div>
		</div>

		<div id="sectionThird">
			<div class="section">
				<div class="obj_3"></div>
				<div class="right">
					<h2>공영주차</h2>
					<p>
						동작구시설관리공단은 12개(노상 2개소, 노외 10개소)주차장을 관리운영하며<br> 관내 원활한 교통소통과
						주차질서 확립에 항상 노력하고 있습니다.
					</p>
				</div>
				<div class="link right">
					<div class="top"></div>
					<div class="bot">
						<a class="one"
							href="javascript:fn_MovePage('/pub/publicRequest.c');">이용신청</a> <a
							href="javascript:fn_MovePage('/pub/defaultChargeInfo.c');">미납요금<br>안내
						</a> <a href="javascript:fn_MovePage('/pub/parkingCondition.c');">주차장<br>현황
						</a> <a href="javascript:fn_MovePage('/pub/parkingIntro.c');">주차장<br>소개
						</a>
					</div>
				</div>
			</div>
		</div>

		<div id="sectionFourth">
			<div class="section">
				<div class="obj_4"></div>
				<div class="left">
					<h2>견인보관소</h2>
					<p>
						차량 사용자 또는 소유주께서 신분증을 소지하시고 견인차량보관소를 방문하시어<br> 견인료와 보관료를 납부하시면
						차량을 인수해 가실 수 있습니다.
					</p>
				</div>
				<div class="link left">
					<div class="top"></div>
					<div class="bot">
						<a href="javascript:fn_MovePage('/tow/towStorageInfo.c');">견인보관소<br>안내
						</a>
					</div>
				</div>
			</div>
		</div>

		<div id="footer">
			<div class="section">
				<div class="foot_left">
					<img
						src="${pageContext.request.contextPath}/resource/images/footer_img1.png" alt="중랑구 슬로건">
					<address>주소 : 서울 중랑구 신내로 15길 197 중랑구립정보도서관(묵동) 중랑구시설관리공단</address>

					<p>TEL : 02-3422-4831~4 / FAX : 02-3422-4848</p>

					<span>Copyright © 2020 All Right Reserved. Jungnang-Gu Facilities Management Corporation.</span>
				</div>
				<div class="foot_right">
					<div class="top">
						<ul>
							<li><a href="https://park.idongjak.or.kr/sup/phoneInfo.c"
								target="_blank">부서업무 / 직원안내</a></li>												
							<li><a href="http://www.idongjak.or.kr/html/etc/privacy.php"
								target="_blank">개인정보보호방침</a></li>
							<li><a href="javascript:poptastic('http://www.idongjak.or.kr/html/etc/e-mail.php');"
								target="_blank">이메일수집거부</a></li>
						</ul>
					</div>
					<div class="bot">
						<ul>
							<sec:authorize access="isAnonymous()">
								<li><a
									href="javascript:fn_MovePage('/mem/memberJoinIpin.c');">회원가입</a></li>
								<li><a href="javascript:fn_MovePage('/mem/memberIpin.c');">아이디
										/ 비밀번호 찾기</a></li>
							</sec:authorize>
							<li><a href="javascript:fn_MovePage('/sup/visitMap.c');">찾아오시는
									길</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>

		<div id="log"></div>

	</div>
</body>
</html>
