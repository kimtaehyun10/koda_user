<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/paging.tld"%>
<!doctype html>
<html lang="ko">
<head>
<script type="text/javascript">
		/*$(document).ready(function(){
			$('.listSelect a').click(function(){
				$('#searchYear').val($('.select > a').data('val'));
				goSearch();
			});
			
			datePic("startDate");
			datePic("endDate");
		});*/
	
		function goSearch(){
			$('#currentPage').val(1);
			$('#method').val('');
			$('#frm_url').attr('action', '/donate/member.c').submit();
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
			$("#frm_url").attr("action", "/donate/member.c").submit();
		}
		
		function goView(idx){
			$('#method').val('view');
			$('#idx').val(idx);
			$('#frm_url').attr('action', '/donate/member_view.c').submit();
		}
		
		//하늘나라 편지쓰기
		function goForm(donateIdx,donateNm){
			$('#donateIdx').val(donateIdx);
			$('#donateName').val(donateNm);
			$('#gubun').val("letter");
			$('#frm_url').attr('action', '/donate/letter_form.c').submit();
		}
		
		
		// card flip
		/*$(document).ready(function(){
			TweenMax.to($('.listDonor .back') , 1, {rotationY:180, transformOrigin:"center bottom"});
			$('.listDonor .front > a').mouseenter(function(){
				TweenMax.to($(this).parent('.front') , 1, {rotationY:180, transformOrigin:"center bottom"});
				TweenMax.to($(this).parents('li').find('.back') , 1, {rotationY:360, transformOrigin:"center bottom"});
				$(this).parent('.front').hide();
				$(this).parents('li').find('.back').fadeIn().addClass('bgBack');
			});
			$('.listDonor .back > a').mouseleave(function(){
				TweenMax.to($(this).parents('li').find('.front') , 1, {rotationY:0, transformOrigin:"center bottom"});
				TweenMax.to($(this).parent('.back') , 1, {rotationY:180, transformOrigin:"center bottom"});
				$(this).parent('.back').hide().removeClass('bgBack');
				$(this).parents('li').find('.front').fadeIn();
			});
		});*/
	</script>
