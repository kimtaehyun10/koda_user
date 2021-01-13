<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="ko">
<head>
<script type="text/javascript">
$(document.body).ready(function(){
	
	//메인 게시판 toggle
	$(document).on('click', '.notice-tabs a', function () {		 
        $('.sub__tabs a').removeClass("active");
        $("a[href='"+ $(this).attr("href") +"']").addClass("active");
        
        $(".content").hide();

        var activeTab = $(this).attr("href");
        $(activeTab).fadeIn();

  	  	$('.sub__tabs .select button').html($(this).html());
  	  	
        return false;
    });
	
	//메인 게시판 data
	$.ajax({
		type: "get",
		url: "/main/mainBoardList.json",				
		dataType: "json",		
		success: function(data){
			var html1='<div class="main__notice-body">';
			var html2='<div class="main__notice-body">';
			var html3='<div class="main__notice-body">';
			var html4='<div class="main__notice-body">';
			var html5='<div class="main__notice-body">';
			var html6='<div class="main__notice-body">';
			
			//전체
			for(var i=0;i<data.mainTotalList.length;i++){				
				if(data.mainTotalList[i].brdNo === 7){										
					html1 += '<a href="" class="main__notice-item attach">';
					html1 += '<span class="type notice-color-1">공지</span>'
					html1 += '<p>'+data.mainTotalList[i].brdTitle+'</p>'
					html1 += '</a>'										
				}
				
				if(data.mainTotalList[i].brdNo === 43){										
					html1 += '<a href="" class="main__notice-item attach">';
					html1 += '<span class="type notice-color-2">채용</span>'
					html1 += '<p>'+data.mainTotalList[i].brdTitle+'</p>'
					html1 += '</a>'										
				}
				
				if(data.mainTotalList[i].brdNo === 31){										
					html1 += '<a href="" class="main__notice-item attach">';
					html1 += '<span class="type notice-color-3">보도</span>'
					html1 += '<p>'+data.mainTotalList[i].brdTitle+'</p>'
					html1 += '</a>'										
				}
				
				if(data.mainTotalList[i].brdNo === 36){										
					html1 += '<a href="" class="main__notice-item attach">';
					html1 += '<span class="type notice-color-4">홍보</span>'
					html1 += '<p>'+data.mainTotalList[i].brdTitle+'</p>'
					html1 += '</a>'										
				}
			}
			if(data.mainSurveyList.length != 0){
				html1 += '<a href="" class="main__notice-item attach">';
				html1 += '<span class="type notice-color-5">설문</span>'
				html1 += '<p>'+data.mainSurveyList[0].surveyTitle+'</p>'
				html1 += '</a>'	
			}			
						
			for(var i=0;i<data.mainBoardList.length;i++){
				//공지
				if(data.mainBoardList[i].brdNo === 7){										
					html2 += '<a href="" class="main__notice-item attach">';
					html2 += '<span class="type notice-color-1">공지</span>'
					html2 += '<p>'+data.mainBoardList[i].brdTitle+'</p>'
					html2 += '</a>'										
				}
				
				//채용
				if(data.mainBoardList[i].brdNo === 43){										
					html3 += '<a href="" class="main__notice-item attach">';
					html3 += '<span class="type notice-color-2">채용</span>'
					html3 += '<p>'+data.mainBoardList[i].brdTitle+'</p>'
					html3 += '</a>'										
				}
				
				//보도
				if(data.mainBoardList[i].brdNo === 31){										
					html4 += '<a href="" class="main__notice-item attach">';
					html4 += '<span class="type notice-color-3">보도</span>'
					html4 += '<p>'+data.mainBoardList[i].brdTitle+'</p>'
					html4 += '</a>'										
				}
				
				//홍보
				if(data.mainBoardList[i].brdNo === 36){										
					html5 += '<a href="" class="main__notice-item attach">';
					html5 += '<span class="type notice-color-4">홍보</span>'
					html5 += '<p>'+data.mainBoardList[i].brdTitle+'</p>'
					html5 += '</a>'										
				}
			}
			
			//설문
			for(var i=0;i<data.mainSurveyList.length;i++){				
				html6 += '<a href="" class="main__notice-item attach">';
				html6 += '<span class="type notice-color-5">설문</span>'
				html6 += '<p>'+data.mainSurveyList[i].surveyTitle+'</p>'
				html6 += '</a>'
			}
			html1 += '</div>';
			html2 += '</div>';
			html3 += '</div>';
			html4 += '</div>';
			html5 += '</div>';
			html6 += '</div>';
			$("#tab1").html(html1);
			$("#tab2").html(html2);
			$("#tab3").html(html3);
			$("#tab4").html(html4);
			$("#tab5").html(html5);
			$("#tab6").html(html6);
		},
		error: function (request, status, error){
			console.log(error);
		}
	});
    
});

