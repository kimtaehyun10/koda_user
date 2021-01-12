<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java" import="Kisinfo.Check.IPINClient"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<%
	String gubn = request.getParameter("gubn")==null ? "" : (String)request.getParameter("gubn");
	String letter_id = request.getParameter("letter_id")==null ? "" : (String)request.getParameter("letter_id");
	String rnum = request.getParameter("letter_id")==null ? "" : (String)request.getParameter("rnum");
	String curPage = request.getParameter("letter_id")==null ? "1" : (String)request.getParameter("curPage");
%>

<head>
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
            
          	//편지함 이름 변경 등        	
        	if (bgubn == "R"){
            	$("#boxName").html("받은편지함");	
            	$("#sendReciTitle").html("보낸사람");
            	$("#rtabidx").addClass("active");
        	}
        	
        	if (bgubn == "N"){
            	$("#boxName").html("안읽은편지함");
            	$("#sendReciTitle").html("보낸사람");
            	$("#ntabidx").addClass("active");
        	}

        	if (bgubn == "S"){
            	$("#boxName").html("보낸편지함");	
            	$("#sendReciTitle").html("받는사람");
            	$("#stabidx").addClass("active");
        	}
        	
        	if (bgubn == "T"){
            	$("#boxName").html("임시보관함");	
            	$("#sendReciTitle").html("받는사람");
            	$("#ttabidx").addClass("active");
        	}
        	

        	var formData = new FormData();
        	formData.append("gubn", "<%=gubn%>"); 
        	formData.append("letter_id", "<%=letter_id%>"); 
        	formData.append("rnum", "<%=rnum%>");
            
            //편지조회	
            $.ajax({
                url: "/let/searchLetterView.json",
                type: "POST",
                data: formData,
                processData: false,
                contentType: false,
                dataType: "json",
                success: function (data, textStatus, jqXHR) {

                   $("#title").html(data.title);
                   $("#sendReciName").html(data.sendreciname);
                   $("#senderDate").html(data.senderDate);

            	   var htmlsum = "";
            	   
                   if (data.filelist.length > 0){
                	   htmlsum = ' <div class="files" id="filelist">';     
                	   for (var i = 0 ; i < data.filelist.length ; i ++ ){
                		   var html = '';
                		   html = html + ' <a href="#" onclick="window.open(encodeURI(\'<c:url value='/let/downFile.l?'/>f_letter_id=<%=letter_id%>&f_letter_file_seq='+data.filelist[i].letterFileSeq+ '&f_gubn=<%=gubn%>\'))" class="file">';
                		   html = html + ' 첨부파일 <strong>' + data.filelist[i].letterFileOrgNm + '</strong>';
                		   html = html + ' </a>';
                		   
                		   htmlsum = htmlsum + html; 
                	   }
                	   
                	   htmlsum = htmlsum + " </div>";
                   }

                   htmlsum = htmlsum + ' <div class="edit">' + data.content + '</div> ';
            	   
                   $("#emaildetail__body").html(htmlsum);
                   
                   if (data.palist.length > 0){
	                   //이전글 다음글 생성
	                   htmlsum = "";
					   
	                   if (data.palist[0].preLetterId != undefined && data.palist[0].preLetterId != ""){
	                	   htmlsum = htmlsum + ' <div class="row"> '
		                   htmlsum = htmlsum + '     <div class="col col1" style="font-size: 10px;">▲</div> '
		                   htmlsum = htmlsum + '     <div class="col col2"> '
		                   if (data.palist[0].preReceiveYn == 'F'){		                	   
			                   htmlsum = htmlsum + '         <img src="${pageContext.request.contextPath}/resource/assets/images/not-readed.png" alt="" class="inline"> '
		                   }else{
		                	   htmlsum = htmlsum + '         <img src="${pageContext.request.contextPath}/resource/assets/images/readed.png" alt="" class="inline"> '
		                   }
		                   htmlsum = htmlsum + '     </div> '
		                   htmlsum = htmlsum + '     <div class="col col3"> '
	                       if (data.palist[0].preFileCnt != '0'){
			                   htmlsum = htmlsum + '         <img src="${pageContext.request.contextPath}/resource/assets/images/have-item.png" alt="" class="inline"> '
	                       }
		                   htmlsum = htmlsum + '     </div> '		                	   
		                   htmlsum = htmlsum + '     <div class="col col4 text-center">' + data.palist[0].preReseName + '</div> '
		                   htmlsum = htmlsum + '     <div class="col col5"> '
		                   htmlsum = htmlsum + '         <a href="javascript:gotoLetterView(' + data.palist[0].preLetterId + ','+data.palist[0].preRnum +');">' + data.palist[0].preTitle + '</a> '
		                   htmlsum = htmlsum + '     </div> '
		                   htmlsum = htmlsum + '     <div class="col col6 text-center">' + data.palist[0].preSenderDate + '</div> '
		                   htmlsum = htmlsum + ' </div> ' 
	                   }
	                   
	                   if (data.palist[0].aftLetterId != undefined && data.palist[0].aftLetterId != ""){
	                   
		                   htmlsum = htmlsum + ' <div class="row"> '
		                   htmlsum = htmlsum + '     <div class="col col1" style="font-size: 10px;">▼</div> '
		                   htmlsum = htmlsum + '     <div class="col col2"> '
		                   if (data.palist[0].aftReceiveYn == 'F'){		                	   
			                   htmlsum = htmlsum + '         <img src="${pageContext.request.contextPath}/resource/assets/images/not-readed.png" alt="" class="inline"> '
		                   }else{
		                	   htmlsum = htmlsum + '         <img src="${pageContext.request.contextPath}/resource/assets/images/readed.png" alt="" class="inline"> '
		                   }
		                   htmlsum = htmlsum + '     </div> '
		                   htmlsum = htmlsum + '     <div class="col col3"> '
	                       if (data.palist[0].aftFileCnt != '0'){
			                   htmlsum = htmlsum + '         <img src="${pageContext.request.contextPath}/resource/assets/images/have-item.png" alt="" class="inline"> '
	                       }
		                   htmlsum = htmlsum + '     </div> '
		                   htmlsum = htmlsum + '     <div class="col col4 text-center">' + data.palist[0].aftReseName + '</div> '
		                   htmlsum = htmlsum + '     <div class="col col5"> '
		                   htmlsum = htmlsum + '         <a href="javascript:gotoLetterView(' + data.palist[0].aftLetterId + ','+data.palist[0].aftRnum +');">' + data.palist[0].aftTitle + '</a> '
		                   htmlsum = htmlsum + '     </div> '
		                   htmlsum = htmlsum + '     <div class="col col6 text-center">' + data.palist[0].aftSenderDate + '</div> '
		                   htmlsum = htmlsum + ' </div> '
	                   }
	                   
                   		$("#palist").html(htmlsum);
                   }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    axf.alert("code:" + jqXHR.status + "\nmessage:" + textStatus + "\nerror:" + errorThrown);
                }
            });

            searchLetterTot();
        });
        
		//이전 다음 편지보기
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
        
        function fileDown(letter_file_seq){
        	$("#f_letter_id").val($("#letter_id").val());
            $("#f_letter_file_seq").val(letter_file_seq);

        	$("#frm_file_down").attr("action", "/let/downFile.l");
        	
        	var newWin = window.open("","fileDownNewWin");
        	
        	$("#frm_file_down").attr("target", "fileDownNewWin");
        	
        	$("#frm_file_down").submit();
        	
        }
        
        //편지함별 총계 조회		
        //"R" : 받은 편지함
        //"N" : 안읽은 편지함
        //"S" : 보낸편지함
        //"T" : 임시보관함
        function searchLetterTot(gubn) {     
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
        
        //편지함 이동
        function toLetterBox(gubn,searchflg){
        	if(searchflg != undefined && searchflg != "" && searchflg == "T"){
        		if ($("#searchTxt").val()==""){
        			axf.alert("검색어를 입력하십시요.");
        			return;
        		}else{
        			$("#p_searchTxt").val($("#searchTxt").val());
        		}
        	}
        	$("#gubn").val(gubn);
        	$("#frm_move").attr("action", "/let/letterMain.l");
        	$("#frm_move").submit();
        }
        
        //널체크
        function ckEmpty(str){
           
            if(typeof str == undefined || str == null || str == "")
                return "";
            else
                return str ;
        }
        
        //답장하기
        function letterReturn(){
        	$("#returnflg").val("Y");
        	$("#frm_move").attr("action", "/let/letterWrite.l");
        	$("#frm_move").submit();
        	
        }
        
 </script>
</head>

<body>
	<!-- <form name="user" method="post"> -->
	<%--     <input type="hidden" name="enc_data" value="<%= sResponseData %>"><br> --%>
	<!-- </form> -->


	<form name="frm_move" id="frm_move" method="post">
		<input type="hidden" id="gubn" name="gubn" value="<%=gubn%>" />
		<input type="hidden" id="returnflg" name="returnflg" value="" />
		<input type="hidden" id="letter_id" name="letter_id" value="<%=letter_id%>" />
		<input type="hidden" id="curPage" name="curPage" value="<%=curPage%>" />
		<input type="hidden" id="p_searchTxt" name="p_searchTxt" value="" />
		<input type="hidden" id="rnum" name="rnum" value="" />
	</form>
	<form name="frm" id="frm" enctype="multipart/form-data">
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
                    <strong><label id="boxName">받은편지함/보낸편지함/안읽은편지함/임시저장함</label><strong class="ml-4" id ="MainTot"></strong>
                </div>
                <div class="search">
		                <input type="text" id="searchTxt" name="searchTxt" placeholder="메일 검색">
		                <button type="button" onclick="javascript:toLetterBox('R','T');"><img src="${pageContext.request.contextPath}/resource/assets/images/search-icon.png" alt=""></button>
		        </div>
            </div>

            <div class="emaildetail">
                <div class="emaildetail__header">
                    <h2 id ="title"></h2>
                    <div class="info">
                        <span class="tit" id="sendReciTitle">받는사람/보낸사람</span> <label id="sendReciName"></label><span class="info__date" id="senderDate">20-10-20 13:12</span>
                    </div>
					<% if (gubn.equals("R") || gubn.equals("N")) {%>
                    <a href="javascript:letterReturn();" >답장하기</a>
                    <% } %>
                </div>
                <div class="emaildetail__body" id = "emaildetail__body">
                </div>
                <div class="emaildetail__footer">
                    <div class="emaillist">
                        <div class="emaillist__body" id ="palist" >
                        </div>
                    </div>
                </div>
            </div>
        </div>
		</div>
		
	</form>
</body>