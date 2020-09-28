<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="Kisinfo.Check.IPINClient" %>
<%
    /********************************************************************************************************************************************
        NICE평가정보 Copyright(c) KOREA INFOMATION SERVICE INC. ALL RIGHTS RESERVED
        
        서비스명 : 가상주민번호서비스 (IPIN) 서비스
        페이지명 : 가상주민번호서비스 (IPIN) 호출 페이지
    *********************************************************************************************************************************************/
    
    String sSiteCode                = (String)request.getAttribute("sSiteCode");
    String sSitePw                  = (String)request.getAttribute("sSitePw");
    
    
    /*
    ┌ sReturnURL 변수에 대한 설명  ─────────────────────────────────────────────────────
        NICE평가정보 팝업에서 인증받은 사용자 정보를 암호화하여 귀사로 리턴합니다.
        따라서 암호화된 결과 데이타를 리턴받으실 URL 정의해 주세요.
        
        * URL 은 http 부터 입력해 주셔야하며, 외부에서도 접속이 유효한 정보여야 합니다.
        * 당사에서 배포해드린 샘플페이지 중, ipin_process.jsp 페이지가 사용자 정보를 리턴받는 예제 페이지입니다.
        
        아래는 URL 예제이며, 귀사의 서비스 도메인과 서버에 업로드 된 샘플페이지 위치에 따라 경로를 설정하시기 바랍니다.
        예 - http://www.test.co.kr/ipin_process.jsp, https://www.test.co.kr/ipin_process.jsp, https://test.co.kr/ipin_process.jsp
    └────────────────────────────────────────────────────────────────────
    */
    
    String sReturnURL               = (String)request.getAttribute("sReturnURL");
    sReturnURL = sReturnURL+request.getContextPath()+"/mem/memberJoinIpinConfirm.c";
    
    
    /*
    ┌ sCPRequest 변수에 대한 설명  ─────────────────────────────────────────────────────
        [CP 요청번호]로 귀사에서 데이타를 임의로 정의하거나, 당사에서 배포된 모듈로 데이타를 생성할 수 있습니다.
        
        CP 요청번호는 인증 완료 후, 암호화된 결과 데이타에 함께 제공되며
        데이타 위변조 방지 및 특정 사용자가 요청한 것임을 확인하기 위한 목적으로 이용하실 수 있습니다.
        
        따라서 귀사의 프로세스에 응용하여 이용할 수 있는 데이타이기에, 필수값은 아닙니다.
    └────────────────────────────────────────────────────────────────────
    */
    String sCPRequest               = "";
    
    
    
    // 객체 생성
    IPINClient pClient = new IPINClient();
    
    
    // 앞서 설명드린 바와같이, CP 요청번호는 배포된 모듈을 통해 아래와 같이 생성할 수 있습니다.
    sCPRequest = pClient.getRequestNO(sSiteCode);
    
    // CP 요청번호를 세션에 저장합니다.
    // 현재 예제로 저장한 세션은 ipin_result.jsp 페이지에서 데이타 위변조 방지를 위해 확인하기 위함입니다.
    // 필수사항은 아니며, 보안을 위한 권고사항입니다.
    session.setAttribute("CPREQUEST" , sCPRequest);
    
    
    // Method 결과값(iRtn)에 따라, 프로세스 진행여부를 파악합니다.
    int iRtn = pClient.fnRequest(sSiteCode, sSitePw, sCPRequest, sReturnURL);
    
    String sRtnMsg                  = "";           // 처리결과 메세지
    String sEncData                 = "";           // 암호화 된 데이타
    
    // Method 결과값에 따른 처리사항
    if (iRtn == 0)
    {
    
        // fnRequest 함수 처리시 업체정보를 암호화한 데이터를 추출합니다.
        // 추출된 암호화된 데이타는 당사 팝업 요청시, 함께 보내주셔야 합니다.
        sEncData = pClient.getCipherData();     //암호화 된 데이타
        
        sRtnMsg = "정상 처리되었습니다.";
    
    }
    else if (iRtn == -1 || iRtn == -2)
    {
        sRtnMsg =   "배포해 드린 서비스 모듈 중, 귀사 서버환경에 맞는 모듈을 이용해 주시기 바랍니다.<BR>" +
                    "귀사 서버환경에 맞는 모듈이 없다면 ..<BR><B>iRtn 값, 서버 환경정보를 정확히 확인하여 메일로 요청해 주시기 바랍니다.</B>";
    }
    else if (iRtn == -9)
    {
        sRtnMsg = "입력값 오류 : fnRequest 함수 처리시, 필요한 4개의 파라미터값의 정보를 정확하게 입력해 주시기 바랍니다.";
    }
    else
    {
        sRtnMsg = "iRtn 값 확인 후, NICE평가정보 개발 담당자에게 문의해 주세요.";
    }
