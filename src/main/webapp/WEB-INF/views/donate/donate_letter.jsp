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
			$('#frm_url').attr('action', '/donate/letter_form.c').submit();
		}
	
		function goSearch(){
			$('#searchKey').val($('#searchKeySelect').val());
			$('#currentPage').val(1);
			$('#method').val('');
			$('#frm_url').attr('action', '/donate/letter.c').submit();
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
			$('#frm_url').attr('action', '/donate/letter.c').submit();
		}
		
		function goView(idx){
			$('#method').val('view');
			$('#idx').val(idx);
			$('#frm_url').attr('action', '/donate/letter_view.c').submit();
		}		

		function goMemberView(idx){
			$('#method').val('view');
			$('#idx').val(idx);
			$('#frm_url').attr('action', '/donate/member_view.c').submit();
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
                	 <div class="memorial__head__cm01a">
						<span class="dq_t01"><img src="${pageContext.request.contextPath}/resource/assets/images/icon_dq_t01.png" alt=""></span>하늘의 아름다운 별이 된 당신께<span class="dq_b01"><img src="${pageContext.request.contextPath}/resource/assets/images/icon_dq_b01.png" alt=""></span>
					</div>
                    <h2>하늘나라 편지</h2>
                </div>
                <div class="sub__tabs memorial">
                    <a href="javascript:fn_MoveUrl('2','1','0','/donate/member.c')" class="dp1a">기증자 추모관</a>
                    <a href="javascript:fn_MoveUrl('2','2','0','/donate/letter.c')" class="dp1a active active__green1a">하늘나라 편지</a>
                    <a href="javascript:fn_MoveUrl('2','3','0','/donate/receipt.c')" class="dp1a">수혜자 편지</a>
                    <a href="javascript:fn_MoveUrl('2','4','0','/donate/story.c')" class="dp1a">기증 후 스토리</a>


                    <div class="select">
                        <button>하늘나라 편지</button>
                        <div class="dropdown">
                            <a href="javascript:fn_MoveUrl('2','1','0','/donate/member.c'))" class="">기증자 추모관</a>
                            <a href="javascript:fn_MoveUrl('2','2','0','/donate/letter.c')" class="active">하늘나라 편지</a>
                            <a href="javascript:fn_MoveUrl('2','3','0',/donate/receipt.c)" class="">수혜자 편지</a>
                            <a href="javascript:fn_MoveUrl('2','4','0','/donate/story.c')" class="">기증 후 스토리</a>
                        </div>
                    </div>
                </div>


                <div class="memorial__message">
                    <div class="memorial__message-info">
                        <div class="imgbox">
                            <p>
                                기증자에 대한 그리움과 사랑을 담은 '하늘나라 편지'는
                                언제 어디서나 시간과 장소에 제약을 받지 않고 추모를 할 수 있는
                                온라인 공간으로 익명 작성이 가능합니다.
                            </p>
                        </div>
                        <div class="infobox">
                            <h2>하늘나라 편지 작성 시 확인하세요!</h2>
                            <ul>
                                <li>경건한 분위기에서 기증자분들을 추모할 수 있도록 협조 부탁드립니다.</li>
                                <li>비방이나 욕설 등 분위기를 해치는 내용은 관리자에 의해 임의 삭제될 수 있습니다.</li>
                                <li>게시글 작성시 개인정보 표기는 자제해주시기 바랍니다.</li>
                                <li>일부 게시글은 한국장기조직기증원 뉴스레터 및 타 매체에 원문의 의미를 훼손하지 않는 범위내에서 교정을 거쳐 익명으로 게재될 수 있습니다. </li>
                            </ul>

                            <div class="info-desc">
                                <p>
                                    한국장기조직기증원에서는 기증자 가족, 친지, 친구들의 하늘나라 편지로 < 선물 >이라는 사례집을
                                    출간하였습니다. 도서를 직접 받아보고 싶으신 분은 홍보팀으로 연락주시거나, 신청서를 작성해
                                    주세요.
                                </p>
                                <div class="flex">
                                    <a href="#" class="flex-1">홍보팀 02-542-5631</a>
                                    <a href="#" class="flex-1">신청서 작성하기</a>
                                </div>
                            </div>

                            <a href="javascript:goWrite();" class="write-button">
                                <strong>하늘나라 편지쓰기</strong>
                            </a>
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
                        <button type="button" class="submit" title="검색하기" onclick="return goSearch();">검색하기</button>
                        </div>
                    </div>
					
					<c:if test="${!empty letterList }">
                    <div class="memorial__message-list">
						<c:forEach var="letter" items="${letterList }" varStatus="status">
                    	<div class="item">
                            <a href="javascript:goView(${letter.storyIdx });">
                                <header>
                                    <span class="count"><c:out value="${totalCount - ((donateSearch.currentPage - 1) * donateSearch.articleCount) - status.index }"/>번째 편지</span>
                                    <fmt:parseDate value="${now}" pattern ="yyyy-MM-dd" var="date"> </fmt:parseDate>
									<fmt:parseNumber value="${date.time / (1000*60*60*24)}" integerOnly="true" var="nowDays" scope="request"/>
									
									<fmt:parseDate var="regdate" value="${letter.storyRegdate }" pattern="yyyy-MM-dd"/>
									<fmt:parseNumber value="${regdate.time / (1000*60*60*24)}" integerOnly="true" var="oldDays" scope="page"/>
									<c:set value="${nowDays - oldDays}" var="dateDiff"/>
									<c:if test="${dateDiff <= 7 }"><strong class="is_new">NEW</strong></c:if>
		                            <c:if test="${donate.replyCnt > 0 }">&nbsp;<span>[<c:out value="${donate.replyCnt }"/>]</span></c:if>
                                </header>
	                                <h2 class="title">
	                                    <c:choose>
											<c:when test="${fn:length(letter.storyTitle) > 12 }">
												<c:out value="${fn:substring(letter.storyTitle, 0, 12) }"/>...
											</c:when>
											<c:otherwise>
												<c:out value="${letter.storyTitle }"/>
											</c:otherwise>
										</c:choose>
	                                </h2>
                                <div class="info">
                                    <div class="row">
                                        <span>기증자</span>
                                        <strong>
                                        	<c:if test="${not empty letter.donateName }">
											<!-- <a href="javascript:goMemberView(${letter.donateIdx });"> -->
												<c:set var="donateNm"/>
												<c:choose>
													<c:when test="${letter.donateAnonymity eq 'Y' }">
														<c:set var="donateNm" value="${fn:substring(letter.donateName, 0, 1) }*${fn:substring(letter.donateName, 2, fn:length(letter.donateName)) }"/>
													</c:when>
													<c:otherwise>
														<c:set var="donateNm" value="${letter.donateName }"/>
													</c:otherwise>
												</c:choose>
												<c:out value="${donateNm }"/>
											<!-- </a> -->
											</c:if>
										</strong>
                                    </div>
                                    <div class="row">
                                        <span>추모자</span>
                                        <strong>
                                        	<c:choose>
												<c:when test="${letter.storyAnonymity eq 'Y' }">
													<c:out value="${fn:substring(letter.storyWriter, 0, fn:length(letter.storyWriter) - (fn:length(letter.storyWriter) > 2 ? 2 : 1)) }" />**
												</c:when>
												<c:otherwise>
													<c:out value="${letter.storyWriter }" />
												</c:otherwise>
											</c:choose>
										</strong>
                                    </div>
                                </div>
                                <span class="foot">
                                    <span>
                                    	<fmt:parseDate var="regdate" value="${letter.storyRegdate }" pattern="yyyy-MM-dd"/>
										<fmt:formatDate value="${regdate }" pattern="yyyy-MM-dd"/>
									</span>
                                    <span>조회 <c:out value="${letter.storyHits }"/></span>
                                    <span><c:if test="${letter.comcnt > 0 }">댓글 ${letter.comcnt }</c:if></span>
                                </span>
                            </a>
                        </div>                        
						</c:forEach>
	                </div>
					</c:if>
				
                    <div class="pagination">
					<paging:pagingNew pagingObj="${donateSearch }"/>
					</div>

                    <div class="action-button">
                        <a href="">하늘나라 편지쓰기</a>
                    </div>
                </div>
            </div>
	
</body>
</html>
