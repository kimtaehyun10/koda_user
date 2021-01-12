<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<!-- <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery.min.js"></script> -->
<!--<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery.form.js"></script> -->
<!--<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/common.js"></script> -->

<script type="text/javascript" src="${pageContext.request.contextPath}/resource/axisj/dist/AXJ.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/axisj/lib/AXUtil.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/axisj/lib/AXValidator.js"></script>



<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;400;500;700&display=swap" rel="stylesheet">
<link type="text/css" rel="stylesheet" href="//fonts.googleapis.com/earlyaccess/nanummyeongjo.css">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resource/assets/plugins/slick/slick.css">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resource/assets/plugins/jquery-ui-1.12.1/jquery-ui.css">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resource/assets/css/main.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resource/axicon/axicon.min.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resource/axisj/ui/AXJ.min.css"/>
<!-- <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/main.css"/> -->
<!-- <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/sub.css"/>-->
<!-- <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/sub_nam.css"/>-->

<title>한국장기조직기증원-<sitemesh:write property="title" /></title>
<script>

$.ajaxSettings.traditional = true;

function fn_main_headPageMove(menuNo, url){
	document.selectOne.menuNo.value=menuNo;
	document.selectOne.chkURL.value=url;
    document.selectOne.action = "<c:url value='/index.c'/>";
    document.selectOne.submit(); 
} 
var imgpath = "<c:url value='/images/egovframework/com/cmm/utl/'/>"; 
var path = "http://" + "${pageContext.request.serverName}" + ":" + "${pageContext.request.serverPort}"; 
function fn_MovePage(url, menuNo) {  
	//document.location.href = url+"?menuNo="+document.selectOne.menuNo.value+"&pageId="+menuNo; 
	document.location.href = url;
}

function poptastic(url)
{
	window.open("/map/emailPopup", "", 'toolbar=no, width=1000, height=600, status=yes, menubar=no, scrollbars=yes');	    	
}

initTimer = function() {
	
	var session = '<%=request.getSession().getId()%>';
	var max = parseInt('<%=request.getSession().getMaxInactiveInterval()%>');
    $.ajax({
        url : "/com/selectSession.json",
        type: "POST", 
        data: {session : session},
        dataType:"json", 
        success : function(data, textStatus, jqXHR) {
        	var seconds = data.pastSeconds;
        	 
        	if (seconds >= max) {
        		location.href = "/sessionError";
        	} else {
        		setTimeout("initTimer()", 120000); // 2분 간격으로 체크
        	}
        },
        error : function(jqXHR, textStatus, errorThrown){
            //Error시, 처리
        }
    });
}

$(function(){

	var authenticated = '<%=session.getAttribute("isLocallyAuthenticated")%>';
	var max = parseInt('<%=request.getSession().getMaxInactiveInterval()%>');
	
	if (authenticated == 'true' && max > 0) {
		initTimer();	
	}
});

</script>

<sitemesh:write property="head" />

</head>
<body>

<form name="selectOne" method="post">
<input name="menuNo" type="hidden" value="${resultVO.tempInt}"/>
<input name="chkURL" type="hidden" value=""/> 
</form>
  
