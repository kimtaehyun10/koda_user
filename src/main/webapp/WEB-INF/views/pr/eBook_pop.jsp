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
<html>
<head>
	<title></title>
</head>
<body>
<c:if test="${empty bean.brdUrl }">		
	<script type="text/javascript">
		alert('등록된 미리보기가 없습니다. ');
		self.close();
	</script>
</c:if>
	<!-- wrap frame : s -->
	<div id="wrapFrame">
		<c:if test="${not empty bean.brdUrl }">
			<iframe src="${bean.brdUrl }" frameborder="0" allowfullscreen width="100%" height="700"></iframe>
		</c:if>
	</div>
</body>
</html>