<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java" import="Kisinfo.Check.IPINClient"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>


<head>
<title>생명나눔편지함</title>

<style type="text/css">
.memorial__search-form {
	background: #FFFFFF;
	padding: 0px;
}

.memorial__search-form .schedule {
	margin-left: 0px;
	display: flex;
	align-items: center;
}
</style>

<script id="jscode">

   		var myValidator = new AXValidator();
        

        $(document.body).ready(function(){
        	
            $(document).on('click', '.mobile-emenu-content .links a', function () {
                $('.links a').removeClass("active");
                $(this).addClass("active");
            })

        });        

        $(document).ready(function () {

            $('#user_pw').keypress(function(event){
                if(event.keyCode == 13) {
                	chkPassword();
                }
            });
            
        });
        
        function chkPassword(){
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
                		extMember();                    	
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
        
        //회원 탈퇴 처리
        function extMember(){
        	//비밀번호 확인
        	$.ajax({
                url: "/mem/extMember.json",
                type: "POST",
                data: {password:$("#user_pw").val()},
                dataType: "json",
                success: function (data, textStatus, jqXHR) {
                	if (data.result == "OK"){
                		axf.alert("회원 탈퇴처리가 완료되었습니다.");
                		document.getElementById('logout-form').submit();                    	
                	}else{
                		axf.alert("탈퇴처리에 실패했습니다.");
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
	<div class="esignup">
		<div class="wrap">

			<div class="email-end">
				<div class="icon">
					<img src="${pageContext.request.contextPath}/resource/assets/images/email-end-img.png" alt="">
				</div>

				<h2>회원탈퇴가 완료되었습니다.</h2>
				<p>그동안 생명나눔우체통을 이용해 주셔서 감사합니다.</p>
			</div>

			<div class="actions mt-12">
				<a href="/" class="green">확인</a>
			</div>
		</div>
	</div>
</body>