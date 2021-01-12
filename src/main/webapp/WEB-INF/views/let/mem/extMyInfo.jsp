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
                url: "/let/extMember.json",
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
	<form name="frm" id="frm">
		<sec:authentication property="principal.username" var="username" />
		<div class="esignup">
			<div class="wrap">
				<h2 class="e-title">회원탈퇴</h2>
				<div class="e-desciption">
					회원탈퇴를 원하실 경우, 본인확인을 위해 비밀번호를 한번 더 입력해 주세요.<br /> 비밀번호를 입력하시면 회원탈퇴가
					완료됩니다.
					<p style="color: #ff7e00">
						※ 탈퇴 후 재가입은 30일 이후에 가능합니다.<br /> <span class="block pl-4">-
							탈퇴 후에는 같은 아이디로 다시 가입할 수 없으며 아이디와 데이터는 복구할 수 없습니다.</span> <span
							class="block pl-4">- 게시판에 남아 있는 게시글은 탈퇴 후 삭제할 수 없습니다.</span>
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
								<input type="password" id="user_pw" name = "user_pw" placeholder="비밀번호 입력" />
							</div>
						</div>
					</div>

					<div class="actions mt-12">
						<a href="javascript:chkPassword();" class="green">회원탈퇴</a>
					</div>
				</div>
			</div>
		</div>
	</form>
</body>