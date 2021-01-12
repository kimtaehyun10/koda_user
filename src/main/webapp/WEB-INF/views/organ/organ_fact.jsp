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
		$(document).on('click', '.faq__item button', function () {
	        
	        $(".faq__content").hide();
	        
	        $(this).next().fadeIn();
	
	        return false;
	    })	
	   
	});
	
	
	function goSearch(){
		$('#searchKey').val($('#searchKeySelect').val());
		$('#currentPage').val(0);
		$('#method').val('');
		$('#frm_url').attr('action', '/organ/organ_fact.c').submit();
	}
</script>

</head>
<body>
	<input type="hidden" name="currentPage" id="currentPage" value="${brainSearch.currentPage }" />
	<input type="hidden" name="searchKey" id="searchKey" value="${brainSearch.searchKey }">
	<div class="wrap">
		<div class="section">
			<h2 class="section__title text-center">기증팩트체크</h2>
		</div>

		<div class="memorial__search-form mb-8">
			<div class="select" style="margin: 0; margin-right: 10px;">
				<select name="searchKeySelect" id="searchKeySelect">
                    <option value="">전체</option>
                    <option value="title" <c:if test="${brainSearch.searchKey eq 'title' }">selected</c:if>>제목</option>
                    <option value="contents" <c:if test="${brainSearch.searchKey eq 'contents' }">selected</c:if>>내용</option>
				</select>
			</div>
			<div class="input name mobile-mt-10">
				<input type="text" name="searchValue" id="searchValue" value="<c:out escapeXml="true" value="${brainSearch.searchValue }"/>" placeholder="검색어를 입력해주세요." onkeypress="if(event.keyCode == 13) goSearch();">
			</div>
			<button type="button" onclick="return goSearch();" class="submit">검색하기</button>
		</div>

		<div class="search-tags">
			<!-- <a href="">#기증가능장기</a> <a href="">#기증가능장기</a> <a href="">#기증가능장기</a> -->
		</div>

		<div class="faq">
			
			<c:forEach var="faq" items="${faqList }" varStatus="status">
			<div class="faq__item">
				<button type="button"><c:out value="${faq.brdTitle }"/></button>
				<div class="faq__content">
					${faq.brdContents }
					<div class="etc">
						<span>그 밖의 궁금한 사항은 자유게시판에 남겨주세요.</span> <a href="">자유게시판에 문의하기</a>
					</div>
				</div>
			</div>
			</c:forEach>
		</div>
	</div>
</body>
</html>
