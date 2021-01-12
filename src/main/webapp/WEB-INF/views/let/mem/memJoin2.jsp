<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java" import="Kisinfo.Check.IPINClient"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>


<%
	String gubn = (String) request.getParameter("gubn");
	String donor_name = (String) request.getParameter("pdonor_name");
	String dhospital_idx = (String) request.getParameter("pdhospital_idx");
	String donor_date = (String) request.getParameter("pdonor_date");
	String donor_birth = (String) request.getParameter("pdonor_birth");
	String benefi_name = (String) request.getParameter("pbenefi_name");
	String bhospital_idx = (String) request.getParameter("pbhospital_idx");
	String benefi_parts = (String) request.getParameter("pbenefi_parts");
	String benefi_birth = (String) request.getParameter("pbenefi_birth");
	
%>
<head>
<meta http-equiv="refresh"
	content="<%=session.getMaxInactiveInterval()%>;url=/mem/memLogin.l?loginError=04" />

<title>회원가입</title>

<script id="jscode">
	function selectUpperFlg(idx) {
		$("#upper_flg").val(idx);

		$("#frm").submit();
	}
</script>
</head>

<body>
	<!-- <form name="user" method="post"> -->
	<%--     <input type="hidden" name="enc_data" value="<%= sResponseData %>"><br> --%>
	<!-- </form> -->

	<form name="frm" id="frm" action="/mem/memJoin3.l" method="post">
		<input type="hidden" id="gubn" name="gubn" value="<%=gubn%>" />
		<input type="hidden" id="upper_flg" name=upper_flg value="" />
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
                        <img src="${pageContext.request.contextPath}/resource/assets/images/eprocess-2-active.png" alt="">
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
                        <img src="${pageContext.request.contextPath}/resource/assets/images/eprocess-4.png" alt="">
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
                    <div class="icon"><img src="${pageContext.request.contextPath}/resource/assets/images/eprocess-2-img1.png" alt="" style="height: 150px;"></div>
                    <h3>일반회원</h3>
                    <a href="javascript:selectUpperFlg('U')"">14세 이상 가입하기</a>
                </div>
                <div class="col">
                    <div class="icon"><img src="${pageContext.request.contextPath}/resource/assets/images/eprocess-2-img2.png" alt="" style="height: 150px;"></div>
                    <h3>어린이회원</h3>
                     <a href="javascript:selectUpperFlg('D')" class="black">14세 미만 가입하기</a>
                </div>
            </div>
        </div>
    </div>
</body>
