<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.List"%>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
          
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/assets/plugins/slick/slick.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/assets/plugins/jquery-ui-1.12.1/jquery-ui.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/assets/css/main.css"> 


	<script	src="${pageContext.request.contextPath}/resource/assets/plugins/jquery/jquery.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resource/axisj/dist/AXJ.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resource/axisj/lib/AXUtil.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resource/axisj/lib/AXValidator.js"></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resource/axisj/ui/AXJ.min.css"/>

	<title>한국장기조직기증원</title>
	
<script type="text/javascript">
function fn_MovePage(url) {
	document.location.href = url; 
}

function fn_MoveUrl(menuCd,seqCd1,seqCd2,action) {
	
	if (action != undefined && action != ""){
		if (action.indexOf(".c") != -1 ){
			$("#frm_url").clearForm();
			$("#menuCd").val(menuCd);
			$("#seqCd1").val(seqCd1);
			$("#seqCd2").val(seqCd2);
			$("#frm_url").attr("action", action);
		}else{
			$("#menuCd").val(menuCd);
			$("#seqCd1").val(seqCd1);
			$("#seqCd2").val(seqCd2);
			$("#frm_url").attr("action", "/main/contents.c");
		}
	}else{
		$("#menuCd").val(menuCd);
		$("#seqCd1").val(seqCd1);
		$("#seqCd2").val(seqCd2);
		$("#frm_url").attr("action", "/main/contents.c");
	}
	
	$("#frm_url").submit();
}

$.fn.clearForm = function () {
	  return this.each(function () {
	    var type = this.type,
	      tag = this.tagName.toLowerCase();
	    if (tag === 'form') {
	      return $(':input', this).clearForm();
	    }
	    if (
	      type === 'text' ||
	      type === 'password' ||
	      type === 'hidden' ||
	      tag === 'textarea'
	    ) {
	      this.value = '';
	    } else if (type === 'checkbox' || type === 'radio') {
	      this.checked = false;
	    } else if (tag === 'select') {
	      this.selectedIndex = -1;
	    }
	  });
	};

</script>

<sitemesh:write property="head" />

