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
		function regOpenPop(idx){
			/* window.open('http://www.koda1458.kr/newPr/organEvent.do?idx=${forum.brdContNo}', '', 'width=700, height=750, scrollbars=no, resizable=no'); */
			window.open('/newPr/organEvent_pop.do?idx=${forum.brdContNo}', '', 'width=700, height=750, scrollbars=no, resizable=no');
		}
		
		function goView(idx){
			$('#method').val('view');
			$('#idx').val(idx);
			$('#frm_url').attr('action', '/pr/comnews_view.c').submit();
		}
		
		function goList(){
			$('#frm_url').attr('action', '/pr/comnews.c').submit();
		}
		function goDown(f,d){
			location.href = "/include/file_download.jsp?file="+encodeURI(encodeURIComponent(f))+"&path="+d;
		}
	</script>
</head>
<body>
	<input type="hidden" name="searchKey" id="searchKey" value="${prSearch.searchKey }"/>
	<input type="hidden" name="searchValue" id="searchValue" value="${prSearch.searchValue }"/>
	<input type="hidden" name="currentPage" id="currentPage" value="${prSearch.currentPage }"/>
	<input type="hidden" name="idx" id="idx" value="${prSearch.brdContNo }"/>
	<input type="hidden" name="method" id="method" value=""/>

	<div class="wrap">
                <div class="sub__header">
                    <h2>기관소식</h2>
                </div>
                <div class="memorial__detail-content">
                    <header>
                        <h3 class="title">
						<c:out value="${forum.brdTitle }"/>
                        </h3>
                        <div class="info">
                            <div class="col">
                               	 등록일 <strong>
							<fmt:parseDate var="regdate" value="${forum.regDm }" pattern="yyyy-MM-dd"/>
							<fmt:formatDate value="${regdate }" pattern="yyyy-MM-dd"/></strong>
                            </div>                            
                            <div class="col">
                                	조회수 <strong><c:out value="${forum.brdReadNum }"/></strong>
                            </div>
                        </div>
                        <c:if test="${not empty forum.brdFileOrgNm }">
                        <div class="attachFile flex items-center">
                            <span class="inline-block">첨부파일</span>
                            <a href="#" onclick="goDown('${forum.brdFileOrgNm}','/${forum.brdFileNm}');"><c:out value="${forum.brdFileOrgNm }"/></a>
                        </div>
						</c:if>
                    </header>

                    <div class="memorial__detail-body border-type">

                        <!-- content 입력 -->
                        <div class="content" style="white-space: pre-line;line-height:1.5em;">
							${cfn:nl2br(forum.brdContents) }   
                        </div>

                    </div>
                </div>
                <div class="form-actions justify-center">
                	<c:choose>
						<c:when test="${forum.brdEtc1 eq 'A' and forum.brdEtc2 eq 'Y' }">
							<a href="javascript:regOpenPop(${forum.brdContNo });" class="btnColorPoint">신청</a>
						</c:when>
						<c:when test="${forum.brdEtc1 eq 'A' and forum.brdEtc2 ne 'Y' }">
							<span class="btnDisabled">마감</span><!-- disabled -->
						</c:when>
					</c:choose>
                    <a href="javascript:goList();" class="submit btn">목록보기</a>
                </div>
            </div>
	
</body>
</html>
