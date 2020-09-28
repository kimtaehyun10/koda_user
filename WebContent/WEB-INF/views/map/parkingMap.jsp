<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>동작구시설관리공단 주차시설</title>

    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery.form.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/common.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/axisj/dist/AXJ.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/axisj/lib/AXUtil.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/axisj/lib/AXValidator.js"></script>

    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resource/axicon/axicon.min.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resource/axisj/ui/AXJ.min.css"/>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/main.css"/>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/map.css"/>
    
    <!-- Daum지도 API키 Import-->
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=<spring:eval expression="@appConfig['daum.api.key']"/>"></script>

    <script id="jscode">
    
    var parentOpenType = '${param.openType}';
    var parentManageZone = '${param.searchManageZone}';
    var parentSectionKey = '${param.searchParkSectionKey}';
    var parentBlockKey = '${param.searchParkBlockKey}';
    var parentDivisionKey = '${param.searchParkDivisionKey}';
    
	    $(document.body).ready(function(){
	
	        //주차구역 검색 체인콤보구현
	        $("#searchManageZone").change(function(){
	
	            var searchManageZone = $(this).val();
	
	            if(searchManageZone == ''){
	                $("#searchParkSectionKey").bindSelectSetValue("");
	                $("#searchParkBlockKey").bindSelectSetValue("");
	                $("#searchParkDivisionKey").bindSelectSetValue("");
	            }else{
	            	
	            	var selectParkSectionKey = '';
	            	var selectParkBlockKey = '';
	            	var selectParkDivisionKey = '';
	            	
	            	if(parentOpenType == 'RR' || parentOpenType == 'RRB'){
	            		selectParkSectionKey = parentSectionKey;
		            	selectParkBlockKey = parentBlockKey;
		            	selectParkDivisionKey = parentDivisionKey;
	            	}
	            	
	                $("#searchParkSectionKey").bindSelect({
	                	
	                    ajaxUrl: "/com/searchResSectionCombo.json", ajaxPars: "searchManageZone="+searchManageZone, ajaxAsync:false,
	                    isspace: true, isspaceTitle: "전체",
	                    setValue: selectParkSectionKey,
	                    alwaysOnChange: true,
	                    onChange: function(){
	                    	
	                    	var searchParkSectionKey = $("#searchParkSectionKey").val();
	                    	
	                    	$("#searchParkBlockKey").bindSelect({
	                    	    
	                            ajaxUrl: "/com/searchResBlockCombo.json", ajaxPars: "searchParkSectionKey="+searchParkSectionKey, ajaxAsync:false,
	                            isspace: true, isspaceTitle: "전체",
	                            //setValue: this.optionValue,
	                            setValue: selectParkBlockKey,
	                            alwaysOnChange: true,
	                            onChange: function(){
	                                
	                            	var searchParkBlockKey = $("#searchParkBlockKey").val();
	                                
	                                $("#searchParkDivisionKey").bindSelect({
	                                    
	                                    ajaxUrl: "/com/searchResDivisionCombo.json", ajaxPars: "searchParkBlockKey="+searchParkBlockKey, ajaxAsync:false,
	                                    isspace: true, isspaceTitle: "전체",
	                                    //setValue: this.optionValue,
	                                    setValue: selectParkDivisionKey,
	                                    alwaysOnChange: true,
	                                    onChange: function(){
	                                        
	                                    }
	                                });
	                            }
	                        });
	                    }
	                });
	            }
	        });
	    });
    
  		//콤보박스 완성후 카운트변수
	    comboCallbackCnt = 0;
	    
	    //콤보박스 콜백스크립트
	    function comboCallback(){
	        
	        //콤보박스 완성되면서 + 1
	        comboCallbackCnt = comboCallbackCnt + 1;
	        
	        //콤보박스 완성되면서 아래 스크립트 실행
	        objectDataSet();
	    }
	    
	    //콤보박스 완성후 카운트변수 체크해서 마지막으로 데이터 셋팅(콤보가 완성된이후에 bindSelectSetValue를 할 수있음)
	    function objectDataSet(){
	        
	        //현재팝업에 콤보2개만체크
	        if(comboCallbackCnt == '2'){
	            
	        	if(parentOpenType == 'RC'){ //거주자우선주차-주차장현황
	        		//주차장유형선택
	        		$("#searchSectionType").bindSelectSetValue('01');
	        		//동선택
	        		$("#searchManageZone").bindSelectSetValue(parentManageZone);
	        		
	        		searchParkMap();
	        	}
	        	
	        	if(parentOpenType == 'RR'){
	        		//주차장유형선택
	        		$("#searchSectionType").bindSelectSetValue('01');
	        		//동선택
	        		$("#searchManageZone").bindSelectSetValue(parentManageZone);
	        		
	        		setTimeout("searchParkMap()", 1000);
	        	}
	        	
	        	if(parentOpenType == 'RRB'){ //거주자우선주차-이용신청
	        		//주차장유형선택
	        		$("#searchSectionType").bindSelectSetValue('01');
	        		//동선택
	        		$("#searchManageZone").bindSelectSetValue(parentManageZone);
	        		
	        		setTimeout("searchParkMap()", 1000);
	        	}
	        }
	    }
	    
	    //주차장검색
        function searchParkMap(){
	    	
	    	if($("#searchSectionType").val() != '02'){
	    		
	    		if($("#searchManageZone").val() == ''){
	    			alert('거주자주차구역(전체포함)을 검색시 [동선택]을 해주세요.');
	    			$("#searchSectionType").focus();
	    			return;
	    		}
	    	}
	    	
	    	//기존 맵겉어내고
        	$('#map').empty();
	    	
	    	var centerLat = '';
	    	var centerLon = '';
	    	
	    	if($("#searchSectionType").val() == '02' && $("#searchManageZone").val() == ''){
	    		//공영주차장을 전체동으로 검색했을때에는 동작구중심좌표를 지도중심좌표로 넣어준다.
	    		//동작구 행정구역상 상도로39가길7 이 중심..
	    		centerLat = '37.502434';
	    		centerLon = '126.949585';
	    	}else{
	    		if($("#searchManageZone").val() == '01'){ //노량진1동
	    			centerLat = '37.512470';
		    		centerLon = '126.949181';
	    		}else if($("#searchManageZone").val() == '02'){ //노량진2동
	    			centerLat = '37.511227';
		    		centerLon = '126.937775';
	    		}else if($("#searchManageZone").val() == '03'){ //대방동
	    			centerLat = '37.507320';
		    		centerLon = '126.928024';
	    		}else if($("#searchManageZone").val() == '04'){ //동작동
	    			centerLat = '37.500431';
		    		centerLon = '126.973961';
	    		}else if($("#searchManageZone").val() == '05'){ //사당1동
	    			centerLat = '37.480526';
		    		centerLon = '126.978630';
	    		}else if($("#searchManageZone").val() == '06'){ //사당2동
	    			centerLat = '37.498024';
		    		centerLon = '126.977158';
	    		}else if($("#searchManageZone").val() == '07'){ //사당3동
	    			centerLat = '37.489159';
		    		centerLon = '126.970711';
	    		}else if($("#searchManageZone").val() == '08'){ //사당4동
	    			centerLat = '37.480942';
		    		centerLon = '126.971268';
	    		}else if($("#searchManageZone").val() == '09'){ //사당5동
	    			centerLat = '37.486324';
		    		centerLon = '126.965416';
	    		}else if($("#searchManageZone").val() == '10'){ //상도1동
	    			centerLat = '37.503120';
		    		centerLon = '126.950851';
	    		}else if($("#searchManageZone").val() == '11'){ //상도2동
	    			centerLat = '37.504017';
		    		centerLon = '126.942024';
	    		}else if($("#searchManageZone").val() == '12'){ //상도3동
	    			centerLat = '37.498211';
		    		centerLon = '126.932457';
	    		}else if($("#searchManageZone").val() == '13'){ //상도4동
	    			centerLat = '37.497402';
		    		centerLon = '126.941010';
	    		}else if($("#searchManageZone").val() == '14'){ //상도5동
	    			centerLat = '37.502766';
		    		centerLon = '126.950485';
	    		}else if($("#searchManageZone").val() == '15'){ //신대방1동
	    			centerLat = '37.490669';
		    		centerLon = '126.910881';
	    		}else if($("#searchManageZone").val() == '16'){ //신대방2동
	    			centerLat = '37.494358';
		    		centerLon = '126.921883';
	    		}else if($("#searchManageZone").val() == '17'){ //흑석1동
	    			centerLat = '37.505844';
		    		centerLon = '126.962646';
	    		}else if($("#searchManageZone").val() == '18'){ //흑석2동
	    			centerLat = '37.505844';
		    		centerLon = '126.962646';
	    		}else if($("#searchManageZone").val() == '19'){ //흑석3동
	    			centerLat = '37.505844';
		    		centerLon = '126.962646';
	    		}else if($("#searchManageZone").val() == '20'){ //본동
	    			centerLat = '37.512630';
		    		centerLon = '126.953613';
	    		}else{ //이도저도아닐땐 동작구 중심
	    			centerLat = '37.502434';
		    		centerLon = '126.949585';
	    		}
	    	}
        	
            $.ajax({
                url : "/com/searchParkMap.json",
                type: "POST", 
                data: $('#frm').serialize(),
                dataType:"json", 
                success : function(data, textStatus, jqXHR) {
                	
                	var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
        	        mapOption = { 
        	            center: new daum.maps.LatLng(centerLat, centerLon), // 지도의 중심좌표
        	            level: 6 // 지도의 확대 레벨
        	        };

        		    var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
        		    
        		 	// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
        			var mapTypeControl = new daum.maps.MapTypeControl();
        		    
        		    // 지도에 컨트롤을 추가해야 지도위에 표시됩니다
        			// daum.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
        			map.addControl(mapTypeControl, daum.maps.ControlPosition.TOPRIGHT);
        		    
        			// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
        			var zoomControl = new daum.maps.ZoomControl();
        			map.addControl(zoomControl, daum.maps.ControlPosition.RIGHT);
        		    
        		    // 마커를 표시할 위치와 내용을 가지고 있는 객체 배열입니다 
        		    var positions = new Array();
				    
				    for (var j = 0; j < data.list.length; j ++) {
				    	
				    	var sectionInfo = new Object();
				    	
				    	if(data.list[j].sectionType == '01'){
				    		if(data.list[j].divisionLat != null){
				    			sectionInfo.parkSectionName = data.list[j].parkSectionName; //구간명
				    			sectionInfo.sectionType = data.list[j].sectionType; //구간종류
				    			sectionInfo.sectionTypeName = data.list[j].sectionTypeName; //구간종류명
				    			sectionInfo.manageZoneName = data.list[j].manageZoneName; //관리지구
				    			sectionInfo.sectionClassifyName = data.list[j].sectionClassifyName; //구간구분
				    			sectionInfo.sectionTraitName = data.list[j].sectionTraitName; //구간특성
				    			sectionInfo.assignUnitName = data.list[j].assignUnitName; //구간속성
				    			sectionInfo.visitParkYn = data.list[j].visitParkYn; //방문주차여부
				    			sectionInfo.visitParkChargeComma = data.list[j].visitParkChargeComma; //방문주차요금
				    			
				    			if(data.list[j].timeParkYn == 'Y'){
				    				sectionInfo.timeParkYn = data.list[j].timeParkYn; //시간주차여부
					    			sectionInfo.timeParkInterval = data.list[j].timeParkInterval; //시간주차간격
					    			sectionInfo.timeParkChargeComma = data.list[j].timeParkChargeComma; //분단위이용요금
				    			}else{
				    				sectionInfo.timeParkYn = 'N'; //시간주차여부
					    			sectionInfo.timeParkInterval = ''; //시간주차간격
					    			sectionInfo.timeParkChargeComma = ''; //분단위이용요금
				    			}
				    			
				    			sectionInfo.allDayChargeComma = data.list[j].allDayChargeComma; //전일이용요금
				    			sectionInfo.dayTimeChargeComma = data.list[j].dayTimeChargeComma; //주간이용요금
				    			sectionInfo.nightTimeChargeComma = data.list[j].nightTimeChargeComma; //야간이용요금
				    			sectionInfo.parkBlockName = data.list[j].parkBlockName;
				    			sectionInfo.divisionName = data.list[j].divisionName;
				    			sectionInfo.latlng = new daum.maps.LatLng(data.list[j].divisionLat, data.list[j].divisionLon);
				    		}
				    	}else if(data.list[j].sectionType == '02'){
				    		if(data.list[j].sectionLat != null){
				    			sectionInfo.parkSectionName = data.list[j].parkSectionName; //구간명
				    			sectionInfo.sectionType = data.list[j].sectionType; //구간종류
				    			sectionInfo.sectionTypeName = data.list[j].sectionTypeName; //구간종류명
				    			sectionInfo.manageZoneName = data.list[j].manageZoneName; //관리지구
				    			sectionInfo.sectionClassifyName = data.list[j].sectionClassifyName; //구간구분
				    			sectionInfo.sectionTraitName = data.list[j].sectionTraitName; //구간특성
				    			sectionInfo.assignUnitName = data.list[j].assignUnitName; //구간속성
				    			sectionInfo.totalDivision = data.list[j].totalDivision; //총구획
				    			sectionInfo.compactDivision = data.list[j].compactDivision; //경차전용구획
				    			sectionInfo.femaleDivision = data.list[j].femaleDivision; //여성전용구획
				    			sectionInfo.handicapDivision = data.list[j].handicapDivision; //장애인전용구획
				    			sectionInfo.allDayChargeComma = data.list[j].allDayChargeComma; //전일이용요금
				    			sectionInfo.dayTimeChargeComma = data.list[j].dayTimeChargeComma; //주간이용요금
				    			sectionInfo.nightTimeChargeComma = data.list[j].nightTimeChargeComma; //야간이용요금
				    			sectionInfo.operationStartTimeStr = data.list[j].operationStartTimeStr; //운영시작시간
				    			sectionInfo.operationEndTimeStr = data.list[j].operationEndTimeStr; //운영종료시간
				    			sectionInfo.latlng = new daum.maps.LatLng(data.list[j].sectionLat, data.list[j].sectionLon);
				    		}
				    	}
				    	positions.push(sectionInfo);
        		    }
				    
					overlay_arr = new Array();
					var marker_arr = new Array();
					
					for (var i = 0; i < positions.length; i ++) {
						(function(i){
							
							// 마커를 생성합니다
							// 마커이미지 설정
							var imageSrcSectionType = '';
							if(positions[i].sectionType == '01'){ //거주자
								imageSrcSectionType = '${pageContext.request.contextPath}/resource/images/marker_res.png'; // 마커이미지의 주소입니다    
							}else if(positions[i].sectionType == '02'){ //공영
								imageSrcSectionType = '${pageContext.request.contextPath}/resource/images/marker_pub.png'; // 마커이미지의 주소입니다    
							}
							
							var imageSrc = imageSrcSectionType,
						    imageSize = new daum.maps.Size(30, 30), // 마커이미지의 크기입니다
						    imageOprion = {offset: new daum.maps.Point(15, 30)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
		
							// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
							var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize, imageOprion);
							
							// 마커를 생성합니다
	        		        var marker = new daum.maps.Marker({
	        		            map: map, // 마커를 표시할 지도
	        		            position: positions[i].latlng, // 마커의 위치
	        		            image: markerImage,
	        		            clickable: true
	        		        });
							
	        		     	// 지도에 마커를 표시합니다 
							marker_arr.push(marker);
	        		     	
	        		     	//거주자와 공영의 오버레이DIV분기
	        		     	if(positions[i].sectionType == '01'){ //거주자
	        		     		
	        		     		var content = '<div class="detail res">' + 
		        	            '    <div class="title">' + 
		        	            '        <p><span>거주자 : </span>'+positions[i].manageZoneName+'>'+positions[i].parkSectionName+'>'+positions[i].parkBlockName+'>'+positions[i].divisionName+'</p>' +
		        	            '        <a class="btn" onclick="closeOverlay('+i+')"><i class="axi axi-clear"></i></a>' +
		        	            '    </div>' + 
		        	            '    <div class="body">' + 
		        	            '        <table class="table">' + 
		        	            '            <caption>거주자 주차구획 정보</caption>' + 
		        	            '            <thead>' +
		        	            '            <tr>' +
		        	            '                <th>구획명</th>' +
		        	            '                <th>전일이용요금</th>' +
		        	            '                <th>주간이용요금</th>' +
		        	            '                <th>야간이용요금</th>' +
		        	            '            </tr>' +
		        	            '            </thead>' +
		        	            '            <tbody>' +
		        	            '            <tr>' +
		        	            '                <td>'+positions[i].divisionName+'</td>' +
		        	            '                <td>'+positions[i].allDayChargeComma+'</td>' +
		        	            '                <td>'+positions[i].dayTimeChargeComma+'</td>' +
		        	            '                <td>'+positions[i].nightTimeChargeComma+'</td>' +
		        	            '            </tr>' +
		        	            '            </tbody>' +
		        	            '            <thead>' +
		        	            '            <tr>' +
		        	            '                <th>시간주차여부</th>' +
		        	            '                <th>분단위</th>' +
		        	            '                <th>단위요금</th>' +
		        	            '                <th></th>' +
		        	            '            </tr>' +
		        	            '            </thead>' +
		        	            '            <tbody>' +
		        	            '            <tr>' +
		        	            '                <td>'+positions[i].timeParkYn+'</td>' +
		        	            '                <td>'+positions[i].timeParkInterval+'</td>' +
		        	            '                <td>'+positions[i].timeParkChargeComma+'</td>' +
		        	            '                <td></td>' +
		        	            '            </tr>' +
		        	            '            </tbody>' +
		        	            '            <thead>' +
		        	            '            <tr>' +
		        	            '                <th>구간구분</th>' +
		        	            '                <th>구간특성</th>' +
		        	            '                <th>구간속성</th>' +
		        	            '                <th></th>' +
		        	            '            </tr>' +
		        	            '            </thead>' +
		        	            '            <tbody>' +
		        	            '            <tr>' +
		        	            '                <td>'+positions[i].sectionClassifyName+'</td>' +
		        	            '                <td>'+positions[i].sectionTraitName+'</td>' +
		        	            '                <td>'+positions[i].assignUnitName+'</td>' +
		        	            '                <td></td>' +
		        	            '            </tr>' +
		        	            '            </tbody>' +
		        	            '        </table>' +
		        	            '     </div>' +
		        	            ' </div>';
	        		     		
	        		     	}else if(positions[i].sectionType == '02'){ //공영
	        		     		
	        		     		var content = '<div class="detail pub">' +
		        	            '    <div class="title">' +
		        	            '        <p><span>공영 : </span>'+positions[i].manageZoneName+'>'+positions[i].parkSectionName+'</p>' +
		        	            '        <a class="btn" onclick="closeOverlay('+i+')"><i class="axi axi-clear"></i></a>' +
		        	            '    </div>' + 
		        	            '    <div class="body">' + 
		        	            '        <table class="table">' + 
		        	            '            <caption>공영주차장 정보</caption>' + 
		        	            '            <thead>' +
		        	            '            <tr>' +
		        	            '                <th>주차장명</th>' +
		        	            '                <th>월정기요금(전일)</th>' +
		        	            '                <th>월정기요금(주간)</th>' +
		        	            '                <th>월정기요금(야간)</th>' +
		        	            '            </tr>' +
		        	            '            </thead>' +
		        	            '            <tbody>' +
		        	            '            <tr>' +
		        	            '                <td>'+positions[i].parkSectionName+'</td>' +
		        	            '                <td>'+positions[i].allDayChargeComma+'</td>' +
		        	            '                <td>'+positions[i].dayTimeChargeComma+'</td>' +
		        	            '                <td>'+positions[i].nightTimeChargeComma+'</td>' +
		        	            '            </tr>' +
		        	            '            </tbody>' +
		        	            '            <thead>' +
		        	            '            <tr>' +
		        	            '                <th>총구획</th>' +
		        	            '                <th>경차구획</th>' +
		        	            '                <th>장애인</th>' +
		        	            '                <th>여성구획</th>' +
		        	            '            </tr>' +
		        	            '            </thead>' +
		        	            '            <tbody>' +
		        	            '            <tr>' +
		        	            '                <td>'+positions[i].totalDivision+'</td>' +
		        	            '                <td>'+positions[i].compactDivision+'</td>' +
		        	            '                <td>'+positions[i].handicapDivision+'</td>' +
		        	            '                <td>'+positions[i].femaleDivision+'</td>' +
		        	            '            </tr>' +
		        	            '            </tbody>' +
		        	            '            <thead>' +
		        	            '            <tr>' +
		        	            '                <th>운영시작시간</th>' +
		        	            '                <th>운영종료시간</th>' +
		        	            '                <th></th>' +
		        	            '                <th></th>' +
		        	            '            </tr>' +
		        	            '            </thead>' +
		        	            '            <tbody>' +
		        	            '            <tr>' +
		        	            '                <td>'+positions[i].operationStartTimeStr+'</td>' +
		        	            '                <td>'+positions[i].operationEndTimeStr+'</td>' +
		        	            '                <td></td>' +
		        	            '                <td></td>' +
		        	            '            </tr>' +
		        	            '            </tbody>' +
		        	            '            <thead>' +
		        	            '            <tr>' +
		        	            '                <th>구간구분</th>' +
		        	            '                <th>구간특성</th>' +
		        	            '                <th></th>' +
		        	            '                <th></th>' +
		        	            '            </tr>' +
		        	            '            </thead>' +
		        	            '            <tbody>' +
		        	            '            <tr>' +
		        	            '                <td>'+positions[i].sectionClassifyName+'</td>' +
		        	            '                <td>'+positions[i].sectionTraitName+'</td>' +
		        	            '                <td></td>' +
		        	            '                <td></td>' +
		        	            '            </tr>' +
		        	            '            </tbody>' +
		        	            '        </table>' +
		        	            '     </div>' +
		        	            ' </div>';
	        		     	}
	        		     			
	        	            // 마커 위에 커스텀오버레이를 표시합니다
							// 마커를 중심으로 커스텀 오버레이를 표시하기위해 CSS를 이용해 위치를 설정했습니다
							overlay = new daum.maps.CustomOverlay({
							    content: content,
							    map: map,
							    position: marker.getPosition()
							});
	        	            
							overlay_arr.push(overlay);
							
							// 마커를 클릭했을 때 커스텀 오버레이를 표시합니다
							daum.maps.event.addListener(marker_arr[i], 'click', function() {
								
								for (var k = 0; k < positions.length; k ++) {
									overlay_arr[k].setMap(null);
			        		    }
								
								overlay_arr[i].setMap(map);
							});
							
							overlay_arr[i].setMap(null);
						})(i);
					}
					
                },
                error : function(jqXHR, textStatus, errorThrown){
                    axf.alert("code:"+jqXHR.status+"\nmessage:"+textStatus+"\nerror:"+errorThrown);
                }
            });
        }
	    
        // 커스텀 오버레이를 닫기 위해 호출되는 함수입니다 
        function closeOverlay(number) {
			overlay_arr[number].setMap(null);
		};
        
    </script>
