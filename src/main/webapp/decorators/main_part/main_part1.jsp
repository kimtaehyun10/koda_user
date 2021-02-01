<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 전체메뉴(PC) { -->
<div class="quickmenu">

	<div class="quickmenu__top">

		<a href="javascript:fn_MoveUrl('4','1','0')" class="navlist__link">
			<span><img src="${pageContext.request.contextPath}/resource/assets/images/quickmenu-i1.png" alt=""></span>
			기증<br/>
			희망등록
		</a>
		<a href="javascript:fn_MoveUrl('2','2','0','/donate/letter.c')">
			<span><img src="${pageContext.request.contextPath}/resource/assets/images/quickmenu-i2.png" alt=""></span>
			하늘나라<br/>
			편지
		</a>
		<a href="#">
			<span><img src="${pageContext.request.contextPath}/resource/assets/images/quickmenu-i3.png" alt=""></span>
			소식지<br/>
			신청
		</a>
	

		<a href="javascript:fn_MoveUrl('1','1','0'">기증절차</a>


	</div>

	<?php if(substr(basename($_SERVER['SCRIPT_NAME']), 0, 2) != '3-'){?>
	<div class="quickmenu__bottom">
		<a href="javascript:fn_MoveUrl('8','1','0')" class="member">
			<div class="number">1577-1458</div>
			의료진 전용<br/>
			콜센터
		</a>
		<a href="#">
			<div class="number">1544-0606</div>
			희망서약<br/>
			상담번호
		</a>
		<a href="javascript:fn_MoveUrl('7','1','0')">
			<div class="number">02-000-0000</div>
			KODA<br/>
			의원
		</a>
	</div>
	<?php }?>
	<a href="#" class="quickmenu__scroll">
		<span></span>
		TOP
	</a>
</div>