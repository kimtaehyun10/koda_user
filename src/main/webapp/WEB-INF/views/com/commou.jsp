<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
<script id="jscode">
$(document.body).ready(function(){
	$(document).on('click', '.categoryBtn a', function () {
        $('.categoryBtn a').removeClass("active");
        $(this).addClass("active");
        
        $(".item-wrap").hide();

        var activeTab = $(this).attr("href");
        $(activeTab).fadeIn();

        return false;
    })	

    $(document).on('click', '#subcategory1 a', function (e) {
    	e.preventDefault();
	    var value = $(this).data('id');
	    $('#subcategory1 a').removeClass('active');
	    $(this).addClass('active');
	    $('.item').hide();
	    
	    if (value == 11){
	    	$('#sub12').stop().fadeIn();
	    	$('#sub13').stop().fadeIn();
	    	$('#sub14').stop().fadeIn();
	    }else{
		    $('#sub' + value).stop().fadeIn();    	
	    }
	    
    })
    
    $(document).on('click', '#subcategory2 a', function (e) {
    	e.preventDefault();
	    var value = $(this).data('id');
	    $('#subcategory2 a').removeClass('active');
	    $(this).addClass('active');
	    $('.item').hide();
	    
	    if (value == 21){
	    	$('#sub22').stop().fadeIn();
	    	$('#sub23').stop().fadeIn();
	    	$('#sub24').stop().fadeIn();
	    }else{
		    $('#sub' + value).stop().fadeIn();    	
	    }
	    
    })
    
});
</script>
</head>
<body>

	<div class="wrap">
                <div class="sub__header">
                    <h2>협약기관</h2>
                </div>
                <div class="company__content company__convention">
                    <div class="categoryBtn flex">
                        <a href="#tab1" class="active">뇌사장기기증자 관리업무 협약병원</a>
                        <a href="#tab2">DIP 협약병원</a>
                    </div>
                    <div class="item-wrap" id="tab1">
                    	
	                    <div class="sub-category flex items-center justify-center mb-8" id ="subcategory1">
	                        <a href="#//" data-id = "11" class="active">전국</a>
	                        <span class="bar">|</span>
	                        <a href="#//" data-id = "12">중부권역 </a>
	                        <span class="bar">|</span>
	                        <a href="#//" data-id = "13">충청·호남권역</a>
	                        <span class="bar">|</span>
	                        <a href="#//" data-id = "14">영남권역</a>
	                    </div>
                        <div class="item mb-16" id="sub12">
                            <h4 class="subTit">중부권 협약병원</h4>
                            <div class="list border-orange">
                                <div class="row">
                                    <a href="" class="flex items-center">
                                        <div class="thumb">
                                            <img src="${pageContext.request.contextPath}/resource/assets//images/hospital1.png" alt="">
                                        </div>
                                        <div class="info">
                                            <div class="tit flex items-center">
                                                <h5>이대서울병원</h5>
                                                <span class="new">NEW</span>
                                            </div>
                                            <div class="txt">
                                                <p class="flex items-center">
                                                    <span class="font-medium">협약체결일</span>
                                                    <span>2020.11.09</span>
                                                </p>
                                                <p class="flex items-center">
                                                    <span class="font-medium">협약내용</span>
                                                    <span>장기·조직 기증 활성화를 통한 생명나눔 가치 실현 (예시 문구)</span>
                                                </p>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                                <div class="row">
                                    <a href="" class="flex items-center">
                                        <div class="thumb">
                                            <img src="${pageContext.request.contextPath}/resource/assets//images/hospital1.png" alt="">
                                        </div>
                                        <div class="info">
                                            <div class="tit flex items-center">
                                                <h5>이대서울병원</h5>
                                            </div>
                                            <div class="txt">
                                                <p class="flex items-center">
                                                    <span class="font-medium">협약체결일</span>
                                                    <span>2020.11.09</span>
                                                </p>
                                                <p class="flex items-center">
                                                    <span class="font-medium">협약내용</span>
                                                    <span>장기·조직 기증 활성화를 통한 생명나눔 가치 실현 (예시 문구)</span>
                                                </p>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div class="item mb-16" id="sub13">
                            <h4 class="subTit">충청·호남권 협약병원</h4>
                            <div class="list border-orange">
                                <div class="row">
                                    <a href="" class="flex items-center">
                                        <div class="thumb">
                                            <img src="${pageContext.request.contextPath}/resource/assets//images/hospital1.png" alt="">
                                        </div>
                                        <div class="info">
                                            <div class="tit flex items-center">
                                                <h5>이대서울병원</h5>
                                                <span class="new">NEW</span>
                                            </div>
                                            <div class="txt">
                                                <p class="flex items-center">
                                                    <span class="font-medium">협약체결일</span>
                                                    <span>2020.11.09</span>
                                                </p>
                                                <p class="flex items-center">
                                                    <span class="font-medium">협약내용</span>
                                                    <span>장기·조직 기증 활성화를 통한 생명나눔 가치 실현 (예시 문구)</span>
                                                </p>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                                <div class="row">
                                    <a href="" class="flex items-center">
                                        <div class="thumb">
                                            <img src="${pageContext.request.contextPath}/resource/assets//images/hospital1.png" alt="">
                                        </div>
                                        <div class="info">
                                            <div class="tit flex items-center">
                                                <h5>이대서울병원</h5>
                                            </div>
                                            <div class="txt">
                                                <p class="flex items-center">
                                                    <span class="font-medium">협약체결일</span>
                                                    <span>2020.11.09</span>
                                                </p>
                                                <p class="flex items-center">
                                                    <span class="font-medium">협약내용</span>
                                                    <span>장기·조직 기증 활성화를 통한 생명나눔 가치 실현 (예시 문구)</span>
                                                </p>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div class="item" id="sub14">
                            <h4 class="subTit">영남권 협약병원</h4>
                            <div class="list border-orange">
                                <div class="row">
                                    <a href="" class="flex items-center">
                                        <div class="thumb">
                                            <img src="${pageContext.request.contextPath}/resource/assets//images/hospital1.png" alt="">
                                        </div>
                                        <div class="info">
                                            <div class="tit flex items-center">
                                                <h5>이대서울병원</h5>
                                                <span class="new">NEW</span>
                                            </div>
                                            <div class="txt">
                                                <p class="flex items-center">
                                                    <span class="font-medium">협약체결일</span>
                                                    <span>2020.11.09</span>
                                                </p>
                                                <p class="flex items-center">
                                                    <span class="font-medium">협약내용</span>
                                                    <span>장기·조직 기증 활성화를 통한 생명나눔 가치 실현 (예시 문구)</span>
                                                </p>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                                <div class="row">
                                    <a href="" class="flex items-center">
                                        <div class="thumb">
                                            <img src="${pageContext.request.contextPath}/resource/assets//images/hospital1.png" alt="">
                                        </div>
                                        <div class="info">
                                            <div class="tit flex items-center">
                                                <h5>이대서울병원</h5>
                                            </div>
                                            <div class="txt">
                                                <p class="flex items-center">
                                                    <span class="font-medium">협약체결일</span>
                                                    <span>2020.11.09</span>
                                                </p>
                                                <p class="flex items-center">
                                                    <span class="font-medium">협약내용</span>
                                                    <span>장기·조직 기증 활성화를 통한 생명나눔 가치 실현 (예시 문구)</span>
                                                </p>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    
                    <div class="item-wrap" id="tab2" style="display:none">
                    
	                    <div class="sub-category flex items-center justify-center mb-8" id ="subcategory2">
	                        <a href="#//" data-id = "21" class="active">전국</a>
	                        <span class="bar">|</span>
	                        <a href="#//" data-id = "22">중부권역 </a>
	                        <span class="bar">|</span>
	                        <a href="#//" data-id = "23">충청·호남권역</a>
	                        <span class="bar">|</span>
	                        <a href="#//" data-id = "24">영남권역</a>
	                    </div>
                        <div class="item mb-16" id="sub22">
                            <h4 class="subTit">중부권 협약병원</h4>
                            <div class="list border-orange">
                                <div class="row">
                                    <a href="" class="flex items-center">
                                        <div class="thumb">
                                            <img src="${pageContext.request.contextPath}/resource/assets//images/hospital1.png" alt="">
                                        </div>
                                        <div class="info">
                                            <div class="tit flex items-center">
                                                <h5>이대서울병원</h5>
                                                <span class="new">NEW</span>
                                            </div>
                                            <div class="txt">
                                                <p class="flex items-center">
                                                    <span class="font-medium">협약체결일</span>
                                                    <span>2020.11.09</span>
                                                </p>
                                                <p class="flex items-center">
                                                    <span class="font-medium">협약내용</span>
                                                    <span>장기·조직 기증 활성화를 통한 생명나눔 가치 실현 (예시 문구)</span>
                                                </p>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                                <div class="row">
                                    <a href="" class="flex items-center">
                                        <div class="thumb">
                                            <img src="${pageContext.request.contextPath}/resource/assets//images/hospital1.png" alt="">
                                        </div>
                                        <div class="info">
                                            <div class="tit flex items-center">
                                                <h5>이대서울병원</h5>
                                            </div>
                                            <div class="txt">
                                                <p class="flex items-center">
                                                    <span class="font-medium">협약체결일</span>
                                                    <span>2020.11.09</span>
                                                </p>
                                                <p class="flex items-center">
                                                    <span class="font-medium">협약내용</span>
                                                    <span>장기·조직 기증 활성화를 통한 생명나눔 가치 실현 (예시 문구)</span>
                                                </p>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div class="item mb-16" id="sub23">
                            <h4 class="subTit">충청·호남권 협약병원</h4>
                            <div class="list border-orange">
                                <div class="row">
                                    <a href="" class="flex items-center">
                                        <div class="thumb">
                                            <img src="${pageContext.request.contextPath}/resource/assets//images/hospital1.png" alt="">
                                        </div>
                                        <div class="info">
                                            <div class="tit flex items-center">
                                                <h5>이대서울병원</h5>
                                                <span class="new">NEW</span>
                                            </div>
                                            <div class="txt">
                                                <p class="flex items-center">
                                                    <span class="font-medium">협약체결일</span>
                                                    <span>2020.11.09</span>
                                                </p>
                                                <p class="flex items-center">
                                                    <span class="font-medium">협약내용</span>
                                                    <span>장기·조직 기증 활성화를 통한 생명나눔 가치 실현 (예시 문구)</span>
                                                </p>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                                <div class="row">
                                    <a href="" class="flex items-center">
                                        <div class="thumb">
                                            <img src="${pageContext.request.contextPath}/resource/assets//images/hospital1.png" alt="">
                                        </div>
                                        <div class="info">
                                            <div class="tit flex items-center">
                                                <h5>이대서울병원</h5>
                                            </div>
                                            <div class="txt">
                                                <p class="flex items-center">
                                                    <span class="font-medium">협약체결일</span>
                                                    <span>2020.11.09</span>
                                                </p>
                                                <p class="flex items-center">
                                                    <span class="font-medium">협약내용</span>
                                                    <span>장기·조직 기증 활성화를 통한 생명나눔 가치 실현 (예시 문구)</span>
                                                </p>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div class="item" id="sub24">
                            <h4 class="subTit">영남권 협약병원</h4>
                            <div class="list border-orange">
                                <div class="row">
                                    <a href="" class="flex items-center">
                                        <div class="thumb">
                                            <img src="${pageContext.request.contextPath}/resource/assets//images/hospital1.png" alt="">
                                        </div>
                                        <div class="info">
                                            <div class="tit flex items-center">
                                                <h5>이대서울병원</h5>
                                                <span class="new">NEW</span>
                                            </div>
                                            <div class="txt">
                                                <p class="flex items-center">
                                                    <span class="font-medium">협약체결일</span>
                                                    <span>2020.11.09</span>
                                                </p>
                                                <p class="flex items-center">
                                                    <span class="font-medium">협약내용</span>
                                                    <span>장기·조직 기증 활성화를 통한 생명나눔 가치 실현 (예시 문구)</span>
                                                </p>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                                <div class="row">
                                    <a href="" class="flex items-center">
                                        <div class="thumb">
                                            <img src="${pageContext.request.contextPath}/resource/assets//images/hospital1.png" alt="">
                                        </div>
                                        <div class="info">
                                            <div class="tit flex items-center">
                                                <h5>이대서울병원</h5>
                                            </div>
                                            <div class="txt">
                                                <p class="flex items-center">
                                                    <span class="font-medium">협약체결일</span>
                                                    <span>2020.11.09</span>
                                                </p>
                                                <p class="flex items-center">
                                                    <span class="font-medium">협약내용</span>
                                                    <span>장기·조직 기증 활성화를 통한 생명나눔 가치 실현 (예시 문구)</span>
                                                </p>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    
                </div>
            </div>
            
            
            
	
</body>
</html>
