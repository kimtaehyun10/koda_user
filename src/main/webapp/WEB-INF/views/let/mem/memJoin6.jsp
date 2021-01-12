<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page language="java" import="Kisinfo.Check.IPINClient" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>


<%
	String id = (String) request.getParameter("sid");
	String name = (String) request.getParameter("sname");
	String nick_name = (String) request.getParameter("snick_name");
%>
<head>
	<meta http-equiv="refresh" content="<%=session.getMaxInactiveInterval()%>;url=/sessionError" />
	<script type="text/javascript" src="<spring:eval expression="@appConfig['daum.addr.js.path']"/>"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/com/daumPostcode.js"></script>

	<title>회원가입</title>

    <script id="jscode">


    </script>
</head>

<body>
<!-- <form name="user" method="post"> -->
<%--     <input type="hidden" name="enc_data" value="<%= sResponseData %>"><br> --%>
<!-- </form> -->

	<form name="loginMenu" id="loginMenu" action="${pageContext.request.contextPath}/mem/memLogin.l"></form>
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
                        <img src="${pageContext.request.contextPath}/resource/assets/images/eprocess-6-active.png" alt="">
                    </div>
                    <p>가입완료</p>
                </div>
            </div>
            <div class="esignup-complete">
                <h1>
                    <strong>홍길동</strong> 님의 <strong style="color: #ff7e00;">수혜자 가족</strong> 회원가입을 환영합니다.
                </h1>
                <p>
                    입력하신 정보는 아래와 같습니다.<br/>
                    타인에게 노출되지 않도록 주의하시기 바랍니다.
                </p>
                <div>
                    <p>
                        이름 <strong><%=name %></strong>
                    </p>
                    <p>
                        아이디 <strong><%=id%></strong>
                    </p>
                    <p>
                        닉네임 <strong><%=nick_name%></strong>
                    </p>
                </div>
            </div>

            <div class="actions mt-12">
                <a href="/" class="black">메인으로</a>
                <a href="javascript:fn_MovePage('/let/letterMain.l')" style="background:#ff7e00">로그인</a>
            </div>
        </div>
    </div>
</body>
