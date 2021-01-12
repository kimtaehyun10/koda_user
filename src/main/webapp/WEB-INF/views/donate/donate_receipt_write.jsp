<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="paging" uri="/WEB-INF/tlds/paging.tld"%>
<%@ taglib prefix="cfn" uri="/WEB-INF/tlds/comFunction.tld"%>
<!doctype html>
<html lang="ko">
<head>
<script src="${pageContext.request.contextPath}/resource/ckeditor/ckeditor.js"></script>    
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
		
		if($("#m_result") == "fail"){
			alert("잘못된 접근입니다.");
			location.href="/main.c";
		}
    });
	
		function addRecipient(){
			if(checkForm('frm')){
				if(confirm('등록하시겠습니까?')){
					$("#contents").val(CKEDITOR.instances.contents.getData());
					
					$.ajax({
				           url: "/donate/story_insert.json",
				           type: "POST",
				           data: $('#frm_url').serialize(),
				           dataType: "json",
				           success: function (data, textStatus, jqXHR) {
				           	if (data.result == "insertSuccess"){
				           		axf.alert("게시글이 등록되었습니다.");
				           		
								$('#frm_url').attr({action: '/donate/story.c', method: 'post'}).submit();
				           	}else{
				           		axf.alert("게시글 등록에 실패했습니다.");
				           	}		
				           },
				           error: function (jqXHR, textStatus, errorThrown) {
				               axf.alert("code:" + jqXHR.status + "\nmessage:" + textStatus + "\nerror:" + errorThrown);
				           }
				       });
				}
			}
		}
		
		function modifyRecipient(){
			if(checkForm('frm')){
				if(confirm('등록하시겠습니까?')){
					$("#contents").val(CKEDITOR.instances.contents.getData());
					
					$.ajax({
			            url: "/donate/story_update.json",
			            type: "POST",
			            data: $('#frm_url').serialize(),
			            dataType: "json",
			            success: function (data, textStatus, jqXHR) {
			            	if (data.result == "updateSuccess"){
			            		axf.alert("게시글이 수정되었습니다.");
			            		
								$('#frm_url').attr({action: '/donate/story.c', method: 'post'}).submit();
			            	}else{
			            		axf.alert("게시글 등록에 실패했습니다.");
			            	}		
			            },
			            error: function (jqXHR, textStatus, errorThrown) {
			                axf.alert("code:" + jqXHR.status + "\nmessage:" + textStatus + "\nerror:" + errorThrown);
			            }
			        });
				}
			}
		}
		
		function deleteRecipient(){
			if(confirm('삭제하시겠습니까?')){
				$("#contents").val(CKEDITOR.instances.contents.getData());
				
				$.ajax({
		            url: "/donate/story_delete.json",
		            type: "POST",
		            data: $('#frm_url').serialize(),
		            dataType: "json",
		            success: function (data, textStatus, jqXHR) {
		            	if (data.result == "deleteSuccess"){
		            		axf.alert("게시글이 삭제되었습니다.");
		            		
							$('#frm_url').attr({action: '/donate/story.c', method: 'post'}).submit();
		            	}else{
		            		axf.alert("게시글 삭제에 실패했습니다.");
		            	}		
		            },
		            error: function (jqXHR, textStatus, errorThrown) {
		                axf.alert("code:" + jqXHR.status + "\nmessage:" + textStatus + "\nerror:" + errorThrown);
		            }
		        });
			}
		}
		
		function goList(){
			$('#frm_url').attr('action', '/donate/story.c').submit();
		}

	</script>
