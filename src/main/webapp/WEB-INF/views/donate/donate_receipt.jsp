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
			$('#frm_url').attr('action', '/donate/receipt_form.c').submit();
		}
	
		function goSearch(){
			$('#searchKey').val($('#searchKeySelect').val());
			$('#currentPage').val(1);
			$('#method').val('');
			$('#frm_url').attr('action', '/donate/receipt.c').submit();
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
			$('#frm_url').attr('action', '/donate/receipt.c').submit();
		}
		
		function goView(idx){
			$('#method').val('view');
			$('#idx').val(idx);
			$('#frm_url').attr('action', '/donate/receipt_view.c').submit();
		}
	</script>
</head>
<body>
	<input type="hidden" name="currentPage" id="currentPage" value="<c:out escapeXml="true" value="${donateSearch.currentPage }"/>"/>
	<input type="hidden" name="searchKey" id="searchKey" value="<c:out escapeXml="true" value="${donateSearch.searchKey }"/>"/>
	<input type="hidden" name="idx" id="idx">
	<input type="hidden" name="gubun" id="gubun" value="${donateSearch.gubun }">
	<input type="hidden" name="method" id="method">
	<div class="wrap">
                <div class="sub__header">
                    <h2>수혜자 편지</h2>
                </div>
                
                <div class="sub__tabs memorial">
                    <a href="javascript:fn_MoveUrl('2','1','0','/donate/member.c')" class="dp1a">기증자 추모관</a>
                    <a href="javascript:fn_MoveUrl('2','2','0','/donate/letter.c')" class="dp1a">하늘나라 편지</a>
                    <a href="javascript:fn_MoveUrl('2','3','0','/donate/receipt.c')" class="dp1a active active__pink1a">수혜자 편지</a>
                    <a href="javascript:fn_MoveUrl('2','4','0','/donate/story.c')" class="dp1a">기증 후 스토리</a>


                    <div class="select">
                        <button>하늘나라 편지</button>
                        <div class="dropdown">
                            <a href="javascript:fn_MoveUrl('2','1','0','/donate/member.c'))" class="">기증자 추모관</a>
                            <a href="javascript:fn_MoveUrl('2','2','0','/donate/letter.c')">하늘나라 편지</a>
                            <a href="javascript:fn_MoveUrl('2','3','0',/donate/receipt.c)" class="active">수혜자 편지</a>
                            <a href="javascript:fn_MoveUrl('2','4','0','/donate/story.c')" class="">기증 후 스토리</a>
                        </div>
                    </div>
                </div>


                <div class="memorial__message">
                    <div class="memorial__message-info memorial__message-info--receive">
                        <div class="imgbox">
                            <p>
                                수혜자 편지는 이식으로 새생명을 살고 있는 분들의 이야기입니다.<br/>
                                언제 어디서나 시간과 장소에 구애받지 않고,
                                익명으로 작성이 가능합니다.
                            </p>
                        </div>
                        <div class="infobox ">
                            <h2>수혜자 편지 작성 시 확인하세요!</h2>
                            <ul>
                                <li>생명을 나눠준 기증자에 대한 예의를 지켜 주시기 바랍니다.</li>
                                <li>비방이나 욕설 등 분위기를 해치는 내용은 관리자에 의해 임의 삭제될 수 있습니다.</li>
                                <li>게시글 작성시 개인정보 표기는 자제해주시기 바랍니다.</li>
                                <li>일부 게시글은 한국장기조직기증원 뉴스레터 및 타 매체에 원문의 의미를 훼손하지 않는 범위내 에서 교정을 거쳐 익명으로 게재될 수 있습니다.</li>
                            </ul>
                            <div class="sub__tabs memorial">
	                            <a href="javascript:goWrite();" class="dp1a active active__pink1a">
	                                <strong class="type2">수혜자 편지쓰기</strong>
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
                        <button type="button" class="submit" onclick="goSearch();">검색하기</button>
                        </div>
                    </div>

                    <div class="memorial__message-list">
                    	<c:forEach var="recipient" items="${recipientList }" varStatus="status">
                    	<div class="item">
                           <a href="javascript:goView(${recipient.storyIdx });">
                               <header>
                                   <span class="count"><c:out value="${totalCount - ((donateSearch.currentPage - 1) * donateSearch.articleCount) - status.index }"/>번째 편지</span>
                                   
                                   <fmt:parseDate value="${now}" pattern ="yyyy-MM-dd" var="date"> </fmt:parseDate>
									<fmt:parseNumber value="${date.time / (1000*60*60*24)}" integerOnly="true" var="nowDays" scope="request"/>
									
									<fmt:parseDate var="regdate" value="${recipient.storyRegdate }" pattern="yyyy-MM-dd"/>
									<fmt:parseNumber value="${regdate.time / (1000*60*60*24)}" integerOnly="true" var="oldDays" scope="page"/>
									<c:set value="${nowDays - oldDays}" var="dateDiff"/>
									<c:if test="${dateDiff <= 7 }"><strong class="is_new">NEW</strong></c:if>
                                   
                               </header>
                               <h2 class="title">
                                   <c:choose>
										<c:when test="${fn:contains(recipient.storyTitle,'|')}">
												<c:set var="strtxt" value="${fn:split(recipient.storyTitle,'|')[0]}"/>
										</c:when>
										<c:otherwise>
										<c:set var="strtxt" value="${recipient.storyTitle }"/>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${fn:length(strtxt) > 12 }">
											<c:out value="${fn:substring(strtxt, 0, 12) }"/>...
										</c:when>
										<c:otherwise>
											<c:out value="${strtxt }"/>
										</c:otherwise>
									</c:choose>
                               </h2>
                               <div class="info">
                                   <div class="row">
                                       <span>수혜자</span>
	                                   <strong>
	                                       	<c:choose>
												<c:when test="${fn:contains(recipient.storyWriter,'|')}">
														<c:set var="strtext" value="${fn:split(recipient.storyWriter,'|')[0]}"/>
												</c:when>
												<c:otherwise>
												<c:set var="strtext" value="${recipient.storyWriter }"/>
												</c:otherwise>
											</c:choose>
												<c:choose>
													<c:when test="${recipient.storyAnonymity eq 'Y' }">
														<c:out value="${fn:substring(strtext, 0, fn:length(strtext) - (fn:length(strtext) > 2 ? 2 : 1)) }" />**
													</c:when>
													<c:otherwise>
														<c:out value="${strtext }" />
													</c:otherwise>
										   </c:choose>
                                       </strong>
                                   </div>
                               </div>
                               <span class="foot">
                                   <span>
	                                	<fmt:parseDate var="regdate" value="${recipient.storyRegdate }" pattern="yyyy-MM-dd"/>
										<fmt:formatDate value="${regdate }" pattern="yyyy-MM-dd"/>
									</span>
                                   <span>조회 <c:out value="${recipient.storyHits }"/></span>
                                   <c:if test="${recipient.comcnt > 0 }">
										<span>댓글 ${recipient.comcnt }</span>
									</c:if>
                               </span>
                           </a>
                       </div>
						</c:forEach>
                        
                            
                        
                    </div>
                    <div class="pagination">
						<paging:pagingNew pagingObj="${donateSearch }"/>
					</div>

                    <div class="action-button">
                        <a href="javascript:goWrite();">수혜자 편지쓰기</a>
                    </div>
                </div>
            </div>
	
</body>
</html>
