<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java" import="Kisinfo.Check.IPINClient"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>


<%
	String gubn = request.getParameter("gubn")==null ? "R" : (String)request.getParameter("gubn");
	String curPage = request.getParameter("letter_id")==null ? "1" : (String)request.getParameter("curPage");
	String p_searchTxt = request.getParameter("p_searchTxt")==null ? "" : (String)request.getParameter("p_searchTxt");
%>
<head>
<meta http-equiv="refresh"
	content="<%=session.getMaxInactiveInterval()%>;url=/sessionError" />
<script type="text/javascript"
	src="<spring:eval expression="@appConfig['daum.addr.js.path']"/>"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resource/js/com/daumPostcode.js"></script>

<title>생명나눔편지함</title>

<script id="jscode">

   		var myValidator = new AXValidator();
   		var bgubn = "<%=gubn%>";
        
        $(document.body).ready(function(){
            $(document).on('click', '.email__lnb a', function () {
                $('a').removeClass("active");
                $(this).addClass("active");
            })
        	
            $(document).on('click', '.mobile-emenu-content .links a', function () {
                $('.links a').removeClass("active");
                $(this).addClass("active");
            })

        });
        
        //편지함별 총계 조회		
        //"R" : 받은 편지함
        //"N" : 안읽은 편지함
        //"S" : 보낸편지함
        //"T" : 임시보관함
        function searchLetterTot() {  
        		
            $.ajax({
                url: "/let/searchLetterListTot.json",
                type: "POST",
                data: {gubn:bgubn},
                dataType: "json",
                success: function (data, textStatus, jqXHR) {
                	$("#m_noReadTot").html(data.noReadTot); 
                	$("#noReadTot1").html(data.noReadTot);
                	
					if (bgubn == "R" || bgubn == "N"){
						var html = "<span style='color:#1fb1a8;' ><label>" + data.noReadTot + "</label></span> / <label>" + data.letBoxTot + "</label>";
					}else{
						var html = "<label>" + data.letBoxTot + "</label>";
					}
					
					$("#MainTot").html(html);
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    axf.alert("code:" + jqXHR.status + "\nmessage:" + textStatus + "\nerror:" + errorThrown);
                }
            });
        }
            
        //폄지함 조회
        //"R" : 받은 편지함
        //"N" : 안읽은 편지함
        //"S" : 보낸편지함
        //"T" : 임시보관함
        //"paageIdx" : 페이지번호
        function searchLetterReciList(curPage,searchTxt){
        	
        	$.ajax({
                url: "/let/searchLetterList.json",
                type: "POST",
                data: {gubn:bgubn
                	 , curPage:curPage
                	 , searchTxt:searchTxt},
                dataType: "json",
                success: function (data, textStatus, jqXHR) {
                	returnLetterBox(data);
                	returnPagination(data);
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    axf.alert("code:" + jqXHR.status + "\nmessage:" + textStatus + "\nerror:" + errorThrown);
                }
            });
            
        }
        
        //편지함 리스트 처리
        function returnLetterBox(data){
        	var htmlSum = "";
        	
            for (var i = 0; i < data.list.length; i++) {

                var html = "";
                html = html + ' <div class="row notread"> ';
                html = html + ' <div class="col col1"> ';
                html = html + '     <label for="ck1" class="checkbox"> ';
                html = html + '         <input type="checkbox" hidden id="ck1"> ';
                html = html + '         <span></span> ';
                html = html + '     </label> ';
                html = html + ' </div> ';
                html = html + ' <div class="col col2"> ';
                if (bgubn != "T"){
                	if (data.list[i].receiveYn == 'F'){
                    	html = html + '     <img src="${pageContext.request.contextPath}/resource/assets/images/not-readed.png" alt="" class="inline"> ';	
                    }else{
                    	html = html + '     <img src="${pageContext.request.contextPath}/resource/assets/images/readed.png" alt="" class="inline"> ';	
                    }	  
                }                 
                html = html + ' </div> ';
                html = html + ' <div class="col col3"> ';
                if (data.list[i].fileCnt != '0'){
                	html = html + '     <img src="${pageContext.request.contextPath}/resource/assets/images/have-item.png" alt="" class="inline"> ';	
                }
                html = html + ' </div> ';
                html = html + ' <div class="col col4 text-center">' + data.list[i].reseName + '</div> ';
                html = html + ' <div class="col col5"> ';
                if (bgubn == "T"){
                	html = html + '     <a href="javascript:gotoLetterWrite(' + data.list[i].letterId + ','+data.list[i].rnum +');">' + data.list[i].title + '</a> ';
                }else{
                	html = html + '     <a href="javascript:gotoLetterView(' + data.list[i].letterId + ','+data.list[i].rnum +');">' + data.list[i].title + '</a> ';
                }
                html = html + ' </div> ';
                html = html + ' <div class="col col6 text-center">' + ckEmpty(data.list[i].senderDate) + '</div> ';
            	html = html + ' </div> ';
                
                htmlSum = htmlSum + html;
            }

            $("#emaillist__body").html(htmlSum);
        }

        //페이징 처리
        function returnPagination(data){
        	if (data.page != null){
        		var html = "";
        		
        		if (data.page.curRange != '1'){
        			html = html + '<a href="javascript:fn_paging(1)" class="pagination__arrow prev-full"></a>&nbsp;&nbsp;&nbsp;';
        		}
        		if (data.page.curPage != '1'){
        			html = html + '<a href="javascript:fn_paging('+ data.page.prePage + ')" class="pagination__arrow prev"></a>&nbsp;&nbsp;&nbsp;';
        		}
        		
        		for (var i = data.page.startPage; i <= data.page.endPage; i++){
        			if (data.page.curPage == i){
        				html = html + '<a href="javascript:fn_paging('+ i + ')" class="active">' + i + '&nbsp;&nbsp;&nbsp;</a>';
        			}else{
        				html = html + '<a href="javascript:fn_paging('+ i + ')" >' + i + '&nbsp;&nbsp;&nbsp;</a>';
        			}
        			 
        		}
        		
        		if ((data.page.curPage != data.page.pageCnt) && data.page.pageCnt > 0){
        			html = html + '<a href="javascript:fn_paging('+ data.page.nextPage+')" class="pagination__arrow next"></a>&nbsp;&nbsp;&nbsp;';
        		}
        		if ((data.page.curRange != data.page.rangeCnt) && data.page.rangeCnt > 0){
        			html = html + '<a href="javascript:fn_paging('+ data.page.pageCnt + ')" class="pagination__arrow next-full"></a>&nbsp;&nbsp;&nbsp;';
        		}
        		
        		$("#pagination").html(html);
            	$("#curPage").val(data.page.curPage);
        		
        	}
        }
        
        //편지 검색
        function searchMailBox(){
        	if($("#searchTxt").val() != "") {
        		searchLetterReciList("1",$("#searchTxt").val());

        		axf.alert("검색이 완료 되었습니다.");
        	}else{
        		axf.alert("검색어를 입력하십시요.");
        		$("#serachTxt").focus();
        	}
        }
        
        //페이지 이동
        function fn_paging(curPage){
        	$("#curPage").val(curPage);
        	
        	searchLetterReciList(curPage);
        }
        
        //편지보기
        function gotoLetterView(letter_id, rnum){
        	if (bgubn == "R"){
        		$.ajax({
                    url: "/let/saveReadChk.json",
                    type: "POST",
                    data: {letter_id:letter_id},
                    dataType: "json",
                    success: function (data, textStatus, jqXHR) {
                        if (data.result == "OK") {
                    		$("#frm_move").attr("action", "/let/letterView.l");
                        	$("#letter_id").val(letter_id);
                        	$("#gubn").val(bgubn);
                        	$("#rnum").val(rnum);
                        	
                        	$("#frm_move").submit();	
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        axf.alert("code:" + jqXHR.status + "\nmessage:" + textStatus + "\nerror:" + errorThrown);
                    }
                });
        	}else{
        		$("#frm_move").attr("action", "/let/letterView.l");
            	$("#letter_id").val(letter_id);
            	$("#gubn").val(bgubn);
            	$("#rnum").val(rnum);
            	
            	$("#frm_move").submit();	
        	}
        	
        }
        
        //임시저장 편지 쓰기
        function gotoLetterWrite(letter_id, rnum){
        	$("#letter_id").val(letter_id);
        	$("#tempflg").val("Y");
        	$("#frm_move").attr("action", "/let/letterWrite.l");
        	$("#frm_move").submit();
        }
        
        //편지함 이동
        function toLetterBox(pgubn,p_searchTxt){
        	bgubn = pgubn
        	
        	//편지함 이름 변경        	
        	if (bgubn == "R"){
            	$("#boxName").html("받은편지함");	
        	}
        	
        	if (bgubn == "N"){
            	$("#boxName").html("안읽은편지함");	
        	}

        	if (bgubn == "S"){
            	$("#boxName").html("보낸편지함");	
        	}
        	
        	if (bgubn == "T"){
            	$("#boxName").html("임시보관함");	
        	}

        	//편지리스트 조회
        	 searchLetterTot();
        	
        	//편지리스트 조회
        	if(p_searchTxt != undefined && p_searchTxt != ""){
        		searchMailBox();
         	}else{
            	searchLetterReciList("1");
         	}
        }

        //편지쓰기, 편지일기에서 메인으로 넘어오는 경우
        function toLetterBox_link(pgubn,p_searchTxt){
        	//편지함 이름 변경 등        	
        	if (pgubn == "R"){
            	$("#rtabidx").addClass("active");
        	}
        	
        	if (pgubn == "N"){
            	$("#ntabidx").addClass("active");
        	}

        	if (pgubn == "S"){
            	$("#stabidx").addClass("active");
        	}
        	
        	if (pgubn == "T"){
            	$("#ttabidx").addClass("active");
        	}
        	
        	toLetterBox(pgubn,p_searchTxt);
        }
        
        //널체크
        function ckEmpty(str){
            
            if(typeof str == undefined || str == null || str == "")
                return "";
            else
                return str ;
        }
        
        //신고하기
        function doReporte(){
        	$('#declaration').css('display', 'flex');
        }
        			
 </script>
</head>

<body>
	<!-- <form name="user" method="post"> -->
	<%--     <input type="hidden" name="enc_data" value="<%= sResponseData %>"><br> --%>
	<!-- </form> -->


	<form name="frm_move" id="frm_move" method="post">
		<input type="hidden" id="gubn" name="gubn" value="" />
		<input type="hidden" id="letter_id" name="letter_id" value="" />
		<input type="hidden" id="returnflg" name="returnflg" value="" />
		<input type="hidden" id="tempflg" name="tempflg" value="" />
		<input type="hidden" id="rnum" name="rnum" value="" />
		<input type="hidden" id="curPage" name="curPage" value="<%=curPage%>" />
	</form>
		<div class="emailcontainer">
		    <div class="email__lnb">
        		<div class="top" onclick="javascript:fn_MovePage('/let/letterWrite.l');" style="cursor:pointer">편지쓰기</div>
		        <a href="javascript:toLetterBox('R');" id = "rtabidx">받은편지함 <strong><label id = "noReadTot1"></label></strong>
		        </a>
		        <a href="javascript:toLetterBox('N');" id = "ntabidx">안읽은 편지함</a>
		        <a href="javascript:toLetterBox('S');" id = "stabidx">보낸편지함</a>
		        <a href="javascript:toLetterBox('T');" id = "ttabidx">임시보관함</a>
		    </div>
		    <div class="email__content">
		        <div class="top">
		            <div>
		                <strong><label id="boxName">받은편지함</label></strong> <strong class="ml-4" id ="MainTot"></strong>
		            </div>
		            <div class="search">
		                <input type="text" id="searchTxt" name="searchTxt" value="<%=p_searchTxt %>" placeholder="메일 검색">
		                <button type="button" onclick="searchMailBox();"><img src="${pageContext.request.contextPath}/resource/assets/images/search-icon.png" alt=""></button>
		            </div>
		        </div>
		
		        <div class="emaillist">
		            <div class="emaillist__header">
		                <div class="col col1">
		                    <label for="allck" class="checkbox">
		                        <input type="checkbox" hidden id="allck">
		                        <span></span>
		                    </label>
		                </div>
		                <div class="col col2">읽음</div>
		                <div class="col col3"></div>
		                <div class="col col4">닉네임</div>
		                <div class="col col5">제목</div>
		                <div class="col col6">보낸날짜</div>
		            </div>
		            <div class="emaillist__body" id ="emaillist__body">
		            </div>
		            <div class="pagination" id = "pagination">
					    <a href="" class="pagination__arrow prev-full"></a>
					    <a href="" class="pagination__arrow prev"></a>
					    <div class="pagination__number">
					        <a href="" class="active">1</a>
					        <a href="">2</a>
					        <a href="">3</a>
					        <a href="">4</a>
					        <a href="">5</a>
					    </div>
					    <a href="" class="pagination__arrow next"></a>
					    <a href="" class="pagination__arrow next-full"></a>
					</div>
					
		        </div>
		    </div>
		</div>
		
<script >
toLetterBox_link("<%=gubn%>", "<%=p_searchTxt%>");
</script>
</body>