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
	function goSearch(){
		$('#searchKey').val($('#searchKeySelect').val());
		$('#currentPage').val(0);
		$('#method').val('');
		$('#frm_url').attr('action', '/com/comhuman.c').submit();
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
		$('#frm_url').attr('action', '/com/comhuman.c').submit();
	}
	
	function goView(idx){
		$('#method').val('view');
		$('#idx').val(idx);
		$('#frm_url').attr('action', '/com/comhuman_view.c').submit();
	}
</script>
</head>
<body>

	<input type="hidden" name="currentPage" id="currentPage" value="${prSearch.currentPage }" />
	<input type="hidden" name="searchKey" id="searchKey" value="${prSearch.searchKey }">
	<input type="hidden" name="method" id="method">
	<input type="hidden" name="idx" id="idx">
	<div class="wrap">
                <div class="sub__header">
                    <h2>인권경영</h2>
                </div>
                <div class="company__content company__management">
                    <div class="categoryBtn flex">
                        <a href="javascript:fn_MoveUrl('7','7','0')">인권경영 선언문(CEO 메시지)</a>
                        <a href="javascript:fn_MoveUrl('7','7','1')">인권경영규범</a>
                        <a href="javascript:fn_MoveUrl('7','7','2','/com/comhuman.c')" class="active">인권경영 게시판</a>
                    </div>
                    <div class="memorial__search-form mb-8">
                        <div class="select" style="margin:0;margin-right: 10px;">
	                        <select name="searchKeySelect" id="searchKeySelect" title="검색범위선택">
	                           <option value="">전체</option>
	                           <option value="title" <c:if test="${prSearch.searchKey eq 'title' }">selected</c:if>>제목</option>
	                           <option value="contents" <c:if test="${prSearch.searchKey eq 'contents' }">selected</c:if>>내용</option>
	                        </select>
                        </div>
                        <div class="input name mobile-mt-10">
                            <input title="검색어 입력창" type="text" name="searchValue" id="searchValue" value="<c:out escapeXml="true" value="${prSearch.searchValue }"/>" placeholder="검색어를 입력해주세요." onkeypress="if(event.keyCode == 13) goSearch();">
                        </div>
                        <button type="button" class="submit" onclick="return goSearch();">검색하기</button>
                    </div>
                    <div class="memorial__detail-content">
                        <div class="table promote__table effectNone">
                            <table>
                                <colgroup>
                                    <col class="col1">
                                    <col class="col">
                                    <col class="col3">
                                    <col class="col4">
                                </colgroup>
                                <thead>
                                    <tr>
                                        <th>번호</th>
                                        <th>제목</th>
                                        <th>등록일</th>
                                        <th>조회수</th>
                                    </tr>
                                </thead>
                                <tbody>
                                	<c:forEach var="human" items="${humanList }" varStatus="status">
	                                <tr>
	                                    <td><c:out value="${totalCount - ((prSearch.currentPage - 1) * prSearch.articleCount) - status.index }"/></td>
	                                    <td>
	                                        <a href="javascript:goView(${human.brdContNo })">
	                                           <c:out value="${human.brdTitle }"/>
	                                        </a>
	                                    </td>
	                                    <td>
	                                    	<fmt:parseDate var="regdate" value="${human.regDm }" pattern="yyyy-MM-dd"/>
											<fmt:formatDate value="${regdate }" pattern="yyyy-MM-dd"/>
	                                    </td>
	                                    <td><c:out value="${human.brdReadNum }"/></td>
	                                </tr>
									</c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div class="pagination">
				 	<paging:pagingNew pagingObj="${prSearch }"/>
					</div>

                </div>
            </div>
</body>
</html>
