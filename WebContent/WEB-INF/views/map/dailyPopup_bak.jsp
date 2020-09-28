<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>주차시설 홈페이지 접속불가 안내</title>

    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery.cookie.js"></script>

    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resource/axicon/axicon.min.css"/>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/main.css"/>

    <script language="JavaScript">

        $(document).ready(function(){

            // 팝업 창 닫으며 쿠키저장 : 하루동안 팝업 노출 막기
            $("label[for='chkPopup']").click(function(){

                $("#chkPopup").prop("checked", true);

                $.cookie('the_cookie', 'close', { expires: 1, path: '/'});

                if ($("#chkPopup").is(":checked") == true){
                    window.close();
                }
            });
        });

    </script>
</head>
<body>
    <div class="daily_popup">
        <div class="body">
            <h1>주차시설 홈페이지 접속안내</h1>
            <%--<a class="self_close" href="javascript:closePopup();"><i class="axi axi-highlight-remove"></i></a>--%>
            <div class="disc">
                <p>주차시설 프로그램 개편에 따른 홈페이지를 개편하였습니다.</p>
                <p>HTML5 표준에 맞추어 제작되어 아래의 사양을 참고하셔서 이용바랍니다.</p>
                <p class="bold">[권장] IE 10 이상</p>
				<p class="bold">ActiveX를 지원하는 브라우저</p>
				<p>그 외 표준 HTML5를 지원하는 브라우저를 사용하시면</p>
                <p>원활한 이용이 가능합니다.감사합니다.</p>

                <div class="daily_check">
                    <input type="checkbox" id="chkPopup" />
                    <label for="chkPopup"><span></span>오늘 하루 그만보기</label>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
