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
<c:set var="now" value="<%=now%>"/>
<!doctype html>
<html lang="ko">
<head>
<script type="text/javascript">

		function goWrite(){
			if(confirm('KODA 장기구득 코디네이터 작성 공간입니다.\n유가족이시면 하늘나라편지 메뉴를 이용하세요.')){
				$('#frm_url').attr('action', '/donate/story_form.c').submit();
			}
		}
	
		function goSearch(){
			$('#searchKey').val($('#searchKeySelect').val());
			$('#currentPage').val(1);
			$('#method').val('');
			$('#frm_url').attr('action', '/donate/story.c').submit();
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
			$('#frm_url').attr('action', '/donate/story.c').submit();
		}
		
		function goView(idx){
			$('#method').val('view');
			$('#idx').val(idx);
			$('#frm_url').attr('action', '/donate/story_view.c').submit();
		}

	</script>
</head>
<body>
	<input type="hidden" name="currentPage" id="currentPage" value="${donateSearch.currentPage }" />
	<input type="hidden" name="searchKey" id="searchKey" value="${donateSearch.searchKey }">
	<input type="hidden" name="idx" id="idx">
	<input type="hidden" name="gubun" id="gubun" value="${donateSearch.gubun }">
	<input type="hidden" name="method" id="method">
	<div class="wrap">
                <div class="sub__header">
                    <h2>기증 후 STORY</h2>
                </div>
               <div class="sub__tabs memorial">
                    <a href="javascript:fn_MoveUrl('2','1','0','/donate/member.c')" class="dp1a">기증자 추모관</a>
                    <a href="javascript:fn_MoveUrl('2','2','0','/donate/letter.c')" class="dp1a">하늘나라 편지</a>
                    <a href="javascript:fn_MoveUrl('2','3','0','/donate/receipt.c')" class="dp1a">수혜자 편지</a>
                    <a href="javascript:fn_MoveUrl('2','4','0','/donate/story.c')" class="dp1a active active__violet1a">기증 후 스토리</a>


                    <div class="select">
                        <button>하늘나라 편지</button>
                        <div class="dropdown">
                            <a href="javascript:fn_MoveUrl('2','1','0','/donate/member.c'))" class="">기증자 추모관</a>
                            <a href="javascript:fn_MoveUrl('2','2','0','/donate/letter.c')">하늘나라 편지</a>
                            <a href="javascript:fn_MoveUrl('2','3','0',/donate/receipt.c)" class="">수혜자 편지</a>
                            <a href="javascript:fn_MoveUrl('2','4','0','/donate/story.c')" class="active">기증 후 스토리</a>
                        </div>
                    </div>
                </div>


                <div class="memorial__message">
                    <div class="memorial__message-info memorial__message-info--story">
                        <div class="imgbox">
                            <p>
                                KODA 코디네이터가 마지막까지 기증자와 함께 한
                                나눔의 시간과?아름다운 이야기를 적는 공간입니다.
                            </p>
                        </div>
                        <div class="infobox">
                            <h2>기증 후 스토리 작성 시 확인하세요!</h2>
                            <ul>
                                <li>게시글 작성시 개인정보 표기는 자제해주시기 바랍니다.</li>
                            </ul>
						    <div class="sub__tabs memorial" style="margin-top:140px;">
	                            <a href="javascript:goWrite();" class="dp1a active active__violet1a">
	                                <strong>이야기 쓰기</strong>
	                            </a>
                            </div>
                        </div>
                    </div>

                    <div class="memorial__search-form">
                        <div class="select" style="margin:0;margin-right: 10px;">
                            <select name="searchKeySelect" id="searchKeySelect">
                                <option value="">전체</option>
                                    <option value="title" <c:if test="${donateSearch.searchKey eq 'title' }">selected</c:if>>제목</option>
                                    <option value="contents" <c:if test="${donateSearch.searchKey eq 'contents' }">selected</c:if>>내용</option>
                            </select>
                        </div>
                        <div class="input name mobile-mt-10">
                        	<input title="검색어 입력창" type="text" name="searchValue" id="searchValue" value="<c:out escapeXml="true" value="${donateSearch.searchValue }"/>" placeholder="검색어를 입력해주세요." onkeypress="if(event.keyCode == 13) goSearch();">
                        </div>
                        <div class="submit fobx2">
                      	  <button type="button" class="submit" onclick="return goSearch();">검색하기</button>
                      	</div>
                    </div>

					<c:if test="${!empty storyList }">	
                    <div class="memorial__message-list">
						<c:forEach var="story" items="${storyList }" varStatus="status">
                        
                            <div class="item">
                                <a href="javascript:goView(${story.storyIdx });">
                                    <header>
                                        <span class="count count--story"><c:out value="${totalCount - ((donateSearch.currentPage - 1) * donateSearch.articleCount) - status.index }"/>번째 이야기</span>
                                        
                                        <fmt:parseDate value="${now}" pattern ="yyyy-MM-dd" var="date"> </fmt:parseDate>
										<fmt:parseNumber value="${date.time / (1000*60*60*24)}" integerOnly="true" var="nowDays" scope="request"/>										
										<fmt:parseDate var="regdate" value="${story.storyRegdate }" pattern="yyyy-MM-dd"/>
										<fmt:parseNumber value="${regdate.time / (1000*60*60*24)}" integerOnly="true" var="oldDays" scope="page"/>
										<c:set value="${nowDays - oldDays}" var="dateDiff"/>										
										<c:if test="${dateDiff <= 7 }"><strong class="is_new">NEW</strong></c:if>                                        
                                    </header>
                                    <h2 class="title">
                                        <c:choose>
										<c:when test="${fn:length(story.storyTitle) > 12 }">
											<c:out value="${fn:substring(story.storyTitle, 0, 12) }"/>...
										</c:when>
										<c:otherwise>
											<c:out value="${story.storyTitle }"/>
										</c:otherwise>
									</c:choose>
                                    </h2>
                                    <div class="info">
                                        <div class="row">
                                            <span>코디네이터</span>
                                            <strong>
                                            	<c:choose>
													<c:when test="${story.storyAnonymity eq 'Y' }">
														<c:out value="${fn:substring(story.storyWriter, 0, fn:length(story.storyWriter) - (fn:length(story.storyWriter) > 2 ? 2 : 1)) }" />**
													</c:when>
													<c:otherwise>
														<c:out value="${story.storyWriter }" />
													</c:otherwise>
												</c:choose>
											</strong>
                                        </div>
                                    </div>
                                    <span class="foot">
                                        <span>
	                                        <fmt:parseDate var="regdate" value="${story.storyRegdate }" pattern="yyyy-MM-dd"/>
											<fmt:formatDate value="${regdate }" pattern="yyyy-MM-dd"/>
										</span>
                                        <span>조회 <c:out value="${story.storyHits }"/></span>
                                        <span>댓글 <c:if test="${story.comCnt > 0 }">${story.comCnt }</c:if></span>
                                    </span>
                                </a>
                            </div>
                            </c:forEach>
                    </div>
                    <div class="pagination">
						<paging:pagingNew pagingObj="${donateSearch }"/>
					</div>
					</c:if>

                    <div class="action-button">
                        <a href="javascript:goWrite();">이야기 쓰기</a>
                    </div>
                </div>
            </div>
	
</body>
</html>
