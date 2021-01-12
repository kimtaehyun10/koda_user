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
	
		function addStory(){
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
		
		function modifyStory(){
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
		
		function deleteStory(){
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
		<input type="hidden" name="searchKey" id="searchKey" value="${donateSearch.searchKey }"/>
		<input type="hidden" name="searchValue" id="searchValue" value="<c:out escapeXml="true" value="${donateSearch.searchValue }"/>"/>
		<input type="hidden" name="currentPage" id="currentPage" value="${donateSearch.currentPage }"/>
		<input type="hidden" name="idx" id="idx" value="${donateSearch.idx }"/>
		<input type="hidden" name="gubun" id="gubun" value="${donateSearch.gubun }"/>
		<input type="hidden" name="method" id="method" value=""/>
		<input type="hidden" name="c_idx" id="c_idx" value="${sessionScope.cidx}"/>
		<input type="hidden" name="m_result" id="m_result" value="${m_result}"/>
		
<div class="wrap">
                <div class="sub__header">
                    <h2>하늘나라 편지</h2>
                </div>
                <div class="sub__tabs memorial">
                    <a href="javascript:fn_MoveUrl('2','1','0','/donate/member.c')" class="">기증자 추모관</a>
                    <a href="javascript:fn_MoveUrl('2','2','0','/donate/letter.c')">하늘나라 편지</a>
                    <a href="javascript:fn_MoveUrl('2','3','0','/donate/receipt.c')" class="">수혜자 편지</a>
                    <a href="javascript:fn_MoveUrl('2','4','0','/donate/story.c')" class="active">기증 후 스토리</a>


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
                    <div class="memorial__message-info" style="margin-bottom: 20px;">
                        <div class="infobox">
                            <h2>기증 후 스토리 작성 시 확인하세요!</h2>
                            <ul>
                                <li>게시글 작성시 개인정보 표기는 자제해주시기 바랍니다.</li>
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
                                    <strong class="require">코디네이터</strong>
                                </th>
                                <td>
                                    <div class="flex has-ck">
                                        <div class="input w350">
                                            <input type="text" id="writer" name="writer" value="<c:out escapeXml="true" value="${story.storyWriter }"/>" msg="코디네이터를"/>
                                        </div>
                                        <label for="anonymity" class="checkbox">
                                            <input type="checkbox" id="anonymity" name="anonymity" hidden value="Y" <c:if test="${story.storyAnonymity eq 'Y' }">checked="checked"</c:if>>
                                            <span></span>
                                            <p>익명</p>
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
                                    <strong class="require">권역선택</strong>
                                </th>
                                <td >
                                    <div class="flex flex-wrap items-center">
                                        <label for="area1" class="radio my-2 mr-6">
                                            <input type="radio" name="area" id="area1" hidden value="1"  <c:if test="${empty story.storyArea or story.storyArea eq '1' }">checked="checked"</c:if>>
                                            <span></span>
                                            <p>1권역(수도권, 강원, 제주)</p>
                                        </label>
                                        <label for="area2" class="radio my-2  mr-6">
                                            <input type="radio" name="area" id="area2" hidden value="2"  <c:if test="${empty story.storyArea or story.storyArea eq '2' }">checked="checked"</c:if>>
                                            <span></span>
                                            <p>2권역(충청, 전라)</p>
                                        </label>
                                        <label for="area3" class="radio my-2 ">
                                            <input type="radio" name="area" id="area3" hidden value="3"  <c:if test="${empty story.storyArea or story.storyArea eq '3' }">checked="checked"</c:if>>
                                            <span></span>
                                            <p>3권역(영남)</p>
                                        </label>
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
                                            <input type="text" id="title" name="title" value="<c:out escapeXml="true" value="${story.storyTitle }"/>" msg="제목을"/>
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
                        	<button type="button" class="btn submit" onclick="javascript:addStory();">등록</button>
						</c:if>
						<c:if test="${donateSearch.idx > 0 }">
                        	<button type="button" class="btn submit" onclick="javascript:modifyStory();">수정</button>
                        	<a href="javascript:deleteStory();" class="btn">삭제</a>
						</c:if>
						<a href="javascript:goList();" class="btn">취소</a>
                    </div>
                </div>
            </div>	
</body>
</html>
