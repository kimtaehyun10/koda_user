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
		$('#brdNo').val($('#brdNoSelect').val());
		$('#currentPage').val(0);
		$('#method').val('');
		$('#frm_url').attr('action', '/info/infolaw.c').submit();
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
		$('#frm_url').attr('action', '/info/infolaw.c').submit();
	}
	
	function goView(idx, brdNo){
		$('#method').val('view');
		$('#brdNo').val(brdNo);
		$('#idx').val(idx);
		$('#frm_url').attr('action', '/info/infolaw_view.c').submit();
	}
	
</script>
</head>
<body>

	<input type="hidden" name="currentPage" id="currentPage" value="${libSearch.currentPage }" />
	<input type="hidden" name="searchKey" id="searchKey" value="${libSearch.searchKey }">
	<input type="hidden" name="idx" id="idx">
	<input type="hidden" name="brdNo" id="brdNo">
	<input type="hidden" name="method" id="method">
	<div class="wrap">
                <div class="sub__header">
                    <h2>법률·학술자료</h2>
                </div>
                <div class="memorial__search-form mb-8">
                    <div class="select" style="margin:0;margin-right: 10px;">
                        <select name="brdNoSelect" id="brdNoSelect">
                            <option value="">전체분류</option>
                            <option value="21" <c:if test="${libSearch.brdNo eq 21 }">selected</c:if>>법률자료</option>
                            <option value="13" <c:if test="${libSearch.brdNo eq 13 }">selected</c:if>>학술자료</option>
                        </select>
                    </div>
                    <div class="select" style="margin:0;margin-right: 10px;">
                        <select name="searchKeySelect" id="searchKeySelect">
                             <option value="">전체</option>
                             <option value="title" <c:if test="${libSearch.searchKey eq 'title' }">selected</c:if>>제목</option>
                             <option value="contents" <c:if test="${libSearch.searchKey eq 'contents' }">selected</c:if>>내용</option>
                        </select>
                    </div>
                    <div class="input name mobile-mt-10">
                    	<input title="검색어 입력창" type="text" name="searchValue" id="searchValue" value="<c:out escapeXml="true" value="${libSearch.searchValue }"/>" placeholder="검색어를 입력해주세요." onkeypress="if(event.keyCode == 13) goSearch();">
                    </div>
                    <button type="button" class="submit" onclick="return goSearch();">검색하기</button>
                </div>
                <div class="memorial__detail-content">
                    <div class="table promote__table effectNone">
                        <table>
                            <colgroup>
                                <col class="col1">
                                <col class="col1">
                                <col class="col">
                                <col class="col3">
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>번호</th>
                                    <th>구분</th>
                                    <th>제목</th>
                                    <th>등록일</th>
                                </tr>
                            </thead>
                            <tbody>
                            	<c:forEach var="libList" items="${libList }" varStatus="status">
								<tr>
									<td><c:out value="${totalCount - ((libSearch.currentPage - 1) * libSearch.articleCount) - status.index }"/></td>
                                    <td>
										<c:choose>
											<c:when test="${libList.brdNo eq 13 }">학술자료</c:when>
											<c:when test="${libList.brdNo eq 21 }">법률</c:when>
										</c:choose>
									</td>
                                    <td>
                                        <a href="javascript:goView(<c:out value="${libList.brdContNo }"/>, <c:out value="${libList.brdNo }"/>)">
                                          <c:out value="${libList.brdTitle }" />
                                        </a>
                                    </td>
                                    <td><fmt:parseDate var="regdate" value="${libList.regDm }" pattern="yyyy-MM-dd"/>
										<fmt:formatDate value="${regdate }" pattern="yyyy-MM-dd"/></td>
									
								</tr>
								</c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="pagination">
					<paging:pagingNew pagingObj="${libSearch }"/>
				</div>

            </div>
</body>
</html>
