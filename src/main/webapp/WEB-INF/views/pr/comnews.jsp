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
	function goSearch(){
		$('#searchKey').val($('#searchKeySelect').val());
		$('#currentPage').val(0);
		$('#method').val('');
		$('#frm_url').attr('action', '/pr/comnews.c').submit();
	}

	function goList(page){
		if(page==-1){
			alert('첫페이지입니다.');
			return;
		}else if(page==-2){
			alert('마지막페이지입니다.');
			return;
		}
		
		$('#currentPage').val(page);
		$('#frm_url').attr('action', '/pr/comnews.c').submit();
	}
	
	function goView(idx){
		$('#method').val('view');
		$('#idx').val(idx);
		$('#frm_url').attr('action', '/pr/comnews_view.c').submit();
	}
	
</script>>
</head>
<body>

	<input type="hidden" name="currentPage" id="currentPage" value="${prSearch.currentPage }" />
	<input type="hidden" name="searchKey" id="searchKey" value="${prSearch.searchKey }">
	<input type="hidden" name="idx" id="idx">
	<input type="hidden" name="method" id="method">
	<div class="wrap">
                <div class="sub__header">
                    <h2>기관소식</h2>
                </div>
                <div class="memorial__search-form mb-8">
                    <div class="select" style="margin:0;margin-right: 10px;">
                        <select name="searchKeySelect" id="searchKeySelect">
                            <option value="">전체</option>
                            <option value="title" <c:if test="${prSearch.searchKey eq 'title' }">selected</c:if>>제목</option>
                            <option value="contents" <c:if test="${prSearch.searchKey eq 'contents' }">selected</c:if>>내용</option>
                        </select>
                    </div>
                    <div class="input name mobile-mt-10">
                    	<input type="text" name="searchValue" id="searchValue" value="<c:out escapeXml="true" value="${prSearch.searchValue }"/>" placeholder="검색어를 입력해주세요." onkeypress="if(event.keyCode == 13) goSearch();" title="검색어 입력창">
                    </div>
                    <button type="button" class="submit" onclick="return goSearch();">검색하기</button>
                </div>
                <div class="memorial__detail-content">
                    <div class="pomote__news-list">
                		<c:forEach var="forum" items="${forumList }" varStatus="status">
                        <div class="item">
                            <a href="javascript:goView(<c:out value="${forum.brdContNo }"/>)" class="flex">
                                <div class="img">
                                	<!-- <img src="/upFile/${forum.brdFileNm }" alt="${forum.brdTitle }"> -->
                                    <img src="${pageContext.request.contextPath}/resource/assets/images/news-img.png" alt="">
                                </div>
                                <div class="txtBox">
                                    <div class="tit">
                                        <h3>
                                           <c:out value="${forum.brdTitle }" />
                                        </h3>
                                    </div>
                                    <div class="txt">
                                        <p>
                                        <c:set var="contents" value="${cfn:removeHtmlTag(forum.brdContents) }"/>
										<c:if test="${fn:length(contents) > 0 }">
											<c:choose>
												<c:when test="${fn:length(contents) > 80 }">
													${fn:substring(contents, 0, 80) } ...
												</c:when>
												<c:otherwise>
													${contents }
												</c:otherwise>
											</c:choose>
										</c:if>
                                        </p>
                                    </div>
                                    <div class="date">
			                        	<fmt:parseDate var="regdate" value="${forum.regDm }" pattern="yyyy-MM-dd"/>
										<fmt:formatDate value="${regdate }" pattern="yyyy-MM-dd"/>
									</div>
                                </div>
                            </a>
                        </div>
                        </c:forEach>
                    </div>
                </div>

                <div class="pagination">
					<paging:pagingNew pagingObj="${prSearch }"/>
				</div>

            </div>
	
</body>
</html>
