<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java" import="Kisinfo.Check.IPINClient"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<head>
<meta http-equiv="refresh"
	content="<%=session.getMaxInactiveInterval()%>;url=/sessionError" />

<title>회원가입</title>

<style type="text/css">
</style>

<script id="jscode">
	

	function checkPhone(){
		
		axf.alert("휴대폰 인증에 성공하였습니다.");
		
		//$("#frm").submit();
		
		returnPw();
		
	}
	
	function checkIpin(){
		
		axf.alert("아이핀 인증에 성공하였습니다.");
		
		//$("#frm").submit();
		
		returnPw();
		
	}
	
	function returnPw(){

        $("#div_updatePw1").css("display","");
        $("#div_updatePw2").css("display","");
        $("#div_checkUser1").css("display","none");
        $("#div_checkUser2").css("display","none");
        $("#div_checkUser3").css("display","none");
        
		$("#p_returnId").html($("#id").val());
	}
	
	function updatePw(){
    	if ($("#password").val() == ""){
    		axf.alert("비밀번호를 입력하십시요.");
    		$("#password").focus();
    	}
    	
    	if ($("#passwordCheck").val() == ""){
    		axf.alert("비밀번호를 입력하십시요.");
    		$("#passwordCheck").focus();
    	}
    	
    	if ($("#password").val() != $("#passwordCheck").val()) {
            axf.alert("비밀번호와 비밀번호 확인이 같지않습니다. 확인해주세요.");
            return;
        }
    	
    	//비밀번호 정규식 체크
        var password = $("#password").val();
        var acceptPassword = /^.*(?=^.{9,16}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[~,!,@,#,$,*,(,),=,+,_,.,|]).*$/;

        if (acceptPassword.test(password) == false) {

            axf.alert("비밀번호는 영문/숫자/특수문자를 포함한 9~16글자만 가능합니다.");

            $("#password").focus();
            return;
        }
        
        $.ajaxSettings.traditional = true;
        $.ajax({
            url: "/mem/updatePw.json",
            type: "POST",
            data: $('#frm').serialize(),
            dataType: "json",
            success: function (data, textStatus, jqXHR) {
                if (data.result == "OK") {
                    axf.alert("비밀번호 수정을 완료했습니다.");
                	fn_MovePage('/mem/memLogin.l');
                } else {
                    axf.alert("비밀번호 수정에 실폐했습니다.");
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                axf.alert("code:" + jqXHR.status + "\nmessage:" + textStatus + "\nerror:" + errorThrown);
            }
        });
	}
</script>
</head>

<body>
	<!-- <form name="user" method="post"> -->
	<%--     <input type="hidden" name="enc_data" value="<%= sResponseData %>"><br> --%>
	<!-- </form> -->
	<form name="frm" id="frm" method="post">
	
	<div class="esignup">
        <div class="wrap">
            <h2 class="e-title">비밀번호 찾기</h2>
				<div class="esignup-form-section mt-12" id ="div_checkUser1">
					<div class="form">
						<div class="form-row">
							<h3 class="require">아이디</h3>
							<div class="box">
								<div class="row">
									<div class="input">
										<input type="text" id="id" name="id" title="아이디 입력">
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
	        
            <div class="esignup-type" id ="div_checkUser2">
                <div class="col">
                    <div class="icon"><img src="${pageContext.request.contextPath}/resource/assets/images/eprocess-4-img1.png" alt="" style="height: 150px;"></div>
                    <p>
                        본인명의로 등록된 휴대폰을 통해<br/>
                        본인확인을 받을 수 있는 서비스 입니다.
                    </p>
                    <a href="javascript:checkPhone();" class="black">휴대폰 인증하기</a>
                </div>
                <div class="col">
                    <div class="icon"><img src="${pageContext.request.contextPath}/resource/assets/images/eprocess-4-img2.png" alt="" style="height: 150px;"></div>
                    <p>
                        개인식별 번호를 발급받아 인터넷상에서<br/>
                        본인확인을 받을 수 있는 서비스 입니다.
                    </p>
                    <a href="javascript:checkIpin();" class="black">아이핀(i-PIN) 인증하기</a>
                </div>
            </div>
            
            <div class="actions mt-12" id ="div_checkUser3">
            	<a href="javascript:fn_MovePage('/mem/memLogin.l');">돌아가기</a>
			</div>
            
            <div class="e-desciption" id ="div_updatePw1" style="display:none">
				<div class="e-form mt-8">
					<div class="row">
						<h3>생명나눔 우체통 아이디</h3>
						<div>
							<p id="p_returnId"></p>
						</div>
					</div>
					<div class="row">
						<h3>비밀번호</h3>
						<div>
							<input hidden="hidden" />
							<input type="password" id="password" name = "password" placeholder="비밀번호 입력" />
						</div>
					</div>
					<div class="row">
						<h3>비밀번호확인</h3>
						<div>
							<input hidden="hidden" />
							<input type="password" id="passwordCheck" name = "passwordCheck" placeholder="비밀번호 입력" />
						</div>
					</div>
				</div>
	        </div>
	        
			<div class="actions mt-12" id ="div_updatePw2" style="display:none">
				<a href="javascript:updatePw();" class="black">비밀번호 수정</a> <a
					href="javascript:fn_MovePage('/mem/memLogin.l');">돌아가기</a>
			</div>
	    </div>
    </div>
    
	</form>
</body>