</head>
<body>
	<input type="hidden" name="currentPage" id="currentPage" value="${donateSearch.currentPage }" />
	<input type="hidden" name="method" id="method"/>
	<input type="hidden" name="idx" id="idx"/>
	<input type="hidden" name="gubun" id="gubun"/>
	<input type="hidden" name="donateIdx" id="donateIdx"/>
	<input type="hidden" name="donateName" id="donateName"/>
	<div class="wrap">
                <div class="sub__header">
                    <h2>기증자 추모관</h2>
                </div>
                <div class="sub__tabs memorial">
                    <a href="javascript:fn_MoveUrl('2','1','0','/donate/member.c')" class="active">기증자 추모관</a>
                    <a href="javascript:fn_MoveUrl('2','2','0','/donate/letter.c')">하늘나라 편지</a>
                    <a href="javascript:fn_MoveUrl('2','3','0','/donate/receipt.c')" class="">수혜자 편지</a>
                    <a href="javascript:fn_MoveUrl('2','4','0','/donate/story.c')" class="">기증 후 스토리</a>


                    <div class="select">
                        <button>하늘나라 편지</button>
                        <div class="dropdown">
                            <a href="javascript:fn_MoveUrl('2','1','0','/donate/member.c'))" class="active">기증자 추모관</a>
                            <a href="javascript:fn_MoveUrl('2','2','0','/donate/letter.c')">하늘나라 편지</a>
                            <a href="javascript:fn_MoveUrl('2','3','0',/donate/receipt.c)" class="">수혜자 편지</a>
                            <a href="javascript:fn_MoveUrl('2','4','0','/donate/story.c')" class="">기증 후 스토리</a>
                        </div>
                    </div>
                </div>
                <div class="memorial__search-form">
                    <div class="input name">
                    	<input type="text" id="name" name="name"  onkeypress="if(event.keyCode == 13) goSearch();" value="<c:out escapeXml="true" value="${donateSearch.donateName }"/>" placeholder="기증자명">
                        <!-- <input type="text" placeholder="기증자명"> -->
                    </div>
                    <div class="schedule">
                        <div class="input">
                        	<input type="text" id="startDate" name="startDate" class="datepicker"  value="<c:out escapeXml="true" value="${donateSearch.startDate }"/>">
                            <!-- <input type="text" class="datepicker"> -->
                        </div>
                        <span>~</span>
                        <div class="input">
                        	<input type="text" id="endDate" name="endDate" class="datepicker"  value="<c:out escapeXml="true" value="${donateSearch.endDate }"/>">
                            <!-- <input type="text" class="datepicker"> -->
                        </div>
                    </div>
                    <div class="select">
                        <select name="searchYear" id="searchYear">
                            <option value="" <c:if test="${empty donateSearch.searchYear}"> selected </c:if>>연도 전체</option>
							<c:forEach var="yearL" items="${yearList }" varStatus="status">
                            	<option value="${yearL.year }" <c:if test="${donateSearch.searchYear eq yearL.year}"> selected </c:if>  ><c:out value="${yearL.year }"/>년</a></option>
							</c:forEach>
			             </select>
                    </div>
                    <button type="button" class="submit" onclick="goSearch(); return false;">검색하기</button>
                    <!-- <button class="submit">검색하기</button> -->
                </div>

                <div class="memorial__card">
                    
					<c:forEach items="${donateList}" var="donate">
						<div class="card-itembox">
							<!-- hover 시 item-type2가 올라오는 형식 -->
							<div class="item type1">
								<c:choose>
									<c:when test="${donate.donateAnonymity eq 'Y' }">
										<c:set var="donateNm" value="${fn:substring(donate.donateName, 0, 1) }*${fn:substring(donate.donateName, 2, fn:length(donate.donateName)) }"/>
									</c:when>
									<c:otherwise>
										<c:set var="donateNm" value="${donate.donateName }"/>
									</c:otherwise>
								</c:choose>
								<h2 class="name">
									<c:out value="${donateNm }"/>
									<c:if test="${donate.replyCnt > 0 }">&nbsp;<span>[<c:out value="${donate.replyCnt }"/>]</span></c:if>
								</h2>
								<c:choose>
									<c:when test="${donate.donateAge eq 0 and empty donate.donateGender }">
										<p class="number"><c:out value="${fn:substring(donate.donateContents, fn:indexOf(donate.donateContents, '(') + 1, fn:indexOf(donate.donateContents, ')')) }"/></p>
									</c:when>
									<c:otherwise>
										<p class="number"><c:out value="${donate.donateGender }"/>, <c:out value="${donate.donateAge }"/></p>
									</c:otherwise>
								</c:choose>
								<p class="date">기증일: <fmt:parseDate var="regdate" value="${donate.donateDate }" pattern="yyyy-MM-dd"/>
													  <fmt:formatDate value="${regdate }" pattern="yyyy-MM-dd"/></p>
								<div class="button">
									<a href="javascript:goForm(${donate.donateIdx}, '${donateNm}');"> <span>하늘나라 편지쓰기</span>
									</a>
								</div>
							</div>
							<div class="item item--tyep2 type2" style="z-index:1">
								<h2 class="name">
									<c:out value="${donateNm }"/>
									<c:if test="${donate.replyCnt > 0 }">&nbsp;<span>[<c:out value="${donate.replyCnt }"/>]</span></c:if>
								</h2>				
								<p class="description">
								<c:choose>
									<c:when test="${not empty donate.replyContents }">
										<fmt:parseDate var="regdate" value="${donate.replyRegdate }"
											pattern="yyyy-MM-dd" />
										<fmt:formatDate value="${regdate }" pattern="yyyy.MM.dd" />
										<c:choose>
											<c:when test="${fn:length(donate.replyContents) > 8 }">
												${fn:substring(donate.replyContents, 0, 8) } ..
											</c:when>
											<c:otherwise>
														${donate.replyContents }
											</c:otherwise>
										</c:choose>
									</c:when>
									<c:otherwise>
										하늘에 별이 된<br/>당신을 추모합니다.
									</c:otherwise>
								</c:choose>				
								</p>
								<div class="actions">
									<a href="javascript:goView(${donate.donateIdx });"> 온라인 추모 </a> <a
										href="javascript:goForm(${donate.donateIdx }, '${donateNm}');"> 하늘나라<br /> 편지쓰기
									</a>
								</div>
							</div>
						</div>
					</c:forEach>
                </div>

		<div class="pagination">
			<paging:paging pagingObj="${donateSearch }"/>
		</div>

	</div>
	
</body>
</html>
