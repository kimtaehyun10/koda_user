<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/paging.tld"%>
<%@ taglib prefix="cfn" uri="/WEB-INF/tlds/comFunction.tld"%>
<!doctype html>
<html lang="ko">
<head>

	<script type="text/javascript">

		var chkLike = "";
		
		function updateLike(field, cnt){
			
			if(cnt >= 9999){
				alert('더이상 클릭할 수 없습니다.');
			}else{
				$('#field').val(field);
				
				if (field == "donateFlower"){
					$('.action-img').addClass('active');
				}
				
				if (chkLike.indexOf(field) != -1){
					axf.alert("이미 처리 되었습니다.");
					return false;
				}
				
				$.ajax({
	                url: "/donate/member_like_update.json",
	                type: "POST",
	                data: $('#frm_url').serialize(),
	                dataType: "json",
	                success: function (data, textStatus, jqXHR) {
	                	if (data.result == "OK"){
	                		$("#"+field).html(data[field]);
	                	}	
	                	
	                	chkLike = chkLike + field;
	                },
	                error: function (jqXHR, textStatus, errorThrown) {
	                    axf.alert("code:" + jqXHR.status + "\nmessage:" + textStatus + "\nerror:" + errorThrown);
	                }
	            });
				
			}
		} 
	
		function addReply(){
			if( !$('#replyContents').val() ){
				alert('댓글을 입력해주세요.');
			}else{
				$.ajax({
		            url: "/donate/member_com_insert.json",
		            type: "POST",
		            data: $('#frm_url').serialize(),
		            dataType: "json",
		            success: function (data, textStatus, jqXHR) {
		            	if (data.result == "OK"){
		            		axf.alert("댓글이 등록되었습니다.");
		            		$('#frm_url').attr({action: '/donate/member_view.c', method: 'post'}).submit();
		            	}else{
		            		axf.alert("댓글 등록에 실패했습니다.");
		            	}	
						
		            },
		            error: function (jqXHR, textStatus, errorThrown) {
		                axf.alert("code:" + jqXHR.status + "\nmessage:" + textStatus + "\nerror:" + errorThrown);
		            }
		        });
			}
		}
		
		function goList(page, obj){
			if(page==-1){
				alert('첫페이지입니다.');
				return;
			}else if(page==-2){
				alert('마지막페이지입니다.');
				return;
			}

			if($(obj).parent().parent('div').attr('id') == 'comPaging'){
				$('#comCurrentPage').val(page);
			}else if($(obj).parent().parent('div').attr('id') == 'letterPaging'){
				$('#letterCurrentPage').val(page);
			}
			$('#method').val('view');
			$('#frm_url').attr('action', '/donate/member_view.c').submit();
		}
		
		function goLetterView(idx){
			$("#menuCd").val('2');
			$("#seqCd1").val('2');
			$("#seqCd2").val('0');
			$('#method').val('view');
			$('#idx').val(idx);
			$('#gubun').val('letter');
			$('#frm_url').attr('action', '/donate/letter_view.c').submit();
		}
		
		function goDonateList(){
			$('#frm_url').attr('action', '/donate/member.c').submit();
		}
		
		//하늘나라 편지쓰기
		function goForm(donateIdx,donateNm){
			$('#donateIdx').val(donateIdx);
			$('#donateName').val(donateNm);
			$('#gubun').val("letter");
			$('#idx').val("");
			$('#frm_url').attr('action', '/donate/letter_form.c').submit();
		}
		
	</script>
