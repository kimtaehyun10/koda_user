<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java" import="Kisinfo.Check.IPINClient"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<%
	String gubn = (String) request.getParameter("gubn");
	String upper_flg = (String) request.getParameter("upper_flg");
	String donor_name = (String) request.getParameter("donor_name");
	String dhospital_idx = (String) request.getParameter("dhospital_idx");
	String donor_date = (String) request.getParameter("donor_date");
	String donor_birth = (String) request.getParameter("donor_birth");
	String benefi_name = (String) request.getParameter("benefi_name");
	String bhospital_idx = (String) request.getParameter("bhospital_idx");
	String benefi_parts = (String) request.getParameter("benefi_parts");
	String benefi_birth = (String) request.getParameter("benefi_birth");
%>
<head>
<meta http-equiv="refresh"
	content="<%=session.getMaxInactiveInterval()%>;url=/sessionError" />

<title>회원가입</title>

<style type="text/css">
</style>

<script id="jscode">
	

	function checkPhone(){
		
		axf.alert("휴대폰 인증에 성공하였습니다.");
		
		$("#frm").submit();
		
	}
	
	function checkIpin(){
		
		axf.alert("아이핀 인증에 성공하였습니다.");
		
		$("#frm").submit();
		
	}
	
</script>
</head>

<body>
	<!-- <form name="user" method="post"> -->
	<%--     <input type="hidden" name="enc_data" value="<%= sResponseData %>"><br> --%>
	<!-- </form> -->
	<form name="frm" id="frm" action="/mem/memJoin5.l" method="post">
		<input type="hidden" id="gubn" name="gubn" value="<%=gubn%>" />
	    <input type="hidden" id="upper_flg" name="upper_flg" value="<%=upper_flg%>"/>
		<input type="hidden" id="donor_name" name="donor_name" value="<%=donor_name%>" />
		<input type="hidden" id="dhospital_idx" name="dhospital_idx" value="<%=dhospital_idx%>" />
		<input type="hidden" id="donor_date" name="donor_date" value="<%=donor_date%>" />
		<input type="hidden" id="donor_birth" name="donor_birth" value="<%=donor_birth%>" />
		<input type="hidden" id="benefi_name" name="benefi_name" value="<%=benefi_name%>" />
		<input type="hidden" id="bhospital_idx" name="bhospital_idx" value="<%=bhospital_idx%>" />
		<input type="hidden" id="benefi_parts" name="benefi_parts" value="<%=benefi_parts%>" />
		<input type="hidden" id="benefi_birth" name="benefi_birth" value="<%=benefi_birth%>" />
	</form>
	
	<div class="esignup">
        <div class="wrap">
            <h2 class="e-title">기증자 가족 회원가입</h2>
            <div class="esignup__process">
                <div class="col">
                    <div class="icon">
                        <img src="${pageContext.request.contextPath}/resource/assets/images/eprocess-1.png" alt="">
                    </div>
                    <p>회원구분</p>
                </div>
                <div class="col">
                    <div class="icon">
                        <img src="${pageContext.request.contextPath}/resource/assets/images/eprocess-2.png" alt="">
                    </div>
                    <p>회원선택</p>
                </div>
                <div class="col">
                    <div class="icon">
                        <img src="${pageContext.request.contextPath}/resource/assets/images/eprocess-3.png" alt="">
                    </div>
                    <p>약관동의</p>
                </div>
                <div class="col">
                    <div class="icon">
                        <img src="${pageContext.request.contextPath}/resource/assets/images/eprocess-4-active.png" alt="">
                    </div>
                    <p>본인인증</p>
                </div>
                <div class="col">
                    <div class="icon">
                        <img src="${pageContext.request.contextPath}/resource/assets/images/eprocess-5.png" alt="">
                    </div>
                    <p>정보입력</p>
                </div>
                <div class="col">
                    <div class="icon">
                        <img src="${pageContext.request.contextPath}/resource/assets/images/eprocess-6.png" alt="">
                    </div>
                    <p>가입완료</p>
                </div>
            </div>
            <div class="esignup-type">
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
        </div>
    </div>
</body>
