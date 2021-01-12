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
	function goList(page){
		if(page==-1){
			alert('첫페이지입니다.');
			return;
		}else if(page==-2){
			alert('마지막페이지입니다.');
			return;
		}
		
		$('#currentPage').val(page);
		$('#frm_url').attr('action', '/pr/movie.c').submit();
	}
	
	function goView(idx){
		$('#idx').val(idx);
		$('#frm_url').attr('action', '/pr/movie_view.c').submit();
	}
	
</script>
</head>
<body>

	<input type="hidden" name="currentPage" id="currentPage" value="${prSearch.currentPage }" />
	<input type="hidden" name="searchKey" id="searchKey" value="${prSearch.searchKey }">
	<input type="hidden" name="idx" id="idx">
	<div class="wrap">
                <div class="sub__header">
                    <h2>영상자료실</h2>
                </div>
                <div class="memorial__detail-content">
                    <div class="promote__publication flex flex-wrap pr">
                        <c:forEach var="movieL" items="${movieList }" varStatus="status" begin="0">
                            <div class="item">
                                <a href="javascript:goView(<c:out value="${movieL.brdContNo }"/>)" class="inline-block">
                                    <div class="imgBox relative">
                                        <div class="img">
                                            <img src="${pageContext.request.contextPath}/resource/assets/images/publication-bg4.png" alt="">  
                                            <!--<img src="/upFile/${movieL.brdFileNm }" alt="${movieL.brdTitle }">-->
                                        </div>
                                        <div class="button absolute video">
                                            <img src="${pageContext.request.contextPath}/resource/assets/images/play.png" alt="">
                                        </div>
                                    </div>
                                    <div class="txtBox">
                                        <div class="title">
                                        <c:out value="${movieL.brdTitle }"/>
                                    	</div>
                                        <div class="date">
                                        	<fmt:parseDate var="regdate" value="${movieL.regDm }" pattern="yyyy-MM-dd"/>
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
