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

	<div class="wrap">
                <div class="sub__header">
                    <h2>기증희망등록 현황</h2>
                </div>
                <div class="info__content">
                    <div class="subTit flex justify-between">
                        <h3 class="flex items-center">
                            기증희망등록 현황
                        </h3>
                        <div class="button">
                            <a href="javascript:fn_MoveUrl('4','1','0')" class="heart flex">
                                <i></i>
                                기증희망등록 신청
                            </a>
                        </div>
                    </div>
                    <div class="scrollbox2">
                        <div class="table infoTable border-orange thin border-b-orange">
                            <table>
                                <colgroup>
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
                                        <th rowspan="2">누계</th>
                                        <th colspan="3">뇌사장기기증 희망</th>
                                        <th colspan="3">조직기증 희망</th>
                                        <th rowspan="2" class="light-orange">연간등록수</th>
                                    </tr>
                                    <tr>
                                        <th>누계</th>
                                        <th>사망/취소</th>
                                        <th>등록</th>
                                        <th>누계</th>
                                        <th>사망/취소</th>
                                        <th>등록</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="hope" items="${hopeList }" varStatus="status">
									<c:choose>
									<c:when test="${status.first}">
	                                    <tr>	                                        
	                                        <td class="font-bold"><c:out value="${hope.statsDate }"/></td>
										    <td class="font-bold"><fmt:formatNumber value="${hope.statsTotal }" pattern="###,###"/></td>
										    <td class="font-bold"><fmt:formatNumber value="${hope.statsBrainDonateTotal }" pattern="###,###"/></td>
										    <td class="font-bold"><fmt:formatNumber value="${hope.statsBrainDonateCancle }" pattern="###,###"/></td>
										    <td class="font-bold"><fmt:formatNumber value="${hope.statsBrainDonateRegi }" pattern="###,###"/></td>
										    <td class="font-bold"><fmt:formatNumber value="${hope.statsBoneDonateTotal }" pattern="###,###"/></td>
										    <td class="font-bold"><fmt:formatNumber value="${hope.statsBoneDonateCancle }" pattern="###,###"/></td>
										    <td class="font-bold"><fmt:formatNumber value="${hope.statsBoneDonateRegi }" pattern="###,###"/></td>
										    <td class="font-bold bg-orange orange"><fmt:formatNumber value="${hope.statsRegiTotal }" pattern="###,###"/></td>
	                                    </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
	                                        <td><c:out value="${hope.statsDate }"/></td>
										    <td><fmt:formatNumber value="${hope.statsTotal }" pattern="###,###"/></td>
										    <td><fmt:formatNumber value="${hope.statsBrainDonateTotal }" pattern="###,###"/></td>
										    <td><fmt:formatNumber value="${hope.statsBrainDonateCancle }" pattern="###,###"/></td>
										    <td><fmt:formatNumber value="${hope.statsBrainDonateRegi }" pattern="###,###"/></td>
										    <td><fmt:formatNumber value="${hope.statsBoneDonateTotal }" pattern="###,###"/></td>
										    <td><fmt:formatNumber value="${hope.statsBoneDonateCancle }" pattern="###,###"/></td>
										    <td><fmt:formatNumber value="${hope.statsBoneDonateRegi }" pattern="###,###"/></td>
										    <td class="bg-orange orange"><fmt:formatNumber value="${hope.statsRegiTotal }" pattern="###,###"/></td>
                                        </tr>
                                    </c:otherwise>
                                    </c:choose>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
</body>
</html>
