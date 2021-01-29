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
		$('#frm_url').attr('action', '/pr/webcontents.c').submit();
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
		$('#frm_url').attr('action', '/pr/webcontents.c').submit();
	}
	
	function goView(idx){
		$('#method').val('view');
		$('#idx').val(idx);
		$('#frm_url').attr('action', '/pr/webcontents_view.c').submit();
	}

	function fn_select_change(){
		var idx = "";
		idx = $("#moveselect option:selected").val();
		
		fn_MoveUrl(menucd, seqcd1, seqcd2[idx],url[idx]);
	
	}
	
</script>
</head>
<body>

	<input type="hidden" name="currentPage" id="currentPage" value="${prSearch.currentPage }" />
	<input type="hidden" name="searchKey" id="searchKey" value="${prSearch.searchKey }">
	<input type="hidden" name="idx" id="idx">
	<input type="hidden" name="method" id="method">
	<div class="wrap">
                <div class="sub__header">
                    <h2>홍보콘텐츠</h2>
                </div>
                <div class="promote__select flex ml-auto">
                    <select name="moveselect" id="moveselect" onchange="javascript:fn_select_change();">
                        <option value="0" selected>홍보콘텐츠</option>
                        <option value="1">생명나눔 스토리</option>
                    </select>
                </div>
                <div class="memorial__detail-content">
                    <div class="promote__publication flex flex-wrap pr">
						<c:forEach var="webContents" items="${webContentsList }" varStatus="status">
                            <div class="item">
                                <a href="javascript:goView(<c:out value="${webContents.brdContNo }"/>)" class="inline-block">
                                    <div class="imgBox">
                                        <div class="img">                                        	
                                            <!--<img src="${pageContext.request.contextPath}/resource/assets/images/publication-bg2.png" alt="<c:out value="${webContents.brdTitle }" />">-->
                                            <img src="/imageView.do?imageName=${webContents.brdFileNm}" alt="" style="width: 360px; height: 265px;">
                                        </div>
                                    </div>
                                    <div class="txtBox">
                                        <div class="title">
                                        <c:out value="${webContents.brdTitle }" />
                                    </div>
                                        <div class="date flex items-center">
				                        	<fmt:parseDate var="regdate" value="${webContents.regDm }" pattern="yyyy-MM-dd"/>
											<fmt:formatDate value="${regdate }" pattern="yyyy-MM-dd"/>
                                        <span class="clip ml-auto">
                                                <img src="${pageContext.request.contextPath}/resource/assets/images/clip.png" alt="">
                                            </span>
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
