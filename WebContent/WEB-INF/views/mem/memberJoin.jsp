<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page language="java" import="Kisinfo.Check.IPINClient" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<%
    /********************************************************************************************************************************************
     NICE평가정보 Copyright(c) KOREA INFOMATION SERVICE INC. ALL RIGHTS RESERVED

     서비스명 : 가상주민번호서비스 (IPIN) 서비스
     페이지명 : 가상주민번호서비스 (IPIN) 결과 페이지
     *********************************************************************************************************************************************/

    String sSiteCode = (String) request.getAttribute("sSiteCode");
    String sSitePw = (String) request.getAttribute("sSitePw");


    // 사용자 정보 및 CP 요청번호를 암호화한 데이타입니다.
    String sResponseData = requestReplace(request.getParameter("enc_data"), "encodeData");

    // CP 요청번호 : ipin_main.jsp 에서 세션 처리한 데이타
    String sCPRequest = (String) session.getAttribute("CPREQUEST");

    String mberEmailAdres = request.getParameter("param_r1");

    // 객체 생성
    IPINClient pClient = new IPINClient();
    
    
    /*
    ┌ 복호화 함수 설명  ──────────────────────────────────────────────────────────
        Method 결과값(iRtn)에 따라, 프로세스 진행여부를 파악합니다.
        
        fnResponse 함수는 결과 데이타를 복호화 하는 함수이며,
        'sCPRequest'값을 추가로 보내시면 CP요청번호 일치여부도 확인하는 함수입니다. (세션에 넣은 sCPRequest 데이타로 검증)
        
        따라서 귀사에서 원하는 함수로 이용하시기 바랍니다.
    └────────────────────────────────────────────────────────────────────
    */
    int iRtn = pClient.fnResponse(sSiteCode, sSitePw, sResponseData);
    //int iRtn = pClient.fnResponse(sSiteCode, sSitePw, sResponseData, sCPRequest);

    String sRtnMsg = "";                           // 처리결과 메세지
    String sVNumber = pClient.getVNumber();         // 가상주민번호 (13자리이며, 숫자 또는 문자 포함)
    String sName = pClient.getName();            // 이름
    //String sDupInfo             = pClient.getDupInfo();         // 중복가입 확인값 (DI - 64 byte 고유값)
    //String sAgeCode             = pClient.getAgeCode();         // 연령대 코드 (개발 가이드 참조)
    //String sGenderCode          = pClient.getGenderCode();      // 성별 코드 (개발 가이드 참조)
    String sBirthDate = pClient.getBirthDate();       // 생년월일 (YYYYMMDD)
    //String sNationalInfo        = pClient.getNationalInfo();    // 내/외국인 정보 (개발 가이드 참조)
    //String sCPRequestNum        = pClient.getCPRequestNO();     // CP 요청번호
%>
<%
//sms인증시
if("".equals(sName)){
    sName                   = request.getParameter("sName");
}
if("".equals(sBirthDate)){
    sBirthDate          = request.getParameter("sBirthDate");
}
%>
<%!
    public String requestReplace(String paramValue, String gubun) {
        String result = "";

        if (paramValue != null) {

            paramValue = paramValue.replaceAll("<", "&lt;").replaceAll(">", "&gt;");

            paramValue = paramValue.replaceAll("\\*", "");
            paramValue = paramValue.replaceAll("\\?", "");
            paramValue = paramValue.replaceAll("\\[", "");
            paramValue = paramValue.replaceAll("\\{", "");
            paramValue = paramValue.replaceAll("\\(", "");
            paramValue = paramValue.replaceAll("\\)", "");
            paramValue = paramValue.replaceAll("\\^", "");
            paramValue = paramValue.replaceAll("\\$", "");
            paramValue = paramValue.replaceAll("'", "");
            paramValue = paramValue.replaceAll("@", "");
            paramValue = paramValue.replaceAll("%", "");
            paramValue = paramValue.replaceAll(";", "");
            paramValue = paramValue.replaceAll(":", "");
            paramValue = paramValue.replaceAll("-", "");
            paramValue = paramValue.replaceAll("#", "");
            paramValue = paramValue.replaceAll("--", "");
            paramValue = paramValue.replaceAll("-", "");
            paramValue = paramValue.replaceAll(",", "");

            if (gubun != "encodeData") {
                paramValue = paramValue.replaceAll("\\+", "");
                paramValue = paramValue.replaceAll("/", "");
                paramValue = paramValue.replaceAll("=", "");
            }

            result = paramValue;

        }
        return result;
    }
