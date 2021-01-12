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

</script>
</head>
<body>

	<input type="hidden" id="monthNow" name="monthNow" value="${monthNow}">
    <input type="hidden" id="yearNow" name="yearNow" value="${yearNow}">
	<div class="wrap">
                <div class="sub__header">
                    <h2>기증 현황</h2>
                </div>
                <div class="info__content">
                    <div class="time relative">
                         <p class="flex">
                            <c:forEach var="brain" items="${brainMonthSumList }" varStatus="status" >
								<c:if test="${status.last}">
	                            	<strong><c:out value="${brain.statsDate}"/></strong>기준
								</c:if>
		               		</c:forEach>
                        </p>
                        <div class="promote__select absolute right-0">
                            <select name="yearIdx" id="yearIdx" onchange="goSearch('year');">
                            <c:forEach var="year" items="${yearList }" varStatus="status">
                        		<option value="<c:out value="${year.year }"/>" <c:if test="${year.year eq yearNow}"> selected </c:if>><c:out value="${year.year }"/>년</option>
							</c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="tab-area" >
                        <div class="tabBtn flex">
                            <a href="#tab1" class="active">월별 뇌사자 장기 기증건 추이</a>
                            <a href="#tab2">월별 뇌사자 조직 기증건 추이</a>
                        </div>
                        <div class="tabCont" id="tab1">
                            <div class="tabItem">
                                <div class="box">
                                    <div class="barChart6">
                                        <p class="unit">단위 : 명</p>
                                        <div class="status" id="chart2Ytotal">
                                            <div class="col type1">
                                                <header>
                                                    전국 <strong>404</strong>
                                                </header>
                                                <div class="progress">
                                                    <span style="width: 40%;"></span>
                                                </div>
                                                <p><!-- 전일대비(+2) --></p>
                                            </div>
                                            <div class="col type2">
                                                <header>
                                                    중부권역 <strong>223</strong>
                                                </header>
                                                <div class="progress">
                                                    <span style="width: 40%;"></span>
                                                </div>
                                                <p><!-- 전일대비(+2) --></p>
                                            </div>
                                            <div class="col type3">
                                                <header>
                                                    충청·호남권역 <strong>72</strong>
                                                </header>
                                                <div class="progress">
                                                    <span style="width: 40%;"></span>
                                                </div>
                                                <p><!-- 전일대비(+2) --></p>
                                            </div>
                                            <div class="col type4">
                                                <header>
                                                    영남권역 <strong>23</strong>
                                                </header>
                                                <div class="progress">
                                                    <span style="width: 40%;"></span>
                                                </div>
                                                <p><!-- 전일대비(+2) --></p>
                                            </div>
                                        </div>
                                        <canvas id="chart2graph"></canvas>
                                    </div>


                                </div>
                                <div class="box">
                                    <div class="subTit">
                                        <h3>월별 뇌사자 장기 기증건 추이표</h3>
                                    </div>
                                    <div class="scrollbox">
                                        <div class="table infoTable border-orange">
                                            <table id="chart2Table">
                                                <colgroup>
                                                    <col width="240px" class="m-width-150">
                                                    <col>
                                                    <col>
                                                    <col>
                                                    <col>
                                                    <col>
                                                    <col>
                                                    <col>
                                                    <col>
                                                    <col>
                                                    <col>
                                                    <col>
                                                    <col>
                                                </colgroup>
                                                <thead>
                                                    <tr>
                                                        <th class="orange">월</th>
                                                        <th class="orange">1월</th>
                                                        <th class="orange">2월</th>
                                                        <th class="orange">3월</th>
                                                        <th class="orange">4월</th>
                                                        <th class="orange">5월</th>
                                                        <th class="orange">6월</th>
                                                        <th class="orange">7월</th>
                                                        <th class="orange">8월</th>
                                                        <th class="orange">9월</th>
                                                        <th class="orange">10월</th>
                                                        <th class="orange">11월</th>
                                                        <th class="orange">12월</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td class="orange bg-gray">중부권역</td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="orange bg-gray">충청·호남권역</td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="orange bg-gray">영남권역</td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="orange bg-gray">월별누적</td>
                                                        <td class="orange"></td>
                                                        <td class="orange"></td>
                                                        <td class="orange"></td>
                                                        <td class="orange"></td>
                                                        <td class="orange"></td>
                                                        <td class="orange"></td>
                                                        <td class="orange"></td>
                                                        <td class="orange"></td>
                                                        <td class="orange"></td>
                                                        <td class="orange"></td>
                                                        <td class="orange"></td>
                                                        <td class="orange"></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                                <div class="box">
                                    <div class="subTit flex justify-between">
                                        <h3 class="flex items-center">
                                            권역별 월 장기 기증건 추이
                                            <span class="ml-2">
                                            	<c:forEach var="brain" items="${brainList }" varStatus="status" >
	               								(<c:out value="${brain.statsDate}"/> 기준)
	               								</c:forEach>
	               							</span>
                                        </h3>
                                        <div class="promote__select">
                                            <select name="monthIdx" id="monthIdx" onchange="goSearch('month');">
					                            <c:forEach var="month" items="${monthList }" varStatus="status">
					                        		<option value="<c:out value="${month.month }"/>" <c:if test="${month.month eq monthNow}"> selected </c:if>><c:out value="${month.month }"/>월</option>
												</c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="blockList flex">
	               						<c:forEach var="brain" items="${brainList }" varStatus="status" >
                                        <div class="item red flex">
                                            전국<strong><fmt:formatNumber value="${brain.statsSphereTdonor3 + brain.statsSphereTdonor2 + brain.statsSphereTdonor1 }" pattern="###,###"/></strong>
                                        </div>
                                        <div class="item green flex">
                                            중부권역<strong><fmt:formatNumber value="${brain.statsSphereTdonor1 }" pattern="###,###"/></strong>
                                        </div>
                                        <div class="item blue flex">
                                            충청·호남권역<strong><fmt:formatNumber value="${brain.statsSphereTdonor2 }" pattern="###,###"/></strong>
                                        </div>
                                        <div class="item orange flex">
                                            영남권역<strong><fmt:formatNumber value="${brain.statsSphereTdonor3 }" pattern="###,###"/></strong>
                                        </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="tabCont" id="tab2" style="display:none">
                            <div class="tabItem">
                                <div class="box">
                                    <div class="barChart6">
                                        <p class="unit">단위 : 명</p>
                                        <div class="status" id="chart1Ytotal">
                                            <div class="col type1">
                                                <header>
                                                    전국 <strong>404</strong>
                                                </header>
                                                <div class="progress">
                                                    <span style="width: 40%;"></span>
                                                </div>
                                                <p><!-- 전일대비(+2) --></p>
                                            </div>
                                            <div class="col type2">
                                                <header>
                                                    중부권역 <strong>223</strong>
                                                </header>
                                                <div class="progress">
                                                    <span style="width: 40%;"></span>
                                                </div>
                                                <p><!-- 전일대비(+2) --></p>
                                            </div>
                                            <div class="col type3">
                                                <header>
                                                    충청·호남권역 <strong>72</strong>
                                                </header>
                                                <div class="progress">
                                                    <span style="width: 40%;"></span>
                                                </div>
                                                <p><!-- 전일대비(+2) --></p>
                                            </div>
                                            <div class="col type4">
                                                <header>
                                                    영남권역 <strong>23</strong>
                                                </header>
                                                <div class="progress">
                                                    <span style="width: 40%;"></span>
                                                </div>
                                                <p><!-- 전일대비(+2) --></p>
                                            </div>
                                        </div>
                                        <canvas id="chart1graph"></canvas>
                                    </div>


                                </div>
                                <div class="box">
                                    <div class="subTit">
                                        <h3>월별 뇌사자 조직 기증건 추이표</h3>
                                    </div>
                                    <div class="scrollbox">
                                        <div class="table infoTable border-orange">
                                            <table id="chart1Table">
                                                <colgroup>
                                                    <col width="240px" class="m-width-150">
                                                    <col>
                                                    <col>
                                                    <col>
                                                    <col>
                                                    <col>
                                                    <col>
                                                    <col>
                                                    <col>
                                                    <col>
                                                    <col>
                                                    <col>
                                                    <col>
                                                </colgroup>
                                                <thead>
                                                    <tr>
                                                        <th class="orange">월</th>
                                                        <th class="orange">1월</th>
                                                        <th class="orange">2월</th>
                                                        <th class="orange">3월</th>
                                                        <th class="orange">4월</th>
                                                        <th class="orange">5월</th>
                                                        <th class="orange">6월</th>
                                                        <th class="orange">7월</th>
                                                        <th class="orange">8월</th>
                                                        <th class="orange">9월</th>
                                                        <th class="orange">10월</th>
                                                        <th class="orange">11월</th>
                                                        <th class="orange">12월</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td class="orange bg-gray">중부권역</td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="orange bg-gray">충청·호남권역</td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="orange bg-gray">영남권역</td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="orange bg-gray">월별누적</td>
                                                        <td class="orange"></td>
                                                        <td class="orange"></td>
                                                        <td class="orange"></td>
                                                        <td class="orange"></td>
                                                        <td class="orange"></td>
                                                        <td class="orange"></td>
                                                        <td class="orange"></td>
                                                        <td class="orange"></td>
                                                        <td class="orange"></td>
                                                        <td class="orange"></td>
                                                        <td class="orange"></td>
                                                        <td class="orange"></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                                <div class="box">
                                    <div class="subTit flex justify-between">
                                        <h3 class="flex items-center">
                                            권역별 월 조직 기증건 추이
                                            <span class="ml-2">
                                            	<c:forEach var="brain" items="${brainList }" varStatus="status" >
	               								(<c:out value="${brain.statsDate}"/> 기준)
	               								</c:forEach>
	               							</span>
                                        </h3>
                                        <div class="promote__select">
                                            <select name="monthIdx" id="monthIdx" onchange="goSearch('month');">
					                            <c:forEach var="month" items="${monthList }" varStatus="status">
					                        		<option value="<c:out value="${month.month }"/>" <c:if test="${month.month eq monthNow}"> selected </c:if>><c:out value="${month.month }"/>월</option>
												</c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="blockList flex">
	               						<c:forEach var="brain" items="${brainList }" varStatus="status" >
                                        <div class="item red flex">
                                            전국<strong><fmt:formatNumber value="${brain.statsSphereEdonor3 + brain.statsSphereEdonor2 + brain.statsSphereEdonor1 }" pattern="###,###"/></strong>
                                        </div>
                                        <div class="item green flex">
                                            중부권역<strong><fmt:formatNumber value="${brain.statsSphereEdonor1 }" pattern="###,###"/></strong>
                                        </div>
                                        <div class="item blue flex">
                                            충청·호남권역<strong><fmt:formatNumber value="${brain.statsSphereEdonor2 }" pattern="###,###"/></strong>
                                        </div>
                                        <div class="item orange flex">
                                            영남권역<strong><fmt:formatNumber value="${brain.statsSphereEdonor3 }" pattern="###,###"/></strong>
                                        </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js"></script>

    <script>
    var jan = [0,0,0];
    var feb = [0,0,0];
    var mar = [0,0,0];
    var apr = [0,0,0];
    var may = [0,0,0];
    var jun = [0,0,0];
    var jul = [0,0,0];
    var aug = [0,0,0];
    var sep = [0,0,0];
    var oct = [0,0,0];
    var nov = [0,0,0];
    var dec = [0,0,0];
    var area = ["서울권역","충청·호남권역","영남권역"];
    
    $(document).ready(function(){
		
		<c:forEach var="brain" items="${brainMonthSumList }" varStatus="status">
	    	<c:choose>
	    		<c:when test="${fn:substring(brain.statsDate, 5, 7) == '01' }">
	    			jan = [${brain.statsSphereTdonor1 }, ${brain.statsSphereTdonor2 }, ${brain.statsSphereTdonor3 }];
	        	</c:when>
	        	
	        	<c:when test="${fn:substring(brain.statsDate, 5, 7) == '02' }">
	        		feb = [${brain.statsSphereTdonor1 }, ${brain.statsSphereTdonor2 }, ${brain.statsSphereTdonor3 }];
	        	</c:when>
	        	
	        	<c:when test="${fn:substring(brain.statsDate, 5, 7) == '03' }">
	        		mar = [${brain.statsSphereTdonor1 }, ${brain.statsSphereTdonor2 }, ${brain.statsSphereTdonor3 }];
	        	</c:when>
	        	
	        	<c:when test="${fn:substring(brain.statsDate, 5, 7) == '04' }">
					apr = [${brain.statsSphereTdonor1 }, ${brain.statsSphereTdonor2 }, ${brain.statsSphereTdonor3 }];
	        	</c:when>
	        	
	        	<c:when test="${fn:substring(brain.statsDate, 5, 7) == '05' }">
					may = [${brain.statsSphereTdonor1 }, ${brain.statsSphereTdonor2 }, ${brain.statsSphereTdonor3 }];
	        	</c:when>
				
				<c:when test="${fn:substring(brain.statsDate, 5, 7) == '06' }">
					jun = [${brain.statsSphereTdonor1 }, ${brain.statsSphereTdonor2 }, ${brain.statsSphereTdonor3 }];
	        	</c:when>
					
				<c:when test="${fn:substring(brain.statsDate, 5, 7) == '07' }">
					jul = [${brain.statsSphereTdonor1 }, ${brain.statsSphereTdonor2 }, ${brain.statsSphereTdonor3 }];
	        	</c:when>
					
				<c:when test="${fn:substring(brain.statsDate, 5, 7) == '08' }">
					aug = [${brain.statsSphereTdonor1 }, ${brain.statsSphereTdonor2 }, ${brain.statsSphereTdonor3 }];
	        	</c:when>
					
				<c:when test="${fn:substring(brain.statsDate, 5, 7) == '09' }">
					sep = [${brain.statsSphereTdonor1 }, ${brain.statsSphereTdonor2 }, ${brain.statsSphereTdonor3 }];
	        	</c:when>
					
				<c:when test="${fn:substring(brain.statsDate, 5, 7) == '10' }">
					oct = [${brain.statsSphereTdonor1 }, ${brain.statsSphereTdonor2 }, ${brain.statsSphereTdonor3 }];
	        	</c:when>
					
				<c:when test="${fn:substring(brain.statsDate, 5, 7) == '11' }">
					nov = [${brain.statsSphereTdonor1 }, ${brain.statsSphereTdonor2 }, ${brain.statsSphereTdonor3 }];
	        	</c:when>
					
				<c:when test="${fn:substring(brain.statsDate, 5, 7) == '12' }">
					dec = [${brain.statsSphereTdonor1 }, ${brain.statsSphereTdonor2 }, ${brain.statsSphereTdonor3 }];
	        	</c:when>
	    	</c:choose>
		</c:forEach>
		showGraph ('chart2');
		
		
	    <c:forEach var="brain" items="${brainMonthSumList }" varStatus="status">
			<c:choose>
				<c:when test="${fn:substring(brain.statsDate, 5, 7) == '01' }">
					jan = [${brain.statsSphereEdonor1 }, ${brain.statsSphereEdonor2 }, ${brain.statsSphereEdonor3 }];
		    	</c:when>
		    	
		    	<c:when test="${fn:substring(brain.statsDate, 5, 7) == '02' }">
		    		feb = [${brain.statsSphereEdonor1 }, ${brain.statsSphereEdonor2 }, ${brain.statsSphereEdonor3 }];
		    	</c:when>
		    	
		    	<c:when test="${fn:substring(brain.statsDate, 5, 7) == '03' }">
		    		mar = [${brain.statsSphereEdonor1 }, ${brain.statsSphereEdonor2 }, ${brain.statsSphereEdonor3 }];
		    	</c:when>
		    	
		    	<c:when test="${fn:substring(brain.statsDate, 5, 7) == '04' }">
					apr = [${brain.statsSphereEdonor1 }, ${brain.statsSphereEdonor2 }, ${brain.statsSphereEdonor3 }];
		    	</c:when>
		    	
		    	<c:when test="${fn:substring(brain.statsDate, 5, 7) == '05' }">
					may = [${brain.statsSphereEdonor1 }, ${brain.statsSphereEdonor2 }, ${brain.statsSphereEdonor3 }];
		    	</c:when>
				
				<c:when test="${fn:substring(brain.statsDate, 5, 7) == '06' }">
					jun = [${brain.statsSphereEdonor1 }, ${brain.statsSphereEdonor2 }, ${brain.statsSphereEdonor3 }];
		    	</c:when>
					
				<c:when test="${fn:substring(brain.statsDate, 5, 7) == '07' }">
					jul = [${brain.statsSphereEdonor1 }, ${brain.statsSphereEdonor2 }, ${brain.statsSphereEdonor3 }];
		    	</c:when>
					
				<c:when test="${fn:substring(brain.statsDate, 5, 7) == '08' }">
					aug = [${brain.statsSphereEdonor1 }, ${brain.statsSphereEdonor2 }, ${brain.statsSphereEdonor3 }];
		    	</c:when>
					
				<c:when test="${fn:substring(brain.statsDate, 5, 7) == '09' }">
					sep = [${brain.statsSphereEdonor1 }, ${brain.statsSphereEdonor2 }, ${brain.statsSphereEdonor3 }];
		    	</c:when>
					
				<c:when test="${fn:substring(brain.statsDate, 5, 7) == '10' }">
					oct = [${brain.statsSphereEdonor1 }, ${brain.statsSphereEdonor2 }, ${brain.statsSphereEdonor3 }];
		    	</c:when>
					
				<c:when test="${fn:substring(brain.statsDate, 5, 7) == '11' }">
					nov = [${brain.statsSphereEdonor1 }, ${brain.statsSphereEdonor2 }, ${brain.statsSphereEdonor3 }];
		    	</c:when>
					
				<c:when test="${fn:substring(brain.statsDate, 5, 7) == '12' }">
					dec = [${brain.statsSphereEdonor1 }, ${brain.statsSphereEdonor2 }, ${brain.statsSphereEdonor3 }];
		    	</c:when>
			</c:choose>
		</c:forEach>
		
		showGraph ('chart1');
		
		$(document).on('click', '.tab-area a', function () {
            $('.tab-area a').removeClass("active");
            $("a[href='"+ $(this).attr("href") +"']").addClass("active");
            
            $(".tabCont").hide();

            var activeTab = $(this).attr("href");
            $(activeTab).fadeIn();
      	  	
            return false;
        })	

	});
    
	function showGraph (chartId) {			
		var months = [jan,feb,mar,apr,may,jun,jul,aug,sep,oct,nov,dec];						
		var monthsName = ['jan','feb','mar','apr','may','jun','jul','aug','sep','oct','nov','dec'];
		var tableId = "#"+chartId+"Table"
		var ytotalId = "#"+chartId+"Ytotal";
		//월별 합계 계산
		eachMonthSum = new Array;

		for (i=0;i<months.length;i++) {								
			monthSum = 0;								
			for (k=0; k < 3; k++) {
				if( months[i][k] ) {
					monthSum += months[i][k];
				}
			}
			eachMonthSum.push(monthSum);//월별 합계 배열														
		}
									
		//연간 권역별 합산
		areaSum = [0,0,0];
		for (i=0;i<months.length;i++) {									
			for (k=0;k<months[i].length;k++) {									
				areaSum[k] += months[i][k];
			}												
		}
		
		//전체 합산
		tatalSum = 0;
		for (i=0;i<months[0].length;i++) {									
				tatalSum += areaSum[i];
		}	
		
		areaSum.unshift(tatalSum);
		for (i=0;i<areaSum.length;i++) {	
			$(ytotalId+' strong').eq(i).text(areaSum[i])
		}
		
		// 그래프 그리기		
		drawGraf(chartId, months);
		//표에 데이터 출력
		for (i=0;i<months.length;i++) {
			for (k=0;k<months[i].length;k++) {
				var td = i+2;
				var tr = k+1;
				var val = months[i][k];
				var mTotal = eachMonthSum[i];
				$(tableId+" tr:nth-child("+tr+") td:nth-child("+td+")").text(val);
				$(tableId+" tr:nth-child(4) td:nth-child("+td+")").text(mTotal);
			}												
		}
	}	
	
	function goSearch(flg){
		if(flg == "year"){
			$('#monthNow').val('');
			$('#yearNow').val($('#yearIdx').val());
		}else{
			$('#monthNow').val($('#monthIdx').val());
			$('#yearNow').val($('#yearIdx').val());
		}
		
		$('#frm_url').attr('action', '/info/infodonate.c').submit();
	}
	
	function drawGraf(chartId, months){
		var ctx = document.getElementById(chartId+'graph').getContext('2d');
		
		var data1 = [];
		var data2 = [];
		var data3 = [];
		
		for (i=0;i<months.length;i++) {
			data1[i] = months[i][0];
			data2[i] = months[i][1];
			data3[i] = months[i][2];
		}
		
	      var barChartData = {
	        labels: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	        datasets: [{
	          label: '영남권역',
	          backgroundColor: '#f1a24e',
	          stack: 'bar',
	          data: data3,
	          order: 1
	        }, {
	          label: '충청·호남권역',
	          backgroundColor: '#2e81b1',
	          stack: 'bar',
	          data: data2,
	          order: 1
	        }, {
	          label: '중부권역',
	          backgroundColor: '#4aa179',
	          stack: 'bar',
	          data: data1,
	          order: 1
	        }]
	      };
	      
	      var myChart = new Chart(ctx, {
	        type: 'bar',
	        data: barChartData,
	        options: {
	          showAllTooltips: true,
	        }
	      });
	}
      
    </script>
</body>
</html>
