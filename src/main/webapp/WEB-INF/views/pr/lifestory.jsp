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

		function goSearch(){
			$('#searchKey').val($('#searchKeySelect').val());
			$('#currentPage').val(0);
			$('#method').val('');
			$('#frm_url').attr('action', '/pr/lifeSharing.c').submit();
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
			$('#frm_url').attr('action', '/pr/lifeSharing.c').submit();
		}
		
		function goView(idx){
			$('#method').val('view');
			$('#idx').val(idx);
			$('#frm_url').attr('action', '/pr/lifeSharing_view.c').submit();
		}

		function fn_select_change(){
			var idx = "";
			idx = $("#moveselect option:selected").val();
			
			fn_MoveUrl(menucd, seqcd1, seqcd2[idx],url[idx]);
		
		}
</script>
</head>
<body>

	<input type="hidden" name="currentPage" id="currentPage" value="${sponsorSearch.currentPage }" />
	<input type="hidden" name="searchKey" id="searchKey" value="${sponsorSearch.searchKey }">
	<input type="hidden" name="idx" id="idx">
	<input type="hidden" name="method" id="method" value="">
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
                <div class="memorial__detail-content">
                    <div class="promote__publication flex flex-wrap pr">
						<c:forEach var="story" items="${storyList }" varStatus="status">
                        
                            <div class="item">
                                <a href="javascript:goView(<c:out value="${story.brdContNo }"/>)" class="inline-block">
                                    <div class="imgBox">
                                        <div class="img">
                                            <img src="${pageContext.request.contextPath}/resource/assets/images/publication-bg3.png" alt="<c:out value="${story.brdTitle }" />">
	                    					<!-- <img src="/upFile/${story.brdFileNm }" alt="<c:out value="${story.brdTitle }" />"> -->
                                        </div>
                                    </div>
                                    <div class="txtBox">
                                        <div class="title">
                                        <c:out value="${story.brdTitle }" />
                                    </div>
                                        <div class="date flex items-center">
				                        	<fmt:parseDate var="regdate" value="${story.regDm }" pattern="yyyy-MM-dd"/>
											<fmt:formatDate value="${regdate }" pattern="yyyy-MM-dd"/>
                                        	<!-- <span class="clip ml-auto">
                                                <img src="${pageContext.request.contextPath}/resource/assets/images/clip.png" alt="">
                                            </span> -->
                                        </div>
                                    </div>
                                </a>
                            </div>
                       </c:forEach>
                        
                    </div>
                </div>

                <div class="pagination">
				 	<paging:pagingNew pagingObj="${prSearch }"/>
				</div>

            </div>
	
</body>
</html>
