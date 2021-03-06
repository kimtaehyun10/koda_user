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
		$('#frm_url').attr('action', 'publicview.c').submit();

		
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
                    <h2>간행물</h2>
                </div>
			
                <ul class="bx_more_ty01">
					<li>연간보고서</li>
					<li><a href="javascript:fn_MoveUrl('5','1','1','/pr/annual.c')"><img src="${pageContext.request.contextPath}/resource/assets/images/icon_more_plus_orange_01.png" alt="전체보기"></a></li>
				</ul>
                <div class="memorial__detail-content">
                    <div class="promote__publication flex flex-wrap">
                        
						<c:forEach var="annual" items="${annualList }" varStatus="status">
                            <div class="item">
                                <div class="imgBox relative">
                                    <div class="img">                                    	
                                        <!-- <img src="${pageContext.request.contextPath}/resource/assets/images/publication-bg.png" alt=""> -->
                                        <img src="/imageView.do?imageName=${annual.brdFileNm}" alt="" style="width: 360px; height: 430px;">
                                    </div>
                                    <div class="button flex absolute">
                                    	<c:set var="downUrl" />
			                        	<c:choose>
											<c:when test="${fn:indexOf(annual.brdDownUrl, 'http://') > -1 or fn:indexOf(annual.brdDownUrl, 'https://') > -1 }">
												<c:set var="downUrl" value="${annual.brdDownUrl }" />
											</c:when>
											<c:otherwise>
												<c:set var="downUrl" value="http://${annual.brdDownUrl }" />
											</c:otherwise>
										</c:choose>
								
                                    	<a title="새창열림" href="javascript:goView(${annualNum }, '<c:out value="${annual.brdContNo }"/>');" class="zoomin inline-block"> >확대</a>
                                    	<a href="<c:out value="${downUrl }"/>" class="download inline-block">다운로드</a>
                                    </div>
                                </div>
                                <div class="txtBox">
                                    <div class="title"><c:out value="${annual.brdTitle }" /></div>
                                    <div class="date">
										<fmt:parseDate var="regdate" value="${annual.regDm}" pattern="yyyy-MM-dd"/>
										<fmt:formatDate value="${regdate }" pattern="yyyy-MM-dd"/>
                                </div>
                                </div>
                            </div>
                        </c:forEach>
                        
                    </div>
                </div>
                

			</div>
			<div class="wrap">
				<ul class="bx_more_ty01">
					<li>뉴스레터</li>
					<li><a href="javascript:fn_MoveUrl('5','1','2','/pr/news_letter.c')"><img src="${pageContext.request.contextPath}/resource/assets/images/icon_more_plus_orange_01.png" alt="전체보기"></a></li>
				</ul>
				 <div class="memorial__detail-content">
                    <div class="promote__publication flex flex-wrap">
                        
						<c:forEach var="newsLetter" items="${newsLetterList }" varStatus="status">
                            <div class="item">
                                <div class="imgBox relative">
                                    <div class="img">                                    	
                                        <!-- <img src="${pageContext.request.contextPath}/resource/assets/images/publication-bg.png" alt=""> -->
                                        <img src="/imageView.do?imageName=${newsLetter.brdFileNm}" alt="" style="width: 360px; height: 430px;">
                                        
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
                
				
			</div>
			<div class="wrap">
				<ul class="bx_more_ty01">
					<li>사례집</li>
					<li><a href="javascript:fn_MoveUrl('5','1','3','/pr/casebook.c')"><img src="${pageContext.request.contextPath}/resource/assets/images/icon_more_plus_orange_01.png" alt="전체보기"></a></li>
				</ul>
				 <div class="memorial__detail-content">
                    <div class="promote__publication flex flex-wrap">
                        
						<c:forEach var="casebook" items="${casebookList }" varStatus="status">
                            <div class="item">
                                <div class="imgBox relative">
                                    <div class="img">                                    	
                                        <!-- <img src="${pageContext.request.contextPath}/resource/assets/images/publication-bg.png" alt=""> -->
                                        <img src="/imageView.do?imageName=${casebook.brdFileNm}" alt="" style="width: 360px; height: 430px;">
                                    </div>
                                    <div class="button flex absolute">
                                    	<c:set var="downUrl" />
			                        	<c:choose>
											<c:when test="${fn:indexOf(casebook.brdDownUrl, 'http://') > -1 or fn:indexOf(casebook.brdDownUrl, 'https://') > -1 }">
												<c:set var="downUrl" value="${casebook.brdDownUrl }" />
											</c:when>
											<c:otherwise>
												<c:set var="downUrl" value="http://${casebook.brdDownUrl }" />
											</c:otherwise>
										</c:choose>
								
                                    	<a title="새창열림" href="javascript:goView(${casebookNum }, '<c:out value="${casebook.brdContNo }"/>');" class="zoomin inline-block"> >확대</a>
                                    	<a href="<c:out value="${downUrl }"/>" class="download inline-block">다운로드</a>
                                    </div>
                                </div>
                                <div class="txtBox">
                                    <div class="title"><c:out value="${casebook.brdTitle }" /></div>
                                    <div class="date">
										<fmt:parseDate var="regdate" value="${casebook.regDm}" pattern="yyyy-MM-dd"/>
										<fmt:formatDate value="${regdate }" pattern="yyyy-MM-dd"/>
                                </div>
                                </div>
                            </div>
                        </c:forEach>
                        
                    </div>
                </div>


				
			</div>
		
			<div class="pagination">
					<paging:pagingNew pagingObj="${prSearch }"/>
          		</div>
			
                
	
</body>
</html>
