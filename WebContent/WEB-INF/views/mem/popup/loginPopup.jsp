<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<title>로그인</title>
</head>
<body id="popUp">
    <div class="login">
        <input class="text" type="text" placeholder="아이디" />
        <input class="text" type="password" placeholder="비밀번호" />
        <input id="" type="checkbox" /><label for=""><span></span>보안접속</label>
        <input id="" type="checkbox" /><label for=""><span></span>ID저장</label>
        <a class="btn dblue">로그인</a>
        <a class="text">아이디/비밀번호 찾기</a>
        <a class="text join" href="javascript:fn_MovePage('/mem/memberJoinIpin.c');">회원가입</a>
    </div>
    <div class="pop_foot">
        <a class="btn" onclick="closePopup();">취소</a>
    </div>
</body>
</html>