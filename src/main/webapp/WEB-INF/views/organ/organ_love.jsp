<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
</head>
<body>
        
        <div class="wrap">
            <div class="section">
                <h2 class="section__title">
                    생명나눔이란 무엇인가요?
                </h2>
                <p class="section__description">
                    생명나눔은 이식만이 유일한 희망인 환자에게 새 생명을 선물하는 일입니다.<br/>
                    심한 화상으로 미소를 잃은 어린 아이들, 장기부전으로 죽어가는 누군가에게 새 생명을 나눠주는
                    것은 환자 뿐만 아니라 그들의 가족까지 살리는 숭고한 나눔입니다.
                </p>
            </div>
        </div>

        <div class="sub__fullbox">
            <div class="wrap">
                <img src="${pageContext.request.contextPath}/resource/assets/images/sub1-img.png" alt="" class="fullbox-img">
                <div onclick="javascript:fn_MoveUrl('1','2','4')" class="item" style="cursor:pointer">
                    <span><img src="${pageContext.request.contextPath}/resource/assets/images/sub1-i1.png" alt=""></span>
                    <p>장기기증</p>
                </div>
                <div onclick="javascript:fn_MoveUrl('1','2','5')" class="item" style="cursor:pointer">
                    <span><img src="${pageContext.request.contextPath}/resource/assets/images/sub1-i2.png" alt=""></span>
                    <p>조직기증</p>
                </div>
                <div onclick="javascript:fn_MoveUrl('4','1','0')" class="item" style="cursor:pointer">
                    <span><img src="${pageContext.request.contextPath}/resource/assets/images/sub1-i3.png" alt=""></span>
                    <p>기증희망등록</p>
                </div>
            </div>
        </div>

        <div class="wrap">
            <div class="sub__video">
                <iframe src="https://www.youtube.com/embed/QYbsGilKpGQ" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
            </div>
        </div>

</body>
</html>
