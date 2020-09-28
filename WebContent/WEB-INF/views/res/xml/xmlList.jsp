<?xml version="1.0" encoding="UTF-8"?>
<%@ page contentType="text/xml;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<xml>
	
	<total>${data.total}</total>
	<contents>
		<c:forEach items="${data.list}" var="list">
			<content>
				<unitseqno>${list.unitseqno}</unitseqno>
				<sectionseqno>${list.sectionseqno}</sectionseqno>
				<usestatus>${list.usestatus}</usestatus>
				<longitude>${list.longitude}</longitude>
				<latitude>${list.latitude}</latitude>
				<carno>${list.carno}</carno>
				<mobile>${list.mobile}</mobile>
				<usetimeseqno>${list.usetimeseqno}</usetimeseqno>
				<applyfromdate>${list.applyfromdate}</applyfromdate>
				<applytodate>${list.applytodate}</applytodate>
				<minapyn>${list.minapyn}</minapyn>
				<discvalue>${list.discvalue}</discvalue>
			</content>		
		</c:forEach>
	</contents>
</xml>