%>
<%
    NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();

    String sSmsReturnURL               = (String)request.getAttribute("sSmsReturnURL");

	String sSmsSiteCode = (String)request.getAttribute("sSmsSiteCode");
	String sSmsSitePassword = (String)request.getAttribute("sSmsSitePassword");
    
    String sRequestNumber = (String)request.getAttribute("sRequestNumber"); // 요청 번호, 이는 성공/실패후에 같은 값으로 되돌려주게 되므로 
                                                        // 업체에서 적절하게 변경하여 쓰거나, 아래와 같이 생성한다.
    sRequestNumber = niceCheck.getRequestNO(sSmsSiteCode);
    session.setAttribute("REQ_SEQ" , sRequestNumber);   // 해킹등의 방지를 위하여 세션을 쓴다면, 세션에 요청번호를 넣는다.
    
    String sAuthType = "";          // 없으면 기본 선택화면, M: 핸드폰, C: 신용카드, X: 공인인증서
    
    String popgubun     = "Y";      //Y : 취소버튼 있음 / N : 취소버튼 없음
    String customize    = "";           //없으면 기본 웹페이지 / Mobile : 모바일페이지
        
    // CheckPlus(본인인증) 처리 후, 결과 데이타를 리턴 받기위해 다음예제와 같이 http부터 입력합니다.
    //String sReturnUrl = "http://localhost:8080/mem/memberJoin.c";      // 성공시 이동될 URL
    String sReturnUrl = sSmsReturnURL + request.getContextPath()+"/mem/memberJoinSmsConfirm.c"; // 성공시 이동될 URL
    //String sErrorUrl = "http://localhost:8080/mem/memberJoinFail.c";          // 실패시 이동될 URL
    String sErrorUrl = sSmsReturnURL + request.getContextPath()+"/mem/memberJoinSmsConfirm.c"; // 성공시 이동될 URL
    

    // 입력될 plain 데이타를 만든다.
    String sPlainData = "7:REQ_SEQ" + sRequestNumber.getBytes().length + ":" + sRequestNumber +
                        "8:SITECODE" + sSmsSiteCode.getBytes().length + ":" + sSmsSiteCode +
                        "9:AUTH_TYPE" + sAuthType.getBytes().length + ":" + sAuthType +
                        "7:RTN_URL" + sReturnUrl.getBytes().length + ":" + sReturnUrl +
                        "7:ERR_URL" + sErrorUrl.getBytes().length + ":" + sErrorUrl +
                        "11:POPUP_GUBUN" + popgubun.getBytes().length + ":" + popgubun +
                        "9:CUSTOMIZE" + customize.getBytes().length + ":" + customize;
    
    String sMessage = "";
    String sSmsEncData = "";
    
    int iReturn = niceCheck.fnEncode(sSmsSiteCode, sSmsSitePassword, sPlainData);
    if( iReturn == 0 )
    {
    	sSmsEncData = niceCheck.getCipherData();
    }
    else if( iReturn == -1)
    {
    	sSmsEncData = "암호화 시스템 에러입니다.";
    }    
    else if( iReturn == -2)
    {
    	sSmsEncData = "암호화 처리오류입니다.";
    }    
    else if( iReturn == -3)
    {
    	sSmsEncData = "암호화 데이터 오류입니다.";
    }    
    else if( iReturn == -9)
    {
    	sSmsEncData = "입력 데이터 오류입니다.";
    }    
    else
    {
    	sSmsEncData = "알수 없는 에러 입니다. iReturn : " + iReturn;
    }
%>

