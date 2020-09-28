<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<head>

    <title>회원탈퇴 - 나의 주차정보</title>
    
    <script id="jscode">
    
        //회원수정
        function memberOut() {
        	
        	if($("input:checkbox[id='agree']").is(":checked") == false){
        		alert('회원탈퇴동의를 선택후 탈퇴가 가능합니다.');
        		return;
        	}
        	
        	$.ajax({
                url : "/mypage/memberStatus.json",
                type: "POST",
                data: {},
                dataType:"json",
                success : function(data, textStatus, jqXHR) {
                    if (data.result == "ASSIGNED") {
                        axf.alert("현재 배정상태이며 홈페이지 탈퇴가 불가합니다. 공단으로 문의하시기 바랍니다.");
                        return;
                    } else if (data.result == "FAIL") {
                        axf.alert("회원탈퇴에 실패했습니다. 공단으로 문의해주세요.");
                        return;
                    } else {
                    	if (confirm('회원탈퇴 하시겠습니까?') == false) {
                    		return;
                    	}
                    	
                    	$.ajax({
                            url : "/mypage/memberOut.json",
                            type: "POST",
                            data: {},
                            dataType:"json",
                            success : function(data, textStatus, jqXHR) {
                                if (data.result == "OK") {
                                    axf.alert("회원 탈퇴에 성공했습니다. 그동안 이용해주셔서 감사합니다.");
                                    //todo 로그아웃해야함
                                    
                                    fn_MovePage('/logout');
                                    //fn_MovePage('/main');
                                } else {
                                    axf.alert("회원탈퇴에 실패했습니다. 관리자에게 문의해주세요.");
                                }
                            },
                            error : function(jqXHR, textStatus, errorThrown){
                                axf.alert("code:"+jqXHR.status+"\nmessage:"+textStatus+"\nerror:"+errorThrown);
                            }
                        });
                    }
                },
                error : function(jqXHR, textStatus, errorThrown){
                    axf.alert("code:"+jqXHR.status+"\nmessage:"+textStatus+"\nerror:"+errorThrown);
                }
            });

        }

    </script>

</head>
<body>
<div id="Page" class="page mypage">
    <div class="ct_head">
        <div class="head">
            <div class="title">
                <h1>회원탈퇴</h1>
                <!--<h2><i class="axi axi-keyboard-arrow-right"></i>회원탈퇴</h2>-->
            </div>
        </div>
    </div>
    <div class="ct_body">

        <div class="body full">
            <div class="caption">
                <p>동작구시설관리공단 주차관리시스템에서 회원탈퇴 합니다.</p>
                <p>회원탈퇴 시 모든 등록 내용 및 진행 절차와 정보는 삭제됩니다.</p>
                <p>신중하게 결정해 주시기 바랍니다.</p>
            </div>

            <div class="block">
                <div class="reconfirm">
                    <div class="line">
                    	<!-- 
                        <label>아이디</label>
                        <span id="" class="text_id">${user.mberNm}</span>
                         -->
                    </div>
                    <div class="line" style="text-align: center;">
                        <input name="agree" id="agree" type="checkbox" />
                        <label for="agree"><span></span>회원탈퇴에 동의합니다.</label>
                    </div>
                </div>
            </div>

            <div class="page_btn">
                <a class="btn lgreen" onclick="memberOut();">회원탈퇴</a>
            </div>
        </div>
    </div>
</div>
</body>