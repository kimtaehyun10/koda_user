<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- <%@ page import="IPINClient.IPINClient"%> --%>
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
    sReturnURL = sReturnURL+request.getContextPath()+"/mem/memberIpinConfirm.c";
    
    
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
    String sReturnUrl = sSmsReturnURL + request.getContextPath()+"/mem/memberSmsConfirm.c"; // 성공시 이동될 URL
    //String sErrorUrl = "http://localhost:8080/mem/memberJoinFail.c";          // 실패시 이동될 URL
    String sErrorUrl = sSmsReturnURL + request.getContextPath()+"/mem/memberSmsConfirm.c"; // 성공시 이동될 URL
    

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
	    window.name ="Parent_window"; 
	    
	    function fnPopup(){
	        window.open('', 'popupIPIN2', 'width=450, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
	        document.form_ipin.target = "popupIPIN2";
	        document.form_ipin.action = "https://cert.vno.co.kr/ipin.cb";
	        document.form_ipin.submit();
	    }
	    
		function fnSmsPopup(){
	    	window.open('', 'popupChk', 'width=500, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
            document.form_chk.action = "https://nice.checkplus.co.kr/CheckPlusSafeModel/checkplus.cb";
            document.form_chk.target = "popupChk";
            document.form_chk.submit();
	        
	    }
		
		function smsConfirm(){
            document.smsObj.submit();
        }
    </script>
    
    <title>아이디/비밀번호 찾기 - 아이핀</title>
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

    <form id="smsObj" name="smsObj" action="/mem/memberFind.c" method="post">
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
	                <h1>아이디/비밀번호 찾기</h1>
	            </div>
	            <div class="log in">
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