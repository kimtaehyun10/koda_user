<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
  

<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:w="urn:schemas-microsoft-com:office:word"
xmlns:m="http://schemas.microsoft.com/office/2004/12/omml"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=ks_c_5601-1987">
<meta name=ProgId content=Word.Document>
<meta name=Generator content="Microsoft Word 15">
<meta name=Originator content="Microsoft Word 15">

<script type="text/javascript">
     window.print();
 </script>

<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/print_visit.css"/>

 
</head>

<body>

	<div class="wrap">
		<c:forEach items="${list}" var="item" varStatus="rowStatus">
			<div class="image">
	
				<img src="${pageContext.request.contextPath}/resource/images/print_visit.png" width="900" height="1158"  style="relative: width:100%; left:0px;">
				
				<h01>${item.labelTitle}</h01>
				<h02>평일/주간</h02>
				<h03>(월~금/09:00~18:00)</h03>
				<h04>${item.carNumber}</h04>
				<h05>${item.useBeginDateStr}~${item.useEndDateStr}</h05>
				<h06>${item.mberPhoneStr}</h06>
	
			</div>
		</c:forEach>
	</div>

</body>

</html>
