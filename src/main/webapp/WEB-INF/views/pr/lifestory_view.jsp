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
	var seqcd1 = '2';
	var seqcd2 = ['1','2'];
	var url = ['/pr/webcontents.c','/pr/lifeSharing.c'];
	
	function goView(idx){
		$('#method').val('view');
		$('#idx').val(idx);
		$('#frm_url').attr('action', '/pr/lifeSharing_view.c').submit();
	}
	
	function goList(){
		$('#frm_url').attr('action', '/pr/lifeSharing.c').submit();
	}
	function goDown(f,d){
		location.href = "/include/file_download.jsp?file="+encodeURI(encodeURIComponent(f))+"&path="+d;
	}

	function fn_select_change(){
		var idx = "";
		idx = $("#moveselect option:selected").val();
		
		fn_MoveUrl(menucd, seqcd1, seqcd2[idx],url[idx]);
	
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
                    <h2>생명나눔 스토리</h2>
                    <div class="top-txtBox flex items-center">
                        <div class="img">
                            <img src="${pageContext.request.contextPath}/resource/assets/images/story-top-img.png" alt="">
                        </div>
                        <div class="txt">
                            <h3 class="flex items-center">
                                <span>가슴 따뜻해지는 생명 나눔 이야기</span>를 소개합니다.
                            </h3>
                            <p>
                                생명 나눔을 실천한 고귀한 분들의 이야기, 장기 수혜를 통해 새 삶을 얻은 감동 스토리를 소개합니다.<br/>
                                생명나눔 스토리를 통해 장기·조직 기증의 진짜 의미를 되새겨보시길 바랍니다.
                            </p>
                        </div>
                    </div>
                </div>
                <div class="promote__select flex ml-auto">
                    <select name="moveselect" id="moveselect" onchange="javascript:fn_select_change();">
                        <option value="0">웹콘텐츠</option>
                        <option value="1" selected>생명나눔 스토리</option>
                    </select>
                </div>
                <div class="memorial__detail-content file-type">
                    <header>
                        <h3 class="title">
                            <c:out value="${story.brdTitle }"/>
                        </h3>
                        <div class="info">
                            <div class="col">
                                등록일 <strong>
							<fmt:parseDate var="regdate" value="${story.regDm }" pattern="yyyy-MM-dd"/>
							<fmt:formatDate value="${regdate }" pattern="yyyy-MM-dd"/>
						</strong>
                            </div>
                            <div class="col">
                                조회수 <strong><c:out value="${story.brdReadNum }"/></strong>
                            </div>
                        </div>
                        <c:if test="${not empty story.brdFileOrgNm }">
                        <div class="attachFile flex items-center">
                            <span class="inline-block">첨부파일</span>
                            <a href="#" onclick="goDown('${story.brdFileOrgNm}','/${story.brdFileNm}');"><c:out value="${story.brdFileOrgNm }"/></a>
                        </div>
						</c:if>
                    </header>

                    <div class="memorial__detail-body">

                        <!-- content 입력 -->
                        <div class="content flex items-center flex-col">
                            <!-- <img src="${pageContext.request.contextPath}/resource/assets/images/promote-story.png" alt=""> -->
							${cfn:nl2br(story.brdContents) }  
                        </div>

                        <div class="content-next-prev">
							<c:choose>
								<c:when test="${not empty storyPrev }">
		                            <div class="col prev">
		                                <a href="javascript:goView(${storyPrev.brdContNo });">
		                                    <span>이전글</span>
											<p><c:out value="${storyPrev.brdTitle }"/></p>
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
								<c:when test="${not empty storyNext }">
		                            <div class="col next">
		                                <a href="javascript:goView(${storyNext.brdContNo });">
		                                    <span>다음글</span>
											<p><c:out value="${storyNext.brdTitle }"/></p>
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
