<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!doctype html>
<html lang="ko">
<head>
<script type="text/javascript">
$(document.body).ready(function(){
	
	//메인 게시판 toggle
	$(document).on('click', '.notice-tabs a', function () {		 
        
		//더보기버튼 href 변경 고민해야한다
		//$('.main__board').find('.main__more').eq(0).attr('href','/pr/notice.c');
		
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
					html1 += '<a href="javascript:goView('+data.mainTotalList[i].brdContNo+','+1+')" class="main__notice-item attach">';
					html1 += '<span class="type notice-color-1">공지</span>'
					html1 += '<p>'+data.mainTotalList[i].brdTitle+'</p>'
					html1 += '</a>'										
				}
				
				if(data.mainTotalList[i].brdNo === 43){										
					html1 += '<a href="javascript:goView('+data.mainTotalList[i].brdContNo+','+2+')" class="main__notice-item attach">';
					html1 += '<span class="type notice-color-2">채용</span>'
					html1 += '<p>'+data.mainTotalList[i].brdTitle+'</p>'
					html1 += '</a>'										
				}
				
				if(data.mainTotalList[i].brdNo === 31){										
					html1 += '<a href="javascript:goView('+data.mainTotalList[i].brdContNo+','+3+')" class="main__notice-item attach">';
					html1 += '<span class="type notice-color-3">보도</span>'
					html1 += '<p>'+data.mainTotalList[i].brdTitle+'</p>'
					html1 += '</a>'										
				}
				
				if(data.mainTotalList[i].brdNo === 36){										
					html1 += '<a href="javascript:goView('+data.mainTotalList[i].brdContNo+','+4+')" class="main__notice-item attach">';
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
					html2 += '<a href="javascript:goView('+data.mainBoardList[i].brdContNo+','+1+')" class="main__notice-item attach">';
					html2 += '<span class="type notice-color-1">공지</span>'
					html2 += '<p>'+data.mainBoardList[i].brdTitle+'</p>'
					html2 += '</a>'										
				}
				
				//채용
				if(data.mainBoardList[i].brdNo === 43){										
					html3 += '<a href="javascript:goView('+data.mainBoardList[i].brdContNo+','+2+')" class="main__notice-item attach">';
					html3 += '<span class="type notice-color-2">채용</span>'
					html3 += '<p>'+data.mainBoardList[i].brdTitle+'</p>'
					html3 += '</a>'										
				}
				
				//보도
				if(data.mainBoardList[i].brdNo === 31){										
					html4 += '<a href="javascript:goView('+data.mainBoardList[i].brdContNo+','+3+')" class="main__notice-item attach">';
					html4 += '<span class="type notice-color-3">보도</span>'
					html4 += '<p>'+data.mainBoardList[i].brdTitle+'</p>'
					html4 += '</a>'										
				}
				
				//홍보
				if(data.mainBoardList[i].brdNo === 36){										
					html5 += '<a href="javascript:goView('+data.mainBoardList[i].brdContNo+','+4+')" class="main__notice-item attach">';
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
	
	//메인 기관일정
	mainOrganDateList();
	
});

//게시물 상세보기
function goView(idx,num){
	$('#method').val('view');
	$('#idx').val(idx);				
	
	//공지
	if(num===1){
		$("#menuCd").val(5);
		$("#seqCd1").val(5);
		$("#seqCd2").val(1);		
		$('#frm_url').attr('action', '/pr/notice_view.c').submit();
	}
	//채용
	if(num===2){
		$("#menuCd").val(5);
		$("#seqCd1").val(7);
		$("#seqCd2").val(0);
		$('#frm_url').attr('action', '/pr/hire_view.c').submit();
	}
	//보도
	if(num===3){
		$("#menuCd").val(5);
		$("#seqCd1").val(4);
		$("#seqCd2").val(0);
		$('#frm_url').attr('action', '/pr/pressRelease_view.c').submit();
	}
	//홍보
	if(num===4){
		$("#menuCd").val(5);
		$("#seqCd1").val(2);
		$("#seqCd2").val(1);
		$('#frm_url').attr('action', '/pr/webcontents_view.c').submit();
	}
	//설문
	if(num===5){
		//소통게시판부터 작업하자
		/* $("#menuCd").val(5);
		$("#seqCd1").val(5);
		$("#seqCd2").val(1);
		$('#frm_url').attr('action', '/pr/notice_view.c').submit(); */
	}
	//기관소식
	if(num===6){
		$("#menuCd").val(5);
		$("#seqCd1").val(5);
		$("#seqCd2").val(2);
		$('#frm_url').attr('action', '/pr/comnews_view.c').submit();
	}
	//생명나눔 스토리
	if(num===7){
		$("#menuCd").val(5);
		$("#seqCd1").val(2);
		$("#seqCd2").val(2);		
		$('#frm_url').attr('action', '/pr/lifeSharing_view.c').submit();
	}
}

//메인 기관일정
function mainOrganDateList(){
	var year = $('#year').val();
	var month = $('#month').val();
	$.ajax({
		type: "get",
		url: "/main/mainOrganDateList.json",
		data: {
			year : year,
			month : month
		},
		dataType: "json",		
		success: function(data){			
			var html = '';
			html += '<div class="main__content-header">';
			html += '<h3 class="title">'+data.today_info.search_month+'월 기관일정</h3>';
			html += '<div class="actions">';
			html += '<select name="year" id="year">';
			if(data.today_info.search_year === 2023){
				html += '<option value="2023" selected>2023년</option>';
			}else{
				html += '<option value="2023" >2023년</option>';
			}
			if(data.today_info.search_year === 2022){
				html += '<option value="2022" selected>2022년</option>';
			}else{
				html += '<option value="2022" >2022년</option>';
			}
			if(data.today_info.search_year === 2021){
				html += '<option value="2021" selected>2021년</option>';
			}else{
				html += '<option value="2021" >2021년</option>';
			}
			if(data.today_info.search_year === 2020){
				html += '<option value="2020" selected>2020년</option>';
			}else{
				html += '<option value="2020" >2020년</option>';
			}
			if(data.today_info.search_year === 2019){
				html += '<option value="2019" selected>2019년</option>';
			}else{
				html += '<option value="2019" >2019년</option>';
			}
			if(data.today_info.search_year === 2023){
				html += '<option value="2018" selected>2018년</option>';
			}else{
				html += '<option value="2018" >2018년</option>';
			}			
			html += '</select>';
			html += '<select name="month" id="month">';
			if(data.today_info.search_month === 1){
				html += '<option value="0" selected>1월</option>';
			}else{
				html += '<option value="0">1월</option>';
			}
			if(data.today_info.search_month === 2){
				html += '<option value="1" selected>2월</option>';
			}else{
				html += '<option value="1">2월</option>';
			}
			if(data.today_info.search_month === 3){
				html += '<option value="2" selected>3월</option>';
			}else{
				html += '<option value="2">3월</option>';
			}
			if(data.today_info.search_month === 4){
				html += '<option value="3" selected>4월</option>';
			}else{
				html += '<option value="3">4월</option>';
			}
			if(data.today_info.search_month === 5){
				html += '<option value="4" selected>5월</option>';
			}else{
				html += '<option value="4">5월</option>';
			}
			if(data.today_info.search_month === 6){
				html += '<option value="5" selected>6월</option>';
			}else{
				html += '<option value="5">6월</option>';
			}
			if(data.today_info.search_month === 7){
				html += '<option value="6" selected>7월</option>';
			}else{
				html += '<option value="6">7월</option>';
			}
			if(data.today_info.search_month === 8){
				html += '<option value="7" selected>8월</option>';
			}else{
				html += '<option value="7">8월</option>';
			}
			if(data.today_info.search_month === 9){
				html += '<option value="8" selected>9월</option>';
			}else{
				html += '<option value="8">9월</option>';
			}
			if(data.today_info.search_month === 10){
				html += '<option value="9" selected>10월</option>';
			}else{
				html += '<option value="9">10월</option>';
			}
			if(data.today_info.search_month === 11){
				html += '<option value="10" selected>11월</option>';
			}else{
				html += '<option value="10">11월</option>';
			}
			if(data.today_info.search_month === 12){
				html += '<option value="11" selected>12월</option>';
			}else{
				html += '<option value="11">12월</option>';
			}
			html += '</select>';
			html += '<button type="button" class="submit" onclick="mainOrganDateList();">확인</button>';
			html += '<a href="" class="btn main__more"></a></div></div>';
			html += '<div class="main__calendar-body">';
			html += '<table class="calendar">';
			html += '<thead><tr>';
			html += '<th><span>일</span></th><th><span>월</span></th><th><span>화</span></th><th><span>수</span></th><th><span>목</span></th><th><span>금</span></th><th><span>토</span></th>';
			html += '</tr></thead>';
			html += '<tbody><tr>';
			
			for(var i=0;i<data.dateList.length;i++){				
				/* if(data.dateList[i].value === 'today'){
					html += '<td><span>'+data.dateList[i].date+'</span></td>';
				} */
				if(i%7 === 6){
					html += '<td class="sat_day"><span class="blue">'+data.dateList[i].date+'</span>';
					if(data.dateList[i].value != null){
						for(var j=0;j<data.dateList[i].value.length;j++){
							console.log(data.dateList[i].value[j].schNo);
							html += '<a href="" class="blue">'+data.dateList[i].value[j].schTitle+'</a>';
						}
					}
				}else if(i%7 === 0){
					html += '</tr><tr><td class="sun_day"><span class="red">'+data.dateList[i].date+'</span>';
					if(data.dateList[i].value != null){
						for(var j=0;j<data.dateList[i].value.length;j++){
							console.log(data.dateList[i].value[j].schNo);
							html += '<a href="" class="blue">'+data.dateList[i].value[j].schTitle+'</a>';
						}
					}
				}else{
					html += '<td><span>'+data.dateList[i].date+'</span>';
					if(data.dateList[i].value != null){
						for(var j=0;j<data.dateList[i].value.length;j++){
							console.log(data.dateList[i].value[j].schNo);
							html += '<a href="" class="blue">'+data.dateList[i].value[j].schTitle+'</a>';
						}
					}					
				}	
				html += '</td>';
			}
			html += '</tbody>';
			html += '</table>';
			html += '</div>';
			
			$('.main__calendar').html(html)	
		},
		error: function (request, status, error){
			console.log(error);
		}
	});
}
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
                    
                    <a href="javascript:fn_MoveUrl('5','5','1','/pr/notice.c')">
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
                            <input type="hidden" name="idx" id="idx"> <!-- 해당 게시글 idx -->
                        </div>                                                        
                        <div class="actions ml-auto">
                            <a href="" class="btn main__more"></a>
                        </div>
                    </div>
                    
                    <div class="content" id="tab1"><!-- 전체내용 들어갈 곳 --></div>
                    
                    <div class="content" id="tab2" style="display: none;">
                    	<!-- 공지내용 들어갈 곳 -->
                    </div>
                    
                    <div class="content" id="tab3" style="display: none;">
                    	<!-- 채용내용 들어갈 곳 -->
                    </div>
                    
                    <div class="content" id="tab4" style="display: none;">
                    	<!-- 보도내용 들어갈 곳 -->
                    </div>
                    
                    <div class="content" id="tab5" style="display: none;">
                    	<!-- 홍보내용 들어갈 곳 -->
                    </div>
                    
                    <div class="content" id="tab6" style="display: none;">
                    	<!-- 설문내용 들어갈 곳 -->
                    </div>
                    
                </div>
                <div class="right">
                    <div class="main__content-header">
                        <h3 class="title">기관소식</h3>
                        <!-- ${mainOrganEventList} 
                        	<img src="/imageView.do?imageName=${forum.brdFileNm}" alt="" style="width: 360px; height: 250px;">
                        -->                        
                        <div class="actions">
                            <button type="button" class="btn main__news-prev"></button>
                            <button type="button" class="btn main__news-next"></button>
                            <a href="javascript:fn_MoveUrl('5','5','2','/pr/comnews.c')" class="btn main__more"></a>
                        </div>
                    </div>
                    <div class="main__news">
                        <div class="slider">
                        	<c:forEach items="${mainOrganEventList}" var="mainOrganEventList">
                        		<div class="main__news-item">
                                    <a href="javascript:goView(${mainOrganEventList.brdContNo},6)" class="block">
                                    	<c:choose>
	                                    	<c:when test="${mainOrganEventList.brdFileNm ne ''}">
	                                    		<div class="img">
		                                    		<img src="/imageView.do?imageName=${mainOrganEventList.brdFileNm}" alt="" style="width: 550px; height: 270px;">
		                                    		<!-- <img src="//via.placeholder.com/550x270" alt=""> -->
	                                    		</div>
	                                    	</c:when>
	                                    	<c:otherwise>
	                                    		<div class="img">
	                                    			<img src="${pageContext.request.contextPath}/resource/assets/images/news-img.png" alt="" style="width: 550px; height: 270px;">
	                                    		</div>
	                                    	</c:otherwise>
	                                    </c:choose>                                         
                                        <p>${mainOrganEventList.brdTitle}</p>
                                    </a>
                                </div>
                        	</c:forEach>                                                           
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
                    <a href="javascript:fn_MoveUrl('2','1','0','/donate/member.c')">자세히보기</a>
                </div>
            </div>
            <div class="col col2">
                <h3>하늘나라 편지</h3>
                <p>
                    하늘에 있는 그리운 당신에게<br/>
                    편지를 보냅니다. 보고 싶습니다.
                </p>
                <div>
                    <a href="javascript:fn_MoveUrl('2','2','0','/donate/letter.c')">자세히보기</a>
                </div>
            </div>
            <div class="col col3">
                <h3>수혜자 편지</h3>
                <p>
                    내게 주어진 두번째 삶,<br/>
                    잊지 않고 살겠습니다.
                </p>
                <div>
                    <a href="javascript:fn_MoveUrl('2','3','0','/donate/receipt.c')">자세히보기</a>
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
                                    </div>
                                </div>
                                <div class="thumb">
									<blockquote class="instagram-media" data-instgrm-captioned
										data-instgrm-permalink="https://www.instagram.com/p/CKDrl3JH1po/?utm_source=ig_embed&amp;utm_campaign=loading"
										data-instgrm-version="13" style="width: 336px; height: 577px;">										
									</blockquote>
									<script async src="//www.instagram.com/embed.js"></script>
								</div>                                
                            </div>                            
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
                                    </div>
                                </div>
                                <div class="thumb">                                    
                                  <iframe src="https://www.facebook.com/plugins/post.php?href=https%3A%2F%2Fwww.facebook.com%2Fkoda1458%2Fposts%2F1486230431526965&width=350&show_text=true&height=543&appId" width="500" height="586"></iframe>                                                                          
                                </div>                                
                            </div>                            
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
                                    </div>
                                </div>
                                <div class="thumb">
                                	<iframe src="https://m.blog.naver.com/koda1458/222206875234" width="336" height="585"></iframe>                                		    
                                </div>                                
                            </div>                            
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
                                    </div>
                                </div>
                                <div class="thumb" style="height: 585px;">
                                    <%-- <img src="${pageContext.request.contextPath}/resource/assets/images/dummy-thumb.png" alt=""> --%>                                                                    	
                                	<iframe width="336" height="290" src="https://www.youtube.com/embed/S1JIuhw2__0"></iframe>
                                	<br>                                	
                                	<iframe width="336" height="290" src="https://www.youtube.com/embed/BU2MXiwCMII"></iframe>
                                </div>
                                <!-- <div class="infobox">
                                    <h3>[2020 생명나눔 대학생 기자단 콘텐츠]</h3>
                                    <p>사후에도 장기 기증이 가능하다고?</p>
                                </div> -->
                            </div>
                            <!-- <ul class="item__links">
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
                            </ul> -->
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- calendar / partners -->
        <div class="main__infobox">
            <div class="wrap">

                <div class="main__calendar">
                    <!-- 기관일정 달력 들어갈 곳 -->
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
	                <div class="slider">
	                	<c:forEach items="${mainLifeSharingList}" var="mainLifeSharingList" varStatus="num">	                	
	                		<c:if test="${num.index <= 2}">
	                			<a onclick="goView(${mainLifeSharingList.brdContNo},7);" style="cursor: pointer;">
			                        <div class="img">
			                            <img src="/imageView.do?imageName=${mainLifeSharingList.brdFileNm}" alt="" style="width: 300px; height: 300px;">
			                        </div>
			                        <p>
			                            ${fn:substring(mainLifeSharingList.brdTitle,0,20)}...
			                        </p>
			                    </a>
	                		</c:if>
	                	</c:forEach>                		                                                         
	                </div>
                </div>
                <div class="item">
                    <div class="slider">
                        <div class="storySlide__item" style="background-image: url('${pageContext.request.contextPath}/resource/assets/images/story-slide1.png')">
                            <h2>생명나눔 스토리</h2>
                            <p>
			                                가슴 따뜻해지는<br/>
			                                생명 나눔 이야기를 소개합니다
                            </p>

                            <a href="javascript:fn_MoveUrl('5','2','2','/pr/lifeSharing.c')">더 보러가기</a>
                        </div>
                        <div class="storySlide__item" style="background-image: url('${pageContext.request.contextPath}/resource/assets/images/story-slide1.png')">
                            <h2>생명나눔 스토리</h2>
                            <p>
			                                가슴 따뜻해지는<br/>
			                                생명 나눔 이야기를 소개합니다
                            </p>

                            <a href="javascript:fn_MoveUrl('5','2','2','/pr/lifeSharing.c')">더 보러가기</a>
                        </div>
                        <div class="storySlide__item" style="background-image: url('${pageContext.request.contextPath}/resource/assets/images/story-slide1.png')">
                            <h2>생명나눔 스토리</h2>
                            <p>
			                                가슴 따뜻해지는<br/>
			                                생명 나눔 이야기를 소개합니다
                            </p>

                            <a href="javascript:fn_MoveUrl('5','2','2','/pr/lifeSharing.c')">더 보러가기</a>
                        </div>
                    </div>
                </div>
                <div class="item">
                    <div class="slider">
	                	<c:forEach items="${mainLifeSharingList}" var="mainLifeSharingList" varStatus="num">
	                		<c:if test="${num.index >= 3 and num.index <=5}">
	                			<a onclick="goView(${mainLifeSharingList.brdContNo},7);" style="cursor: pointer;">
			                        <div class="img">
			                            <img src="/imageView.do?imageName=${mainLifeSharingList.brdFileNm}" alt="" style="width: 300px; height: 300px;">
			                        </div>
			                        <p>
			                            ${fn:substring(mainLifeSharingList.brdTitle,0,20)}...
			                        </p>
			                    </a>
	                		</c:if>
	                	</c:forEach>                		                                                         
	                </div>
                </div>
                <div class="item">
                	<div class="slider">
	                    <c:forEach items="${mainLifeSharingList}" var="mainLifeSharingList" varStatus="num">
	                		<c:if test="${num.index >= 6 and num.index <=8}">
	                			<a onclick="goView(${mainLifeSharingList.brdContNo},7);" style="cursor: pointer;">
			                        <div class="img">
			                            <img src="/imageView.do?imageName=${mainLifeSharingList.brdFileNm}" alt="" style="width: 300px; height: 300px;">
			                        </div>
			                        <p>
			                            ${fn:substring(mainLifeSharingList.brdTitle,0,20)}...
			                        </p>
			                    </a>
	                		</c:if>
	                	</c:forEach>
                	</div>
                </div>
                <div class="item">
                	<div class="slider">
	                    <c:forEach items="${mainLifeSharingList}" var="mainLifeSharingList" varStatus="num">
	                		<c:if test="${num.index >= 9 and num.index <=11}">
	                			<a onclick="goView(${mainLifeSharingList.brdContNo},7);" style="cursor: pointer;">
			                        <div class="img">
			                            <img src="/imageView.do?imageName=${mainLifeSharingList.brdFileNm}" alt="" style="width: 300px; height: 300px;">
			                        </div>
			                        <p>
			                            ${fn:substring(mainLifeSharingList.brdTitle,0,20)}...
			                        </p>
			                    </a>
	                		</c:if>
	                	</c:forEach>
                	</div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
