<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
<script id="jscode">
$(document.body).ready(function(){

    
    $(document).on('click', '#tabcon a', function () {
        $('#tabcon a').removeClass("active");
        $(this).addClass("active");
        
        $(".tabItem").hide();

        var activeTab = $(this).attr("href");
        $(activeTab).fadeIn();
  	  	
        return false;
    })	

    
    $(document).on('click', '.sub__tabs .select .dropdown a' , function () {
  	  	$('.sub__tabs .select button').siblings('.dropdown').stop().slideToggle();
  	  	
        return false;
    })	
   
});
</script>
</head>
<body>

	<div class="wrap">
                <div class="sub__header">
                    <h2>정보공개제도 안내·청구</h2>
                </div>
                <div class="info__content">
                    <div class="tab-area">
                        <div class="tabBtn flex type2" id ="tabcon">
                            <a href="#tab1" class="active">정보공개제도 안내</a>
                            <a href="#tab2">정보공개 청구</a>
                        </div>
                        <div class="tabCont">
                            <div class="tabItem" id ="tab1">
                                <div class="box">
                                    <div class="top-txtBox flex items-center">
                                        <div class="img">
                                            <img src="${pageContext.request.contextPath}/resource/assets/images/info-top-img1.png" alt="" class="">
                                        </div>
                                        <div class="txt">
                                            <h3 class="flex items-center">
                                                <span>투명한 기관 운영 정보를 공유합니다.</span>
                                            </h3>
                                            <p>
                                                    정보공개제도란 한국장기조직기증원이 직무상 작성 또는 취득하여 관리하고 있는 정보를 수요자인 국민의 청구에 의하여<br/>
                                                    열람·사본·복제 등의 형태로 청구인에게 공개하거나 한국장기조직기증원이 자발적으로 또는 법령 등의 규정에 의하여 의무적<br/>
                                                    으로 보유하고 있는 정보를 배포 또는 공표 등의 형태로 제공하는 제도를 시행하고 있습니다.
                                                </p>
                                        </div>
                                    </div>
                                    <div class="button ml-auto">
                                        <a href="http://www.law.go.kr/%EB%B2%95%EB%A0%B9/%EA%B3%B5%EA%B3%B5%EA%B8%B0%EA%B4%80%EC%9D%98%EC%A0%95%EB%B3%B4%EA%B3%B5%EA%B0%9C%EC%97%90%EA%B4%80%ED%95%9C%EB%B2%95%EB%A5%A0" target="_blank" class="vertical flex">
                                            <i></i>
                                                공공기관 정보공개에 관한 법률
                                            </a>
                                    </div>
                                </div>
                                <div class="box">
                                    <div class="subTit">
                                        <h3>공개형태</h3>
                                    </div>
                                    <div class="boxflex flex text-center ">
                                        <div class="col flex-1 mr-10 ">
                                            <h4 class="mb-2">청구공개</h4>
                                            <p>
                                                한국장기조직기증원이 직무상 작성 또는 취득하여 관리하고 있는 정보를<br/>
                                                청구인의 청구에 의하여 공개하는 제도입니다. (예 : 공문서의 열람, 복사청구 등)
                                            </p>
                                        </div>
                                        <div class="col flex-1 ">
                                            <h4 class="mb-2">정보제공</h4>
                                            <p>
                                                정보를 보유한 한국장기조직기증원이 자발적으로 또는 법령상 의무적으로 정보를<br/>
                                                제공하는 제도입니다. (예 : 인터넷을 통한 정보 제공, 간행물의 배포 등)
                                            </p>
                                        </div>
                                    </div>
                                </div>
                                <div class="box">
                                    <div class="subTit">
                                        <h3>정보공개 대상 정보와 정보 공개 청구권자</h3>
                                    </div>
                                    <div class="scrollbox">
                                        <div class="table border-orange infoTable type2">
                                            <table>
                                                <colgroup>
                                                    <col width="200px">
                                                    <col width="200px">
                                                    <col>
                                                </colgroup>
                                                <tbody>
                                                    <tr>
                                                        <td class="font-bold bg-gray">정보공개 대상 정보</td>
                                                        <td class="font-medium text-left" colspan="2">
                                                            한국장기조직기증원이 직무상 작성 또는 취득하여 관리하고 있는 문서(전자 문서를 포함)도면, 사진, 필름, 테이프, 슬라이드 및 컴퓨터에 의하여
                                                            처리되는 매체 등에 기록된 사항
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="font-bold bg-gray" rowspan="2">정보공개 청구권자</td>
                                                        <td class="font-bold">대한민국 국민</td>
                                                        <td class="font-medium">
                                                            <p class="dots">청구인 본인 또는 대리인</p>
                                                            <p class="dots">국내 모든 법인, 단체 등</p>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="font-bold">외국인</td>
                                                        <td class="font-medium">
                                                            <p class="dots">국내에 일정한 주소를 두고 거주하는 자</p>
                                                            <p class="dots">학술,연구를 위하여 일시적으로 체류하는 자</p>
                                                            <p class="dots">국내에 사무소를 두고 있는 법인 또는 단체</p>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                                <div class="">
                                    <div class="subTit">
                                        <h3>한국장기조직기증원 정보공개 담당자</h3>
                                    </div>
                                    <div class="mb-16">
                                        <h4 class="mb-4 txt-style-orange">정보공개 책임 담당자</h4>
                                        <div class="table infoTable type-gray">
                                            <table>
                                                <colgroup>
                                                    <col>
                                                    <col>
                                                    <col>
                                                    <col>
                                                </colgroup>
                                                <thead>
                                                    <tr>
                                                        <th>구분</th>
                                                        <th>부서 및 직위</th>
                                                        <th>성명</th>
                                                        <th>연락처</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td class="font-medium">정보공개책임관</td>
                                                        <td>총무인사팀장</td>
                                                        <td>임종성</td>
                                                        <td>02-3447-5632</td>
                                                    </tr>
                                                    <tr>
                                                        <td class="font-medium">정보공개담당자</td>
                                                        <td>총무인사팀</td>
                                                        <td>김해원</td>
                                                        <td>02-3447-5632</td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <div class="">
                                        <h4 class="mb-4 txt-style-orange">공공데이터 지정·게시 담당자</h4>
                                        <div class="table infoTable type-gray">
                                            <table>
                                                <colgroup>
                                                    <col>
                                                    <col>
                                                    <col>
                                                    <col>
                                                </colgroup>
                                                <thead>
                                                    <tr>
                                                        <th>구분</th>
                                                        <th>부서 및 직위</th>
                                                        <th>성명</th>
                                                        <th>연락처</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td class="font-medium">정보공개책임관</td>
                                                        <td>전산팀장</td>
                                                        <td>최민규</td>
                                                        <td>02-3447-5632</td>
                                                    </tr>
                                                    <tr>
                                                        <td class="font-medium">정보공개담당자</td>
                                                        <td>전산팀</td>
                                                        <td>유일근</td>
                                                        <td>02-3447-5632</td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="tabItem" id = "tab2" style="display: none;">
                                <div class="box">
                                    <div class="top-txtBox flex items-center">
                                        <div class="img">
                                            <img src="${pageContext.request.contextPath}/resource/assets/images/info-top-img2.png" alt="" class="">
                                        </div>
                                        <div class="txt">
                                            <h3 class="flex items-center">
                                                <span>대한민국정보공개포털을 이용한 청구</span>
                                            </h3>
                                            <p>
                                                한국장기조직기증원은 정보 공개 서비스 접근성 향상을 위해 <a href="https://www.open.go.kr/" target="_blank">대한민국정보공개포털 (www.open.go.kr)</a>을 통해<br/>
                                                정보공개신청을 접수 받고 있습니다.<br/>
                                                - 정보공개 청구 건의 처리상태 추적 및 확인 서비스 제공<br/>
                                                - 일원화된 정보공개 행정서비스 제공
                                            </p>
                                        </div>
                                    </div>
                                    <div class="button ml-auto flex type2 justify-end">
                                        <a href="https://www.open.go.kr/pa/member/openLogin/memberLogin.do" target="_blank" class="vertical flex">
                                            <i></i>
                                            정보공개 청구 신청
                                        </a>
                                        <a href="https://www.open.go.kr/pa/help/webToon/webToonList.do" target="_blank" class="vertical flex">
                                            <i></i>
                                            정보공개 이용안내
                                        </a>
                                    </div>
                                </div>
                                <div class="">
                                    <div class="subTit">
                                        <h3 class="mb-4">한국장기조직기증원 직접 청구</h3>
                                        <p clsss="font-medium" style="font-size: 18px;">직접방문하시거나, 팩스, 이메일등으로 정보공개를 청구 하실 수 있습니다.</p>
                                    </div>
                                    <div class="table border-orange infoTable">
                                        <table>
                                            <colgroup>
                                                <col width="200px">
                                                <col>
                                            </colgroup>
                                            <tbody>
                                                <tr>
                                                    <td class="bg-gray">정보공개 담당자</td>
                                                    <td class="text-left px-4">총무인사팀장 임종성</td>
                                                </tr>
                                                <tr>
                                                    <td class="bg-gray">담당자 연락처</td>
                                                    <td class="text-left px-4">02-3447-5632~4</td>
                                                </tr>
                                                <tr>
                                                    <td class="bg-gray">담당자 e-mail</td>
                                                    <td class="text-left px-4">koda@koda1458.kr</td>
                                                </tr>
                                                <tr>
                                                    <td class="bg-gray">우편 및 방문 주소</td>
                                                    <td class="text-left px-4">(우)03741 서울시 서대문구 충정로 36 국민연금공단충정로사옥5층 한국장기조직기증원 </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            
                            
                        </div>              
                    </div>
                </div>
            </div>
	
</body>
</html>
