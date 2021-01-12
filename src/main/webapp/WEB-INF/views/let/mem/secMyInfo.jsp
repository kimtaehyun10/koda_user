<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java" import="Kisinfo.Check.IPINClient"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>


<head>
<title>생명나눔편지함</title>

<script id="jscode">


        $(document.body).ready(function(){
        	
            $(document).on('click', '.mobile-emenu-content .links a', function () {
                $('.links a').removeClass("active");
                $(this).addClass("active");
            })
            

            $('#user_pw').keypress(function(event){
                if(event.keyCode == 13) {
                	goModiMem();
                }
            });    
            

        });
        
        //내정보 페이지 이동
        function goModiMem(){
        	if ($("#user_pw").val() == ""){
        		axf.alert("비밀번호를 입력하십시요.");
        		$("#user_pw").focus();
        	}
        	
        	//비밀번호 확인
        	$.ajax({
                url: "/mem/chkPassword.json",
                type: "POST",
                data: {password:$("#user_pw").val()},
                dataType: "json",
                success: function (data, textStatus, jqXHR) {
                	if (data == "1"){
                    	$("#frm").attr("action", "/let/memModify.l");
                    	$("#frm").submit();                  	        	
                	}else{
                		axf.alert("비밀번호가 올바르지 않습니다.");
                		$("#user_pw").focus();
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
	<form name="frm" id="frm" method="post">
		<sec:authentication property="principal.username" var="username" />
		<div class="esignup">
        <div class="wrap">
            <h2 class="e-title">내 정보</h2>
            <p class="e-desciption">
                본인확인을 위해 비밀번호를 한번 더 입력해 주세요.<br/>
                회원님의 정보를 안전하게 보호하기 위해 비밀번호를 한번 더 확인합니다.
            </p>

            <div class="e-form mt-8">
                <div class="row">
                    <h3>생명나눔 우체통 아이디</h3>
                    <div>
                        <p>${username}</p>
                    </div>
                </div>
                <div class="row">
                    <h3>비밀번호</h3>
                    <div>
						<input hidden="hidden" />
                        <input type="password" id="user_pw" name="user_pw" placeholder="비밀번호 입력"/>
                    </div>
                </div>
            </div>

            <div class="actions mt-12">
                <a href="javascript:goModiMem();" class="green">확인</a>
            </div>
        </div>
    </div>
	</form>
</body>