</head>
<body>
    <div class="parking_map">
        <div class="map_header">
            <div class="title">
                <h1>동작구시설관리공단 <span>주차시설 위치검색</span></h1>
            </div>
        </div>
        <div class="map_body">
        
        	<form id="frm" name="frm">
            <div class="search_box">
                <div class="sc_item">
                    <label>주차장 유형선택</label>
                    <select id="searchSectionType" name="searchSectionType" style="width: 160px;" isspace="true" isspaceTitle="전체" class="AXSelect" url="${pageContext.request.contextPath}/mis/tax/codeMaster.json" callback="comboCallback" param="codeId=DFM025"></select>
                </div>
                <div class="sc_item">
                    <label>동선택</label>
                    <select id="searchManageZone" name="searchManageZone" style="width: 160px;" isspace="true" isspaceTitle="전체" class="AXSelect" url="${pageContext.request.contextPath}/mis/tax/codeMaster.json" callback="comboCallback" param="codeId=DFM013"></select>
                </div>
                <div class="sc_item">
                    <label>구간선택</label>
                    <select id="searchParkSectionKey" name="searchParkSectionKey" style="width: 160px;" class="AXSelect" tabindex="2"></select>
                </div>
                <div class="sc_item">
                    <label>블럭선택</label>
                    <select id="searchParkBlockKey" name="searchParkBlockKey" style="width: 160px;" class="AXSelect" tabindex="3"></select>
                </div>
                <div class="sc_item">
                    <label>구획선택</label>
                    <select id="searchParkDivisionKey" name="searchParkDivisionKey" style="width: 160px;" class="AXSelect" tabindex="4"></select>
                </div>
                <div class="sc_item">
                    <a class="btn blue search" onclick="searchParkMap();">주차장검색</a>
                </div>
            </div>
			</form>
			
            <!-- Map Viewer -->
            <div class="viewer">
                <div id="map"></div>

				<!-- 검색 전 마스크 : 맵이 씌워지면 z-index 에 의해 덮힘 -->
				<div id="mapMask" class="map_mask">
					<img src="${pageContext.request.contextPath}/resource/images/map_mask.png" alt="주차시설 위치검색을 위해 각 항목을 선택하신 후 '주차장검색'버튼을 눌러주십시오." />
				</div>
            </div>
        </div>
    </div>
</body>
</html>