<head>
    <script id="jscode">
    
	    var myValidator = new AXValidator();
	    
	    $(function(){
	        myValidator.setConfig({
	            targetFormName : "frm"
	        });
	    });
	    
	    window.name ="Parent_window"; 
	    
	    function fnPopup(){
	    	
	    	var agree01 = $('#agree01').attr('checked');
	    	if (agree01 != 'checked') {
	    		AXUtil.alert('회원가입약관에 동의해야 합니다.');
	    		$('#agree01').focus();
	    		return;
	    	}

	    	var agree02 = $('#agree02').attr('checked');
	    	if (agree02 != 'checked') {
	    		AXUtil.alert('개인정보 수집 이용내역에 동의해야 합니다.');
	    		$('#agree02').focus();
	    		return;
	    	}
	    	
	    	var agree03 = $('#agree03').attr('checked');
	    	if (agree03 != 'checked') {
	    		AXUtil.alert('최종 확인을 위해 전체 약관에도 동의해야 합니다.');
	    		$('#agree03').focus();
	    		return;
	    	}
	    	
	    	var validateResult = myValidator.validate();

            if(!validateResult) {
                var msg = myValidator.getErrorMessage();
                AXUtil.alert(msg);
                myValidator.getErrorElement().focus();
                return false;
            }else{
            	
            	//var param_r1 = $('#mberEmailAdres').val();
            	//$('input[name=param_r1]').attr('value', param_r1);
            	//document.form_ipin.param_r1.value = param_r1;
            	
            	window.open('', 'popupIPIN2', 'width=450, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
                document.form_ipin.target = "popupIPIN2";
                document.form_ipin.action = "https://cert.vno.co.kr/ipin.cb";
                document.form_ipin.submit();
            }
	    }
	    
	    function fnSmsPopup(){
	    	
	    	var agree01 = $('#agree01').attr('checked');
	    	if (agree01 != 'checked') {
	    		AXUtil.alert('회원가입약관에 동의해야 합니다.');
	    		$('#agree01').focus();
	    		return;
	    	}

	    	var agree02 = $('#agree02').attr('checked');
	    	if (agree02 != 'checked') {
	    		AXUtil.alert('개인정보 수집 이용내역에 동의해야 합니다.');
	    		$('#agree02').focus();
	    		return;
	    	}
	    	
	    	var agree03 = $('#agree03').attr('checked');
	    	if (agree03 != 'checked') {
	    		AXUtil.alert('최종 확인을 위해 전체 약관에도 동의해야 합니다.');
	    		$('#agree03').focus();
	    		return;
	    	}
	    	
	    	var validateResult = myValidator.validate();

            if(!validateResult) {
                var msg = myValidator.getErrorMessage();
                AXUtil.alert(msg);
                myValidator.getErrorElement().focus();
                return false;
            }else{
            	
            	//var param_r1 = $('#mberEmailAdres').val();
                //$('input[name=param_r1]').attr('value', param_r1);
                //document.form_chk.param_r1.value = param_r1;
                
            	window.open('', 'popupChk', 'width=500, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
                document.form_chk.action = "https://nice.checkplus.co.kr/CheckPlusSafeModel/checkplus.cb";
                document.form_chk.target = "popupChk";
                document.form_chk.submit();
            }
	        
	    }

	    function smsConfirm(){
            document.smsObj.submit();
        }

    </script>
    
    <title>서비스 이용조건</title>
</head>

<body>
    <form name="form_ipin" method="post">
	    <input type="hidden" name="m" value="pubmain">                      <!-- 필수 데이타로, 누락하시면 안됩니다. -->
	    <input type="hidden" name="enc_data" value="<%= sEncData %>">       <!-- 위에서 업체정보를 암호화 한 데이타입니다. -->
	    
	    <!-- 업체에서 응답받기 원하는 데이타를 설정하기 위해 사용할 수 있으며, 인증결과 응답시 해당 값을 그대로 송신합니다.
	         해당 파라미터는 추가하실 수 없습니다. -->
	    <input type="hidden" name="param_r1" value="">
	    <input type="hidden" name="param_r2" value="">
	    <input type="hidden" name="param_r3" value="">
	</form>
	
	<form name="vnoform" method="post">
	    <input type="hidden" name="enc_data">                               <!-- 인증받은 사용자 정보 암호화 데이타입니다. -->
	    
	    <!-- 업체에서 응답받기 원하는 데이타를 설정하기 위해 사용할 수 있으며, 인증결과 응답시 해당 값을 그대로 송신합니다.
	         해당 파라미터는 추가하실 수 없습니다. -->
	    <input type="hidden" name="param_r1" value="">
	    <input type="hidden" name="param_r2" value="">
	    <input type="hidden" name="param_r3" value="">
	</form>
	
	<form name="form_chk" method="post">
        <input type="hidden" name="m" value="checkplusSerivce">                     <!-- 필수 데이타로, 누락하시면 안됩니다. -->
        <input type="hidden" name="EncodeData" value="<%= sSmsEncData %>">     <!-- 위에서 업체정보를 암호화 한 데이타입니다. -->
        
        <!-- 업체에서 응답받기 원하는 데이타를 설정하기 위해 사용할 수 있으며, 인증결과 응답시 해당 값을 그대로 송신합니다.
             해당 파라미터는 추가하실 수 없습니다. -->
        <input type="hidden" name="param_r1" value="">
        <input type="hidden" name="param_r2" value="">
        <input type="hidden" name="param_r3" value="">
    </form>

    <form id="smsObj" name="smsObj" action="/mem/memberJoin.c" method="post">
        <input type="hidden" name="sDupInfo" value="">
        <input type="hidden" name="sName" value="">
        <input type="hidden" name="sGender" value="">
        <input type="hidden" name="age" value="">
        <input type="hidden" name="sBirthDate" value="">
        <input type="hidden" name="sNationalInfo" value="">
        <input type="hidden" name="sConnInfo" value="">
        <input type="hidden" name="virtualNo" value="">
        <input type="hidden" name="sMobileNo" value="">
        <input type="hidden" name="param_r1" value="">
    </form>

    <div class="page mypage">
	    <div class="ct_head">
	        <div class="head">
	            <div class="title">
	                <h1>서비스 이용조건 동의</h1>
	            </div>
	        </div>
	    </div>
	    <div class="ct_body">

	        <div class="body full">
	            <div class="caption"><!-- 전체 페이지 설명 -->
	                <p>최초 회원가입 시 실명인증과, 공공아이핀 인증을 통하여 회원가입이 이루어지고 있으나, 공공아이핀 인증으로 최초 가입한 아이디는 아이디 찾기 시</p>
					<p>실명인증(한국신용정보)을 통하여 인증값을 찾지 못하여 아이디 찾기시 오류 문제가 있습니다.</p>
	                <p>오류 문제일 시 인증 절차를 다시 하여 주시기 바랍니다.</p>
	                <p>같은 오류 문제가 발생 시 02-832-2445로 연락 바랍니다.</p>
	            </div>
	            
	            <form name="frm" id="frm">

                <div class="bd_title"><!-- 모든 컨텐츠 타이틀 공통 -->
                    <i class="axi axi-label"></i>
                    <p>회원 가입 약관</p>
                </div>

	            <div class="block">
	                <div class="line">
		            <textarea class="caption" style="height: 132px; width: 100%;">
    ::::::::: 제 1 장 총 칙 :::::::::
 제1 조 (목 적) 

    이 약관은 동작구시설관리공단(이하 "공단"라 합니다)이 홈페이지가 제공하는 통합회원 서비스(이하 "서비스"라 합니다)와 각종 서비스의 이용조건 및 절차 등에 관한 사항을 규정함을 목적으로 합니다. 

 제 2 조 (약관의 효력과 변경)

    1. 동작구시설관리공단 홈페이지는 귀하가 본 약관 내용에 동의하는 경우, 동작구시설관리공단 홈페이지의 서비스 제공 행위 및 귀하의 서비스 사용 행위에 본 약관이 우선적으로 적용됩니다.
    2. 동작구시설관리공단 홈페이지는 본 약관을 사전 고지 없이 변경할 수 있으며, 변경된 약관은 동작구시설관리공단 홈페이지 내에 공지하며, 공지와 동시에 그 효력이 발생됩니다.
    3. 회원이 변경된 약관에 동의하지 않는 경우, 본인의 회원등록을 취소(회원탈퇴)할 수 있으며 계속 사용의 경우는 약관 변경에 대한 동의로 간주됩니다.
    4. 본 약관에 명시되지 않은 사항은 전기통신기본법, 전기통신사업법, 정보통신윤리위원회 심의규정, 정보통신 윤리강령, 프로그램보호법 및 기타 관련 법령의 규정에 의합니다.


  제 3 조 (용어의 정의)

    본 약관에서 사용하는 용어의 정의는 다음과 같습니다.
    1. 이용자 : 본 약관에 따라 동작구시설관리공단 홈페이지가 제공하는 서비스를 받는 자.
    2. 가입 : 동작구시설관리공단 홈페이지가 제공하는 신청서 양식에 해당 정보를 기입하고, 본 약관에 동의하여 서비스 이용계약을 완료시키는 행위
    3. 회원 : 동작구시설관리공단 홈페이지에 개인 정보를 제공하여 회원 등록을 한 자로서 동작구시설관리공단 홈페이지가 제공하는 서비스를 이용할 수 있는 자
    4. 아이디 : 이용고객의 식별과 이용자가 서비스 이용을 위하여 이용자가 선정하고 당 사이트가 부여하는 문자와 숫자의 조합
    5. 비밀번호 : 이용자와 회원ID가 일치하는지를 확인하고 통신상의 자신의 비밀보호를 위하여 이용자 자신이 선정한 문자와 숫자의 조합
    6. 탈퇴 : 회원이 이용계약을 종료시키는 행위


    :::::::::제 2 장 서비스 제공 및 이용:::::::::

    제 4 조 (이용계약의 성립 및 탈퇴)

    1. 이용계약은 신청자가 온라인으로 동작구시설관리공단 차홈페이지에서 제공하는 소정의 가입신청 양식에서 요구하는 사항을 기록하여 가입을 완료하는 것으로 성립됩니다.
    2. 동작구시설관리공단 홈페이지는 다음 각 호에 해당하는 이용계약에 대하여는 가입을 취소할 수 있습니다.
    1) 다른 사람의 명의를 도용하여 신청하였을 때 
    2) 이용계약 신청서의 내용을 허위로 기재하였거나 신청하였을 때 
    3) 다른 사람의 동작구시설관리공단 홈페이지 서비스 이용을 방해하거나 그 정보를 도용하는 등의 행위를 하였을 때 
    4) 동작구시설관리공단 홈페이지를 이용하여 법령과 본 약관이 금지하는 행위를 하는 경우 
    5) 기타 동작구시설관리공단 홈페이지가 정한 이용신청요건이 미비 되었을 때 


    제 5 조 (회원정보 사용에 대한 동의)

    1. 회원의 개인정보는 공공기관의 개인정보보호에 관한 법률에 의해 보호됩니다.
    2. 동작구시설관리공단 홈페이지의 회원 정보는 다음과 같이 사용, 관리, 보호됩니다.
	    1) 개인정보의 사용 : 동작구시설관리공단 홈페이지는 서비스 제공과 관련해서 수집된 회원의 신상정보를 본인의 승낙 없이 제3자에게 누설, 배포하지 않습니다.
	    	단, 전기통신기본법 등 법률의 규정에 의해 국가기관의 요구가 있는 경우, 범죄에 대한 수사상의 목적이 있거나 정보통신윤리위원회의 요청이 있는 경우 또는 기타 관계법령에서 정한 절차에 따른 요청이 있는 경우, 귀하가 동작구시설관리공단 홈페이지에 제공한 개인정보를 스스로 공개한 경우에는 그러하지 않습니다.
	    2) 개인정보의 관리 : 귀하는 개인정보의 보호 및 관리를 위하여 서비스의 개인정보관리에서 수시로 귀하의 개인정보를 수정/삭제할 수 있습니다.
	    3) 개인정보의 보호 : 귀하의 개인정보는 오직 귀하만이 열람/수정/삭제 할 수 있으며, 이는 전적으로 귀하의 ID와 비밀번호에 의해 관리되고 있습니다. 따라서 타인에게 본인의 ID와 비밀번호를 알려주어서는 안 되며, 작업 종료 시에는 반드시 로그아웃 해주시기 바랍니다.
    3. 회원이 본 약관에 따라 이용신청을 하는 것은, 동작구시설관리공단 홈페이지가 신청서에 기재된 회원정보를 수집, 이용하는 것에 동의하는 것으로 간주됩니다.


    제 6 조 (사용자의 정보 보안)

    1. 가입 신청자가 동작구시설관리공단 홈페이지 서비스 가입 절차를 완료하는 순간부터 귀하는 입력한 정보의 비밀을 유지할 책임이 있으며, 회원의 ID와 비밀번호를 사용하여 발생하는 모든 결과에 대한 책임은 회원 본인에게 있습니다.
    2. ID와 비밀번호에 관한 모든 관리의 책임은 회원에게 있으며, 회원의 ID나 비밀번호가 부정하게 사용되었다는 사실을 발견한 경우에는 즉시 동작구시설관리공단 홈페이지에 신고하여야 합니다. 신고를 하지 않음으로 인한 모든 책임은 회원 본인에게 있습니다.
    3. 이용자는 동작구시설관리공단 홈페이지 서비스의 사용 종료 시마다 정확히 접속을 종료해야 하며, 정확히 종료하지 아니함으로써 제3자가 귀하에 관한 정보를 이용하게 되는 등의 결과로 인해 발생하는 손해 및 손실에 대하여 동작구시설관리공단 홈페이지는 책임을 부담하지 아니합니다.


    제 7 조 (서비스의 중지)

    1. 동작구시설관리공단 홈페이지는 이용자가 본 약관의 내용에 위배되는 행동을 한 경우, 임의로 서비스 사용을 제한 및 중지할 수 있습니다.
    2. 동작구시설관리공단 홈페이지가 통제할 수 없는 사유로 인한 서비스중단의 경우(시스템관리자의 고의, 과실 없는 디스크장애, 시스템다운 등)에 사전통지가 불가능하며 타인(통신회사, 기간통신사업자 등)의 고의, 과실로 인한 시스템중단 등의 경우에는 통지하지 않습니다.
    3. 긴급한 시스템 점검, 증설 및 교체 등 부득이한 사유로 인하여 예고 없이 일시적으로 서비스를 중단할 수 있으며, 새로운 서비스로의 교체 등 당 사이트가 적절하다고 판단하는 사유에 의하여 현재 제공되는 서비스를 완전히 중단할 수 있습니다.
    4. 국가비상사태, 정전, 서비스 설비의 장애 또는 서비스 이용의 폭주 등으로 정상적인 서비스 제공이 불가능할 경우, 서비스의 전부 또는 일부를 제한하거나 중지할 수 있습니다. 다만 이 경우 그 사유 및 기간 등을 이용자에게 사전 또는 사후에 공지합니다.


    제 8 조 (서비스의 변경 및 해지)

    1. 동작구시설관리공단 홈페이지는 귀하가 서비스를 이용하여 기대하는 손익이나 서비스를 통하여 얻은 자료로 인한 손해에 관하여 책임을 지지 않으며, 회원이 본 서비스에 게재한 정보, 자료, 사실의 신뢰도, 정확성 등 내용에 관하여는 책임을 지지 않습니다.
    2. 동작구시설관리공단 홈페이지는 서비스 이용과 관련하여 가입자에게 발생한 손해 중 가입자의 고의, 과실에 의한 손해에 대하여 책임을 부담하지 아니합니다.


    제 9 조 (정보 제공 및 광고 게재)

    1. 공단은 서비스를 운영함에 있어 필요하다고 인정되는 다양한 정보 및 광고를 전자우편이나 서신우편, SMS(문자 서비스) 등으로 귀하에게 제공할 수 있습니다. 
    2. 공단은 서비스에 적절하다고 판단되거나 공익성이 있는 홍보물을 게재할 수 있습니다.


    제 10 조 (게시물의 저작권)

    1. 귀하가 게시한 게시물의 내용에 대한 권리는 귀하에게 있습니다.
    2. 동작구시설관리공단 홈페이지는 게시된 내용을 사전 통지 없이 편집, 이동할 수 있는 권리를 보유하며, 게시판운영원칙에 따라 사전 통지 없이 삭제할 수 있습니다.
    3. 귀하의 게시물이 타인의 저작권을 침해함으로써 발생하는 민, 형사상의 책임은 전적으로 귀하가 부담하여야 합니다.


    :::::::::제 3 장 의무 및 책임:::::::::

    제 11 조 (동작구시설관리공단 의무)

    1. 동작구시설관리공단 홈페이지는 회원의 개인 신상 정보를 본인의 승낙 없이 타인에게 누설, 배포하지 않습니다.
     	다만, 전기통신관련법령 등 관계법령에 의하여 관계 국가기관 등의 요구가 있는 경우에는 그러하지 아니합니다.


    제 12 조 (회원의 의무)

    1. 회원은 당 사이트의 사전 승낙 없이 서비스를 이용하여 어떠한 영리행위도 할 수 없습니다.
    2. 회원 가입 시에 요구되는 정보는 정확하게 기입하여야 합니다. 또한 이미 제공된 귀하에 대한 정보가 정확한 정보가 되도록 유지, 갱신하여야 하며, 회원은 자신의 ID 및 비밀번호를 제3자가 이용하게 해서는 안 됩니다.
    3. 회원은 당 사이트 서비스 이용과 관련하여 다음 각 호의 행위를 하여서는 안 됩니다. 
     1) 다른 회원의 비밀번호와 ID를 도용하여 부정 사용하는 행위
     2) 저속, 음란, 모욕적, 위협적이거나 타인의 사생활를 침해할 수 있는 내용을 전송, 게시, 게재, 전자우편 또는 기타의 방법으로 전송하는 행위
     3) 서비스를 통하여 전송된 내용의 출처를 위장하는 행위
     4) 법률, 계약에 의해 이용할 수 없는 내용을 게시, 게재, 전자우편 또는 기타의 방법으로 전송하는 행위
     5) 타인의 특허, 상표, 영업비밀, 저작권, 기타 지적재산권을 침해하는 내용을 게시, 게재, 전자우편 또는 기타의 방법으로 전송하는 행위
     6) 당 사이트의 승인을 받지 아니한 광고, 판촉물, 스팸메일, 행운의 편지, 피라미드 조직 기타 다른 형태의 권유를 게시, 게재, 전자우편 또는 기타의 방법으로 전송하는 행위
     7) 다른 사용자의 개인정보를 수립 또는 저장하는 행위
     8) 범죄행위를 목적으로 하거나 기타 범죄행위와 관련된 행위
     9) 선량한 풍속, 기타 사회질서를 해하는 행위
    10) 타인의 명예를 훼손하거나 모욕하는 행위
    11) 타인의 지적재산권 등의 권리를 침해하는 행위
    12) 해킹행위 또는 컴퓨터바이러스의 유포행위
    13) 타인의 의사에 반하여 광고성 정보 등 일정한 내용을 지속적으로 전송하는 행위
    14) 서비스의 안전적인 운영에 지장을 주거나 줄 우려가 있는 일체의 행위
    15) 당 사이트에 게시된 정보의 변경
    16) 기타 전기통신사업법 제53조 제1항과 전기통신사업법 시행령 16조(불온통신)에 위배되는 행위

    :::::::::제 4 장 기타:::::::::

    제 13 조 (양도금지)

    1. 회원이 서비스의 이용권한, 기타 이용계약 상 지위를 타인에게 양도, 증여할 수 없습니다. 


    제 14 조 (손해배상)

    1. 동작구시설관리공단 홈페이지는 무료로 제공되는 서비스와 관련하여 회원에게 어떠한 손해가 발생하더라도 동작구시설관리공단 홈페이지가 고의로 행한 범죄행위를 제외하고 이에 대하여 책임을 부담하지 아니합니다. 


    제 15 조 (면책조항)

    1. 동작구시설관리공단 홈페이지는 천재지변, 전쟁 및 기타 이에 준하는 불가항력으로 인하여 서비스를 제공할 수 없는 경우에는 서비스 제공에 대한 책임이 면제됩니다.
    2. 동작구시설관리공단 홈페이지는 서비스용 설비의 보수, 교체, 정기점검, 공사 등 부득이한 사유로 발생한 손해에 대한 책임이 면제됩니다.
    3. 동작구시설관리공단 홈페이지는 이용자의 컴퓨터 오류에 의해 손해가 발생한 경우, 또는 회원이 신상정보 및 전자우편 주소를 부실하게 기재하여 손해가 발생한 경우 책임을 지지 않습니다.
    4. 동작구시설관리공단 홈페이지는 회원이나 제3자에 의해 표출된 의견을 승인하거나 반대하거나 수정하지 않습니다. 동작구시설관리공단 홈페이지는 어떠한 경우라도 회원이 서비스에 담긴 정보에 의존해 얻은 이득이나 입은 손해에 대해 책임이 없습니다. 
    5. 동작구시설관리공단 홈페이지는 회원 간 또는 회원과 제3자간에 서비스를 매개로 하여 물품거래 혹은 금전적 거래 등과 관련하여  어떠한 책임도 부담하지 아니하고, 회원이 서비스의 이용과 관련하여 기대하는 이익에 관하여 책임을 부담하지 않습니다. 
    6. 동작구시설관리공단 홈페이지는 서비스 이용과 관련하여 귀하에게 발생한 손해 중 귀하의 고의, 과실에 의한 손해에 대하여 책임을 부담하지 아니합니다. 


    제 16 조 (재판관할)

    1. 동작구시설관리공단 홈페이지와 이용자 간에 발생한 서비스 이용에 관한 분쟁에 대하여는 대한민국 법을 적용하며, 본 분쟁으로 인한 소는 대한민국의 법원에 제기합니다.


    부 칙 1. (시행일) 본 약관은 2009년 8월 17일부터 시행됩니다.	
                </textarea>
				   <input name="agree01" id="agree01" type="checkbox" value="N"/>
	               <label for="agree01" style="color:black;"><span></span>회원 가입 약관에 동의합니다.</label>
		         </div>
		      </div>
		            
                <div class="bd_title"><!-- 모든 컨텐츠 타이틀 공통 -->
                    <i class="axi axi-label"></i>
                    <p>주차장시설 이용을 위한 개인정보 수집 이용 동의서</p>
                </div>

	            <div class="block">
	                <div class="line">
		            <textarea class="caption" style="height: 132px; width: 100%;">
