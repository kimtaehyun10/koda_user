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
 <script type="text/javascript">
$(document.body).ready(function(){
	$(document).on('click', '.sub__tabs a', function () {
        $('.sub__tabs a').removeClass("active");
        $("a[href='"+ $(this).attr("href") +"']").addClass("active");
        
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
			<h2>뇌사장기기증자 관리업무 협약</h2>
		</div>

		<div class="sub__tabs">
			<a href="#tab1" class="active">뇌사장기기증자 관리업무 협약이란</a>
			<a href="#tab2" class="">뇌사판정의료기관 현황</a>

			<div class="select">
				<button>뇌사장기기증자 관리업무 협약이란</button>
				<div class="dropdown">
					<a href="#tab1">뇌사장기기증자 관리업무 협약이란</a>
					<a href="#tab2">뇌사판정의료기관 현황</a>
				</div>
			</div>
		</div>
		<div class="content" id="tab1">
			<div class="relbox">
				<div class="relbox__section">
					<h3 class="codi-title">뇌사판정의료기관</h3>
					<ul class="codi-list">
						<li class="">장기 등 적출 및 이식을 위한 뇌사판정 업무를 할 수 있도록 보건복지부로부터 지정받은
							의료기관</li>
					</ul>
				</div>

				<div class="relbox__section">
					<h3 class="codi-title">뇌사장기기증자 관리업무 협약</h3>
					<ul class="codi-list">
						<li class="">뇌사추정자 발굴과 신속한 연락체계 구축, 기증자 이송 없이 신속한 뇌사판정 및 효율적인
							관리 수행, 기증을 위한 의료정보 취득과 진료 행정지원을 위해 한국장기조직기증원과 뇌사관리 병원이 맺는 협약으로
							한국장기조직기증원과 뇌사관리 협약한 병원의 기증이 지속적으로 증가하고 있습니다.</li>
					</ul>
				</div>

				<div class="relbox__section">
					<h3 class="codi-title">협약·비협약 병원별 기증 추이</h3>
					<p class="codi-desc">yearly donation by koda contracted
						hospitals and hopos</p>

					<div class="lineChart mt-4">
						<canvas id="lineChart" style=""></canvas>
					</div>
				</div>
			</div>
		</div>

		<div class="content" id="tab2" style="display: none;">
			<div class="areatab">
				<a href="#//" class="active" data-id="1">전국</a> <a href="#//"
					data-id="2">중부권역</a> <a href="#//" data-id="3">충청·호남권역</a> <a
					href="#//" data-id="4">영남권역</a>
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
								<button class="active">
									<h3>중부권역</h3>
									<span></span>
								</button>
								<div class="tbox">
									<table class="active">
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
								<button>
									<h3>충청·호남권역</h3>
									<span></span>
								</button>
								<div class="tbox">
									<table>
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
								<button>
									<h3>영남권역</h3>
									<span></span>
								</button>
								<div class="tbox">
									<table>
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
								<button class="active">
									<h3>중부권역</h3>
									<span></span>
								</button>
								<div class="tbox">
									<table class="active">
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
								<button class="active">
									<h3>충청·호남권역</h3>
									<span></span>
								</button>
								<div class="tbox">
									<table class="active">
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
								<button class="active">
									<h3>영남권역</h3>
									<span></span>
								</button>
								<div class="tbox">
									<table class="active">
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

	<script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js"></script>

    <script>

      var ctx = document.getElementById('lineChart').getContext('2d');
      var barChartData = {
        labels: ['2015', '2016', '2017', '2018', '2019'],
        datasets: [{
          label: 'HOPO 병원',
          stack: 'HOPO 병원',
          backgroundColor: 'rgba(0, 0, 0, 0.0)',
          borderColor: '#ff7e00',
          pointBackgroundColor: '#ff7e00',
          borderWidth: '2',
          lineTension: 0,
          data: [
            336, 363, 301, 223, 206
          ],
        },{
          label: 'KODA 협약병원',
          stack: 'KODA 협약병원',
          backgroundColor: 'rgba(0, 0, 0, 0.0)',
          borderColor: '#4aa079',
          pointBackgroundColor: '#4aa079',
          borderWidth: '2',
          lineTension: 0,
          data: [
            165, 210, 214, 226, 244
          ],
        }]
      };
      var myChart = new Chart(ctx, {
        type: 'line',
        data: barChartData,
        options: {
          showAllTooltips: true,
        }
      });
    </script>
</body>
</html>
