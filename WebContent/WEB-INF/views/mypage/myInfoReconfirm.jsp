<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
    <script id="jscode">
    
        var myValidator = new AXValidator();
        
        $(function(){ 
            myValidator.setConfig({
                targetFormName : "frm"
            });
        });
        
        //비밀번호 체크
        function confirmPassword() {
            
            var validateResult = myValidator.validate();
            
            if(!validateResult) {
                var msg = myValidator.getErrorMessage();
                AXUtil.alert(msg);
                myValidator.getErrorElement().focus();
                return false;
            }else{
                
            	/*
            	관리자가 회원가입시, 혹은 비밀번호 찾기에서
            	난수(숫자+문자)로 발생시키기때문에 비밀번호를 수정하려면 특수문자 체크는 빼줘야 가능함..
                //비밀번호 정규식 체크
                var password = $("#password").val();
                var acceptPassword = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[~,!,@,#,$,*,(,),=,+,_,.,|]).*$/;
                
                if(acceptPassword.test(password) == false){
                    
                    axf.alert('비밀번호는 영문/숫자/특수문자를 포함한 8~15글자만 가능합니다.');
                    $("#password").focus();
                    return;
                }
                */
                
                $.ajax({
                    url : "/mypage/confirmPassword.json",
                    type: "POST", 
                    data: $('#frm').serialize(),
                    dataType:"json", 
                    success : function(data, textStatus, jqXHR) {
                        if (data.result == "OK") {
                            //axf.alert("등록 성공했습니다. 가입하신정보로 로그인해주세요.");
                            fn_MovePage('/mypage/modifyMyInfo.c');
                        } else {
                            axf.alert("입력하신 비밀번호가 틀립니다. 확인후 다시입력해주세요.");
                        }
                    },
                    error : function(jqXHR, textStatus, errorThrown){
                        axf.alert("code:"+jqXHR.status+"\nmessage:"+textStatus+"\nerror:"+errorThrown);
                    }
                });
            }
        }
      
    </script>

    <title>정보수정 - 나의 주차정보</title>

</head>
<body>
<sec:authentication var="user" property="principal" />
<div id="Page" class="page mypage">
    <div class="ct_head">
        <div class="head">
            <div class="title">
                <h1>나의 주차정보</h1>
                <h2><i class="axi axi-keyboard-arrow-right"></i>정보수정</h2>
            </div>
            <div class="log out">
                <!-- 로그인 이전 -->
                <sec:authorize access="isAnonymous()">
                    <div class="in">
                        <a class="join" href="javascript:fn_MovePage('<c:url value='/mem/memberJoinIpin.c'/>');">회원가입</a>
                    </div>
                </sec:authorize>
                <!-- 로그인 이후 -->
                <sec:authorize access="isAuthenticated()">
                    <div class="out">
                        <p><span>${user.mberNm}</span>님 환영합니다!</p>
                        <a class="btn red" href="<c:url value='/logout'/>">로그아웃</a>
                    </div>
                </sec:authorize>
            </div>
        </div>
    </div>
    <div class="ct_body">
        <div class="sub_nav">
            <ul>
                <li><a href="javascript:fn_MovePage('/mypage/parkingContract.c');">주차요금결제</a></li>
                <li><a href="javascript:fn_MovePage('/mypage/parkingCharge.c');">거주자환불신청</a></li>
                <li><a href="javascript:fn_MovePage('/mypage/standbyStatus.c');">대기현황조회</a></li>
                <li><a class="on" href="javascript:fn_MovePage('/mypage/myInfoReconfirm.c');">정보수정</a></li>
                <li><a href="javascript:fn_MovePage('/mypage/outReconfirm.c');">회원탈퇴</a></li>
            </ul>
        </div>

        <div class="body">
            <div class="caption">
                <p>회원정보 확인 및 정보 수정을 위해 한 번 더 로그인 해주시기 바랍니다.</p>
            </div>
            
            <form name="frm" id="frm">
            <div class="block">
                <div class="reconfirm">
                    <div class="line">
                        <label>아이디</label>
                        <span class="text_id">${user.mberNm}</span>
                    </div>
                    <div class="line">
                        <label>비밀번호</label>
                        <input type="password" name="password" id="password" title="비밀번호" maxlength="15" class="AXInput av-required" />
                    </div>
                </div>
            </div>
            </form>

            <div class="page_btn">
                <a class="btn lgreen" href="javascript:confirmPassword();">확인</a>
            </div>
        </div>
    </div>
</div>
</body>