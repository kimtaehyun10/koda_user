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
					<div class="mapcol2">
						<div class="col">
							<img src="${pageContext.request.contextPath}/resource/assets/images/13-map1a_01.png" alt="">
						</div>
						<div class="col">
							<div class="in1">
								<div class="sc1">
									<span class="ic1"></span><strong class="ic2">중부지부</strong>
									<span class="ic1"></span><strong class="ic2">충청·호남지부</strong>
									<span class="ic1"></span><strong class="ic2">영남지부</strong>
								</div>
								<ul class="sc2">
									<li><img src="${pageContext.request.contextPath}/resource/assets/images/13-map-img1.png" alt=""><a href="javascript:fn_MoveUrl('1','6','1','/organ/organ_agree1.c')">뇌사장기기증자 관리업무 협약</a></li>
									<li><img src="${pageContext.request.contextPath}/resource/assets/images/13-map-img2.png" alt=""><a href="javascript:fn_MoveUrl('1','6','2','/organ/organ_agree2.c')">DIP 협약병원</a></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
</body>
</html>
