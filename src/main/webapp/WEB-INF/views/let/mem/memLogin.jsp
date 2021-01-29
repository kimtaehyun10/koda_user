<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/paging.tld"%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
          
	 <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/assets/plugins/slick/slick.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/assets/plugins/jquery-ui-1.12.1/jquery-ui.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/assets/css/main.css"> 


	<script	src="${pageContext.request.contextPath}/resource/assets/plugins/jquery/jquery.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resource/axisj/dist/AXJ.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resource/axisj/lib/AXUtil.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resource/axisj/lib/AXValidator.js"></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resource/axisj/ui/AXJ.min.css"/>
<title>로그인</title>
<%
	String loginError = (String)request.getParameter("loginError");
%>
<script type="text/javascript">

var myValidator = new AXValidator();

$(document).ready(function () {

    $('#user_pw').keypress(function(event){
        if(event.keyCode == 13) {
            loginProc();
        }
    });    

    myValidator.setConfig({
        targetFormName: "loginForm"
    });
    
});


$(document).ready(function(){
    var userInputId = getCookie("userInputId");//저장된 쿠기값 가져오기
    $("#user_id").val(userInputId); 
     
    if($("#user_id").val() != ""){ // 그 전에 ID를 저장해서 처음 페이지 로딩
                                           // 아이디 저장하기 체크되어있을 시,
        $("#idSaveCheck").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
    }
     
    $("#idSaveCheck").change(function(){ // 체크박스에 변화가 발생시
        if($("#idSaveCheck").is(":checked")){ // ID 저장하기 체크했을 때,
            var userInputId = $("#user_id").val();
            setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
        }else{ // ID 저장하기 체크 해제 시,
            deleteCookie("userInputId");
        }
    });
     
    // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
    $("#user_id").keyup(function(){ // ID 입력 칸에 ID를 입력할 때,
        if($("#idSaveCheck").is(":checked")){ // ID 저장하기를 체크한 상태라면,
            var userInputId = $("#user_id").val();
            setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
        }
    });
});
 
function setCookie(cookieName, value, exdays){
    var exdate = new Date();
    exdate.setDate(exdate.getDate() + exdays);
    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
    document.cookie = cookieName + "=" + cookieValue;
}
 
function deleteCookie(cookieName){
    var expireDate = new Date();
    expireDate.setDate(expireDate.getDate() - 1);
    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
}
 
function getCookie(cookieName) {
    cookieName = cookieName + '=';
    var cookieData = document.cookie;
    var start = cookieData.indexOf(cookieName);
    var cookieValue = '';
    if(start != -1){
        start += cookieName.length;
        var end = cookieData.indexOf(';', start);
        if(end == -1)end = cookieData.length;
        cookieValue = cookieData.substring(start, end);
    }
    return unescape(cookieValue);
}





function loginProc() {
	 var validateResult = myValidator.validate();

     if (!validateResult) {
         var msg = myValidator.getErrorMessage();
         AXUtil.alert(msg);
         myValidator.getErrorElement().focus();
         return false;
     }else{
    	 $("#loginForm").submit();
     }
}

//login 오류 처리
var errorCode = "<%=loginError%>";
if (errorCode == '01') {
    //if (count > 0) {
    //	alert("로그인 실패했습니다.\r\n5회이상 실패할 경우 30분간 계정이 잠깁니다.\r\n현재 실패횟수 : " + count);
    //} else {
    	alert("아이디와 비밀번호를 다시 확인하십시요.");            	
    //}
} else if (errorCode == '02') {
    alert("로그인 후 이용하실수 있습니다. 로그인해주세요.");
} else if (errorCode == '03') {
    alert("로그인 실패 횟수(5회)를 초과했습니다. 30분후 다시 로그인해 주세요");
} else if (errorCode == '04') {
    alert("장기간 미사용으로 로그아웃 되었습니다.");
} else if (errorCode == '05') {
    alert("관리자 승인 전입니다. 잠시 후 다시 시도해 주십시요.");
}

</script>
</head>

<body>
<jsp:include page="main_part/main_part2.jsp"></jsp:include> 
	<form name="loginForm" id="loginForm" action ="/loginProc" method ="post">
		<div class="login">
			<div class="content">
				<img src="${pageContext.request.contextPath}/resource/assets/images/login-bg-img.png" alt="">
				<div class="login__form">
					<h2>생명나눔우체통 로그인</h2>
					<div class="form">
						<div class="input">
							<input type="text" id = "user_id" name ="user_id" title = "아이디" placeholder="아이디" class="av-required">
						</div>
						<div class="input">
	                        <input type="password" id = "user_pw" name="user_pw" title ="비밀번호" placeholder="비밀번호" class="av-required">
						</div>
						<button type="button" class="submit"  id = "btn_login" onclick="javascript:loginProc();">로그인</button>
					</div>
					<div class="etc">
						<label for="idSaveCheck" class="checkbox"> <input type="checkbox" hidden id="idSaveCheck"> <span></span>
							<p>아이디 저장</p>
						</label>

						<div class="links">
							<a id = "btn_find_id" href="javascript:fn_MovePage('/mem/findid.l');">아이디 찾기</a> 
							<a id = "btn_find_pw" href="javascript:fn_MovePage('/mem/findPw.l');">비밀번호 찾기</a>
							<a id = "btn_mem_join" href="javascript:fn_MovePage('/mem/memJoin1.l');">회원가입</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
	
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/assets/plugins/slick/slick.js"></script>

</body>
</html>