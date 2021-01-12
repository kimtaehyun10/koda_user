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
		function goDown(f,d){
			location.href = "/include/file_download.jsp?file="+encodeURI(encodeURIComponent(f))+"&path="+d;
		}
</script>
</head>
<body>

	<div class="wrap">
                <div class="sub__header">
                    <h2>이식 현황</h2>
                </div>
                <div class="info__content">
                    <div class="subTit flex justify-between">
                        <h3 class="flex items-center">
                            뇌사기증자 장기이식현황
                        </h3>
                        <div class="button">
                            <a href="" class="download flex">
                                <i></i>
                                장기이식통계자료 다운로드
                            </a>
                        </div>
                    </div>
                    <div class="scrollbox2">
                        <div class="table infoTable border-orange thin">
                            <table>
                                <colgroup>
                                    <col width="200px" class="m-width-100">
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
                                        <th rowspan="2">연도</th>
                                        <th rowspan="2">뇌사자(명)</th>
                                        <th colspan="8">이식건수</th>
                                        <th class="orange" rowspan="2">Total</th>
                                    </tr>
                                    <tr>
                                        <th>신장</th>
                                        <th>간</th>
                                        <th>췌장</th>
                                        <th>심장</th>
                                        <th>폐</th>
                                        <th>췌도</th>
                                        <th>소장</th>
                                        <th>각막</th>
                                    </tr>
                                </thead>
                                <tbody>
									<c:set var="brainTotal" value="0"/>
									<c:set var="total" value="0"/>
									<c:set var="kidneyTotal" value="0"/>
									<c:set var="heparTotal" value="0"/>
									<c:set var="pancreasTotal" value="0"/>
									<c:set var="heartTotal" value="0"/>
									<c:set var="lungTotal" value="0"/>
									<c:set var="isletTotal" value="0"/>
									<c:set var="intestineTotal" value="0"/>
									<c:set var="corneaTotal" value="0"/>
									
									<c:forEach var="organ" items="${organList }" varStatus="status">
									<c:set var="brainTotal" value="${brainTotal + organ.statsBrainTotal }"/>
									<c:set var="total" value="${total + organ.statsTotal }"/>
									<c:set var="kidneyTotal" value="${kidneyTotal + organ.statsKidney }"/>
									<c:set var="heparTotal" value="${heparTotal + organ.statsHepar }"/>
									<c:set var="pancreasTotal" value="${pancreasTotal + organ.statsPancreas }"/>
									<c:set var="heartTotal" value="${heartTotal + organ.statsHeart }"/>
									<c:set var="lungTotal" value="${lungTotal + organ.statsLung }"/>
									<c:set var="isletTotal" value="${isletTotal + organ.statsIslet }"/>
									<c:set var="intestineTotal" value="${intestineTotal + organ.statsIntestine }"/>
									<c:set var="corneaTotal" value="${corneaTotal + organ.statsCornea }"/>
									
									<c:choose>
									<c:when test="${status.first}">
	                                    <tr>
	                                        <td class="font-bold"><c:out value="${organ.statsDate  }"/></td>
	                                        <td class="font-bold"><fmt:formatNumber value="${organ.statsBrainTotal }" pattern="###,###"/></td>
	                                        <td class="font-bold"><fmt:formatNumber value="${organ.statsKidney }" pattern="###,###"/></td>
	                                        <td class="font-bold"><fmt:formatNumber value="${organ.statsHepar }" pattern="###,###"/></td>
	                                        <td class="font-bold"><fmt:formatNumber value="${organ.statsPancreas }" pattern="###,###"/></td>
	                                        <td class="font-bold"><fmt:formatNumber value="${organ.statsHeart }" pattern="###,###"/></td>
	                                        <td class="font-bold"><fmt:formatNumber value="${organ.statsLung }" pattern="###,###"/></td>
	                                        <td class="font-bold"><fmt:formatNumber value="${organ.statsIslet }" pattern="###,###"/></td>
	                                        <td class="font-bold"><fmt:formatNumber value="${organ.statsIntestine }" pattern="###,###"/></td>
	                                        <td class="font-bold"><fmt:formatNumber value="${organ.statsCornea }" pattern="###,###"/></td>
	                                        <td class="font-bold bg-orange orange"><fmt:formatNumber value="${organ.statsTotal }" pattern="###,###"/></td>
	                                    </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td><c:out value="${organ.statsDate  }"/></td>
	                                        <td><fmt:formatNumber value="${organ.statsBrainTotal }" pattern="###,###"/></td>
	                                        <td><fmt:formatNumber value="${organ.statsKidney }" pattern="###,###"/></td>
	                                        <td><fmt:formatNumber value="${organ.statsHepar }" pattern="###,###"/></td>
	                                        <td><fmt:formatNumber value="${organ.statsPancreas }" pattern="###,###"/></td>
	                                        <td><fmt:formatNumber value="${organ.statsHeart }" pattern="###,###"/></td>
	                                        <td><fmt:formatNumber value="${organ.statsLung }" pattern="###,###"/></td>
	                                        <td><fmt:formatNumber value="${organ.statsIslet }" pattern="###,###"/></td>
	                                        <td><fmt:formatNumber value="${organ.statsIntestine }" pattern="###,###"/></td>
	                                        <td><fmt:formatNumber value="${organ.statsCornea }" pattern="###,###"/></td>
	                                        <td class="bg-orange orange"><fmt:formatNumber value="${organ.statsTotal }" pattern="###,###"/></td>
                                        </tr>
                                    </c:otherwise>
                                    </c:choose>
                                    </c:forEach>
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td>Total</td>
                                        <td><fmt:formatNumber value="${brainTotal }" pattern="###,###"/></td>
									    <td><fmt:formatNumber value="${kidneyTotal }" pattern="###,###"/></td>
									    <td><fmt:formatNumber value="${heparTotal }" pattern="###,###"/></td>
									    <td><fmt:formatNumber value="${pancreasTotal }" pattern="###,###"/></td>
									    <td><fmt:formatNumber value="${heartTotal }" pattern="###,###"/></td>
									    <td><fmt:formatNumber value="${lungTotal }" pattern="###,###"/></td>
									    <td><fmt:formatNumber value="${isletTotal }" pattern="###,###"/></td>
									    <td><fmt:formatNumber value="${intestineTotal }" pattern="###,###"/></td>
									    <td><fmt:formatNumber value="${corneaTotal }" pattern="###,###"/></td>
                                        <td><fmt:formatNumber value="${total }" pattern="###,###"/></td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
	
</body>
</html>
