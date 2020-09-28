<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>

<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/common.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/axisj/dist/AXJ.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/axisj/lib/AXUtil.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/axisj/lib/AXValidator.js"></script>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resource/axicon/axicon.min.css"/>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resource/axisj/ui/AXJ.min.css"/>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/main.css"/>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/sub.css"/>

<sitemesh:write property="head" />
	<script>
		$.ajaxSettings.traditional = true;

		/**
		 * 팝업삭제
		 * @param popupId
		 */
		function closePopup(){
			$('#${param.popupId}_bg', parent.document).remove();
			$('#${param.popupId}', parent.document).remove();
		}
		function callBack(data){
			var funcExist = existFunction("${param.callback}");
			if(funcExist){
				var funcNm = '${param.callback}';
				parent.window[funcNm](data);
			}
		}
		function existFunction(func){
			return typeof window[func]=== "function";
		}

		// 세션만료시 부모페이지로 redirect 하기위한 설정
		/*
		if (top.location != self.location) {
			top.location = self.location.href;
		}
		*/
	</script>
</head>
<body onload="">
	<div class="popup_box">
	    <div class="pop_title"><h3><sitemesh:write property="title" /></h3></div>
        
        <sitemesh:write property="body" />
	</div>
</body>	
</html>