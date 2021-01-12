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
	var menucd = '5';
	var seqcd1 = '1';
	var seqcd2 = ['1','2','3'];
	var url = ['/pr/annual.c','/pr/news_letter.c','/pr/casebook.c'];

	function goList(page){
		if(page==-1){
			alert('첫페이지입니다.');
			return;
		}else if(page==-2){
			alert('마지막페이지입니다.');
			return;
		}
		
		$('#currentPage').val(page);
		$('#frm_url').attr('action', 'news_letter.c').submit();
	}
	
	function goView(num, idx){
		var url = '/pr/eBook.pop?num=' + num + '&idx=' + idx;
		window.open(url, '', 'width=1000, height=700, resizable=yes');
	}
	
	function fn_select_change(){
		var idx = "";
		idx = $("#moveselect option:selected").val();
		
		fn_MoveUrl(menucd, seqcd1, seqcd2[idx],url[idx]);
	
	}
	
</script>
</head>
<body>

	<input type="hidden" name="currentPage" id="currentPage" value="${prSearch.currentPage }" />
	<input type="hidden" name="searchKey" id="searchKey" value="${prSearch.searchKey }">
	<div class="wrap">
                <div class="sub__header">
                    <h2>뉴스레터</h2>
                </div>
                <div class="promote__select flex ml-auto">
                    <select name="moveselect" id="moveselect" onchange="javascript:fn_select_change();">
                        <option value="0">연간보고서</option>
                        <option value="1" selected>뉴스레터</option>
                        <option value="2">사례집</option>
                    </select>
                </div>
                <div class="memorial__detail-content">
                    <div class="promote__publication flex flex-wrap">
                        
						<c:forEach var="newsLetter" items="${newsLetterList }" varStatus="status">
                            <div class="item">
                                <div class="imgBox relative">
                                    <div class="img">
                                    	<!-- <img src="/upFile/${newsLetter.brdFileNm }" alt="<c:out value="${newsLetter.brdTitle }" />"> -->
                                        <img src="${pageContext.request.contextPath}/resource/assets/images/publication-bg.png" alt="">
                                    </div>
                                    <div class="button flex absolute">
                                    	<c:set var="downUrl" />
			                        	<c:choose>
											<c:when test="${fn:indexOf(newsLetter.brdDownUrl, 'http://') > -1 or fn:indexOf(newsLetter.brdDownUrl, 'https://') > -1 }">
												<c:set var="downUrl" value="${newsLetter.brdDownUrl }" />
											</c:when>
											<c:otherwise>
												<c:set var="downUrl" value="http://${newsLetter.brdDownUrl }" />
											</c:otherwise>
										</c:choose>
								
                                    	<a title="새창열림" href="javascript:goView(${newsLetterNum }, '<c:out value="${newsLetter.brdContNo }"/>');" class="zoomin inline-block"> >확대</a>
                                    	<a href="<c:out value="${downUrl }"/>" class="download inline-block">다운로드</a>
                                    </div>
                                </div>
                                <div class="txtBox">
                                    <div class="title"><c:out value="${newsLetter.brdTitle }" /></div>
                                    <div class="date">
										<fmt:parseDate var="regdate" value="${newsLetter.regDm}" pattern="yyyy-MM-dd"/>
										<fmt:formatDate value="${regdate }" pattern="yyyy-MM-dd"/>
                                </div>
                                </div>
                            </div>
                        </c:forEach>
                        
                    </div>
                </div>

                <div class="pagination">
					<paging:pagingNew pagingObj="${prSearch }"/>
            </div>
	
</body>
</html>
