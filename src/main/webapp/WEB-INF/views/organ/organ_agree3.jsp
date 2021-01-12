<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
<script id="jscode">
$(document.body).ready(function(){
    $(document).on('click', '.sub__tabs a', function () {
        $('.sub__tabs a').removeClass("active");
        $(this).addClass("active");
        
        $(".process").hide();

        var activeTab = $(this).attr("href"); //Find the href attribute value to identify the active tab + content
        $(activeTab).fadeIn(); //Fade in the active ID content
        return false;
    })	

});

</script>
</head>
<body>
	<div class="wrap">
		<div class="sub__header">
			<h2>KODA 협약병원</h2>
		</div>

		<div class="content">
			<div class="mapcol">
				<div class="col">
					<img
						src="${pageContext.request.contextPath}/resource/assets/images/13-map.png"
						alt="">
				</div>
				<div class="col">
					<ul>
						<li><img
							src="${pageContext.request.contextPath}/resource/assets/images/13-map-img1.png"
							alt=""> 뇌사장기기증자 관리업무 협약</li>
						<li><img
							src="${pageContext.request.contextPath}/resource/assets/images/13-map-img2.png"
							alt=""> DIP 협약병원</li>
						<li><img
							src="${pageContext.request.contextPath}/resource/assets/images/13-map-img3.png"
							alt=""> 검사실 협약</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
