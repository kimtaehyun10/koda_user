$(document.body).ready(function(){
    
    // 로그인 화면 호출
    $('.add_login').click(function(){
        // 마스크 덮기
        $('#bgMask').css('display', 'block');
        $('#loginContainer').addClass('active');
    });
    
    // 메뉴 화면 호출
    $('.add_menu').click(function(){
        // 마스크 덮기
        $('#bgMask').css('display', 'block');
        $('#menuContainer').addClass('active');
    });
    
    // 로그인,메뉴 화면 닫기
    $('.close_container').click(function(){
        // 마스크 지우기
        $('#bgMask').css('display', 'none');
        $(this).parent().parent().removeClass('active');
    });
    
    // 전체 소메뉴 컨트롤
    $('.nav > li > a').click(function(){
       
        if ($(this).parent().hasClass('active') == false){
            // 이전 오픈 된 소메뉴 닫기
            $('.nav > li').removeClass('active');
            // 클릭 한 소메뉴 열기
            $(this).parent().addClass('active');
        } else {
            $(this).parent().removeClass('active');
        }
    });
    
});

function fn_MovePage(url, menuNo) {  
	//document.location.href = url+"?menuNo="+document.selectOne.menuNo.value+"&pageId="+menuNo; 
	document.location.href = url;
}

function loginProc() {
    if ($("#user_id").val() == "") {
        alert("ID를 입력하세요");
        $("#user_id").focus();
        return;
    }

    if ($("#user_pw").val() == "") {
        alert("비밀번호를 입력하세요");
        $("#user_pw").focus();
        return;
    }

    $("#loginForm").submit();
}