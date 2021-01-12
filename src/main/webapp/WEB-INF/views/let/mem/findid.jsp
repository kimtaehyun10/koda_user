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
		
		returnId("testuser1");
		
	}
	
	function checkIpin(){
		
		axf.alert("아이핀 인증에 성공하였습니다.");
		
		//$("#frm").submit();
		
		returnId("testuser2");
		
	}
	
	function returnId(id){

        $("#div_returnId").css("display","");
        $("#div_checkUser").css("display","none");
        
		$("#p_returnId").html(id);
	}
	
</script>
</head>

<body>
	<!-- <form name="user" method="post"> -->
	<%--     <input type="hidden" name="enc_data" value="<%= sResponseData %>"><br> --%>
	<!-- </form> -->
	<form name="frm" id="frm" method="post">
	</form>
	
	<div class="esignup">
        <div class="wrap">
            <h2 class="e-title">아이디 찾기</h2>
            <div class="esignup-type" id ="div_checkUser">
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
            
            <div class="e-desciption" id ="div_returnId" style="display:none">
					<div class="e-form mt-8">
						<div class="row">
							<h3>생명나눔 우체통 아이디</h3>
							<div>
								<p id="p_returnId"></p>
							</div>
						</div>
					</div>
	        </div>
	        
	        <div class="actions mt-12">
	        	<a href="javascript:fn_MovePage('/mem/memLogin.l');">돌아가기</a>
			</div>
	    </div>
    </div>
</body>
