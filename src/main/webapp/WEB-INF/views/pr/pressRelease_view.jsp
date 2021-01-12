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
	
	function goView(idx){
		$('#method').val('view');
		$('#idx').val(idx);
		$('#frm_url').attr('action', '/pr/pressRelease_view.c').submit();
	}
	
	function goList(){
		$('#frm_url').attr('action', '/pr/pressRelease.c').submit();
	}
	function goDown(f,d){
		location.href = "/include/file_download.jsp?file="+encodeURI(encodeURIComponent(f))+"&path="+d;
	}

</script>
</head>
<body>

	<input type="hidden" name="searchKey" id="searchKey" value="${kodaSearch.searchKey }"/>
	<input type="hidden" name="searchValue" id="searchValue" value="${kodaSearch.searchValue }"/>
	<input type="hidden" name="currentPage" id="currentPage" value="${kodaSearch.currentPage }"/>
	<input type="hidden" name="idx" id="idx" value="${kodaSearch.brdContNo }"/>
	<input type="hidden" name="method" id="method" value=""/>
	<div class="wrap">
                <div class="sub__header">
                    <h2>언론보도</h2>
                    <div class="top-txtBox flex items-center">
                        <div class="img">
                            <img src="${pageContext.request.contextPath}/resource/assets/images/news-top-img.png" alt="">
                        </div>
                        <div class="txt">
                            <p>
                                한국장기조직기증원에서 언론에 소개할 자료를 배포하는 공간입니다.<br/>
                                KODA에서 작성한 언론 보도자료는 각 언론사를 통해 소개됩니다.
                            </p>
                        </div>
                    </div>
                </div>
                <div class="memorial__detail-content file-type">
                    <header>
                        <h3 class="title">
                            <c:out value="${pressRelease.brdTitle }"/>
                        </h3>
                        <div class="info">
                            <div class="col">
                                등록일 <strong>
							<fmt:parseDate var="regdate" value="${pressRelease.regDm }" pattern="yyyy-MM-dd"/>
							<fmt:formatDate value="${regdate }" pattern="yyyy-MM-dd"/>
						</strong>
                            </div>
                            <div class="col">
                                조회수 <strong><c:out value="${pressRelease.brdReadNum }"/></strong>
                            </div>
                        </div>
                        <c:if test="${not empty pressRelease.brdFileOrgNm }">
                        <div class="attachFile flex items-center">
                            <span class="inline-block">첨부파일</span>
                            <a href="#" onclick="goDown('${pressRelease.brdFileOrgNm}','/${pressRelease.brdFileNm}');"><c:out value="${pressRelease.brdFileOrgNm }"/></a>
                        </div>
						</c:if>
                    </header>

                    <div class="memorial__detail-body">

                        <!-- content 입력 -->
                        <div class="content flex items-center flex-col">
                            <!-- <img src="${pageContext.request.contextPath}/resource/assets/images/promote-pressRelease.png" alt=""> -->
							${cfn:nl2br(pressRelease.brdContents) }  
                        </div>

                        <div class="content-next-prev">
							<c:choose>
								<c:when test="${not empty pressReleasePrev }">
		                            <div class="col prev">
		                                <a href="javascript:goView(${pressReleasePrev.brdContNo });">
		                                    <span>이전글</span>
											<p><c:out value="${pressReleasePrev.brdTitle }"/></p>
		                                </a>
		                            </div>
                            	</c:when>
								<c:otherwise>
		                            <div class="col next">
		                                <a href="javascript:function(){return false;}" style="cursor:default">
											<p>이전글이 없습니다.</p>
										</a>
		                            </div>
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${not empty pressReleaseNext }">
		                            <div class="col next">
		                                <a href="javascript:goView(${pressReleaseNext.brdContNo });">
		                                    <span>다음글</span>
											<p><c:out value="${pressReleaseNext.brdTitle }"/></p>
		                                </a>
		                            </div>
                            	</c:when>
								<c:otherwise>
		                            <div class="col next">
		                                <a href="javascript:function(){return false;}" style="cursor:default">
											<p>다음 글이 없습니다.</p>
										</a>
		                            </div>
								</c:otherwise>
							</c:choose>
                        </div>
                    </div>
                </div>
                <div class="form-actions justify-center">
                    <a href="javascript:goList();" class="submit btn">목록보기</a>
                </div>
            </div>
</body>
</html>
