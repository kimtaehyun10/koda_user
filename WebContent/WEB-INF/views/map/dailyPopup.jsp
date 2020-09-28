<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>운영변경안내</title>

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
            <h1>공영주차장 운영시간<font color="blue">&nbsp변경</font>안내</h1>
            <%--<a class="self_close" href="javascript:closePopup();"><i class="axi axi-highlight-remove"></i></a>--%>
            <div class="disc">
            	<font color="blue">
	                <p style="text-align:left;"><font color="black">■ 보라매 동문 공영 주차장 </font>운영시간변경 </p>
	                <p style="text-align:left;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">09:00~22:00(연중무휴) </font>→ 09:00~21:00(연중무휴)</p>
	                <p style="text-align:left;"><font color="black">■ 보라매 병원앞 노상 공영 주차장 </font>운영시간변경</p>
	                <p style="text-align:left;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">월~토 (09:00~22:00)  </font>→ 월~토(09:00~21:00)</p>
	                <p style="text-align:left;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">일·공휴일 (11:00~20:00) </font>→ 일·공휴일 (10:00~20:00)(연중무휴)</p>
	            </font>

                <div class="daily_check">
                    <input type="checkbox" id="chkPopup" />
                    <label for="chkPopup"><span></span>오늘 하루 그만보기</label>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
