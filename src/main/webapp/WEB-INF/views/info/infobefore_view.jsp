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
			$('#frm_url').attr('action', '/info/infobefore_view.c').submit();
		}
		
		function goList(){
			$('#frm_url').attr('action', '/info/infobefore.c').submit();
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
                    <h2>사전정보 공개</h2>
                </div>
                <div class="memorial__detail-content">
                    <header>
                        <h3 class="title">
						<c:out value="${makePublic.brdTitle }"/>
                        </h3>
                        <div class="info">
                            <div class="col">
                               	 공개방법 <strong>
								<c:choose>
									<c:when test="${fn:substring(makePublic.brdEtc1, 2, 1) == 1 }">
									홈페이지
									</c:when>
									<c:when test="${fn:substring(makePublic.brdEtc1, 2, 1) == 1 }">
									방법1
									</c:when>
									<c:otherwise>
									방법2
									</c:otherwise>
								</c:choose>
								</strong>
                            </div>           
                            <div class="col">
                               	 등록일 <strong>
							<fmt:parseDate var="regdate" value="${makePublic.regDm }" pattern="yyyy-MM-dd"/>
							<fmt:formatDate value="${regdate }" pattern="yyyy-MM-dd"/></strong>
                            </div>                            
                            <div class="col">
                                	조회수 <strong><c:out value="${makePublic.brdReadNum }"/></strong>
                            </div>
                        </div>
                        <c:if test="${not empty makePublic.brdFileOrgNm }">
                        <div class="attachFile flex items-center">
                            <span class="inline-block">첨부파일</span>
                            <a href="#" onclick="goDown('${makePublic.brdFileOrgNm}','/${makePublic.brdFileNm}');"><c:out value="${makePublic.brdFileOrgNm }"/></a>
                        </div>
						</c:if>
                    </header>

                    <div class="memorial__detail-body border-type">

                        <!-- content 입력 -->
                        <div class="content" style="white-space: pre-line;line-height:1.5em;">
							${cfn:nl2br(makePublic.brdContents) }   
                        </div>

                    </div>
                </div>
                <div class="form-actions justify-center">
                    <a href="javascript:goList();" class="submit btn">목록보기</a>
                </div>
            </div>
	
</body>
</html>
