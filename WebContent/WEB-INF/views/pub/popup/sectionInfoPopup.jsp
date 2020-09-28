<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<html>
<head>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/axisj/lib/AXGrid.js"></script>

    <style>
	    .screen_out {display:block;overflow:hidden;position:absolute;left:-9999px;width:1px;height:1px;font-size:0;line-height:0;text-indent:-9999px}
	    .wrap_content {overflow:hidden;height:300px}
	    .wrap_map {width:50%;height:300px;float:left;position:relative}
	    .wrap_roadview {width:50%;height:300px;float:left;position:relative}
	    .wrap_button {position:absolute;left:15px;top:12px;z-index:2}
	    .btn_comm {float:left;display:block;width:70px;height:27px;background:url(http://i1.daumcdn.net/localimg/localimages/07/mapapidoc/sample_button_control.png) no-repeat}
	    .btn_linkMap {background-position:0 0;}
	    .btn_resetMap {background-position:-69px 0;}
	    .btn_linkRoadview {background-position:0 0;}
	    .btn_resetRoadview {background-position:-69px 0;}
	</style>
    
    <!-- Daum지도 API키 Import-->
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=<spring:eval expression="@appConfig['daum.api.key']"/>"></script>
    
    <script id="jscode">
        
        //부모창에서 선택한 구간정보 Object
        var parentObject = parent.selectSectionObj;
        
        $(document.body).ready(function(){
        	
        	//맵,로드뷰 초기화버튼 모두 감춤
            resetMapBtn('AH');
            
            $('#parkSectionName').text(parentObject.parkSectionName);
            
            if(parentObject.allDayCharge == '0'){
            	$("#allDayCharge").text("신청불가");
            }else{
            	$("#allDayCharge").text(parentObject.allDayChargeComma);
            }
            
            if(parentObject.dayTimeCharge == '0'){
                $("#dayTimeCharge").text("신청불가");
            }else{
                $("#dayTimeCharge").text(parentObject.dayTimeChargeComma);
            }
            
            if(parentObject.nightTimeCharge == '0'){
                $("#nightTimeCharge").text("신청불가");
            }else{
            	$("#nightTimeCharge").text(parentObject.nightTimeChargeComma);
            }
            
            if(parentObject.timeParkYn == 'Y'){
            	$('#timeParkYn').text("가능");
            }else{
            	$('#timeParkYn').text("불가능");
            }
            
            $("#timeParkInterval").text(parentObject.timeParkInterval);
            
            $("#timeParkCharge").text(parentObject.timeParkCharge);
            
            if(parentObject.operationStartTime != ''){
                var operationStartTime = parentObject.operationStartTime;
                var operationStartTimeH = operationStartTime.substring(0,2);
                var operationStartTimeM = operationStartTime.substring(2,4);
                
                $("#operationStartTime").text(operationStartTimeH+':'+operationStartTimeM);
            }
            
            if(parentObject.operationEndTime != ''){
                var operationEndTime = parentObject.operationEndTime;
                var operationEndTimeH = operationEndTime.substring(0,2);
                var operationEndTimeM = operationEndTime.substring(2,4);
                
                $("#operationEndTime").text(operationEndTimeH+':'+operationEndTimeM);
            }
            
            $('#totalDivision').text(parentObject.totalDivision);
            
            if(parentObject.compactDivision == ''){
                $('#compactDivision').text('0');
            }else{
                $('#compactDivision').text(parentObject.compactDivision);
            }
            
            if(parentObject.handicapDivision == ''){
                $('#handicapDivision').text('0');
            }else{
                $('#handicapDivision').text(parentObject.handicapDivision);
            }
            
            if(parentObject.femaleDivision == ''){
                $('#femaleDivision').text('0');
            }else{
                $('#femaleDivision').text(parentObject.femaleDivision);
            }
            
            if((parentObject.sectionLat == '' || parentObject.sectionLat == null) || (parentObject.sectionLon == '' || parentObject.sectionLon == null)){
                //manageZoneComboChange(parentObject.manageZoneName);
            }else{
                //initMap(parentObject.sectionLat, parentObject.sectionLon);
                mapSetting();
            }
            
        });
        
        //아래는 다음지도 스크립트 시작
        var markers = []; //지도에 표시된 마커 객체를 가지고 있을 배열입니다
        var map; //지도객체
        var roadview; //로드뷰객체
        var rvResetValue = {} //로드뷰의 초기화 값을 저장할 변수

        function mapSetting(){
            
            //지도+로드뷰 영역 html set
            //$('.wrap_content').empty();
            //$('.wrap_content').html(wrapContentHtml);
            
            //맵,로드뷰 초기화버튼 모두 감춤
            resetMapBtn('AH');
            
            var sectionLon = parentObject.sectionLon;
            var sectionLat = parentObject.sectionLat;
            var mapPanoId = parentObject.mapPanoId;
            var mapPan = parentObject.mapPan;
            var mapTilt = parentObject.mapTilt;
            var mapZoom = parentObject.mapZoom;
            
            //좌표값없으면 수정하라고 안내(빼도됨)
            if((sectionLon == '' || sectionLon == null) || (sectionLat == '' || sectionLat == null)){
                //alert('설정되어있는 좌표,지도값이 없습니다. 구간수정에서 지도영역을 수정해주세요.');
                return;
            }
            
            // 기존 마커 삭제
            for (var i = 0; i < markers.length; i++) {
                markers[i].setMap();
            } 
            
            // 지도를 표시할 div
            var mapContainer = document.getElementById('map');
            
            // 지도와 로드뷰 위에 마커로 표시할 특정 장소의 좌표입니다 
            var placePosition = new daum.maps.LatLng(sectionLat, sectionLon);
            mapOption = {
                center: placePosition, // 지도의 중심 좌표
                level: 1 // 지도의 확대 레벨
            };
            
            // 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
            map = new daum.maps.Map(mapContainer, mapOption);
            
            // 지도에 올릴 마커를 생성합니다.
            var mMarker = new daum.maps.Marker({
                position: placePosition, // 지도의 중심좌표에 올립니다.
                map: map // 생성하면서 지도에 올립니다.
            });
            
            //마커의 초기화를 위해 마커담아두기
            markers.push(mMarker);
            
            //맵 초기화버튼 보임
            resetMapBtn('MS');
            
            /*
            // 지도에 올릴 장소명 인포윈도우 입니다.
            var mLabel = new daum.maps.InfoWindow({
                position: mapCenter, // 지도의 중심좌표에 올립니다.
                content: '스페이스 닷원' // 인포윈도우 내부에 들어갈 컨텐츠 입니다.
            });
            mLabel.open(map, mMarker); // 지도에 올리면서, 두번째 인자로 들어간 마커 위에 올라가도록 설정합니다.
            */
            
            //로드뷰 파노라마ID가 없으면 로드뷰세팅값이 없는것으로 판단
            if(mapPanoId == '' || mapPanoId == null){
                
                //로드뷰 영역 html set
                $('.wrap_roadview').empty();
                $('.wrap_roadview').html(wrapRoadviewHtml);
                
                //로드뷰 초기화버튼 감춤
                resetMapBtn('RH');
            }else{
                
                var rvContainer = document.getElementById('roadview'); // 로드뷰를 표시할 div
                roadview = new daum.maps.Roadview(rvContainer); // 로드뷰 객체 생성
                
                // 로드뷰의 위치를 특정 장소를 포함하는 파노라마 ID로 설정합니다
                roadview.setPanoId(mapPanoId, placePosition);
                rvResetValue.panoId = mapPanoId;
                
                // 로드뷰 초기화 이벤트
                daum.maps.event.addListener(roadview, 'init', function() {
                    
                    /*
                    // 로드뷰에 올릴 마커를 생성합니다.
                    var rMarker = new daum.maps.Marker({
                        position: mapCenter,
                        map: rv //map 대신 rv(로드뷰 객체)로 설정하면 로드뷰에 올라갑니다.
                    });
                    */
                    // 로드뷰에 특정 장소를 표시할 마커를 생성하고 로드뷰 위에 표시합니다 
                    var rvMarker = new daum.maps.Marker({
                        position: placePosition,
                        map: roadview
                    });
                    
                    markers.push(rvMarker);
                    
                    /*
                    // 로드뷰에 올릴 장소명 인포윈도우를 생성합니다.
                    var rLabel = new daum.maps.InfoWindow({
                        position: mapCenter,
                        content: '스페이스 닷원'
                    });
                    rLabel.open(rv, rMarker);
                    */

                    // 로드뷰 마커가 중앙에 오도록 로드뷰의 viewpoint 조정 합니다.
                    var projection = roadview.getProjection(); // viewpoint(화면좌표)값을 추출할 수 있는 projection 객체를 가져옵니다.
                    
                    if(mapPan == '' || mapPan == null){
                        //디폴트
                        roadview.setViewpoint({
                            pan: 321,
                            tilt: 0,
                            zoom: 0
                        });
                        
                        //각 뷰포인트 값을 초기화를 위해 저장해 놓습니다.
                        rvResetValue.pan = 321;
                        rvResetValue.tilt = 0;
                        rvResetValue.zoom = 0;
                        
                    }else{
                        
                        roadview.setViewpoint({
                            pan: mapPan,
                            tilt: mapTilt,
                            zoom: mapZoom
                        });
                        
                        //각 뷰포인트 값을 초기화를 위해 저장해 놓습니다.
                        rvResetValue.pan = mapPan;
                        rvResetValue.tilt = mapTilt;
                        rvResetValue.zoom = mapZoom;
                    }
                });
                
                //로드뷰 초기화버튼 보임
                resetMapBtn('RS');
            }
        }
        
        //지도 이동 이벤트 핸들러(사용안함)
        function moveDaumMap(self){
            
            var center = map.getCenter(), 
                lat = center.getLat(),
                lng = center.getLng();
            
            self.href = 'http://map.daum.net/link/map/' + encodeURIComponent('스페이스 닷원') + ',' + lat + ',' + lng; //Daum 지도로 보내는 링크
        }

        //지도 초기화 이벤트 핸들러
        function resetDaumMap(){
            
            var sectionLon = parentObject.sectionLon;
            var sectionLat = parentObject.sectionLat;
            var placePosition = new daum.maps.LatLng(sectionLat, sectionLon);
            
            map.setCenter(placePosition); //지도를 초기화 했던 값으로 다시 셋팅합니다.
            map.setLevel(mapOption.level);
        }

        //로드뷰 이동 이벤트 핸들러(사용안함)
        function moveDaumRoadview(self){
            var panoId = roadview.getPanoId(); //현 로드뷰의 panoId값을 가져옵니다.
            var viewpoint = roadview.getViewpoint(); //현 로드뷰의 viewpoint(pan,tilt,zoom)값을 가져옵니다.
            self.href = 'http://map.daum.net/?panoid='+panoId+'&pan='+viewpoint.pan+'&tilt='+viewpoint.tilt+'&zoom='+viewpoint.zoom; //Daum 지도 로드뷰로 보내는 링크
        }

        //로드뷰 초기화 이벤트 핸들러
        function resetRoadview(){
            
            //초기화를 위해 저장해둔 변수를 통해 로드뷰를 초기상태로 돌립니다.
            roadview.setViewpoint({
                pan: rvResetValue.pan, tilt: rvResetValue.tilt, zoom: rvResetValue.zoom
            });
            roadview.setPanoId(rvResetValue.panoId);
        }
        
        //맵초기화버튼 show/hide
        function resetMapBtn(val){
            /*
            AS : 맵,로드뷰 초기화버튼 모두 보임
            AH : 맵,로드뷰 초기화버튼 모두 감춤
            MS : 맵 초기화버튼 보임
            MH : 맵 초기화버튼 감춤
            RS : 로드뷰 초기화버튼 보임
            RH : 로드뷰 초기화버튼 감춤
            */
            if(val == 'AS'){
                $("#resetDaumMapBtn").show();
                $("#resetRoadviewBtn").show();
            }else if(val == 'AH'){
                $("#resetDaumMapBtn").hide();
                $("#resetRoadviewBtn").hide();
            }else if(val == 'MS'){
                $("#resetDaumMapBtn").show();
            }else if(val == 'MH'){
                $("#resetDaumMapBtn").hide();
            }else if(val == 'RS'){
                $("#resetRoadviewBtn").show();
            }else if(val == 'RH'){
                $("#resetRoadviewBtn").hide();
            }
        }
        
    </script>
    
    <title>주차장 상세보기</title>
</head>

<body id="popUp">
<div class="pop_up"><!-- 팝업용 전체 컨테이너 클래스 -->
    <div class="div_table">
        <div class="section_map">
            <!-- class="wrap_content" 이거만질때 조심해주세요..지도안뜰수도있어요 -->
            <div class="wrap_content">
                <div class="wrap_map">
                    <div id="map" style="width:100%;height:100%"></div> <!-- 지도를 표시할 div 입니다 -->
                    <div class="wrap_button">
                        <!-- <a href="javascript:;" class="btn_comm btn_linkMap" target="_blank" onclick="moveDaumMap(this)"><span class="screen_out">지도 크게보기</span></a> --> <!-- 지도 크게보기 버튼입니다 -->
                        <a href="javascript:;" id="resetDaumMapBtn" class="btn_comm btn_resetMap" onclick="resetDaumMap()"><span class="screen_out">지도 초기화</span></a> <!-- 지도 크게보기 버튼입니다 -->
                    </div>
                </div>
                <div class="wrap_roadview">
                    <div id="roadview" style="width:100%;height:100%"></div> <!-- 로드뷰를 표시할 div 입니다 -->
                    <div class="wrap_button">
                        <!-- <a href="javascript:;" class="btn_comm btn_linkRoadview" target="_blank" onclick="moveDaumRoadview(this)"><span class="screen_out">로드뷰 크게보기</span></a> --> <!-- 로드뷰 크게보기 버튼입니다 -->
                        <a href="javascript:;" id="resetRoadviewBtn" class="btn_comm btn_resetRoadview" onclick="resetRoadview()"><span class="screen_out">로드뷰 초기화</span></a> <!-- 로드뷰 리셋 버튼입니다 -->
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="table_box">
        <table class="table">
            <caption>선택한 주차장 정보</caption>
            <thead>
            <tr>
                <th>주차장명</th>
                <th>월정기요금(전일)</th>
                <th>월정기요금(주간)</th>
                <th>월정기요금(야간)</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td id="parkSectionName"></td>
                <td id="allDayCharge"></td>
                <td id="dayTimeCharge"></td>
                <td id="nightTimeCharge"></td>
            </tr>
            </tbody>
            <thead>
            <tr>
                <th>시간주차여부</th>
                <th>분단위</th>
                <th>단위요금</th>
                <th></th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td id="timeParkYn"></td>
                <td id="timeParkInterval"></td>
                <td id="timeParkCharge"></td>
                <td id=""></td>
            </tr>
            </tbody>
            <thead>
            <tr>
                <th>운영시작시간</th>
                <th>운영종료시간</th>
                <th></th>
                <th></th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td id="operationStartTime"></td>
                <td id="operationEndTime"></td>
                <td id=""></td>
                <td id=""></td>
            </tr>
            </tbody>
            <thead>
            <tr>
                <th>총구획</th>
                <th>경차구획</th>
                <th>장애인</th>
                <th>여성구획</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td id="totalDivision"></td>
                <td id="compactDivision"></td>
                <td id="handicapDivision"></td>
                <td id="femaleDivision"></td>
            </tr>
            </tbody>
            
        </table>
    </div>
    <div class="pop_foot">
        <a class="btn" onclick="closePopup();">닫기</a>
    </div>
</div>
</body>
</html>