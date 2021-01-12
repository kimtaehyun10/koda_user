<?xml version="1.0" encoding="UTF-8"?>
<%@ page contentType="text/xml;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<items>
	<c:forEach items="${list}" var="list">
		<item>
			<parkSectionKey>${list.parkSectionKey}</parkSectionKey>
			<parkDivisionKey>${list.parkDivisionKey}</parkDivisionKey>
			<mberNm>${list.mberNm}</mberNm>
			<carNumber>${list.carNumber}</carNumber>
			<mberPhone>${list.mberPhone}</mberPhone>
		</item>		
	</c:forEach>
</items>