<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/paging.tld"%>
<%@ taglib prefix="cfn" uri="/WEB-INF/tlds/comFunction.tld"%>


<%
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String now = sdf.format(new Date());
%>
<!doctype html>
<html lang="ko">
<head>
<script id="jscode">
$(document.body).ready(function(){
	$(document).on('click', '.sub__tabs a', function () {
        $('.sub__tabs a').removeClass("active");
        $("a[href='"+ $(this).attr("href") +"']").addClass("active");
        
        $(".process").hide();
        $(".content").hide();

        var activeTab = $(this).attr("href");
        $(activeTab).fadeIn();

  	  	$('.sub__tabs .select button').html($(this).html());
  	  	
        return false;
    })	

    
    $(document).on('click', '.sub__tabs .select .dropdown a' , function () {
  	  	$('.sub__tabs .select button').siblings('.dropdown').stop().slideToggle();
  	  	
        return false;
    })	

    $(document).on('click', '.areaView .view button', function (e) {
    	 e.preventDefault();
         $(this).toggleClass('active')
         $(this).parents('.table').find('table').toggleClass('active');
    })
    

    $(document).on('click', '.areatab a', function (e) {
    	e.preventDefault();
	    var value = $(this).data('id');
	    $('.areatab a').removeClass('active');
	    $(this).addClass('active');
	    $('.areaView .view').hide();
	    $('.areaView .view.view' + value).stop().fadeIn();
    })
});