%>


<head>
<meta http-equiv="refresh" content="<%=session.getMaxInactiveInterval()%>;url=/sessionError" />
<!--     <script type="text/javascript" src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> -->
<!--     <script type="text/javascript" src="https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script> -->
    <script type="text/javascript" src="<spring:eval expression="@appConfig['daum.addr.js.path']"/>"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/com/daumPostcode.js"></script>

    <script id="jscode">

        var myValidator = new AXValidator();

        $(function () {
            myValidator.setConfig({
                targetFormName: "frm"
            });
            
            var clock = document.getElementById("clock");
            var now = new Date();
            var time = now.getFullYear() + "년 " + (now.getMonth()+1) + "월 " + now.getDate() + "일  " + now.getHours() + "시 " + now.getMinutes() + "분 " + now.getSeconds() + "초";
            clock.innerHTML = time;
        });

        $(document.body).ready(function () {

            //입력한 이메일, 아이핀인증후 이름과 생년월일을 조회해서 동일한회원이 있다면 튕겨준다
            var mberNm = '<%= sName %>';
            var mberBirth = '<%= sBirthDate %>';
            var mberEmailAdres = '<%= mberEmailAdres %>';

            $.ajax({
                url: "/mem/searchUseMember.json",
                type: "POST",
                data: {
                    mberNm: mberNm,
                    mberBirth: mberBirth,
                    mberEmailAdres: mberEmailAdres
                },
                dataType: "json",
                success: function (data, textStatus, jqXHR) {

                    if (data != "0") {
                        axf.alert("입력하신 이메일 주소와 아이핀인증 정보로 회원이 존재합니다.");
                        $('#mainMenu').submit();
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    //Error시, 처리
                }
            });

            //생년월일
            //아이핀인증시 넘겨주기때문에 입력할수없다
            /*
             $("#mberBirth").bindDate({
             align: "right", valign: "top", separator: "-", selectType: "d"
             });
             */

            // 고지주소 집주소와 동일
            $("#samAdresChk").change(function () {
                if (axf.isEmpty($("#zip").val() && $("#detailAdres").val())) {
                    axf.alert("집주소가 입력되지 않았습니다.");
                    $("#samAdresChk").attr('checked', false);
                    return;
                } else {
                    if (this.checked) {
                        $("#noticeZip").val($("#zip").val());
                        $("#noticeAdres").val($("#adres").val());
                        $("#noticeDetailAdres").val($("#detailAdres").val());
                        $("#noticeAdresNewYn").val($("#adresNewYn").val());
                    } else {
                        $("#noticeZip").val("");
                        $("#noticeAdres").val("");
                        $("#noticeDetailAdres").val("");
                        $("#noticeAdresNewYn").val("");
                    }
                }
            });

            //할인항목 조회
            searchDiscountItemList();
        });

        //할인항목 - 할인항목 조회
        function searchDiscountItemList() {

            $.ajax({
                url: "/com/searchDiscountItemList.json",
                type: "POST",
                data: {
                    discountBusiness: "02", //거주자 : 02, 공용 : 03
                    discountDivision: "01" //할인 : 01, 할증 : 02
                },
                dataType: "json",
                success: function (data, textStatus, jqXHR) {

                    var htmlSum = "";

                    for (var i = 0; i < data.list.length; i++) {

                        var html = "";

                        html = html + '<li class="selection">';
                        html = html + '<input type="checkbox" name="discountItemList" id="' + data.list[i].discountItemKey + '" value="' + data.list[i].discountItemKey + '" />';
                        html = html + '<label for="' + data.list[i].discountItemKey + '">';
                        html = html + '<span></span>';
                        html = html + data.list[i].discountName + '</label>';
                        html = html + '</li>';

                        htmlSum = htmlSum + html;
                    }

                    $("#discountItemUl").html(htmlSum);

                },
                complete: function (data) {
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    //Error시, 처리
                }
            });
        }

        //아이디중복체크
        var idCheck = 'N';
        var checkFinishId = '';

        function mberIdDuplCheck() {

            var mberId = $("#mberId").val();

            if (idCheck == 'Y') {
                axf.alert('고객ID 중복체크를 이미 완료했습니다.');
                return;
            }
            if (mberId == '') {
                axf.alert('고객ID를 입력 해 주세요.');
                return;
            }

            //고객ID 정규식 체크
            var acceptMberId = /^[A-Za-z0-9+]{6,20}$/;

            if (acceptMberId.test(mberId) == false) {

                axf.alert('고객ID는 6~20자의 영문/숫자만 입력 가능합니다.');
                $("#mberId").focus();
                return;
            }

            $.ajax({
                url: "/mem/mberIdDuplCheck.json",
                type: "POST",
                dataType: "json",
                data: {mberId: $("#mberId").val()},
                success: function (data, textStatus, jqXHR) {
                    if (data == "0") {
                        axf.alert("사용가능한 ID 입니다.");
                        idCheck = 'Y';
                        checkFinishId = mberId;
                    } else {
                        axf.alert("사용이 불가능한 ID 입니다.");
                        idCheck = 'N';
                        checkFinishId = '';
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    axf.alert("code:" + jqXHR.status + "\nmessage:" + textStatus + "\nerror:" + errorThrown);
                }
            });
        }

        var carNumCheckYN = 'N';
        var checkedCarNum = '';
        
        //차량번호 2중등록 확인
        function carNumCheck() {

        	var carNumber = $("#carNumber").val();

            $.ajax({
                url: "/mem/carNumberDupCheck.json",
                type: "POST",
                dataType: "json",
                data: {carNumber: carNumber},
                success: function (data, textStatus, jqXHR) {
                    if (data == "0") {
                        axf.alert("등록가능한 차량 입니다.");
                        carNumCheckYN = 'Y';
                        checkedCarNum = carNumber;
                    } else {
                        axf.alert("이미 등록된 차량입니다. 공단에 문의 바랍니다.");
                        carNumCheckYN = 'N';
                        checkedCarNum = '';
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    axf.alert("code:" + jqXHR.status + "\nmessage:" + textStatus + "\nerror:" + errorThrown);
                }
            });
        }

        function mberIdDuplCheckFalse() {
            idCheck = 'N';
        }

        //차량주소 집주소와 동기화
        function carAdresSync() {
            if (axf.isEmpty($("#zip").val() && $("#detailAdres").val())) {
                axf.alert("집주소가 입력되지 않았습니다.");
                return;
            } else {
                $("#carZip").val($("#zip").val());
                $("#carAdres").val($("#adres").val());
                $("#carDetailAdres").val($("#detailAdres").val());
                $("#carAdresNewYn").val($("#adresNewYn").val());
            }
        }

        //회원가입
        function saveMember() {

            var ipinChk = '<%= sName %>';
            if (ipinChk == '') {
                axf.alert("아이핀인증후 가입가능합니다.");
                return;
            }

            var validateResult = myValidator.validate();

            if (!validateResult) {
                var msg = myValidator.getErrorMessage();
                AXUtil.alert(msg);
                myValidator.getErrorElement().focus();
                return false;
            } else {

                if (idCheck != 'Y') {
                    axf.alert("사용자아이디 중복확인을 해주세요.");
                    return;
                }

                if ($("#mberId").val() != checkFinishId) {
                    axf.alert("입력한 사용자아이디와 중복확인 완료한 사용자아이디가 같지않습니다. 확인해주세요.");
                    return;
                }

                if ($("#password").val() != $("#passwordCheck").val()) {
                    axf.alert("비밀번호와 비밀번호 확인이 같지않습니다. 확인해주세요.");
                    return;
                }

                //비밀번호 정규식 체크
                var password = $("#password").val();
                var acceptPassword = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[~,!,@,#,$,*,(,),=,+,_,.,|]).*$/;

                if (acceptPassword.test(password) == false) {

                    axf.alert('비밀번호는 영문/숫자/특수문자를 포함한 8~15글자만 가능합니다.');

                    //$("#password").val("");
                    //$("#passwordCheck").val("");
                    $("#password").focus();
                    return;
                }

                var carNumber = $("#carNumber").val();
                if(carNumber == '') {
                    axf.alert("차량번호를 입력 해주세요.");
                    return;
                }
                
            	if(carNumCheckYN == 'N' || carNumber != checkedCarNum) {
                    axf.alert("차량번호 중복확인이 필요합니다.");
                    return;
            	}
                
                var mberId = $("#mberId").val();
                var password = $("#password").val();
                var mberNm = $("#mberNm").val();
                var mberBirth = $("#mberBirth").val().replace(/-/gi, '');
                var mberEmailAdres = $("#mberEmailAdres").val();
                var mberPhone = $("#mberPhone").val();
                var mbtlnum = $("#mbtlnum").val();
                var adresNewYn = $("#adresNewYn").val();
                var zip = $("#zip").val();
                var adres = $("#adres").val();
                var detailAdres = $("#detailAdres").val();
                var noticeAdresNewYn = $("#noticeAdresNewYn").val();
                var noticeZip = $("#noticeZip").val();
                var noticeAdres = $("#noticeAdres").val();
                var noticeDetailAdres = $("#noticeDetailAdres").val();
                
                var carName = $("#carName").val();
                var carAdresNewYn = $("#carAdresNewYn").val();
                var carZip = $("#carZip").val();
                var carAdres = $("#carAdres").val();
                var carDetailAdres = $("#carDetailAdres").val();
                var lentCarYn = $("#lentCarYn").val();
                var arrDiscountItemKey = [];
                $('input[name="discountItemList"]:checkbox:checked').each(function () {
                    arrDiscountItemKey.push($(this).val());
                });

                $.ajaxSettings.traditional = true;
                $.ajax({
                    url: "/mem/saveMember.json",
                    type: "POST",
                    data: {
                        mberId: mberId,
                        password: password,
                        mberNm: mberNm,
                        mberBirth: mberBirth,
                        mberEmailAdres: mberEmailAdres,
                        mberPhone: mberPhone,
                        mbtlnum: mbtlnum,
                        adresNewYn: adresNewYn,
                        zip: zip,
                        adres: adres,
                        detailAdres: detailAdres,
                        noticeAdresNewYn: noticeAdresNewYn,
                        noticeZip: noticeZip,
                        noticeAdres: noticeAdres,
                        noticeDetailAdres: noticeDetailAdres,
                        carNumber: carNumber,
                        carName: carName,
                        carAdresNewYn: carAdresNewYn,
                        carZip: carZip,
                        carAdres: carAdres,
                        carDetailAdres: carDetailAdres,
                        lentCarYn: lentCarYn,
                        arrDiscountItemKey: arrDiscountItemKey
                    },
                    dataType: "json",
                    success: function (data, textStatus, jqXHR) {
                        if (data.result == "OK") {
                            axf.alert("등록 성공했습니다. 가입하신정보로 로그인해주세요.");
                            $('#mainMenu').submit();
                        } else {
                            axf.alert("등록 실패했습니다.");
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        axf.alert("code:" + jqXHR.status + "\nmessage:" + textStatus + "\nerror:" + errorThrown);
                    }
                });
            }
        }

    </script>

    <title>회원가입</title>
</head>

<body>
<!-- <form name="user" method="post"> -->
<%--     <input type="hidden" name="enc_data" value="<%= sResponseData %>"><br> --%>
<!-- </form> -->

<div class="page mypage">
    <div class="ct_head">
    	
        <div class="head">
        	<h2>사용자 개인정보 보호를 위해 30분이내 회원가입이 완료되지 않으면 강제로 회원가입 페이지가 닫힙니다.</h2>
            <div class="title">
                
                <h1>회원가입</h1>
                
            </div>
        </div>
    </div>
    <div class="ct_body">
        <form name="mainMenu" id="mainMenu" action="${pageContext.request.contextPath}/main"></form>

        <form name="frm" id="frm">
            <div class="body full">
                <div class="caption"><!-- 전체 페이지 설명 -->
                    <p>동작구시설관리공단 주차관리시스템에 오신걸 환영합니다!</p>
                    <p>사용자의 정보를 작성한 후 [회원가입] 버튼을 눌러 신청하십시오.</p>
                    <p>* 필수 항목을 꼭 작성하셔야 회원가입이 가능합니다.</p>
                    <p style="color:red;">30분 이내에 반드시 회원가입 절차를 완료해야 합니다. 그렇지 않을경우 회원가입 페이지가 강제로 닫힙니다.</p>
                    <p>회원가입 작업 시작 시간 : <span id="clock"></span></p>
                </div>

                <div class="bd_title"><!-- 모든 컨텐츠 타이틀 공통 -->
                    <i class="axi axi-label"></i>
                    <p>사용자 정보 작성</p>
                </div>

                <div class="block" id="memberInfo"><!-- 특별한 목적 없이 어디든 사용하는 컨테이너 -->
                    <div class="line"><!-- 항목별로 나눠서 라인정렬 할 때 -->
                        <label for="mberId">사용자 아이디*</label>
                        <input type="text" name="mberId" id="mberId" title="고객ID" class="AXInput av-required"
                               maxlength="20" onclick="javascript:mberIdDuplCheckFalse();"/>
                        <a class="btn green" onclick="mberIdDuplCheck();">중복확인</a>
                    </div>
                    <div class="line">
                        <label for="password">비밀번호*</label>
                        <input type="password" name="password" id="password" title="비밀번호" maxlength="15"
                               class="AXInput av-required"/>
                        <span class="disc">비밀번호는 영문/숫자/특수문자를 포함한  8~15글자만 가능합니다.</span>
                    </div>
                    <div class="line">
                        <label for="passwordCheck">비밀번호 확인*</label>
                        <input type="password" name="passwordCheck" id="passwordCheck" title="비밀번호 확인" maxlength="15"
                               class="AXInput av-required"/>
                    </div>
                    <div class="line">
                        <label for="mberNm">이름*</label>
                        <input type="text" name="mberNm" id="mberNm" title="이름" value="<%= sName %>" maxlength="16"
                               class="AXInput av-required" readonly/>
                        <div class="axi_box">
                            <label for="mberBirth">생년월일*</label>
                            <input type="text" name="mberBirth" id="mberBirth" title="생년월일" value="<%= sBirthDate %>"
                                   class="AXInput av-required" readonly/>
                        </div>
                        <label for="mberEmailAdres">이메일*</label>
                        <input type="text" name="mberEmailAdres" id="mberEmailAdres" title="이메일"
                               value="<%= mberEmailAdres %>" maxlength="50" class="AXInput av-required av-email"/>
                    </div>
                    <div class="line">
                        <label for="mberPhone">핸드폰 번호*</label>
                        <input type="text" name="mberPhone" id="mberPhone" title="핸드폰 번호" maxlength="20"
                               class="AXInput av-required av-phone"/>
                        <label for="mbtlnum">전화번호</label>
                        <input type="text" name="mbtlnum" id="mbtlnum" title="전화번호" maxlength="20"
                               class="AXInput av-phone"/>
                    </div>
                    <div class="line">
                        <label for="">집주소*</label>
                        <a class="btn dblue"
                           onclick="execDaumPostcode_UserEdit('zip','adres','detailAdres', 'adresNewYn')">우편번호 검색</a>
                        <input type="hidden" name="adresNewYn" id="adresNewYn"/>
                        <input type="text" name="zip" id="zip" value="" class="wid100 AXInput av-required" title="우편번호"
                               readonly/>
                        <input type="text" name="adres" id="adres" value="" class="wid300 AXInput av-required"
                               title="주소" readonly/>
                        <input type="text" name="detailAdres" id="detailAdres" value=""
                               class="wid300 AXInput av-required" placeholder="상세주소"/>
                    </div>
                    <div class="line">
                        <label for="">고지주소*</label>
                        <input type="hidden" name="noticeAdresNewYn" id="noticeAdresNewYn"/>
                        <a class="btn dblue"
                           onclick="execDaumPostcode_UserEdit('noticeZip','noticeAdres','noticeDetailAdres', 'noticeAdresNewYn')">우편번호
                            검색</a>
                        <input type="text" name="noticeZip" id="noticeZip" value="" class="wid100 AXInput av-required"
                               title="고지우편번호" readonly/>
                        <input type="text" name="noticeAdres" id="noticeAdres" value=""
                               class="wid300 AXInput av-required" title="고지주소" readonly/>
                        <input type="text" name="noticeDetailAdres" id="noticeDetailAdres" value=""
                               class="wid300 AXInput av-required" placeholder="고지상세주소"/>
                        <input name="samAdresChk" id="samAdresChk" type="checkbox"/>
                        <label for="samAdresChk"><span></span>집주소 동일</label>
                    </div>
                </div>

                <div class="bd_title"><!-- 모든 컨텐츠 타이틀 공통 -->
                    <i class="axi axi-label"></i>
                    <p>차량 정보 작성(차량정보는 반드시 모두 입력해야 합니다)</p>
                </div>
                <div class="block" id="carInfo">
                    <div class="line add"><!-- 라인을 추가할 때 사용 -->
                        <input type="text" name="carNumber" id="carNumber" class="wid100 AXInput av-required"
                               maxlength="13" placeholder="차량번호"/>
                        <a class="btn green" onclick="carNumCheck();">중복확인</a>
                        <input type="text" name="carName" id="carName" class="wid100 AXInput av-required" maxlength="33"
                               placeholder="차량모델"/>

                        <a class="btn dblue"
                           onclick="execDaumPostcode_UserEdit('carZip','carAdres','carDetailAdres', 'noticeAdresNewYn')">우편번호</a>
                        <input type="hidden" name="carAdresNewYn" id="carAdresNewYn"/>
                        <input type="text" name="carZip" id="carZip" value="" class="wid100 AXInput av-required"
                               title="차량우편번호" readonly/>
                        <input type="text" name="carAdres" id="carAdres" value="" class="AXInput av-required"
                               title="차량주소" readonly/>
                        <input type="text" name="carDetailAdres" id="carDetailAdres" value=""
                               class="AXInput av-required" placeholder="차량등록 상세주소"/>
                        <a class="btn green" onclick="carAdresSync();">상동</a>

                        <input name="lentCarYn" id="lentCarYn" type="checkbox" value="Y"/>
                        <label for="lentCarYn"><span></span>임대차량</label>

                        <!-- 
	                    <a class="btn dblue add"><i class="axi axi-add"></i>차량추가</a>
	                     -->
                    </div>

                    <!-- 추가된 항목
                    <div class="line add">
                        <input id="" class="wid100" type="text" placeholder="차량번호" />
                        <input id="" class="wid100" type="text" placeholder="차량모델" />

                        <a class="btn dblue">우편번호</a>
                        <input id="" class="wid100" type="text" readonly />
                        <input id="" type="text" readonly />
                        <input id="" type="text" placeholder="차량주소" />
                        <a class="btn green">상동</a>

                        <input id="" type="checkbox" value=""/>
                        <label for=""><span></span>임대차량 체크</label>

                        <a class="btn red add"><i class="axi axi-remove"></i>차량삭제</a>
                    </div>
                     -->

                </div>

                <div class="bd_title"><!-- 모든 컨텐츠 타이틀 공통 -->
                    <i class="axi axi-label"></i>
                    <p>할인항목 선택</p>
                </div>

                <div class="block">
                    <div class="caption"><!-- 블럭 안에 캡션은 스타일 달라짐 -->
                        <p>사용자가 해당사항 있는 할인 적용 항목을 모두 선택해 주십시오. (다중선택가능하며 선택하지 않아도 회원가입은 가능합니다.)</p>
                    </div>

                    <div class="multiple_selection">
                        <ul id="discountItemUl">
                        </ul>
                    </div>
                </div>

                <div class="page_btn">
                    <a class="btn lgreen" onclick="saveMember();">회원가입</a>
                    <a class="btn" href="javascript:fn_MovePage('/main');">취소</a>
                </div>
            </div>
        </form>

    </div>
</div>
</body>
