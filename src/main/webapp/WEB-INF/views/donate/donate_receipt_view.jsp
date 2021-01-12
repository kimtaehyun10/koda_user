<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/paging.tld"%>
<%@ taglib prefix="cfn" uri="/WEB-INF/tlds/comFunction.tld"%>
<!doctype html>
<html lang="ko">
<head>

<script type="text/javascript" src="/resource/js/com/frmCheck.js"></script>
<script type="text/javascript">
	jQuery(document).ready(function() {
		
		var a = $("#c_idx").val();
		var b = $("#idx").val();
		
		if(a !="" && b !="0"){
			if(a != b){
			alert("잘못된 접근입니다.");
			location.href="/home.do";
			}
		
		}
    });
	
		function goList(page, obj){
			if(page==-1){
				alert('첫페이지입니다.');
				return;
			}else if(page==-2){
				alert('마지막페이지입니다.');
				return;
			}
			
			$('#comCurrentPage').val(page);
			$('#method').val('view');
			$('#frm_url').attr('action', '/donate/receipt_view.c').submit();
		}
		
		function deleteStory(){
			if(confirm('게시글을 삭제하시겠습니까?')){

				$('#comCurrentPage').val(0);
				$('#comIdx').val(0);
				$('#optionStr').val('del');

				$('#esignup-1').css('display', 'flex');
				$('#ppw').focus()
			}
		}
		
		function goModify(){
			$('#comIdx').val(0);
			$('#optionStr').val('update');

			$('#esignup-1').css('display', 'flex');
			$('#ppw').focus()
		}
	
		function addComment(){
			if(checkForm('frm_url')){
				
				$.ajax({
		            url: "/donate/receipt_com_insert.json",
		            type: "POST",
		            data: $('#frm_url').serialize(),
		            dataType: "json",
		            success: function (data, textStatus, jqXHR) {
		            	if (data.result == "OK"){
		            		axf.alert("댓글이 등록되었습니다.");
		            		
							$('#reloadYn').val('Y');
							$('#frm_url').attr({action: '/donate/receipt_view.c', method: 'post'}).submit();
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
		
	
		function deleteComment(idx){
			if(confirm('댓글을 삭제하시겠습니까?')){			
				$('#comCurrentPage').val(1);
				$('#comIdx').val(idx);
				$('#optionStr').val('del');
				
				$('#esignup-1').css('display', 'flex');
				$('#ppw').focus()
			}
		}
		

		function chkPassword(){
			$.ajax({
		           url: "/donate/pwd_action.json",
		           type: "POST",
		           data: $('#frm_url').serialize(),
		           dataType: "json",
		           success: function (data, textStatus, jqXHR) {
		           	if (data.result == "comDelSuccess"){
		           		axf.alert("댓글이 삭제되었습니다.");		            		

		           		$('#esignup-1').hide();;
		           		
						$('#reloadYn').val('Y');
						$('#frm_url').attr({action: '/donate/receipt_view.c', method: 'post'}).submit();
		           	}else if (data.result == "delSuccess"){
		           		axf.alert("게시글이 삭제되었습니다.");		            		

		           		$('#esignup-1').hide();;
		           		
						$('#frm_url').attr({action: '/donate/receipt.c', method: 'post'}).submit();
		           	}else if (data.result == "goUpdate"){      		

		           		$('#esignup-1').hide();

						$('#pwdYn').val('Y');
						$('#frm_url').attr({action: '/donate/receipt_form.c', method: 'post'}).submit();
		           	}else if (data.result == "pwdFail"){
		           		axf.alert("비밀번호를 확인하십시요.");
		           	}else if (data.result == "FAIL"){
		           		axf.alert("댓글 삭제에 실패했습니다.");
		           	}		
		           },
		           error: function (jqXHR, textStatus, errorThrown) {
		               axf.alert("code:" + jqXHR.status + "\nmessage:" + textStatus + "\nerror:" + errorThrown);
		           }
		       });
		}
		
		function goRecipientList(){
			$('#frm_url').attr('action', '/donate/receipt.c').submit();
		}
	</script>
</head>
<body>

	<input type="hidden" name="searchKey" id="searchKey" value="<c:out escapeXml="true" value="${donateSearch.searchKey }"/>"/>
	<input type="hidden" name="searchValue" id="searchValue" value="<c:out escapeXml="true" value="${donateSearch.searchValue }"/>"/>
	<input type="hidden" name="currentPage" id="currentPage" value="<c:out escapeXml="true" value="${donateSearch.currentPage }"/>"/>
	<input type="hidden" name="comCurrentPage" id="comCurrentPage" value="<c:out escapeXml="true" value="${comDonateSearch.currentPage }"/>"/>
	<input type="hidden" name="idx" id="idx" value="${donateSearch.idx }"/>
	<input type="hidden" name="gubun" id="gubun" value="${donateSearch.gubun }"/>
	<input type="hidden" name="optionStr" id="optionStr"/>
	<input type="hidden" name="comIdx" id="comIdx"/>
	<input type="hidden" name="method" id="method" value=""/>
	<input type="hidden" name="pwdYn" id="pwdYn" value=""/>
	<input type="hidden" name="c_idx" id="c_idx" value="${sessionScope.cidx}"/>
	<input type="hidden" name="reloadYn" id="reloadYn" value=""/>
	<div class="wrap">
                <div class="sub__header">
                    <h2>수혜자 편지</h2>
                </div>
                 <div class="sub__tabs memorial">
                    <a href="javascript:fn_MoveUrl('2','1','0','/donate/member.c')" class="">기증자 추모관</a>
                    <a href="javascript:fn_MoveUrl('2','2','0','/donate/letter.c')">하늘나라 편지</a>
                    <a href="javascript:fn_MoveUrl('2','3','0','/donate/receipt.c')" class="active">수혜자 편지</a>
                    <a href="javascript:fn_MoveUrl('2','4','0','/donate/story.c')" class="">기증 후 스토리</a>


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


                <div class="memorial__detail">
                    <header>
                        <h2 class="title">
                            <c:choose>
							<c:when test="${fn:contains(recipient.storyTitle,'|')}">
									<c:set var="strtxt" value="${fn:split(recipient.storyTitle,'|')[0]}"/>
									<c:set var="strtxt1" value="${fn:split(recipient.storyTitle,'|')[1]}"/>
							</c:when>
							<c:otherwise>
							<c:set var="strtxt" value="${recipient.storyTitle }"/>
							<c:set var="strtxt1" value=""/>
							</c:otherwise>
							</c:choose>
							<c:out value="${strtxt }"/>
                        </h2>
                        <div class="info">
                            <div class="col">
                                수혜자 <span>
                       	<c:choose>
								<c:when test="${fn:contains(recipient.storyWriter,'|')}">
										<c:set var="strtext" value="${fn:split(recipient.storyWriter,'|')[0]}"/>
										<c:set var="strtext1" value="${fn:split(recipient.storyWriter,'|')[1]}"/>
								</c:when>
								<c:otherwise>
								<c:set var="strtext" value="${recipient.storyWriter }"/>
								<c:set var="strtext1" value=""/>
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
                       </span>
                            </div>
                            <div class="col">
                                등록일 <span>
							<fmt:parseDate var="regdate" value="${recipient.storyRegdate }" pattern="yyyy-MM-dd"/>
							<fmt:formatDate value="${regdate }" pattern="yyyy-MM-dd"/>
						</span>
                            </div>
                            <div class="col">
                                조회 <span><c:out value="${recipient.storyHits }"/></span>
                            </div>
                        </div>
                    </header>
                    <div class="memorial__detail-body">
                        <img src="${pageContext.request.contextPath}/resource/assets/images/memorial-detail-top.png" alt="">
                        <div class="detail" >
                            <p style="white-space: pre-line;line-height: 2em;">${cfn:nl2br(recipient.storyContents) }</p>
                        </div>
                        <img src="${pageContext.request.contextPath}/resource/assets/images/memorial-detail-bottom.png" alt="">
                    </div>

                    <div class="memorial__detail-foot">
                        <a href="javascript:goModify();" class="active">수정</a>
                        <a href="javascript:deleteStory();" class="">삭제</a>
                        <a href="javascript:goRecipientList();" class="">목록</a>
                    </div>
                </div>

                <div class="memorial__comment">
                    <div class="memorial__comment-author">
                        <div class="col">
                            <strong>이름</strong>
                            <div class="input">
                            	<input type="text" id="uname" name="uname" msg="이름을" onkeypress="if(event.keyCode == 13) return false;">
                            </div>
                        </div>
                        <div class="col">
                            <strong>비밀번호</strong>
                            <div class="input">
                            	<input type="password" id="upw" name="upw" msg="비밀번호를" onkeypress="if(event.keyCode == 13) return false;">
                            </div>
                        </div>
                    </div>
                    <div class="memorial__comment-form">
                        <div class="textarea">
							<textarea name="comContent" id="comContent" class="textarea" title="댓글 입력" placeholder="기증자에 대한 추모 분위기를 해치거나, 비방의 글 등이 게시가 될 경우 관리자에 의해 삭제 될 수 있습니다. " msg="댓글을"></textarea>
                        </div>
						<button type="button" onclick="addComment(); return false;" title="댓글등록">댓글등록</button>
                    </div>


                    <div class="memorial__detail-comment">
                        <div class="memorial__comment-total">
                            	댓글 <span>${comDonateSearch.totalCount }</span>
                        </div>
                        <div class="list">
						<c:choose>
							<c:when test="${not empty comList and comDonateSearch.totalCount > 0 }">
								<c:forEach var="com" items="${comList }" varStatus="status">
		                            <div class="memorial__comment-title">
		                                <div class="info">
		                                    <strong><c:out escapeXml="true" value="${com.comRegName }"/></strong>
		                                    <span class="date">
												<fmt:parseDate var="regdate" value="${com.comRegDate }" pattern="yyyy-MM-dd"/>
												<fmt:formatDate value="${regdate }" pattern="yyyy/MM/dd"/>
											</span>
		                                    <a href="javascript:deleteComment(${com.comIdx })">삭제</a>
		                                </div>
		                                <p>
		                                	<c:out escapeXml="false" value="${cfn:nl2br(com.comContent) }"/>
		                                </p>
		                            </div>
								</c:forEach>
	                            <c:if test="${comDonateSearch.totalCount > 10 }">
									<div class="pagination">
										<paging:pagingNew pagingObj="${comDonateSearch }"/>
									 </div>
								</c:if>
							</c:when>
						</c:choose>
                        </div>
                            
                        </div>
                    </div>
                </div>
                
                <div class="isMailbox">
	            <div class="modal modal--eisngup" style="display: none;" id="esignup-1">
					<div class="modal__content">
						<header>
							<h1>비밀번호 확인</h1>
							<button type="button" class="close" onclick="$('#esignup-1').hide();"></button>
						</header>
						<div class="modal__body">
								<div class="form">
									<table>
										<colgroup>
											<col class="w1">
											<col>
										</colgroup>
										<tbody>
											<tr>
												<th><strong>비밀번호</strong></th>
												<td>
													<div class="input">
														<input type="password" id="ppw" name="ppw" title="비밀번호" placeholder="비밀번호를 입력해주세요." onkeypress="if(event.keyCode == 13) chkPassword()();">
													</div>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
			
								<button type="button" class="submit" onclick="javascript:chkPassword()">확인</button>
								
						</div>
					</div>
				</div>	
				</div>

</body>
</html>
