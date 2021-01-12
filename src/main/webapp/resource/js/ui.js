/**
 * 
 */
$(function(){
	//글자크기확대축소
	var scrzoom_now	= 100;
	var scrzoom_max	= 300;
	var scrzoom_min	= 100;
	function fn_scrzoom(ac){
		if(ac == 1){
			if(scrzoom_now >= scrzoom_max){
				alert('최대 화면입니다.');
				return;
			}
			scrzoom_now	+= 10;
		}else{
			if(scrzoom_now <= scrzoom_min){
				alert('최소 화면입니다.');
				return;
			}
			scrzoom_now	-= 10;
		}
		document.body.style.zoom = scrzoom_now + '%';
	}
	
	// 헤드 > 메뉴점프
	$('.head_goto1 a').on('focus', function(){
		$(this).css({'opacity':'1','padding':'1em 0','height':'auto'});
	});
	$('.head_goto1 a').on('blur', function(){
		$(this).css({'opacity':'0','padding':'0','height':'0'});
	});
	// 헤드 > 메뉴점프 > 주메뉴
	$('.btn_anchor_topmenu').on('click', function(){
		$('#anchor_topmenu').trigger('focus');
	});
	// 헤드 > 메뉴점프 > 본문영역
	$('.btn_anchor_content').on('click', function(){
		$('#anchor_content').trigger('focus');
	});
	// 헤드 > 통합예약
	$('.addmenu1_btn').on('click', function(){
		$('.addmenu1_ly').slideToggle();
		var osrc	= $('.addmenu1_btn img').attr('src');
		var nsrc	= '';
		if(osrc.indexOf('_up.') > -1) nsrc	= osrc.replace('_up.','_down.');
		else nsrc	= osrc.replace('_down.','_up.');
		$('.addmenu1_btn img').attr('src', nsrc);
	});
	// 헤드 > 대메뉴 > PC > 마우스overout
	$('.head_menu_p .head_topmenu .topmenu .dp1 .tm1').on('focus mouseover', function(){
		$('.head_menu_p .head_topmenu .topmenu .dp1 .sm1').css({'display':'none'});
		$('.head_menu_p .head_topmenu .topmenu .dp1:eq('+$(this).parent().index()+') .sm1').css({'display':'block'});
		$('.head_menu_p .topmenu_ly').addClass('on');
		$('.head_menu_p .topmenu_ly').css({'height':($(this).next().outerHeight()+$('.head_menu_p .head_topmenu').height())+'px'});
	});
	$('.head_menu_p .head_topmenu, .head_menu_p .topmenu_ly').on('blur mouseleave', function(){
		$('.head_menu_p .topmenu_ly').removeClass('on');
		$('.head_menu_p .topmenu_ly').css({'height':$('.head_menu_p .head_topmenu').height()+'px'});
		$('.head_menu_p .head_topmenu .topmenu .dp1 .sm1').css({'display':'none'});
	});
	$('#anchor_topmenu, #anchor_content').on('focus', function(){
		$('.head_menu_p .topmenu_ly').removeClass('on');
		$('.head_menu_p .topmenu_ly').css({'height':$('.head_menu_p .head_topmenu').height()+'px'});
		$('.head_menu_p .head_topmenu .topmenu .dp1 .sm1').css({'display':'none'});
	});
	// 전체메뉴onoff
	$('.btn_allmenu_toggle').on('click', function(){
		var win_w = $(window).innerWidth();
		var topmenu_ly__w = $('.head_menu_m .topmenu_ly').width();
		if(topmenu_ly__w < 100){
			$('.head_menu_m .topmenu_bx').prepend("<div class='topmenu_bg'></div>");
			$('.head_menu_m .topmenu_ly').css({'display':'block','opacity':'1','width':(win_w>=865 ? 60 : 80)+'%','overflow-y':'auto'});
			$('.head_menu_m .topmenu').focus();
			$('.btn_allmenu_toggle').attr('title','전체메뉴 닫기');
			$('.head_menu_m .topmenu_bg').on('click', function(){
				$('.head_menu_m .topmenu_ly').animate({'width':'0','opacity':'0','display':'none','overflow-y':'hidden'}, 100);
				$('.head_menu_m .topmenu_bg').fadeOut('slow', function(){$(this).remove();});
				$('.head_menu_m .bx_allmenu').focus();
				$('.btn_allmenu_toggle').attr('title','전체메뉴 열기');
			});
		}
		else{
			$('.head_menu_m .topmenu_ly').animate({'width':'0','opacity':'0','display':'none','overflow-y':'hidden'}, 100);
			$('.head_menu_m .topmenu_bg').fadeOut('slow', function(){$(this).remove();});
			$('.head_menu_m .bx_allmenu').focus();
			$('.btn_allmenu_toggle').attr('title','전체메뉴 열기');
		}
	});
	// 상단검색폼
	$('.head_menu_m .headlogo .sch_btn a').on('click', function(){
		$('.head_menu_m .bx_sch .ly1').css({'display':'block','width':'100%','opacity':'1'});
		$('form[name=fsearch2] input[name=s_val]').focus();
	});
	$('.head_menu_m .bx_sch .ly1 .btn_sch2_close').on('click', function(){
		$('form[name=fsearch2] input[name=s_val]').val('');
		$('.head_menu_m .bx_sch .ly1').css({'display':'none','width':'0','opacity':'0'});
		$('.head_menu_m .headlogo .sch_btn a').focus();
	});
	// 메인 > 롤링 > 빅
	$('.main_rollingbig1').bxSlider({
		auto: true,
		speed: 500,
		pause: 4000,
		mode: 'horizontal',
		autoControls: true,
		autoHover: true,
		captions: false,
		keyboardEnabled: true,
		responsive: true
	});
	// 메인 > 최근게시물 > 게시판명탭
	$('.bx_main_late1 .latest1 .btn_sbj').on('click', function(){
		var linkurl_old	= $('.bx_main_late1 .latest1 .more1 .more').attr('href');
		var linkurl_new	= $(this).attr('linkurl');
		if(linkurl_old != linkurl_new){
			$('.bx_main_late1 .latest1 .btn_sbj').removeClass('on');
			$('.bx_main_late1 .latest1 .dta:eq('+$(this).parent().index()+') .btn_sbj').addClass('on');
			$('.bx_main_late1 .latest1 .data').css('display', 'none');
			$('.bx_main_late1 .latest1 .dta:eq('+$(this).parent().index()+') .data').css('display', 'block');
			$('.bx_main_late1 .latest1 .more1 .more').attr('href', linkurl_new);
		}
	});
	// 메인 > 최근게시물 > 갤러리형보기 or 리스트형보기
	$('.bx_main_late1 .dsp_change').on('click', function(){
		var dsp_old	= $('.bx_main_late1 .latest1').attr('class').replace('latest1 ', '');
		var dsp_new	= $(this).attr('dsp');
		if(dsp_old != dsp_new){
			$('.bx_main_late1 .dsp_change').find('img').each(function(){
				$(this).attr('src', $(this).attr('src').replace('_on.', '_off.'));
			});
			var tar_img	= $('.bx_main_late1 .more1 li:eq('+$(this).parent().index()+') .dsp_change img');
			tar_img.attr('src', tar_img.attr('src').replace('_off.', '_on.'));
			if(dsp_old == 'dsp_g1'){
				$('.bx_main_late1 .latest1').removeClass('dsp_g1');
				$('.bx_main_late1 .latest1').addClass('dsp_b1');
			}
			else{
				$('.bx_main_late1 .latest1').removeClass('dsp_b1');
				$('.bx_main_late1 .latest1').addClass('dsp_g1');
			}
		}
	});
	// 온라인통합예약시스템
	$('.bx_main_late1b .main_addm1').html($('.bx_main_late1 .main_addm1').html());
	// 안전무사고현황판 > 리사이징
	function fn_popz1(){
		var win_w	= $(window).innerWidth();
		$('.resizing_1264_864').each(function(){
			if(win_w <= 1264 && win_w > 864){
				var ofw	= $(this).attr('osize_w');  // 원본width
				var ofh	= $(this).attr('osize_h');  // 원본height
				var dfw = $(this).width();   // 현재width
				var fpe = Math.round(dfw / ofw * 100);  // 비율
				var nfh	= Math.ceil(ofh / (100 / fpe)); // 최종height
				$(this).css('height', nfh+'px');
			}
			else{
				$(this).css('height', 'auto');
			}
		});
	}
	fn_popz1();
	$(window).on('resize', function() {
		fn_popz1();
	});
	// 메인 > 롤링 > 팝업존
	$('.main_rollingpopz1').bxSlider({
		auto: true,
		speed: 500,
		pause: 4000,
		mode: 'horizontal',
		autoControls: true,
		autoHover: true,
		captions: false,
	});
	// 메인 > 시설안내
	function fn_main_sisul(){
		//var win_w	= $(window).innerWidth();
		$('.main_sisul .menu1 .dp1').each(function(){
			if($(this).attr('class').indexOf('on') > -1){
				var objh = $('.main_sisul .menu1 .dp1:eq('+$(this).parent().index()+') .dta1').outerHeight() + 52;
				$('.main_sisul .ly1').css('height', objh+'px');
				$('.main_sisul').css('height', objh+'px');
				return false;
			}
		});
	}
	fn_main_sisul();
	$(window).on('resize', function(){
		fn_main_sisul();
	});
	$('.main_sisul .menu1 .dp1 .tab1').on('click', function(){
		$('.main_sisul .menu1 .dp1').removeClass('on');
		$('.main_sisul .menu1 .dp1 .dta1').css('display', 'none');

		$('.main_sisul .menu1 .dp1:eq('+$(this).parent().index()+')').addClass('on');
		$('.main_sisul .menu1 .dp1:eq('+$(this).parent().index()+') .dta1').css('display', 'block');

		var objh	= $('.main_sisul .menu1 .dp1:eq('+$(this).parent().index()+') .dta1').outerHeight() + 52;
		$('.main_sisul .ly1').css('height', objh+'px');
		$('.main_sisul').css('height', objh+'px');
	});
	// 메인 > 롤링 > 배너모음 > 반응형사이즈별출력개수처리
	function fn_resizing_rollingsite1(){
		var hostIndex = location.href.indexOf(location.host)+location.host.length;
		var contextPath = location.href.substring(hostIndex, location.href.indexOf('/',hostIndex+1));
		var win_w	= $(window).innerWidth();
		var htmls	= '';
		if(win_w >= 1200){
			htmls	+= "<li class='dp2'>";
			htmls	+= "	<dl>";
			htmls	+= "		<dd><a href='http://www.jungnang.go.kr' target='_blank'><img src='"+contextPath+"/resource/images/main/bn_rollingsite1_01.png' alt='배너명'></a></dd>";
			htmls	+= "		<dd><a href='http://www.jungnang.go.kr' target='_blank'><img src='"+contextPath+"/resource/images/main/bn_rollingsite1_02.png' alt='배너명'></a></dd>";
			htmls	+= "		<dd><a href='http://www.jungnang.go.kr' target='_blank'><img src='"+contextPath+"/resource/images/main/bn_rollingsite1_03.png' alt='배너명'></a></dd>";
			htmls	+= "		<dd><a href='http://www.jungnang.go.kr' target='_blank'><img src='"+contextPath+"/resource/images/main/bn_rollingsite1_04.png' alt='배너명'></a></dd>";
			htmls	+= "		<dd><a href='http://www.jungnang.go.kr' target='_blank'><img src='"+contextPath+"/resource/images/main/bn_rollingsite1_05.png' alt='배너명'></a></dd>";
			htmls	+= "	</dl>";
			htmls	+= "</li>";
			htmls	+= "<li class='dp2'>";
			htmls	+= "	<dl>";
			htmls	+= "		<dd><a href='http://www.jungnang.go.kr' target='_blank'><img src='"+contextPath+"/resource/images/main/bn_rollingsite1_06.png' alt='배너명'></a></dd>";
			htmls	+= "		<dd><a href='http://www.jungnang.go.kr' target='_blank'><img src='"+contextPath+"/resource/images/main/bn_rollingsite1_07.png' alt='배너명'></a></dd>";
			htmls	+= "		<dd><a href='http://www.jungnang.go.kr' target='_blank'><img src='"+contextPath+"/resource/images/main/bn_rollingsite1_08.png' alt='배너명'></a></dd>";
			htmls	+= "		<dd><a href='http://www.jungnang.go.kr' target='_blank'><img src='"+contextPath+"/resource/images/main/bn_rollingsite1_09.png' alt='배너명'></a></dd>";
			htmls	+= "		<dd><a href='http://www.jungnang.go.kr' target='_blank'><img src='"+contextPath+"/resource/images/main/bn_rollingsite1_10.png' alt='배너명'></a></dd>";
			htmls	+= "	</dl>";
			htmls	+= "</li>";
		}
		else if(win_w >= 920){
			htmls	+= "<li class='dp2'>";
			htmls	+= "	<dl>";
			htmls	+= "		<dd><a href='http://www.jungnang.go.kr' target='_blank'><img src='"+contextPath+"/resource/images/main/bn_rollingsite1_01.png' alt='배너명'></a></dd>";
			htmls	+= "		<dd><a href='http://www.jungnang.go.kr' target='_blank'><img src='"+contextPath+"/resource/images/main/bn_rollingsite1_02.png' alt='배너명'></a></dd>";
			htmls	+= "		<dd><a href='http://www.jungnang.go.kr' target='_blank'><img src='"+contextPath+"/resource/images/main/bn_rollingsite1_03.png' alt='배너명'></a></dd>";
			htmls	+= "		<dd><a href='http://www.jungnang.go.kr' target='_blank'><img src='"+contextPath+"/resource/images/main/bn_rollingsite1_04.png' alt='배너명'></a></dd>";
			htmls	+= "	</dl>";
			htmls	+= "</li>";
			htmls	+= "<li class='dp2'>";
			htmls	+= "	<dl>";
			htmls	+= "		<dd><a href='http://www.jungnang.go.kr' target='_blank'><img src='"+contextPath+"/resource/images/main/bn_rollingsite1_05.png' alt='배너명'></a></dd>";
			htmls	+= "		<dd><a href='http://www.jungnang.go.kr' target='_blank'><img src='"+contextPath+"/resource/images/main/bn_rollingsite1_06.png' alt='배너명'></a></dd>";
			htmls	+= "		<dd><a href='http://www.jungnang.go.kr' target='_blank'><img src='"+contextPath+"/resource/images/main/bn_rollingsite1_07.png' alt='배너명'></a></dd>";
			htmls	+= "		<dd><a href='http://www.jungnang.go.kr' target='_blank'><img src='"+contextPath+"/resource/images/main/bn_rollingsite1_08.png' alt='배너명'></a></dd>";
			htmls	+= "	</dl>";
			htmls	+= "</li>";
			htmls	+= "<li class='dp2'>";
			htmls	+= "	<dl>";
			htmls	+= "		<dd><a href='http://www.jungnang.go.kr' target='_blank'><img src='"+contextPath+"/resource/images/main/bn_rollingsite1_09.png' alt='배너명'></a></dd>";
			htmls	+= "		<dd><a href='http://www.jungnang.go.kr' target='_blank'><img src='"+contextPath+"/resource/images/main/bn_rollingsite1_10.png' alt='배너명'></a></dd>";
			htmls	+= "	</dl>";
			htmls	+= "</li>";
		}
		else if(win_w >= 740){
			htmls	+= "<li class='dp2'>";
			htmls	+= "	<dl>";
			htmls	+= "		<dd><a href='http://www.jungnang.go.kr' target='_blank'><img src='"+contextPath+"/resource/images/main/bn_rollingsite1_01.png' alt='배너명'></a></dd>";
			htmls	+= "		<dd><a href='http://www.jungnang.go.kr' target='_blank'><img src='"+contextPath+"/resource/images/main/bn_rollingsite1_02.png' alt='배너명'></a></dd>";
			htmls	+= "		<dd><a href='http://www.jungnang.go.kr' target='_blank'><img src='"+contextPath+"/resource/images/main/bn_rollingsite1_03.png' alt='배너명'></a></dd>";
			htmls	+= "	</dl>";
			htmls	+= "</li>";
			htmls	+= "<li class='dp2'>";
			htmls	+= "	<dl>";
			htmls	+= "		<dd><a href='http://www.jungnang.go.kr' target='_blank'><img src='"+contextPath+"/resource/images/main/bn_rollingsite1_04.png' alt='배너명'></a></dd>";
			htmls	+= "		<dd><a href='http://www.jungnang.go.kr' target='_blank'><img src='"+contextPath+"/resource/images/main/bn_rollingsite1_05.png' alt='배너명'></a></dd>";
			htmls	+= "		<dd><a href='http://www.jungnang.go.kr' target='_blank'><img src='"+contextPath+"/resource/images/main/bn_rollingsite1_06.png' alt='배너명'></a></dd>";
			htmls	+= "	</dl>";
			htmls	+= "</li>";
			htmls	+= "<li class='dp2'>";
			htmls	+= "	<dl>";
			htmls	+= "		<dd><a href='http://www.jungnang.go.kr' target='_blank'><img src='"+contextPath+"/resource/images/main/bn_rollingsite1_07.png' alt='배너명'></a></dd>";
			htmls	+= "		<dd><a href='http://www.jungnang.go.kr' target='_blank'><img src='"+contextPath+"/resource/images/main/bn_rollingsite1_08.png' alt='배너명'></a></dd>";
			htmls	+= "		<dd><a href='http://www.jungnang.go.kr' target='_blank'><img src='"+contextPath+"/resource/images/main/bn_rollingsite1_09.png' alt='배너명'></a></dd>";
			htmls	+= "	</dl>";
			htmls	+= "</li>";
			htmls	+= "<li class='dp2'>";
			htmls	+= "	<dl>";
			htmls	+= "		<dd><a href='http://www.jungnang.go.kr' target='_blank'><img src='"+contextPath+"/resource/images/main/bn_rollingsite1_10.png' alt='배너명'></a></dd>";
			htmls	+= "	</dl>";
			htmls	+= "</li>";
		}
		else if(win_w >= 550){
			htmls	+= "<li class='dp2'>";
			htmls	+= "	<dl>";
			htmls	+= "		<dd><a href='http://www.jungnang.go.kr' target='_blank'><img src='"+contextPath+"/resource/images/main/bn_rollingsite1_01.png' alt='배너명'></a></dd>";
			htmls	+= "		<dd><a href='http://www.jungnang.go.kr' target='_blank'><img src='"+contextPath+"/resource/images/main/bn_rollingsite1_02.png' alt='배너명'></a></dd>";
			htmls	+= "	</dl>";
			htmls	+= "</li>";
			htmls	+= "<li class='dp2'>";
			htmls	+= "	<dl>";
			htmls	+= "		<dd><a href='http://www.jungnang.go.kr' target='_blank'><img src='"+contextPath+"/resource/images/main/bn_rollingsite1_03.png' alt='배너명'></a></dd>";
			htmls	+= "		<dd><a href='http://www.jungnang.go.kr' target='_blank'><img src='"+contextPath+"/resource/images/main/bn_rollingsite1_04.png' alt='배너명'></a></dd>";
			htmls	+= "	</dl>";
			htmls	+= "</li>";
			htmls	+= "<li class='dp2'>";
			htmls	+= "	<dl>";
			htmls	+= "		<dd><a href='http://www.jungnang.go.kr' target='_blank'><img src='"+contextPath+"/resource/images/main/bn_rollingsite1_05.png' alt='배너명'></a></dd>";
			htmls	+= "		<dd><a href='http://www.jungnang.go.kr' target='_blank'><img src='"+contextPath+"/resource/images/main/bn_rollingsite1_06.png' alt='배너명'></a></dd>";
			htmls	+= "	</dl>";
			htmls	+= "</li>";
			htmls	+= "<li class='dp2'>";
			htmls	+= "	<dl>";
			htmls	+= "		<dd><a href='http://www.jungnang.go.kr' target='_blank'><img src='"+contextPath+"/resource/images/main/bn_rollingsite1_07.png' alt='배너명'></a></dd>";
			htmls	+= "		<dd><a href='http://www.jungnang.go.kr' target='_blank'><img src='"+contextPath+"/resource/images/main/bn_rollingsite1_08.png' alt='배너명'></a></dd>";
			htmls	+= "	</dl>";
			htmls	+= "</li>";
			htmls	+= "<li class='dp2'>";
			htmls	+= "	<dl>";
			htmls	+= "		<dd><a href='http://www.jungnang.go.kr' target='_blank'><img src='"+contextPath+"/resource/images/main/bn_rollingsite1_09.png' alt='배너명'></a></dd>";
			htmls	+= "		<dd><a href='http://www.jungnang.go.kr' target='_blank'><img src='"+contextPath+"/resource/images/main/bn_rollingsite1_10.png' alt='배너명'></a></dd>";
			htmls	+= "	</dl>";
			htmls	+= "</li>";
		}
		else{
			htmls	+= "<li class='dp2'>";
			htmls	+= "	<dl>";
			htmls	+= "		<dd><a href='http://www.jungnang.go.kr' target='_blank'><img src='"+contextPath+"/resource/images/main/bn_rollingsite1_01.png' alt='배너명'></a></dd>";
			htmls	+= "	</dl>";
			htmls	+= "</li>";
			htmls	+= "<li class='dp2'>";
			htmls	+= "	<dl>";
			htmls	+= "		<dd><a href='http://www.jungnang.go.kr' target='_blank'><img src='"+contextPath+"/resource/images/main/bn_rollingsite1_02.png' alt='배너명'></a></dd>";
			htmls	+= "	</dl>";
			htmls	+= "</li>";
			htmls	+= "<li class='dp2'>";
			htmls	+= "	<dl>";
			htmls	+= "		<dd><a href='http://www.jungnang.go.kr' target='_blank'><img src='"+contextPath+"/resource/images/main/bn_rollingsite1_03.png' alt='배너명'></a></dd>";
			htmls	+= "	</dl>";
			htmls	+= "</li>";
			htmls	+= "<li class='dp2'>";
			htmls	+= "	<dl>";
			htmls	+= "		<dd><a href='http://www.jungnang.go.kr' target='_blank'><img src='"+contextPath+"/resource/images/main/bn_rollingsite1_04.png' alt='배너명'></a></dd>";
			htmls	+= "	</dl>";
			htmls	+= "</li>";
			htmls	+= "<li class='dp2'>";
			htmls	+= "	<dl>";
			htmls	+= "		<dd><a href='http://www.jungnang.go.kr' target='_blank'><img src='"+contextPath+"/resource/images/main/bn_rollingsite1_05.png' alt='배너명'></a></dd>";
			htmls	+= "	</dl>";
			htmls	+= "</li>";
			htmls	+= "<li class='dp2'>";
			htmls	+= "	<dl>";
			htmls	+= "		<dd><a href='http://www.jungnang.go.kr' target='_blank'><img src='"+contextPath+"/resource/images/main/bn_rollingsite1_06.png' alt='배너명'></a></dd>";
			htmls	+= "	</dl>";
			htmls	+= "</li>";
			htmls	+= "<li class='dp2'>";
			htmls	+= "	<dl>";
			htmls	+= "		<dd><a href='http://www.jungnang.go.kr' target='_blank'><img src='"+contextPath+"/resource/images/main/bn_rollingsite1_07.png' alt='배너명'></a></dd>";
			htmls	+= "	</dl>";
			htmls	+= "</li>";
			htmls	+= "<li class='dp2'>";
			htmls	+= "	<dl>";
			htmls	+= "		<dd><a href='http://www.jungnang.go.kr' target='_blank'><img src='"+contextPath+"/resource/images/main/bn_rollingsite1_08.png' alt='배너명'></a></dd>";
			htmls	+= "	</dl>";
			htmls	+= "</li>";
			htmls	+= "<li class='dp2'>";
			htmls	+= "	<dl>";
			htmls	+= "		<dd><a href='http://www.jungnang.go.kr' target='_blank'><img src='"+contextPath+"/resource/images/main/bn_rollingsite1_09.png' alt='배너명'></a></dd>";
			htmls	+= "	</dl>";
			htmls	+= "</li>";
			htmls	+= "<li class='dp2'>";
			htmls	+= "	<dl>";
			htmls	+= "		<dd><a href='http://www.jungnang.go.kr' target='_blank'><img src='"+contextPath+"/resource/images/main/bn_rollingsite1_10.png' alt='배너명'></a></dd>";
			htmls	+= "	</dl>";
			htmls	+= "</li>";
		}
		$('.rollingsite1 ul.bx1').html(htmls);
	}
	fn_resizing_rollingsite1();
	$(window).on('resize', function() {
		fn_resizing_rollingsite1();
	});
	// 메인 > 롤링 > 배너모음
	$('.rollingsite1 ul.bx1').carouFredSel({
		items : 1,
		scroll : {
			items : 1, // 롤링넘어가는갯수
			duration : 500, // 롤링속도
			pauseOnHover : true // 마우스 오버시 롤링멈춤 true, 롤링작동 false
		},
		prev : '#btn_main_rollingsite1_prev', // 왼쪽으로 이동 버튼
		next : '#btn_main_rollingsite1_next', // 오른쪽으로 이동 버튼
		responsive : false,
		direction : 'up' // 롤링 방향
	});
	$('#btn_main_rollingsite1_stop').on('click', function(){
		$('.rollingsite1 ul.bx1').trigger('pause');
		$('.main_rollingsite1 .sc1 .btn_control li.stop').css('display', 'none');
		$('.main_rollingsite1 .sc1 .btn_control li.play').css('display', 'block');
	});
	$('#btn_main_rollingsite1_play').on('click', function(){
		$('.rollingsite1 ul.bx1').trigger('play');
		$('.main_rollingsite1 .sc1 .btn_control li.stop').css('display', 'block');
		$('.main_rollingsite1 .sc1 .btn_control li.play').css('display', 'none');
	});
	$('.rollingsite1 ul.bx1 a').on('focus', function(){
		$('.rollingsite1 ul.bx1').trigger('pause');
		$('.main_rollingsite1 .sc1 .btn_control li.stop').css('display', 'none');
		$('.main_rollingsite1 .sc1 .btn_control li.play').css('display', 'block');
	});
	$('.rollingsite1 ul.bx1 a').on('blur', function(){
		$('.rollingsite1 ul.bx1').trigger('play');
		$('.main_rollingsite1 .sc1 .btn_control li.stop').css('display', 'block');
		$('.main_rollingsite1 .sc1 .btn_control li.play').css('display', 'none');
	});
	$('#btn_main_rollingsite1_prev, #btn_main_rollingsite1_next').on('click', function(){
		$('.rollingsite1 ul.bx1').trigger('play');
		$('.main_rollingsite1 .sc1 .btn_control li.stop').css('display', 'block');
		$('.main_rollingsite1 .sc1 .btn_control li.play').css('display', 'none');
	});
	// 푸터 > 관련사이트 바로가기
	$('.foot_sc1 .dp1 .site1 .btn_toggle').on('click', function(){
		var tar	= $('.foot_sc1 .dp1 .site1 .data');
		tar.css('height', tar.outerHeight()+'px');
		tar.slideToggle(300);
	});
});
