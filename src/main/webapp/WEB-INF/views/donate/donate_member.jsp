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
		
		function choice1(){
		
	
				$.ajax({
				
		            url: "/donate/choice_insert.json",
		            type: "POST",
		            data: $('#frm_url').serialize(),
		            dataType: "json",
		            success: function (data, textStatus, jqXHR) {
		            	if (data.result == "OK"){
		            alert("asdd");

		            	}else{
		            		axf.alert("실패.");
		            	}		
		            },
		            error: function (jqXHR, textStatus, errorThrown) {
		                axf.alert("code:" + jqXHR.status + "\nmessage:" + textStatus + "\nerror:" + errorThrown);
		            }
		        });
			
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

		
			

			

		function choice2(){
			alert("asdsad");
		}
		function choice3(){
			alert("asdsad");
		}
		function choice4(){
			alert("asdsad");
		}
	</script>
</head>
<body>
	<input type="hidden" name="currentPage" id="currentPage" value="${donateSearch.currentPage }" />
	<input type="hidden" name="method" id="method"/>
	<input type="hidden" name="idx" id="idx"/>
	<input type="hidden" name="gubun" id="gubun"/>
	<input type="hidden" name="donateIdx" id="donateIdx"/>
	<input type="hidden" name="donateName" id="donateName"/>
	

	<input type="hidden" name="donatePine" id="donatePine" value=${donate.donatePine }/>
	<input type="hidden" name="donateProud" id="donateProud" value=${donate.donateProud }/>
	<input type="hidden" name="donateHard" id="donateHard" value=${donate.donateHard }/>
	<input type="hidden" name="donateSade" id="donateSade" value=${donate.donateSade }/>

	<div class="wrap">
                <div class="sub__header">
                	<div class="memorial__head__cm01a">
						<span class="dq_t01"><img src="${pageContext.request.contextPath}/resource/assets/images/icon_dq_t01.png" alt=""></span>생의 마지막 순간 누군가의 빛이 되어준 당신을 영원히 기억합니다<span class="dq_b01"><img src="${pageContext.request.contextPath}/resource/assets/images/icon_dq_b01.png" alt=""></span>
					</div>
                    <h2>기증자 추모관</h2>
                </div>
                <div class="sub__tabs memorial">
                    <a href="javascript:fn_MoveUrl('2','1','0','/donate/member.c')" class="dp1a active active__blue1a">기증자 추모관</a>
                    <a href="javascript:fn_MoveUrl('2','2','0','/donate/letter.c')" class="dp1a">하늘나라 편지</a>
                    <a href="javascript:fn_MoveUrl('2','3','0','/donate/receipt.c')" class="dp1a">수혜자 편지</a>
                    <a href="javascript:fn_MoveUrl('2','4','0','/donate/story.c')" class="dp1a">기증 후 스토리</a>

				
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
                    <div class="submit fobx2">
                    <button type="button" class="submit" onclick="goSearch(); return false;">검색하기</button>
                    </div>
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
										<ul class="thum1">
											<li><img src="${pageContext.request.contextPath}/resource/assets/images/temp_pho02__seojungmin.png" alt=""></li>
											<li class="ly1"><img src="${pageContext.request.contextPath}/resource/assets/images/pho02_bg1_white01.png" alt=""></li>
										</ul>
									</c:when>
									<c:otherwise>
										<c:set var="donateNm" value="${donate.donateName }"/>
											<ul class="thum1">
											<li><img src="${pageContext.request.contextPath}/resource/assets/images/temp_pho02__seojungmin.png" alt=""></li>
											<li class="ly1"><img src="${pageContext.request.contextPath}/resource/assets/images/pho02_bg1_white01.png" alt=""></li>
										</ul>
									</c:otherwise>
								</c:choose>
								<h2 class="name">
									<c:out value="${donateNm }"/><small>(<c:out value="${donate.donateAge }"/>)</small>
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
									<div class="imo1">
										<a class="btn1" id="ch1"  onclick="choice1();"><img src="${pageContext.request.contextPath}/resource/assets/images/memorial-i5.png" alt="">${donate.donatePine }</a>
										<a class="btn1" id="ch2"  onclick="choice2();"><img src="${pageContext.request.contextPath}/resource/assets/images/memorial-i6.png" alt="">${donate.donateProud }</a>
										<a class="btn1" id="ch3"  onclick="choice3();"><img src="${pageContext.request.contextPath}/resource/assets/images/memorial-i8.png" alt="">${donate.donateHard }</a>
										<a class="btn1" id="ch4"  onclick="choice4();"><img src="${pageContext.request.contextPath}/resource/assets/images/memorial-i9.png" alt="">${donate.donateSad }</a>
									</div>
									<div class="let1">
										<a href="javascript:goForm(${donate.donateIdx}, '${donateNm}');"><img src="${pageContext.request.contextPath}/resource/assets/images/memorial-card-img5.png" alt="">하늘나라 편지쓰기</a>
									<c:if test="${dateDiff <= 7 }">
										<span class="new1">NEW</span></c:if>  
									</div>	
								</div>
							</div>
							<div class="item item--tyep2 type2" style="z-index:1">
								<ul class="thum1">
									<li><img src="${pageContext.request.contextPath}/resource/assets/images/temp_pho02__seojungmin.png" alt=""></li>
									<li class="ly1"><img src="${pageContext.request.contextPath}/resource/assets/images/pho02_bg1_green01.png" alt=""></li>
								</ul>
								<h2 class="name">
									<c:out value="${donateNm }"/>
									<c:if test="${donate.replyCnt > 0 }">&nbsp;<span>[<c:out value="${donate.replyCnt }"/>]</span></c:if>
								</h2>
								<div class="button">
									<div class="imo1">
									
										<a href="#" onclick="choice1();" class="btn1"><img src="${pageContext.request.contextPath}/resource/assets/images/memorial-i5.png" alt="">${donate.donatePine }</a>
										<a href="#" id="ch2" onclick="choice2();" class="btn1"><img src="${pageContext.request.contextPath}/resource/assets/images/memorial-i6.png" alt="">${donate.donateProud }</a>
										<a href="#" id="ch3" onclick="choice3();" class="btn1"><img src="${pageContext.request.contextPath}/resource/assets/images/memorial-i8.png" alt="">${donate.donateHard }</a>
										<a href="#" id="ch4" onclick="choice4();" class="btn1"><img src="${pageContext.request.contextPath}/resource/assets/images/memorial-i9.png" alt="">${donate.donateSad }</a>
									</div>
							
								</div>				
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
								<div class="button">
									<ul class="let2">
										<li><a href="javascript:goView(${donate.donateIdx });">온라인 추모</a></li>
										<li><a href="javascript:goForm(${donate.donateIdx }, '${donateNm}');">하늘나라<br/>편지쓰기</a></li>
									</ul>
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