개인정보 수집 이용 내역(필수항목)

1. 수집항목
  가. 필수항목 : 성명, 주소, 휴대전화, 차량번호, 이메일 주소
  나. 선택항목 : 518민주유공자, 거주자, 경차, 고엽제자동차, 국가유공상이자, 다둥이(두자녀), 다둥이(세자녀이상), 모범납세자, 상근자, 영업용차량, 요일제, 의사상자 및 가족, 장애인, 저공해
  
2. 이용목적
  가. 주차시설 이용
  나. 이용자 확인 및 감면대상 확인, 서비스 만족도 조사

3. 보유 및 이용기간
  가. 보유 및 이용기간 : 정보주체 요청시까지
  나. 회원퇄퇴 시 :
    - 결제정보 없을 시 즉시 파기
    - 주차시설 이용료 결제 및 서비스 등의 공급에 관한 기록 : 5년
    - 소비자 불만 및 분쟁처리에 관한 기록 : 3년
    
4. 개인정보 수집 근거 : 개인정보 보호법 제15조 1항 (정보주체의 동의)

위의 개인정보 수집 이용에 대한 동의를 거부할 권리가 있습니다. 그러나 동의를 거부할 경우 회원 가입 및 주차시설 이용이 제한됩니다. 

    		            </textarea>
  				    <input name="agree02" id="agree02" type="checkbox" value="Y"/>
	                <label for="agree02" style="color:black;"><span></span>위 개인정보의 수집 및 이용내역에 동의합니다.</label>
		        </div>
			
	           <div class="bd_title"><!-- 모든 컨텐츠 타이틀 공통 -->
	           	<p>귀하는 위 항목에 대하여 동의를 거부할 수 있으며, 동의 후에도 언제든지 철회 가능합니다.</p>
	           	<input name="agree03" id="agree03" type="checkbox" value="Y"/>
    			<label for="agree03" style="color:black;"><span></span>위의 전체 약관에 동의합니다.</label>
                </div>
	



	            </form>
	            
	            <div class="page_btn" style="margin-top: 100px;">
	                <a class="btn blue" href="javascript:fnPopup();">아이핀 인증</a>
	                <a class="btn green" href="javascript:fnSmsPopup();">SMS 인증</a>
					<!-- 취소 시 메인페이지로 이동합니다. -->
	                <a class="btn" href="javascript:fn_MovePage('/main');">취소</a>
	            </div>
	        </div>
	        
	    </div>
	</div>
</body>