<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
</head>
<body>
	<div class="wrap">
		<div class="section">
			<h2 class="section__title">기증은 왜 필요한가요?</h2>
			<p class="section__description">
				하루에 5.9명이 이식을 받지 못해 사망하고 있습니다.<br /> 이식을 기다리는 사람들은 한 집안의 생계를 책임져야하는
				가장일 수도 있고, 이제 막 세상을 마주한 어린 아이일수도 있습니다.<br /> 기증은 단순한 나눔이 아닌 한 사람의
				생명을 살릴 수 있는 선한 영향력이란 사실을 기억해주세요.<br /> <br /> 장기이식, 우리 가족의 일이 될 수도
				있습니다.
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
			<iframe src="https://www.youtube.com/embed/QYbsGilKpGQ"
				frameborder="0"
				allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
				allowfullscreen></iframe>
		</div>
	</div>
</body>
</html>