<div class="wrap">

	<div class="topMessage">
	   <div class="wrap flex items-center">
	       <div class="logo">
	           <img src="${pageContext.request.contextPath}/resource/assets/images/header-message-logo.png" alt="">
	       </div>
	       <p class="text font-myeongjo">
	           “지금 우리의 헤어짐이 영원한 이별이 아닌 잠시 동안 작별이라 생각하고 그리움은 간직하겠지만 슬픔은 잊어볼게 언니야 사랑해”..........
	       </p>
	       <span class="author font-myeongjo">추모자 : 한**</span>
	   </div>
	</div>

	<header class="header">
	    <div class="header__top">
	        <div class="wrap flex items-center">
	            <h1 class="header__logo">
	                <a href="javascript:fn_MovePage('/main');"><img src="${pageContext.request.contextPath}/resource/assets/images/logo.png" alt="한국장기조직기증원" /></a>
	            </h1>
	            <form action="" class="searchform">
	                <div class="search">
	                    <input type="text" placeholder="검색어를 입력해주세요.">
	                    <button type="submit" class="btn">검색</button>
	                </div>
	            </form>
	            <div class="header__etc">
	                <a href="">
	                    <span>의료인 페이지</span>
	                </a>
	            </div>
	            <div class="header__sns">
	                <a href="" class="insta" title="인스타그램">인스타그램</a>
	                <a href="" class="facebook" title="페이스북">페이스북</a>
	                <a href="" class="blog" title="블로그">블로그</a>
	                <a href="" class="youtube" title="유튜브">유튜브</a>
	            </div>
	            <button class="mobile-search-button">검색</button>
	            <button class="mobile-gnb-button">메뉴</button>
	        </div>
	    </div>
	    <nav class="header__nav">
	        <div class="wrap flex items-center">
	            <div class="navlist flex-1">
	                <div class="navlist__item">
	                    <a href="" class="navlist__link">장기조직기능</a>
	                    <div class="navlist__depth">
	                        <div class="wrap flex">
	                            <div class="depth-name">
	                                <h2>장기조직 기증</h2>
	                                <p>
	                                    누군가의 끝이 아니라<br/>
	                                    누군가의 시작
	                                </p>
	                            </div>
	                            <div class="depth-links">
	                                <div class="depth-links-item">
	                                    <a href="">장기·조직 기증</a>
	                                </div>
	                                <div class="depth-links-item">
	                                    <a href="" class="link">장기·조직 기증이란</a>
	                                    <div class="depth-links-inner">
	                                        <a href="">생명나눔이란 무엇인가요?</a>
	                                        <a href="">기증은 왜 필요한가요?</a>
	                                        <a href="">기증은 언제 이루어지나요?</a>
	                                        <a href="">장기기증</a>
	                                        <a href="">조직기증</a>
	                                        <a href="">한 눈에 보는 기증 흐름도</a>
	                                    </div>
	                                </div>
	                                <div class="depth-links-item">
	                                    <a href="">기증팩트체크</a>
	                                </div>
	                                <div class="depth-links-item">
	                                    <a href="">KODA코디네이터</a>
	                                </div>
	                                <div class="depth-links-item">
	                                    <a href="">기증용어 설명</a>
	                                </div>
	                                <div class="depth-links-item">
	                                    <a href="" class="link"> 협약병원</a>
	                                    <div class="depth-links-inner">
	                                        <a href="">뇌사장기기증자 관리업무협약</a>
	                                        <a href="">DIP 협약병원</a>
	                                        <a href="">검사실 협약</a>
	                                    </div>
	                                </div>
	                            </div>
	                            <div class="depth-etc">
	                                <a href="">
	                                    <img src="${pageContext.request.contextPath}/resource/assets/images/navlist-link1.png" alt="">
	                                    <p>기증희망등록</p>
	                                </a>
	                                <a href="">
	                                    <img src="${pageContext.request.contextPath}/resource/assets/images/navlist-link2.png" alt="">
	                                    <p>하늘나라편지</p>
	                                </a>
	                                <a href="">
	                                    <img src="${pageContext.request.contextPath}/resource/assets/images/navlist-link3.png" alt="">
	                                    <p>소식지신청</p>
	                                </a>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	                <div class="navlist__item">
	                    <a href="" class="navlist__link">기증자예우</a>
	                </div>
	                <div class="navlist__item">
	                    <a href="javascript:fn_MovePage('/mem/memLogin.c');" class="navlist__link">생명나눔우체통</a>
	                </div>
	                <div class="navlist__item">
	                    <a href="" class="navlist__link">기증희망등록</a>
	                </div>
	                <div class="navlist__item">
	                    <a href="" class="navlist__link">홍보·소식</a>
	                </div>
	                <div class="navlist__item">
	                    <a href="" class="navlist__link">정보공개</a>
	                </div>
	                <div class="navlist__item">
	                    <a href="" class="navlist__link">KODA</a>
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
	                <a href="javascript:fn_MovePage('/main');"><img src="${pageContext.request.contextPath}/resource/assets/images/logo.png" alt="한국장기조직기증원"></a>
	            </div>
	            <button class="btn">닫기</button>
	        </div>
	        <div class="sitemap__body">
	            <div class="col">
	                <h3 class="col__title">
	                    <a href="">장기조직 기증</a>
	                </h3>
	                <div class="col__list">
	                    <div class="col__item">
	                        <a href="">장기·조직 기증</a>
	                    </div>
	                    <div class="col__item">
	                        <a href="">장기·조직 기증이란</a>
	                        <div class="col__depth">
	                            <a href="">생명나눔이란 무엇인가요?</a>
	                            <a href="">기증은 왜 필요한가요?</a>
	                            <a href="">기증은 언제 이루어지나요?</a>
	                            <a href="">장기기증</a>
	                            <a href="">조직기증</a>
	                            <a href="">한 눈에 보는 기증 흐름도</a>
	                        </div>
	                    </div>
	                    <div class="col__item">
	                        <a href="">기증팩트체크</a>
	                    </div>
	                    <div class="col__item">
	                        <a href="">KODA코디네이터</a>
	                    </div>
	                    <div class="col__item">
	                        <a href="">기증용어 설명</a>
	                    </div>
	                    <div class="col__item">
	                        <a href="">협약병원</a>
	                        <div class="col__depth">
	                            <a href="">뇌사장기기증자 관리업무협약</a>
	                            <a href="">DIP 협약병원</a>
	                            <a href="">검사실 협약</a>
	                        </div>
	                    </div>
	                </div>
	            </div>
	
	            <div class="col">
	                <h3 class="col__title">
	                    <a href="">기증자 예우</a>
	                </h3>
	                <div class="col__list">
	                    <div class="col__item">
	                        <a href="">가족지원 및 예우</a>
	                        <div class="col__depth">
	                            <a href="">기증자 추모관</a>
	                            <a href="">하늘나라 편지</a>
	                            <a href="">수혜자 편지</a>
	                            <a href="">기증자 추모 및 가족행사</a>
	                        </div>
	                    </div>
	                </div>
	            </div>
	
	            <div class="col">
	                <h3 class="col__title">
	                    <a href="">생명나눔 우체통</a>
	                </h3>
	                <div class="col__list">
	                    <div class="col__item">
	                        <a href="javascript:fn_MovePage('/mem/memLogin.c');">생명나눔 우체통</a>
	                    </div>
	                </div>
	            </div>
	
	            <div class="col">
	                <h3 class="col__title">
	                    <a href="">기증희망등록</a>
	                </h3>
	                <div class="col__list">
	                    <div class="col__item">
	                        <a href="">기증희망등록</a>
	                    </div>
	                </div>
	            </div>
	
	            <div class="col">
	                <h3 class="col__title">
	                    <a href="">홍보·소식</a>
	                </h3>
	                <div class="col__list">
	                    <div class="col__item">
	                        <a href="">간행물</a>
	                        <div class="col__depth">
	                            <a href="">연보</a>
	                            <a href="">뉴스레터</a>
	                            <a href="">사례집</a>
	                        </div>
	                    </div>
	                    <div class="col__item">
	                        <a href="">홍보 콘텐츠</a>
	                        <div class="col__depth">
	                            <a href="">웹콘텐츠</a>
	                            <a href="">생명나눔 스토리</a>
	                        </div>
	                    </div>
	                    <div class="col__item">
	                        <a href="">영상자료실</a>
	                    </div>
	                    <div class="col__item">
	                        <a href="">언론보도</a>
	                    </div>
	                    <div class="col__item">
	                        <a href="">기관소식</a>
	                        <div class="col__depth">
	                            <a href="">공지사항</a>
	                            <a href="">기관소식</a>
	                        </div>
	                    </div>
	                    <div class="col__item">
	                        <a href="">소통게시판</a>
	                    </div>
	                </div>
	            </div>
	
	            <div class="col">
	                <h3 class="col__title">
	                    <a href="">정보공개</a>
	                </h3>
	                <div class="col__list">
	                    <div class="col__item">
	                        <a href="">기증통계</a>
	                        <div class="col__depth">
	                            <a href="">단계별 기증 현황</a>
	                            <a href="">기증 현황</a>
	                            <a href="">이식 현황</a>
	                            <a href="">기증희망등록 현황</a>
	                        </div>
	                    </div>
	                    <div class="col__item">
	                        <a href="">정보공개</a>
	                        <div class="col__depth">
	                            <a href="">정보공개제도 안내·청구</a>
	                            <a href="">사전정보 공표</a>
	                            <a href="">사업실명제</a>
	                            <a href="">경영공시</a>
	                            <a href="">공공데이터 개방</a>
	                        </div>
	                    </div>
	                    <div class="col__item">
	                        <a href="">자료실</a>
	                        <div class="col__depth">
	                            <a href="">법률·학술자료</a>
	                            <a href="">교육자료</a>
	                        </div>
	                    </div>
	                </div>
	            </div>
	
	            <div class="col">
	                <h3 class="col__title">
	                    <a href="">KODA</a>
	                </h3>
	                <div class="col__list">
	                    <div class="col__item">
	                        <a href="">기증원소개</a>
	                    </div>
	                    <div class="col__item">
	                        <a href="">인사말</a>
	                    </div>
	                    <div class="col__item">
	                        <a href="">비전·역할</a>
	                    </div>
	                    <div class="col__item">
	                        <a href="">연혁</a>
	                    </div>
	                    <div class="col__item">
	                        <a href="">KODA 인재채용</a>
	                    </div>
	                    <div class="col__item">
	                        <a href="">CI소개 및 캐릭터</a>
	                    </div>
	                    <div class="col__item">
	                        <a href="">인권경영</a>
	                    </div>
	                    <div class="col__item">
	                        <a href="">적극행정</a>
	                    </div>
	                    <div class="col__item">
	                        <a href="">조직안내</a>
	                    </div>
	                    <div class="col__item">
	                        <a href="">협약기관</a>
	                    </div>
	                    <div class="col__item">
	                        <a href="">오시는 길</a>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>
	
	    <div class="mobile-gnb">
	    <div class="mobile-gnb__header">
	        <a href="" class="member">의료진 페이지</a>
	        <div class="sns">
	            <a href="" class="insta">인스타그램</a>
	            <a href="" class="facebook">페이스북</a>
	            <a href="" class="blog">블로그</a>
	            <a href="" class="youtube">유트브</a>
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
	                    <a href="">장기·조직 기증</a>
	                </div>
	                <div class="col__item">
	                    <a href="">장기·조직 기증이란</a>
	                </div>
	                <div class="col__item">
	                    <a href="">기증팩트체크</a>
	                </div>
	                <div class="col__item">
	                    <a href="">KODA코디네이터</a>
	                </div>
	                <div class="col__item">
	                    <a href="">기증용어 설명</a>
	                </div>
	                <div class="col__item">
	                    <a href="">협약병원</a>
	                </div>
	            </div>
	        </div>
	
	        <div class="col">
	            <h3 class="col__title">
	                <a href="">기증자 예우</a>
	            </h3>
	            <div class="col__list">
	                <div class="col__item">
	                    <a href="">가족지원 및 예우</a>
	                </div>
	            </div>
	        </div>
	
	        <div class="col">
	            <h3 class="col__title">
	                <a href="">생명나눔 우체통</a>
	            </h3>
	            <div class="col__list">
	                <div class="col__item">
	                    <a href="javascript:fn_MovePage('/mem/memLogin.c');">생명나눔 우체통</a>
	                </div>
	            </div>
	        </div>
	
	        <div class="col">
	            <h3 class="col__title">
	                <a href="">기증희망등록</a>
	            </h3>
	            <div class="col__list">
	                <div class="col__item">
	                    <a href="">기증희망등록</a>
	                </div>
	            </div>
	        </div>
	
	        <div class="col">
	            <h3 class="col__title">
	                <a href="">홍보·소식</a>
	            </h3>
	            <div class="col__list">
	                <div class="col__item">
	                    <a href="">간행물</a>
	                </div>
	                <div class="col__item">
	                    <a href="">홍보 콘텐츠</a>
	                </div>
	                <div class="col__item">
	                    <a href="">영상자료실</a>
	                </div>
	                <div class="col__item">
	                    <a href="">언론보도</a>
	                </div>
	                <div class="col__item">
	                    <a href="">기관소식</a>
	                </div>
	                <div class="col__item">
	                    <a href="">소통게시판</a>
	                </div>
	            </div>
	        </div>
	
	        <div class="col">
	            <h3 class="col__title">
	                <a href="">정보공개</a>
	            </h3>
	            <div class="col__list">
	                <div class="col__item">
	                    <a href="">기증통계</a>
	                </div>
	                <div class="col__item">
	                    <a href="">정보공개</a>
	                </div>
	                <div class="col__item">
	                    <a href="">자료실</a>
	                </div>
	            </div>
	        </div>
	
	        <div class="col">
	            <h3 class="col__title">
	                <a href="">KODA</a>
	            </h3>
	            <div class="col__list">
	                <div class="col__item">
	                    <a href="">기증원소개</a>
	                </div>
	                <div class="col__item">
	                    <a href="">인사말</a>
	                </div>
	                <div class="col__item">
	                    <a href="">비전·역할</a>
	                </div>
	                <div class="col__item">
	                    <a href="">연혁</a>
	                </div>
	                <div class="col__item">
	                    <a href="">KODA 인재채용</a>
	                </div>
	                <div class="col__item">
	                    <a href="">CI소개 및 캐릭터</a>
	                </div>
	                <div class="col__item">
	                    <a href="">인권경영</a>
	                </div>
	                <div class="col__item">
	                    <a href="">적극행정</a>
	                </div>
	                <div class="col__item">
	                    <a href="">조직안내</a>
	                </div>
	                <div class="col__item">
	                    <a href="">협약기관</a>
	                </div>
	                <div class="col__item">
	                    <a href="">오시는 길</a>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>


	<div class="container">
		<sitemesh:write property="body" />
	</div>
	
	
	<footer class="footer">
	  <div class="footer__partners">
	      <div class="wrap">
	          <div class="slider">
	              
	                  <div class="footer__partners-item">
	                      <a href="">
	                          <img src="${pageContext.request.contextPath}/resource/assets/images/footer-partner1.png" alt="">
	                      </a>
	                  </div>
	              
	                  <div class="footer__partners-item">
	                      <a href="">
	                          <img src="${pageContext.request.contextPath}/resource/assets/images/footer-partner2.png" alt="">
	                      </a>
	                  </div>
	              
	                  <div class="footer__partners-item">
	                      <a href="">
	                          <img src="${pageContext.request.contextPath}/resource/assets/images/footer-partner3.png" alt="">
	                      </a>
	                  </div>
	              
	                  <div class="footer__partners-item">
	                      <a href="">
	                          <img src="${pageContext.request.contextPath}/resource/assets/images/footer-partner4.png" alt="">
	                      </a>
	                  </div>
	              
	                  <div class="footer__partners-item">
	                      <a href="">
	                          <img src="${pageContext.request.contextPath}/resource/assets/images/footer-partner5.png" alt="">
	                      </a>
	                  </div>
	              
	                  <div class="footer__partners-item">
	                      <a href="">
	                          <img src="${pageContext.request.contextPath}/resource/assets/images/footer-partner6.png" alt="">
	                      </a>
	                  </div>
	              
	                  <div class="footer__partners-item">
	                      <a href="">
	                          <img src="${pageContext.request.contextPath}/resource/assets/images/footer-partner7.png" alt="">
	                      </a>
	                  </div>
	              
	                  <div class="footer__partners-item">
	                      <a href="">
	                          <img src="${pageContext.request.contextPath}/resource/assets/images/footer-partner1.png" alt="">
	                      </a>
	                  </div>
	              
	                  <div class="footer__partners-item">
	                      <a href="">
	                          <img src="${pageContext.request.contextPath}/resource/assets/images/footer-partner2.png" alt="">
	                      </a>
	                  </div>
	              
	                  <div class="footer__partners-item">
	                      <a href="">
	                          <img src="${pageContext.request.contextPath}/resource/assets/images/footer-partner3.png" alt="">
	                      </a>
	                  </div>
	              
	                  <div class="footer__partners-item">
	                      <a href="">
	                          <img src="${pageContext.request.contextPath}/resource/assets/images/footer-partner4.png" alt="">
	                      </a>
	                  </div>
	              
	                  <div class="footer__partners-item">
	                      <a href="">
	                          <img src="${pageContext.request.contextPath}/resource/assets/images/footer-partner5.png" alt="">
	                      </a>
	                  </div>
	              
	                  <div class="footer__partners-item">
	                      <a href="">
	                          <img src="${pageContext.request.contextPath}/resource/assets/images/footer-partner6.png" alt="">
	                      </a>
	                  </div>
	              
	                  <div class="footer__partners-item">
	                      <a href="">
	                          <img src="${pageContext.request.contextPath}/resource/assets/images/footer-partner7.png" alt="">
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
	                    <a href="">
	                        <span>기증 희망등록 </span>
	                    </a>
	                </div>
	                <div class="col">
	                    <a href="">
	                        <span>아름다운 동행(E-뉴스레터) 신청하기</span>
	                    </a>
	                </div>
	            </div>
	            <div class="family">
	                <label for="f1">
	                    <span>
	                        유관기관
	                    </span>
	                </label>
	
	
	
	            </div>
	        </div>
	    </div>
	    <div class="footer__bottom">
	        <div class="wrap">
	            <div class="logo">
	                <a href=""><img src="${pageContext.request.contextPath}/resource/assets/images/footer-logo.png" alt=""></a>
	            </div>
	            <div class="flex flex-1">
	                <div class="footer-info">
	                    <div class="links">
	                        <a href="">개인정보 처리방침</a>
	                        <a href="">위치안내</a>
	                        <a href="">연락체계</a>
	                        <a href="">경영공시</a>
	                    </div>
	                    <p>
	                        서울시 서대문구 충정로 36 국민연금공단충정로사옥5층 한국장기조직기증원 (우)03741
	                    </p>
	                    <div class="addr">
	                    <span>
	                        <strong>전화</strong> 02-3447-5632
	                    </span>
	                        <span>
	                        <strong>팩스</strong> 02-3447-5631
	                    </span>
	                        <span>
	                        <strong>이메일</strong> koda@koda1458.kr
	                    </span>
	                    </div>
	                </div>
	                <div class="marks">
	                <span>
	                    <img src="${pageContext.request.contextPath}/resource/assets/images/footer-bottom1.png" alt="">
	                </span>
	                    <span>
	                    <img src="${pageContext.request.contextPath}/resource/assets/images/footer-bottom2.png" alt="">
	                </span>
	                    <span>
	                    <img src="${pageContext.request.contextPath}/resource/assets/images/footer-bottom3.png" alt="">
	                </span>
	                </div>
	            </div>
	        </div>
	    </div>
	</footer>
	

</div>


<div id="loader">
  <span class="loader-overlay">
    <span class="loader-inner"></span>
  </span>
</div>


<script type="text/javascript" src="${pageContext.request.contextPath}/resource/assets/plugins/jquery/jquery.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/assets/plugins/jquery-ui-1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/assets/plugins/slick/slick.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/assets/js/ui.js"></script>

</body> 
</html>