</head>
<body>
	<div class="wrapper">				 
		<div class="topMessage">
		    <div class="wrap flex items-center">
		        <div class="logo">
		            <img src="${pageContext.request.contextPath}/resource/assets/images/header-message-logo.png" alt="">
		        </div>
		        <Marquee class="text font-myeongjo">
		            “지금 우리의 헤어짐이 영원한 이별이 아닌 잠시 동안 작별이라 생각하고 그리움은 간직하겠지만 슬픔은 잊어볼게 언니야 사랑해”..........
		        </Marquee>
		        <span class="author font-myeongjo">추모자 : 한**</span>
		    </div>
		</div>		
		<header class="header">
			<div class="header__top">
				<div class="wrap flex items-center">
					<h1 class="header__logo">
						<a href="javascript:fn_MovePage('/main.c')"><img
							src="${pageContext.request.contextPath}/resource/assets/images/logo.png"
							alt="한국장기조직기증원" /></a>
					</h1>
					<form action="" class="searchform">
						<div class="search">
							<input type="text" placeholder="검색어를 입력해주세요.">
							<button type="submit" class="btn">검색</button>
						</div>
					</form>
					<div class="header__etc">
						<a href="javascript:fn_MoveUrl('8','1','0')"> <span>의료진 페이지</span>
						</a>
					</div>
					<div class="header__sns">
						<a href="https://www.instagram.com/koda1458/" target="_blank" class="insta" title="인스타그램">인스타그램</a>
						<a href="https://www.facebook.com/koda1458/" target="_blank" class="facebook" title="페이스북">페이스북</a>
						<a href="https://blog.naver.com/koda1458" target="_blank" class="blog" title="블로그">블로그</a>
						<a href="https://www.youtube.com/channel/UCbhsMbBEOm1vIpOZXbaZR7g" target="_blank" class="youtube" title="유튜브">유튜브</a>
					</div>
					<button class="mobile-search-button">검색</button>
					<button class="mobile-gnb-button">메뉴</button>
				</div>
			</div>
			<nav class="header__nav">
				<div class="wrap flex items-center">
					<div class="navlist flex-1">
						<div class="navlist__item">
							<a href="#" class="navlist__link">장기조직기증</a>
							<div class="navlist__depth">
								<div class="wrap flex">
									<div class="depth-name">
										<h2>장기조직 기증</h2>
										<p>
											누군가의 끝이 아니라<br /> 누군가의 시작
										</p>
									</div>
									<div class="depth-links">
										<div class="depth-links-item">
											<a href="javascript:fn_MoveUrl('1','1','0')">장기·조직 기증</a>
										</div>
										<div class="depth-links-item">
											<a href="javascript:fn_MoveUrl('1','2','1')" class="link">장기·조직 기증이란</a>
											<div class="depth-links-inner">
												<a href="javascript:fn_MoveUrl('1','2','1')">생명나눔이란 무엇인가요?</a>
												 <a href="javascript:fn_MoveUrl('1','2','2')">기증은 왜 필요한가요?</a> 
												 <a href="javascript:fn_MoveUrl('1','2','3')">기증은 언제 이루어지나요?</a>
												 <a href="javascript:fn_MoveUrl('1','2','4')">장기기증</a>
												 <a href="javascript:fn_MoveUrl('1','2','5')">조직기증</a>
												 <a href="javascript:fn_MoveUrl('1','2','6')">한 눈에 보는 기증 흐름도</a>
											</div>
										</div>
										<div class="depth-links-item">
											<a href="javascript:fn_MoveUrl('1','3','0','/organ/organ_fact.c')">기증팩트체크</a>
										</div>
										<div class="depth-links-item">
											<a href="javascript:fn_MoveUrl('1','4','0')">KODA코디네이터</a>
										</div>
										<div class="depth-links-item">
											<a href="javascript:fn_MoveUrl('1','5','0')">기증용어 설명</a>
										</div>
										<div class="depth-links-item">
											<a href="javascript:fn_MoveUrl('1','6','1','/organ/organ_agree1.c')" class="link"> 협약병원</a>
											<div class="depth-links-inner">
												<a href="javascript:fn_MoveUrl('1','6','1','/organ/organ_agree1.c')">뇌사장기기증자 관리업무협약</a>
												<a href="javascript:fn_MoveUrl('1','6','2','/organ/organ_agree2.c')">DIP 협약병원</a>
												<!-- <a href="javascript:fn_MoveUrl('1','6','3')">검사실 협약</a> -->
											</div>
										</div>
									</div>
									<div class="depth-etc">
										<a href=""> <img
											src="${pageContext.request.contextPath}/resource/assets/images/navlist-link1.png"
											alt="">
											<p>기증희망등록</p>
										</a> <a href=""> <img
											src="${pageContext.request.contextPath}/resource/assets/images/navlist-link2.png"
											alt="">
											<p>하늘나라편지</p>
										</a> <a href=""> <img
											src="${pageContext.request.contextPath}/resource/assets/images/navlist-link3.png"
											alt="">
											<p>소식지신청</p>
										</a>
									</div>
								</div>
							</div>
						</div>
						<div class="navlist__item">
							<a href="javascript:fn_MoveUrl('2','1','0','/donate/member.c')" class="navlist__link">기증자예우</a>
						</div>
						<div class="navlist__item">
							<a href="javascript:fn_MovePage('/let/letterMain.l');" class="navlist__link">생명나눔우체통</a>
						</div>
						<div class="navlist__item">
							<a href="javascript:fn_MoveUrl('4','1','0')" class="navlist__link">기증희망등록</a>
						</div>
						<div class="navlist__item">
							<a href="javascript:fn_MoveUrl('5','1','1','/pr/annual.c')" class="navlist__link">홍보·소식</a>
						</div>
						<div class="navlist__item">
							<a href="javascript:fn_MoveUrl('6','1','1')" class="navlist__link">정보공개</a>
						</div>
						<div class="navlist__item">
							<a href="javascript:fn_MoveUrl('7','1','0')" class="navlist__link">KODA</a>
						</div>
					</div>
					<button class="sitemap-btn">전체보기</button>
				</div>
			</nav>
		</header>

		<div class="sitemap">
			<div class="wrap">
				<div class="sitemap__header">
					<div class="logo">
						<a href="javascript:fn_MovePage('/main');"><img
							src="${pageContext.request.contextPath}/resource/assets/images/logo.png"
							alt="한국장기조직기증원"></a>
					</div>
					<button class="btn">닫기</button>
				</div>
				<div class="sitemap__body">
					<div class="col">
						<h3 class="col__title">
							<a href="#">장기조직 기증</a>
						</h3>
						<div class="col__list">
							<div class="col__item">
								<a href="javascript:fn_MoveUrl('1','1','0')">장기·조직 기증</a>
							</div>
							<div class="col__item">
								<a href="javascript:fn_MoveUrl('1','2','1')">장기·조직 기증이란</a>
								<div class="col__depth">
									<a href="javascript:fn_MoveUrl('1','2','1')">생명나눔이란 무엇인가요?</a>
									<a href="javascript:fn_MoveUrl('1','2','2')">기증은 왜 필요한가요?</a>
									<a href="javascript:fn_MoveUrl('1','2','3')">기증은 언제 이루어지나요?</a>
									<a href="javascript:fn_MoveUrl('1','2','4')">장기기증</a> 
									<a href="javascript:fn_MoveUrl('1','2','5')">조직기증</a>
									<a href="javascript:fn_MoveUrl('1','2','6')">한 눈에 보는 기증 흐름도</a>
								</div>
							</div>
							<div class="col__item">
								<a href="javascript:fn_MoveUrl('1','3','0','/organ/organ_fact.c')">기증팩트체크</a>
							</div>
							<div class="col__item">
								<a href="javascript:fn_MoveUrl('1','4','0')">KODA코디네이터</a>
							</div>
							<div class="col__item">
								<a href="javascript:fn_MoveUrl('1','5','0')">기증용어 설명</a>
							</div>
							<div class="col__item">
								<a href="javascript:fn_MoveUrl('1','6','1','/organ/organ_agree1.c')">협약병원</a>
								<div class="col__depth">
									<a href="javascript:fn_MoveUrl('1','6','1','/organ/organ_agree1.c')">뇌사장기기증자 관리업무협약</a>
									<a href="javascript:fn_MoveUrl('1','6','2','/organ/organ_agree2.c')">DIP 협약병원</a>
									<!-- <a href="javascript:fn_MoveUrl('1','6','3')">검사실 협약</a> -->
								</div>
							</div>
						</div>
					</div>

					<div class="col">
						<h3 class="col__title">
							<a href="#">기증자 예우</a>
						</h3>
						<div class="col__list">
							<div class="col__item">
								<a href="javascript:fn_MoveUrl('2','1','0','/donate/member.c')">가족지원 및 예우</a>
								<div class="col__depth">
									<a href="javascript:fn_MoveUrl('2','1','0','/donate/member.c')">기증자 추모관</a>
									<a href="javascript:fn_MoveUrl('2','2','0','/donate/letter.c')">하늘나라 편지</a> 
									<a href="javascript:fn_MoveUrl('2','3','0','/donate/receipt.c')">수혜자	편지</a>
									<a href="javascript:fn_MoveUrl('2','4','0','/donate/story.c')">기증 후 스토리</a>
									<a href="javascript:fn_MoveUrl('2','5','0')">기증자 추모 및 가족행사</a>
								</div>
							</div>
						</div>
					</div>

					<div class="col">
						<h3 class="col__title">
							<a href="#">생명나눔 우체통</a>
						</h3>
						<div class="col__list">
							<div class="col__item">
								<a href="javascript:fn_MovePage('/let/letterMain.l');">생명나눔 우체통</a>
							</div>
						</div>
					</div>

					<div class="col">
						<h3 class="col__title">
							<a href="#">기증희망등록</a>
						</h3>
						<div class="col__list">
							<div class="col__item">
								<a href="javascript:fn_MoveUrl('4','1','0')">기증희망등록</a>
							</div>
						</div>
					</div>

					<div class="col">
						<h3 class="col__title">
							<a href="#">홍보·소식</a>
						</h3>
						<div class="col__list">
							<div class="col__item">
								<a href="javascript:fn_MoveUrl('5','1','1','/pr/annual.c')">간행물</a>
								<div class="col__depth">
									<a href="javascript:fn_MoveUrl('5','1','1','/pr/annual.c')">연보</a>
									<a href="javascript:fn_MoveUrl('5','1','2','/pr/news_letter.c')">뉴스레터</a>
									<a href="javascript:fn_MoveUrl('5','1','3','/pr/casebook.c')">사례집</a>
								</div>
							</div>
							<div class="col__item">
								<a href="javascript:fn_MoveUrl('5','2','1','/pr/webcontents.c')">홍보 콘텐츠</a>
								<div class="col__depth">
									<a href="javascript:fn_MoveUrl('5','2','1','/pr/webcontents.c')">웹콘텐츠</a> 
									<a href="javascript:fn_MoveUrl('5','2','2','/pr/lifeSharing.c')">생명나눔 스토리</a>
								</div>
							</div>
							<div class="col__item">
								<a href="javascript:fn_MoveUrl('5','3','0','/pr/movie.c')">영상자료실</a>
							</div>
							<div class="col__item">
								<a href="javascript:fn_MoveUrl('5','4','0','/pr/pressRelease.c')">언론보도</a>
							</div>
							<div class="col__item">
								<a href="javascript:fn_MoveUrl('5','5','1','/pr/notice.c')">기관소식</a>
								<div class="col__depth">
									<a href="javascript:fn_MoveUrl('5','5','1','/pr/notice.c')">공지사항</a>
									<a href="javascript:fn_MoveUrl('5','5','2','/pr/comnews.c')">기관소식</a>
								</div>
							</div>
							<div class="col__item">
								<a href="javascript:fn_MoveUrl('5','6','0')">소통게시판</a>
							</div>
						</div>
					</div>

					<div class="col">
						<h3 class="col__title">
							<a href="#">정보공개</a>
						</h3>
						<div class="col__list">
							<div class="col__item">
								<a href="javascript:fn_MoveUrl('6','1','1')">기증통계</a>
								<div class="col__depth">
									<a href="javascript:fn_MoveUrl('6','1','1')">단계별 기증 현황</a>
									<a href="javascript:fn_MoveUrl('6','1','2','/info/infodonate.c')">기증 현황</a>
									<a href="javascript:fn_MoveUrl('6','1','3','/info/infotrans.c')">이식 현황</a>
									<a href="javascript:fn_MoveUrl('6','1','4','/info/infohope.c')">기증희망등록 현황</a>
								</div>
							</div>
							<div class="col__item">
								<a href="javascript:fn_MoveUrl('6','2','1')">정보공개</a>
								<div class="col__depth">
									<a href="javascript:fn_MoveUrl('6','2','1')">정보공개제도 안내·청구</a>
									<a href="javascript:fn_MoveUrl('6','2','2','/info/infobefore.c')">사전정보 공표</a>
									<a href="javascript:fn_MoveUrl('6','2','3')">사업실명제</a>
									<a href="javascript:fn_MoveUrl('6','2','4')">경영공시</a>
									<a href="javascript:fn_MoveUrl('6','2','5','/info/infodata.c')">공공데이터 개방</a>
								</div>
							</div>
							<div class="col__item">
								<a href="javascript:fn_MoveUrl('6','3','1')">자료실</a>
								<div class="col__depth">
									<a href="javascript:fn_MoveUrl('6','3','1','/info/infolaw.c')">법률·학술자료</a>
									<a href="javascript:fn_MoveUrl('6','3','2')">교육자료</a>
								</div>
							</div>
						</div>
					</div>

					<div class="col">
						<h3 class="col__title">
							<a href="#">KODA</a>
						</h3>
						<div class="col__list">
							<div class="col__item">
								<a href="javascript:fn_MoveUrl('7','1','0')">기증원소개</a>
							</div>
							<div class="col__item">
								<a href="javascript:fn_MoveUrl('7','2','0')">인사말</a>
							</div>
							<div class="col__item">
								<a href="javascript:fn_MoveUrl('7','3','0')">비전·역할</a>
							</div>
							<div class="col__item">
								<a href="javascript:fn_MoveUrl('7','4','0')">연혁</a>
							</div>
							<div class="col__item">
								<a href="javascript:fn_MoveUrl('7','5','0')">KODA 인재채용</a>
							</div>
							<div class="col__item">
								<a href="javascript:fn_MoveUrl('7','6','0')">CI소개 및 캐릭터</a>
							</div>
							<div class="col__item">
								<a href="javascript:fn_MoveUrl('7','7','0')">인권경영</a>
							</div>
							<div class="col__item">
								<a href="javascript:fn_MoveUrl('7','8','0')">적극행정</a>
							</div>
							<div class="col__item">
								<a href="javascript:fn_MoveUrl('7','9','0')">조직안내</a>
							</div>
							<div class="col__item">
								<a href="javascript:fn_MoveUrl('7','10','0')">협약기관</a>
							</div>
							<div class="col__item">
								<a href="javascript:fn_MoveUrl('7','11','0')">오시는 길</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="mobile-gnb">
			<div class="mobile-gnb__header">
				<a href="javascript:fn_MoveUrl('8','1','0')" class="member">의료진 페이지</a>
				<div class="sns">
					<a href="" class="insta">인스타그램</a> <a href="" class="facebook">페이스북</a>
					<a href="" class="blog">블로그</a> <a href="" class="youtube">유트브</a>
				</div>
				<button class="close">닫기</button>
			</div>

			<div class="mobile-gnb__body">
				<div class="col">
					<h3 class="col__title">
						<a href="">장기조직 기증</a>
					</h3>
					<div class="col__list">
						<div class="col__item">
							<a href="javascript:fn_MoveUrl('1','1','0')">장기·조직 기증</a>
						</div>
						<div class="col__item">
							<a href="javascript:fn_MoveUrl('1','2','1')">장기·조직 기증이란</a>
						</div>
						<div class="col__item">
							<a href="javascript:fn_MoveUrl('1','3','0','/organ/organ_fact.c')">기증팩트체크</a>
						</div>
						<div class="col__item">
							<a href="javascript:fn_MoveUrl('1','4','0')">KODA코디네이터</a>
						</div>
						<div class="col__item">
							<a href="javascript:fn_MoveUrl('1','5','0')">기증용어 설명</a>
						</div>
						<div class="col__item">
							<a href="javascript:fn_MoveUrl('1','6','1','/organ/organ_agree1.c')">협약병원</a>
						</div>
					</div>
				</div>

				<div class="col">
					<h3 class="col__title">
						<a href="#">기증자 예우</a>
					</h3>
					<div class="col__list">
						<div class="col__item">
							<a href="javascript:fn_MoveUrl('2','1','0','/donate/member.c')">가족지원 및 예우</a>
						</div>
					</div>
				</div>

				<div class="col">
					<h3 class="col__title">
						<a href="">생명나눔 우체통</a>
					</h3>
					<div class="col__list">
						<div class="col__item">
							<a href="javascript:fn_MovePage('/let/letterMain.l');">생명나눔 우체통</a>
						</div>
					</div>
				</div>

				<div class="col">
					<h3 class="col__title">
						<a href="">기증희망등록</a>
					</h3>
					<div class="col__list">
						<div class="col__item">
							<a href="javascript:fn_MoveUrl('4','1','0')">기증희망등록</a>
						</div>
					</div>
				</div>

				<div class="col">
					<h3 class="col__title">
						<a href="">홍보·소식</a>
					</h3>
					<div class="col__list">
						<div class="col__item">
							<a href="javascript:fn_MoveUrl('5','1','1','/pr/annual.c')">간행물</a>
						</div>
						<div class="col__item">
							<a href="javascript:fn_MoveUrl('5','2','1','/pr/webcontents.c')">홍보 콘텐츠</a>
						</div>
						<div class="col__item">
							<a href="javascript:fn_MoveUrl('5','3','0','/pr/movie.c')">영상자료실</a>
						</div>
						<div class="col__item">
							<a href="javascript:fn_MoveUrl('5','4','0','/pr/pressRelease.c')">언론보도</a>
						</div>
						<div class="col__item">
							<a href="javascript:fn_MoveUrl('5','5','1','/pr/notice.c')">기관소식</a>
						</div>
						<div class="col__item">
							<a href="javascript:fn_MoveUrl('5','6','0')">소통게시판</a>
						</div>
					</div>
				</div>

				<div class="col">
					<h3 class="col__title">
						<a href="">정보공개</a>
					</h3>
					<div class="col__list">
						<div class="col__item">
							<a href="javascript:fn_MoveUrl('6','1','1')">기증통계</a>
						</div>
						<div class="col__item">
							<a href="javascript:fn_MoveUrl('6','2','1')">정보공개</a>
						</div>
						<div class="col__item">
							<a href="javascript:fn_MoveUrl('6','3','1','/info/infolaw.c')">자료실</a>
						</div>
					</div>
				</div>

				<div class="col">
					<h3 class="col__title">
						<a href="">KODA</a>
					</h3>
					<div class="col__list">
						<div class="col__item">
							<a href="javascript:fn_MoveUrl('7','1','0')">기증원소개</a>
						</div>
						<div class="col__item">
							<a href="javascript:fn_MoveUrl('7','2','0')">인사말</a>
						</div>
						<div class="col__item">
							<a href="javascript:fn_MoveUrl('7','3','0')">비전·역할</a>
						</div>
						<div class="col__item">
							<a href="javascript:fn_MoveUrl('7','4','0')">연혁</a>
						</div>
						<div class="col__item">
							<a href="javascript:fn_MoveUrl('7','5','0')">KODA 인재채용</a>
						</div>
						<div class="col__item">
							<a href="javascript:fn_MoveUrl('7','6','0')">CI소개 및 캐릭터</a>
						</div>
						<div class="col__item">
							<a href="javascript:fn_MoveUrl('7','7','0')">인권경영</a>
						</div>
						<div class="col__item">
							<a href="javascript:fn_MoveUrl('7','8','0')">적극행정</a>
						</div>
						<div class="col__item">
							<a href="javascript:fn_MoveUrl('7','9','0')">조직안내</a>
						</div>
						<div class="col__item">
							<a href="javascript:fn_MoveUrl('7','10','0')">협약기관</a>
						</div>
						<div class="col__item">
							<a href="javascript:fn_MoveUrl('7','11','0')">오시는 길</a>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="container">			
		<form id="frm_url" method="post" action="/main/contents.c">
			<input type = "hidden" id = "menuCd" name = "menuCd" value ="${menuCd}" />
			<input type = "hidden" id = "seqCd1" name = "seqCd1" value ="${seqCd1}" />
			<input type = "hidden" id = "seqCd2" name = "seqCd2" value ="${seqCd2}" />	
			<c:if test="${!empty menuCd}">
			<div class="sub sub1 <c:if test="${menuCd eq '5'}"> promote</c:if> <c:if test="${menuCd eq '6'}"> information</c:if> <c:if test="${menuCd eq '7'}">company</c:if> <c:if test="${menuCd eq '8'}">medical</c:if>">
			<c:if test="${menuCd eq '1' || menuCd eq '2' || menuCd eq '4'|| menuCd eq '5'|| menuCd eq '6'|| menuCd eq '7'|| menuCd eq '8'}">
				<div class="sub__visual">
					<div class="sub__pagename">
						<div class="wrap">
			                <c:if test="${menuCd eq '1'}">
							<h2>장기·조직 기증</h2>
							<p>누군가의 끝이 아니라 누군가의 시작</p>
			                	<img class="img" src="${pageContext.request.contextPath}/resource/assets/images/sub-visual1.png" alt="">
			                </c:if>
			                <c:if test="${menuCd eq '2'}">
			                <h2>기증자 예우</h2>
			                <p>누군가에게 새로운 생명을 선물한 당신, 잊지않고 기억하겠습니다.</p>
						         <img class="img" src="${pageContext.request.contextPath}/resource/assets/images/sub-visual2.png" alt="">
			                </c:if>
			                <c:if test="${menuCd eq '4'}">
		                    <h2>기증희망등록</h2>
		                    <p>함께해요! 기증희망등록</p>
						         <img class="img" src="${pageContext.request.contextPath}/resource/assets/images/sub-visual4.png" alt="">
			                </c:if>
			                <c:if test="${menuCd eq '5'}">
		                    <h2>홍보·자료</h2>
		                    <p>한국장기조직기증원의 다양한 소식 및 자료</p>
						         <img class="img" src="${pageContext.request.contextPath}/resource/assets/images/sub-visual5.png" alt="">
			                </c:if>
			                <c:if test="${menuCd eq '6'}">
		                    <h2>정보공개</h2>
		                    <p>기증/이식 현황 등을 한눈에 보실 수 있습니다.</p>
						         <img class="img" src="${pageContext.request.contextPath}/resource/assets/images/sub-visual6.png" alt="">
			                </c:if>
			                <c:if test="${menuCd eq '7'}">
		                    <h2>KODA</h2>
		                    <p>장기·조직 기증 활성화를 통한 생명나눔 가치 실현</p>
						         <img class="img" src="${pageContext.request.contextPath}/resource/assets/images/sub-visual7.png" alt="">
			                </c:if>
			                <c:if test="${menuCd eq '8'}">
		                    <h2>의료진 페이지</h2>
		                    <p>의료진 전용 페이지 입니다.</p>
						         <img class="img" src="${pageContext.request.contextPath}/resource/assets/images/sub-visual8.png" alt="">
			                </c:if>
						</div>
					</div>
					<div class="sub__navigation">
						<div class="wrap flex">
							<a href="/" class="home">홈</a>
							<!-- 수정된 서브 셀렉터 -->
							<div class="select">
								<c:forEach items="${mlist}" var="map">
										<c:if test="${map.menuCd == menuCd && map.seqCd1 == seqCd1 && map.seqCd2 == seqCd2}">
											<button>${map.menuNm}</button>
										</c:if>
						        </c:forEach>
								<div class="dropdown">
									<c:forEach items="${mlist}" var="map">
											<c:if test="${map.seqCd1 != 0}">
												<c:choose>
													<c:when test="${map.menuUrl != null && map.menuUrl != '' && map.menuGubun == 'T'}">
							                			<a href="javascript:fn_MoveUrl(${map.menuCd},${map.seqCd1},${map.seqCd2},'${map.menuUrl}')">
							                			<c:if test="${map.seqCd2 != 0  && map.menuGubun == 'T'}">
							                			&nbsp;&nbsp;&nbsp;${map.menuNm}
							                			</c:if>
							                			<c:if test="${map.seqCd2 == 0  && map.menuGubun == 'T'}">
							                			${map.menuNm}
							                			</c:if>
							                			</a>
													</c:when>
													<c:otherwise>
														<c:if test="${map.menuGubun == 'T'}">
							                				<a href="javascript:fn_MoveUrl(${map.menuCd},${map.seqCd1},1,'${map.menuUrl})'">${map.menuNm}</a>
							                			</c:if>
													</c:otherwise>
												</c:choose>
											</c:if>
						            </c:forEach>
								</div>
							</div>
							<!-- // 수정된 서브 셀렉터 -->
							<a href="" class="link">기증희망등록 신청</a>
						</div>
					</div>
				</div>
				</c:if>							
				<div class="sub__content">
					<c:if test="${menuCd eq '1'}">
						<div class="sub__lnb" style="z-index:5">
							<div class="row">
								<a href="javascript:fn_MoveUrl('1','1','0')" id = "110" class="link">장기·조직기증</a>
							</div>
							<div class="row">
								<a href="javascript:fn_MoveUrl('1','2','1')" id = "120" class="link">장기·조직기증이란</a>
								<div class="depth">
									<a href="javascript:fn_MoveUrl('1','2','1')" id = "121" class="depth-link">생명나눔이랑 무언인가요?</a>
									<a href="javascript:fn_MoveUrl('1','2','2')" id = "122" class="depth-link">기증은 왜 필요한가요?</a>
									<a href="javascript:fn_MoveUrl('1','2','3')" id = "123" class="depth-link">기증은 언제 이루어지나요?</a>
									<a href="javascript:fn_MoveUrl('1','2','4')" id = "124" class="depth-link">장기기증</a>
									<a href="javascript:fn_MoveUrl('1','2','5')" id = "125" class="depth-link">조직기증</a>
									<a href="javascript:fn_MoveUrl('1','2','6')" id = "126" class="depth-link">한눈에 보는 기증 흐름도</a>
								</div>
							</div>
							<div class="row">
								<a href="javascript:fn_MoveUrl('1','3','0','/organ/organ_fact.c')" id = "130" class="link">기증팩트체크</a>
							</div>
							<div class="row">
								<a href="javascript:fn_MoveUrl('1','4','0')" id = "140" class="link">KODA코디네이터</a>
							</div>
							<div class="row">
								<a href="javascript:fn_MoveUrl('1','5','0')" id = "150" class="link">기증용어 설명</a>
							</div>
							<div class="row">
								<a href="javascript:fn_MoveUrl('1','6','1','/organ/organ_agree1.c')" id = "160" class="link">협약병원</a>
								<div class="depth">
									<a href="javascript:fn_MoveUrl('1','6','1','/organ/organ_agree1.c')" id = "161" class="depth-link">뇌사장기기증자 관리업무협약</a>
									<a href="javascript:fn_MoveUrl('1','6','2','/organ/organ_agree2.c')" id = "162" class="depth-link">DIP 협약병원</a>
									<!-- <a href="javascript:fn_MoveUrl('1','6','3')" id = "163" class="depth-link">검사실 협약</a> -->
								</div>
							</div>
						</div>
					</c:if>	
					<c:if test="${menuCd eq '2'}">
						<div class="sub__lnb" style="z-index:5">
							<div class="row">
								<a href="javascript:fn_MoveUrl('2','1','0','/donate/member.c')" id = "210" class="link">기증자 추모관</a>
							</div>
							<div class="row">
								<a href="javascript:fn_MoveUrl('2','2','0','/donate/letter.c')" id = "220" class="link">하늘나라 편지</a>
							</div>
							<div class="row">
								<a href="javascript:fn_MoveUrl('2','3','0','/donate/receipt.c')" id = "230" class="link">수혜자 편지</a>
							</div>
							<div class="row">
								<a href="javascript:fn_MoveUrl('2','4','0','/donate/story.c')" id = "240" class="link">기증 후 스토리</a>
							</div>
							<div class="row">
								<a href="javascript:fn_MoveUrl('2','5','0')" id = "250" class="link">기증자추모 및 가족행사</a>
								<div class="depth">
									<a href="javascript:fn_MoveUrl('2','5','2')" id = "252" class="depth-link">가족지원 서비스</a>
									<a href="javascript:fn_MoveUrl('2','5','3')" id = "253" class="depth-link">기증 후 행정처리</a>
								</div>
							</div>
						</div>
					</c:if><c:if test="${menuCd eq '5'}">
						<div class="sub__lnb" style="z-index:5">
							<div class="row">
								<a href="javascript:fn_MoveUrl('5','1','1','/pr/annual.c')" id = "510" class="link">간행물</a>
								<div class="depth">
									<a href="javascript:fn_MoveUrl('5','1','1','/pr/annual.c')" id = "511" class="depth-link">연보</a>
									<a href="javascript:fn_MoveUrl('5','1','2','/pr/news_letter.c')" id = "512" class="depth-link">뉴스레터</a>
									<a href="javascript:fn_MoveUrl('5','1','3','/pr/casebook.c')" id = "513" class="depth-link">사례집</a>
								</div>
							</div>
							<div class="row">
								<a href="javascript:fn_MoveUrl('5','2','1','/pr/webcontents.c')" id = "520" class="link">홍보콘텐츠</a>
								<div class="depth">
									<a href="javascript:fn_MoveUrl('5','2','1','/pr/webcontents.c')" id = "521" class="depth-link">웹콘텐츠</a>
									<a href="javascript:fn_MoveUrl('5','2','2','/pr/lifeSharing.c')" id = "522" class="depth-link">생명나눔스토리</a>
								</div>
							</div>
							<div class="row">
								<a href="javascript:fn_MoveUrl('5','3','0','/pr/movie.c')" id = "530" class="link">영상자료실</a>
							</div>
							<div class="row">
								<a href="javascript:fn_MoveUrl('5','4','0','/pr/pressRelease.c')" id = "540" class="link">언론보도</a>
							</div>							
							<div class="row">
								<a href="javascript:fn_MoveUrl('5','5','1','/pr/notice.c')" id = "550" class="link">기관소식</a>
								<div class="depth">
									<a href="javascript:fn_MoveUrl('5','5','1','/pr/notice.c')" id = "551" class="depth-link">공지사항</a>
									<a href="javascript:fn_MoveUrl('5','5','2','/pr/comnews.c')" id = "552" class="depth-link">기관소식</a>
								</div>
							</div>
							<div class="row">
								<a href="javascript:fn_MoveUrl('5','6','0')" id = "560" class="link">소통게시판</a>
							</div>
						</div>
					</c:if>
					<c:if test="${menuCd eq '6'}">
						<div class="sub__lnb" style="z-index:5">
							<div class="row">
								<a href="javascript:fn_MoveUrl('6','1','1')" id = "610" class="link">기증통계</a>
								<div class="depth">
									<a href="javascript:fn_MoveUrl('6','1','1')" id = "611" class="depth-link">단계별 기증 현황</a>
									<a href="javascript:fn_MoveUrl('6','1','2','/info/infodonate.c')" id = "612" class="depth-link">기증 현황</a>
									<a href="javascript:fn_MoveUrl('6','1','3','/info/infotrans.c')" id = "613" class="depth-link">이식 현황</a>
									<a href="javascript:fn_MoveUrl('6','1','4','/info/infohope.c')" id = "614" class="depth-link">기증희망등록현황</a>
								</div>
							</div>
							<div class="row">
								<a href="javascript:fn_MoveUrl('6','2','1')" id = "620" class="link">정보공개</a>
								<div class="depth">
									<a href="javascript:fn_MoveUrl('6','2','1')" id = "621" class="depth-link">정보공개제도 안내·청구</a>
									<a href="javascript:fn_MoveUrl('6','2','2','/info/infobefore.c')" id = "622" class="depth-link">사전정보 공표</a>
									<a href="javascript:fn_MoveUrl('6','2','3')" id = "623" class="depth-link">사업실명제</a>
									<a href="javascript:fn_MoveUrl('6','2','4')" id = "624" class="depth-link">경영공시</a>
									<a href="javascript:fn_MoveUrl('6','2','5','/info/infodata.c')" id = "625" class="depth-link">공공데이터 개방</a>
								</div>
							</div>
							<div class="row">
								<a href="javascript:fn_MoveUrl('6','3','1','/info/infolaw.c')" id = "630" class="link">자료실</a>
								<div class="depth">
									<a href="javascript:fn_MoveUrl('6','3','1','/info/infolaw.c')" id = "631" class="depth-link">법률·학술 자료</a>
									<a href="javascript:fn_MoveUrl('6','3','2')" id = "632" class="depth-link">교육자료</a>
								</div>
							</div>
						</div>
					</c:if>
					<c:if test="${menuCd eq '7'}">
						<div class="sub__lnb" style="z-index:5">
							<div class="row">
								<a href="javascript:fn_MoveUrl('7','1','0')" id = "710" class="link">기증원소개</a>
							</div>
							<div class="row">
								<a href="javascript:fn_MoveUrl('7','2','0')" id = "720" class="link">인사말</a>
							</div>
							<div class="row">
								<a href="javascript:fn_MoveUrl('7','3','0')" id = "730" class="link">비전·역할</a>
							</div>
							<div class="row">
								<a href="javascript:fn_MoveUrl('7','4','0')" id = "740" class="link">연혁</a>
							</div>
							<div class="row">
								<a href="javascript:fn_MoveUrl('7','5','0')" id = "750" class="link">KODA 인재채용</a>
							</div>
							<div class="row">
								<a href="javascript:fn_MoveUrl('7','6','0')" id = "760" class="link">CI소개 및 캐릭터</a>
							</div>
							<div class="row">
								<a href="javascript:fn_MoveUrl('7','7','0')" id = "770" class="link">인권경영</a>
							</div>
							<div class="row">
								<a href="javascript:fn_MoveUrl('7','8','0')" id = "780" class="link">적극행정</a>
							</div>
							<div class="row">
								<a href="javascript:fn_MoveUrl('7','9','0')" id = "790" class="link">조직안내</a>
							</div>
							<div class="row">
								<a href="javascript:fn_MoveUrl('7','10','0')" id = "7100" class="link">협약기관</a>
							</div>
							<div class="row">
								<a href="javascript:fn_MoveUrl('7','11','0')" id = "7110" class="link">오시는길</a>
							</div>
						</div>
					</c:if>
					<c:if test="${menuCd eq '8'}">
						<div class="sub__lnb" style="z-index:5">
							<div class="row">
								<a href="javascript:fn_MoveUrl('8','1','0')" id = "810" class="link">통보센터</a>
							</div>
							<div class="row">
								<a href="javascript:fn_MoveUrl('8','2','0')" id = "820" class="link">뇌사판정</a>
							</div>
							<div class="row">
								<a href="javascript:fn_MoveUrl('8','3','0')" id = "830" class="link">기증적합성평가</a>
							</div>
							<div class="row">
								<a href="javascript:fn_MoveUrl('8','4','0')" id = "840" class="link">장기 분배 시스템</a>
							</div>
							<div class="row">
								<a href="javascript:fn_MoveUrl('8','5','0')" id = "850" class="link">검사실</a>
							</div>
						</div>
					</c:if>
			 		<sitemesh:write property="body" />
			 	</div>
			 </div>
			 </c:if>
			 <c:if test="${empty menuCd}">
			 	<sitemesh:write property="body" />
			 </c:if>
		</form>
		</div>
		<footer class="footer">
			<div class="footer__partners">
				<div class="wrap">
					<div class="slider">

						<div class="footer__partners-item">
							<a href="http://www.mohw.go.kr/react/index.jsp" target="_blank"> <img
								src="${pageContext.request.contextPath}/resource/assets/images/footer-partner1.png"
								alt="보건복지부">
							</a>
						</div>

						<div class="footer__partners-item">
							<a href="http://www.129.go.kr/index.jsp" target="_blank"> <img
								src="${pageContext.request.contextPath}/resource/assets/images/footer-partner2.png"
								alt="보건복지상담센터">
							</a>
						</div>

						<div class="footer__partners-item">
							<a href="https://www.konos.go.kr/konosis/index.jsp" target="_blank"> <img
								src="${pageContext.request.contextPath}/resource/assets/images/footer-partner3.png"
								alt="국립장기조직혈액관리원">
							</a>
						</div>

						<div class="footer__partners-item">
							<a href="http://www.kdca.go.kr/"  target="_blank">  <img
								src="${pageContext.request.contextPath}/resource/assets/images/footer-partner4.png"
								alt="질병관리본부">
							</a>
						</div>

						<div class="footer__partners-item">
							<a href="https://www.mykst.org/" target="_blank"> <img
								src="${pageContext.request.contextPath}/resource/assets/images/footer-partner5.png"
								alt="대한이식학회">
							</a>
						</div>

						<div class="footer__partners-item">
							<a href="http://www.vitallink.or.kr/" target="_blank"> <img
								src="${pageContext.request.contextPath}/resource/assets/images/footer-partner6.png"
								alt="생명잇기">
							</a>
						</div>

						<div class="footer__partners-item">
							<a href="http://www.kadof.kr/home/" target="_blank"> <img
								src="${pageContext.request.contextPath}/resource/assets/images/footer-partner7.png"
								alt="한국기증자유가족지원본부">
							</a>
						</div>
						
						<div class="footer__partners-item">
							<a href="http://www.mohw.go.kr/react/index.jsp" target="_blank"> <img
								src="${pageContext.request.contextPath}/resource/assets/images/footer-partner1.png"
								alt="보건복지부">
							</a>
						</div>

						<div class="footer__partners-item">
							<a href="http://www.129.go.kr/index.jsp" target="_blank"> <img
								src="${pageContext.request.contextPath}/resource/assets/images/footer-partner2.png"
								alt="보건복지상담센터">
							</a>
						</div>

						<div class="footer__partners-item">
							<a href="https://www.konos.go.kr/konosis/index.jsp" target="_blank"> <img
								src="${pageContext.request.contextPath}/resource/assets/images/footer-partner3.png"
								alt="국립장기조직혈액관리원">
							</a>
						</div>

						<div class="footer__partners-item">
							<a href="http://www.kdca.go.kr/"  target="_blank">  <img
								src="${pageContext.request.contextPath}/resource/assets/images/footer-partner4.png"
								alt="질병관리본부">
							</a>
						</div>

						<div class="footer__partners-item">
							<a href="https://www.mykst.org/" target="_blank"> <img
								src="${pageContext.request.contextPath}/resource/assets/images/footer-partner5.png"
								alt="대한이식학회">
							</a>
						</div>

						<div class="footer__partners-item">
							<a href="http://www.vitallink.or.kr/" target="_blank"> <img
								src="${pageContext.request.contextPath}/resource/assets/images/footer-partner6.png"
								alt="생명잇기">
							</a>
						</div>

						<div class="footer__partners-item">
							<a href="http://www.kadof.kr/home/" target="_blank"> <img
								src="${pageContext.request.contextPath}/resource/assets/images/footer-partner7.png"
								alt="한국기증자유가족지원본부">
							</a>
						</div>

					</div>
					<div class="controller">
						<button class="prev"></button>
						<button class="stop"></button>
						<button class="play" style="display: none;"></button>
						<button class="next"></button>
					</div>
				</div>
			</div>
			<div class="footer__middle">
				<div class="wrap">
					<div class="flex">
						<div class="col">
							<a href=""> <span>기증 희망등록 </span>
							</a>
						</div>
						<div class="col">
							<a href=""> <span>아름다운 동행(E-뉴스레터) 신청하기</span>
							</a>
						</div>
					</div>
					<div class="family">
						<label for="f1"> <span> 유관기관 </span>
						</label>
					</div>
				</div>
			</div>
			<div class="footer__bottom">
				<div class="wrap">
					<div class="logo">
						<a href="javascript:fn_MovePage('/main.c')"><img
							src="${pageContext.request.contextPath}/resource/assets/images/footer-logo.png"
							alt=""></a>
					</div>
					<div class="flex flex-1">
						<div class="footer-info">
							<div class="links">
								<a href="">개인정보 처리방침</a> <a href="">위치안내</a> <a href="">연락체계</a>
								<a href="">경영공시</a>
							</div>
							<p>서울시 서대문구 충정로 36 국민연금공단충정로사옥5층 한국장기조직기증원 (우)03741</p>
							<div class="addr">
								<span> <strong>전화</strong> 02-3447-5632
								</span> <span> <strong>팩스</strong> 02-3447-5631
								</span> <span> <strong>이메일</strong> koda@koda1458.kr
								</span>
							</div>
						</div>
						<div class="marks">
							<span> <img
								src="${pageContext.request.contextPath}/resource/assets/images/footer-bottom1.png"
								alt="">
							</span> <span> <img
								src="${pageContext.request.contextPath}/resource/assets/images/footer-bottom2.png"
								alt="">
							</span> <span> <img
								src="${pageContext.request.contextPath}/resource/assets/images/footer-bottom3.png"
								alt="">
							</span>
						</div>
					</div>
				</div>
			</div>
		</footer>

	</div>
	<div id="loader">
		<span class="loader-overlay"> <span class="loader-inner"></span>
		</span>
	</div>
	<script
		src="${pageContext.request.contextPath}/resource/assets/plugins/jquery-ui-1.12.1/jquery-ui.js"></script>
	<script
		src="${pageContext.request.contextPath}/resource/assets/plugins/slick/slick.js"></script>
	<script
		src="${pageContext.request.contextPath}/resource/assets/js/ui.js"></script>

 <c:if test="${!empty menuCd}">
 <script>
 	var targetId = "" + ${menuCd} + ${seqCd1} + "0";

 	$("#"+targetId).addClass("active");

 	if (${seqCd2} > 0){
 		targetId = "" + ${menuCd} + ${seqCd1} + ${seqCd2};

 		$("#"+targetId).addClass("active");
 	}
 	
</script>
</c:if>
</body>
</html>