</head>
<body>
	<input type="hidden" id="idx" name="idx" value="${donateSearch.idx }"/>
	<input type="hidden" id="currentPage" name="currentPage" value="${donateSearch.currentPage }"/>
	<input type="hidden" id="comCurrentPage" name="comCurrentPage" value="${comDonateSearch.currentPage }"/>
	<input type="hidden" id="letterCurrentPage" name="letterCurrentPage" value="${letterDonateSearch.currentPage }"/>
	<input type="hidden" id="name" name="name" value="<c:out escapeXml="true" value="${donateSearch.donateName }"/>"/>
	<input type="hidden" id="startDate" name="startDate" value="${donateSearch.startDate }"/>
	<input type="hidden" id="endDate" name="endDate" value="${donateSearch.endDate }"/>
	<input type="hidden" id="searchYear" name="searchYear" value="${donateSearch.searchYear }"/>
	<input type="hidden" id="method" name="method" />
	<input type="hidden" id="field" name="field" />
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
        </div>

        <div class="memorial__banner">
            <div class="wrap">
                <img src="${pageContext.request.contextPath}/resource/assets/images/memorial-img.png" alt="" class="action-img">
                <div class="memorial__banner-text">
                    <img src="${pageContext.request.contextPath}/resource/assets/images/memorial-title.png" alt="">
                </div>
                <button type="button" onclick="javascript:updateLike('donateFlower', ${donate.donateFlower });">헌화하기</button>
            </div>
        </div>

        <div class="wrap">
            <div class="memorial__info">
                <header class="flex">
                    <div class="flex-1 memorial__info-text">
                        <span>기증자</span>
                        <c:set var="donateNm"/>
						 <c:choose>
						 	<c:when test="${donate.donateAnonymity eq 'Y' }">
						 		<c:set var="donateNm" value="${fn:substring(donate.donateName, 0, 1) }*${fn:substring(donate.donateName, 2, fn:length(donate.donateName)) }"/>
						 	</c:when>
						 	<c:otherwise>
						 		<c:set var="donateNm" value="${donate.donateName }"/>
						 	</c:otherwise>
						 </c:choose>
						 <c:out value="${donateNm }"/>
                    </div>
                    <div class="flex-1 memorial__info-text">
                        <span>기증일</span>
						<fmt:parseDate var="regdate" value="${donate.donateDate }" pattern="yyyy-MM-dd"/>
						<fmt:formatDate value="${regdate }" pattern="yyyy-MM-dd"/>
                    </div>
                </header>
                <div class="memorial__info-box">
                    ${donate.donateContents }
                </div>
            </div>
            <div class="memorial__info-foot">
                <a href="javascript:goForm(${donate.donateIdx}, '${donateNm}');" class="f1">하늘나라 편지쓰기</a>
                <a href="javascript:goDonateList();" class="f2">목록보기</a>
            </div>


            <div class="memorial__comment">
                <div class="memorial__comment-top">
                    <button type = "button" class="type1" onclick="javascript:updateLike('donateFlower', ${donate.donateFlower });">
                        <img src="${pageContext.request.contextPath}/resource/assets/images/memorial-i3.png" alt=""> 헌화 <span id ="donateFlower">${donate.donateFlower }</span>
                    </button>
                    <button type = "button" class="type2" onclick="javascript:updateLike('donateLove', ${donate.donateLove });"><img src="${pageContext.request.contextPath}/resource/assets/images/memorial-i4.png" alt=""> 사랑해요 <span id ="donateLove">${donate.donateLove }</span></button>
                    <button type = "button" class="type3" onclick="javascript:updateLike('donateSee', ${donate.donateSee });"><img src="${pageContext.request.contextPath}/resource/assets/images/memorial-i5.png" alt=""> 보고싶어요 <span id ="donateSee">${donate.donateSee }</span></button>
                    <button type = "button" class="type4" onclick="javascript:updateLike('donatePine', ${donate.donatePine });"><img src="${pageContext.request.contextPath}/resource/assets/images/memorial-i6.png" alt=""> 그리워요 <span id ="donatePine">${donate.donatePine }</span></button>
                    <button type = "button" class="type5" onclick="javascript:updateLike('donateProud', ${donate.donateProud });"><img src="${pageContext.request.contextPath}/resource/assets/images/memorial-i7.png" alt=""> 자랑스러워요 <span id ="donateProud">${donate.donateProud }</span></button>
                    <button type = "button" class="type6" onclick="javascript:updateLike('donateHard', ${donate.donateHard });"><img src="${pageContext.request.contextPath}/resource/assets/images/memorial-i8.png" alt=""> 힘들어요 <span id ="donateHard">${donate.donateHard }</span></button>
                    <button type = "button" class="type7" onclick="javascript:updateLike('donateSad', ${donate.donateSad });"><img src="${pageContext.request.contextPath}/resource/assets/images/memorial-i9.png" alt=""> 슬퍼요 <span id ="donateSad">${donate.donateSad }</span></button>
                </div>
                <div class="memorial__comment-form">
                    <div class="textarea">
                        <textarea name="replyContents" id="replyContents" placeholder="기증자에 대한 추모 분위기를 해치거나, 비방의 글 등이 게시가 될 경우 관리자에 의해 삭제 될 수 있습니다. "></textarea>
                    </div>
                    <button type="button" onclick = "addReply(); return false;">댓글등록</button>
                </div>
				<c:if test="${not empty comList and comDonateSearch.totalCount > 0 }">
                <div class="memorial__comment-title">
                	<c:choose>
						<c:when test="${not empty comList and comDonateSearch.totalCount > 0 }">
							<c:forEach var="com" items="${comList }" varStatus="status">
								<span class="date">
									<fmt:parseDate var="regdate" value="${com.replyRegdate }" pattern="yyyy-MM-dd"/>
									<fmt:formatDate value="${regdate }" pattern="yyyy/MM/dd"/>
								</span>
								<p><c:out escapeXml="false" value="${cfn:nl2br(com.replyContents) }"/></p>
							</c:forEach>		
							<c:if test="${comDonateSearch.totalCount > 10 }">
								<div class="pagination" id="comPaging">
									<paging:pagingNew pagingObj="${comDonateSearch }"/>
								</div>
							</c:if>
						</c:when>
					</c:choose>
                </div>
                </c:if>
            </div>

            <div class="memorial__comment-list">
                <header>
                    <h2>하늘나라 편지 <span>${letterDonateSearch.totalCount }</span></h2>
                </header>
                <div class="list">
					<c:forEach var="letter" items="${letterList }" varStatus="status">
	                    <a href="javascript:goLetterView(${letter.storyIdx });" class="row">
	                        <p>
	                           <c:out escapeXml="true" value="${letter.storyTitle }"/> <span><c:if test="${not empty letter.comCnt }">&nbsp;<span class="pointColor"><c:out value="${letter.comCnt }"/></span></c:if></span>
	                        </p>
	                        <span class="date">
								<fmt:parseDate var="regdate" value="${letter.storyRegdate }" pattern="yyyy-MM-dd"/>
								<fmt:formatDate value="${regdate }" pattern="yyyy-MM-dd"/>
							</span>
	                    </a>
					</c:forEach>
                </div>
            </div>

			<c:if test="${letterDonateSearch.totalCount > 10 }">
	            <div class="pagination" id="letterPaging">
					<paging:pagingNew pagingObj="${letterDonateSearch }"/>
				</div>
			</c:if>

        </div>
	
</body>
</html>
