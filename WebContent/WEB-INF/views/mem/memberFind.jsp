<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="Kisinfo.Check.IPINClient" %>
<%
    /********************************************************************************************************************************************
        NICE평가정보 Copyright(c) KOREA INFOMATION SERVICE INC. ALL RIGHTS RESERVED
        
        서비스명 : 가상주민번호서비스 (IPIN) 서비스
        페이지명 : 가상주민번호서비스 (IPIN) 결과 페이지
    *********************************************************************************************************************************************/
    
    String sSiteCode                = (String)request.getAttribute("sSiteCode");
    String sSitePw                  = (String)request.getAttribute("sSitePw");
    
        
        // 사용자 정보 및 CP 요청번호를 암호화한 데이타입니다.
    String sResponseData = requestReplace(request.getParameter("enc_data"), "encodeData");
    
    // CP 요청번호 : ipin_main.jsp 에서 세션 처리한 데이타
    String sCPRequest = (String)session.getAttribute("CPREQUEST");

    
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
    
    String sRtnMsg              = "";                           // 처리결과 메세지
    String sVNumber             = pClient.getVNumber();         // 가상주민번호 (13자리이며, 숫자 또는 문자 포함)
    String sName                = pClient.getName();            // 이름
    //String sDupInfo             = pClient.getDupInfo();         // 중복가입 확인값 (DI - 64 byte 고유값)
    //String sAgeCode             = pClient.getAgeCode();         // 연령대 코드 (개발 가이드 참조)
    //String sGenderCode          = pClient.getGenderCode();      // 성별 코드 (개발 가이드 참조)
    String sBirthDate           = pClient.getBirthDate();       // 생년월일 (YYYYMMDD)
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
public String requestReplace (String paramValue, String gubun) {
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
            
            if(gubun != "encodeData"){
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
	<script id="jscode">
	
	    var myValidator = new AXValidator();
	    
	    $(function(){
            myValidator.setConfig({
                targetFormName : "frm"
            });
        });
	
		//아이디 찾기
	    function findMemberId() {
			
           	var mberNm = '<%= sName %>';
            var mberBirth = '<%= sBirthDate %>';
            var mberEmailAdres = $('#mberEmailAdres').val();
            
            if(mberNm == '' || mberBirth == ''){
                axf.alert("아이핀인증후 찾을수 있습니다.");
                return;
            }
            
            var validateResult = myValidator.validate();

            if(!validateResult) {
                var msg = myValidator.getErrorMessage();
                AXUtil.alert(msg);
                myValidator.getErrorElement().focus();
                return false;
            }else{
            	
                $.ajax({
                    url : "/mem/findMemberId.json",
                    type: "POST",
                    data: {
                        mberNm : mberNm,
                        mberBirth : mberBirth,
                        mberEmailAdres : mberEmailAdres
                    },
                    dataType:"json",
                    success : function(data, textStatus, jqXHR) {
                    	
                    	if(data == null){
                        	alert('입력하신정보와 아이핀인증정보로 가입되어있는 회원이 없습니다.');
                        }else{
                        	//아이디를 찾을 경우
                            $('#findId').css('display', 'block');
                            $('#findPassword').css('display', 'none');
                            $('#mberId').text(data.mberId);
                        }
                    },
                    error : function(jqXHR, textStatus, errorThrown){
                        axf.alert("code:"+jqXHR.status+"\nmessage:"+textStatus+"\nerror:"+errorThrown);
                    }
                });
            }
	    }

	    //아이디 찾기
        function findPassword() {
	    	
        	var mberNm = '<%= sName %>';
            var mberBirth = '<%= sBirthDate %>';
            var mberEmailAdres = $('#mberEmailAdres').val();
            
            if(mberNm == '' || mberBirth == ''){
                axf.alert("아이핀인증후 찾을수 있습니다.");
                return;
            }
            
            var validateResult = myValidator.validate();

            if(!validateResult) {
                var msg = myValidator.getErrorMessage();
                AXUtil.alert(msg);
                myValidator.getErrorElement().focus();
                return false;
            }else{
            	
            	$.ajax({
                    url : "/mem/findPassword.json",
                    type: "POST",
                    data: {
                        mberNm : mberNm,
                        mberBirth : mberBirth,
                        mberEmailAdres : mberEmailAdres
                    },
                    dataType:"json",
                    success : function(data, textStatus, jqXHR) {
                    	
                    	if(data.password == null){
                            alert('입력하신정보와 아이핀인증정보로 가입되어있는 회원이 없습니다.');
                        }else{
                            //비밀번호를 찾을 경우
                        	$('#findId').css('display', 'none');
                            $('#findPassword').css('display', 'block');
                            $('#password').text(data.password);
                        }
                    },
                    error : function(jqXHR, textStatus, errorThrown){
                        axf.alert("code:"+jqXHR.status+"\nmessage:"+textStatus+"\nerror:"+errorThrown);
                    }
                });
            }
        }

	</script>

	<title>아이디/비밀번호 찾기</title>
</head>

<body>
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
				<p>가입당시의 이메일을 입력후 아이디 / 비밀번호 중 원하시는 정보를 선택 해 주십시오.</p>
			</div>
			
			<form name="frm" id="frm">
			<div class="block">
                <div class="line">
                    <label for="mberEmailAdres">이메일</label>
                    <input type="text" name="mberEmailAdres" id="mberEmailAdres" title="이메일" maxlength="50" class="AXInput av-required av-email" />
                </div>
            </div>
            </form>
            
			<div class="page_btn" style="margin: 100px 0 50px 0;">
				<a class="btn blue" onclick="findMemberId();">아이디 찾기</a>
				<a class="btn lgreen"  onclick="findPassword();">비밀번호 찾기</a>
			</div>
			<div class="block">
				<div id="findId" class="caption find" style="display: none;">
					<p>회원님의 아이디는 <span id="mberId"></span> 입니다.</p>
				</div>

				<div id="findPassword" class="caption find" style="display: none;">
					<p>회원님의 비밀번호가 <span id="password"></span> 로 변경 되었습니다.</p>
					<p>임시로 변경 된 비밀번호는 로그인 즉시 새 비밀번호로 설정하여 사용하십시오!</p>
				</div>
			</div>
		</div>

	</div>
</div>
</body>