</script>
</head>
<body>

    <div class="main">
        <!-- visual -->
        <div class="visual">
            <div class="slider">
            	<c:forEach items="${mainBannerList}" var="mainBannerList">
            		<c:choose>
            			<c:when test="${mainBannerList.mainBannerIdx eq '86'}">
            				<div class="visual__item" style="background-image: url(/imageView.do?imageName=${mainBannerList.mainBannerFileName});">
		                       <div class="wrap">
		                           <div>
		                               <span>KBS 오수진 기상캐스터</span>
		                               <h2>생명나눔 홍보대사 위촉</h2>
		                           </div>
		                           <p>
					                               기증자께서 제게 주신 것은 단순히 심장 하나가 아닙니다.<br/>
					                               지금 이 순간 살아 숨 쉴수 있다는 감사함.<br/>
					                               이 세상에 긍정적인 영향을 미치고 싶다는 바람까지 주셨습니다.<br/>
					                               앞으로 홍보대사로서 뜻 깊은 나눔의 가치를 많은 분들에게 알리겠습니다.
		                           </p>
		                       </div>
		                   </div>
            			</c:when>
            			<c:otherwise>
            				<div class="visual__item" style="background-image: url(/imageView.do?imageName=${mainBannerList.mainBannerFileName});">
		                       <div class="wrap">
		                           
		                       </div>
		                   </div>
            			</c:otherwise>
            		</c:choose>
            	</c:forEach>                                                                                                                                                
            </div>
            <!-- visual controller -->
            <div class="slider-controller">
                <div class="paging">
                    <span id="current">1</span>/<span id="total">3</span>
                </div>
                <div class="controller">
                    <button type="button" class="prev"></button>
                    <button type="button" class="stop"></button>
                    <button type="button" class="play" style="display: none;"></button>
                    <button type="button" class="next"></button>
                </div>
            </div>
        </div>

        <!-- nav -->
        <div class="main__nav">
            <div class="wrap">
                <div class="left">
                    
                    <a href="javascript:fn_MoveUrl('2','1','0','/donate/member.c')" class="navlist__link">
                        <span class="icon">
                            <img src="${pageContext.request.contextPath}/resource/assets/images/main-nav1.png" alt="">
                        </span>
                        <p>기증자예우</p>
                    </a>
                    
                    <a href="javascript:fn_MoveUrl('4','1','0')">
                        <span class="icon">
                            <img src="${pageContext.request.contextPath}/resource/assets/images/main-nav2.png" alt="">
                        </span>
                        <p>기증희망등록</p>
                    </a>
                    
                    <a href="javascript:fn_MoveUrl('8','1','0')">
                        <span class="icon">
                            <img src="${pageContext.request.contextPath}/resource/assets/images/main-nav3.png" alt="">
                        </span>
                        <p>KODA LAB</p>
                    </a>
                    
                    <a href="javascript:fn_MoveUrl('1','1','0')">
                        <span class="icon">
                            <img src="${pageContext.request.contextPath}/resource/assets/images/main-nav4.png" alt="">
                        </span>
                        <p>장기·조직기증</p>
                    </a>
                    
                    <a href="javascript:fn_MoveUrl('5','2','1','/pr/webcontents.c')">
                        <span class="icon">
                            <img src="${pageContext.request.contextPath}/resource/assets/images/main-nav5.png" alt="">
                        </span>
                        <p>홍보자료</p>
                    </a>
                    
                    <a href="javascript:fn_MoveUrl('7','1','0')">
                        <span class="icon">
                            <img src="${pageContext.request.contextPath}/resource/assets/images/main-nav6.png" alt="">
                        </span>
                        <p>기관안내</p>
                    </a>
                    
                    <a href="javascript:fn_MoveUrl('5','5','1','/pr/notice.c')"">
                        <span class="icon">
                            <img src="${pageContext.request.contextPath}/resource/assets/images/main-nav7.png" alt="">
                        </span>
                        <p>기관소식</p>
                    </a>
                    
                </div>
                <div class="right">
                    <a href="javascript:fn_MoveUrl('8','1','0')" class="row">
                        <span>
                            <h3>의료진 전용</h3>
                            <p>
                                뇌사시 통보 <strong>1577-1458</strong>
                            </p>
                        </span>
                    </a>
                    <a href="javascript:fn_MoveUrl('4','1','0')" class="row">
                        <span>
                            <h3>일반인 전용</h3>
                            <p>
                                기증희망등록 <strong>1544-0606</strong>
                            </p>
                        </span>
                    </a>
                </div>
            </div>
        </div>

        <!-- chart -->
        <div class="main__chart">
            <div class="wrap flex pc">
                <div class="main__chart-item">
                    <img src="${pageContext.request.contextPath}/resource/assets/images/main-chart1.png" alt="">
                    <!-- <div class="current">
                    	<div>
                    		<strong>100</strong>명
                    	</div>
                    	<p>2021-01-12 현재</p>
                    </div> -->                    
                </div>
                <div class="main__chart-item">
                    <img src="${pageContext.request.contextPath}/resource/assets/images/main-chart2.png" alt="">
                </div>
            </div>

            <div class="wrap tablet">
                <img src="${pageContext.request.contextPath}/resource/assets/images/main-chart-tablet.png" alt="">
            </div>

            <div class="wrap mobile">
                <img src="${pageContext.request.contextPath}/resource/assets/images/main-chart-mobile.png" alt="">
            </div>
        </div>

        <!-- process -->
        <div class="main__process">
            <div class="wrap">
                <h2>올해 생명나눔은 이렇게 진행되고 있어요</h2>
                <div class="main__process-list">
                    <div class="item">
                        <div class="icon">
                            <img src="${pageContext.request.contextPath}/resource/assets/images/main-process1.png" alt="">
                        </div>
                        <h3>통보</h3>
                        <div>
                            <p>
                            뇌사추정자 및 잠재 기증자 통보
                        </p>
                        </div>
                    </div>
                    <div class="item">
                        <div class="icon">
                            <img src="${pageContext.request.contextPath}/resource/assets/images/main-process2.png" alt="">
                        </div>
                        <h3>보호자 동의</h3>
                        <div>
                            <p>
                            코디네이터 출동 후 면담
                        </p>
                        </div>
                    </div>
                    <div class="item">
                        <div class="icon">
                            <img src="${pageContext.request.contextPath}/resource/assets/images/main-process3.png" alt="">
                        </div>
                        <h3>기증동의</h3>
                        <div>
                            <p>
                            선순위 가족동의
                        </p>
                        </div>
                    </div>
                    <div class="item">
                        <div class="icon">
                            <img src="${pageContext.request.contextPath}/resource/assets/images/main-process4.png" alt="">
                        </div>
                        <h3>기증</h3>
                        <div>
                            <p>
                                장기 <strong>220</strong>명<br/>
                                조직 <strong>185</strong>명
                            </p>
                        </div>
                    </div>
                    <div class="item">
                        <div class="icon">
                            <img src="${pageContext.request.contextPath}/resource/assets/images/main-process5.png" alt="">
                        </div>
                        <h3>가족지원</h3>
                        <div>
                            <p>
                                사회복지사 방문 및 전화상담
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- board -->
        <div class="main__board">
            <div class="wrap">
                <div class="left">
                    <div class="main__content-header">                        
                        <div class="notice-tabs">
                            <a href="#tab1">전체</a>
                            <a href="#tab2" class="notice-color-1">공지</a>
                            <a href="#tab3" class="notice-color-2">채용</a>
                            <a href="#tab4" class="notice-color-3">보도</a>
                            <a href="#tab5" class="notice-color-4">홍보</a>
                            <a href="#tab6" class="notice-color-5">설문</a>
                        </div>                                                        
                        <div class="actions ml-auto">
                            <a href="" class="btn main__more"></a>
                        </div>
                    </div>
                    
                    <div class="content" id="tab1"></div>
                    
                    <div class="content" id="tab2" style="display: none;"></div>
                    
                    <div class="content" id="tab3" style="display: none;"></div>
                    
                    <div class="content" id="tab4" style="display: none;"></div>
                    
                    <div class="content" id="tab5" style="display: none;"></div>
                    
                    <div class="content" id="tab6" style="display: none;"></div>
                    
                </div>
                <div class="right">
                    <div class="main__content-header">
                        <h3 class="title">기관소식</h3>
                        <div class="actions">
                            <button type="button" class="btn main__news-prev"></button>
                            <button type="button" class="btn main__news-next"></button>
                            <a href="" class="btn main__more"></a>
                        </div>
                    </div>
                    <div class="main__news">
                        <div class="slider">
                            
                                <div class="main__news-item">
                                    <a href="" class="block">
                                        <div class="img">
                                            <img src="//via.placeholder.com/550x270" alt="">
                                        </div>
                                        <p>
                                            Let's Green! Let's Walk! 前국가대표 선수들이 함께하는
                                            희망잇기 걷기대회에 발걸음을 모아주세요 :)
                                        </p>
                                    </a>
                                </div>
                            
                                <div class="main__news-item">
                                    <a href="" class="block">
                                        <div class="img">
                                            <img src="//via.placeholder.com/550x270" alt="">
                                        </div>
                                        <p>
                                            Let's Green! Let's Walk! 前국가대표 선수들이 함께하는
                                            희망잇기 걷기대회에 발걸음을 모아주세요 :)
                                        </p>
                                    </a>
                                </div>
                            
                                <div class="main__news-item">
                                    <a href="" class="block">
                                        <div class="img">
                                            <img src="//via.placeholder.com/550x270" alt="">
                                        </div>
                                        <p>
                                            Let's Green! Let's Walk! 前국가대표 선수들이 함께하는
                                            희망잇기 걷기대회에 발걸음을 모아주세요 :)
                                        </p>
                                    </a>
                                </div>
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- sublinks -->
        <div class="main__sublinks">
            <div class="col col1">
                <h3>기증자 추모관</h3>
                <p>
                    생명나눔을 실천한 분들의 고귀한 뜻,<br/>
                    잊지 않겠습니다.
                </p>
                <div>
                    <a href="">자세히보기</a>
                </div>
            </div>
            <div class="col col2">
                <h3>하늘나라 편지</h3>
                <p>
                    하늘에 있는 그리운 당신에게<br/>
                    편지를 보냅니다. 보고 싶습니다.
                </p>
                <div>
                    <a href="">자세히보기</a>
                </div>
            </div>
            <div class="col col3">
                <h3>수혜자 편지</h3>
                <p>
                    내게 주어진 두번째 삶,<br/>
                    잊지 않고 살겠습니다.
                </p>
                <div>
                    <a href="">자세히보기</a>
                </div>
            </div>
        </div>

        <!-- sns -->
        <div class="main__sns">
            <div class="wrap">
                <h2>한국장기기증조직원 SNS 소식</h2>
                <div class="main__sns-list">
                        <div class="item insta">
                        <header>
                            <a href="">
                                <img src="${pageContext.request.contextPath}/resource/assets/images/main-sns-insta.png" alt="">
                            </a>
                            인스타그램
                        </header>
                        <div class="item__body">
                            <div class="item__mainlink">
                                <div class="item__mainlink-header">
                                    <div class="img">
                                        <img src="${pageContext.request.contextPath}/resource/assets/images/sns-author.png" alt="">
                                    </div>
                                    <div class="info">
                                        <h3>한국장기기증조직원</h3>
                                        <p>11시간 전</p>
                                    </div>
                                </div>
                                <div class="thumb">
                                    <img src="${pageContext.request.contextPath}/resource/assets/images/dummy-thumb.png" alt="">
                                </div>
                                <div class="infobox">
                                    <h3>[2020 생명나눔 대학생 기자단 콘텐츠]</h3>
                                    <p>사후에도 장기 기증이 가능하다고?</p>
                                </div>
                            </div>
                            <ul class="item__links">
                                <li>
                                    <a href="">
                                        <p>생체기능과 뇌사시 기능의 차이기능의 차이기능의 차이기능의 차이점?</p>
                                        <span>3시간 전</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="">
                                        <p>기증희망등록이란?</p>
                                        <span>3일 전</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="">
                                        <p>생명나눔의 가치</p>
                                        <span>4일 전</span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="item facebook">
                        <header>
                            <a href="">
                                <img src="${pageContext.request.contextPath}/resource/assets/images/main-sns-facebook.png" alt="">
                            </a>
                            페이스북
                        </header>
                        <div class="item__body">
                            <div class="item__mainlink">
                                <div class="item__mainlink-header">
                                    <div class="img">
                                        <img src="${pageContext.request.contextPath}/resource/assets/images/sns-author.png" alt="">
                                    </div>
                                    <div class="info">
                                        <h3>한국장기기증조직원</h3>
                                        <p>11시간 전</p>
                                    </div>
                                </div>
                                <div class="thumb">
                                    <img src="${pageContext.request.contextPath}/resource/assets/images/dummy-thumb.png" alt="">
                                </div>
                                <div class="infobox">
                                    <h3>[2020 생명나눔 대학생 기자단 콘텐츠]</h3>
                                    <p>사후에도 장기 기증이 가능하다고?</p>
                                </div>
                            </div>
                            <ul class="item__links">
                                <li>
                                    <a href="">
                                        <p>생체기능과 뇌사시 기능의 차이점?</p>
                                        <span>3시간 전</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="">
                                        <p>기증희망등록이란?</p>
                                        <span>3일 전</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="">
                                        <p>생명나눔의 가치</p>
                                        <span>4일 전</span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="item blog">
                        <header>
                            <a href="">
                                <img src="${pageContext.request.contextPath}/resource/assets/images/main-sns-blog.png" alt="">
                            </a>
                            블로그
                        </header>
                        <div class="item__body">
                            <div class="item__mainlink">
                                <div class="item__mainlink-header">
                                    <div class="img">
                                        <img src="${pageContext.request.contextPath}/resource/assets/images/sns-author.png" alt="">
                                    </div>
                                    <div class="info">
                                        <h3>한국장기기증조직원</h3>
                                        <p>11시간 전</p>
                                    </div>
                                </div>
                                <div class="thumb">
                                    <img src="${pageContext.request.contextPath}/resource/assets/images/dummy-thumb.png" alt="">
                                </div>
                                <div class="infobox">
                                    <h3>[2020 생명나눔 대학생 기자단 콘텐츠]</h3>
                                    <p>사후에도 장기 기증이 가능하다고?</p>
                                </div>
                            </div>
                            <ul class="item__links">
                                <li>
                                    <a href="">
                                        <p>생체기능과 뇌사시 기능의 차이점?</p>
                                        <span>3시간 전</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="">
                                        <p>기증희망등록이란?</p>
                                        <span>3일 전</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="">
                                        <p>생명나눔의 가치</p>
                                        <span>4일 전</span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="item youtube">
                        <header>
                            <a href="">
                                <img src="${pageContext.request.contextPath}/resource/assets/images/main-sns-youtube.png" alt="">
                            </a>
                            유튜브
                        </header>
                        <div class="item__body">
                            <div class="item__mainlink">
                                <div class="item__mainlink-header">
                                    <div class="img">
                                        <img src="${pageContext.request.contextPath}/resource/assets/images/sns-author.png" alt="">
                                    </div>
                                    <div class="info">
                                        <h3>한국장기기증조직원</h3>
                                        <p>11시간 전</p>
                                    </div>
                                </div>
                                <div class="thumb">
                                    <img src="${pageContext.request.contextPath}/resource/assets/images/dummy-thumb.png" alt="">
                                </div>
                                <div class="infobox">
                                    <h3>[2020 생명나눔 대학생 기자단 콘텐츠]</h3>
                                    <p>사후에도 장기 기증이 가능하다고?</p>
                                </div>
                            </div>
                            <ul class="item__links">
                                <li>
                                    <a href="">
                                        <p>생체기능과 뇌사시 기능의 차이점?</p>
                                        <span>3시간 전</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="">
                                        <p>기증희망등록이란?</p>
                                        <span>3일 전</span>
                                    </a>
                                </li>
                                <li>
                                    <a href="">
                                        <p>생명나눔의 가치</p>
                                        <span>4일 전</span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- calendar / partners -->
        <div class="main__infobox">
            <div class="wrap">
                <div class="main__calendar">
                    <div class="main__content-header">
                        <h3 class="title">9월 기관일정</h3>
                        <div class="actions">
                            <select name="" id="">
                                <option value="">2020년</option>
                            </select>
                            <select name="" id="">
                                <option value="">9월</option>
                            </select>
                            <button class="submit">확인</button>
                            <a href="" class="btn main__more"></a>
                        </div>
                    </div>
                    <div class="main__calendar-body">
                        <table class="calendar">
                            <thead>
                            <tr>
                                <th><span>일</span></th>
                                <th><span>월</span></th>
                                <th><span>화</span></th>
                                <th><span>수</span></th>
                                <th><span>목</span></th>
                                <th><span>금</span></th>
                                <th><span>토</span></th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>
                                    <span class="prev">28</span>
                                </td>
                                <td>
                                    <span class="prev">29</span>
                                </td>
                                <td>
                                    <span class="prev">30</span>
                                </td>
                                <td>
                                    <span>1</span>
                                </td>
                                <td>
                                    <span>2</span>
                                </td>
                                <td>
                                    <span>3</span>
                                </td>
                                <td>
                                    <span>4</span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span>5</span>
                                </td>
                                <td>
                                    <span>6</span>
                                    <a href="" class="red">대학생공모전 .........</a>
                                </td>
                                <td>
                                    <span>7</span>
                                </td>
                                <td>
                                    <span>8</span>
                                </td>
                                <td>
                                    <span>9</span>
                                </td>
                                <td>
                                    <span>10</span>
                                </td>
                                <td>
                                    <span>11</span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span>12</span>
                                    <a href="" class="blue">온라인 대학생 .........</a>
                                </td>
                                <td>
                                    <span>13</span>
                                </td>
                                <td>
                                    <span>14</span>
                                </td>
                                <td>
                                    <span>15</span>
                                    <a href="" class="blue">온라인 대학생 .........</a>
                                </td>
                                <td>
                                    <span>16</span>
                                </td>
                                <td>
                                    <span>17</span>
                                </td>
                                <td>
                                    <span>18</span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span>19</span>
                                    <a href="" class="red">대학생공모전 .........</a>
                                </td>
                                <td>
                                    <span>20</span>
                                </td>
                                <td>
                                    <span>21</span>
                                </td>
                                <td>
                                    <span>22</span>
                                </td>
                                <td>
                                    <span>23</span>
                                </td>
                                <td>
                                    <span>24</span>
                                </td>
                                <td>
                                    <span>25</span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span>26</span>
                                    <a href="" class="red">대학생공모전 .........</a>
                                    <a href="" class="blue">온라인 대학생 .........</a>
                                </td>
                                <td>
                                    <span>27</span>
                                </td>
                                <td>
                                    <span>28</span>
                                </td>
                                <td>
                                    <span>29</span>
                                </td>
                                <td>
                                    <span>30</span>
                                </td>
                                <td>
                                    <span class="next">1</span>
                                </td>
                                <td>
                                    <span class="next">2</span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="next">3</span>
                                </td>
                                <td>
                                    <span class="next">4</span>
                                </td>
                                <td>
                                    <span class="next">5</span>
                                </td>
                                <td>
                                    <span class="next">6</span>
                                </td>
                                <td>
                                    <span class="next">7</span>
                                </td>
                                <td>
                                    <span class="next">8</span>
                                </td>
                                <td>
                                    <span class="next">9</span>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="main__partners">
                    <div class="main__content-header">
                        <h3 class="title">협약 기관</h3>
                        <div class="actions">
                            <a href="" class="btn main__more--text">+ 더보기</a>
                        </div>
                    </div>
                    <div class="main__partners-tab">
                        <a href="#//" class="active">KODA 협약병원</a>
                        <a href="#//" class="">DIP 협약병원</a>
                        <a href="#//" class="">협약기관</a>
                    </div>
                    <div class="main__partners-body">
                        
                            <div class="main__partners-item  new "><img src="${pageContext.request.contextPath}/resource/assets/images/main-partner1.png" alt=""></div>
                        
                            <div class="main__partners-item  new "><img src="${pageContext.request.contextPath}/resource/assets/images/main-partner2.png" alt=""></div>
                        
                            <div class="main__partners-item  new "><img src="${pageContext.request.contextPath}/resource/assets/images/main-partner3.png" alt=""></div>
                        
                            <div class="main__partners-item "><img src="${pageContext.request.contextPath}/resource/assets/images/main-partner4.png" alt=""></div>
                        
                            <div class="main__partners-item "><img src="${pageContext.request.contextPath}/resource/assets/images/main-partner5.png" alt=""></div>
                        
                            <div class="main__partners-item "><img src="${pageContext.request.contextPath}/resource/assets/images/main-partner6.png" alt=""></div>
                        
                            <div class="main__partners-item "><img src="${pageContext.request.contextPath}/resource/assets/images/main-partner7.png" alt=""></div>
                        
                            <div class="main__partners-item "><img src="${pageContext.request.contextPath}/resource/assets/images/main-partner8.png" alt=""></div>
                        
                            <div class="main__partners-item "><img src="${pageContext.request.contextPath}/resource/assets/images/main-partner9.png" alt=""></div>
                        
                    </div>
                </div>
            </div>
        </div>

        <div class="main__stories">
            <div class="wrap">
                <div class="item">
                    <a href="">
                        <div class="img">
                            <img src="${pageContext.request.contextPath}/resource/assets/images/main-story1.png" alt="">
                        </div>
                        <p>
                            로봇공학자를 꿈꾸던 12살 이기백군
                        </p>
                    </a>
                </div>
                <div class="item">
                    <div class="slider">
                        <div class="storySlide__item" style="background-image: url('${pageContext.request.contextPath}/resource/assets/images/story-slide1.png')">
                            <h2>생명나눔 스토리</h2>
                            <p>
                                가슴 따뜻해지는<br/>
                                생명 나눔 이야기를 소개합니다
                            </p>

                            <a href="">더 보러가기</a>
                        </div>
                        <div class="storySlide__item" style="background-image: url('${pageContext.request.contextPath}/resource/assets/images/story-slide1.png')">
                            <h2>생명나눔 스토리</h2>
                            <p>
                                가슴 따뜻해지는<br/>
                                생명 나눔 이야기를 소개합니다
                            </p>

                            <a href="">더 보러가기</a>
                        </div>
                    </div>
                </div>
                <div class="item">
                    <a href="">
                        <div class="img">
                            <img src="${pageContext.request.contextPath}/resource/assets/images/main-story2.png" alt="">
                        </div>
                        <p>
                            아름다운 기증 릴레이 - 故 김춘희님
                        </p>
                    </a>
                </div>
                <div class="item">
                    <a href="">
                        <div class="img">
                            <img src="${pageContext.request.contextPath}/resource/assets/images/main-story3.png" alt="">
                        </div>
                        <p>
                            9살 체조 꿈나무,<br/>
                            "우리집 막내 동원이"
                        </p>
                    </a>
                </div>
                <div class="item">
                    <a href="">
                        <div class="img">
                            <img src="${pageContext.request.contextPath}/resource/assets/images/main-story4.png" alt="">
                        </div>
                        <p>
                            국경을 초월한 생명나눔 이야기<br/>
                            -미얀마인 윈톳쏘(Win Htut Zaw)님
                        </p>
                    </a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