</script>
</head>
<body>

            <div class="wrap">
                <div class="sub__header">
                    <h2>DIP 협약기관</h2>
                </div>

                <div class="sub__tabs">
                    <a href="#tab1" class="active">DIP 소개</a>
                    <a href="#tab2">DIP 협약기관 현황</a>
                    <div class="select">
                        <button>DIP 소개</button>
                        <div class="dropdown">
                            <a href="#tab1">DIP 소개</a>
                            <a href="#tab2">DIP 협약기관 현황</a>
                        </div>
                    </div>
                </div>

            <div class="process" id ="tab1">
                <div class="box box1">
                    <div class="wrap">
                        <h3>장기·조직기증 활성화 프로그램 프로세스</h3>
                        <div class="img"><img src="${pageContext.request.contextPath}/resource/assets/images/dip1.png" alt="" class="inline-block" style="max-width: 100%;"></div>
                    </div>
                </div>
                <div class="box box2">
                    <div class="wrap">
                        <h3>
                            <strong>장기·조직기증 활성화 프로그램</strong> (DIP : Donation Improvement Program)
                        </h3>
                        <p class="dots orange">
                            협약병원의 사업대상 ICU를 선정하여 협약 전·후 지속적으로 사망자 정보를 수집하고 이를 통해 뇌사추정자의 장기기증 과정 중단 시점 및 사유를 분석, 원내
                            장기기증 정책을 활성화 하고 잠재적 조직기증자의 발생 정도를 확인합니다.<br/>
                            또한 원내 의료진의 인식조사를 통해 뇌사장기기증 및 인체조직기증 관련 인식 개선을 도모하고 병원별 강점과 약점을 확인하여 자료를 제공하며, 이를 통해
                            병원별 개선점을 마련하는 원내 뇌사장기기증 및 인체조직기증 활성화를 위한 질 관리 프로그램입니다.
                        </p>
                    </div>
                </div>
                <div class="box box3">
                    <div class="wrap">
                        <h3>
                            <strong>DIP 위원회</stron> (DIPC : Donation Improvement Program Committee)</h3>
                        <div class="list flex">
                            <div class="item">
                                <div class="tit">DIP 위원회 구성</div>
                                <img src="${pageContext.request.contextPath}/resource/assets/images/i-dip1.png" alt="" class="img">
                                <div class="txt">
                                    <p>
                                        병원경영진, 신경외과 의료진 또는 신경과
                                        의료진, 응급의학과 의료진, 사업대상 중환
                                        자실 수간호사 포함 4~6인 이상으로 구성
                                        (위원장, 간사, DIP Link 선정)
                                    </p>
                                    <p class="small">DIP LINK : 뇌사추정자 인지 후 콜센터에 알리는 역할</p>
                                </div>
                            </div>
                            <div class="item">
                                <div class="tit">DIP 위원회 역할</div>
                                <img src="${pageContext.request.contextPath}/resource/assets/images/i-dip2.png" alt="" class="img">
                                <div class="txt">
                                    <p>
                                        협약병원 대상으로 기증 과정 단계를 평가하여 기증정책 마련 및 프로토콜 개선
                                    </p>
                                </div>
                            </div>
                            <div class="item">
                                <div class="tit">DIP 위원회 회의 내용 (연 2~3회)</div>
                                <img src="${pageContext.request.contextPath}/resource/assets/images/i-dip3.png" alt="" class="img">
                                <div class="txt">
                                    <p class="dots mint">
                                        MRR과 HAS 분석자료를 통한 병원의 기증 관련 강·약점 분석
                                    </p>
                                    <p class="dots mint">
                                        분석결과를 토대로 병원별 맞춤 기증 활성화 계획 수립

                                    </p>
                                    <p class="dots mint">
                                        장기·조직기증 사례 및 잠재적 장기조직 기증자 발굴을 위한 논의
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="content" id="tab2" style="display: none;">
			<div class="areatab">
				<a href="#//" class="active" data-id="1">전국</a> <a href="#//"
					data-id="2">중부지부</a> <a href="#//" data-id="3">충청·호남지부</a> <a
					href="#//" data-id="4">영남지부</a>
			</div>
			<div class="areaView">
				<div class="view view1">
					<div class="box">
						<div class="map">
							<img
								src="${pageContext.request.contextPath}/resource/assets/images/11-map1.png"
								alt="">
						</div>
						<div class="list">
							<div class="table">	
							<p class="info-section__description">
										뇌사장기기증자 관리업무 협약 병원
										</p>
								<button class="active">
									<h3>중부지부</h3>
									<span></span>
								</button>
								<div class="tbox">
									<table class="active tbl_bg_ty_01a">
										<tbody>
											<c:forEach var="hospital" items="${hospitalList1 }" varStatus="status" begin="1">
											<tr>
												<th><c:out value="${status.index}"/></th>
												<td><c:out value="${hospital.hospitalName }"/></td>
											</tr>
											<c:set var="hospitalIndex" value="${status.index}"/>						
											</c:forEach>
										</tbody>
									</table>
								</div>
							</div>

							<div class="table type2">
							    	<p class="info-section__description">
										뇌사장기기증자 관리업무 협약 병원
										</p>
								<button>
									<h3>충청·호남지부</h3>
									<span></span>
								</button>
								<div class="tbox">
									<table class="active tbl_bg_ty_01a">
										<tbody>

											<c:forEach var="hospital" items="${hospitalList2 }" varStatus="status" begin="1">
											<tr>
												<th><c:out value="${status.index}"/></th>
												<td><c:out value="${hospital.hospitalName }"/></td>
											</tr>
											<c:set var="hospitalIndex" value="${status.index}"/>						
											</c:forEach>

										</tbody>
									</table>
								</div>
							</div>
							<div class="table type3">
								<p class="info-section__description">
										뇌사장기기증자 관리업무 협약 병원
										</p>
								<button>
									<h3>영남지부</h3>
									<span></span>
								</button>
								<div class="tbox">
									<table class="active tbl_bg_ty_01a">
										<tbody>

											<c:forEach var="hospital" items="${hospitalList3 }" varStatus="status" begin="1">
											<tr>
												<th><c:out value="${status.index}"/></th>
												<td><c:out value="${hospital.hospitalName }"/></td>
											</tr>
											<c:set var="hospitalIndex" value="${status.index}"/>						
											</c:forEach>

										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="view view2" style="display: none;">
					<div class="box">
						<div class="map">
							<img
								src="${pageContext.request.contextPath}/resource/assets/images/11-map2.png"
								alt="">
						</div>
						<div class="list">
							<div class="table">
									<p class="info-section__description">
										뇌사장기기증자 관리업무 협약 병원
										</p>
								<button class="active">
									<h3>중부지부</h3>
									<span></span>
								</button>
								<div class="tbox">
									<table  class="active tbl_bg_ty_01a">
										<tbody>

											<c:forEach var="hospital" items="${hospitalList1 }" varStatus="status" begin="1">
											<tr>
												<th><c:out value="${status.index}"/></th>
												<td><c:out value="${hospital.hospitalName }"/></td>
											</tr>
											<c:set var="hospitalIndex" value="${status.index}"/>						
											</c:forEach>

										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="view view3" style="display: none;">
					<div class="box">
						<div class="map">
							<img
								src="${pageContext.request.contextPath}/resource/assets/images/11-map3.png"
								alt="">
						</div>
						<div class="list">
							<div class="table type2">
							   <p class="info-section__description">
									뇌사장기기증자 관리업무 협약 병원
								</p>
								<button class="active">
									<h3>충청·호남지부</h3>
									<span></span>
								</button>
								<div class="tbox">
									<table class="active tbl_bg_ty_01a">
										<tbody>

											<c:forEach var="hospital" items="${hospitalList2 }" varStatus="status" begin="1">
											<tr>
												<th><c:out value="${status.index}"/></th>
												<td><c:out value="${hospital.hospitalName }"/></td>
											</tr>
											<c:set var="hospitalIndex" value="${status.index}"/>						
											</c:forEach>

										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="view view4" style="display: none;">
					<div class="box">
						<div class="map">
							<img
								src="${pageContext.request.contextPath}/resource/assets/images/11-map4.png"
								alt="">
						</div>
						<div class="list">
							<div class="table type3">
								<p class="info-section__description">
									뇌사장기기증자 관리업무 협약 병원
								</p>
								<button class="active">
									<h3>영남지부</h3>
									<span></span>
								</button>
								<div class="tbox">
									<table class="active tbl_bg_ty_01a">
										<tbody>

											<c:forEach var="hospital" items="${hospitalList3 }" varStatus="status" begin="1">
											<tr>
												<th><c:out value="${status.index}"/></th>
												<td><c:out value="${hospital.hospitalName }"/></td>
											</tr>
											<c:set var="hospitalIndex" value="${status.index}"/>						
											</c:forEach>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
            </div>
</body>
</html>