</head>
<body>

	<input type="hidden" name="searchKey" id="searchKey" value="<c:out escapeXml="true" value="${donateSearch.searchKey }"/>"/>
	<input type="hidden" name="searchValue" id="searchValue" value="<c:out escapeXml="true" value="${donateSearch.searchValue }"/>"/>
	<input type="hidden" name="currentPage" id="currentPage" value="<c:out escapeXml="true" value="${donateSearch.currentPage }"/>"/>
	<input type="hidden" name="idx" id="idx" value="${donateSearch.idx }"/>
	<input type="hidden" name="gubun" id="gubun" value="${donateSearch.gubun }"/>
	<input type="hidden" name="method" id="method" value=""/>
	<input type="hidden" name="donateIdx" id="donateIdx" value="${recipient.donateIdx }" />
	<input type="hidden" name="c_idx" id="c_idx" value="${sessionScope.cidx}"/>
	<input type="hidden" name="m_result" id="m_result" value="${m_result}"/>
	<div class="wrap">
                <div class="sub__header">
                    <h2>하늘나라 편지</h2>
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


                <div class="memorial__message">
                    <div class="memorial__message-info" style="margin-bottom: 20px;">
                        <div class="infobox">
                            <h2>수혜자 편지 작성 시 확인하세요!</h2>
                            <ul>
                                <li>경건한 분위기에서 기증자분들을 추모할 수 있도록 협조 부탁드립니다.</li>
                                <li>비방이나 욕설 등 분위기를 해치는 내용은 관리자에 의해 임의 삭제될 수 있습니다.</li>
                                <li>게시글 작성시 개인정보 표기는 자제해주시기 바랍니다.</li>
                                <li>일부 게시글은 한국장기조직기증원 뉴스레터 및 타 매체에 원문의 의미를 훼손하지 않는 범위내에서 교정을 거쳐 익명으로 게재될 수 있습니다. </li>
                            </ul>
                        </div>
                    </div>

                    <div class="memorial__write">
                        <table>
                            <colgroup>
                                <col class="memorial__write-col1">
                                <col class="memorial__write-col2">
                            </colgroup>
                            <tbody>
                            <tr>
                                <th>
                                    <strong class="require">수혜자</strong>
                                </th>
                                <td>
                                    <div class="flex has-ck">
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
										
                                        <div class="input w350">
                                            <input type="text" id="writer" name="writer" value="<c:out escapeXml="true" value="${strtext }"/>"/>
                                        </div>

                                        <label for="ck1" class="checkbox">
                                            <input type="checkbox" id="anonymity" name="anonymity" hidden value="Y" <c:if test="${recipient.storyAnonymity eq 'Y' }">checked="checked"</c:if>>
                                            <span></span>
                                            <p>익명으로 작성하기</p>
                                        </label>
                                    </div>
                                </td>
                            </tr>
                           <c:if test="${donateSearch.idx eq 0 }">
                            <tr>
                                <th>
                                    <strong class="require">비밀번호</strong>
                                </th>
                                <td>
                                    <div class="flex">
                                        <div class="input w350">
											<input type="password" id="pwd" name="pwd" msg="비밀번호를"/>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            </c:if>
                            <tr>
                                <th>
                                    <strong class="require">기증받은 장기</strong>
                                </th>
                                <td >
                                    <div class="flex">
                                        <div class="select w350">
                                            <select name="area" id="area">
                                                <option value="">선택</option>
												<option value="1" <c:if test="${recipient.storyArea eq 1 }"> selected </c:if>>신장</option>
												<option value="2" <c:if test="${recipient.storyArea eq 2 }"> selected </c:if>>간장</option>
												<option value="3" <c:if test="${recipient.storyArea eq 3 }"> selected </c:if>>췌장</option>
												<option value="4" <c:if test="${recipient.storyArea eq 4 }"> selected </c:if>>심장</option>
												<option value="5" <c:if test="${recipient.storyArea eq 5 }"> selected </c:if>>폐</option>
												<option value="6" <c:if test="${recipient.storyArea eq 6 }"> selected </c:if>>췌도</option>
												<option value="7" <c:if test="${recipient.storyArea eq 7 }"> selected </c:if>>소장</option>
												<option value="8" <c:if test="${recipient.storyArea eq 8 }"> selected </c:if>>대장</option>
												<option value="9" <c:if test="${recipient.storyArea eq 9 }"> selected </c:if>>위장</option>
												<option value="10" <c:if test="${recipient.storyArea eq 10 }"> selected </c:if>>십이지장</option>
												<option value="11" <c:if test="${recipient.storyArea eq 11 }"> selected </c:if>>비장</option>
												<option value="12" <c:if test="${recipient.storyArea eq 12 }"> selected </c:if>>손, 팔</option>
												<option value="13" <c:if test="${recipient.storyArea eq 13 }"> selected </c:if>>안구</option>
												<option value="14" <c:if test="${recipient.storyArea eq 14 }"> selected </c:if>>인체조직</option>
                                            </select>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <strong class="require">기증받은 연도</strong>
                                </th>
                                <td >
                                    <div class="flex">
                                        <div class="select w350">
                                            <select name="story_org_img" id="story_org_img">
                                                <option value="">선택하세요</option>
                                                <c:forEach var="i" begin="0" end="${2030-1995}">
												<c:set var="yearOption" value="${2030-i}" />
												<option   value="${yearOption}" <c:if test="${yearOption eq strtxt1 }"> selected </c:if>>${yearOption}</option>
												</c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <strong class="require">제목</strong>
                                </th>
                                <td>
                                    <div class="flex">
                                        <div class="input">
											<input type="text" id="title" name="title" value="<c:out escapeXml="true" value="${strtxt }"/>" msg="제목을"/>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="padding: 10px 0;">
                                    <textarea class="ckeditor" id="contents" name="contents" rows="5" msg="내용을"><c:out escapeXml="true" value="${story.storyContents }"/></textarea>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="form-actions justify-center">
                        <c:if test="${empty donateSearch.idx or donateSearch.idx eq 0 }">
                        	<button type="button" class="btn submit" onclick="javascript:addRecipient();">등록</button>
						</c:if>
						<c:if test="${donateSearch.idx > 0 }">
                        	<button type="button" class="btn submit" onclick="javascript:modifyRecipient();">수정</button>
                        	<a href="javascript:deleteRecipient();" class="btn">삭제</a>
						</c:if>
						<a href="javascript:goList();" class="btn">취소</a>
                    </div>
                </div>
            </div>
	
</body>
</html>
